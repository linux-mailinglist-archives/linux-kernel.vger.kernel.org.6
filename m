Return-Path: <linux-kernel+bounces-445033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F49F102D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2249188F092
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8011EC4D0;
	Fri, 13 Dec 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh7dzqnF"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46671EC4D4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101904; cv=none; b=H6vtlpS3s2+WPd740EIaym8y2uAakeYIytPJvaPqmWk8j+1QiRlRF+4uCXgQkUBmGqv5uGE5rGN66/8mr2lsnr1T39v+78AVHsi/aqorhYmsh4+KU7NWmGk8OOxtJYGxXGJqxLTTLKXPkObxZloszi9hmjtGOaxIgjUuoqe5miU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101904; c=relaxed/simple;
	bh=XvAzclflr2UpwBopbbcBeEOopsATykat3oD2rQeOkiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHSO006VH5z3A9+8vcjLlABNoNJJRfZv4gqqYxscOw9GBtFZreRVVMv70zxk8098dOcy14wOireE3Rp8g1dAlUuWZJ+yqSUQHu2eiCPajdCwivleKxcJulQy06eoCd3mpwefMEwkNGPjShN10bDDfoiqie/Sql6yX72cdCzaLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh7dzqnF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3276200a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101901; x=1734706701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIAyRklPQmqf9KZJxMUGFpriShtgf5N1bsq1t9wgGwE=;
        b=Fh7dzqnFKwHTxBMK1bASwPy8JeAVDspzT0aTy+pvDephV7cX9l60F+nLY3kwgn/1KV
         zmnh9i28eK3NHbfYPS4WYNm/+3m6qSwTPERz9vxUOFtQNv0HHSGlIm5I5Lvr+KKRkCMA
         Q+HGbOHhML+7dlH89KDBEER4PdGVlv+Di/X0MVvUBM+CovgoHE4hhyTmmdc5BXOLSnfk
         3xCaBLJt5D8QHXvhIt8cQHU0xmH/yCMVabNyvGo71uVbgR2TdaMe8ayWDOBKWsWsXNOE
         e+iTyl+DzIiD7kadFP7Q3tHKvNNSdQRUgudQnLLjzoakXfbm3YnUwxCmPh+5ke6BIiLX
         s26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101901; x=1734706701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIAyRklPQmqf9KZJxMUGFpriShtgf5N1bsq1t9wgGwE=;
        b=ADJMgkGr4c7t+q6x7t5tUY0tYp7XX8WBGOoFq/+iD2ThQ3CsHP8GRDjZLBjbrW7Txm
         pIFZy8IckC1NhpK187zXRkwb1HfLrfdNBrPiZLDhRym2TAQWUu+A5uLjLHihtqWA2UbE
         x5R16Cf9wdB0h+JjzmDQP95dgOpCRAtThyckIDylD597zC3QY6zvx8R2AgtbXf6DCrHX
         TyIhjAktOt31D2JbWQDcRNBeKUJ0Wf4+C6Bu1KgUk55gKFpO+BbIIuQmqQJZ3t+/Oxzw
         fCpCLQgpTfKjSMwAuC3qvfIE1WgCih7/6aaRRTZhj45dKnS4nujwK9LsAUNMdkKM50t9
         s5RA==
X-Forwarded-Encrypted: i=1; AJvYcCVmC8kwgv6iw8Rq4vBXIFGSWAqaS0xrous8A2G4HBY+PrWaFRPHd1wKlXqIKGjvKPSGBqDuSUmrnfHcdGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBSmSprMIif4kkphjyxOeorZNODCUz7IUi+TJVIGNkpc2/PfU
	AeYRaRqaiSY+h5p+TWTKmn1kC5g2N6Qz0DB5VqPLGaWElxUkyD/3
X-Gm-Gg: ASbGncuxFdaIz7GhJnr8m+otJr2RDeDI92jteMrgR7hCmYWAMhVuiqN1HjBRsEcsKN0
	FzXWtypCLwuVRmhnNTUBG0nxM3elqhnXJNQX7kegUBqJfyRIB2AfEIQWVk+RTK2qR/Tg/eYTbx6
	+qHl942xcERZ+qa3aSMaXqC+S+NojT2eMFe4NlbJuTVXO/nd4rB4KbgAVsEgSXErYvfDds5hMKA
	gOBXO3FlMdNODbrcgLBdetAIgdrSUOIeT64tGov9u8WxWgWGKgvDZQT+B+XIeBCFw==
X-Google-Smtp-Source: AGHT+IH1tqiOuYhFc9ioeNHPkf8qQaZvXIjpk64aKZaDXNtayA3HfPmpe9Y22E4UKaBziVSZVldg9g==
X-Received: by 2002:a05:6402:3890:b0:5d3:cd85:36c6 with SMTP id 4fb4d7f45d1cf-5d63c3ac2a0mr2656510a12.24.1734101900740;
        Fri, 13 Dec 2024 06:58:20 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cedbb8fesm10048424a12.22.2024.12.13.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:58:20 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/3] KVM: arm64: timers: Fix percpu address space issues in kvm_timer_hyp_init()
Date: Fri, 13 Dec 2024 15:57:52 +0100
Message-ID: <20241213145809.2918-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast return value from kvm_get_running_vcpus() in the __percpu
address space to the generic address space via uintptr_t [1]
to fix a couple of:

arch_timer.c:1395:66: warning: incorrect type in argument 2 (different address spaces)
arch_timer.c:1395:66:    expected void *vcpu_info
arch_timer.c:1395:66:    got struct kvm_vcpu *[noderef] __percpu *

sparse warnings.

There were no changes in the resulting object files.

[1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 1215df590418..a13bb9e8dc19 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -1392,7 +1392,7 @@ int __init kvm_timer_hyp_init(bool has_gic)
 
 	if (has_gic) {
 		err = irq_set_vcpu_affinity(host_vtimer_irq,
-					    kvm_get_running_vcpus());
+					    (void *)(uintptr_t)kvm_get_running_vcpus());
 		if (err) {
 			kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
 			goto out_free_vtimer_irq;
@@ -1416,7 +1416,7 @@ int __init kvm_timer_hyp_init(bool has_gic)
 
 		if (has_gic) {
 			err = irq_set_vcpu_affinity(host_ptimer_irq,
-						    kvm_get_running_vcpus());
+						    (void *)(uintptr_t)kvm_get_running_vcpus());
 			if (err) {
 				kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
 				goto out_free_ptimer_irq;
-- 
2.42.0


