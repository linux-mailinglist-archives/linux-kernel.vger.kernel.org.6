Return-Path: <linux-kernel+bounces-570240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C205A6ADFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B72F7B4250
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EB24166A;
	Thu, 20 Mar 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzJO0lud"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3123F419
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496842; cv=none; b=A1D6KXa2ISWrbZrnUfdZUsmytOBNQbAUBO6XnDOE1M5FaBjU1RVp8ASKa3OoKwo7eD8IVLsa0r5/pStirTK5tBdpaoEHL/1KkrmDbYGbvYL/MBPpWcxEZDCKUWUcKFB/SuNuj9USuyTsG3QltSf9UVMnSKFPSl8fF71qxRjKNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496842; c=relaxed/simple;
	bh=pnykpLg2nT1btqisiOtnE7+yyT4IxmtHkmEzKH03RVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6yJdpd8A1RjEXtj22kZVTZ3L68gNO/2wtCqUlETUA/c7EW47RfxSTMNVYfvHF5vXykKhLNJPDlgmsdbtV2rAUiDniRZk1A1vCQZ1RtcwgL4vA2K8f7V4x42lHn38h4yJlZ2SQU4Mn9nCuvCEy0NuTfeWbf6Y48HLE0CR6QgxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzJO0lud; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85ae131983eso125383339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496840; x=1743101640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVuxeJKKK9Rs+v9Dxb1+k9xlxA6UW5kge7MRPvzoPYI=;
        b=SzJO0ludiz+JtezF72mGcIouaMd2eiVqvkj29aLyP+fvkUsye6eY5t6vQW4c9s1oNr
         3nQjk702YW6UtXGbo7vT741WS6aQ+noCOWQ2AFk723wv2kWgSzM761j31qpTpzCh5Jn1
         SuUHxX5g8GPjFj/uXzuJ9nARsrwy+AVFkK3/hNm1+1OWAAd4Z84Y8FV8VjGhvm0W2xW3
         Dk5EHOqzCp63cXMxDV94GMw33a0ANGJoTu7psa+U+MaxAWbHDIlfE0ED2nVLhJBCQBtT
         RidKmMKvJU8O969yJXKPoKGI1lTsWRzcMp1Kytf4oITeH1uvtC2XK/oeJiABzFLft2T4
         OsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496840; x=1743101640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVuxeJKKK9Rs+v9Dxb1+k9xlxA6UW5kge7MRPvzoPYI=;
        b=mmtgZU7Iv5PdriokSbOM+HTJCmFTkGLSaY96fYYfWNwyfzLPoBI/U3RrMlyqzOWKDN
         XdS28KWllU0M2I+0qrRun/1u7L/alDAw6kjOk7eL7+VuiFr7SfZIAYZZv6rVf8Llaxlz
         RF0Bj2bLSyxetk9l40CCusuVMiuu7CO6tm3xaKuwUUHFv1E9F49KWhEpl/CgbzAk1pEz
         /eEHrsskld+20i4CIAdmR+C2fuU55+cBwrHhwbh0GHHdswJ00f/y8y0mMaJUfaMZTdIY
         xy332qGNILqstj1+qV5vpBJzbLSQVHHA9UVQvCIJLbLQzTMocDSuS18VjGm0VpVl92uP
         EAXQ==
X-Gm-Message-State: AOJu0YwaGBpQS0O+Bt51v9OCJj320u+0n9/IS5MxtgJooXzt2LhZD0e5
	9cTLCaxDOJx7J4XrIBxf58ZulWEqe8RXT8GPCiO/MTJan+NXyuqvJEu3Aljc
X-Gm-Gg: ASbGncv2ZmdUz+ek6hxkIA8Uo5axK+2xPscEaZMa/HWOKHzLEvcH6CBTS1nhmrBYLf/
	d3TKa84tK8wtsGHk1z19QoJ4yUS0Vzt+99UT96JRxSrLOpxOIpvCKmUO4y3XLSIIxJYwyYdI7Rv
	bLRd71gRj5pHBxt2umGVNdJgsqeszW0slRp+eMY2HdxBxG7M5kSU+efuT8MJeFAlF/6L+j+7ySj
	2F2lCHaVpZygxLDpRvqCLEvD2/YHnzNi/QrjQ1E+7NkdAhors1Ib7a6nrRqei9ky9XgKNN9ztqJ
	QO1yIUO28GXsEM8x6GfOM2yEw/XmaPFd6/Gjo66sZ1kigZh2xqdE2D/3gbcd8/dzR1IwBB+ONaN
	LYA==
X-Google-Smtp-Source: AGHT+IEgtZhnFWdPHG6hTurl2TJTpACa9ncEjZ7DOX6uv9rTIlbze+MtBpfCYmXm8khqb7FwjH6Qaw==
X-Received: by 2002:a05:6602:7218:b0:85b:5564:2d51 with SMTP id ca18e2360f4ac-85e2cc52346mr35719439f.11.1742496840061;
        Thu, 20 Mar 2025 11:54:00 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:59 -0700 (PDT)
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
Subject: [PATCH v2 49/59] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Thu, 20 Mar 2025 12:52:27 -0600
Message-ID: <20250320185238.447458-50-jim.cromie@gmail.com>
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

The gma500 has 126 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 85d3557c2eb9..dc72388ed08d 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -40,6 +40,8 @@
 static const struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * The table below contains a mapping of the PCI vendor ID and the PCI Device ID
  * to the different groups of PowerVR 5-series chip designs
-- 
2.49.0


