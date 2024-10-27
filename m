Return-Path: <linux-kernel+bounces-383487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E011B9B1C67
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78B21C20974
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFBB217F3B;
	Sun, 27 Oct 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a747LVY5"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2657DA88
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015493; cv=none; b=pRdN/VwZDp0JXzUQZxxbJZsalyK87GzDKB5zg2t3zaZn9HUHGTeKIipRUo0+/u7CVZ8qFXo8D51hIPNhCUsHUhI26HBBc2DyXma9k10vNzD5hsZAFXrHf7t4O1mMi+0QWnnoGlaxWSDJk7A/2/DWCKsZdyHMzUycuNcAHVlT2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015493; c=relaxed/simple;
	bh=UUC8cC3TAMgwQ1yjoC8b/V5qpSb9de4BBZikaAxoqn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3gRGmJbmujSxWaN+tmZHjzFFAnAbNT+jfAxhZfNkuCJQRscaU6blCIaKlgAbClWsvMm331pcsxMFRfimrz0e8zDRcwVRyDWd+lp6mniefQ4jtsq2+oZKsfYb71SFFChDJT4K264G9Tpkwn3DeHxmJpQ59YiZyHbSg4ooIw4Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a747LVY5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cdb889222so30666185ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015491; x=1730620291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95caNnI7hgOLxEqas86hhjYPjq4p60okYGlZe1W9+VQ=;
        b=a747LVY5VzdvPurx0+fmJK56R/UOOVS72/R5Vei2zVmzPJ/HE/gpkkfoW0laBbZ9/q
         Q5ac2JsL8Ic/vO89PnTukxSRZWddG+fHQnufSzTcaJzSvOT8DWtwp9uBkLUhTCgc86rr
         YltsKN2HvGZEhnaMiesSx+yzMzqCMPbZvH9LUO4yzLFIjrHUL2CmT0xB4Q/KvDdipP85
         H3GZjExGbGeJCX7e3ITi1CVkYj35avi4yFzSKaIsHRFo7vQeHrs9Yuo0iTcEn5EuJQpF
         BqHagnWmiJnYMFt90YaJ273RwRaBPNlW+h7PeI/cTqYkQyOKiQdgszLkt0S2ImQjVvg3
         YZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015491; x=1730620291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95caNnI7hgOLxEqas86hhjYPjq4p60okYGlZe1W9+VQ=;
        b=kwD9kr4YTHojy215me9eh31SGfFkMEPDz3WCjP3sDux/aRzYyZj4bQs8c5dxGmUKM8
         Hh7iZm8Aa7w8v4B4daWVSKsHpV0vlbeZS5hBBznhINNTjh4mWscG9JsYNqeqYhCOPvVB
         90rzEwp19sPWR0f6AKLISMmJhyKurIj+pQo4yWVMhzZa/Mu9VwkMs1VrJDx8oM/rnvFY
         BzzR1i644fzJiJs+Q3fc6bJF4rHiQHFSBAb4bGzF7oNiz1sLEnVFha0KFiV/le0zDWXf
         sdNnXCJurgfdujOGxnpFR0IKKOh7q2wXycSXumo1jO6lph+z6gImkH7ENt+N3zU5aHyB
         JEYg==
X-Forwarded-Encrypted: i=1; AJvYcCVo6+0YQQrl4IJexViHLVrS7whmEIfm29ixO3w+oheTEoIXNK/PW4WnS4mPs/Gmw26j0PGfs2KALgM+wMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYJ7TGWFwrsOfScU1QooYcHRNCtwL1Dvqv0iGWEXZISkPyZOu
	T/LeAoJTUT3AkN8j1M9ycIwT5Q0x1dXUI56XAu5HCflbWsb+/sZ2
X-Google-Smtp-Source: AGHT+IH7qS5niQmAAfTA2UGQJF1s0kcotIcMoHkxWCvAmGRljhi8/z+HxbR/00ppveIZ8SYyL8JZRA==
X-Received: by 2002:a05:6a21:6282:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1d9a84d9ddfmr6268806637.38.1730015491155;
        Sun, 27 Oct 2024 00:51:31 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f9a1sm3785551b3a.90.2024.10.27.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:51:30 -0700 (PDT)
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
Subject: [PATCH 4/5] drm/edid: convert drm_parse_vcdb to use struct cea_db *
Date: Sun, 27 Oct 2024 13:21:07 +0530
Message-ID: <20241027075108.14273-5-vamsikrishna.brahmajosyula@gmail.com>
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
in the parser drm_parse_vcdb

cea_db contains len and then data. Appropriately change the indices
when referring to individual elements (db[n] becomes data[n-1]).

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2ef07d00aaf..d9fa994a3acc 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6065,14 +6065,15 @@ static void parse_cta_y420vdb(struct drm_connector *connector,
 	}
 }
 
-static void drm_parse_vcdb(struct drm_connector *connector, const u8 *db)
+static void drm_parse_vcdb(struct drm_connector *connector, const struct cea_db *db)
 {
 	struct drm_display_info *info = &connector->display_info;
+	const u8 *data = cea_db_data(db);
 
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] CEA VCDB 0x%02x\n",
-		    connector->base.id, connector->name, db[2]);
+		    connector->base.id, connector->name, data[1]);
 
-	if (db[2] & EDID_CEA_VCDB_QS)
+	if (data[1] & EDID_CEA_VCDB_QS)
 		info->rgb_quant_range_selectable = true;
 }
 
@@ -6430,7 +6431,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 		else if (cea_db_is_y420vdb(db))
 			parse_cta_y420vdb(connector, db);
 		else if (cea_db_is_vcdb(db))
-			drm_parse_vcdb(connector, data);
+			drm_parse_vcdb(connector, db);
 		else if (cea_db_is_hdmi_hdr_metadata_block(db))
 			drm_parse_hdr_metadata_block(connector, data);
 		else if (cea_db_tag(db) == CTA_DB_VIDEO)
-- 
2.47.0


