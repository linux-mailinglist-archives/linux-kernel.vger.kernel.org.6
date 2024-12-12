Return-Path: <linux-kernel+bounces-443093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791199EE709
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF44283242
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5FF2135DE;
	Thu, 12 Dec 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1n7cW1z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60A213E89
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007664; cv=none; b=bSxG7WKeKR+tSTkfr2lGYhkm4K1UZOFjKZlzjlqU+iYP7Msu3Sozgk4z6noI3kkPE/oyssbsHhU2jIIax6C2A4k7s0JBsSncBa2Ji3aB9FOT3kYIP1/Jp1l6iHMpRbOdTkE7pzpvKFWx+vpKtHPB5WQVT05wdIu2OnU3qetcTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007664; c=relaxed/simple;
	bh=1Ts9EKssjbPUaajtIUeXtbeIZ5MvymgYej7/+BBHFJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AQPBaW+nqZVGefdLxmAgekprhg/RT4hbM2A9EQemvuAcmtiLNvmZwEaxVLteQzhMstL08SujK0BIatJcMu92uE+leb3EJzTcTKTi30QNmuF2OKU8Dln9ht4aaK+Piw7PbtdwGv/ub4V6xsvMSVWTr4KO3SNqJaKZ7AIq9rR39rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1n7cW1z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a2033562so3943865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734007661; x=1734612461; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1Aa7kk3KKfy9aAdx9Y9ApzJ11F7xml9XtZy8ZKLnk0=;
        b=C1n7cW1z429N8uy32cjEurBOqlnHcBCUH3zEyHviNwukhyXZgm75PbGL4xwY2STQFP
         N3dVjVLLzbohvPUZ0crQyFo2KksIANcHg/GyLJtXlizPcH1rHKzrPuPE9Ui3VaE7AB1r
         mQvQ13yTHxQs5I6StSNoFHxEonEsBRGqcwdHVE4bRJTRpb5O/jK5X8j9SHIk5L4eyPv6
         hV+BJnOX48NRFXD0itA2s2KKMPQSxyaHIUTsFGCXM+kyV9/GwtfBGLJj/I0znfTrQ9Gp
         BuA4FzWRNwbP58Z0QDDt2/3phoUsikNfiuMVWi7WFOWWs/TN1xlErvkFOOUdSZ7gcZCm
         SxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007661; x=1734612461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Aa7kk3KKfy9aAdx9Y9ApzJ11F7xml9XtZy8ZKLnk0=;
        b=mtFmlkmNVtS4llHbHY8aMDTTnDOLg5Ws3C7veqpWtYTROo6lLLQOKzO68LXorXJWs9
         7ASiadqS5YNllH/iclE+ux8NGE7HNCfZy05nWzR9ar4226zhAvEznmyZ9BiMfHz1+RDG
         8woJ5xfD9HuHwnfeLg1MOYvQLI8GW/cch+ctRqaJx7qMnI0QuHbUUN0KvyqKERxc1Q0e
         05BJ+SO2egxi39O7B2hK3SWpr4GeewTHLaLDaeoM2evIWhQVxwcQqSK1ik82nyUuu3m1
         lXYHHMtmuPpOdXgAIjpPa7iEhvWQke1cIf/I8hv8KY61/79Hm+Eo222pn49R8VD7A64a
         6PsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIILK0NRWUlZdR2kFROp0AbA4gjMEHcuDFl70bOSNe6zxevilgR6U5ewuXNJP7jUmhDLSQ+5fSKgST1Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDx1QGYi5/mIYUTorHbEpx9ud/7goIBjWwvyVVGuQpNsXk3FfF
	xf/jqEn/RcCKTnxucc3COTgEsZf7E3DjcDsyjJqqSnvU0uieTMrDXsjsyPe3Bj23jY1chkzLmGC
	V
X-Gm-Gg: ASbGncv0yr3NdSmiocXMqqUZl2s0mCJ7VUBFbUKBfZUwwU6x3VMz4l9RnQ8AC8FGvTY
	YoYIlP0DJoi9ZuUhUik7C76A176uy0ygR42Tu8sEY+XYN/5qyX/yP1S3knNC4xvjbxZ4Sn9zGQM
	mKeyVSzuwKz6bpdCvfC5b5mQxvNFiOozJyzHbmqyZcWK69Fbd66XaVJyYMjpzEXAImqfcP99SdN
	tJEEO9Ucb945wiZwkzbHhvB0yHbRywVh2NnxnNqzgmDtfe8+wUmEkNiJnKhMA==
X-Google-Smtp-Source: AGHT+IHG070ZSCDM3VoQ8IcxxgcIA8LmAYT5Wy1Ts2flXAmROuoKHKuI+kgLYIo8ua64rhinlAKIfA==
X-Received: by 2002:a05:600c:1e0b:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-4362256dc73mr30023385e9.0.1734007661208;
        Thu, 12 Dec 2024 04:47:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625553234sm16279045e9.3.2024.12.12.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:47:40 -0800 (PST)
Date: Thu, 12 Dec 2024 15:47:37 +0300
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
Subject: [PATCH v2 next] drm/vc4: unlock on error in
 vc4_hvs_get_fifo_frame_count()
Message-ID: <b61a81b2-0101-43bd-a4f6-09cf3a016484@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The default statement is never used in real life.  However, if it were
used for some reason then call drm_dev_exit() before returning.

Fixes: 8f2fc64773be ("drm/vc4: Fix reading of frame count on GEN5 / Pi4")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: style fixes

 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index b42027636c71..4811d794001f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -522,7 +522,7 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
 		break;
 	default:
 		drm_err(drm, "Unknown VC4 generation: %d", vc4->gen);
-		return 0;
+		break;
 	}
 
 	drm_dev_exit(idx);
-- 
2.45.2


