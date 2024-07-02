Return-Path: <linux-kernel+bounces-238480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BE0924B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374CC1F24860
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C491D1A08;
	Tue,  2 Jul 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCw0fPru"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F21CD353
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957559; cv=none; b=pHPFRbYw9jHi2hX4vHXo5AjN52eoatKtOCs0ALANaBOLwi4K36T1KrdEpPvaMqFWtkYHsJCfCGiJ5VlrJCpGSgbXVNLqI+doB+ZSBTuXuAM5Zc9jC5jqYC8YvaQz+Pb1IIAz9/X+tgETgaaCnVBalLzSM3DGvqovutBlhi/4RBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957559; c=relaxed/simple;
	bh=Bnq5BQKfMG5kstkLfy63VtsHV2NPk24N/ajWD1f0Eak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKGMXwU4tFR36rCawKb6GcEP15f5iekZX0987fLlsmltj4MO8Gs0fOvQVCfPXq4T2MdGzAzcMzSy7XBj5W+mRsClxs6kIp/Z9/H5fpAKB/8o7w604DlgNQm7sithIf888FO7bBc/d9CsVhUM/VV6trVma0m8ccxgjwOYQZxsI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCw0fPru; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eeea388a8eso185113539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957557; x=1720562357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MstXp7FK88BMTd8JHXdyfJJm9pHe+R2QRKpv7nuxLhw=;
        b=PCw0fPrufy3KASeYQEi9JBdVnNQJY+4+FHm2fAo3ao2G5AbuF+bSXXt2iedgf2mvcM
         ddN5IzIxTIvS/WRUGcX1ZYD/FSvJdpr7zR67NWFuAgl6uKriCSgz8cctemAbFa9Hj9sg
         RLDmmMiX/KFKv7sjVw9hKuufOFyLR/17h6xe43mbpef/4iitwPxQCdGXDZaX3Ah+X6HY
         0McpftENGdL+n7wLIJGPeTkpUqX7p1iFyjhJwEzwTMmPQztg/1XY9dlUT4kBZlM8s+xy
         aOp+F7AtxcZYAtQ8dB3BpBxEX5cWExAfIVV1t3M/lZkq62dyfsOMqb6TUJkeT1VjviFE
         cH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957557; x=1720562357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MstXp7FK88BMTd8JHXdyfJJm9pHe+R2QRKpv7nuxLhw=;
        b=F733J8uhP+D0pPaB3Aafactdh4YMt+i2pqJxaxBrrVomK4+gp2+ErM2d/owP4OdDaq
         ceeTB2G2dH4EMPg4VJNrIQfYuQqxu8zQ2jLdArdGmFPY0idnFdp/C5Wq5oNFa7FQ5l7S
         dPvpfpmfsxTqZlAjEo2qB6OslXaI51YBaRyGDVpXPISxG3mBrahBi5VLXEMSEkt/Vbfu
         qk+bhV2CyssOHrwjGsrjWbPr/lxyR7+n07FTpG/SfiSLEd1LSqHxP3QVRcmE62N2cf6S
         P0pR0WXbG8LcNo++dsqxcMtI0JS3gE4noe0lGLBEezJEzJovmWsEMPj9lh7A5+aJzV8i
         4Haw==
X-Gm-Message-State: AOJu0Yx+ovTdGBMRi654q+FwMnBbsQyTmDr+bUg4NVpKV9vSdvEBKINi
	VCzDBzmkuA/n8XXAM7CcmNaUuXMaLupLj8gW5bvrcPM5GoYhpJLK
X-Google-Smtp-Source: AGHT+IFELzazdv52SOJ609vTMnouJkmTMMLQschX/DEhQZmc7e+NLKxBenDxq+yCZxxLRM+vTht15w==
X-Received: by 2002:a6b:6106:0:b0:7f6:2e72:e81b with SMTP id ca18e2360f4ac-7f62ee168f6mr1110126639f.4.1719957557504;
        Tue, 02 Jul 2024 14:59:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 43/52] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Tue,  2 Jul 2024 15:57:45 -0600
Message-ID: <20240702215804.2201271-56-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gma500 has 126 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..5e03ac7ff433 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -39,6 +39,8 @@
 static const struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * The table below contains a mapping of the PCI vendor ID and the PCI Device ID
  * to the different groups of PowerVR 5-series chip designs
-- 
2.45.2


