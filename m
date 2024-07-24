Return-Path: <linux-kernel+bounces-260957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520E93B0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E0A285225
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053A158D60;
	Wed, 24 Jul 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5hKN31P"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977215884B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823906; cv=none; b=R5A/7yS0ysPBqtXnrfXTuqdGUJxJz24B3JXIxwTSiTzy4DoSC7LgGnXMDfCDaHltD64yMBfhUQ7kRliOBWlig6Pb/ojN+Q3XIrRSnsmv+eHoSfkZd6WjfFy7HRblpkeQlzdwjiYIMWJ2qtYioUkQbnyTba2HRYvE5GlvDBu/zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823906; c=relaxed/simple;
	bh=Whd/p1BkkzMXiI+jI3fYJLod5sR0DmpRlzJ0bqKo1l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YREvNrJJFECczgtyoX+eJ3ekaT3RsYfV36RQH/L8ziC8mP9YPDd83WQUn6Ig+L+7B0VhbetqCHhZO3YespvECfbRq+UPFQMtvv1OSUlC89LxjYtcF+mEd4HY5d+Trv3C/S6yCILEQDubko0vGMxrakU/UIqBBHVt75czP/qPIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5hKN31P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd9e70b592so15593665ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721823905; x=1722428705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RS7gU16ITnoH4uJ2P4cBrWFJTcLfxSuNNT2bfx+93A=;
        b=i5hKN31PRaegqAujHA/i3/hwRdbEbMrKGHXzK6ai6sC5C/UXMpvWVN9XjigmEW/WWX
         LZ0pkyMXFvuGZF9ZQetGahcPOah/WnOWp6ch7keTpb+BNjWAaS1QoJtiDhR72dRPwg8L
         J1KTfF6uTkFRgVpa0rtWbfiUNRr0ROqz0KTT4L+myF4JQcMmudjCQxlr2p5NL3obdl5A
         VuHxsAwgUH6/9wpDYD4kQVK/Rmosfqu43VsWPCLMumJlpIq0wlT8Fsz2Y442Raq1ZFbF
         a5vCgKMIiPvP1KoBPNAav47rtgz0ganfuDx97i4roCSxxGrgABAz9E84yOFtVhipCXzk
         Dv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823905; x=1722428705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RS7gU16ITnoH4uJ2P4cBrWFJTcLfxSuNNT2bfx+93A=;
        b=ss3kQb2ZaOBMfPJnSwInb2bRQSg5JuU/Ud5bIzqW3aHbOQzpbvNLL3iH/adYIpC+3r
         +XgHh8v39pplaUoX2tzuEPrWw7J1HXz9sPz+zNBpsgLXVyGr1j6ao/MpYfP5lmvXIS5x
         tWtU8eJEuTENnNaTAt8R/TBbtD7tZYiISyQ6mkydLwRzS4x1sYNz/aTu+0rP4PSBNAud
         aH06SICyOmioNmdPGqC08Qgd60kBWKBGHTYbVTZcEg800dQ07icZR0NLmNvEb9VIPbnf
         K/Kpc4YL2J7/5ParSMxZd01//ith7Zgg4U6jl1gLXLAM/zVH47r+8yEpTf0LA43v/OH5
         mAbg==
X-Forwarded-Encrypted: i=1; AJvYcCXLAQ7LOYWXIkkLROsMGs/Ti+JcLBYmQvxzFfF39mZlxi14K6AaawOM8VwPD5hoo1kwJ5VUJd4i5SV0XQKCz72S2XZmoY0fZpuXIttF
X-Gm-Message-State: AOJu0Yyb22efKkGmRKe8RvnY2pL7gJPDvg0woe6hqzQVTi+/BGmXah+Z
	SiYC+KvY+4pWnEaUw8u3DuzRNyBXU3RP7ykbtAKmTHDPdVFjhje/
X-Google-Smtp-Source: AGHT+IF7OVyonWCCnCVBX9lx5jU8mzF0yeNoeycLEZCNLMHS8GfiaraNhErqelj7XcB9qfI2jnBS2g==
X-Received: by 2002:a17:90a:d301:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2cdb51ce903mr2067038a91.34.1721823904996;
        Wed, 24 Jul 2024 05:25:04 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb76001d6sm1481454a91.48.2024.07.24.05.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:25:04 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 1/2] drm/mipi-dsi: Add quiet member to mipi_dsi_multi_context struct
Date: Wed, 24 Jul 2024 17:54:46 +0530
Message-ID: <20240724122447.284165-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724122447.284165-1-tejasvipin76@gmail.com>
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "quiet" member is added to mipi_dsi_multi_context which allows 
silencing all the errors printed by the multi functions.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 include/drm/drm_mipi_dsi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 0f520eeeaa8e..75855c1c7dae 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -217,6 +217,16 @@ struct mipi_dsi_multi_context {
 	 * end to see if any of them failed.
 	 */
 	int accum_err;
+
+	/**
+	 * @quiet: Controls if a function calls dev_err or not
+	 *
+	 * Init to 0. When the value of quiet is set to 0, the function
+	 * will  print error messages as required. If this is set to 1,
+	 * the function will not print error messages, but will still
+	 * change the value of accum_err.
+	 */
+	int quiet;
 };
 
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
-- 
2.45.2


