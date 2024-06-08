Return-Path: <linux-kernel+bounces-207066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7553901200
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9961F21BC6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091A17BBA;
	Sat,  8 Jun 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkM/7s3B"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A474179652
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856679; cv=none; b=N6/uQl0GPfXJOHC9zCeTX4q4oO+bt09moxsb7cC/RCbpfJd04i/LU4w1D+Qkwz0fstKO0FLdnMUTywxHa/nkBSZCMJrEFZHrRxYNMx8zlCti/Zo1d2Kx5IuzKjJ+Q0ciL+wrPJiw23miPrfcSkn0HVLsjPs9+FUjh8qmIgtIte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856679; c=relaxed/simple;
	bh=lUHuy8Zfz9urTlm/jQeycQ6F7jtrAN9u++rvVMTwTgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=II+ILLJNSuni2ecYLsq6o8gxJMb9mxAQyWi/iZfDv4uW2LFkgr8JiZsl5f0aPVVEaSaiY7LRHXlXtLgEm3zYDfcATL0EA2iZ7bbOdu/aiASwngV1UAudnLxAHvoHWhhaM6fNbdhyBxBys07jdylqFbFoZTrLh3XmJYOew99Q6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkM/7s3B; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217f2e3450so2005215e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856675; x=1718461475; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3xUXLeXJa7g57nR3Rih0dUWygv43+3NziJlOMTLS4c=;
        b=MkM/7s3BdonbSLtkq+3dkQOqDYsf2ynPHvl4H/pU6e2hfJv/VmwW8+FK6V3loW7pwS
         grguLgrudIcJ1ptPAq+XV6/JiYi47CPdYk96gcd6LiPGi+NJ8JHMep/GjrkNWsSPoIu8
         sYPKYg6oSGDQD8gKLbQluMZoYjXraG6Oza+l9p7q8XrCD+DzcUo/jEY/chsE0+YfVjIu
         VN1l1Jv3nec2flg09SmILpdIy2Dn5PrkaupHLzjGoRVrwGfGLx8S3Z3b+TDfT7FRsduV
         7wZ6fNKL7JDfwUC0d6E30mtdMdj9rhPdyyTFvprvz1MWDLq4EHEiIe+CMlMvl0oDRHhC
         yVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856675; x=1718461475;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3xUXLeXJa7g57nR3Rih0dUWygv43+3NziJlOMTLS4c=;
        b=fOMe9cFO/hccXxDxI5Y1l25eO3uPc7C4bizOBxitqmPVAlIHS0Co5WU//atP3EKM1A
         n4RdhlXng7Z2TmBoYlDZoeMZj4lRYq7HkCgsecEKVAO6NSB9kMYw2BM8P8tLUjH/m7vy
         qqrZKY5JjPBKJVEPfXpL3wivorJvmiVd1oEmj8LMimm+W7mt49QIq1HPDsvzjGayF6X1
         A8HcRPIYy3PgBzNgVKGnL4pkUcBUOibIEh1NFh2nuQXX2udEugbiJrFh7qhfFmsk/TvD
         kBKPP+2NtWZscMflze3RdJmWP2ZJ0aoT0PMk5Iilkn+tgyg8EbrfBLwN1i+JqFs+R8H1
         +umA==
X-Forwarded-Encrypted: i=1; AJvYcCXEtMZVZoATVmSEnd/INE6FY/KS5qr4PJyxsnkd+xqKrIiCFzdt8AyLpjoL4CjkxKz+LIgYR57QESc38NXkR+kY9f8+yQ/b46gGU31Q
X-Gm-Message-State: AOJu0YxtEkusZeilFZ6m/dgUdNVLTESqgTzQL+/Kmty4JLR31Wga/gOf
	n7qGLBbKIrtqJf6J2B7zRkxpp+TXSnMLVPE02TY18ZnMAtqKjgJGHALJ2iZti7A=
X-Google-Smtp-Source: AGHT+IFmaCUQ01iQpATq/GX8GTofXo5bwpAglPLwHfhcOwikEZDRyVKEQD6qy8rV6aM+BrXdDmp4sw==
X-Received: by 2002:a05:600c:34d5:b0:420:fed7:2903 with SMTP id 5b1f17b1804b1-421649fbfa9mr53053035e9.15.1717856675259;
        Sat, 08 Jun 2024 07:24:35 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c738bsm86538485e9.32.2024.06.08.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:24:34 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:24:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: samsung: midas_wm1811: Fix error code in probe()
Message-ID: <01590109-cf27-404b-88ff-b42bb73ca1c6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This accidentally returns success instead of -EINVAL.

Fixes: c91d0c2e198d ("ASoC: samsung: midas_wm1811: Add GPIO-based headset jack detection")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/samsung/midas_wm1811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 3a269c7de169..bbfe5fef59af 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -623,7 +623,7 @@ static int midas_probe(struct platform_device *pdev)
 
 		if (channel_type != IIO_VOLTAGE) {
 			dev_err(dev, "ADC channel is not voltage\n");
-			return ret;
+			return -EINVAL;
 		}
 
 		priv->gpio_headset_key = devm_gpiod_get(dev, "headset-key",
-- 
2.43.0


