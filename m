Return-Path: <linux-kernel+bounces-279080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30B94B8B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5011F229BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C218950C;
	Thu,  8 Aug 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l+HCar1t"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B588188CD9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104886; cv=none; b=S7CbeEKs2Mikn4urgMrW2GNwwFbSzccKEsKDg1YQT9qfxHkirTha5obnZBUyAejTQRq9c56EYlp1O5Ud3ImmzM3wmSW+kIhmLRnDRDnyabOI4nPIjsdY5fTy9fvuPg2+ipnUSeMqGXI/gtcUN4jxUGySwaVROG6pgOsscSmjiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104886; c=relaxed/simple;
	bh=eYH/t+EqSzgoXAk6bItXHNsosxzNFpOP3Tl4KqWYQGM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pi8jX9zeKhpgHh6QydyvU8Zghr05eiqsVfcJlFldxEZX7c3QeX4LKt7r5Gk0h5GWqtz76zIIm3gCO8GB6Xhk8rktbJH9sbh/Z1YLiT2Oa4T+J28fPi9GfHkiRDlljNgzmREZKN8Gm25Ig2VXjhMNp47zaa9MUZx6YYebckzQX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=l+HCar1t; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso572420a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723104884; x=1723709684; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz2Q34geGJiRJ8e8z0pDWtJTTDFKWyWloO9Btu2KCw8=;
        b=l+HCar1tYDnQ2TsXG4W+EppSebZY7831K8m7qvv/mX9k9LwDxyLWFadzeRinlBdR6f
         lSffAKyF2XKlG7ewoZUqVtdkYCWL2A9YNeanKiiCI8uhnbORYZ+zhYnyTeorHUWqPMB9
         QkvsOzU+cwxb4sXY8tk9yEJlEbAA4D8GczY714e/Qo1FwpUv0Sn+WMKPX7uhv/wiHIXz
         FSUyhY2LRHOIYJJi32ggs8/1qNkgLK4UalPoUEL4iPoW/Agib4/O5MH7cc1DxP4SUrLj
         YfR5vUsvqjq1fIcMV/Ttfs+yDQfp5WVRnlOaNGrSXTJx5hD4Wvbm+zxEOAok1ojoRuNF
         A5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104884; x=1723709684;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz2Q34geGJiRJ8e8z0pDWtJTTDFKWyWloO9Btu2KCw8=;
        b=cis4zIig6R5X/T2IpKVCpRoOjquW4sezAdHX+YQc+biX/P//HuLx8+7mvtbn1wnwev
         tiF3BMn4/nY/nsCdsMsy4Bo8sHy51ZB0/k5Q4gbryi6mrSUZKyNyXFvehYJQGq13kNnT
         crFdsGHnJ5kzUY0qPDR0da0ZU4ORPrrvscOaTn5X31HVgtfhDx/6Aj3W4L0Vr+D8vC9B
         7j5rubjiPuU49HVEZM02AEAhQhxzkewTVARs+mhiwpQ3TcSFoE33kYDuJGkCypf43C+K
         9fpOpv3L1blK241RE/LGGYlK6lBCIP81DndzIUMhL+0XOoTFpx7n2csk/u7DDWxJKVf/
         tCDA==
X-Gm-Message-State: AOJu0YwiBUk1a6dpmS8y9/22oV6GZGI5C12QF160p7w7Pd+IwmrsCvKP
	bB0vyM3b001d7lN7aEOn3bGInB/FrcrN3ZEmBdKOwm45EsGTCewd6GZTte6hOsI3mCJ6x4c/Ceq
	wZYX6A4Nj/6sDR8PmccTsevbBatDoLkDXfvyxD23vh1t4h6ztUWY2u2XenD8Ws6KUh12cWYXwFU
	THDgTXSUviuz3G5Q98RClL9FKsCsrYD69+S6j5fQKD8XYdA7wPgnAocQ==
X-Google-Smtp-Source: AGHT+IE8I00iIp/1AKllHFcYCJLmvvu0pdzTgwwUhvhBSbA/p5VCIfIk3GciGH9HF1hk5jCo+FswWg==
X-Received: by 2002:a05:6a20:5501:b0:1c2:912f:ca70 with SMTP id adf61e73a8af0-1c6fcf7b166mr898421637.42.1723104884149;
        Thu, 08 Aug 2024 01:14:44 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f18616sm118451765ad.39.2024.08.08.01.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:14:43 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/1] RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation
Date: Thu,  8 Aug 2024 16:14:38 +0800
Message-Id: <20240808081439.24661-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In the section "4.7 Precise effects on interrupt-pending bits"
of the RISC-V AIA specification defines that:

If the source mode is Level1 or Level0 and the interrupt domain
is configured in MSI delivery mode (domaincfg.DM = 1):
The pending bit is cleared whenever the rectified input value is
low, when the interrupt is forwarded by MSI, or by a relevant
write to an in_clrip register or to clripnum.

Update the aplic_write_pending() to match the spec.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kvm/aia_aplic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index da6ff1bade0d..97c6dbcabf47 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -142,8 +142,6 @@ static void aplic_write_pending(struct aplic *aplic, u32 irq, bool pending)
 
 	if (sm == APLIC_SOURCECFG_SM_LEVEL_HIGH ||
 	    sm == APLIC_SOURCECFG_SM_LEVEL_LOW) {
-		if (!pending)
-			goto skip_write_pending;
 		if ((irqd->state & APLIC_IRQ_STATE_INPUT) &&
 		    sm == APLIC_SOURCECFG_SM_LEVEL_LOW)
 			goto skip_write_pending;
-- 
2.17.1


