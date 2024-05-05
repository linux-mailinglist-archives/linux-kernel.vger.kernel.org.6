Return-Path: <linux-kernel+bounces-168978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B488BC07D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD41C20A87
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCB51CA92;
	Sun,  5 May 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oa7L/8iL"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5218C36
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714915009; cv=none; b=cbCH4B8V+lAvWzwi8XpxNHgEsDC+hGOuyDU2xB1uKcaHhjvTzHswE/IRCOd08uyRTUZnuK1a54WP1TeaO4o3jxxIR8Xk6emplJlUJ9yKrRadXeSEfJd8pGUJBkzgYz+iHthtsuyP9FfhIhor+0jKEMXxT79oa31CDcjIQWMcVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714915009; c=relaxed/simple;
	bh=JUeAkc0VpjizPXONmHIR8AUIb0zyYhhxLFu/R8GLIAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVIHG/SkjGO/r8orHEpQCGJ1zzCOISdOMISgB76U6jcQF1fUhfH7kc//+UccGac6KaDTNL3PCfDMHdC/Vh1wfM1gWjXOIu0JHAWSej/re5qCl9gqXqhriyd395r5wH2gYkmIX+CWnVjq1PSO0jWZRq596XCQkO6vdswC7qnPDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oa7L/8iL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b516b36acfso92878a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714915006; x=1715519806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9gsKxFa2cb/3Cv8aGgzqyrtC++fhIDtBe2EGByMdvY=;
        b=oa7L/8iLZcSq9/zs6B8J7j/VVxqgpjEb4n24EGHZ0E7xVgvS/nmjxb1hgPRhG7X6Qm
         6WO1I/0d9k0JsdziUXuvIw5k9qhQUYNaDi3+mALOjoKV5pCS6eve297+Si8IIg65Rlqy
         40Qi8o4E4uRR/QeSVP7g1FvrkJXLQolsXw8ZUzLbMzaOZfuaLSv6Xr7+4cO8ifOczVFG
         uh79NT6opMcFbYebg3X4JyTxgRpUaTxRVJaOXMGfsuVEVvF7gdDOFreZwU+rJ0N97BId
         5+QDvNnjM1XgUmht/LsRCL9obOLcj/2i0Sv3aVNhGtdv1BFWCFjFQl2nyujSyrnsfFxF
         VhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714915006; x=1715519806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9gsKxFa2cb/3Cv8aGgzqyrtC++fhIDtBe2EGByMdvY=;
        b=Qj8AyFE4XnWPJf8VhnZ69tm/O9Un85WTeTrW7OP+VNme4vwr2NaNNFRx09ZNTGZUta
         7d6o9xkLBt4wqQCFgeyoL3owrCcKnOUdsu5VX2RPDyUon0EC+ZUr7qTw7+Mv5ekk0T2w
         7BD8WHEOkBq8XoNwIxEFeBEcet1ncuoBBVtApItyuBsLgmyE01qrT0UPq4fHGmYw1FQY
         V4Dwqv6d2eCmd6PUsX4sgXaAKBiHqW4ILBrFcjrANwN9FuINnKF9Iu+f++iPnvjlmn1/
         NhFKFCjWCXVY360sGsk05j8aeEdPgij70Cc46fs9py3h0jIseOzOKMMDEmk0VDpy36SU
         9VVA==
X-Gm-Message-State: AOJu0YwszamKT8ry2Ss4M+4bqucYD9HFu/v0S8lUmDecekSgAOM940GP
	g9OBwK8ptQStihI0CDM0N2MsvyYS+vbEtw4G39lXs3I0NxWnzm5sJohGXip3yG0=
X-Google-Smtp-Source: AGHT+IFVYhWBd6jHteuSZMdw9jRtZj/mjMdyHP4zXZreMovDGI55qccUxGeVr3BmjAf0Bb06UPxb2A==
X-Received: by 2002:a17:90b:4a0a:b0:2af:d64:4887 with SMTP id kk10-20020a17090b4a0a00b002af0d644887mr7186558pjb.4.1714915005545;
        Sun, 05 May 2024 06:16:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a528300b002b4329ec537sm4711379pjh.53.2024.05.05.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 06:16:44 -0700 (PDT)
Message-ID: <01a5c073-463b-46e7-beae-c5de4eb0ee11@kernel.dk>
Date: Sun, 5 May 2024 07:16:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 413/437] media/rc: convert to read/write iterators
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240411153126.16201-414-axboe@kernel.dk> <20240504133055.0ca70f7a@sal.lan>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240504133055.0ca70f7a@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/24 6:31 AM, Mauro Carvalho Chehab wrote:
> Em Thu, 11 Apr 2024 09:19:13 -0600
> Jens Axboe <axboe@kernel.dk> escreveu:
> 
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Please add a patch description to media patches. Also, please
> c/c linux-media@vger.kernel.org, as otherwise patchwork.linuxtv.org
> won't track it, and such patches will be silently ignored[1].

Certainly, it's all just a RFC to get the full picture idea out in the
open. Any individual patches/series will go out separately to the
respective lists and maintainers, and it'll have actual commit message
as well at that point.

-- 
Jens Axboe


