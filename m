Return-Path: <linux-kernel+bounces-326206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5F9764ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5A31F24A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE91922D7;
	Thu, 12 Sep 2024 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2TBpeNb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842719005A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131083; cv=none; b=lBq2Vz3mRUdQV/1HIGHFbYI0wGSisYRgEFf9yu9GdBZIN/GOLaiWB52AMT4lnKpYe/82uWlACfHXtASSx0XJ8gWGAimWtZ5Wiwule3SoFQyKarnZaZ/tRsUYp3uYLBhQqF3ZhqmZshf+xuu7EkCMAWVGktJR2BVr+fiHwrGpRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131083; c=relaxed/simple;
	bh=Oqpf6WxrvhQNA4h2zZSOyiF1FFl+HVlkz3Sk47rCQfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jC6alheXEl6TbsKy8dm24fg8YI8T2LmPDOmJgGxUUN+9gJ7FDwx+2pWh7b2hdQ1W5uqdby18HU/dGnMRMnK8828Xka2K4B86g5xBQH1niHq7wm5n6ntyTVJHwhrXqv/Pe7v6WT6BV3gjWre17vCWqSZOJlDyQ3+nwKxFg4h5EHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2TBpeNb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c3eef39eso443380f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131080; x=1726735880; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XjXALdKFm1l8dDisZb/hkbZwF++A+4h5dCECeJO6Cg=;
        b=z2TBpeNbRdd3p6Lv7R/3jZj3CsQ1oAerqK8tln44K6iS2tKujELfNGp39njS9RP6/U
         0eWCohtejIR27hP2l+9tUCR70/GQ54MoMqs4Pz1w237+ZJ9AU9nChb43KOQKOv0YMmbF
         SEAlLNA5nB/MwiVqrBDvv1M9njT/PVP7oAtUSjnpdlrjvej6e5k/3vOOKQAAcwO9zmsd
         WFVEGY5Fhe0lhagsnbwB9PF+gs6IAP0BGSd4FBxUJIBBJynYeG27WSFBKx2lvxNXzUxo
         7s9x/T8wbhQ46Xs5ptJhvC6HUR0KmVaVIcMaYdOvmdaC3ZTn6MlGfqUz6R5qdr8n4mrE
         wyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131080; x=1726735880;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XjXALdKFm1l8dDisZb/hkbZwF++A+4h5dCECeJO6Cg=;
        b=RNEeihoSdBnz4FdlPMPOWF4GPnX7tDEjlCDa1J2KHiwSab3fj9gEoOaDH3U/9hmqTC
         D9QkHJvioiQ4MHXRv1nV/ZjRINpKYDivyfRytj7V6fIhMN+pQMDHvAg7IFwtFdWkWa2L
         ZhfyUGvN9GlrbExzg04w1KB5gmeKG0Ko5zoQAc2xKCiKkNdKXGjrIl3RXC5I2eiCtlRQ
         vIsuI75kIX38rh1KfQBtAZOfwcm74cGMxMY2UDMKF5IVi7P1vHrPf8usF+fvwy2I513I
         XbwP8LWf6uy/DkLynvxu0AFjV+Lw8VELdySCGA//ibuYAGRnTTt4zWKVWxlmO7hdAsb1
         SvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmG0SzxJ5NK27I6ChHFpZKcO7hojV4ZcmTuWrokZfRDS5gRSj8tsE7HkpTi5jqfoDq4T8i/O5RwzhiikA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47jgBq1oTL4NLyWnZVOgPm8LY/bKET586f/JGBKUl5CYMoi2P
	C/PXHl5hMf5/FGim00yzo5DS4TDPZwNNNsfgr7tM7Ux1Fg3bo2H5WLH41DIbuFA=
X-Google-Smtp-Source: AGHT+IHLHcB/HCgQjKnUW7bwjv1XmnDSqMuyvP2XcLeTnW9k2A9PadCFA/1sq6R/1Xv5W3/sfWKXWg==
X-Received: by 2002:a5d:5582:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-378c2cd5da5mr1059565f8f.2.1726131079586;
        Thu, 12 Sep 2024 01:51:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d365fsm13753381f8f.82.2024.09.12.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:51:19 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:51:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ALSA: control: prevent some integer overflow issues
Message-ID: <0f03d569-9804-4617-a806-f0e5c32399fb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

I believe the this bug affects 64bit systems as well, but analyzing this
code is easier if we assume that we're on a 32bit system.  The problem is
in snd_ctl_elem_add() where we do:

sound/core/control.c
  1669          private_size = value_sizes[info->type] * info->count;
  1670          alloc_size = compute_user_elem_size(private_size, count);
                                                                  ^^^^^
count is info->owner.  It's a non-zero u32 that comes from the user via
snd_ctl_elem_add_user().  So the math in compute_user_elem_size() could
have an integer overflow resulting in a smaller than expected size.

  1671
  1672          guard(rwsem_write)(&card->controls_rwsem);
  1673          if (check_user_elem_overflow(card, alloc_size))

The math is check_user_elem_overflow() can also overflow.  Additionally,
large positive values are cast to negative and thus do not exceed
max_user_ctl_alloc_size so they are treated as valid.  It should be the
opposite, where negative sizes are invalid.

  1674                  return -ENOMEM;

Fixes: 2225e79b9b03 ("ALSA: core: reduce stack usage related to snd_ctl_new()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/core/control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 4f55f64c42e1..f36af27e68d5 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1397,9 +1397,9 @@ struct user_element {
 };
 
 // check whether the addition (in bytes) of user ctl element may overflow the limit.
-static bool check_user_elem_overflow(struct snd_card *card, ssize_t add)
+static bool check_user_elem_overflow(struct snd_card *card, size_t add)
 {
-	return (ssize_t)card->user_ctl_alloc_size + add > max_user_ctl_alloc_size;
+	return size_add(card->user_ctl_alloc_size, add) > max_user_ctl_alloc_size;
 }
 
 static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
@@ -1593,7 +1593,7 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 
 static size_t compute_user_elem_size(size_t size, unsigned int count)
 {
-	return sizeof(struct user_element) + size * count;
+	return size_add(sizeof(struct user_element), size_mul(size, count));
 }
 
 static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
-- 
2.45.2


