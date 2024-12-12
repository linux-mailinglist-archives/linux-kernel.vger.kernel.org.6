Return-Path: <linux-kernel+bounces-442988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AB9EE513
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4FF282842
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1199211A0C;
	Thu, 12 Dec 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVcfcMdG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602181E9B3E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003105; cv=none; b=kGuwDClN1b8SUlKTVSOYNpw1SvqomNHjIcswtk4thLFys2cYAdPf+j1RaCXLRIUPsz/v7rNElZlUsXEBqC5C5MdhYv0luzr00IY/zCfHozAm98nlRdzDW6otIrzHzEnxK1qjcY63Qt44banqe48zbPa9EUyQjN+Rbi6CmQS/i/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003105; c=relaxed/simple;
	bh=sgb6rx6Ubncn+ZQjyakieXna291FTKXhuXB6pqhFDNM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZacTFZ6cOYTYt5v4UTRPiQhKEhEezQm4G4/fwTum1If/NjQbhjxWJQYI2JFcYKxF/J8wnVhUaJzitOhMUtO9omBZ4NQ0z6ZuGp8Ew5S8S4U4vcIGnGanzPNIYNR8uoArgYsnL9tRM9QVPd7FHWoOqXnCGlbUvheKL1yEop0DefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVcfcMdG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43624b2d453so5486095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734003102; x=1734607902; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gESUwGVm8WBjqVJACEoM8n/aZXcQ4Fx33aNt8RmViA=;
        b=iVcfcMdGafECUbVi3ovQIkPAUqh1MNOlZPE4mIq1YodZ3GJOpgUCMcza4v/IUliQRn
         Dl7H941J9SX8378eKVrWn/JttAwPJi983BBR5egklPA8+0fOu9199QcpOJELJGVnIR0G
         jo20um3j/xish8aAsZflzuylPN8U5sZNQMg1tygdNWQgS28pa+3WqJrofQkmauhNLy2f
         UyywjNXtfltv6vpiL08p6/TWnHZIKZhxHQeV+ZFDXhQURvkw6/i4HrUQw7OaUTbo074/
         AEZV24Im7OgZOMox/aP/HD9nJoQoeXMtbZEKCyCvP7cEfm/9X/IiYxTSNHXmUfpNp30X
         lOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003102; x=1734607902;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gESUwGVm8WBjqVJACEoM8n/aZXcQ4Fx33aNt8RmViA=;
        b=rFVfByoATk+sfMQMouGoVXm5VCsDKa0/voqGaWlKNlVYIU+6cZAUBj3kTn/KLXaMdJ
         msS4jkw/nXW7F4uUrDRnMdRGfb7l0HoKGRipVFogVL6vLbqaWtQtLAHwqIEPRSkHBscS
         zyVeku7/h0svJXw+q61lEx0kYwjNQ9JnXytuEC9jDyy/dbweHehI8hj8853tYp1083UC
         3zfrU5SKM01FpP41n/Ug09lUuY/ngYYjI9eRRb9vYx71+fHyOdqr9MG2+dSA4YP/TlYt
         LB6bF5DLR0uvTghxIWRvmqtRLsJ2NLPZIMeD87f4Iax+ONCfy2UfFNzA5R1lzTE+8s9V
         Pnwg==
X-Forwarded-Encrypted: i=1; AJvYcCXh5DUyLD2yUay4zu1/zOpT7y/mb7v7KZKixT42+r2S4lWZXIViAOCGZJxHhNQVe7o8cYz9Trlm2P4URtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYu51IzEEKuSLkKOIEIY1WsVd0JyTNfsE9iMPqVcMwERBWzJi8
	cofdA/08XSVY2k7IxSKUPjNomODbDYKaaclH6V5lBYzny0b7SNeb4r0HCVQPOjg=
X-Gm-Gg: ASbGncv8o8dWiunIW+S1qj+JlsOK0mbKgDQ5ZKEvUFpOZkr28fgoQHoyUjAm8PrR2+u
	lissuOaI9LI2We9ijYYwMVmnok1JGHm/T7BWP/uvuKLG0q9Iqz3Jn+9d76BRT8plFJv1rbbUM8y
	THmOp54A8sK3aafpyORMOJBCkN2u6Kn8evV2QiHSln+Lge6K4RArcPSN4IwnDyMZWY+c+HgteQV
	47QupiFVkm9izc54FO7Kqeukwuge3i5TYb0EBJ0kierbJRXzgBo5AbnpZP9rQ==
X-Google-Smtp-Source: AGHT+IFXD9JCROyiJxtYSdcxXayCgPwhArAcMYowgXbP6P19iREmdzEMAFHi33xiUeQM1gepZzrOHA==
X-Received: by 2002:a05:6000:a10:b0:385:faad:bfb8 with SMTP id ffacd0b85a97d-3864cec7d55mr6267275f8f.41.1734003101646;
        Thu, 12 Dec 2024 03:31:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dbbfsm3727812f8f.97.2024.12.12.03.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:31:40 -0800 (PST)
Date: Thu, 12 Dec 2024 14:31:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/vc4: unlock on error in
 vc4_hvs_get_fifo_frame_count()
Message-ID: <02c87d9c-76b8-4d93-b0da-0e4f7d4952ae@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Presumably the default path is never used.  However, if it were used for
some reason then call drm_dev_exit() before returning.

Fixes: 8f2fc64773be ("drm/vc4: Fix reading of frame count on GEN5 / Pi4")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index b42027636c71..4f524ec126e7 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -522,7 +522,7 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
 		break;
 	default:
 		drm_err(drm, "Unknown VC4 generation: %d", vc4->gen);
-		return 0;
+		field = 0;
 	}
 
 	drm_dev_exit(idx);
-- 
2.45.2


