Return-Path: <linux-kernel+bounces-264566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC993E526
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CAA1C21233
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E94F8A0;
	Sun, 28 Jul 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laBg1dpN"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256139FCE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170871; cv=none; b=bHQZ1zKjF7RxQbsLE+JGrffQ1iftxtanDpOEHtQ5umP7oEhiox2XqWE/Mzy9oFNK8H31h6mx07GXRaOl9k5AdBa/eXQr0oWsBmxOlfa8g7R7KJT5EVTi9ys9Jgb3O1TbSVs1C/D48qCslHsKU5D2XmfNjkE72Kvo37KpAKkH/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170871; c=relaxed/simple;
	bh=ccXnvq3Imvb8PKdgiIK7mQZ/PQ1cStfF0UBgdXum7Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnFVmYXxs7Ufak4+TlsO4b2DVR4xwmBQf5pEXqsQ7S0Nysk8KfJq81DJUoGywlkfFeg+857jpvnSsWPvi2RWy1D+AFpdHSS577E9x5qaSGbyYd6dlM8w3Y/+RRe+6aG6kKHzH67J6N4qFWlHOAJGbp4yixN+YdDkLNA5V+FS3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laBg1dpN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aada2358fso511318166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722170868; x=1722775668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPVGTGuK2/ZvoBHgwOxrrL/epZwrZeql038/zY8F5Uw=;
        b=laBg1dpNMmilTgri8o2Zpwn5x+a42hLF0UPLvr0A2h7YSWQ4/IebQsQ1DuidChxLZY
         GgMkn+tsI/VlguqYEe3/ZIAPeJ74IfWkJ2aQItRtxX1wyPpwMTGkwDbJdeaLEEmQ+YRw
         ifurF9IpkODP6d/PFOtrlECoPhV4k5RDg2hnivbjpvxPOfjL0HIz+ZiQUNugNpZcrOE7
         ZebFYyrNFkgFsmP+/cDb1ZQAb0XoAO0ntjKZrJo5zOVDnGWPKlC2RmPnh3W0F3xevzIw
         dKjmARwjYiGHUA4cG8CMBBwjEwlyeUwmzqntFLUTd53klLKVDGpfu3d87due1xwuT4VL
         GUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722170868; x=1722775668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPVGTGuK2/ZvoBHgwOxrrL/epZwrZeql038/zY8F5Uw=;
        b=KYAzpXq2Uzt3Je8xDUbatTYs43eifOvEeS7jGuphyoQmoAWAdwvyzvT4NhAtuAFDGT
         V9ibzIQ6VXfCPjc3d6E1ZFQRD6kCmgynBVxf2d9pQB4V7kT1O4NOIMhq2fvbkJXq68Rs
         gLtzWSHep/67NFZ7KbmClGSbTTNP2BWZjPYYbcrGas5Pqg+Il2yQvwJZLehweX92GYg2
         rXmw+2vAnUlt7emGcb/TRMYCgmCB4Ady+nFEE4YzyI7nn+qTHuzA/742PI6dWxOQ1guZ
         A7oIeeWAFh1Ei7RU8AWksFcHPEcxU6cO7U96wY5ztw9BmJkOJ1ylCPITMdBthkoYRtQp
         oMyg==
X-Forwarded-Encrypted: i=1; AJvYcCWCl6sKiOmr0B4pVg1PD4vt0XTLV0d2eL1oIiHJx7+UL9B3w/qARhRc0jLBpdatJx2DHgMfoKTqSEJ5NceQJJZlartJbPleZZFSisBC
X-Gm-Message-State: AOJu0YyjQiOoAzoV8V4OjjjFQK3LsO3A41oouSwLldw+rCoY5gVbCs4Q
	QnMTMh2WrhyKHDW1j1Yy4q2Od+nQeBhQCT/9cCXaSjKKa22/aJas
X-Google-Smtp-Source: AGHT+IEgFpT12RM1VUvndjc/bes+AYGvqugA9b2iz8T7vCrVIESZJ353xthOLr7iIs0PW5VsXdj3xg==
X-Received: by 2002:a17:906:bc24:b0:a7a:1c7b:dc17 with SMTP id a640c23a62f3a-a7d3fa0ab43mr461386366b.22.1722170868461;
        Sun, 28 Jul 2024 05:47:48 -0700 (PDT)
Received: from Slimbook.lan (134-248-201-31.ftth.glasoperator.nl. [31.201.248.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9d3cbsm381125166b.182.2024.07.28.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 05:47:48 -0700 (PDT)
From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	hdegoede@redhat.com
Cc: mripard@kernel.org,
	luke@ljones.dev,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Subject: [PATCH RESEND 1/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date: Sun, 28 Jul 2024 14:47:30 +0200
Message-ID: <20240728124731.168452-2-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240728124731.168452-1-boukehaarsma23@gmail.com>
References: <20240728124731.168452-1-boukehaarsma23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add quirk orientation for the Ayn Loki Zero.

This also has been tested/used by the JELOS team.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index c16c7678237e..a1dfeaae644d 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.45.2


