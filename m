Return-Path: <linux-kernel+bounces-254299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A11993318F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE258285894
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168BF1AC453;
	Tue, 16 Jul 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/4ygcl6"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F41AC421;
	Tue, 16 Jul 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156365; cv=none; b=hyQO+2TBpBdqq0byJ7A8wLatSQlzViO9WTiv/wFEQ5pNuGWSyvoXQ4dyIvRXu/wtg3pSRGNY6lGJrXT0qt4Go7uFfX8iNb3jhswFIiMagTw5zDIz39TQjL2izztvQnp/D3uVKt25pO3MCA0Hlljs6Tl9zN4yFtG3oErC27NlAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156365; c=relaxed/simple;
	bh=IW3s7sT2wCImsg5MxCShRcdd54vAplC2TvpdeZuQvns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAbnJ9X4WxHpUDHIp8JkuGDTvCZhVsGCrr/j27pPvgLYcigSPywvmKf0TJL5DBMLhydyvCaz1akA5qjPtBqDePQn2ud7+VGzm6K2V1KOuJPFhyAL5J8mF/KQ41qhOlbABWjXUngOGSJXCE8jouPUfEX6luZhATWc8/XOyduOp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/4ygcl6; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f99d50c1a6so8661639f.0;
        Tue, 16 Jul 2024 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156362; x=1721761162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP6HptfiTdQ0tPqLXKJ5a+6n7jBPHeNyJUhIr64YncM=;
        b=l/4ygcl6L7cTiGPLtS7Yuki8zXHHmoAP+1G5r9yMtXbZ4ZPnRDfZW17QIGRKsVGCFK
         yxt9wNnJ1BvNjOGt+f6fTp68XGNouoVlHHkFjBbSVpr6SxKgp/vViRdvuxSNCSOfZKTR
         8veqY2N0yn8SpUb09vrdaG83c78baTC26IkOctuGY198UcEm5SPK0HYU3NIrqZgsMQa1
         Axm9Rc9mw0cDQsMoWqpuTiaSMI2fGN4owLRDpcRohIuEnGH16dAA09RZolbBIVXScQvG
         BMYValnUr50LSCMlagA4Ulruzw7MkRHR8Kh2/5QsQ1VjVKh4r32dUhR5iwTZc2Ze5ApZ
         /R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156362; x=1721761162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WP6HptfiTdQ0tPqLXKJ5a+6n7jBPHeNyJUhIr64YncM=;
        b=Y9X/jn5kSmip6L6aD7rXtFpi02UN2zCitnwFOkgWOs60TyOx7gO0ne+CmViEAZ3XAV
         ML63WH0aWjv2z//lvegI9O50Ei9cCBV0t9G6kfS1tgiGRXix4HMLqWGl/0At177I44XL
         wBvBq1szFpIb+2Nobfm5acR66j4EX3tvQSdZRh2HES7+p1MxkdF99c/V5W76yrmMyReJ
         DvUisEUhAOzFyhTcS3ZbUZgD+IxRUMXwojPizluRQflfEZp4douf+rzhiFGotmzttSCj
         guKdVAK1GEoKLNesoTf1dRc8r0pO/2YHKLfAfD5TiPEV3/bGPdMAZYj9lJow/TEdvIXp
         c6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXX44lTGV986kYLAIIWFFQtlBsGcYSRMXb5drYrv9seg43JaK+0RmHevI/IKvI+WjyjMsvYC9TzcIK84bEni10cXeViVInOhDLo
X-Gm-Message-State: AOJu0Yybchn0bArKbth03v/+xh/zDxLtV6lVWwKuClgyf/mOB2d6XH37
	ZdL1XtWarTLkMgjT9id5Gv8l2DeijrwMQw1MarDO6Qt2CFt4DNdHf0RfDf1V
X-Google-Smtp-Source: AGHT+IG0qJNgrwAVUIeZbI3iE5ZWAneLU5YeLYaL9upPtNIQr6xsAykXRcCjaAh8RTQq2lp/KAQPhg==
X-Received: by 2002:a05:6602:6019:b0:7fa:b6c1:c35a with SMTP id ca18e2360f4ac-816c51c7898mr35514039f.12.1721156362418;
        Tue, 16 Jul 2024 11:59:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 45/54] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
Date: Tue, 16 Jul 2024 12:57:57 -0600
Message-ID: <20240716185806.1572048-46-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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
index 823d8d2da17c..fd6cd62608a9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -277,6 +277,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.45.2


