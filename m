Return-Path: <linux-kernel+bounces-570242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44482A6AE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76808A3127
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FEC24168D;
	Thu, 20 Mar 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwaRH7BE"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A240241698
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496844; cv=none; b=csUHisubWPuepQsrWeC5KeU9AFFTQ/65yCC2AZOeJdgxkcSm5KllCfeKRTjOpX9lYDYSLQNQktw9UH/B7lOmB+/T/YY0GbSfLJ+TgOJ4Le4AOnCZA+4QME7zye9QgfCYLTHER/YMi/4UuUZYCA7FE1/cgKHfX/9sJi8iXY4UYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496844; c=relaxed/simple;
	bh=106XxGOuAhdnmay00WQENaLHjezUM4Q8dwXi2xfOFYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjhU5WQPX/UZ/l63wGnIRldAieBRPfLMY1p732LGBBV5whgx4dCRYbhCUn7XlmbcpQoUXwVpu17vf7UuSBlSTzbQg426iBKDrlPFsta3mtCONEoF5f/atVEXYcbKLIjbRquMY8RjdfnjnHdTWyXVhsKqJfIbVyGT06kx49YgrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwaRH7BE; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85df99da233so93764839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496842; x=1743101642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTbNTI64Sdb94F5FeGTeZQmx91wNwlAKHYCBLiEXOdM=;
        b=NwaRH7BEd9NF3PbrxWaDWtm32VHnmjyaGBXMm3QdcKggbNVtmjjDA9B919xDZjVI9r
         flhKUBRtUIekY+1UwI/blJLfiIbJdR6yy73TI+m1iYL+snS84HIfc1DEK0ASdd0qGnXI
         gHRzURbarkbU/qAPgZ8nrMUpQFoKXOJcdvbGjpkslSo6gLGfG1tUsOvCgnS/RVbHDICM
         XYhIaVZTBdRK11+qvCb2if/uWASMXZy6Sl/O9DNSCZH8KkksiS2o0aRV7jhFu+qYWOWL
         VI1uwNvOp3AnZj9RbuDO/4Mh66lE15NMpEBlfYsvZeKQv4OSrWthKkiUiwCuBleUMsie
         t5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496842; x=1743101642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTbNTI64Sdb94F5FeGTeZQmx91wNwlAKHYCBLiEXOdM=;
        b=K78oRY1LQ0gID83D11GtGdloKprykrI3LuxyAhQB1C7KhSAhinjB2IkHCGEH40GQgn
         2Vgo3lXKrJt4Yc5lEOhVSarFU5AGfmIBSV8oTRdhT5qrmKfqECcUwIzmMLXkxdHO8ibm
         eQcC+nFCg/RzDx5e/a7GV+KNLMzZV0SZy2dxJOffXDomb05UAtw/Dfz8qsLbWos/O7cy
         rDMPnKF7jtHfV7PEepEdlY2h7avyZybqO1zvHCo9ALj/WxEAOgiib1uH4cGyqxsS10dp
         eVSOEwdmtsNToeZ4DFtpA06kShHFgFEZeOk9UAijj76GOXlYZwVJcytUaAXzG9XHZCdv
         sLpQ==
X-Gm-Message-State: AOJu0YynzEvNtEd9nNywPrnfWGEDq4wyl9suIzbBOOwtk57D37TVIwpZ
	F1/XachAmTl8jyyKLbxsdPST+J177feNJbARFU4lxqXaiSxDKlwPnBG4mMnJ
X-Gm-Gg: ASbGncuGTCQ62yGNOHPD+o7k/oa8c4cs8RpY5p6qwNhAf4EklSnkJ60g0i7b7c9XlOE
	oO6M5EdKRDDQuEaZaXrSC/wzztT58YBMgJjpt4c0oumvJnG54pEEo6gMTcUFZ63dnOPMwuzsFG1
	dd8MAQEuIbuu805zP2/XBVrxv6rTGBL34FmMK82FNoc1ZJmTrz98ZSltd2oscx3zAnlXLQwbNS1
	D6mAJcyWZOx+tGMFce3PhcW5DW3efW7p/duJ4VwWd33gRix05kwpXOOic2P/PRtex0jScDHjGH4
	u7rJkTDO0pPsmCXUFYSidhMoxqCH+PsftEvhEb0tmxOXow9zvmv8q+eoZtAaPtae1uCDajxSVe8
	dJw==
X-Google-Smtp-Source: AGHT+IGJ+F5hgXSEX8LPUK8KbWY2gpleoQ+3CsjZCEJhiphZtgFJ/4Ts9qzOdYEYS2jHaPKn3rXpJQ==
X-Received: by 2002:a05:6602:7219:b0:85b:5869:b6a with SMTP id ca18e2360f4ac-85e2ca35c40mr46952939f.3.1742496842400;
        Thu, 20 Mar 2025 11:54:02 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:01 -0700 (PDT)
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
Subject: [PATCH v2 51/59] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
Date: Thu, 20 Mar 2025 12:52:29 -0600
Message-ID: <20250320185238.447458-52-jim.cromie@gmail.com>
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

The vmwgfx driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f32471c8533..2b4f862fe5d4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -279,6 +279,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.49.0


