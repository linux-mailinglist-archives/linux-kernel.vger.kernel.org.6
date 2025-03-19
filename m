Return-Path: <linux-kernel+bounces-567116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C2A68169
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C55E3BB668
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9317C77;
	Wed, 19 Mar 2025 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzZO0mgy"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74519134BD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343819; cv=none; b=nlW79SwUjrviP0y6TBwra0nAwWVPVa+AZorWPA/f+BkKq2RHQ6xQEw5gxFIOOXWzPLxuGRt2dzZWUj7zQSJwXmfw1AR9PJbCf9+JliKiM09JJZW3TPGrr86bFGHZkduUSHplBLhVK9vHBQoLm7y3cr2W6N/hA0H8FB065T+tutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343819; c=relaxed/simple;
	bh=flkW0Kc/AwuDNglpOY44+O02/ydTyPgQ4DGL1E0SA6Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bNVn8IgpdWmIToVs8CfaJ/2vLw0W8SheWefdOCZK5GTHEc5mzkJlx65dW/vfbulogWlxALKBEm4vssoXAgMZF5niRqo/C+KcPI6h2Tvg5r6zhYYTCfjRq3Djrm56BaO3SI7jhlt14vIaBS7kxdWWCeSUYwH9T/rCI/Sg7NmlllE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzZO0mgy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso10417687a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742343818; x=1742948618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flkW0Kc/AwuDNglpOY44+O02/ydTyPgQ4DGL1E0SA6Y=;
        b=bzZO0mgyr0W/U0O2BqW0G2aLp76P1YG84LFq4++IgrJV+i+D/GxSt2RmW3C+q+Ms09
         N2EMXTkDaeNfYLBdfLNYIJ0JFTAhiW7rHX4taluedHC6uYmjPZ9cjEwAS0LkSbW5CnZm
         wBiZRUjImyP5prJ7fIwN2SGuxqeGZOsP4vXT+TD7xjyX7zqi+9hVoIC7+DubPuYbk5mn
         wYwkDPyz5hWKyjkD/PyqOrn9xBwKQNjJkGpcd/0Et0+DXj3bfZG/8pRBMIWxiq6j68I7
         ykVRXFf2cWbq0utu5mqZTjpgymT2fxxh5soOaNfg/QU79j/musHRsLJ+AG9rYmKRSbGT
         nsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343818; x=1742948618;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flkW0Kc/AwuDNglpOY44+O02/ydTyPgQ4DGL1E0SA6Y=;
        b=AJc2HBphVrqc+ng6Ys/JF6wQqSl6JliXJl3AKdElG9g5Y1diPUkEE6QasnmoGqciiR
         DsqYJD7wTTJdL2LoThA3sWHaqv8y5K2nhjSOpFN5VWntxnTwWqU6zlKbxO83+M2vW4f4
         zY7KyN8rVC5j6gvsseM58n0z7GJXFQ5V5lthSylid2j2wLKIw1A1dogAZHpcLOiO+StQ
         hNhd3+qQwgsX+NS+eCowdHUlB2OrhrYeu8Zr9xdVQ4PSpCN5rCmO77sTLoY2MnWESqkF
         F0XPyI/usia2/nY/itqgJrlzB6DrrloVe5xQeKxb+6ruWWw1M3ECz3YhjRN3bUjc/vxC
         qC/g==
X-Forwarded-Encrypted: i=1; AJvYcCXJTF9oR8JW5XhsAzo6dPnOREF8DnYrC1Z8nzvE85Y3CyZ74BYEJqfH99t1ytkon0QBv84g42ZSgX0TqTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18FBuXBBv43RT1A3bVLANm5WLir01VZ24F2gbyB5KZXVP9sZh
	TA1mE/vAT8+Kaxj060jFD0Pb/A9cpKEs1cPlg45O/jjv730FpI3niRasa681jGzbaQP5a8aY31I
	zow==
X-Google-Smtp-Source: AGHT+IEwq6+Cr31AxEejBtorkWS2Jfklz9XCQbgHslIQ/czU5GSKu5DpnY0HEqY0QvbxvAqrmkiRcenvqTg=
X-Received: from pjbpq2.prod.google.com ([2002:a17:90b:3d82:b0:2fb:fac8:f45b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ca8e:b0:2ff:52b8:2767
 with SMTP id 98e67ed59e1d1-301bdf7155emr831662a91.19.1742343817797; Tue, 18
 Mar 2025 17:23:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Mar 2025 17:23:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319002334.423463-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.03.19 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled this week due to lack of topics/interest, DST differences, and
far too many meetings on my calendar.

PUCK is canceled for next week as well (03.26) for similar reasons, in case I
forget to send a notice next week.

