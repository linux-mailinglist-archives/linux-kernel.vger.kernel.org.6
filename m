Return-Path: <linux-kernel+bounces-320476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 849CA970AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D448CB2118C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693CA932;
	Mon,  9 Sep 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RmE0I9MK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D65101C8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725843788; cv=none; b=G0D73+qkv6ISQu7xVErKEB7oYhJT4RweATJvjiGwnUE/hfjtNwGZKfLuN9jD13IM2HU3XLNZr81aaLjWkGAtiaTsrvvkGlSHZfFvis2q0/Gvlou8w0mUdFqSH5kc1mIXSNQlD9nfFytrtwkZyIggrkGa1YRPskALD0sJ5Zy8lyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725843788; c=relaxed/simple;
	bh=khk30wY3xXyR9sRYV8s5FHMtDbhrQkXYCwdpJoT8eiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRsNuY2Deb6NvLTKRXwYVee3b1qRLBY0alNDFVDYxHTxwOhx8ZyFf/4X0iAgl3Eic4Vp/3bo0eWavqg9a3Z4/BuOJ+vOzZ9bxFr0UGOfdnfq8InbqvC5KrokjYIM+8i4VuWHxBFq8CsUMWTvz8j3yN1UhZHLTzR9k73TBldWsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RmE0I9MK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso1810945e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 18:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725843784; x=1726448584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OV7VGKDNa+MYCPDaH3eYbggjB6/nkG30q/dMutycMh8=;
        b=RmE0I9MKt9IrP4cELbF5MOoE1MKRs0+5B0DzxCD/Bi7/TeU31zFdvuwgC3IwE0s6xh
         h6qWwkByJjFnnifO0Wldl1eIqI9GgseKtjU6PXeiyjVSq6f79a/dFTRBjqm1EwgoF0tv
         q0/tzKVpdS7JEomTl1FvZj2YC+k3F4oYhfrIodZrPLU7Pqwx3dT6GBgIOonI6kM0p4hY
         Pex36gk4Yr6JNLkRPeu/2CJcuoPMj2LPmY718qgO7+orCpcq6qKzxSKbgURK+LIGFOGS
         EVQVyo7FAYIDHu7JBTSCTQyJwbTMmD3mtKBawre+wEbOyWkjAG5I4v2zvIkh8SAAnr8c
         LaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725843784; x=1726448584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV7VGKDNa+MYCPDaH3eYbggjB6/nkG30q/dMutycMh8=;
        b=PGiLvD7/qhsRwmvsIyY/bDKz3X7p1dA9oWSUpY+ipGS6QdbxA8VJKGZHfAbtD/qPFD
         ynY5wK8Ti4OprUY63R8riygi9pZnNkaviqUwmOd3CxXfl77PwzDGbg/QF4D2hKutzNBp
         lH+0K/BmY/ho3zbVQ/eSrLvNOtW0A2h5Kdn3MEiwoV0XZJM4Npz7fcTQUbF9l3b23BvI
         VawsuE5JZkppbo6x6C038Rq9eEMXda/foFY5p7HIB5aB7fjIKBMoj1daMAnC+ic38e3k
         AeWXFR4EZdVp8H1RAvw61cotjmonXfY+smosbhRYdupEn6BmxD3cTHsP5nb1lmrCB5Wk
         yNmw==
X-Forwarded-Encrypted: i=1; AJvYcCXSdV9FZANZwYmfSyh8buKWgDbw4n6Un5UnGSNg1n8U5qfswtnMfMsN57YUD0aRaZHhh8ob+T6tQVvzddY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNXCDX9UsDJxvsQnOekauiNRDczlormpKV07cPcrrhxO3a4NQ
	V1W9xzr+9YzelKmsq1qpQZoAZa5dMY4VrtnMKKumu1x6JhEkjn5a4j6rlruSENk=
X-Google-Smtp-Source: AGHT+IG+Q3rwxK84PkFA2rjUi4Xr9PUnKPR3t9AIPNqqCub9ivi56tLrKglxADx78f/P33lxOLQ8xg==
X-Received: by 2002:a5d:6d08:0:b0:374:d088:476f with SMTP id ffacd0b85a97d-37889659481mr2967933f8f.5.1725843783325;
        Sun, 08 Sep 2024 18:03:03 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c6a3csm2497871b3a.65.2024.09.08.18.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 18:03:02 -0700 (PDT)
Message-ID: <094ef45c-3268-4155-b867-56d06e80ba69@suse.com>
Date: Mon, 9 Sep 2024 09:02:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ocfs2: give ocfs2 the ability to reclaim suballoc
 free bg
To: joseph.qi@linux.alibaba.com, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240908140705.19169-1-heming.zhao@suse.com>
 <20240908140705.19169-2-heming.zhao@suse.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240908140705.19169-2-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 22:07, Heming Zhao wrote:
> The current ocfs2 code can't reclaim suballocator block group space.
> This cause ocfs2 to hold onto a lot of space in some cases. for example,
> when creating lots of small files, the space is held/managed by
> '//inode_alloc'. After the user deletes all the small files, the space
> never returns to '//global_bitmap'. This issue prevents ocfs2 from
> providing the needed space even when there is enough free space in a
> small ocfs2 volume.
> This patch gives ocfs2 the ability to reclaim suballoc free space when
> the block group is freed. For performance reasons, this patch keeps
> the first suballocator block group.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Reviewed-by: Su Yue <glass.su@suse.com>
> ---
>   fs/ocfs2/suballoc.c | 302 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 292 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index f7b483f0de2a..d62010166c34 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> ... ...
>   
> +/*
> + * Reclaim the suballocator managed space to main bitmap.
> + * This function first works on the suballocator then switch to the
> + * main bitmap.

need to revise above comment:
This function first works on the suballocator to perform the
cleanup rec/alloc_inode job, then switches to the main bitmap
to reclaim released space.

-Heming

> + *
> + * handle: The transaction handle
> + * alloc_inode: The suballoc inode
> + * alloc_bh: The buffer_head of suballoc inode
> + * group_bh: The group descriptor buffer_head of suballocator managed.
> + *           Caller should release the input group_bh.
> + */
> +static int _reclaim_to_main_bm(handle_t *handle,
> +			struct inode *alloc_inode,
> +			struct buffer_head *alloc_bh,
> +			struct buffer_head *group_bh)
> +{


