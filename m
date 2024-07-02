Return-Path: <linux-kernel+bounces-238481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F82924B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D01C208F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFAF201270;
	Tue,  2 Jul 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crmcLVPC"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466E1D19E8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957560; cv=none; b=uKbums1e+vTTdNx4vLMcnc7eiN2/QVupX65U8hbezJo7EWZGCSwMgHeApffH2FWFi7XYJvMrN/ahE/YD3MBRDCa7vpYxpVG0WcQxlELqpbjKRGUl+RIvgyTMiS3IxHSRFOnFw4vi7nolTgBdf7T+dHtq7MQB+6e9SX0rVBVUvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957560; c=relaxed/simple;
	bh=Bnq5BQKfMG5kstkLfy63VtsHV2NPk24N/ajWD1f0Eak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qckfiAo/fnj0B8F36jATiCmFS2PMYVo1epcthEkwQ08GVbYbg0H98OjuVbKCYf8sfwGiz8ZyHHaifMxsqzqcL/CFWMDgm0Cm0bIPyGGhJuNZ8dJh8lZgQlhKKwKqv31sK4F5zA7RUZ8Qr1xx5u9newVDeXfyHcvSnLNaGGkfwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crmcLVPC; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f64f66fdd7so60635739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957558; x=1720562358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MstXp7FK88BMTd8JHXdyfJJm9pHe+R2QRKpv7nuxLhw=;
        b=crmcLVPCRSIH0PeN9U1Xd4urGdBGo8rvqX/njvq760CsoqK9aFttyK7tgbq9SGteMq
         S1XrLlshKxjdYwcpFL+Pisb7frHNLg7GrB2ywU9Pxj3D+QGTZ6t026cAvLofjYsryk0s
         OY8MNq06YVTsPm/OFX0Py02EGSbqH/SapL89ai2TUTGMHXBNB2SZ3MjL7Qf2tNWwjBer
         JIeL8stCqI//H5fgZFjYTlI5PF4ietfIpkz8eXU2nYpxairye2ohLvCdG92/WJ1P692Y
         KNKyrOTCVY63A5Oa5SYISv5NiJm+wISh/I9fRlkSYWik0O9h9N4pKiOcyKtWrbp83eHZ
         ls+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957558; x=1720562358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MstXp7FK88BMTd8JHXdyfJJm9pHe+R2QRKpv7nuxLhw=;
        b=hCfxHgjsqZyhM13XZq6uwlnz2jqflZvi+lL999/byPowE4JFjw4x2uI8f2sivqFwpx
         B2Sk2PohBw6wYdz7aYEFz2FlUynAiKZFPxKTRPYF44WzzK80gF5eXNPPe9bmD7KBKXO3
         qX8RGED6gFmMotj8oOSVlfcWNfEg/09d3SelNWHeGQrDquoOLkw2nbKNmbfYK1L9Qp3R
         aOC/NRbFhECpUGvVXTV6+hVu7ljXktbCgXY3XP2RoIm4izBy7Dc6oxTJPwMUNgFj8X+P
         ME8fcijhdZ3lrUqCDdvTX1Y9MY3SY/6ZPz7SbUmfmesR6oaM9Cq0K903d3MmEjYlq7/S
         xumQ==
X-Gm-Message-State: AOJu0YzGWZhu0U896xgSnY3L+4iYQyIUTYWRTEtlJKgO8eTE2Zq+FfRb
	17eVzfWiYUMewx4GyCHFni7M0hxw4Ox2KMe9ZhTJjjfsJX7NyBNd
X-Google-Smtp-Source: AGHT+IFcIORp9H/J73OiEqri32U4KgwsO40eee8n6IPtXvMuMDoj2ETHViN1dw0w41V6S4LRy3BoYA==
X-Received: by 2002:a05:6602:1d15:b0:7f6:5c30:3717 with SMTP id ca18e2360f4ac-7f65c303a28mr121899839f.5.1719957558467;
        Tue, 02 Jul 2024 14:59:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:18 -0700 (PDT)
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
Subject: [PATCH v9 44/53] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Tue,  2 Jul 2024 15:57:46 -0600
Message-ID: <20240702215804.2201271-57-jim.cromie@gmail.com>
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


