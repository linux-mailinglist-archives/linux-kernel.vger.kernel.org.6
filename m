Return-Path: <linux-kernel+bounces-293549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1B295812F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619001F247DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3F18A92F;
	Tue, 20 Aug 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQ4XsKl5"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E518A6C2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143367; cv=none; b=OjqJZnfWtcMZGT1SnsWIHaAOEDteG2M1ykbWcXyjbjLPggPu7fOkmb+Q45IH++/w4GZp6+BVPXhDAMKbSRKEQZHMNdGM/XQeytaNUC+E7h5ChCTljF2Ee7WpMQ94kxwVt/HIuoDLw1sTA4mt0MKqXRQcg3wnK//8CVphiX4f8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143367; c=relaxed/simple;
	bh=6rtUYcIz3xm63JUpK8NzVborqyrGoiRibCxvD6FDPOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OXoywvcl6gILzsB8wOCkyGQFv+DVZQA02Mp983xW0gLbngcXcIIss/2dJN1on/csxg8GpGNz7V/tPxInOUP1vxvmTR0dzpX5mNAcDPlgMIrKPzKFkIkU83EdE2kPiUHtBx4N46HVmJEZriepSatccfPZndECPn1YqecFEDFSlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQ4XsKl5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso59928411fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724143364; x=1724748164; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PP/VAgEIyHL1KqSWiO//9a8kNH8xXXjnkMKoqwockA=;
        b=vQ4XsKl5OYUeowSx5itoMpdeZ2TZujx+22Y+U1I4R7X9WB9Zggbrk7SFTNE4Ftdpz5
         6+4di6mznYeXOnHZb05xR7vyvHJScFWc+5oimSnM2BNcRhuVJxtBzx19fFkAoHT0+f1I
         giJOH2EeoClbM59STQ3kMJjc4EwvI1w1YTn7GGnG7vq9ScyuCNRsI+ecUAEHgnMCXiRQ
         NeR6NXI1/m8+UzU8asA4KQY/cW7reiMpaY8ehY6Wp5cmOp9lJF+6vcVRoO8Pynlh8owh
         qsp7ZZSD6MsR62yhjUfdPUzBGcy3J2HqJ3AwBPkEIpdX62myyBZ6zVAkAcXbPb9HSvKF
         jgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143364; x=1724748164;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PP/VAgEIyHL1KqSWiO//9a8kNH8xXXjnkMKoqwockA=;
        b=rYagUti7zNUdrq0v4Sa/w3U0ziLdr/RheFEkn/uzQsCjH9JEk0Sr399ETy0hhnpDtf
         zxNzdRPIAhLU5fJveSF9KSfsdTmTUeVMEjswbCMCmHjdoNF0F699GkORmGVqO0/Uvy1S
         6LMaFZyQTXM8aLs01JWhD+g+5IMKKYcfOYJQlqB867zP27agQPOSOHzBvuz9ZM3iJANT
         K5upKIZCQ7hpfRtMI+Ob33zT0pmh9Rxhqy+dOGqbXWt/90vzafxdv01GubNA+qhOWGdN
         LqSeHkB2D0vbyokdsTsngOf7dwDgDxORIJw7Hv8/dH/vBh8xmnpvJQo42tDdm+1il3Vo
         KoeA==
X-Forwarded-Encrypted: i=1; AJvYcCX0pn1P7D4foV12GvHtNAaqySTfDtPJz9H9PlntESSbjoxZCdirDyJT6M7jUSgeoczfnwHkS4oFc1o9KUe4SXoVZIpFeSkxdLL6jHAP
X-Gm-Message-State: AOJu0YydNObNufDAsZYx8m3R0V7mQY0WIsESaRL5DftsIF7PZSA9UZRZ
	EmbUcVg2ma1Lz6LnGW4Snv9ct0FiWNsGN9H/kfyRneRaRSIKUJOo669BQE8gv9w=
X-Google-Smtp-Source: AGHT+IHyMvSwXLRRmCjKbTOz+MEieevfpO33ioQwKGl2Doy+5ysz84GRgquXIJdiF2lrdI+nfWga3w==
X-Received: by 2002:a05:6512:6ce:b0:52f:d0f0:e37e with SMTP id 2adb3069b0e04-5331c6dca58mr8439534e87.42.1724143364033;
        Tue, 20 Aug 2024 01:42:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c306sm731716766b.208.2024.08.20.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:42:43 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:42:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()
Message-ID: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_platform_ioremap_resource() function doesn't return NULL, it
returns error pointers.  Fix the error handling to match.

Fixes: 2333df5ae51e ("irqchip: Add RISC-V advanced PLIC driver for direct-mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-riscv-aplic-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 28dd175b5764..981fad6fb8f7 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
 
 	/* Map the MMIO registers */
 	regs = devm_platform_ioremap_resource(pdev, 0);
-	if (!regs) {
+	if (IS_ERR(regs)) {
 		dev_err(dev, "failed map MMIO registers\n");
-		return -ENOMEM;
+		return PTR_ERR(regs);
 	}
 
 	/*
-- 
2.43.0


