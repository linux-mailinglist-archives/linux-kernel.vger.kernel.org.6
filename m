Return-Path: <linux-kernel+bounces-180203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193418C6B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D31C23EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB1156653;
	Wed, 15 May 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DV/jI6en"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3B433BC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793793; cv=none; b=EdPIlDAN2lWBsIZtVlV/76E8/FKV5Lih/B3m98/zsMvqiEWDgqsbWKArrFmEvpaQ0Ei1sj5eZBY/eIfA7hLfZCdhipBYJ9hgba90sFTQqrZJBbH+nmYKSsJBU/WFOKayFnnrtrTaRVe7VQrnr5WKDUw4fi97qF9tRbq9ARJa8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793793; c=relaxed/simple;
	bh=3Hey8yGfFDeNGoMd+KV/s1c9VtxcoIDls3Ojr/oIhm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aYw+20mJRVb2rgwZjF5AbfPiQJcwymtDVP2tEp8VAqfe8iMynw9zjpLUrvtdTAMi5n9t3anA3ieSaNuuHHAEt12whow4a7fFii9kOWw66eZvzbG2L3ScK+rn7UVL2xRTkdOPuQJFmYnC8+0g/t5lyaxZeiRLCLnhpIlzCxnXXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DV/jI6en; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-420151eb455so16431255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793788; x=1716398588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RvZSZw4jxBqtRsNUm11hD2fyY6WsB4is9eFDyT77bE=;
        b=DV/jI6enesRbsGJhuV4zAzDQ7mm+gAXZQDSf8YVuMRGjxCgj4wDN/DhRiW+h8y64+K
         zT1dZzF+oXkESnFRb4EItOjToYecXuQUAXymaKX/sv6VAHmQMea1m7VIcIfZOCeedYnc
         FrRw4GdnNAl9zAjp/+mJ4JlWsa/akRK0LjzDK9ZlKkp5rSkQYWAszzSTcqevHMNC36zk
         QbXbictKkLgDkl/ZG6njEbnH23a7E3LPWjzA5k0/taAHg/4kGZ8veLeTYoR/5gelWPy2
         hjoK7VN+NPHwBCgsOqBa6XO8VhYGwSd+u41F/KbrDzEfOOxTddY18FQkhTaYWH5hGb8q
         KRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793788; x=1716398588;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RvZSZw4jxBqtRsNUm11hD2fyY6WsB4is9eFDyT77bE=;
        b=GwN7uhol6n7TrWuuDfWKotjm8j6I0e1zBn2detoienc7T45M+JDZQyDR87hx7wi6Sh
         vckLh+GL3Y0eSv8rU4Dtb9vMwZxmfSfHN7WLtK/6N3CxR139hx87Sm8kIppMB56XvwGt
         YBNzpiA2n1b53/CzMI0XXL5+8etY23jBfFq0TB0axtm5a/8Jln53MQQlYAKZMM0Rjikf
         HyAaTx1owyZY/RE/GomIu9t3949+4HqR14y/yaB5Ws8aF2GR5gPhCWlJWjDhqk/7+kC6
         JDJds+rwpg5cDC9I3Yn2lgka7XOGzqITiW3wei0b4cbL33qMzwZ43B/J24CwvaUKDpPd
         Z6PA==
X-Forwarded-Encrypted: i=1; AJvYcCXijOJm6EVjN10R20T/V6E95sx3aQ9DtZ+56m9peYl9hzLk/5WklE2Jb2GKctPULfMw/9bd7GtRcn1mSyCW+2htXsTsfvW6IsZBM9LJ
X-Gm-Message-State: AOJu0YyBpL1fn73j1Dk9FLWiTONwPECVSrd14Ys7/4W74qtKCdNLk1Fj
	/yO+fBqjwXUzjKe8Ho3ehIs9abYtAvyg0aSbTsRULN3owo73up/GdJ1b6QCpO7kFiVVFa1yx80n
	6aeKjJfn/pTqiCp0qzSjXiVWi1Q==
X-Google-Smtp-Source: AGHT+IHARczV2e6GphBvu/GRT1dSaZeTKSmihgV/GKa3xOn2mh1vlMNsjz+sFoMVlqfAVVR0jb3CJk0/60m2L6gideM=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3b86:b0:41f:9ffd:fd33 with
 SMTP id 5b1f17b1804b1-41fea52ef1fmr737175e9.0.1715793787741; Wed, 15 May 2024
 10:23:07 -0700 (PDT)
Date: Wed, 15 May 2024 17:22:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515172258.1680881-1-sebastianene@google.com>
Subject: [PATCH v2 0/4] KVM: arm64: pKVM host proxy FF-A fixes
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
  KVM: arm64: Fix the identification range for the FF-A smcs
  KVM: arm64: Use FF-A 1.1 with pKVM

 arch/arm64/kvm/hyp/include/nvhe/ffa.h |   2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c         | 183 +++++++++++++++++++++-----
 include/linux/arm_ffa.h               |   3 +
 3 files changed, 154 insertions(+), 34 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


