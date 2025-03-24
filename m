Return-Path: <linux-kernel+bounces-574537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A2A6E689
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098073AA7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712FB1EFFA0;
	Mon, 24 Mar 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N58ZWjrG"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48E1EF368;
	Mon, 24 Mar 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855237; cv=none; b=Y7gtQTudWT7VRNaYiuovX2tKDefDAqLTbJrG3balCBc6hSQ+smJGfF4DsH1K5vSBF4RTOaO94XVVnZBx/W2qC7EmdhdnS1adq0H3UyLbr2oU2nZriW3z6C2cTYOYJiSzBIv0eQX66hzNawbCaafUMHmn79kbJhd9AP6OYIn0A3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855237; c=relaxed/simple;
	bh=fpaUyYCkVYbbotdcmZPjp2NVXq3HG3hkInitEEF4fqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb4NYkI7BS4ZvdhYr6kpxg0LSpARNZDrO5K8MFpVLkjPDFFAfsczLrXWLZ1O8ZZlB5OsmfPRUkiZV/alfcrFfmLg2Wz+Vt1gmYREYiulnRWyITzOPM40bsDEnjtF35rKRdJ2OXKRttXvSqvCZglJ8UppV6+sEZJXZPqLEYWsJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N58ZWjrG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30b83290b7bso50180791fa.1;
        Mon, 24 Mar 2025 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855233; x=1743460033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddSVp+ypiMhRSFA7o3CYe6V+kLZUWGKWiTmxzUfHGXg=;
        b=N58ZWjrG1T3PCROdYu7xn+gCqyJhXlCn75nKGTFUWBX1hu2Dub14OgrsUheD/9rDvC
         QkjDbH9+mPA31AyQXvqoHmpTKGUCQiw5BVcIpqJAcLUmpc2gPpiMVezi2kDJPpny7stF
         l35poRLDLiGCfkaflwEQpHnqLITXRbiS3Io2IT52yTFYUfA+/NPohwetsRQ3/7lVjutl
         YrwdVyvWD20Fxp5e9tTXMIvmXvXmN1VxpUOuWudGidXefKl+wVpZtTr/ER+Ri65Gnnqz
         ioSF7TyldLvnXCyIJQmjubf6UA0OzgUjK0cfdJCGdv9UWvvWry2umfpKty7vdpsjfBcY
         vc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855233; x=1743460033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddSVp+ypiMhRSFA7o3CYe6V+kLZUWGKWiTmxzUfHGXg=;
        b=hQJRZzb/GbCTyirvRtG3HJCsK3ljq9R3SR+RgAPhnTlgkbijO/rocG1hSiLDD4BQUS
         v7/XvUuHJWUAjFRaMDqTFJCvxkPbWG5i+MXuQAW7ve9fMeMHj9sstZCeUmUudt769A7n
         orGBdzCqSuv2QMZFE7Ee/785fYRchGRZLDSZvnb6Qe8y4UUjVVubZ2meKlLPC2Pc3UaY
         RV/6H+w+Go3ssPnI9hU5Rbf6s6I/pgrv9ZSfhkouNqnTQISI04PXvuA2XKK+dz9Pj23K
         5D/0GqXbdYY86HUB5iS3w9oCL/cygRb5Yc0ND2GN3ViGSP6cAQ+Fp+6yyCjEdK5pHBTL
         vkZw==
X-Forwarded-Encrypted: i=1; AJvYcCUj4zeAlsBtm+3zXBULFIF8NHcsgMA+w+59pMb7zHgm3vEdN9eyiYzOsgbtQTPLXSm5hR/QByoGQNw1ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIWccKu/K0ilBC3gIx1GV36v53GFfT+68GzitujvqaCKu7Yhn
	7KOdN3u9qgwW2H8m6PTtMlz3SuojRMJ7v8b2DPsXBfJCyDwffn4oUlc4jTbVdf8=
X-Gm-Gg: ASbGncst2HGRRWdENOvc6D2XvZaPz4lBV8SuTamNLbWkDP3vtzHOFt2n7uzpGfEsHzr
	2iFaYYeE0PU8XqsaBhll6Qqaq+QKTQrVc5KO6NtNHPReMfSVmzBtaxnZRWXE+duIfov8rwLrlIu
	upSlf4seyKa+1I3TDhkiPl4caDvhNFxQpAfyYYbA0F58P9D3uehxMbpFBeWwvT+/rR88ObQuqQO
	jIrEJQkF4k3aWggL4bDzhiLrMWMhTpoXvysOCLo5kQt4pq1XmpzIDFBSC/7eZEfpTDyQXTxNHmZ
	yzUYa3739LBmI9I+bD83yhuIAPnSMLs1Ggk6j2EyRIS+tKsBdCianEmoEQKiu9Xn6uJBC4tx/Hc
	kr5sIrI9+HDhOAfMvqeihFQ==
X-Google-Smtp-Source: AGHT+IEGYMFQ3M/FEyaGKhYSMRlIUVeZKU/8wqdm9uGRP96xzgSkRDjIjMLvacdDAcg7dOYvuMdR+g==
X-Received: by 2002:a05:651c:4cb:b0:30b:f924:3565 with SMTP id 38308e7fff4ca-30d7e32e98bmr52257461fa.37.1742855232742;
        Mon, 24 Mar 2025 15:27:12 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:12 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: richard.henderson@linaro.org,
	mattst88@gmail.com,
	arnd@arndb.de,
	paulmck@kernel.org,
	glaubitz@physik.fu-berlin.de,
	macro@redhat.com,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 2/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:34 +0100
Message-ID: <20250324222643.32085-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250324222643.32085-1-linmag7@gmail.com>
References: <20250324222643.32085-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Install handlers for processing logout frames from SRM
console on the tsunami platform.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/sys_dp264.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index 9fb445d7dca5..bb1f5f05825b 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -34,7 +34,7 @@
 #include "irq_impl.h"
 #include "pci_impl.h"
 #include "machvec_impl.h"
-
+#include "err_impl.h"
 
 /* Note mask bit is true for ENABLED irqs.  */
 static unsigned long cached_irq_mask;
@@ -282,6 +282,15 @@ dp264_init_irq(void)
 	init_i8259a_irqs();
 	init_tsunami_irqs(&dp264_irq_type, 16, 47);
 }
+static void __init
+tsunami_late_init(void)
+{
+	tsunami_register_error_handlers();
+	/*
+	 * Check if the console left us any error logs.
+	 */
+	cdl_check_console_data_log();
+}
 
 static void __init
 clipper_init_irq(void)
@@ -521,6 +530,12 @@ monet_init_pci(void)
 static void __init
 clipper_init_pci(void)
 {
+/*
+ * This isn't really the right place, but there's some init
+ * that needs to be done after everything is basically up.
+ */
+	tsunami_late_init();
+
 	common_init_pci();
 	locate_and_init_vga(NULL);
 }
-- 
2.45.3


