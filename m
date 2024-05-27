Return-Path: <linux-kernel+bounces-190289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CC8CFC75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209E51C21F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDB7CF33;
	Mon, 27 May 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysJ6HegL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BE433C8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800869; cv=none; b=J1i9Fx0+L1WpEcJnnD/Yuth0dK89++OI6khaJsujWGlXVSGewVenL0P6Ou90Nh+MvjE5f21KKjVc7Esa3z5U4VCrsgz3ADlOKxpHFo5SihcL541+oPZtpXZv9YSyXM1dgB5I6DB/kXFbszI7nRQKrbopoyLEz+FYNCq3SkkOw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800869; c=relaxed/simple;
	bh=a1Vl1rci3lVc+qkTZXlXSNM3HyM20lhqxxNM6JEBPyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOzfahxd5Y+ZsIu28+qdTDnsf0X6tXAeLkkuwuTF32BmRqlUoyn+51IAh2t6wjJobnZLR0zzBkByrO9jbhIWo1WIkD7btXY+Y20MztPnZMGIzsIPFPYODFp36xtGMP3WF8YPtP/8JcxeLt+zLex4ncg2k7CFD1irBBUbKMEEYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysJ6HegL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a352bbd9so913754266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716800866; x=1717405666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1Vl1rci3lVc+qkTZXlXSNM3HyM20lhqxxNM6JEBPyE=;
        b=ysJ6HegL8pKKmKFmBkMvi0VDZxOQQs4Gn84uGEwBQFY7/Gi+jLFboS57C/Yhs1sMmB
         yfXnrkGPbEFT83zO73VRqbAV0piMz04tR+TYPzutJqK/FZETG5jz4yLOg8ZJmg4Xm7bD
         bTNqCZgNFeEM2nwBjexUqMcz9/s4rGNYsBlLDN85gQyGHIo4gK2FzRNlNjMUB72R870f
         wVz2WHOYEHimKyHi76Kh4WvIjWM0BJDgN4OS093PBbW7HPVBLu9W1iuvxlaz23y0dgoS
         Lza5YCGsAunOo0MmFKQTlgjvNM/oXyugItwaayV1l4Gu7xdYKSMkPSKgQPSp8n2zxn7g
         iRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800866; x=1717405666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1Vl1rci3lVc+qkTZXlXSNM3HyM20lhqxxNM6JEBPyE=;
        b=K0n2DKxUJlmSeQmw84liMkYwszdw4vYY4poXUpYd/DuLn+uweiFwqqpkVOw6ap8Nj+
         jtyLOtl1suEDr7MEskRdAThCunZF8gXhx0ijOsrwqSKJRJQKbVJ2tlPUW6aWBhXOMI4e
         nUH05yrvndg1xBZN8RlLZuzQ8e8MMa7CzEEAyPerLb7fpoWqclFCaFarNSwZv6698ih/
         rroedMjM+CrCc+mvB06xAXgd2LZPzctVySjPG+bL2LFx/Hn17JG4gQFoGof/4bQHRYFN
         CyC6zJfyWayuHo7j7LBxxulT5uXGFpvUDFzcV2vXxtVuSnHjg2zkZwfNtzC+f7Scjieo
         bcow==
X-Forwarded-Encrypted: i=1; AJvYcCUt4WPefnx8hSWTxstgjN4Ql88JqBuLLroCno6++8M9alLxS0MUh1uefiFbW5Dl7BBvUD6NYMmsnoo3DoyytEvN7C8zgYLAMXtGt6bP
X-Gm-Message-State: AOJu0Yyuf3SBk/H9vJLHHsmmyCzeCsyy+y2djYTyGjfCKQgm5LLIiHik
	TCwB0SelK/XQ1XHbOZdixoPcXsCffcMp7aULWu9LkIg0WyHc0m+eJdlY5NzL5iU=
X-Google-Smtp-Source: AGHT+IF7OcaPLruFbCjuG1bWRANJbFK+TLfQ4b7xj1bJIFQqh4jWRuxYVX51Rrq+jAKwgb46l39rYw==
X-Received: by 2002:a17:906:2a89:b0:a59:c944:de4 with SMTP id a640c23a62f3a-a62616df6b5mr808475566b.2.1716800866283;
        Mon, 27 May 2024 02:07:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62de917c6bsm167617166b.194.2024.05.27.02.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:07:46 -0700 (PDT)
Date: Mon, 27 May 2024 12:07:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>,
	jic23@kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	lars@metafoo.de, swboyd@chromium.org, nuno.a@analog.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <494eacc4-c406-4288-9f7f-85a69add7c6f@moroto.mountain>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
 <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
 <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>
 <6f479ca6-cd6d-4a28-8afe-8b74c4d171d4@moroto.mountain>
 <16a63a13-4c98-4eea-82b7-68213bff61bc@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a63a13-4c98-4eea-82b7-68213bff61bc@moroto.mountain>

I've looked through a large sample of other callers and they're okay.
The bug seems to not be so prevalent as I feared.

regards,
dan carpenter


