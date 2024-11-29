Return-Path: <linux-kernel+bounces-425489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4609DC2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62633B22A18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3FD199FAB;
	Fri, 29 Nov 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCRIb0eL"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1819995D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879413; cv=none; b=B74CeSE/NoENJWdrb6cOZhRAoIPXywDErucNZj97BGy32uZEdLYNuUa5xWjs37ieX0EiuejGdhMmdwLTk36S6XsYRQ3/Dqx1UvZiPLWI6jyZDiELxpHqNv3Gb5Czc5+yAhZtniKe5NQXRppbjzt3znE1JYUUw0HhkkBn8K63sLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879413; c=relaxed/simple;
	bh=HI5FQjIfiAkbmFy8K6SF1Wgbfg+NQpVtdyas5DXYWcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6nJZ1nQLCQdaoN2GtWCZrin+cKxCgB9+8RRW/MBNoJb6jQcWLwmg1VtDBpfiRzKRo0Xr2RKSSbP1ZNQPuwUNVVUPOYqfBiFb/q5V2igkzj1y+LIkEtgfuRTVSFfpYsMzWuJJY+MYnFeL3N0a63uOeHoEcC7gls6LP8UeEwjE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCRIb0eL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dfb168cbso252903f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732879409; x=1733484209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wehBO9wd7/4qEClAe5Z+1iGP3dGbLJy57UrveIk2Hpc=;
        b=TCRIb0eLVfJZfBu2eRcX4tqBOCUTp8QcFS1oVlVFfdxllJ7Ta+WGM80fj4tfD+FAKS
         6amCjjSndnZp3qBuXmy4lZzBrHD07qvc6W4uCE8WJGZo5uYzsTRxY/6u/K/ty5EhG+2i
         0t23FXp/BXk4oL/29FTgVkVzKvjMW1OQ/rqKTmmOTBbW3QDAEl2BHVegWK/LqFy93R4W
         OytmqD39oP1MCAq7c66M5SC3jgGf1le2R8iw73xW7l6leXmqwM6BhlWLF/I7+SuPeOvo
         PbZ62uLpWVfspmrZpl0dzg5tCGIwkMzVWD2QY32sB7Bd7s9ALFYFLyw1gDUaaroRM30i
         kESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732879409; x=1733484209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wehBO9wd7/4qEClAe5Z+1iGP3dGbLJy57UrveIk2Hpc=;
        b=IJ1Emkn2OYdDgozgIs9Z+N7OXTDhK6f5DgwSE4o2yIqr9GhOpoYUbTDYVoX8g1ci9O
         i7m4FxSLijp7m1jZeCX3BzWjz48XegaDnMVsffiVvj5YIZnQb3u6jOjwuZURvi2dXN/O
         v/oKYjhWLUKAbf1ZcTMo5Fi2cfJSosKeoI+Q16eLVXn+OIjs6gOQhA6SkkU6Fp6WL4Bu
         IQ2vQFJLE1oZQJF3ZbCwA5MFiN2SdHb/DWJZzIPfrKt34/f2oZhFwRUPPgBeoM0LRE9L
         8z3rhuvWxkrNAtXawZEnKBjViOl6O6nKjcdO1mot0/AMEq3wUmTY5ve97ecogceIMeDL
         +HZg==
X-Forwarded-Encrypted: i=1; AJvYcCV4J7OvydVg1YQvuclMOk5pEGC5Bn1aoZ3yAyoD/Ta8eatCMS3P1LjlbvzrVhvb/x4DjK97OGL+yPkYksY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkX46c603cjFc82lZTWY4+nT8qg1bRvfGOpXSME1nA4k0kkAH6
	TQxdcv08rhC8CtffMtcSlttNhmlUgoTe4zoB0cwov2twUpveCXU6BgcGMRHSJEo=
X-Gm-Gg: ASbGnctCl3yhKKtYX4YrDJmvayGN9hxiq6nqT2yqbi7cUbU+XE642OW5ZjXX92ak3hF
	x1dVF8sm8Yc1hDDBj+cYaTpk9lZCnkgz9xKDIs8GC6H5RYVj5uxXdgYa1Piqju0HH0UkGwkP3XT
	tW2vUSUX4fLpJN/dtTLQ+QR1hnAPs3GMqfoX/C5KSrwNz99lF3JWizMY+0tP4T5Q2ibN9sKx+Sk
	UqyNGLVaWek3+ui9J1achmfNi7fdHIs8b4rzRLH5Lb0zFPzJYV89xfe5S7CU28=
X-Google-Smtp-Source: AGHT+IEAXNy/RWJn3Zcpg6BCPHgms/2bmga++LC07nE1WotVMszhnyHL0BPNUcD3C6x+4g0hwK/XgQ==
X-Received: by 2002:a5d:6d8b:0:b0:382:49f9:74c0 with SMTP id ffacd0b85a97d-385c6eddb90mr9570707f8f.38.1732879409622;
        Fri, 29 Nov 2024 03:23:29 -0800 (PST)
Received: from [192.168.0.31] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78120dsm80940945e9.24.2024.11.29.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:23:29 -0800 (PST)
Message-ID: <02029a14-3cc0-453e-b1ea-ec7dd30dbb33@linaro.org>
Date: Fri, 29 Nov 2024 11:23:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: qcom: camss: fix VFE pm domain off
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
References: <20241128-vfe_pm_domain_off-v2-1-0bcbbe7daaaf@mainlining.org>
 <3a5fd596-b442-4d3f-aae2-f454d0cd8e5c@linaro.org>
 <5cccec71-0cc7-492a-9fb9-903970da05c5@linaro.org>
 <d3a8d38c-9129-4fbd-8bd6-c91131d950ad@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <d3a8d38c-9129-4fbd-8bd6-c91131d950ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 11:20, Vladimir Zapolskiy wrote:
> There should be no room for suppositions, the source code is open.
> 
> If the described by you case is true, and vfe_pm_domain_on() fails,
> then vfe_pm_domain_off() shall not be called, otherwise that's the
> real problem and it shall be fixed instead of being veiled by the
> proposed change.

Maybe, maybe not I'd like to hear more from Barnabás on that, who is in 
a position to replicate this bug.

---
bod

