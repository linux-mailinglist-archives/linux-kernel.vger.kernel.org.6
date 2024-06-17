Return-Path: <linux-kernel+bounces-217010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0889490A9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9485428CD13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA7193062;
	Mon, 17 Jun 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoFRL6TP"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60197190053
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616796; cv=none; b=DRHtTpJwPddccA5YOAutoeT6Wc1GZJU0Fsj9BgXgEBOPyJqgEMfCXmgalrOkkcYF+z1k7Z81sswx5bsVU5wCorrHmjsTRuswMoKkrG0FM8dhRlBvQ8ItgzE5rJOSbXKjrm1wRiEsCop2PI0RXMUpVAwq6NfdIyTIzEJdbKExcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616796; c=relaxed/simple;
	bh=cuDoyOzQS8+YGUYNphhgplN7srLAz/Uq/xuPLYwdlvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PpCjZl3wuLx+b/QgCxlGUHfed6bLIIS7fwk5Jfk7j1H7K+E6bA7XmQOSvV09Ns5iyVKxVZR5ZYvrWJKYAtJoYmYwxp/Jg53orB2VxgRTaoTXjcSJ3AFUZ1dwBw1oWyEfApPLW5cMQAgVSwvfci25bCuLiDk7OAXaTnmWooh7Oxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoFRL6TP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so42728611fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616792; x=1719221592; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XR5GYB9eKu58vQFoGUBee/KjF/Xw+p5AvKjlrAjbe4E=;
        b=XoFRL6TPRXrl/gtBWDcnwd0t7ToJfi3G5PU0wekKq/sWwT4/dOsIFuiV0M4mM12koY
         hbI8u1e2NlwHSMNiwRiQoYBSufnUXN74HdAZVFzPxuQyylAhCUQgeXV6tvzY10y5hwcd
         iZ/VEdnIr3X35cc3kF6toriBEcZ94EiIAfIqQ+6HP/9WU3eqggOJuGsb1NEUR/OO5fnT
         Ls7LtFGP6rvNT7ERd5wyiZT5Wa1kVBwtCFTD3DRRyMZ1cM+Ap96YWCS6vm067kmq4F9N
         NjjJpHi0rRIriVPUixcEZj51HaFjCV/0KgeXyFQigDw9CxD9c2EJ0pI13fawwVMc7mtI
         aXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616792; x=1719221592;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR5GYB9eKu58vQFoGUBee/KjF/Xw+p5AvKjlrAjbe4E=;
        b=XSInJ3Xk7oOJrCsFf10o8jFBj6DwmS18xXPHW5QM1aYrlvDOMcB/KwP5pAoneb7qY7
         9HwLgTaJJWNP2jJRzjd2Axj/P/i4KX4N9LTbs8MrWLdbn61cHaeJ4uHT2AxKx/WZGFYf
         dBq5XjIuNSwGgOyorvPedhVBP+GHvn1zx63lf3r3BI+lvcUQhmWx7vVjs4NBfwg3sYVy
         xlRHQXZlssbTNRTvuPnG/R8IY3ZYBAogjsmY6JTsqzK7wRKiUy6n8A9sLmMh7Wv70m2K
         oOBPhcC8SzBo6Df4Njc2TtWUCWLMpYplY3A1nMbsP1PoZmMmvS5bUXUFri0lMHzzHWp2
         iGNg==
X-Forwarded-Encrypted: i=1; AJvYcCUs//1oEy2IY9HJW3mfYWiC9O27ouA3JJExcbSG0TLIp4gQC8wNJL/44ZgcdbRX4jqAbPNL9MV6dSdY0d3XNPX+JdA/QmMYQyrGD7/3
X-Gm-Message-State: AOJu0YxBXKx6ZB7xWSMnNlbgCLwAdXp7UEJAhKtC2+MIU3KPbQtlbSn5
	gdN1jtohIISjl+IGubEE5FffL11yzLvPTjLxBkG+p1w2xY7IRV3ZZGpFZvOkJwE=
X-Google-Smtp-Source: AGHT+IEa3K7XWz/lzC+j+im6KTvLDjDG7zCAkU3RZRrqaUfwf+xaegKVQs8z15qdzYiqFHNsN+qEbw==
X-Received: by 2002:a2e:9f44:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ec0e5ffc00mr63770771fa.36.1718616792269;
        Mon, 17 Jun 2024 02:33:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bfdsm153872995e9.37.2024.06.17.02.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:33:11 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:33:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/nouveau: Use kmemdup_array() instead of kmemdup()
Message-ID: <a3e8cecc-77dd-4a4a-bb12-c1d6759d3efb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Use kmemdup_array() because we're allocating an array.

The main difference between kmemdup() and kmemdup_array() is that the
kmemdup_array() function has integer overflow checking built it.  The
"args->in_sync.count" variable is a u32 so integer overflows would only
be a concern on 32bit systems.  Fortunately, however, the u_memcpya()
function has integer overflow checking which means that it is not an
issue.

Still using kmemdup_array() is more appropriate and makes auditing the
code easier.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 32fa2e273965..53d8b0584a56 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -45,10 +45,10 @@ nouveau_job_init(struct nouveau_job *job,
 		if (job->sync)
 			return -EINVAL;
 
-		job->in_sync.data = kmemdup(args->in_sync.s,
-					 sizeof(*args->in_sync.s) *
-					 args->in_sync.count,
-					 GFP_KERNEL);
+		job->in_sync.data = kmemdup_array(args->in_sync.s,
+					args->in_sync.count,
+					sizeof(*args->in_sync.s),
+					GFP_KERNEL);
 		if (!job->in_sync.data)
 			return -ENOMEM;
 	}
@@ -60,10 +60,10 @@ nouveau_job_init(struct nouveau_job *job,
 			goto err_free_in_sync;
 		}
 
-		job->out_sync.data = kmemdup(args->out_sync.s,
-					  sizeof(*args->out_sync.s) *
-					  args->out_sync.count,
-					  GFP_KERNEL);
+		job->out_sync.data = kmemdup_array(args->out_sync.s,
+					args->out_sync.count,
+					sizeof(*args->out_sync.s),
+					GFP_KERNEL);
 		if (!job->out_sync.data) {
 			ret = -ENOMEM;
 			goto err_free_in_sync;
-- 
2.43.0


