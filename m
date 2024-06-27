Return-Path: <linux-kernel+bounces-232821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EED91AEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849F01F222C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4919AA6F;
	Thu, 27 Jun 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="B8oTANzn"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B039AE3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511214; cv=none; b=P3yE8e1E9htfMvqBJykj8DzGgfucw+ksloNO4NjwB6ce1++4nEOvxr3dIOivBzIUewBefyqkdeH072qcBq97gjImEgLQGxeoQcBVEUPnXi9YXfMF1/WGN6b5GpBWYcRuv8SBd5veCzEWvTQ72+coKYyI/Nvl5xQTB+oF5O6jBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511214; c=relaxed/simple;
	bh=uxJobc5X55vbuAJrHT9v2GBEjFzrLbPm+JWr6rwIHfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByV+GSc/H6Grg/GwsTPnm+1sHKB2MmNE/SaUAYVUQ+3OEhPOFUzMaU+sC1jxbwAWBPENWOTLCVAw50P033oRMikKdeW2boUNv5U6Sg0yljxWc0wfYo3x8PG8BW/bWiGUcbC96S+zxbemT0USaJdtTgn4dPooCWHEw40f9OnJ9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=B8oTANzn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7067435d376so1558057b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719511211; x=1720116011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT0amGwlyAC8k8Kw/r8wtgGR1gR7pflMV02NL/G058g=;
        b=B8oTANznzefRy9Mz2ESLxwoqps0GXRZmRWxOTi9QSJncUU/3M1hjHV0T5UgKOHfQkw
         iX1PZQq+R9S7ukUheviPKv3tA7XTG9t9Zm668PqUZIJo8aknDeyVXE7PJyQLNZSZK1Ij
         dQitYGY0Mel1C3NikS5Yi884JU0YMXJG3pTL15HYKbhVbFKhzz7u7AZb2fniJPGhCFc8
         fVMlheM7cYaV1RaF0UoSk/uClftGT572AXZ/lNM5hSV9e+zL7ojm6eI88Xf5FMKRelgL
         h8oPUXVZI3/Vbl8R+WggxS8bqlSZxllItqItFFW8CnWhYYIaau5L5uowoPdF/QUM9DZb
         0ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719511211; x=1720116011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT0amGwlyAC8k8Kw/r8wtgGR1gR7pflMV02NL/G058g=;
        b=brkEX9ioCzlnT0b+5/J+BXDSwTHWHrjxOuPZWENV7aneaCbn3GEUT/p0eL/yoIxMxv
         KB+7fNTxrArHcbDeSb5LJN3S0ou/yTcBKvYX5QTzKOS6T4NVYeS8Zb0tdfSMJEPSHXaQ
         GnUFD/eJAGIcihXa6tOJKrtlHOQunHVlrVNRuP6F+afvYXJeo6tNqSLyXTibNzpvMd1I
         F3XpnVrpdDORHE28XG8WYCOyBGkFV4TBqk+rmEeWDBx6XJPWrZwlpfSe7PZuTtbl29RZ
         fR16RB7VaspU4DwBETKGJxUnmN6g6G57q8H4kb1HPOSbV1JmfJKCNOHhliwyIM5K4M8H
         bELQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGGP8xSObCzYU60XXJdjN5n/mOh40V8ofI2UNhOzCageuzHP7/TNeQEob34iP3GwZOPjpeqbfzZQlkpRYcmC0fLWhUoys4wQbCag6t
X-Gm-Message-State: AOJu0Yytd0Kl5jkgi/N4+J0tuW7pyi0K+OhlCv8UpyQBd29r+pJ1nKDL
	nyQU3p9q7ma9Hr2gyCxxu3BcWnvEhgS9NU5J4TrbyDUSOIrtR7aEAYO8riS+Og==
X-Google-Smtp-Source: AGHT+IEVZbegkTkHIwCs4fEpExpIBikkAoMtG1beygbZS81J9sVcWUApDU7aKdJw9eeYpy34AsB93g==
X-Received: by 2002:a05:6a21:6d9e:b0:1be:c41d:b6b7 with SMTP id adf61e73a8af0-1bec41de2acmr7026768637.19.1719511210927;
        Thu, 27 Jun 2024 11:00:10 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a352c0sm1718018b3a.171.2024.06.27.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:00:10 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: John Schoenick <johns@valvesoftware.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <mattschwartz@gwu.edu>
Subject: [PATCH 1/2] drm: panel-orientation-quirks: Add quirk for Valve Galileo
Date: Thu, 27 Jun 2024 10:59:46 -0700
Message-ID: <20240627175947.65513-2-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627175947.65513-1-mattschwartz@gwu.edu>
References: <20240627175947.65513-1-mattschwartz@gwu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Schoenick <johns@valvesoftware.com>

Valve's Steam Deck Galileo revision has a 800x1280 OLED panel

Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
Suggested-by: Matthew Schwartz <mattschwartz@gwu.edu>
Link: https://gitlab.com/evlaV/linux-integration/-/commit/d2522d8bf88b35a8cf6978afbbd55c80d2d53f4f
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3d127127e7cb..ac8319d38e37 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -427,6 +427,13 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* Valve Steam Deck */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* VIOS LTH17 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
-- 
2.45.2


