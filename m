Return-Path: <linux-kernel+bounces-572721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367DA6CDC9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C193B9190
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13D1FFC77;
	Sun, 23 Mar 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+AEOHca"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425828691;
	Sun, 23 Mar 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742698786; cv=none; b=Ric8qOXCPyQ6vGT/waxUD1TUFKR1jdpKvXOLNZ8Fx+HXYY5edJW3n1ktwPxm3rXjRto+c6Ro6xxKWpPh9kQc+J8UNohiVA6Qtpn0V+sJufar/FZlBSsWtdt0do+LHDv9wmxbStuPbSzrslB0VdMA+vwm8AegdFu8pOt9HYRhF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742698786; c=relaxed/simple;
	bh=9BtaeiQjKgDpAE1AwouiFw+6IA/C4KaLsTyZY7gdYAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+13hVYflzUTQrThHAcf2kIGHG9KEBq/4h71p+5tW6PNAlxBuuCG2TXWR3GJGndISK+T728+NswDBjAy8u2oezYVOfL3XUWMv9qunap7Lg8l+muWyOvioX1OhpNdV6+yYi59tIWJeJTkch6VdpQ3qQt400/4k8oxPh69CoG+WhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+AEOHca; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5ba363f1aso329903985a.0;
        Sat, 22 Mar 2025 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742698783; x=1743303583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alDYSXZgOpXws3wZPrNZiq8p2H6lHODtdwt0xCwEuHg=;
        b=c+AEOHcaYq1Qtl4daA8cdO00VVzll+82XGKhgMT6hHAnISt1ArSRB718DTdswzKP58
         +uHmYzgAfDQi1wJTdquUPkIQDxLcCNMwwn/8jQPW70KHm2UGjCVgTn1VNIx+zX5yTzFb
         yy/f4tjlrRO3tdq/f2JkimIdt9eGx3FE0zMGBxkAH2L5VZxYPo7hXyI7Y1jXWJCaz5dX
         e/eYLEsY9jI8y3CVgJKadKb4EUbdUVWuineoBC6KcPa3StWghV/nL/L2Tg1By4ssdF+D
         IMj+vBQ2SPrbMc2Ec0AjbBsEg4sgDUhARAWxFvqR8AuAoFFIUeQoW/LNqLgVgePZ9mO3
         ylnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742698783; x=1743303583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alDYSXZgOpXws3wZPrNZiq8p2H6lHODtdwt0xCwEuHg=;
        b=THpOSfOJRJYw8hgK+KYu+qZ9s+5MvKhLQo9wClH6W71hNbxOx2ngfZ6kzG4hByXh5k
         CzdUMko7hw+hT9wjffgm8NWgz91TfaY5B2mM7ZPXLLw1E3J5Om8+9BIuOfEPiYmTUZsg
         iFa0OTmWTPGLeM34Jf1kZ9p+zL4VtCm4xH5J0D2PeolX8tIeS1RNwKHW1Bo0GOilXZXI
         bV2FuNl1GvwcJCJqVIyoT41gU//T+Hy2AHXMsSsD0k92hNDL515HTVuMB91tGffiBtl3
         l6CAaprAc3kwvQ3aFkNSnNhdBkmWpzCuMzkzKCVGnZUzJAXotNn8lrGNxGOMcYo59UWu
         vdIA==
X-Forwarded-Encrypted: i=1; AJvYcCU15i5Rk7dgoV7/8z3yBw1fbCGXwOImqYnBA9Z9qYwTvzhw1aH5Amv8SXmwRhfywFx8/QHl8ljaKJ/lg9qAVlg9FBH71w==@vger.kernel.org, AJvYcCUL7JOgLC9sHSp1Ie5Q+aOJ1iH0LQPEW9m5WA1Rrg7LrcN8Lt/6WMtscErMUGkMkzHZJ/rLZ5KrVnbXk1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeDFDgDmJ2LctGHekKA4RGCdmCMUyFEzgMublIzVjHzjWrZTv
	c4x5mADfbPW1AH8Y/PayiHt8q2fDz4K31ZmOnuurGvFZCHoi07PW
X-Gm-Gg: ASbGncubLtvzxQomu3rase/Q6JYjAoPDRlKElQh0HJ8gpY0L0htdQ1+qjYcqtR1CLdd
	0afd5adIZZxTyJBXdgv1MrpDuma9Qsmp32PVFeF1mMRqQEBCFHcd2QNO7gJi20u1q6Y6PUSbyp9
	ThBsC+Gj/1ilTYdLO8QZ55gJZ8TgPQYuOG38HAAcJM3K7aC7VMjq3FrE4e5xNaR5mcTvzRtAMCy
	kyTkF0mn/fsSfMLNdYjhUDN2T5MjaS2ZfyXkvXOvHGCMa0M+lPdyo5XYw5JXIHBBcSBJH6uMX8o
	95A7B2zzMvdk4P3cMikMwzWpoFCXICFcAJ2RzOkKmeMtUSkLdGPGnFQmMHd1dQ9sikSEIuvCCUK
	Dqg94UU6ylFRxP+dKtFsCAFyoLJFyQw==
X-Google-Smtp-Source: AGHT+IE2oMk31LVZrSN2YrexYmcS3QStHLUvupI6DVGE5JYw2i3VW7ou4ghFmTV7R/0M9m/R1yKfBw==
X-Received: by 2002:a05:620a:2485:b0:7c5:3e76:bcd7 with SMTP id af79cd13be357-7c5ba1dee3dmr1348443885a.37.1742698783386;
        Sat, 22 Mar 2025 19:59:43 -0700 (PDT)
Received: from localhost.localdomain (pat-199-212-65-136.resnet.yorku.ca. [199.212.65.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d6b09sm319804185a.46.2025.03.22.19.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 19:59:42 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>,
	Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>,
	Vlastimil Holer <vlastimil.holer@gmail.com>,
	crok <crok.bic@gmail.com>,
	Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560
Date: Sat, 22 Mar 2025 23:01:19 -0400
Message-ID: <20250323030119.17485-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug was introduced in commit 57d0557dfa49 ("platform/x86:
thinkpad_acpi: Add Thinkpad Edge E531 fan support") which adds a new
fan control method via the FANG and FANW ACPI methods.

T945, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
fang_handle and fanw_handle are not NULL) but they do not actually work,
which results in the dreaded "No such device or address" error. Fan access
and control is restored after forcing the legacy non-ACPI fan control
method by setting both fang_handle and fanw_handle to NULL.

The DSDT table code for the FANG+FANW methods doesn't seem to do anything
special regarding the fan being secondary.

This patch adds a quirk for T495, T495s, and E560 to make them avoid the
FANG/FANW methods.


Original-patch-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Co-authored-by: Seyediman Seyedarab <ImanDevel@gmail.com>
Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219643
Tested-by: crok <crok.bic@gmail.com>
Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
The main patch was proposed on Bugzilla, but I couldn't reach the
original author (Eduard Christian Dumitrescu) to help him fix it
and resend it, so I submitted it on his behalf.

Kindest Regards,
Seyediman

 drivers/platform/x86/thinkpad_acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d8df1405edfa..365cd7e452a4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
+#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
+	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
+	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
+	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s  */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8874,6 +8878,16 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	if (quirks & TPACPI_FAN_NOACPI) {
+		/* E560, T495, T495s */
+		pr_info("Ignoring buggy ACPI fan access method\n");
+		gfan_handle = NULL;
+		sfan_handle = NULL;
+		fang_handle = NULL;
+		fanw_handle = NULL;
+		fans_handle = NULL;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
-- 
2.48.1


