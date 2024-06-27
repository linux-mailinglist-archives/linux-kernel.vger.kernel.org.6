Return-Path: <linux-kernel+bounces-232822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3EB91AEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2401C23097
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D519AD49;
	Thu, 27 Jun 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="AyQ9Xcwd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352519A2BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511214; cv=none; b=W504AcZog/lke3JO3V62xahSt0iaoFlcT163siuqoXOvE/vM6hSuHKFW5FrDkDgnMKvHgUimPegr6scNBYMj0mId7aLIbBFAO8fLy8mhiYXyxNwb2+NpEOXMonWXtea9NA14Mx9eahms6lFq4Ti7ltkG+ALe18T/zQY0g4UdhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511214; c=relaxed/simple;
	bh=mBDSfGw/GZHKX3ZupvSkH4E92c/bKaohuOPzugJPyD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP+0FXGx4yKMt/7Uxz4OmK34/MN3h+MQ2LnhU+Mqs9pPFsZG8ZCSmmQoXWpMCuzvTSd+LMTM9YXs7JLljzBey4E5qm6gGyjL7bn2VXPa8CVVvprlFiBgsl7n7FgFbIDkCurCd2D9cnomGnxmiodlBvRz0yIoBskGxNdpguOp9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=AyQ9Xcwd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70673c32118so4058755b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719511212; x=1720116012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItlPUnSvus72i750gw994VRrzxx6DngH2RkQqxVGs8Q=;
        b=AyQ9Xcwd8Zj7E2Pd7ncPLVGeCOaZt0gWItohGDzTgDRTE14qzYQK94UIExgV3wRGjT
         4Ue0VuQvVwrnLNpqU9lbEWQTDLyXsAAruBkb6UNKdsV3LM5mG0yemwp+2ymLm/+nRUT6
         gp8oMRQWJxNc0t2gUhMeNuuKU/8E5gKzN1TZBgROMMEefMr29cKS6WV5Na0yUlbEv/jD
         c2AQ3Qa5+dTJ61g6S9lIgY+ewrmWhGTOki1Pj91DYDUWXW2IZ9hxdHcENt1wKzV+g79/
         7EXPT97FO3602pDZVt6WfKor2RN4gHP3qHRUMxQrSrPTxufQPXm+7OC5RkDjb8GMyaVS
         d52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719511212; x=1720116012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItlPUnSvus72i750gw994VRrzxx6DngH2RkQqxVGs8Q=;
        b=CzEr13Xiuqc7MjLeiUe6feFPY490KFLVdBqUdiXsOpQAbksubkKKx41puSP0pARhK6
         zxMnsV2pGm9DpCIhMRp+t5FSHEdtdofscuhexuVF54XJHvVocSUUXPshEqrWIM6pAwr5
         9cmfatlQ6aMcd0JDsneO/cR45xDyrKBI3TYzYFYEzuGvezx0wknC20JMURxZUC013dly
         yKjTBu7LxZIV4QZiFnodFtKhh1mqPeWIAJVlRnDt9Keelwt7DQxcBJ88pjtVCvk8/KlJ
         ZOLJahEPCBQzhZqFkQIGJVgOZNkisTUcoloO9+k8TbFAGlyaiXOVpX1NNiaw/TXsYdlC
         6RYw==
X-Forwarded-Encrypted: i=1; AJvYcCXw4x+hXn8W9dQXDYcCqNFXpU6RxrGOSM1U+OnFc+pGAQ2H3lQNdu+qZxRoYGS0Ag8zrkAPEjywdWHFiQGNFAxOGYWUTQ2GGbybQQEA
X-Gm-Message-State: AOJu0Yw+RG3m5We3CQoVF6QGqUjaApms1Jsr1aKL+ylSsPnPWA4Yw2rx
	Ll98vZR+t2Gn/uYQ3h1e5/Op2q1Txqzf+8LQ1vvDJM+AyJoOsIAVLlOzzC4fOEOhpb+NvEDRn2D
	yKg==
X-Google-Smtp-Source: AGHT+IESjooPdGd4R6XKtPhPeyt2QG2/mENVza+Wy5xrhF/fH7VOJlp0YoLUOLgDIN+gvqfSIu+Aeg==
X-Received: by 2002:a05:6a00:26c5:b0:706:4304:3047 with SMTP id d2e1a72fcca58-706746fb433mr11797648b3a.32.1719511212095;
        Thu, 27 Jun 2024 11:00:12 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a352c0sm1718018b3a.171.2024.06.27.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:00:11 -0700 (PDT)
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
Subject: [PATCH 2/2] drm: panel-orientation-quirks: Add labels for both Valve Steam Deck revisions
Date: Thu, 27 Jun 2024 10:59:47 -0700
Message-ID: <20240627175947.65513-3-mattschwartz@gwu.edu>
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

This accounts for the existence of two Steam Deck revisions 
instead of a single revision

Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index ac8319d38e37..3f84d7527793 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -420,14 +420,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
 		},
 		.driver_data = (void *)&lcd1280x1920_rightside_up,
-	}, {	/* Valve Steam Deck */
+	}, {	/* Valve Steam Deck (Jupiter) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* Valve Steam Deck */
+	}, {	/* Valve Steam Deck (Galileo) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
-- 
2.45.2


