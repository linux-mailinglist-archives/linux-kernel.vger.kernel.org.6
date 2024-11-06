Return-Path: <linux-kernel+bounces-398124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9A9BE5D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05F5280CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8B1DED76;
	Wed,  6 Nov 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="QKl4N1IT"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88E1DE3B4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893308; cv=none; b=NIYwg9gFTLtAl4z5+9HDgfH9GeATXrTBdLbkqq33eVpZ1j7J9IxWWmFEhSRdMdoll9pr43ToiM0DJYxDGugzewnZzRPbpXd/qWk4L4TmHzsLSOT+P9nVidgeaX33y5fYJz62K07NMWMrkICX7oDlR/3KR3js5z8DvskFa96XvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893308; c=relaxed/simple;
	bh=gpKnmGMkCL3MLyDlexE5kcZ1gDVx6RqpDiyiH1Uxa/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETg3ECAoYo70ipInnRLEf14h1D29MhGwdB9JPxk8xAdwewWu2Fvx2dH1gl3P5ZXPojz3eJ3Y3ZIbFvi/pF7FPFRiUA5qU1nL+BwMPkv8/s4gwRehwnDTVPgdvN9bPOAWy6zOTiPARJ5Wv7uRm8cgZyYyCX8GekCJb/7kiUhGXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=QKl4N1IT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539eb97f26aso4528348e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893305; x=1731498105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPCzRjUimrvW9UNg2TpVh6Pq5BYTOh3dyaOa5B/jNvU=;
        b=QKl4N1ITS3KyKgTXShiN9+r8rm63nzdKdhl1/1DteMb2f3NDfE+YQHD0Yref2k3L82
         zcI8vn266L5K3cn98N1/NhRr9ruZkRaOBYaljYQr1FNhXvBd7E+XPzShTg9BsHizNTCx
         BQoBcnZ0ZRLbSv3YXTkknlueDqQ6dfhhfG0ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893305; x=1731498105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPCzRjUimrvW9UNg2TpVh6Pq5BYTOh3dyaOa5B/jNvU=;
        b=Iy0iUskH/U4rjwUXmYrj7bz58mo2COd8qYiFCwT1IpjXtKDjDKRXBn4QaoRcrgFWGc
         4wDba+fnJjcje+11UTM7T6jolwcwQWFfBhtFWkziUOYyFpf3Zpi+z33OGhjTO17Lv1b2
         NQIeaJmlv++zZR9QHloPyySzjiFD7SRLNfRIKyIlnsbw0MMwctijNaS5a1jKIpRfB9jS
         aNYOTGw42GiyHdwC/ixGw4ujqkvWkacljQwN4+ty+zNnCg6spg/HEcX5nhBpWIM6/yI5
         YJAGoUfxbB1Wqzkul83V8SxWHPlV7K+z+s3IBTQPjVzvIvs+UCJI5FdAjwgtWBpGdNlK
         KrpA==
X-Forwarded-Encrypted: i=1; AJvYcCVV8gfvxNXBw4rJDwuk3YCoxXQCbTrfOSM3AaZAzpOgbasgTM3/2tSe9oT60RN1WnZGjaj/M0YRLiLWP7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHyEXu3sLa7ekbiG5he//IIgV92eGTWADnODZhKoVjp84FPkh
	dr+GwMOnmlkhRynKX1joysIQWUIZ/jrGA9Z/z8pzxnmIo0hFNWtkfR2uRuXO77w=
X-Google-Smtp-Source: AGHT+IGXkt0yYBT7Tm2B+DHoTvfz6t5T9JKmnp4MG4hr0sosZp9XndcXXtQ2G5/RBce1KaWy/EP2xQ==
X-Received: by 2002:a05:6512:308a:b0:539:8d67:1b1b with SMTP id 2adb3069b0e04-53b7ecf1ff6mr14947497e87.26.1730893305209;
        Wed, 06 Nov 2024 03:41:45 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:41:44 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	Orange Kao <orange@aiven.io>
Subject: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
Date: Wed,  6 Nov 2024 11:35:47 +0000
Message-ID: <20241106114024.941659-4-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106114024.941659-1-orange@aiven.io>
References: <20241106114024.941659-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation does not allow users to set edac_op_state. As a
result, if a user needs to test different edac_op_state, they need to
compile the kernel.

This commit accepts module parameter edac_op_state which makes it easier
for users to test IBECC on their hardware.

Signed-off-by: Orange Kao <orange@aiven.io>
---
 drivers/edac/igen6_edac.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index dd62aa1ea9c3..025f994f7bf0 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1341,16 +1341,18 @@ static int register_err_handler(void)
 {
 	int rc;
 
-	if (res_cfg->machine_check) {
+	if (edac_op_state == EDAC_OPSTATE_INT) {
 		mce_register_decode_chain(&ecclog_mce_dec);
 		return 0;
 	}
 
-	rc = register_nmi_handler(NMI_SERR, ecclog_nmi_handler,
-				  0, IGEN6_NMI_NAME);
-	if (rc) {
-		igen6_printk(KERN_ERR, "Failed to register NMI handler\n");
-		return rc;
+	if (edac_op_state == EDAC_OPSTATE_NMI) {
+		rc = register_nmi_handler(NMI_SERR, ecclog_nmi_handler,
+					  0, IGEN6_NMI_NAME);
+		if (rc) {
+			igen6_printk(KERN_ERR, "Failed to register NMI handler\n");
+			return rc;
+		}
 	}
 
 	return 0;
@@ -1358,16 +1360,29 @@ static int register_err_handler(void)
 
 static void unregister_err_handler(void)
 {
-	if (res_cfg->machine_check) {
+	if (edac_op_state == EDAC_OPSTATE_INT) {
 		mce_unregister_decode_chain(&ecclog_mce_dec);
 		return;
 	}
 
-	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
+	if (edac_op_state == EDAC_OPSTATE_NMI)
+		unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }
 
 static void opstate_set(struct res_config *cfg, const struct pci_device_id *ent)
 {
+	switch (edac_op_state) {
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_NMI:
+	case EDAC_OPSTATE_INT:
+		return;
+	case EDAC_OPSTATE_INVAL:
+		break;
+	default:
+		edac_op_state = EDAC_OPSTATE_INVAL;
+		break;
+	}
+
 	/*
 	 * Quirk: Certain SoCs' error reporting interrupts don't work.
 	 *        Force polling mode for them to ensure that memory error
@@ -1509,3 +1524,6 @@ module_exit(igen6_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Qiuxu Zhuo");
 MODULE_DESCRIPTION("MC Driver for Intel client SoC using In-Band ECC");
+
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll, 1=NMI, 2=Machine Check, Default=Auto detect");
-- 
2.47.0


