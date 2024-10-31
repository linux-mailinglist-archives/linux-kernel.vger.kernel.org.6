Return-Path: <linux-kernel+bounces-389994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486B9B7446
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47B81F24E32
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314413D53A;
	Thu, 31 Oct 2024 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpWTLLOx"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B08C07;
	Thu, 31 Oct 2024 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354575; cv=none; b=nkeyf3zq3nwOmIpvhmDTBQEMvOJXV7rWgyyGuMqGMLuxVqI9PGOimUXHWS1QoC1UdquXY+ZSTtxPUrigwxPKTUkI1DIIVPVwvfDBW+r5ey4SPA26YOuseLeb4A5XC1epUCFkQ978j24KiyKidFEyDJ2NKWKlwdlJJr6IZZJiM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354575; c=relaxed/simple;
	bh=uB3F6rWl7NKDcN7l7yrWc0Lo1FjNcHweWqEb3fTxcgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzkXlCUxbZbwNRwgck7dA43h9uTnqWgH3QLIodtnaYLW+FoljXv6k1XkY0pmVp8bgXbrUNpa4thDixR8u+kEqI9qFLv6Aal8VqhQcJ5Wwfn5BxUuHPaYA2x9/kZfmF8BmoXyAmr4nog4I/ZzAcriHEaAhaRmrhaIhk10W2ga2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpWTLLOx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7edb6879196so462894a12.3;
        Wed, 30 Oct 2024 23:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730354573; x=1730959373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqjepxxjP8c0WWuxF6ErmPuQVjeddHR/ym0Vn+DhiEM=;
        b=GpWTLLOxKMXvCp976mU5TqcozX1siSlaHXs48WVPT2z/Xsol4AFAnPuPfzZymH/4R/
         0zdH9wCNcoN0mIUTW9RpbjvleVjlZPWUyeP4bP0unMukt/F/6Xuig41ytrqWgYOM2C1E
         9upbKcGBRUVUsz/cbMg44EyImOPwd0cyy/HwK8JTkCqVcdgI0NOA+JjMiyNA3kyFNDzY
         T86FT0T7m0QiMR/L0k1G+8lzEDfK4gB8fV52f0lZfd3vKsa8ckdeu4kHrglaU1eD31QI
         KBFKAo2HgvItf8PScenJPdLqluIFTZ8Qiu+BZAC2vj7xzPpP9oIE1mJYAxIOvixIlt8w
         FNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730354573; x=1730959373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqjepxxjP8c0WWuxF6ErmPuQVjeddHR/ym0Vn+DhiEM=;
        b=SsghaKVaVNnOQnvq+HV+N2l7U5dsTkF+y/kSk0p7l4hYtoNFgdaHZ/vbc9XxQmBfBl
         /o3AJRUd8irjmjNG6bzbngzvNof6ZKaYaXucGXBTghbPls/1cayXvP/q6rD5AshG2Y52
         t8xrvWIYu3YHrnFhizVjDhcpL+j6ZyMCBx5tI+WGMGbZ3JhXj5YjeeDKj9YrwBsdhL+s
         S3H5qGdjC8JwI+cuYkyF6jCDNmwAPZGtfd/Wu2KUCX/RegoBA9mk+da+rWwJB0aMZ0bM
         iG8IfyfaAAEvv3917OzE+GO+CehLiFBdSODBrom7b+MoDZ3naFnRxORevHwqyFXpO8FP
         c0ug==
X-Forwarded-Encrypted: i=1; AJvYcCUa4Wu1KOkKsOCW0RwkZHJ166rgA5T30M0uveY8Vyo3al+8SM36STwO+RIKJGpjRLvoglshUcrWVqazvjw=@vger.kernel.org, AJvYcCUzwTOmM+MLetGwVB5JzOCY6fOATIbK/mLNMlCGy1BbuEqE42as+vMseBKmCSJq7gi97w+pznIXjD3sRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKVC5QLMwdgvP6M8YWXUF2Q8oUCFwOT6C0u6G3krT3M1K+BKX
	SFpl5T9bqcDWHnjPEyNjqSRxEy1nUSzBmmpq4dnSgRGsodj1laDY
X-Google-Smtp-Source: AGHT+IH2emVIjoMWFrjRX6hnx+NgETzXJYEtgLIJ2/e3w4K26BG4hMHqaDIqawjsginSdzbPOpzc6w==
X-Received: by 2002:a05:6a21:4603:b0:1d9:975e:2bcd with SMTP id adf61e73a8af0-1d9a840c529mr23185331637.27.1730354572820;
        Wed, 30 Oct 2024 23:02:52 -0700 (PDT)
Received: from ?IPV6:2409:40f2:e:4b75:a7f4:68e1:fad8:f425? ([2409:40f2:e:4b75:a7f4:68e1:fad8:f425])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720be493966sm427307b3a.152.2024.10.30.23.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 23:02:52 -0700 (PDT)
Message-ID: <4bb45cad-293e-44ec-b67b-2410231b6031@gmail.com>
Date: Thu, 31 Oct 2024 11:32:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.dev, perex@perex.cz, tiwai@suse.com,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <28112e29-e326-40d7-a550-d3466f454658@sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <28112e29-e326-40d7-a550-d3466f454658@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/24 22:40, Mark Brown wrote:
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
Thank you for the guidance! I’ll make sure to follow the subsystem’s 
subject line style in future submissions.

