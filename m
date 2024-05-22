Return-Path: <linux-kernel+bounces-185658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BADA8CB881
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7C31F21802
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61001BDD0;
	Wed, 22 May 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Emplf75H"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4F1946F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341812; cv=none; b=E4HCQ3+7I8qoh5qtGCovUGgYOmgbvN4L7f4WV5U94E8KTbOOQXXfkwa+UHeeJzxsmFmWbZzbxCsGJjlVk47DHG/tWNXaVDXVi6+OS4EUMunCSyBc0eAL/waukcRCJhEYZeoPoM24f4nqXAenwwgne459spdM4K4Xdky4RjVKCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341812; c=relaxed/simple;
	bh=uOp1wN2DfhSBAyIiZVfxcpEE4nMrRqzLGODorRKlTxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G/otVcomTOEmLOctqiy941woOgwmwzruvjZuO5MLQYHtp1OeOlgdjUOcg1IpHoWr6lKWKa2r/3UHErA9bqireFnBYGgzXcU9uCpuJypU0JeJtidMXriD1iGPcJSQQoyaac0j8+Mjh5Nm7UPnR1U/WIN22HhnD41Bpl5Qswy/Wm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Emplf75H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ee089eedb7so13985574b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716341810; x=1716946610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5S3zXzDNy7OaqRCsEecoffZHoJSYB0z+yL5rqDfD/8=;
        b=Emplf75HVOoTBKGz1WFCvLiYJ3vc9U0HDKIMxfvjyH/3Zcg3xdLIE3L3hAhjQfhzDt
         NfzXEqGUOWUz9fd7VfgCWxYCpN/LrGyRtJH8cMRyIWn4m2D/lZfWXPDVVwa4Ji1ADWYT
         B1Z7yBwbI8nWCYftgEh+nPUBwxanzRWC5ZQNYwCXdACor6jAQVQkeeLrXD3WVLgTJmv+
         9fsgVnzVd3FNP0R0QAWARJzdKohfe2roTpMa4qlfQsujhA/T9FeZ8KQfZJi6+bpxSCoq
         FUIujhrE2p0M7g4JKuRA97eK/Ad0fi1x3ub0qvgaUks4idEvxBiHZo7EMUhuHhrHe6m8
         8y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716341810; x=1716946610;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5S3zXzDNy7OaqRCsEecoffZHoJSYB0z+yL5rqDfD/8=;
        b=Wy4tgtNyuizm8uQE1rDEjhM5KrCNk4B01im6b8C0YQxNjxPdgKN8Eg4ymXeKg25j21
         4oILi+C5ive7lNOwBnr9fLg8sXSzQkSOyeujWLw3jJvD9sdsx6g8fx6Oc170ZqEShT8c
         pRmEJakGdXOayIZuhYpsM9aDvQ7wWLzxaib6h0CHK5Dt66MH9vtNpO8g8CREFqMWuO1I
         dWKS0lTcosLpFDbbzCB7ZRCxVdea+oiwXYU76Z5Eh9m/1Lyh0aweuSFaaggkms7JhcJX
         4HieJ+q4QJmLDsrkhZoHimKL7dSzkMHMDSTpQ/ren58H7Wq4yLiAd9QG9NV70KO1W7HV
         1bvg==
X-Forwarded-Encrypted: i=1; AJvYcCXk0DZp35ngnilUg6RjuOZj61dyBmSAPkFvi9R6GbNNhX55XNGhSqAF0EDVOhM+Ga9CHYLsn4HovvortJ7XC6hzGCSqK539oU7WDfLe
X-Gm-Message-State: AOJu0YzG1qZpL2c5VH65PcweNAnGFV7pZL0t9t+4bPynib2MBu3Fx9DZ
	V5Y+nD1LylHpw9v8vpDv3vZ5nNn8Ax/jlfU1kt34BlMW6O1Z56UN6wuxPkIpyQgs+Bp8IoDWFD6
	0XQ==
X-Google-Smtp-Source: AGHT+IHSwJQAi1yjFTuHmA1rC8UBSwdnDUj06ie59IvdpRhZGk46IaXZJ7WlmuD8kWJc3+ceeAiUtVHuyF4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2e8f:b0:6f3:f447:57e1 with SMTP id
 d2e1a72fcca58-6f6d6002b65mr9428b3a.1.1716341810176; Tue, 21 May 2024 18:36:50
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 18:36:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522013647.1671968-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.05.22 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for tomorrow, as I will be offline (tomorrow until Tuesday,
in case anyone cares).  Though if y'all want to meet without me, definitely
feel free to do so.

Future Schedule:
May  29th - No Topic
June  5th - No Topic
June 12th - PV Scheduling

