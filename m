Return-Path: <linux-kernel+bounces-280466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFE94CAFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763DA283B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF816DC37;
	Fri,  9 Aug 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BoiCiB/z"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293116DC22
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187457; cv=none; b=LGAaldgRtct+ZWgcwdlmx5Ylxburukx7+TqJN9jNsjSNMCtpK0MoI3K3emM3N9due5MQ3NtHbB/S0w5EhdzDcbOYRcIiEFmCdMPObOuilgNR4gw2JdBEUqlxX06sa7ZA+ump6XgaWh084iVOCIxvLgTMF/7gKQ90TWKauTBjQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187457; c=relaxed/simple;
	bh=KTG5mWtTdi9h15qQxlscp8Vhg1n5zK+BuKhkyEQR6Ww=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QiAaQMoT60+ndakoi9zHGQDnSo4wn+TNg6MYZXfQu0byOmB5ZdHHSJzQ6xTBiOhq6Mavgeg0zVLBcDqLyTADjAO4iFePjaEzyfbEvUPJMJr6R/HjIUnFj/Om922uCZxn6/v4RSdOINEu9K6lCecCPNT1lnvhMsELaIZ+cAlzRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BoiCiB/z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ab09739287so1249130a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723187455; x=1723792255; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK3MDCV2rpOHu2qy4K9eeOFj7ftebBMKk/Vr4qOeqzg=;
        b=BoiCiB/zbSWe6d5Xmelzh5PSR6H6Bn/I62tGG8TaMNUya4lJuLLeVB/dDIa2F9QF/S
         U3dAhTigJw3T1OxxY5usRx3fTkkEUHWDergZacu9bAD9n1TXOPNqQwGFlR1cs7qFwGj2
         C2U1IbyFHALDvktzpSrxTClup56cCC6gvlr8E9yUXM0hW71jf2hbjMihXgjDnHZvhsaY
         prOmLLwu3Rk3BveSguMdhxric9k7QjNsVZvIfF1FhLpW9vfQaB2MX/0Yu9Bu66bkpA1V
         +H05T7XvaI6gajIRHpyM2DcJC+rSfexUo6l0ZRqE+yd68m8ssOnQ06wOVR8rLG24/1nB
         8rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723187455; x=1723792255;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK3MDCV2rpOHu2qy4K9eeOFj7ftebBMKk/Vr4qOeqzg=;
        b=CmRi8tPWIp+VY52+YKXD7CtWq349xiXyzFlwxAhUFaZYTxYAyrVosyJtkTplZYXPC4
         ulBjgTn7Psvbha1uovZTwmMVDnPGXKvvW/aRfDNWBZowR5ca5FgTWQYomlUCzVGBxpRK
         PEmSY4INujjhjk9J8Y1rYr0aaLVRhs6LlCmuEruqgcoB5tcRxdWaV6SfGN19uK8kn9un
         +wQ+kF3kvwf9CGXk5Ifp7GMTus7Jbrf275tUx2a1Vz5uF7DlsQu4Qmt1Ugt6gofd20sq
         9F5HzPEaMmqQ/FWvjI9w7SRFzihwe2Yy3dz/kBG099oiLWuHiO8ojdrKln7F9pkGYCVM
         RegQ==
X-Gm-Message-State: AOJu0Yw5gQZnhPIY10OVtjojK1QhH3bmQL9eyX16kacFY2/hKnpDqvVa
	93m3cb2KEZNfsSA8mDGt4aWo2V2xdI3nRl/dZdmoFc0Or6duM2YlCBGrNwxHuXVojAZPKn/aK7C
	gjRcgunL/UJawlTW6zpWeuiVk5kxENxryf6xLn/vbD/bKfYr0/16I5ux6dThwatx34/PSusNLzr
	ndKaxbaniGEi2h6EWkkLve4pGl/dyVxDInjVSiIegzSCmxtkSzhxme8A==
X-Google-Smtp-Source: AGHT+IEY4TBF7ra6jOH+IWRmf/XQhCq6io9RLd5FW+CdEtFQTLVV5A2SEkQOUfMGT3hVBJ8eZ2Qvow==
X-Received: by 2002:a05:6a20:c916:b0:1c3:b26d:82ad with SMTP id adf61e73a8af0-1c89fd2693amr941315637.3.1723187454381;
        Fri, 09 Aug 2024 00:10:54 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e7490sm2079259b3a.164.2024.08.09.00.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:10:54 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2 1/1] irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration
Date: Fri,  9 Aug 2024 15:10:47 +0800
Message-Id: <20240809071049.2454-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The section 4.5.2 of the RISC-V AIA specification says that "any write
to a sourcecfg register of an APLIC might (or might not) cause the
corresponding interrupt-pending bit to be set to one if the rectified
input value is high (= 1) under the new source mode."

When the interrupt type is changed in sourcecfg register, the APLIC
device might not set the corresponding pending bit, so the interrupt
might never become pending.

To handle sourcecfg register changes for level-triggered interrupts in
MSI mode, manually set the pending bit for retriggering interrupt if it
was already asserted.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
---
v2:
- update commit message (Anup, Thomas)
- rename aplic_retrigger_asserting_irq() to aplic_msi_irq_retrigger_level()
  and make it as a static function since only APLIC MSI mode require it.
  (Anup, Thomas)

---
 drivers/irqchip/irq-riscv-aplic-msi.c | 35 +++++++++++++++++++++------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444af48bd..9d63dc37dea5 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -32,15 +32,10 @@ static void aplic_msi_irq_unmask(struct irq_data *d)
 	aplic_irq_unmask(d);
 }
 
-static void aplic_msi_irq_eoi(struct irq_data *d)
+static void aplic_msi_irq_retrigger_level(struct irq_data *d)
 {
 	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	/*
-	 * EOI handling is required only for level-triggered interrupts
-	 * when APLIC is in MSI mode.
-	 */
-
 	switch (irqd_get_trigger_type(d)) {
 	case IRQ_TYPE_LEVEL_LOW:
 	case IRQ_TYPE_LEVEL_HIGH:
@@ -59,6 +54,32 @@ static void aplic_msi_irq_eoi(struct irq_data *d)
 	}
 }
 
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+
+	aplic_msi_irq_retrigger_level(d);
+}
+
+static int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	int rc;
+
+	rc = aplic_irq_set_type(d, type);
+	if (rc)
+		return rc;
+
+	/*
+	 * Updating sourcecfg register for level-triggered interrupts
+	 * requires interrupt retriggering when APLIC is in MSI mode.
+	 */
+	aplic_msi_irq_retrigger_level(d);
+	return 0;
+}
+
 static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int group_index, hart_index, guest_index, val;
@@ -130,7 +151,7 @@ static const struct msi_domain_template aplic_msi_template = {
 		.name			= "APLIC-MSI",
 		.irq_mask		= aplic_msi_irq_mask,
 		.irq_unmask		= aplic_msi_irq_unmask,
-		.irq_set_type		= aplic_irq_set_type,
+		.irq_set_type		= aplic_msi_irq_set_type,
 		.irq_eoi		= aplic_msi_irq_eoi,
 #ifdef CONFIG_SMP
 		.irq_set_affinity	= irq_chip_set_affinity_parent,
-- 
2.17.1


