Return-Path: <linux-kernel+bounces-551549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB66A56DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FE81754A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15AD24291E;
	Fri,  7 Mar 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvt+SEYc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF02417E4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365259; cv=none; b=Grnglv3QXk62HwKRK9Qo6JpxmkvWEIXu9gw7VrBz7jPICvdKlD6iUCdTjKu8hMl9UT+R9O6aGuo/zUTwPUF5fJ6tZkaX+XzQM1wtglDnsWQkIDNZZniZHSnfnYcG4oYUEIyPHEEwr6YSq+nykqoj5zkZ2ePmwFLziEjkG5QsV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365259; c=relaxed/simple;
	bh=ruD0UQijRSTbAbiYbiy92bcwQmGm+acqNJsn/Xwt7PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMAUx6QS/L53N/fgwVwDpipAYiQvOQHM2i9V4h+bujbIMyD93yOx2W/In++6dx0KP8/Zy2wWc3xQhcCpeTToJ1me5CTFzCng7UH/n+mVwhyNLIwoYx6yGepEPHM1dhkZAYhy5usyTgYEDW8WkgqR250VyZ2TmVO4Fm2QeaZxHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvt+SEYc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913958ebf2so285075f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365255; x=1741970055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIdjBnojDe9JlRJkQtXkq6PiLeEhZjPQxZt/O+Cfesg=;
        b=Wvt+SEYcHqY6Bcv2NbEbwlqsyJrcjOMnLsX05Tw0X2gcL946+m7Z/67ATL1rYiS+6N
         0aNe3jLVmf53DCoD3x/GM82SwGIzCgpHVXx57NCRrAAcFtiVHsE4A3YOmATm+kbvnu+9
         HlxVPNMJWWtLuIZs7o8JIXbO8FODE8CpCobpquc7iiT6lo3TJSNUnf8Y6zw1xsXjI1dB
         AKp4JnuN93elWIhI5KyxizOr/8XPS59rPNMfGzfpFvlFDlH4Eu6/UHmqDs0YxLI+/X26
         OeptLSTt798Tf30FrcFJghCP/nvw6S9kkYqE/rpQ40/o8zV6F6+7xlW1EGfPgswFNnyP
         jC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365255; x=1741970055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIdjBnojDe9JlRJkQtXkq6PiLeEhZjPQxZt/O+Cfesg=;
        b=qvyEkEEC7MnAH+8uqS7pHGOXNhRkToO5IXgpKuPsI0jlWieP3UrAIBaZ0vM8gJW/nB
         APIOT+i27UGNWJp9NUF2+MwKrwqcbU6gL+fgELMhrcX+wd+6TQnoq0fiol6/pSc9NE99
         rIuglaQnUT83KNYJTXhZB25GzBzQ95z82fyhMurXYLKFspqU8UQZR9MmMAKLCCJ+Potq
         zMkwhCjqubsnQPCwzwnYcXsmP8QsPwLC7mVrvrj3h/dvRX98MldmqODTctwO7VZvBn5D
         +PGCT0iqV7pA9ontk63L2l7Un6KH2lXdLp4SQn3HHMqyGGBMFYAWeYYtz/mcNKjRtley
         8/hw==
X-Forwarded-Encrypted: i=1; AJvYcCUbFw0R1Iv886dALZpZIpjvMoZnl3w45gDmZ1vSDQxc477uu+7pf1xfavRrvKaDWbTeMf7iGN4T1Xxn67E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGONf6V/qlovqG9J5SCNhHh6BYL5Dk0ht7rR6OIT8Y4rO9wfv
	wDowGbdqc5/BvHArqZyA5SUXd8su+GpJ33ObdlAUrqhqWcHpP8Qr
X-Gm-Gg: ASbGncuxsE9EhAPtnM/Cr3rKkJ/lpTGmH4nstr1hax6T+TLBii3AckBF6Iq6Bulz9Nj
	JSWRVktRmkklrb+tZ5gONSxnVI4/jG+iI4TnGKstu6wLDhO9xByKd/4gFg3XoUFYt1A/4uTv7IC
	P66MN/G7LUGGCe7mhdwUJ497WURjLIZ3w7NTNc8IgvjJUM/Dgnm55Hq3naFDZ9oTM1aXjYcPnE8
	h4wjKBPtJkeDsOyYEFSXtapce4iPYzrpenr1IgeGeZ21eEVP4nMpWF3KAQv0/KUdjqj920wICvu
	gknCCjzOQZELRe6p+51u5WOSzDSq1xFFbB+HdTmg0iH8/2Y=
X-Google-Smtp-Source: AGHT+IEwPvhouBA6vZMQodw9FQoUs0STHqGK32YOVJMT04SsOqUtTVNTysfRc3/xVYG7647HWWzuxg==
X-Received: by 2002:a05:6000:1846:b0:390:f6be:af1d with SMTP id ffacd0b85a97d-39132d98ae2mr2659989f8f.41.1741365255560;
        Fri, 07 Mar 2025 08:34:15 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:14 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 12/16] drm/vkms: Allow to configure the default device creation
Date: Fri,  7 Mar 2025 17:33:49 +0100
Message-ID: <20250307163353.5896-13-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new module param to allow to create or not the default VKMS
instance. Useful when combined with configfs to avoid having additional
VKMS instances.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5bcfbcb6c0c5..b4ed19c97576 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -50,6 +50,10 @@ static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
 MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
+static bool create_default_dev = true;
+module_param_named(create_default_dev, create_default_dev, bool, 0444);
+MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
@@ -219,6 +223,9 @@ static int __init vkms_init(void)
 	if (ret)
 		return ret;
 
+	if (!create_default_dev)
+		return 0;
+
 	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
-- 
2.48.1


