Return-Path: <linux-kernel+bounces-383486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAB9B1C66
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A041C20B39
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154378C9D;
	Sun, 27 Oct 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF+rboRA"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE77346D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015490; cv=none; b=jCN70oKAs3e22kAoZ1oDOfNMnQ0I4hYMEC/d8Sw5qpaQz9hsdMbAViNSiP5/qgDiz4pOZEtjBMAMC+k16AbbbIjL5rnTebjKTAICSjO3VpUF8ak1fFz8TGux8aYESTFW7QjJpFrOe+BPHCwGIJ+J2B2+YeEcDQCm6KObjshjMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015490; c=relaxed/simple;
	bh=nhIxyCQYfb/pjLbh6iu5zVWZFBHtkKHs0QJxP7HhhyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFgEI7GIzRduFtmF/yYdwETerMR9LI6KXDc/mR+v3d5B7HGvn/97yqJ/wDHr9Atib1ATNNPfthOGi3n5jjLiUsTqdVA86Gt21DvNx76Gnpi3KeFfq94Wl3sbjAHOcXTk1YUQ5mBCFvPy+yyKdSLyiYXfvuw1W7Kt9wgkngTAVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF+rboRA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so2113466a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015487; x=1730620287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzgoY73OAH7IN4I8JIVtQ+45LcH7GhgBHjlXlGpHvfY=;
        b=dF+rboRAtAsVBu386RjRmSPB4D3dwt6iLw2w2ZLNSvITwHmMjy2BGeUE2wBeGi/ACf
         5g6hJPw/R3b4h4J8aPZpla49XN5PKv/e74o17HdbB3l/nl3c6LSfri3/KLZco4VK3uAM
         /hDxywfACupnrw7QJpDEqYCvDGAVy6wiC12PBf9Kg3w5iofvZYZ9tlqjM7KLThyzuJa1
         o6a11+WHyTkbHAK+EFSTa8DwuRkeNNN3f3jGE70IySrABm6Eabsi5vieJSj4HEBa8tLV
         UpqFAbMER6wGHrGZgKUZXLyBa4x4rCG+4A/yymuS2LvfRLgScz2d3OXZndUOuDFM5gmu
         2BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015487; x=1730620287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzgoY73OAH7IN4I8JIVtQ+45LcH7GhgBHjlXlGpHvfY=;
        b=qNJF4UtJJoXgxQIB6akP8tyK9vwFmTJ2IXLs/AsA6SBSwMdeKjkaZU1XT+Y6zPX3Yv
         mGgbZJdSuLPUZsc6PubPJK1amZBT+f1O+D0YeWFjOQi0rxIHPZw91GpPEFSV07yNY3KB
         Au6uMDBpQWNjGK/BJ0EZpLwlLaplCqiBi6JqD/jJaatzsJPChxdB8WhmNobC1tTk7dls
         n5F6HO+eHvLiQ2wxqrdHyPbjRcVbkC766jsPEoC8yEYVJHSKc/IQn4bJyu++rczIjYFL
         7HMwtvTsjfTbQ8gsMQDmamg7X3cVSR+sYYUrJYTPs13/592OSiUbf6Kw9gFA7CFaytgA
         GQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUsnN73WMUqEX23grCcoPooBjcCWJ4smflplRwK+GzjPq+aU+LSp4PKaaLh4sRRuX6XBVNd361r4yi4qV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7tA6XPb0nyc8AjEMANfAzIFKzURzOCGzwqXvXqCZnSQVGPCd
	NsqKHoOft+ejrfucTp7/BF1xtqEP6dThIgpKMEQ1VSfq0LuLqTWt6I92Wm5bC0I=
X-Google-Smtp-Source: AGHT+IFIvv3jnR4vgZY784qrPZUlPI3xPYuwCE5+QmhB3umvWUCbhT9ijcuc5ukibYVcOx+Qde/7kQ==
X-Received: by 2002:a05:6a21:1193:b0:1d9:61:e779 with SMTP id adf61e73a8af0-1d9a83ab127mr6572670637.4.1730015487264;
        Sun, 27 Oct 2024 00:51:27 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f9a1sm3785551b3a.90.2024.10.27.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:51:26 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com
Cc: skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/edid: convert drm_parse_microsoft_vsdb to use struct cea_db *
Date: Sun, 27 Oct 2024 13:21:06 +0530
Message-ID: <20241027075108.14273-4-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
References: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the following
	FIXME: convert parsers to use struct cea_db
in the parser drm_parse_microsoft_vsdb

cea_db contains len and then data. Appropriately change the indices
when referring to individual elements (db[n] becomes data[n-1]).

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index f79d8fbdb62b..e2ef07d00aaf 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6361,11 +6361,12 @@ drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const struct cea_db *
  * https://docs.microsoft.com/en-us/windows-hardware/drivers/display/specialized-monitors-edid-extension
  */
 static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
-				     const u8 *db)
+				     const struct cea_db *db)
 {
 	struct drm_display_info *info = &connector->display_info;
-	u8 version = db[4];
-	bool desktop_usage = db[5] & BIT(6);
+	const u8 *data = cea_db_data(db);
+	u8 version = data[3];
+	bool desktop_usage = data[4] & BIT(6);
 
 	/* Version 1 and 2 for HMDs, version 3 flags desktop usage explicitly */
 	if (version == 1 || version == 2 || (version == 3 && !desktop_usage))
@@ -6373,7 +6374,7 @@ static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
 
 	drm_dbg_kms(connector->dev,
 		    "[CONNECTOR:%d:%s] HMD or specialized display VSDB version %u: 0x%02x\n",
-		    connector->base.id, connector->name, version, db[5]);
+		    connector->base.id, connector->name, version, data[4]);
 }
 
 static void drm_parse_cea_ext(struct drm_connector *connector,
@@ -6423,7 +6424,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			 cea_db_is_hdmi_forum_scdb(db))
 			drm_parse_hdmi_forum_scds(connector, db);
 		else if (cea_db_is_microsoft_vsdb(db))
-			drm_parse_microsoft_vsdb(connector, data);
+			drm_parse_microsoft_vsdb(connector, db);
 		else if (cea_db_is_y420cmdb(db))
 			parse_cta_y420cmdb(connector, db, &y420cmdb_map);
 		else if (cea_db_is_y420vdb(db))
-- 
2.47.0


