Return-Path: <linux-kernel+bounces-293433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B184E957F34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F182818CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63913E02A;
	Tue, 20 Aug 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cZ8poHQy"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE05179A7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138136; cv=none; b=RfT0LX5LB6tKUApCRdk2/9E5pDti7cnHdxFnHNACG7jDnp/vT7lNIPJ4/uM+BjVerH2tQjoHuVYHb7OVWcfcglFnjt3vzhG4ZXGWPXszdcynCphNLl1iio9QSZNEp9Dwpzk/f5rcv1GrmGErI+Fw9Z5Ny7a9kCDgnwrtUtxMCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138136; c=relaxed/simple;
	bh=2iyxmBwE+Dhna9XByPTzsauwyf2HIFCEXZhVnfkCnNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwqfQ0gXPQIgdGW0WMAbrzXTBDYpknZDoh3y4PjGKC74kmC70MnY6diV4jVafsKaA0JPMRAQZcJ72cWb9fluZIIn+Q+DQBVk3GnV3suWXLiLq5HNC98eqbei5xzD0PjSWI3LjMZtTOYDX3WMZ+BgzQPy7Vud+QZsAJuJCVpe1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cZ8poHQy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371936541caso2364115f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724138131; x=1724742931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYmRAALLdtRDEwzcXRpN1JVYbuII2jz/aV++mavgkqo=;
        b=cZ8poHQyCdx/jsIJq+PZHxynhl1BxNJkIUYAxmqZqWV4/2iv0wvmXubPk67NUf+dao
         UDwlA2mdwgGBDoYCnqmVZ7XF0ljymfa/7Cupk95qpKoKm3Vp02NqouvoR27uPTcfiPYf
         WfYG/in27Lfz1RHJlHiyEilH9x+GCUd8F/j3YRy/ugdDIdlnJcOJF/xNarpN7QLUC+1z
         JRnR5wdPAvCKQCH6jryIoUjhtH5aqy1ZWkp94CS+bNZqeBXSM0ntatoito+FmX1tjjbs
         8AYZnNkPUTJsUggyGTGfaQBTDIYCAWQbX6z7P9RNNrvgBYi6x8zlEHW8gXIDElkWyIp1
         4PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138131; x=1724742931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYmRAALLdtRDEwzcXRpN1JVYbuII2jz/aV++mavgkqo=;
        b=Xh+K+d4+es88U2uM1NcHPPQpOESeZoe72uVnmumOdI4ZHtjd1W5nb1bvAKW7vzegSH
         vkzu4Z2xmul+IpQxBLRTnVG/gj34+rW/ZFLY8csvk6iA5oVwB9efE+RYXH2c8aq2LFvg
         dbJ4nijKNNXWDj0Ax7X+UHk6rmPnh2B9TURsmjicIL4okUG4fcPVUrUMrprb19v0f4lW
         I20EIQ8/7JeXRQ8XIsmagqMGat/VHb6v2CJknyxMx4rdyLgxU6rnYJs+vkY2Fid//31d
         gT6qY8Z8whO6/zNdIWN7JAvwLEnVKmR151T6h6pYp2UQ0e2CRAjZsSkf0S8yFytSEylT
         9Frg==
X-Forwarded-Encrypted: i=1; AJvYcCUvqlV49BWVlElr0ZZwHpMZ6Itxdzxw3us5Al7wz/RIyrY+lFZYBIBuDqBA7XhEtRQIWLyuBorqM21JTkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLQOmJjqZIQAq+/aekdQOkz9hudV5fWp2zo3K2sfmog7t9VLD
	BOgXdKT/E8GBdQwEnLhy9Vdm8wtAT0N9ZsVIFghb9/OEEnYfFanFx1oa9Rx876g=
X-Google-Smtp-Source: AGHT+IHLxDvudl34MzQn/Jyw7XR+SaCk77UNwaeIDhFNTcRpyK+SyTtix/ir08jgvJJk0WfAJX/oXw==
X-Received: by 2002:a05:6000:124a:b0:368:4626:1327 with SMTP id ffacd0b85a97d-371c5fcaf67mr632387f8f.23.1724138131094;
        Tue, 20 Aug 2024 00:15:31 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fff81sm72327425ad.11.2024.08.20.00.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 00:15:30 -0700 (PDT)
Message-ID: <2d6499d6-fd03-43d8-9595-5babfd82481d@suse.com>
Date: Tue, 20 Aug 2024 15:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] ocfs2: Fix uaf in ocfs2_read_blocks
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <2e662cb6-47d9-4bbd-855d-1f6d5edb8633@suse.com>
 <20240820065511.996453-1-lizhi.xu@windriver.com>
 <20240820065511.996453-2-lizhi.xu@windriver.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240820065511.996453-2-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 14:55, Lizhi Xu wrote:
> In the for-loop after the 'read_failure' label, the condition
> '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
> When this contidion is true, this for-loop will call ocfs2_set_buffer
> _uptodate(ci, bh), which then triggers a NULL pointer access error.
> 
> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/ocfs2/buffer_head_io.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e62c7e1de4eb..b4a76f45253d 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -384,6 +384,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>   					goto read_failure;
>   			}
>   		}
> +		if (!bh)
> +			continue;

If you like the style of the above two lines, put them after the
line "bh = bhs[i];", or the code below is more concise:
```
                   * completed. */
+ 		if (bh)
   			ocfs2_set_buffer_uptodate(ci, bh);
```

Thanks,
Heming
>   
>   		/* Always set the buffer in the cache, even if it was
>   		 * a forced read, or read-ahead which hasn't yet



