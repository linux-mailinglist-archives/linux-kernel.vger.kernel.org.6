Return-Path: <linux-kernel+bounces-542538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9381A4CADF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DFC3AC0CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5822D4E5;
	Mon,  3 Mar 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="td3wpqRy"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC21F0E5C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025913; cv=none; b=GwTxI+3/RzhNGyGzXw1oi9l+n88SI3l6kM6TFgGZQgwMP5TTDFLN1cP6Laj3AioRkVOqSGNL37zlpNdxhjEKAmbOv34WtesTwaS92LnNbm7upr+Q3fodZYmBpzhueuaJ5flIRI/GZpXUOEJvqdUX+6Dr4j2eTSu2f6vqZnQrPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025913; c=relaxed/simple;
	bh=aqBu5lgaIjKfB79ewU8DMYZH9ogDFAvumeNR3vcP144=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJXXhXfg1xmvLF+TD83jaTsP6I+7nY/ASrATdIhAc2OmBt4M+c0IjJg77m0oUT7qZjwFd7yzpH7TEVcb6oOLqCNFosS6fBS/skIEkgY689/cm6xNYxFLnedGQa5qvGkSswAvYhkFLmlHugYkoqWxlodLMMwmt9dHxnINKQKvV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=td3wpqRy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d3e28e6bb4so34607015ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741025910; x=1741630710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvjzyQGR5WjOCFzCpc4mCzksbIOnD4wTL60DVSWvoTc=;
        b=td3wpqRyJzanGMf1wlmlKklI/DI4ZOn7mHdZRYD2IW1n0lZg4wzr7hBG9YHz7jO30R
         8dv7+Y8yVISBqbLhKKffi+4j5pEnPqlP1Pa1Ob+P8wTceBq2u282BQ1rQylPxObO4IWK
         i7Isi0J92lZZhKiUcnwy5kwtRdGidCr081emNE24MS0Bisdnri7t3LXMC/AaQ8NeRP8o
         qvy6a3NhY0i+kvftjXW6LWOMKruyWia2x5KoF8y0eJSyrCEL0SYXhR3/QDgsJXtpDY9K
         IMY6S9jDuyuZCE8VhAEvDIksyn1uZfsNHe7VwZdfl7tKuBsohDJgrDCUeRCxt3dBdbit
         qd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741025910; x=1741630710;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvjzyQGR5WjOCFzCpc4mCzksbIOnD4wTL60DVSWvoTc=;
        b=g2cdlXyoVCPFsCz/InHfMRAxD9BGw86BEvulaLbWzJOPpoUw4puR2CaE5LTm0teVrd
         oh9e/6f2eCKEzWBiuVHyQnnnjgvXQoBo1bjSAewiu8/zL0clc6OTeB/1h2eiraXGdhIh
         WkBMCdFl/nW+oBHFGXqFm26IwMk7y8TNiEgKt0HRAsDKPE3vsYS7iuCRO6Wp+pkCtIeE
         Y51XUC2CDd1WxYb0jjRqiamI8XkNgDfB+tKbLCAO/pk7al+R5C0CdSQcTGsSJF2m1VJW
         uM2NBlmlhYvKm+/+04yMkHpg9QmFqYxDyRLrZXz9GpWWUgB4KmFWNR6nfQUZ5Y2kp53f
         rC3A==
X-Forwarded-Encrypted: i=1; AJvYcCVbupWTvwX1b2Z4chYiXnRSzVntiBSGSBn5bJyyJEI06j2FooM/A55ZYB2ORzsvg6YOFkzlOP16iJAEoOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ini8oXjkinupBKi9GfFW7ymigJy4f44KHnKuozXfVIOSI8d7
	rrLdMzFlI6Vn6khTYequlrmKfMtTnXNcKPn95UbEh03y1LKD9alvdXcm6lnVj0I=
X-Gm-Gg: ASbGnctvpP+TtZjmfCjJoRI/xzXqoBZTCSJtI9XCr9QdSTFvqNBksXei7WS7Ylkltkz
	CpzotOfLNcVompdyMrbc4B48NSRS+wMRLL8UoIiFu/y4DJ5GjN+4dhY/G2N/aGSpBj3Vnjmdsab
	SUD9//QLD0Tms4oeX7Rd+4atSqs/SxQblhDoUvrWnmkZj2lGGroQVFRWrC0yn9p6fUDvgrSpRq8
	PZllg7P3SululSgsvc7sxq2GixU93UqIb/GKiYr5vIzJcf6BskFB/TOg5npgrJSlzl71YIxd4yV
	wSEy+TagEp1L1PMx0EuqU/DL2YUE940Hu0ZzEdB2
X-Google-Smtp-Source: AGHT+IFNdCaZ1XIhp2XJhaxfUE7ndUbdgMNH8GlVjblLMQhKUk1YKF0bz0OwoT+Q4yO5k2hF9QBXug==
X-Received: by 2002:a05:6e02:1:b0:3d3:e536:3096 with SMTP id e9e14a558f8ab-3d3e6e952damr141947255ab.13.1741025910102;
        Mon, 03 Mar 2025 10:18:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f09cac9f8asm527552173.39.2025.03.03.10.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:18:29 -0800 (PST)
Message-ID: <00cef2b0-5a33-4069-b0b7-96f65b6e13ec@kernel.dk>
Date: Mon, 3 Mar 2025 11:18:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] rbd: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Alex Elder <elder@ieee.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daniel Vacek <neelx@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Xiubo Li <xiubli@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250301-converge-secs-to-jiffies-part-two-v4-0-c9226df9e4ed@linux.microsoft.com>
 <20250301-converge-secs-to-jiffies-part-two-v4-1-c9226df9e4ed@linux.microsoft.com>
 <4c4b3d6f-64b7-4ba3-8d2e-d8b1f1a03a53@ieee.org>
 <d5035d88-f714-47c2-ace6-8bd609d84633@linux.microsoft.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <d5035d88-f714-47c2-ace6-8bd609d84633@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 11:13 AM, Easwar Hariharan wrote:
> @Jens, @Andrew, can you drop the rbd and libceph patches from your respective
> trees while I work this out?

Sure...

-- 
Jens Axboe

