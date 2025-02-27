Return-Path: <linux-kernel+bounces-537060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD90A487AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FAC1884082
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B191EFF95;
	Thu, 27 Feb 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE0Hl1ch"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD953C1F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680277; cv=none; b=hPMglWbrtkBD84RLNKESKMm6p0Adaf2SgKEd1YWm2rpqtwXa7erxUu8YKxwrJp20Y0MOfxz8cdlNG5MhdaXV43qLc1nYA7s/h8w9HFuFT6DKR+ro/q8kFAtnmetILUWlROOdB+GD1xD1nZ+a6Poudgmr7nncAWJBb6hJKa19j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680277; c=relaxed/simple;
	bh=OOQnd0cgPVqA4hicU0YVfjL7ytbVCqNXzH9fXVa8jDA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D/DPQjeLuPXoEz5kmM4gBj9jeH///S6I6bTd07p6qBS+Vs6TWwheQKFeD5k7CdSQaJ9G9vp9uU1tfThXClKcl8muHKGrIdEcxslfZX5e2ZaZTs+bHKry5sVQIbjXDWftoYEaBAI08fWJVw+p1j2yYjGoytXJODbg+GFVa4sgYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE0Hl1ch; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390e27150dbso1039661f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740680274; x=1741285074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WML+/ObPWkSPRoaiWIHFm8yG2IrgtdFB4ZBzBau4x8I=;
        b=qE0Hl1chaY/Dd2cp8Z5h3JdO1Tlcd/N3OkzqqvRG+kWCGayqvy/KnunC9nU2u4OppX
         OjsPkYW7adibwvoRa8M76FMoxlWs1zUYY3ai9yErGu98gsjUIlmsiRw0nS4ir3KKJLTs
         8PYWoVZjeuL2r824mH+0c1NWirXqXAm4UvzFfd3BUEEthzLlrjF+2Q2HNX3XXE8Udwz3
         ffV84sQiU2DX1JViYi+iOiJQHq2cJGW9DJIUCdG46gl77ON0re4mfvlaSlslBKgfRXoi
         ajr+8TayzZugWUXTBgP0rLDb8BHchhG30ypmxdPl16QCGsHwUY8M1zpU57m932g5pRTE
         QrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680274; x=1741285074;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WML+/ObPWkSPRoaiWIHFm8yG2IrgtdFB4ZBzBau4x8I=;
        b=NThNjeHFA3IZSIsojI8r6BlaxeBe0uEkWr5Zh+C9YznY4thX7G9Ge+do+SbbHD0WdF
         c4uoKuvjFFegQKq6gh7zpSEkScSw8ALb8iL5jorVDjws20wTFG6biKxYp5mjgqbyndoW
         d+eLoCvZjp3Hux4KdyG4he/RJOvfdIDzF4zO6mXB6/B0CD5T7EI2taSPqTCbsjqz+KC7
         On7oxOG/pVWnowRzxg9m734QTi9lpWs6htuW8VX/f8fF3XD+Axbvam0Zh/X69HHG30A0
         WUBxj5GQWeGk4sQInBw4fZUj0G1Ws9TK+UaPu+8YK2Ev5dfgbTxo1KUhRI7grTgG54nT
         CUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7sGHhxFMHshopRdHZUcEy9vX/jH3zQCKqnpFANTRXwPQ0DE4NcuzDUyUJYrfApr6lRaDrh2KaKnvcAMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYMZwJRYwfwwX437XWBXODiX9C5Y8sARSc/s8rZ1vkFnOHVof
	ecCNFhk2lAeuqfJxo5nEHcwysQ2pH0CrNs/5hL/Cj0nh+3R36ncGW+blKeLpy24L+tjSmVq0+Z7
	R9z9VZ9JRSHqD1P8/ATkX7rYTtw==
X-Google-Smtp-Source: AGHT+IFFgy3uOiYkfgXSKvEHx/UgS5vFK40ACXZHcvac3+mJfnimRkLhC2vM9vssr/5l88QZLrGZkaFEBXqbcHd+ZhA=
X-Received: from wrbfa8.prod.google.com ([2002:a05:6000:2588:b0:390:e9d7:900b])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8f:b0:38d:d274:4533 with SMTP id ffacd0b85a97d-390eca41791mr151865f8f.55.1740680274621;
 Thu, 27 Feb 2025 10:17:54 -0800 (PST)
Date: Thu, 27 Feb 2025 18:17:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227181750.3606372-1-sebastianene@google.com>
Subject: [PATCH v2 0/4] KVM: arm64: Separate the hyp FF-A buffers init from
 the host
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This moves the initialization of the hypervisor FF-A buffers
away from the host FF-A map calling path. If the hypervisor
cannot map the buffers with Trustzone, it rejects any FF-A call
when it runs under protected mode. 
Other than that it moves the definitions of the ffa_to_linux_err
map from the arm_ffa driver to the ffa header so that the hyp code
can make use of it.

*** Changelog ***

v1 -> this version:

Split the patch that maps the ff-a buffers of ffa init and introduce
"Move the ffa_to_linux definition to the ffa header".

Thanks,

Sebastian Ene (4):
  KVM: arm64: Use the static initializer for the vesion lock
  KVM: arm64: Move the ffa_to_linux definition to the ffa header
  KVM: arm64: Map the hypervisor FF-A buffers on ffa init
  KVM: arm64: Release the ownership of the hyp rx buffer to Trustzone

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 56 +++++++++++++------------------
 drivers/firmware/arm_ffa/driver.c | 24 -------------
 include/linux/arm_ffa.h           | 24 +++++++++++++
 3 files changed, 47 insertions(+), 57 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


