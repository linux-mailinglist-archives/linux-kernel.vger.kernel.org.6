Return-Path: <linux-kernel+bounces-445286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43919F140F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437B3188A665
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78C17B505;
	Fri, 13 Dec 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BEur1q54"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFC1E5701
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111664; cv=none; b=OEprxpMRoYC8HfSAJiYGMqjhPt6pCy+pIF0rw7hLsglVtMvzrOCOvLLCqJT+fBtrxytcQ5RgYWflS3Un6uOGG62jj1hX8xVP1iPmSHGvPQtnCIBv9bqYtYMIQd1tm+GGVvh1/l8c+jnJAEpvxFWgHGD1FyJ1It7JLDToU7Gt8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111664; c=relaxed/simple;
	bh=mS5remZZ47Xsdl54gElc1+pdGXZZqNxO4fVKAY0Gq88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bWxerrysRIOadyf7lS/k+Z+MDGov0r0kg0OKLvVv3soAVK1pRuPTPtqeMHV2z8Yfo4jSNLaOjxaF8h+gu9PCLBoprZrtMZXO7+x8l8up/K6MY3rrEtAjDbTICPmH0Vrdv7FZlLKc6fBCjouMAWoF7SNCjr1nkPTM1O9OCKua38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BEur1q54; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so7061485ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734111660; x=1734716460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfoQCPAYwIf25kFxsXANckD/Z6DcaeKiLRaR2xCd30Y=;
        b=BEur1q54cUU1UPEgVdNz0FHe+UksJRVqsNn29mxIhZJTd1fbJEJrI0c3ClE2rcXtiA
         I70vB3dy3VbqERlwM1a6ugpvXpAYXjsJyG31weJxWUYfO3ilZbCGUAJxZetxgLnNTZO4
         HkSpHV+/E8wmbZWaGRvQxtNUsmFwltSbBVfTvD4qSOLPh2aCUJNsk8Gime/DDwAN+iAQ
         8Hgir955iAmkIwjWcGdUQdhM8gmOihC4XoaMbQh+xbTsYoyxR+1dt2ywuRlVb0hArgcb
         bS1/WyGj/eATTFN7d+kB9q4dix0k+MmakIuHqqXYUBxT5Yqs+2NdDrjOqczL4OMX9u0I
         BiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734111660; x=1734716460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfoQCPAYwIf25kFxsXANckD/Z6DcaeKiLRaR2xCd30Y=;
        b=Ii49AO+7RyonRoNyNKKCQzyeBAGLZSbvbZX7Uqcj9/40rTgAVrAzegipN3gZCDSyQW
         nqWUxnZKkG5iDwGbyYuUNnIcgxGbppGg0svqvPTXsYb3f2gpyzu1Evnil8N1OfcYW/dK
         YKarkiVJCXyUWz7bbQOD9KVqZVKvg+MHmTmB1T3eYhYvSG5AwMo+iYFfeysvH6YGN5lg
         7lxGT7o+wZgplvdt8eSqjsGo0xBu9nkf1E3cT7N/gU7YhFbXq4WERYKdBG2kuWj7T9rO
         nYDz7doYTQuhA4nriCfi2RaRQfNYkjv4D+tTfjavWieN4pGI40K5RfnQVygg1/2hShHl
         7zpA==
X-Forwarded-Encrypted: i=1; AJvYcCUmil9/awmzz0Lg4eZCC7J+fulmTnP8iVjTgM7qIJ59Jkyc35wSXj9+ASToFXFYP6FK8uI5kjWYfOQgL4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSWhdp58bVS9VTLFIwrXGA22oGSDzbRun2u32E11oBmYhr+Tb
	1Y+LLwrgAS/jcSgcFQYydL80c8KfZW2cYf30bOANLG7Eq8zZWp5Gl5FITKEke3w=
X-Gm-Gg: ASbGncuyjIdzur99PumbK1X3MxCGyjg4bSDRe+rLle78+Zwg/KMYt0viQ4AwwaLFrm9
	ienk230u6BFI/XsIW1OJ1yIDqSjkyUTU0CHPFHn6IKFQg80ZDCA0UB0zvzaaKwOBGF/8Bb0qOmF
	+LV5reC25j2BGBxZ7kmR/6lmvBprp7VjtD4NiPdMTNXsyRKXScSep1ER0AaqY5N8Z/R55PVSS1Z
	dgMf53Xvs4DyEdU4Y/hv95RRdHBxsSHDsCuGGDP/XmxJiDGF98T
X-Google-Smtp-Source: AGHT+IFMakr8bU6f3YZSO/+eHvp/KKhselD2XlkHsnfbAosDkYcEJnpYHg/228UJMmGvVKljs/oVHg==
X-Received: by 2002:a05:6e02:12e8:b0:3a7:e592:55ee with SMTP id e9e14a558f8ab-3aff8b9d0admr46064905ab.20.1734111660696;
        Fri, 13 Dec 2024 09:41:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2425c4b3dsm262605ab.0.2024.12.13.09.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:40:59 -0800 (PST)
Message-ID: <ca3b85d6-ddbf-48b9-bdf5-7962ef3b46ed@kernel.dk>
Date: Fri, 13 Dec 2024 10:40:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in get_pat_info
To: chase xd <sl1589472800@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDQpNvEd7ntUgOAQpU18PErENx2NsMMm05SXXODik6Vmtw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADZouDQpNvEd7ntUgOAQpU18PErENx2NsMMm05SXXODik6Vmtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:35 AM, chase xd wrote:
> Hi, when I tested io-uring on lts 5.15 I found this bug, do you think
> this is a bug from io-uring or mm subsystem?

See this discussion:

https://lore.kernel.org/io-uring/f02a96a2-9f3a-4bed-90a5-b3309eb91d94@intel.com/

-- 
Jens Axboe


