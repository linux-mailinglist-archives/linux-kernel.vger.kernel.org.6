Return-Path: <linux-kernel+bounces-570249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945E9A6AE17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C510348826F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D624C07E;
	Thu, 20 Mar 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnH357E5"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992C227B8E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496852; cv=none; b=uQj/xKSNGcd3Y2tQRUwMgmV47JXZPogIaT9YrG0BGu94SdkI6SzseAIsS7I1+UETWFUaIedYrtzqGcRK+AR7g8WJI/ObOuOfo2/5wjpK2N7vHhA5F++UyOJkUM+3dsy8OCRvtDl+ZDpat/gdK78THFRcY6iQtOKseRoUKel0KpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496852; c=relaxed/simple;
	bh=2hj07UwdhkVjVMyzWoCwFWPShBiCLBIyGVcsL78LCFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXYMuSe6HPQtYr3t9MRB6scZ6ObB4p51h+HNPQykad3naMiOYva3YryKDbvKdz9yMef8CuHBE+fKrVcpLHAF+ebkJMwhsWqvDKb4YN1MGr786miL8f4wxrUEoHA2kamkEHpaytnzx4nvYI60+RNQnulswm161kVtHELlWC4cyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnH357E5; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85da5a36679so109022739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496850; x=1743101650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+QMYU6kMnFOETa/gyjW3XwbPIpROUU0JSPdCI4eHHw=;
        b=LnH357E5aATLNc7FWU3AyA0CnWX76vsxMNdNHuTU/w5WjTQcC1JG8wjPA4QzfBQOFg
         abAozYwi14DkZSer9N5pRF6ISI0dQ/Qs1fIYQPP2uNzZNP9dIfYFaP3qZNXU6f7gcJHz
         iuolKWZTwzFMoONaNP3UNTw+7Qh7O8EV1q3eGLQ/lY+XG1YnQu29///FYd00PJ8QYJ5g
         o4SJaqogCBoM3WtCv8pWU9U0q++Lt18dutGoutmdea6O7Xd6p/a47Pd2hfP1P+zLGcVK
         cCj1HqKoOCvJf8fleUh5OGdcd5hNuVDhPFrZ8byjq5LgfgbokTmePcX5PTazKy6H1/nJ
         fTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496850; x=1743101650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+QMYU6kMnFOETa/gyjW3XwbPIpROUU0JSPdCI4eHHw=;
        b=SP3KmvU5fFJiHLZNfhUWWIWWk5TA8utod5QzcD211hmloyvo6jwgAo6DKDztCXk/Fs
         A6Yp9H0PyurFl62rnn3PO9LIa7+8CHPM4oemu1ub636W2+izrllbVhcVu9ZHlpsYlrxh
         eT20VPcVHP1H5+lkLMbWxe5BGR+v7e4Z1YDWmlkoeApZKspiqaupqHAByr5jweF1ogSt
         mF9eNvF8I1sHJ1vJqLSuYmBTxu6d0wDFpaOI2CDwuSycd9AiIBqNlgU1k2OIo0D1cksp
         W/h5iOyWSgR07V2vx/pfKLLh3rTmnTFm8iLUInB9uy7/db0uGZSH8cb5VzZXkxj5Zv9r
         axfg==
X-Gm-Message-State: AOJu0YxbVfG5Ur8XjbPVV6FfcVHgVYXnIHyXQ2dZOdaHGvLdbAOPcYyn
	2TbZ9m0Z/kudM1OCMxtzJzz+ZAFOVd0ytCPveo7zkrRLwiRYTN4w39wOrCfF
X-Gm-Gg: ASbGncvBJQRAXzwOLZ2rdkhoe8+yFb9aiyS3pz8wg90HXixO4N5w4eWHXXnHdC+rt77
	RPq1Y6rwWUAq2uPhqOgD4xabr0h6j4/0VhCpsNDRDJ7rW+R4hGn/6gLuWjP7q6RJCc81/K+Jqzc
	FBkdmvPzF3egLXJ8468emIxyoN1smjLAbSThOlgePj/7S1JmlY83Wv4vdHcvXvmoAbGJzL0Nip3
	SOM3VrJ4WnaYLGbJORmk0yVpRfIO1bslj0H2vJVIHKdJKweCkDE3Akp3Lxp72QOVk/95l/lrZ67
	0rkCkbej4bKviTvbLErHobUjIrCK1sqU8zUBPFHu6OxkppXcUbH3FDH9uFPBa1e8j3PNjFGCfbm
	z6NNTM0KMvUP7
X-Google-Smtp-Source: AGHT+IFM14DB5b0+Yb3xk+iy8bUVQ6+k06Y9+AI7/qq96L95YVo4adquNQGvMAtgqIcPJKOtb0c8DA==
X-Received: by 2002:a05:6602:408e:b0:85b:4170:e1a1 with SMTP id ca18e2360f4ac-85e2cc7c771mr36727539f.13.1742496850400;
        Thu, 20 Mar 2025 11:54:10 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:09 -0700 (PDT)
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
Subject: [PATCH v2 58/59] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date: Thu, 20 Mar 2025 12:52:36 -0600
Message-ID: <20250320185238.447458-59-jim.cromie@gmail.com>
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

Time for some thorough CI.

Also, the previous 18 patches could perhaps be replaced by a single
invocation of DYNDBG_CLASSMAP_USE, from a C-file linked into all drm
drivers & helpers.  I didn't find such a file, nor a drm-client
linkage item in the Makefile.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index fbef3f471bd0..c7d6adbe17eb 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -53,8 +53,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.49.0


