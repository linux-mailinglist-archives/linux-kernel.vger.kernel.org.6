Return-Path: <linux-kernel+bounces-325066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783CD975470
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223A41F22158
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09E19C556;
	Wed, 11 Sep 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw1ZpkJi"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F71885B0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062526; cv=none; b=R56ctK4kAjEJJH/cjDhndaRc4VKup6F5TZDqFSL4pi3lLQOaxkUI0bN+gYrBsvGbrebAVytU3T0qqh/ZFuIsoHfCro8U9WQXAX/8yZplhXiWZvb+N8sVxNDdA6M8jKEA/95Fy/BjtKpdINMdVcejysebtcGhAeqU01rX+ICVgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062526; c=relaxed/simple;
	bh=CRRx7fOA/0xIBJgi4Y2qJuRGN5+stwLbzZrHZDnSfYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pSq6jtHS+605F9XxHm4Cb7nwCUHdZX36khTTFyfe7ED7tS0fWtofx0O79z1h/1b6yUIPQGLMPrK7V8UzbJ5uieE+g8OUZlPO/3zd15PXjKjU8YDM1bTJTd/Wu+6LzvEV3rVNfS3gDGI+bXKcRP1WDCfkmt9ffLJ1gJh/HtA1WEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw1ZpkJi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so4684142a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726062524; x=1726667324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCx961giDzkawX4RkON4d9oRpJgphqstJWVnXbsVBFk=;
        b=fw1ZpkJiGgOGFXTZvAHV2Q+mAb8XjCfou98XtSY+IJVVDc1ClDkJBEkTPhUtm9GidV
         Fs1G5LDNUsv1t7OM3oaMyAs1vqmhK6gw7WblkpIR92NG7IwXeQr3Ng34DqyhWS2/YECD
         XP+I0MZEX3Ve+spAdxMwmq4W2CJ+X1FNr8krMRMo8kAFdJDlEcTsgQS0JC2ZQ0CYL0zS
         +hKOQ0dGGywsI/lCSiKGfSAfhrY/u+SqJSirWXEld3xrOR59br6pwY6FPJC1b7WreYQ2
         G2xEvoum6TKVcNwO1Fhpf7fw7DSfYZjtb5HpYIDrq4tYJa+TxZ3msma+MRpj9FrhPFBZ
         eO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726062524; x=1726667324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCx961giDzkawX4RkON4d9oRpJgphqstJWVnXbsVBFk=;
        b=a52SMN83/DFFJ2oe/yV3dDEVV7DTRHmZRESStQlHZIHYR25t461OYFJas2nEvXH5v2
         odj7vj1d6dz8cHbgCTeYYgnjWWzw6xiulhZG5piQNOxlM4R5YcE0hk2NSzeGYaXRKlVa
         1j2Bt14pzi4gXKoME6+FVfhYCAGxPRDhgeyBP2U3FMueh4oLQ2EH5kR4BSWcL4hTVf0F
         92al+5pt7ZmYhMt2sXLUr+iTV2YjorNb3LmQezDpt0JJsF7pmbDlwROUipMxBHhRSMlc
         g3B/1FWgOxO0jYWPlGdRGYybI3DSj6j0eWMkfNKsfLdEHbwxKIM9Vvd74h3nkTQRt1SH
         +OqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqUVRcC6Gm+ceyTyuDLPg9NOSUhiEYgqC8qDULlx5N/ZDP/miSOKkq+5jqJp8IVwU+A2odTnG0I6jETI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqDbs9Dq/gwKhiiFFq9SrXVz1ZSc1qzkAHMjuGE32lRpbgb3W
	MnAYdfjTRC+lcL+Q4BMDvVzUAeFkyrlniKbClRnHRu5L+PaOYqBZK4UywZca
X-Google-Smtp-Source: AGHT+IEEaBij1LC75ufDL1ammpPlxeRl+6VZZLpg5ZDFJiqcVeBdQwOQhSrfa0mDiJYnHvvijk98BA==
X-Received: by 2002:a05:6a21:513:b0:1cf:337e:98f6 with SMTP id adf61e73a8af0-1cf5e13350amr4446721637.29.1726062523749;
        Wed, 11 Sep 2024 06:48:43 -0700 (PDT)
Received: from maloca.localdomain (d162-157-58-14.abhsia.telus.net. [162.157.58.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8d76sm2989232b3a.4.2024.09.11.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:48:43 -0700 (PDT)
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: [PATCH] MAINTAINERS: remove myself as a VKMS maintainer
Date: Wed, 11 Sep 2024 07:50:46 -0600
Message-ID: <20240911135051.44579-1-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I haven't been able to follow or review the work on the driver for a
long time and I don't see the situation improving anytime soon. Hence,
this commit removes me from the maintainers list.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 333ed0718175..1e6356a1b6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7346,7 +7346,6 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/udl/
 
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
-M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
 M:	Maíra Canal <mairacanal@riseup.net>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
 R:	Simona Vetter <simona@ffwll.ch>
-- 
2.46.0


