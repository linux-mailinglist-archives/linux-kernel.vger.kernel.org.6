Return-Path: <linux-kernel+bounces-210764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897C90486D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A3C284B64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575963B9;
	Wed, 12 Jun 2024 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9kqe8ah"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D764A12
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155885; cv=none; b=gYwF/2wJFIUM6ZYClEymAI1i31p5Faqs7UX/OE4M1bKutMk+8d1n9JTCMBhJh0aOv3ZRhfvzsIBwgSFBI6mKCUunkvfmgmDQuLLMf7XiNca4Gyhy1E2RcmThPis25j4D4KK9YzrbsJEECHdyUwwMmki3oU182DrRo5YqXFbvLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155885; c=relaxed/simple;
	bh=iTJ+y+yUYurbot1d/zZMuCMgrR5OjCYsg4h2tP6dM08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jauPOUNsosKuSariajOMP1puWjDs7FIxuj4vvEs/YL50WmOpb5BIZ+LiYW/6PXStQBU/QvgDe3eLrVHS6a63IVtjhVojSixlSKeDFpjo5vdSqoGkDq9soi1QgKN6zeOFQacHeKFdxfosp2IrXRjxRU+n1no10ImWjoyEaAXBOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9kqe8ah; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb36d7f5fso4435237b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155883; x=1718760683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar9pYcOp2XX0p6wb+X/64p4KFgEtV0/Aspp8aMtT5ao=;
        b=q9kqe8ah6UWiHYnkSQl43YPWAjNb56rY3jGsF1TK78XiH6Mz1rUoalSeKH7lZmHIeu
         5PVZd+5mUi21bK+cZSHsoBctEaZQhKEdy8uhK0J4KOjSta8LVraZwf5MLdA9SFt89YSK
         elVgXaAZuYWpZ1MsbetEqxQBmiri2l+F83LGWQjf64IGPVHRryrLVNfgxaS7h3XRcRZJ
         +jnB9KP/F7JmCuUhjxbZyWfc9Z69q0ovTVEScusBxxBJhcrJIpzT8FwA+dW86dMFFse2
         0JLIOmH5vKNltIQSNZG098HC4FF7MesUZu6ets77Ar3I+6EFs6TDUHP7H7DC6hpv0Vcb
         ItQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155883; x=1718760683;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ar9pYcOp2XX0p6wb+X/64p4KFgEtV0/Aspp8aMtT5ao=;
        b=POdR9rHd4i+cf5r0tvbX0x4LTbwW/FXz2VITtcElIZqXD9VbtRHKRQCwoxhAVz0NKm
         CCucNsMzql1fXf0FcvGNOiwDgVymtk0YniwO6o8NToFnbj4NMseB4lT8xgwNmPr9gPMH
         uR4Fif3qS8lpS0K0cxwdROhI8CApcRb4ox0iWm5zscQDVlUZSF7DXoRJxd7odAZbNU8+
         w23VZh8YC+2WMeioGIM1PMogTCK+zY04W038NprHfMFBE6gy+fOU/A3yv3umwkyR+3eO
         TbsVdzLr8Y2YJogP9e2xcg+UUKlLIcyXP8L4zNCdgJKUmIowCgDHAY51z/paxpFFsatF
         z7qA==
X-Forwarded-Encrypted: i=1; AJvYcCUkikSZSKPk+AGAS2BV3G5uzm7OPmEur/RyF4QwtgqdXv6TbWfVWP9N4egwS/3WvIno8Pj4E8aTQ54nHxJqVB5jAjaMZ84V3iinD9Rb
X-Gm-Message-State: AOJu0YzcZ2uBibnwLFqWVHa5DPSLIH0KWIdgovrKRt6U8rnN4llvOKV8
	wZnVzBCCZdB1ePFcIMxW/OCckuQ7PHm2QLx8lHs1e+qRCrTEDmeMtO4YBudIOdz1I4QMtZw1AIj
	L9A==
X-Google-Smtp-Source: AGHT+IHjsmkw6gcJpOYLaVOJnx0DSozjS1LUCiStBXBbuhGBJOoAQwoomO7H5cEoCaK9cwKJGkA7Y6cmS2s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:f:b0:627:96bd:b1e with SMTP id
 00721157ae682-62fbaa3d8d7mr1514547b3.10.1718155883247; Tue, 11 Jun 2024
 18:31:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 11 Jun 2024 18:31:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612013119.426771-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.06.12 - Paravirt Scheduling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

Tomorrow's topic is PV scheduling.  My apologies for the late reminder, I don't
have a good excuse other than its become tradition to procrastinate on sending
the agenda.

https://lore.kernel.org/all/20240403140116.3002809-1-vineeth@bitbyteword.org

Advanced warning #2, no PUCK on June 19th or July 3rd (US holidays).

Future Schedule:
June 19th - CANCELED
June 26th - No Topic
July  3rd - CANCELED

