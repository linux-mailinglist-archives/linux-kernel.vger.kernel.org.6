Return-Path: <linux-kernel+bounces-570241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C0A6AE05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BC41894FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9BD245000;
	Thu, 20 Mar 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOGuXzCS"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D23241660
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496843; cv=none; b=YPRMhggID+UAsNGKGqw8SeVyYZDS/zDAhffAQiwugKkhJoPTwbmXXCu9mQI1YZV4W2iPYI0hlGEKiWU5gL5I3ZbccDW68X1iCV/BLABUBj1NMEV0jdhGQJG4sQJVBUwoP/SspRxuhS7KgUJ1I17SJoSL6xwKOrdIExyxpEpVgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496843; c=relaxed/simple;
	bh=SMOgUl5f5Hv4lntfLvuEDqMGTbyJ1k0zKXfBEdqoVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiDei2hgvX3hbL4BkloKNiYh9kfaB0V9pyGS7Zrpd6BN7q61rLvxj9SyDFgNqXiP6MpmttQbz+B2A8z3c0F0v4zHQBAvqqt0kE5vHlFIzHRGpG+LLPSjpAMf/2nvJRw2v3SrYwvO3LAD22wqBop7INeg8w3xXXivn7noaYr/HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOGuXzCS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b515e4521so36872739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496841; x=1743101641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgy450ZES2ez3J/XkWzr8/KGFStO5bXfg+gAZCZdzzk=;
        b=aOGuXzCS81M//gsfAcPWnKvRfW/MTiPZaIv0uqH2KWSs8EoTJHM7uwveA4OfbvClQh
         5SjgsbTduq9wUdT3+FemEvnoSslezykGSbAIKeR360brE3ZyhCZynNpa8BfEyrpWwGKL
         p0oJg5WMeGCOEJ9zuW7odWcIRKWz+cQZKMzAqeIK35CFvdBqBnqwg8b7wxiN2PLMdiTy
         rweyiSlR3zZR46AOgeaDF/OGe9ejUBAogJITl0nkRjeZ5PwvU8ggj5WQmmGSangIYJ7z
         MO2/W8RRNZzOfbBpcKWrUUn8CLmpS/M+Za3XUib+6v8lbRGOTwbFa4Roj1cw//sm8GDJ
         YSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496841; x=1743101641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgy450ZES2ez3J/XkWzr8/KGFStO5bXfg+gAZCZdzzk=;
        b=HgA+VX3E+fl61rQ6NlGXW7y/2WPh51mfpxPQI2ZVw2RYGOuOASAfhcJbiUaU+kxq4K
         4CExLbc7akd+DZBrZipmql7Q4NupIxvIXzSC1Pk4wCMKrJyAp1VYBse+gKMwwhX2niDg
         npEmyQ0IBqtMIF+6zmLo4FQApSgjqmhAXscMsoiedX7E2sB80Mct6bsZvg5XjH3XVvsB
         OPZ+NKFfRoApdRJTzXb3/7BEiO4QwuSeKC/JNkabkQO55j7jgbEop5Z05vAVjuKF8+iq
         FiqLCoCJ0S1253hQErAuEkUFWkwHhVy7i2qKkLr/diXi2SuyqrBpkgBT5+GetxGatTbg
         nsnQ==
X-Gm-Message-State: AOJu0YzQOz7bAGHrMU2KNbwaTQl7njTvybdOqkehnGF05VRE3Xfz7g+a
	O946CTqc4biHEVTNN1x25A+CTnrIzDslw5AR1h8jdbXc7nt6UyyxhwGdmyJ4
X-Gm-Gg: ASbGncsetdCRaLdjMoUzA1ZPF4qu8U8H9+1Yspihf1lv6Lowr8WtkxhO0w1HbORDmbT
	Ngm628EiREmxMl+cS1VGysM7gZ/FFD9KgWegHcbEnCjVuhDpHB2m/JjxlDV4e0y+n4orTs7ad63
	qikvcTn9MwcJsEPAFu9lZps1Az3NXQArQBTD59gCzPw/B6eVE2ovWU+vmguE7RD/BYby/e4LFvf
	hHzvFz5eNxVoWRXrMcF45/uMc4L48s951voh17eH1JZiLks126wpLIkV6EcUpbK3VczHtJqSpBs
	OTUhB7fE7yi+7O8iqwtbvpISV+NUZPpA6vtTsYJ4IpP1Rd/eqyUVJlMjbl1MMWm3rDJevRiwprW
	Af9UBzdXs4oHN
X-Google-Smtp-Source: AGHT+IGBUJj0c0mSBRBgJSPDvGPw3Gh4UAbdxFlYAyO26LwXLIgnhQFAIJTPVSWIGcw7/GhzghR57A==
X-Received: by 2002:a05:6602:c89:b0:85e:201e:3e35 with SMTP id ca18e2360f4ac-85e2ca18937mr56876739f.3.1742496841207;
        Thu, 20 Mar 2025 11:54:01 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:00 -0700 (PDT)
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
Subject: [PATCH v2 50/59] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Thu, 20 Mar 2025 12:52:28 -0600
Message-ID: <20250320185238.447458-51-jim.cromie@gmail.com>
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

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 267f082bc430..6eaac728e966 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -253,6 +253,8 @@ static const struct pci_device_id pciidlist[] = {
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static const struct drm_driver kms_driver;
 
 static int radeon_pci_probe(struct pci_dev *pdev,
-- 
2.49.0


