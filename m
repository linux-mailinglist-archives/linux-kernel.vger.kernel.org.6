Return-Path: <linux-kernel+bounces-570248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F12A6AE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B8C189F41C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E124C073;
	Thu, 20 Mar 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2x15mOz"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32124BBF2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496852; cv=none; b=h675DnqNI5n4zQzPvpsAbx44gU1RDTCa55gDMPm/1k/oaej8wzoSucy9MUPLaXOvZHTGyyfRyceJTKINvm/yPMxyh2XKOB1lG6RTBjJeP6jPodzNJ82/E4/8BrTIYfVkfRj4rQzF8foMQA3vI1tCl+sCJITWB9N3iFqsxcCKKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496852; c=relaxed/simple;
	bh=jo1ydT2hB6u1cx8n6xgWYmM/1GUAUgZV4IauZsWcOk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6HZJaHtx4aXjdmE40GJ3FpsuPiBJrDt6Yj/zWjH1gntZ4Z9+1Wn3krfUgdc57NOE8JTbJaO/Eyj0joO9RjNZ+20gJruugd0gxTKIxOTsFIRG/ebf+qq72IjoqNRkVN5zazTAq1n9iycqc04gYGHQbNH7D2L3XDUI+giqR2/okQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2x15mOz; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b4277d03fso43924439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496849; x=1743101649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riXSD1tORrHtkttiQwAlqFF38I5b7O133kwF8VYREw8=;
        b=T2x15mOz1CSO6ZORPg77Fz2K00aOoPBU5wKc1um9gmMd2RWyC+4qgc1m/N9Ctr6Lio
         232pbeWRzCLGc1i+KqjMAhqigW3Ve6+clAK/vIDo3Wn+yPVY6a5bknNkexeB7X2/TG1z
         Dg2tRIScx43IfCzGY89icFN9DCv37PyzmD98n/TFX7L2zh+nYBwkeA3riPL7tifuBjpf
         J4eG0llN9VJvMW95wKIJZ7es6wsy8wlKwIo1ACo4Ncv+bLuSbl6K3J7qERkzgiaor/nf
         mfdt7xjG+PH1gJ9SG0tJ5GgpyuBNYDy4n7jpgtAu1myRoWUk2Q+kxjO3FPS59GqU1YR2
         s+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496849; x=1743101649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riXSD1tORrHtkttiQwAlqFF38I5b7O133kwF8VYREw8=;
        b=rqhNgelYbt/vcuJzafL/fFp4iFodfvC4ytnWiKfAaiSuvs/XApXvnxu2hmh7OYneeF
         5/iLg/aivul596HFove7d/6AuufpeC2YPLNPp5T9kv1pJ/g+PSZWNOPW97ZHZNMiQrll
         S2adjbG3u51YH5y4h2lHvlcbOMoqx1iQVeQ8gKqWoZ0zwB6/6StcroaSHPhBC3Y3NmZc
         tmn+bEE8jNY/3i70IaDUVunsWG3GzVGrkg/5gvVhMv0pCSisZQuuWHzLoEou5TLkXVAP
         GrWpg5AeF0J85z1aTxMg6ZvKPlm15KoCj+CKegWnDLekLOmvMgW2dlm0S7s9DDFhvBG7
         95kw==
X-Gm-Message-State: AOJu0YyuCpA8WzAGgtqMWuqMaRl9oK+5zL8FWsr9lRqRXFghkwea0cW7
	HvMT95Y0cdgWIlTuCkq1J0mOYfb81reWPM5hknI3umkbcqpLi4og1l8hTxeE
X-Gm-Gg: ASbGncv6cQB7pQ5VCLsLh1xkrILXO3LoV6FtLc+FQ6iRPbgt+zCUJSuWFQALe2jChrC
	Id+i0kZOdgQTRFhkiske1nq33f1NYI802S9vFtZjpyVxlADXZt5HXE5IveVS90WDkJrtJ/8xsH7
	z1AfjlTg0ItoZyVOwcVizhwhY/cj5wiVJuE8wlsxictSb1AUOIqQyMfND7BoEwxHXnP8QMJUoa9
	F4vwpJqbnThjs/2Ux9r0ITnsxZE0LK2OLRCYKmp3Q5QgZq0+ZqQceX2RIm9KYIpRyPgYGxdy80z
	bilsnX4P0SE7T3xhXpdU72IdF+3f8TdQyoS2BFdo4GU4wIMxE4V6yBkapcStwsJtKAl1qO9icP6
	FBg==
X-Google-Smtp-Source: AGHT+IF1oSBpmraBX8zPImUtfNnxyTPneTMK46EMc6j1uPXohNjQQHHeHYBBNbkda865fA0ElyE4Lg==
X-Received: by 2002:a05:6602:4145:b0:85b:37eb:f466 with SMTP id ca18e2360f4ac-85e2ca19f85mr41137739f.1.1742496849336;
        Thu, 20 Mar 2025 11:54:09 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 57/59] drm-dyndbg: add DRM_CLASSMAP_USE to the drm_gem_shmem_helper driver
Date: Thu, 20 Mar 2025 12:52:35 -0600
Message-ID: <20250320185238.447458-58-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 5ab351409312..481d18561688 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -23,6 +23,7 @@
 #include <drm/drm_print.h>
 
 MODULE_IMPORT_NS("DMA_BUF");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
-- 
2.49.0


