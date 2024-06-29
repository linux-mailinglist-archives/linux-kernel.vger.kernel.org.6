Return-Path: <linux-kernel+bounces-234967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CA91CD9A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEF2833B2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46381ACA;
	Sat, 29 Jun 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mkMtK7Sr"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC592574F
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671342; cv=none; b=Wa0oCAnkf5kxbEFOQkuovK3IvrqiJj2n19UGmuTCpsenkRXFJUDaG1Gw9aeio2eDHMTevZnLzTdVvDnfKRAiSiEgtDkr2MaeOmRJo1gNbkjbirjg+HDChQh+xF2B6j23XOxB4KPhFIUvu+twlzz8KEaAQllwlaxiidnQQgWrZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671342; c=relaxed/simple;
	bh=uIaD8ZBxLPhcfgj7aofsksVVm3xFYi0A9yZhtMP0kiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVycWKZnxcZGGVF/ygsIum+z1+pUTbUglPQ4Pu+gJYyXWJfv3abIRg6Zi9UAgg1pKJxvWDRN2OpMFPgt4saAHYLYwOOHnaETDCEBtSqYlasv4i56E3qOnylX9/MJ/VV5tV5z2pi5DiYxFELWl8RQs8wBM4Y+H13Ia5/O45bCjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mkMtK7Sr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fa94d0ba3dso795285ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719671339; x=1720276139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2p5XLNwS2YRBahtSdOANhzhq5mBjZgumL1aQTLRpZko=;
        b=mkMtK7SrdzT47/t0IalOe/AYnUIi8fDYx+cebRtuFLEzwurtO/brkoHnNnygNSSFQz
         AhgTMApQO5hW6cXJippjsa0Dvtr3uoSN4tpvU2cyQ1+GF627zarI8lB/M01qdMo7bql2
         9LAh5p/mNpAnGbwJ86MXdFJUaB4/HQ0d6dEaLkd9nTAeUpdZr1Sr5tkYlwq9hzJGCHoH
         7/NKadoTfM7EDktUXMDWrUZeAyqrvKmjMchhUykmOwwFuGXJV4nnyNvFfbPQYrprMAtb
         FTNfKWEIM7OR5IQQJ7l/tW14mFnIP/c0/ng4jkGNyXhX5OUV+x8cMBZ6AkrMKRJCKnOi
         KMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719671339; x=1720276139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p5XLNwS2YRBahtSdOANhzhq5mBjZgumL1aQTLRpZko=;
        b=BZy11R9JLPU+QWiVX4RaMX712wpdGwYt9y1P/e49QFGKswBFy9XZ4N5OYnM/O0u3SP
         1eGyDcRIRiT9R2w1erglI1iHZmd9KV+t5/ZOqvOEMzuCN900HFLOSC0G7kbfw3bR+9XS
         lj1qCvKvkJNI+687glfibr/mrUV2INzTIrTXsdS3Zq8onP59WXheo3/9YKXhdXLKtdFL
         lIYo4T1pCyqbLux3BlHDG/kRmjqtYBwU3Z/Tnxd78NFVf47gO4YnA4xDH00VsqM+oeH0
         nHvneBr2SGMH+S+bSId0X9Q8DF+6DQtjh8mD16XFEFQlJnyMU5Qi5vd//n5Hy5zaSJ+0
         qKXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCfn8pANzrm+KsGQV2mFL6fQ4QULvkrZdeXViZMevih0vjZslvXTzDzaMSrstqICd4Q5fpykMEbx2bCi/yCjXHKaEHwoHfEONE4THB
X-Gm-Message-State: AOJu0YzdeI6j+Ny+i6fywQtQJEL0ZMbBP3hICAgE212gGc6ROj5pj288
	sC8fM5ofyQ2nTINrMjSSE9V5OrUK428wfWu2TjbBknczT+gmXDhenSHaY+r4SK8=
X-Google-Smtp-Source: AGHT+IF5H4C/jQELWTgkXFGgHR0QJ7TWYa1ahOViweIVG8k2UjXlw9gVU49DkNGyutaZsrjJXKy6kw==
X-Received: by 2002:a17:902:ea0b:b0:1f9:ecaa:75e9 with SMTP id d9443c01a7336-1fadbd395f7mr10861945ad.4.1719671339216;
        Sat, 29 Jun 2024 07:28:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568efdsm32821455ad.193.2024.06.29.07.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 07:28:58 -0700 (PDT)
Message-ID: <53d0ee02-c33f-4fd5-ab14-cf28a618a699@kernel.dk>
Date: Sat, 29 Jun 2024 08:28:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with the vfs-brauner
 tree
To: Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>,
 Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <Zn76C70F9QB_Z0bw@sirena.org.uk>
 <20240629-gelohnt-widmung-b53f957cd69f@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240629-gelohnt-widmung-b53f957cd69f@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 4:05 AM, Christian Brauner wrote:
> On Fri, Jun 28, 2024 at 06:59:39PM GMT, Mark Brown wrote:
>> Hi all,
>>
>> Today's linux-next merge of the block tree got a conflict in:
>>
>>   fs/stat.c
>>
>> between commit:
>>
>>   0ef625bba6fb2 ("vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)")
>>
>> from the vfs-brauner tree and commit:
>>
>>   0f9ca80fa4f96 ("fs: Add initial atomic write support info to statx")
>>   9abcfbd235f59 ("block: Add atomic write support for statx")
>>
>> from the block tree.
> 
> Jens,
> 
> Can you give me the fs bits and I'll put them in a shared branch we can
> both pull in?

It's pretty far down in my tree at this point, so I think we'll just
have to live with this conflict. At least it's not a complicated one to
resolve.

-- 
Jens Axboe


