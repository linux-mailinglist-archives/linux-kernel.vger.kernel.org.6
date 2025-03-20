Return-Path: <linux-kernel+bounces-570244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A409A6AE12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621473B5199
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA6248886;
	Thu, 20 Mar 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Vgi/Se"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0D23F419
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496847; cv=none; b=tl5iwi9c86EW3yGrc0bTLae47hm/Ykn0PEjwHLq5FYp4osspnEpd0c+Co9t2jPAf+5Oj4nURBf+InRBZH/GYxVI5DbLyxJM+rtE8TRSZ4ep983/pNWEqQoFJzAhlMgMJbgtAk4VqdpOGJbP7aQERJgLksXfrMy9PvmzoELhZz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496847; c=relaxed/simple;
	bh=CwWS1tqqtSrGX5l/zPl5jVAGna1ng5cXDDz/wrrMCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEAbhlFULNsNpTXc066xyi2HWPTpvIIwOIAAGB15ya6VEy2/rLy0lssNnXaOzy+BwrPwoLsG3XHsuQLDTvWGLsHlnJtI8emYxl1SfN/Gs2rj5EnDqLZ1Il+Cteo3oRTUppwyCHXdTAc/LqDzH6MuHhs5qs6iQiLhdiS5QzApO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4Vgi/Se; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso13786739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496844; x=1743101644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phnE7T3rE82X9afYdUepg2ZaVnfZbBYGopazv1dsHzc=;
        b=J4Vgi/SeQrDMJ5V2TBnBJoCAH3lrwcdx6bHtUqKsy89xmDT8ejpiFM5J4dzFz3p6z/
         4YUrKdIuGJRqTxHfwGN2FcFwsvWzx4u4GUZJda+HhoiI2qFh/sZyI4MOR9A5X5SQSQ68
         qRvvkov0tAztkg3BIWG+defv/kiPMsRzXyBFN5C25kutuBMrHXV5LYWnan24stAAfRkj
         yI4v1KJ/R9HjBmdwkO6QIX4VKmlVOFPXSXq6/TOwZNceQT9j/fndzpZIJbVke4NPsqsN
         P24ia3qa43kyStVc2olWdTNnWZnsJBDmhzXaAVM746RQ1krkEVgjvwvmCg8/Z5mIXWc8
         HOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496844; x=1743101644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phnE7T3rE82X9afYdUepg2ZaVnfZbBYGopazv1dsHzc=;
        b=p1LdwDQx7YBQufkaim60xAuIUXH3jnoj/Dk5whW03ApbfFUyH66Gr5+e/CfiqmlTrj
         Dpy0xX8dCtWrXRs50iwf8emlll/7OktpmcGobpQG+cn4X9+MrdsIziSBswC6lhZVvlPz
         pwpOSZxTTvL8gqg+EdbzadL82fNkbhGUycVlGRswidv2/c8UbzTouegKk2h9h4XNibgR
         1cYnzED7K84zVCZn5fQ5R2k+7kjbqtfLv6teNkfp/CtLR5+m3xHdN3TaL70cAnqTG10z
         JLFx4kPCkABE/T9NysHFIy8NasBGNg0NPj4jVZuEaQR7+jK1/XiOTawao5jZownpK42O
         z1PA==
X-Gm-Message-State: AOJu0Yw/ybYjHm+ayQ0SBj5ob3P3pR37QneMJZjFdXgPPDU1S6tv5Atk
	2BPFiwUs+RvFdyOvyuw58waE/9MlTlIKVlLo7t2Nh8JG7LD23Mzr0Oh1wcua
X-Gm-Gg: ASbGncs7qpzv/MNacBQOrrpqsgD4qmp8ktFQCg8WgBowFVP7jEyBfwceIaj3UqUNKDr
	wpsxnP2qBBCeRlPguEAheFBFHTHvxdK8vwupYgVDg2bNAXJ78hf6A8f57Yl6wxUm98l8fTIvXyI
	xYtU++vmDAToAiglZgigqzCqaP0AhFdkyGHUbMkUxRkMDqadhaCPHqvTdalNnN+S40RNY8cOs6/
	tWFPFshxKQpiJXsbc63Zjpw65Qw62bBhSUMfMJSI7Z66f9Ows2vc2aDSZUhkzEEiyMk0LaRAnxI
	UKYEBDFBLmlASieGAMkJDrQgmxtVc/a6V1RsL14R69NQjkr6uPdajz48b/dJhJ28upKklaUJy7O
	6AA==
X-Google-Smtp-Source: AGHT+IEquWBiK+hoBl688ui0TzT9uiALVStKwkK7VjOSDZDveERfz+JuO98cZxCxxin9hgntP4lKOw==
X-Received: by 2002:a05:6602:4013:b0:85b:3827:ed06 with SMTP id ca18e2360f4ac-85e2ca33995mr46254839f.4.1742496844632;
        Thu, 20 Mar 2025 11:54:04 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:04 -0700 (PDT)
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
Subject: [PATCH v2 53/59] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
Date: Thu, 20 Mar 2025 12:52:31 -0600
Message-ID: <20250320185238.447458-54-jim.cromie@gmail.com>
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

The udl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/udl/udl_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 3ebe2ce55dfd..ba57c14454e5 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -19,6 +19,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
-- 
2.49.0


