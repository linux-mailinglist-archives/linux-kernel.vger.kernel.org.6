Return-Path: <linux-kernel+bounces-353449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECF992DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC431C22FAC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA21D79B1;
	Mon,  7 Oct 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5evg8+M"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2B1D7999
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309335; cv=none; b=bjhzQPh0BONVEJinegTfOLag8nT7NftPt7NOU6/M7dCoUVf0yxkYiDY/UJ4o3OXZAqZxs4YjQwC8T1HAxW7RR89tC37w5wJw/ErhaA7MclhZqzQuoVCV5HEAZ0937SwG9CubFFGSUulmYKmx7wpRuuLuxbk6fFB3tqZ/Uxcnue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309335; c=relaxed/simple;
	bh=hozD34R+1r+AOEtpIL+3KZ2W+shD6S4TBvGWV06zetk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8dhqWFmeFx+2Xj2roUs1EUIWNafU9dvKJZEVMTZp1QNVwBRlxdjHSTgIOTiENQn0RjpEwv/v7RmomHgk0KzI1RqbbijTxoQOcYY3SjU2Lo2kyxrbYnL3rmzGeNCwN6GuwikReZDtrc99ALI/w+ycMSHK2Hm+yl3966SfAortFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5evg8+M; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e26ba37314so14205447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728309333; x=1728914133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUZWXIYmMgx7eQT8FX3UW0dYEBsjOxQkFr0vicKGH/A=;
        b=p5evg8+MRSv5KkN7vv90IGdRQpXLMn9Y9F0I2CQu4ovN0sN76svBpHba1udyJM0tCV
         qJGgftQBwWe/zYSMpiBtlRo54MuksLoYGCG6ZrivMvOCx1E/KaSfFBub4q/TMFPgRJW1
         jfIBd5+EUF7irkunOLSzAoyWgjCzSRFM7fGLPzAX9ib15GMWFKpMYXlRQAtbnirzbPRe
         DBvPwln6jvY+kZshT6fwSqkS3flhNF2HLvLl1FI1t36IlM/FCRVZkbV+JcWFeXJQ1Q4Y
         N5UTodH0k17tfL2fdnH+GOOjYqDham3F8Qwv9uEOQJJ/sQO7W4QyJcL7/qMml8rTtEUd
         J0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309333; x=1728914133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUZWXIYmMgx7eQT8FX3UW0dYEBsjOxQkFr0vicKGH/A=;
        b=QfzneiHwUltnDBkCw5/0wuB1dpbn0OXK96utkmYGrE/IfOoHi/WpSBsRb6Yjqny1DB
         rT1tWs0KsYbR303nj+8JeC26fB/8kS2svIdGLiSPOZukbfkJZSlwTpAYeteOXRaTEuxd
         OhLqKhL94NRfoFiTMiAisYyiC47272Rhu8HaUKzHpFEXmRn5y5R9GmKmjZzxbawzvZ6q
         Qlwfs8oQVwuftZ7XULk45zHkVdaQZ4O0BgFwDJ1D/oW9SP2lJFKzK19btcsvFPTLciJb
         a0A6hhBxQhW2bTqJTy8HkLUxE1G6j4j7HlyGD0owUXYLjbpUNA6z+DAtK3gmIj5b3fkx
         uByA==
X-Forwarded-Encrypted: i=1; AJvYcCVi8hK8QdB/e3ITkFqEaXnPwsiUO8aIZtULcv8wyIYeJ5D9UYyjTri0GX+r1/GgpuJy0GyTwaHTu//qFWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ncMtCN++gFe3mwdAy9MjdT3cDjzG5+geJPO671f4fWdIjvKB
	LNhA3ErNkhynTHkZscAoKvkTlJAatN6d6TkiDHv25bs/noAVm0zjPPEIRok0ajsIjNVq/y9OM8n
	2X4p8KrkIjg==
X-Google-Smtp-Source: AGHT+IHfzB+j+raL3YfEPrA/7E6aJxT/LOBbbgaPT9rP/noUUvfUlHVKB44G7oC3F1FuusFkgKByAeWn9pVWWQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:d84:b0:6e2:371f:4aef with SMTP
 id 00721157ae682-6e2c7289a65mr408327b3.3.1728309332607; Mon, 07 Oct 2024
 06:55:32 -0700 (PDT)
Date: Mon,  7 Oct 2024 13:55:08 +0000
In-Reply-To: <20241007135508.3143756-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241007135508.3143756-1-joychakr@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007135508.3143756-5-joychakr@google.com>
Subject: [PATCH 2/2] usb: dwc3: Program USB Gen2 De-emphasis defined in PIPE4 spec
From: Joy Chakraborty <joychakr@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Set 18bit TxDeemph[17:0] in LCSR_TX_DEEMPH(n) register for USB3 Gen2
Normal Operation as defined in PIPE4 spec based on dt quirk
"snps,tx_gen2_de_emphasis_quirk" and "snps,tx_gen2_de_emphasis".

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/usb/dwc3/core.c | 13 +++++++++++++
 drivers/usb/dwc3/core.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..25e19aea364a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -693,6 +693,11 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
 
+	if (dwc->tx_gen2_de_emphasis_quirk) {
+		reg = dwc->tx_gen2_de_emphasis;
+		dwc3_writel(dwc->regs, DWC3_LCSR_TX_DEEMPH(index), reg);
+	}
+
 	return 0;
 }
 
@@ -1654,6 +1659,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
+	u32			tx_gen2_de_emphasis = 0;
 	const char		*usb_psy_name;
 	int			ret;
 
@@ -1797,8 +1803,15 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->tx_gen2_de_emphasis_quirk = device_property_read_bool(dev,
+								   "snps,tx_gen2_de_emphasis_quirk");
+	if (dwc->tx_gen2_de_emphasis_quirk)
+		device_property_read_u32(dev, "snps,tx_gen2_de_emphasis",
+					 &tx_gen2_de_emphasis);
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
+	dwc->tx_gen2_de_emphasis = tx_gen2_de_emphasis;
 
 	dwc->hird_threshold = hird_threshold;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..fa9db38b7e15 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -179,7 +179,9 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
+/* Link Registers */
 #define DWC3_LLUCTL		0xd024
+#define DWC3_LCSR_TX_DEEMPH(n)	(0xd060 + ((n) * 0x80))
 
 /* Bit fields */
 
@@ -1145,6 +1147,8 @@ struct dwc3_scratchpad_array {
  *	1	- -3.5dB de-emphasis
  *	2	- No de-emphasis
  *	3	- Reserved
+ * @tx_gen2_de_emphasis_quirk: set if we enable USB Gen2 Tx de-emphasis quirk
+ * @tx_gen2_de_emphasis: Tx de-emphasis value used in USB Gen2 with PIPE4
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
  * @sys_wakeup: set if the device may do system wakeup.
@@ -1374,6 +1378,8 @@ struct dwc3 {
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
+	unsigned		tx_gen2_de_emphasis_quirk:1;
+	unsigned		tx_gen2_de_emphasis:18;
 
 	unsigned		dis_metastability_quirk:1;
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


