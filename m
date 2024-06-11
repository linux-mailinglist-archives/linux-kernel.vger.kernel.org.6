Return-Path: <linux-kernel+bounces-210064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF257903ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30CF1C2252E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B517D8AF;
	Tue, 11 Jun 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwOjPLg0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B1176FB2;
	Tue, 11 Jun 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116200; cv=none; b=Oma7ppCZo807SauwSds9eeOMWreOqAjwHzuesBoU6DFEsL0hPJE6MHYxi/uv4pdrN9z9L0mydori/Rc2BrYR/RJDWHMcCHzWKXRmhsqdOX5taIDoLnhiLcRr5ZvJvLcocyb/QGjUpXNLWBz9zDOWvwd8cEYyVsaJgbVqVQ8PVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116200; c=relaxed/simple;
	bh=jFYH2da5XcpRBIqchmBL/ENU7P0kcVqu0RtOd05/6/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=buDdogD+VF0eC1EX6lzNGyOh+I27Rt2Kn2/lYO8cKdFLK6xYiTjQ07nNn19tkRxV/cApZsMVWao6QmZ7KUExb2Skh8bSPbcI2+blvImPpZ04E844PXbAdb6r4L5vgHKldTsyGnPD2g3RIxBEvuevJBz7wpkWVGIsAuWbo5XwXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwOjPLg0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-701b0b0be38so5332915b3a.0;
        Tue, 11 Jun 2024 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718116198; x=1718720998; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qw+ZTo+XND5Z/h5anzLLoBN7tIc7rhg0Cb5o5EiNfwo=;
        b=iwOjPLg004gtdgyRJ8s1RZe4LBo5zzqYg4LvTady0aJE84OJoZJ/IgNdizTdC1p9I8
         7icg+qDxgfMUrOkopD1tb1Tw7Br0ZAELu2pHiRct6W3pdALhvOGd65w3U2xBBk4sqyfN
         wB5b5e7Uao/ExQRr+gVBfQuOcpYQEfcK+6O7bqVdP3cpnkj6dM8nCJfwPdM1/YeVvp0M
         ld78OYTAVu12L3t/MQN6R23XFayclsQJF+Crlj31vJ1ifybQXKMGReFuAolcTPyb8vmC
         nK8KsCa5QOr0QDqVTuCTzuQCi2PRXd1zeujb8gXLI9EvSIt0bLAmDCXPVfP5aGOyLgvx
         u5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718116198; x=1718720998;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qw+ZTo+XND5Z/h5anzLLoBN7tIc7rhg0Cb5o5EiNfwo=;
        b=QBMa4KnHrsiwnluD9/+FoVEMQZ1k/N0Dgd55RdhBZ8n7xLzX2dVd+1sKeHAgsOMhE0
         GHRvGGo6ZySdoUGoNtE7sG3/5xQsJBZjaNIWtXUX4w2si94j90KhJpbkuC8aXyUjNZmk
         xbi2pK/Eu+9S8RNXCCc3aC8VQWG7llQvWl5c+GgrgskVSJg44B8PXfmsPQfu1QEX/9G1
         2YrHBYFZkvx8gNlZUgytJHwknrf5n0zbsJLq/AWGomHzflPk9TDRiUPRZM5y5Sbccvry
         wrBoRSOSwJy2R8yQw4bJ3lOPI0oiafu2j3P6/6BJGnkJQGL8fy7Myfj4BB3cA4Qju7W1
         9q9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQmDy+D43HUt/9upODLIr5NmMYIpeKufUtVxH6sRLxLFlEmMTa22wGybakgzMHztJLA2U5g+Ya6DEth0eDMtYEYF8HZhHDUWEjT4m9
X-Gm-Message-State: AOJu0YysMZtT09jFo8Rkf/bjO6C6taZ1Rn2tBAv4dyrMLe8ybwpjac5i
	MBIq8cdI4+lZWQddviVk81Yr4Ql/Ue9TtbZrhm8qp/XGlA5Iykyy
X-Google-Smtp-Source: AGHT+IG2mqTYdeCEXWIJR2uKPPk7Ohhj3KpLoWze21uf2Ct5dMlAtm7fMRmC869DyZet027tJbtPTQ==
X-Received: by 2002:a05:6a21:6d8a:b0:1b5:e2c8:dd0e with SMTP id adf61e73a8af0-1b5e2c8dd9emr9718975637.9.1718116198223;
        Tue, 11 Jun 2024 07:29:58 -0700 (PDT)
Received: from localhost ([106.44.60.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70408c58197sm7777141b3a.129.2024.06.11.07.29.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2024 07:29:57 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Date: Tue, 11 Jun 2024 22:29:53 +0800
Message-Id: <20240611142953.12057-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Jos Wang <joswang@lenovo.com>

This is a workaround for STAR 4846132, which only affects
DWC_usb31 version2.00a operating in host mode.

There is a problem in DWC_usb31 version 2.00a operating
in host mode that would cause a CSR read timeout When CSR
read coincides with RAM Clock Gating Entry. By disable
Clock Gating, sacrificing power consumption for normal
operation.

Signed-off-by: Jos Wang <joswang@lenovo.com>
---
v1 -> v2:
- add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
v2 -> v3:
- code refactor
- modify comment, add STAR number, workaround applied in host mode
- modify commit message, add STAR number, workaround applied in host mode
- modify Author Jos Wang
---
 drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3a8fbc2d6b99..61f858f64e5a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -960,12 +960,16 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
+	unsigned int power_opt;
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	power_opt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
 
-	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
+	switch (power_opt) {
 	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
 		/**
 		 * WORKAROUND: DWC3 revisions between 2.10a and 2.50a have an
@@ -998,6 +1002,20 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		break;
 	}
 
+	/*
+	 * This is a workaround for STAR#4846132, which only affects
+	 * DWC_usb31 version2.00a operating in host mode.
+	 *
+	 * There is a problem in DWC_usb31 version 2.00a operating
+	 * in host mode that would cause a CSR read timeout When CSR
+	 * read coincides with RAM Clock Gating Entry. By disable
+	 * Clock Gating, sacrificing power consumption for normal
+	 * operation.
+	 */
+	if (power_opt != DWC3_GHWPARAMS1_EN_PWROPT_NO &&
+	    hw_mode != DWC3_GHWPARAMS0_MODE_GADGET && DWC3_VER_IS(DWC31, 200A))
+		reg |= DWC3_GCTL_DSBLCLKGTNG;
+
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
 		dev_info(dwc->dev, "Running with FPGA optimizations\n");
-- 
2.17.1


