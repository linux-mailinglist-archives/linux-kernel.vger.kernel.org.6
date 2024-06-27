Return-Path: <linux-kernel+bounces-232952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88191B06B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971B9285B72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B219E7E5;
	Thu, 27 Jun 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="CFacRNKC"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48F195398
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520297; cv=none; b=SFYf0eYg0l3QDDnsH59gTAxikfWdXsjY/LNCG/zJE7cqsiPUx1tFFmHR/f22qrfbY8608a1ooqyiFEAJ0PdWw40lzw/rKGgSrPbEj3sQllk23HjlH/s7QmABZTaxZtjqNzA+ywSodJDmH6v83r5iDAI5MdwOyUzz4rOXv2PBNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520297; c=relaxed/simple;
	bh=qGmZ54javUBer9i48bf17GmuVyc0Ot8E5Nz9k8mzUBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giNzIYfM9Sd+LhSLCV9dJnPPGiWI9swUtBZu/fAr7u/P6vB8vsEOArnuZrUnQfHGBov9awmWtEC0G737YAVi2tyWjy1/0GsDRUI63no/Cccibmhl5VDX6jRycZug+O/+9uNeB4VpxOXKgNnEITR0At9DfZTMsugexfyfFkbvG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=CFacRNKC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so6143605a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719520295; x=1720125095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puKEntbYEmMEidhzP0NA7FT52xgsmmmBOCRFF0y7bVk=;
        b=CFacRNKCRfZuZHMR8Q+4iy5B1s4aMW4wlIIg/n1OASz/FqI87B7PZ0YIhzqHgVBBr9
         Wv0DK2iKmz0HoWvOfF1TeTZtux92pLHikPfu8w59g4mBYAredcbb7Rh4s0LZGQ7TKL8H
         P2K/TI1GANH9AotNjas17fw24UHvgRXhNc7Jrzx7/IG3ECObayeoYqCvjkDTGwcS9kZi
         e/4FI2eHs2zJLC4RQrDPUYy/6K3dOIVZ3XUX0ST02Hu35X11n1yGqbJI8LE1EmJ68IDQ
         7nwyKHQTaGBsW6XwCFNd2NXsiWFcVC41/8h09LYMSf/skNZArTMPJoYaVVLoRIdQFPI7
         vE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520295; x=1720125095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puKEntbYEmMEidhzP0NA7FT52xgsmmmBOCRFF0y7bVk=;
        b=qk3oBYUgDvzkBqZivI5AeAvuLq1AakipEFNuysJgMLqZoQ0vWmsgmrPZsnlmXvQpUs
         QVSPwarGsZGtvKkWcTRzb/W1LIdkCJ67pJY7ONggGFzBN/rRjUT3d6SNdcMboKSSf5r2
         b8NLYmzWmx+Qu6gq5uEK2KE77HblHQR3umIk7Ii5Xt56I7nJy5RCdLhBKX2b/4hMGj82
         +WrWt869m+AVB+TeptZXtkoS+0xfudVLuLtS2SQF2zTEmuZNMMUHyJOj/Uy7uYcrHcX1
         QeUCwo7onKIKS6+9CXv+KWn37p6GQ4mUoMvVwdqvIUfFiWIJRrUuLizkLQlxUzTFlZ+s
         s+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn1hQQORT4aLbVw19pYzYsLT/kM5CnLVVJoIiQts+CDeJbJGu1LJqQVz074HCC1e+AFAs4hrzGbO/rCRnklIk9gj1nZwGYF4p0mBjn
X-Gm-Message-State: AOJu0Yz4g5lnDfPi/6tskBexvpzYnIdrWJ+ZV9R0+rCMgvyveP6utHPr
	J4P5azlcey0F6QR+59sxbPm0Qad34Glgr5oeQsa24sGE8umCLul040l7nrfTpA==
X-Google-Smtp-Source: AGHT+IH4yJEM2wH6Qd0uhyZ3YRcR+RRXG2M0fbCW7SjsmuVY0ysvtcnP0gO0nNFo9Kngj7OGCtFLAg==
X-Received: by 2002:a05:6a20:c481:b0:1bd:2a48:2340 with SMTP id adf61e73a8af0-1bd2a482929mr5734664637.61.1719520294993;
        Thu, 27 Jun 2024 13:31:34 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63250sm140514b3a.29.2024.06.27.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:34 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm: panel-orientation-quirks: Add quirk for Valve Galileo
Date: Thu, 27 Jun 2024 13:30:56 -0700
Message-ID: <20240627203057.127034-2-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627203057.127034-1-mattschwartz@gwu.edu>
References: <20240627203057.127034-1-mattschwartz@gwu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Schoenick <johns@valvesoftware.com>

Valve's Steam Deck Galileo revision has a 800x1280 OLED panel

Suggested-by: John Schoenick <johns@valvesoftware.com>
Link: https://gitlab.com/evlaV/linux-integration/-/commit/d2522d8bf88b35a8cf6978afbbd55c80d2d53f4f
Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
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


