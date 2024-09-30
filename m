Return-Path: <linux-kernel+bounces-343468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61A989B45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D661F23EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414731547F0;
	Mon, 30 Sep 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbRFuqF6"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C114E2DF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680806; cv=none; b=bS91PWJiISVAqN7LQrJ2W7XQuMqC5Bqf6EfqIfqgF5EuxOH0uVwfpElR0HKUVhpG9t11W0xx3XYEflhZz97GrUJhk99sywUXP4Xmfq0YbabXmBnBzJVr738MHARYUEsaphbumVf/gl2+4bYwd3gJOjgP5l0Vee2erZws8rTS73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680806; c=relaxed/simple;
	bh=kOS97WzXTFsa3idOVPtmyemN/Qc70yCZwBWtU2dhk5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YicIGZDVhnnzntB4ZIVBJgR1tgpFA8ot2dLxOrP1++H2lK9UbnjLAgijNfzdCLv58ma9zU2oexGkeNxToeWRrVBj6gAbLk5PrSWahDUauz21zuGj1HAaCKlZ10TDAz2B1Sg6tqdOIENnUPhlJFXWKRZ57rJx0cXIeiuSHPDOCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IbRFuqF6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c87853df28so4504585a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727680803; x=1728285603; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rw9AwEY0T+uAx5ZrPxcoQOhNORL8BhV39Pg+ejN3+4E=;
        b=IbRFuqF6Fi1N3vZJhyi7LjyOXe1ns9z4XwP3jyCuowFxIMnsJVtEcq5MzrXR8EBLJH
         k5yyvBBhH3ufdWcpaluzR2gJ8hyI4ixHojQ77sJxzeNNYMB3U+1OziKacQUgGeNVEwzw
         DJv9Txhv6qBlMxZMmC47gqVObgs9VJTSpVTKtN/ZTQhqDlacJGYPF9e1pl3LA7YkpLDO
         LL79V6oiNGg3RQAad2xWSLxgZrecfvwMJCs7L5Mdq2aPoSqNL6yDtR45GzgA+jbLBoCO
         qMnLfb78RQJrWqGxq78gnWk/7ZeWMpAVgG1Xbww68XCDReZT1iECA5w0XEG00KJR5Rxa
         +5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680803; x=1728285603;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw9AwEY0T+uAx5ZrPxcoQOhNORL8BhV39Pg+ejN3+4E=;
        b=cdnsdIVu1DrSiEVkwYtO/s+1yspinl+bbUuBuJ9Y8JoQj+NH3QDton0SKbSrI0hbRN
         +dmPPHcFVYysopVG+wJBTmEYtNBNbsCcEwKTLJQVwft9k5qjcfuzhtm3fRXV76a5Dbkl
         2QyR9xx+8nBqaXw/GDj9zzOoPwBs0uZNOlyvKpNbszTkAy1t8/FSHXQQ0COlaUTBthEq
         3xVJEFWVpF+23PyOMu8k+/jPg7KkaPXAO/z1ge8r+KfvsVHZovFgp/blauHeT2wGlmjm
         CCMG1L9c46pApGtytRicavoDTD0hflpqYt7vH0YKwUOpsOrb26VmJKoY74NCrX2ukyxI
         136w==
X-Forwarded-Encrypted: i=1; AJvYcCWytrOjgm5ICN+GK79yOQtj6GzxJIe5F/jWYxo+v8p7KyXDQi5B+t9YLJQ5nYl/q0IByhX+/J6mlAM9c5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3mnLKjFFDft6CnYvH6M/A958QdfNprjJJhVLE8T2CGC1BCqS
	LWQJd3/5uioGe8Qqsi2ug4W2Q1rtG8qP8b+lCn1E+DlWeHg3NRQ6Xl32mIc0bx4=
X-Google-Smtp-Source: AGHT+IHYaPJJh3KX8S6fFpqMVHlak7RZvjvr9EdBT5FS3XHOzEltMKI+ZrX1CjMVa4wfhdIBR+NPuA==
X-Received: by 2002:a17:906:f59b:b0:a83:94bd:d913 with SMTP id a640c23a62f3a-a93c48e80d3mr1275629166b.10.1727680803327;
        Mon, 30 Sep 2024 00:20:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947a7asm483458266b.103.2024.09.30.00.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:20:02 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:19:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ALSA: silence integer wrapping warning
Message-ID: <5457e8c1-01ff-4dd9-b49c-15b817f65ee7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This patch doesn't change runtime at all, it's just for kernel hardening.

The "count" here comes from the user and on 32bit systems, it leads to
integer wrapping when we pass it to compute_user_elem_size():

	alloc_size = compute_user_elem_size(private_size, count);

However, the integer over is harmless because later "count" is checked
when we pass it to snd_ctl_new():

	err = snd_ctl_new(&kctl, count, access, file);

These days as part of kernel hardening we're trying to avoid integer
overflows when they affect size_t type.  So to avoid the integer overflow
copy the check from snd_ctl_new() and do it at the start of the
snd_ctl_elem_add() function as well.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I'm going to write a blog about this which explains the kernel hardening
proposal in more detail.

The problem is that integer overflows are really hard to analyze
because the integer overflow itself is harmless.  The harmful thing comes
later.  Not only are integer overflows harmless, but many of them are
done deliberately.

So what we're doing is we're saying that size_t types should not overflow.
This eliminates many deliberate integer overflows handling time values for
example.  We're also ignoring deliberate idiomatic integer overflows such
as if (a + b < a) {.

We're going to detect these integer overflows using static analysis and at
runtime using UBSan and Syzbot.

The other thing, actually, is the we're planning to only work on 64bit
systems for now so if you want to ignore this patch then that's fine.  There
are a lot more (like 10x more) integer overflows on 32bit systems but most
people are on 64bit.  So it's less work and more impact to focus on 64bit
at first.

 sound/core/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 4f55f64c42e1..82b9d14f4ee3 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1641,6 +1641,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	count = info->owner;
 	if (count == 0)
 		count = 1;
+	if (count > MAX_CONTROL_COUNT)
+		return -EINVAL;
 
 	/* Arrange access permissions if needed. */
 	access = info->access;
-- 
2.45.2


