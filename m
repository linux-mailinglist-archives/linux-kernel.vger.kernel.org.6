Return-Path: <linux-kernel+bounces-259446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB894939650
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF441F2216E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD64594A;
	Mon, 22 Jul 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xsocAl/W"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9E3BBE2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686453; cv=none; b=YrqX0xbcepLf3J1oFSr9dn4ElD4hYhC6BubvNAoRVsb9siN7Lx6iliytzhRSctoChwBvgjThplrdFqY+bFdpvSBTQVWFmZ1c8d8M/1EL+AZ16JPH7AutZPlvX+ad5eWlUX3xe7gNguLC6pQBt16k9KI9fgEuXEEeK77SAoGHr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686453; c=relaxed/simple;
	bh=WpOlRs4TOSTE1yLR4nzWEKz1bJL5jPW4Utj8q3Bmro4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7JwCXQrkD7D7mypjHQ2fhogI8JWGeqMu0qUu9IZM6ICZD7I5ngcvwOUt75csaDwznFxDRqrIJHnECUYxafTnDajLrNFXqTHpLom5dSVKgb3alPPkJo+gkwTrH6f/CiHDbNztZmKqyVNMqrHhBHdsKEItgDOoFJIS3sjUKF62hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xsocAl/W; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb80633dcfso435141a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721686451; x=1722291251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+nljKvLkh0rGWIbsB2pQpM9uK/ktoXnRCGn0QKA544=;
        b=xsocAl/Wx8NQmCbmrLjViOuR/CEh2PQ7Z/x1tAdc1b93u3fuFNwiTdrg7EZ/AytSSY
         O2x9qFVlng5oxEaM56V2qJizOc4vvz5VTiNUHtPXQciTKL/O1lBrI2DPX+EhSwmSZYjp
         DY0rUUWBSltZh6wgqvUabdzpIv1mV/bfQqSQhsdkZndGvxCXRXhHXTZ/Prj1fZnngWbW
         2NJRxjzla9nj39LsX9Bn6SdnlWBllFr7FyhTLnyUqrNvCISuEKEaCPBQBr854hA7h7YK
         a5XcR0lZ7G8LSxTi6t07/Xm5GXJNRGvaRXB6VAvelM1qkQSzPuwNrwOB+4MrZroX4HDl
         29Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686451; x=1722291251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+nljKvLkh0rGWIbsB2pQpM9uK/ktoXnRCGn0QKA544=;
        b=YWuGLBfpIbHZRctG2vZl2xXWZpfj1/HKTtw4ncvNKE9EoQ30wVip8qL63O/+hB/Z6v
         jHQhDG04Ms0hTxkhmi7/FVHX6Ayj2OsjISgzQaqJUiXHiVaceDjTMwiLUaba4UVptszn
         p4N6VYxw9ORKhENqX13Q5R4gvuIc3bdtYO62MZpBB3Rlk7o8Js97zANPM48KBcFr41j+
         XKEdDPEi0c3I5/z08/v4eKDaCo4DWYhZesg8wsOusBSN81YVnBNcgU3iK54PUf2tG24t
         FmBg1KV0LV9EsFEOJ8y3MKO4FNqjZ8FFDp8OFwx9Vpy8c9+pHqhcBEFRXdsgjmSRT16K
         BuXA==
X-Gm-Message-State: AOJu0YwFypOfAfEF9pYYCntdRCOc6Ad32PW90GF3XA5FCmJQ+qfMDU9q
	JVih/Qm0oi9e+hrMSYwwz5fGHewiIXJrs1J/FrKCwHqITX4Fxp/bpqmayp4tFtE=
X-Google-Smtp-Source: AGHT+IE2S4TxHAoAj6cfc17mler1Q209Xj+EYn/BpQ9nbAqCDBkkQZRbXDCslzfR5c4eR2owAtOsBA==
X-Received: by 2002:a17:902:e749:b0:1fc:4377:d946 with SMTP id d9443c01a7336-1fd746034e5mr74208745ad.7.1721686450689;
        Mon, 22 Jul 2024 15:14:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44d179sm60356005ad.212.2024.07.22.15.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:14:10 -0700 (PDT)
Message-ID: <6aa71f3d-9eac-488e-9d90-be3b806108ce@kernel.dk>
Date: Mon, 22 Jul 2024 16:14:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240723081113.1487a535@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240723081113.1487a535@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 4:11 PM, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   2554b855a2f8 ("io_uring: fix lost getsockopt completions")
>   77feb9505ce6 ("io_uring: fix error pbuf checking")

That's fine, my for-next branch is dead now until after the merge
window. I'll reset it to master.

-- 
Jens Axboe



