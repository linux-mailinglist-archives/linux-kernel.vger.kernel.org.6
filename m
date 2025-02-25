Return-Path: <linux-kernel+bounces-532157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5204EA4499D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5AD865E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7320F063;
	Tue, 25 Feb 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq3Uctdd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0701A08AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506398; cv=none; b=mYjOfkS2Sk/STxhuR+NJ2Nn6mglHj3w+d4vLeEWT5PPB11SIo7VnI/1vbehWUiGCQyxfg1dHwl622c68kylsNxRbUFS0k3KEhfX11pvmntCYIS2jtE89gTcL+KyByJpTAH+Dij+fXWTeC6MYHP6KaHDnwDMRsSSCOBtIsvA7o1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506398; c=relaxed/simple;
	bh=ruD0UQijRSTbAbiYbiy92bcwQmGm+acqNJsn/Xwt7PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d74dKhOSGki3XNxKVqPOPuXNfMbVEON4dJlBwvzN/q5bdEzOmoQrWvEoebpkhX8ymYSXzrWwP3oEhsgO2U1X7M/EQTLA3Lh/fcuilEsOPlzrEVO1Em6M7JggEJseE1B1C1HEBMgGiA4PFEMbh12D8L4bOQtn1qW9Y/NH/5bNq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq3Uctdd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f2f783e4dso5070201f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506394; x=1741111194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIdjBnojDe9JlRJkQtXkq6PiLeEhZjPQxZt/O+Cfesg=;
        b=Oq3UctddCVKuMCtJNRw9Ot00/VsJAwsQoNxNC/qZ7ZSDgRkVY0p6ZJE1i2W/7LFIW6
         9fgVFO3AKOSfoUatOjMimfd1+7vzWz/DTmlHjsm5PTu5bDQYewfPEpc+W2YRi2Anae2N
         N1bjtHAPope6Fyj0xHtPEbvy+65VUa569CJmHZHz8WvGxnqsaUgBt11OAKU8aWizsJqt
         uDigvuxX8zke1tI29/B0R1F7gMzw6KajhQ5esVI6KE0bN1JDEZpVhOqJrOr4cKZeFpjH
         qo8zrLUy6Pq+XcfTl2PyJEti8bJ0sZGRrsK9ftVnmEMSutD2s4nR/zocswZuYlqWkps8
         z03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506394; x=1741111194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIdjBnojDe9JlRJkQtXkq6PiLeEhZjPQxZt/O+Cfesg=;
        b=NRrgG0iO9XH18B1vE/EOarTX5LMSbGNQo96Fzz13Dda/VexXshG/AgBXdtZUYcXWmC
         4ujowM1+fXxoHH9Dz5TxZl8KvCKS9c1UjpByIXTuF1cT1Ud9bJG+n8A1npvef71CMKGt
         g+W6xaQWNk4lGvowTTciNOZQ656B/9Uv09z1rriU5D9T677UEsb49wlxoS900lVr09jl
         LAlwf3iUh3gf5ZaC2CJUqmlwurmG9/gSPpvgE0uttQM+x4smz8soI5Ht9B/j0GnYPtnM
         yv51sbNXu1sy40hu78Ibn3jL5G/fgoGxWz4vAvMtrSwU4e8ianwW9/sTEZ2Hq0ZXSbid
         QOMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdcff4SRzaMGvtWNojsck6fOqGbXLQqicMvRm/DizT62qH0YbhG43bC0UG9rT+3s/qs7k/xKLrQZIKE7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+vjrFC0jNKy1WVpiiYlh3BPAxsK9Qlti6tagCrBAQ/HFFGqd
	60yCPPsGlzgBK9V3tu0gVRWkMyQdP1APNFUBOgJnkDZN5WlpGPM/
X-Gm-Gg: ASbGncvHJO2E8zmzTdext1d8INKemiZAVJbrOch4Hw09dW2Q79MYMbFFtKl0LQEiGyu
	vFsaBQi21atK7bxPVAAaKuuaa717wPY+GXE6O9rRYoNkh5fAMG3FshyOyOhQVgnWm98wWQf+3JJ
	s1GFV0fOt2zNLGy+/2rSFWhiidSaetBcbE2rhkPDWNQuXNV3QX1s4OoCgRVkOQEjt/0eX1dRXaE
	/ws0FKyEFa451rh2aFekGrNSou588wb6/h3QbgBvyXZ/UxM8+CQAI4q3o0OWHzxN2SgXIvAtlcq
	SPcSq6wyZx74hBJDFyMaxad53siX
X-Google-Smtp-Source: AGHT+IEDK6mCAOgu8hG/ZIDX6sti+i4PgULEycQ5M/TU5713F8zbTbDTErKhL+ginH4PGoNCQwXC+A==
X-Received: by 2002:a5d:68cc:0:b0:38f:330a:acbc with SMTP id ffacd0b85a97d-390d4fb02b6mr136963f8f.54.1740506394420;
        Tue, 25 Feb 2025 09:59:54 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:53 -0800 (PST)
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
Subject: [PATCH v2 12/16] drm/vkms: Allow to configure the default device creation
Date: Tue, 25 Feb 2025 18:59:32 +0100
Message-ID: <20250225175936.7223-13-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
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


