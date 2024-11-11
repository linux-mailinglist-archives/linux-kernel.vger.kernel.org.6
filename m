Return-Path: <linux-kernel+bounces-404553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB69C450C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA1E1F25416
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD81AA79A;
	Mon, 11 Nov 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcTnxx6t"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D042A87;
	Mon, 11 Nov 2024 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350140; cv=none; b=F3c1IYkhmU0rOtqMhsAF+Zixu1X6NbJJvgjlVw0PKiWsjtgrFlHlaFZhXOUQywWNx3L7VJROxww8Cqi8RxIA5sDwNDe0hMXj+tyJFr4rj8jyiZPv98rH0Kxn7+lFxtFhjDIqCimCmXUiUkHGJey3eu3SsCG7SumqNoVrHFnZGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350140; c=relaxed/simple;
	bh=qyqmzcAlV/qU/gs1YCXoIR/oEsuJpUJ02rP8Oa49I3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnnlpuserUQ9KGoPguOlBzDgz2KSEzSByckJmjJMtUXqpjOs2sVDIPKiOjbrfsNrrMBQkj8kbd/Z4McQZeMzhIf23iu0Kz6404WW+qg/ja2d30bQqkt1H8YxiIpBHj7JSyBtPlVSwQQVOkNk/8DvW6xcb1ETgRRH3FP45MOi1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcTnxx6t; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720d01caa66so4507210b3a.2;
        Mon, 11 Nov 2024 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350138; x=1731954938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IH3L7vfz84/AAdgY9zkGi3PamyVUn0pY3KRZfJhanY=;
        b=JcTnxx6tQEp9iaPsJPbWj10gyqXcnQA0X9Z65qf5MvZn5rOAOimljw8cb015d4ZHYd
         OovpDjY2i322q6hkmqbzF89eXBGPhcvS74DkRbjoorw6DGpufe5JdXP5eYR0YE9HQQjq
         dkTui4YA/+3v1MBIqknWqhhimp2qvg8gvOLgxRAr9t/iHlpd0uv/zgJiSpiCUGGgYjBR
         yMrs7iCFndOflpwgX/oXI0yE/GvCxNyiWKSw147cfitdByECnr9I8zy5CG+lg/laU0lA
         WZILFbpZZQbF5SGZK75egRqTmgMX+cmY+iqi/ApmtCPFpQVKa0qupUKPr9JILudJTON8
         0pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350138; x=1731954938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IH3L7vfz84/AAdgY9zkGi3PamyVUn0pY3KRZfJhanY=;
        b=nJ5WleVIMOhv0EqTlVZU6G+ntqNWclEat+KXBzt95jDrYuzr6gcHhGTy1v4THR/jv9
         Lz0Ydu9845BsoHUK5AQZDHwLY8lzgtqMr+s8NsRBe0TKESQOMHXrgOoKzHQH8Gp8N3m4
         x2eG5O2B2gftcn7mvShgPFYixDfn6W0fw6uUkHRJAW9hLPG6Jgl6Qo+dvMD0bxmDj240
         i/Ucezwj0CQMcpCS1QvR323fneg2NRQz606NhlQgxuDCreclPGdG3Kmga6K/gUX+6kP1
         0XrKsazEAYBbJQzEw7SW0PJy99Yj1lDdlBA4EzhHRVpBC7mVKcEmcoWQWWmRPbymi0th
         m/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkUiGiI/KgZ5TTgba6Y0JbR3Xokg/D7LZL7cEz0d7FHi1WK8jgme4JjvEWktX9UAd+v6rp6ZV1vcbAjQARRklou+7uZQ==@vger.kernel.org, AJvYcCVKyiVCmFgCyXAa3wULVRPzuomPnJJkdKqM8uUPXNN43qsGXTqHobX9UIET56p1/auswF4J5QXcGekk74o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKw9u+wXJ4KaLQDM4goVSB/bG3c6gg94hzBfNuiIf/OHg6J+n
	m/j/gEebEet3btoz57wOrfjB9uGmEwWOU8BD7XTHFvWxsBAQbuEnxmqliuAX
X-Google-Smtp-Source: AGHT+IFrfuSVWF6DRA/DPq7pG6u1Mh3tou2LR1cZ07CaKiCzVI2+LS71JcVDGIpPlEPB7qAFXp5KSA==
X-Received: by 2002:a05:6a21:8cca:b0:1db:df7b:471a with SMTP id adf61e73a8af0-1dc22b9162amr20555970637.43.1731350138124;
        Mon, 11 Nov 2024 10:35:38 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5b48c6sm8818616a12.18.2024.11.11.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:35:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	w_armin@gmx.de,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 1/5] alienware-wmi: order alienware_quirks[] alphabetically
Date: Mon, 11 Nov 2024 15:35:20 -0300
Message-ID: <20241111183520.14573-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111183308.14081-3-kuurtb@gmail.com>
References: <20241111183308.14081-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alienware_quirks[] entries are now ordered alphabetically

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 52 +++++++++++------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index a800c28bb4d5..bcc80ca8861c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -206,75 +206,75 @@ static int __init dmi_matched(const struct dmi_system_id *dmi)
 static const struct dmi_system_id alienware_quirks[] __initconst = {
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware X51 R3",
+		.ident = "Alienware ASM100",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
 		},
-		.driver_data = &quirk_x51_r3,
+		.driver_data = &quirk_asm100,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware X51 R2",
+		.ident = "Alienware ASM200",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
 		},
-		.driver_data = &quirk_x51_r1_r2,
+		.driver_data = &quirk_asm200,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware X51 R1",
+		.ident = "Alienware ASM201",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
 		},
-		.driver_data = &quirk_x51_r1_r2,
+		.driver_data = &quirk_asm201,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware ASM100",
+		.ident = "Alienware x15 R1",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1"),
 		},
-		.driver_data = &quirk_asm100,
+		.driver_data = &quirk_x_series,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware ASM200",
+		.ident = "Alienware X51 R1",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
 		},
-		.driver_data = &quirk_asm200,
+		.driver_data = &quirk_x51_r1_r2,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware ASM201",
+		.ident = "Alienware X51 R2",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
 		},
-		.driver_data = &quirk_asm201,
+		.driver_data = &quirk_x51_r1_r2,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Dell Inc. Inspiron 5675",
+		.ident = "Alienware X51 R3",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
 		},
-		.driver_data = &quirk_inspiron5675,
+		.driver_data = &quirk_x51_r3,
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Alienware x15 R1",
+		.ident = "Dell Inc. Inspiron 5675",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
 		},
-		.driver_data = &quirk_x_series,
+		.driver_data = &quirk_inspiron5675,
 	},
 	{}
 };
-- 
2.47.0


