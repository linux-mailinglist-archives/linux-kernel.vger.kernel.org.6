Return-Path: <linux-kernel+bounces-213286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC4907375
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EC9281569
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DD143C62;
	Thu, 13 Jun 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vx4ewY08"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5AA94D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284854; cv=none; b=u4/TPhuyE2tPBvr6Uj55i4hSlTNhRnD45sfvcnmaSb0ycpLjCWXir79zETAuvq4r/UmnHS+Q5JGy/b2eYWB7F/ZCgTr3281EoyFkLZdvyf7g8MFFTeNvk6Ys7nL8xaQyE/0RAoLm7aji1VPg4+fJSJdJULJl/LNMFJMiEWVKxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284854; c=relaxed/simple;
	bh=VcBbGGJep2ekDxbDczjcUBXrzrySClZ2EvXx5e9Xf/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DCncMNqBUjUuAeM3ImRePWdqNhZAnZtFtimXO2Hmwkpi2qrikabGBQhisZ2gUHXEwlu07l8wE6OadiE+OvetTWfUmMM4ayD7Y43VsZ74TGITrRfhy4jye4qApY/GEcz2LNMFiRF46zGFYKJrvY5ZOFTsJsgqezS8rgP1LwPw8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vx4ewY08; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-631d53af5e1so2332477b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718284852; x=1718889652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=djDLCCB5OOx1VLqb+6JoETNcLYcEqA80QwW7FOqmwqw=;
        b=Vx4ewY08fnSQgO5PbGRQnsfNPTZammyDBLpxiRASixBFw/nHJwqKSXsuu6goD4YJbe
         UkkeWSxcPN0HJJo9pR2qiVrIkNu0+tlf8HFX1N8qEbynqNocKulCcrCTdG+8uyvTha07
         CPwEoE1rGfN3tuazjSLLpZA5IYUYOm/0loIdmvuvMtkuHNfAUVmmZLAjxAq187J6v2IN
         eDSpZXGs/bgfGwvpaqXYbFta5FaOzq2azD5Zk92xnb+guBLw+t6b+k7fGWx+HGAtG6sT
         /m/RpHYiOewdz4Gf33JMssM7R6l9d5xhT2SkyaqX1/QTs8BqOOlzFtJOYTFlUmuppCRI
         cwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284852; x=1718889652;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djDLCCB5OOx1VLqb+6JoETNcLYcEqA80QwW7FOqmwqw=;
        b=Erq5aLpQCV/yOmKTSQ5tHyAasY2T9F+N2/rPeOgkkXDS4kQmfca3gtGi2yn9TpafdV
         A7CAAuyhmprz7aeiuNYxnfwNshtLYbSo0JNbQM95BPQI/5IRQEBzyBXWBSA5SMXnxSG4
         XY/bhUGcsSdbeYR9dc+DPYqT/i6VhXW2O4Lz4k+8TZqsHO2nQHi5HChHaswCWKNTjod1
         RrN+i8LzXseAN/fWVyhe1zh6MYOsiUwDmEkxL8S0tB3PFpXJF0q2mys/2IdffXC3kx0S
         LjbNYGzjgLsyVQ2z5L+XjkYgFoCz/K+cajTtypLMYiADIJZJ5+hO7c9YUB9qZSRT1a5R
         z2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBbik7ym3X6pODTk1yn9zWNAqf0n1wsT1YfF6tUuBb72E1IHe9EzsFvE3RjmhTN8tM2jfXKPRtprzw3Oeb8AStyRKVf7uLsZvJ8iTK
X-Gm-Message-State: AOJu0YzQJO7aPmzfUR+A0+arpHPTDM0Jp8kTeaLQJNoEGZHsexQa5XgD
	CwVelDp1X8s8Mi2kPEYT1ZRUiyV+Q2y5oeFFPwAvdXMpO3xYZT5SvcR9LMVmn4Bn8Orhf7fB8tx
	CUK9gtvewVPlcXMkkrqDcc8TQMA==
X-Google-Smtp-Source: AGHT+IFhIfr1FObnJYpja+B/zdb5Gn8y7cv54mQ+gaACvWPNtu2WXPb1DewkVyJUN9Ld/Vx8SGXfTP7sVxw4QmbJ3nc=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2b01:b0:dfd:b66c:9565 with
 SMTP id 3f1490d57ef6-dfe66461ae1mr1390128276.6.1718284852106; Thu, 13 Jun
 2024 06:20:52 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:20:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613132035.1070360-1-sebastianene@google.com>
Subject: [PATCH v3 0/4] KVM: arm64: pKVM host proxy FF-A fixes
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com, 
	lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,


This series contains some small fixes for the host pKVM proxy code. I included
some of the patches that I already sent on the list as part of this series
to make it easier to keep track of them.

I verified the functionality with OPTEE as a TEE-OS.

Changelog:

v2 -> v3:

* small fixes on the commit messages
* applied the Review-by tags from Sudeep. Thank you Sudeep !
 
v1 -> v2:

* applied the feedback received from Will on the FFA_VERSION patch:
  The spec requires that no other calls to be issued prior to the FFA
  version negotiation and the current change reflects this. After the
  version negotiation phase is complete with Trustzone we will just
  return the hypervisor version.

* corrected some mistakes on the FFA_PARTITION_INFO_GET patch:
  - don't trim the number of bytes copied from the hypervisor buffer
  - introduce FFA_1_0_PARTITON_INFO_SZ definition
  - simplify the logic when the input flag is specified 

* collected the Ack from Will and embbeded it in the commit - Thanks Will ! 


v2:
https://lore.kernel.org/all/20240515172258.1680881-1-sebastianene@google.com/

v1:

* previously posted FFA_PARTITION_INFO_GET patch here:
https://lore.kernel.org/kvmarm/20240411133249.2134696-1-sebastianene@google.com/
 -> minor changes from the previous version, look for the current
    ffa_version in the host_buffer structure

* previously posted "Fix the identification range for the FF-A smcs" here:
https://lore.kernel.org/kvmarm/20240322124303.309423-1-sebastianene@google.com/

Thank you,
Sebastian

Sebastian Ene (4):
  KVM: arm64: Trap FFA_VERSION host call in pKVM
  KVM: arm64: Add support for FFA_PARTITION_INFO_GET
  KVM: arm64: Update the identification range for the FF-A smcs
  KVM: arm64: Use FF-A 1.1 with pKVM

 arch/arm64/kvm/hyp/include/nvhe/ffa.h |   2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c         | 180 +++++++++++++++++++++-----
 include/linux/arm_ffa.h               |   3 +
 3 files changed, 152 insertions(+), 33 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


