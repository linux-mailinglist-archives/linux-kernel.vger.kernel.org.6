Return-Path: <linux-kernel+bounces-443000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F277B9EE54F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F490188734C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13D211A29;
	Thu, 12 Dec 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F1RtQkEN"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FE1F2C30
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003919; cv=none; b=Hg/2Ktp/dqmmEM3BtceoOyF6u/D23ta4P0YimCgOZ7LXvJpCpR2WUYeDreBUH8S0h9PC750QNIcFnSnHBf/ZXeDVwskDTLwPV5jnPeJMwGEfWRcR0hIKdQL/KV5hhYAchOHT+VcXGK+N6BEHMgw0BlCwd4Hs5difghyQeydTOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003919; c=relaxed/simple;
	bh=/AeMddT5I/7ORa8Vq3OjuCXXDJmjVLBFui+0F4NUov0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqXOFVMHsnGI+mZsIIZHhyvORlPKyFauNwxscvQwpfiBOhwthu8TNHfHGqPNm09TFzOoYJd6ox2r0xxmted5aJcPyRtGJKiXnsw7H0r4haah6+wif/TvCrxlpP5bjV3263sEO3UxUFsiqSBzme/FzPOnUUtChSSlQnqruToPOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F1RtQkEN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38625aa01b3so34771f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734003916; x=1734608716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNJ2NNXOEYsaP47VU4MW29jbTvfPJgrGv8fsDcVmvbY=;
        b=F1RtQkENIXfAgjAYovXI8VzSBq3iDlcCy62phGx7oYjCScIgNVh75Qc0fNpd2xPp7f
         5axGrgF1ObTRxntC9aceDilI90b619MMDgyy/xZhnupCSa9YbriHSxATstGD3O4Do+7J
         5V47sxX2hbmcNVAN/Tr1NAqNEVVLh3T6r0Gwm4caAnXN0deuIlwlRGD6L72wWH9yixEZ
         cycuYd+8zWhuNE086LigVP1D+sT3dq8HEYzN988fCCMFdYQYyNRUI+3q4KBYzlPQJEhJ
         LmKlLZHXuaB7EkWNkGNw6PQ3phoL8UN35gfDiVOzVVg5zwOCYBnkzN4k17XhnwSxP4A1
         in0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003916; x=1734608716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNJ2NNXOEYsaP47VU4MW29jbTvfPJgrGv8fsDcVmvbY=;
        b=CMMvucqHzxS3o+h9TRNYrv4SFoZMsnIu4J77eOOeE0eIZX9quIDf6Aks2tKVBRENPl
         YqIOrM6TAOw/mprnU9sm4Jfbu+3gc4XLLZNisLaHrJjYcNjAZoNQr6lloMPkYl0kI2NC
         54uOf5N+zxBCb00JjR15zM6NVzLMouYHIQ4AX+3VwLQIiTvl0nJHL48guqmqLjC67qca
         /owrydvscA3pucTRd8P58xjHyrY6kFNdrrFnSPkqqdHqv2Hhn4gGjgP9iHF5cZTgpPwK
         +ySZVK1aJ5whH5fNYsceSW2y8BbdwoZFmLBd3GzLLcc4JwuhICDyYCtdWL1oAv/kG2Bw
         4iYw==
X-Gm-Message-State: AOJu0YzIWb3UKcxHgifjKJ3o5Wr5S58kBHU1OIom09dc4z+7xmZ3RX2G
	7ObsMa+Q2zjonZLNmN7/9GZeiLUGJA6dQnoz/q0RHWpiSeqWDUD7Gy49hSEvNEs=
X-Gm-Gg: ASbGncutLPWmgcvl76yexli//MNAc/SkiLljy3XxX0s1abrDlwjgwmNFTRokJBVHSy6
	kCf1f2pnu5jm7wgUTofbmt0xt4rIEt3/fpm/k73UqfyIWkLqLbJg0UjhFBBmAJy+hAfsLee+cyR
	WeVGoh9qChkzk0HT2p9Fjvq1lPkn6+mrEtn5WZ4Of2HcluoEf2dXAbZ1Pn2ksU39niZ504/bBVS
	vAzUcg8802aVEDrzkDb4DzVybYVmXcP2tKTB46EuaX5GlWsfb3uwuSul+p1
X-Google-Smtp-Source: AGHT+IEq35k9CwEbCU11uF2TKeyxIO7Vf7aoHPTQorzrPZxcWI2W9+Q+cuNSK/R6YL8Vw1DfHHFb5w==
X-Received: by 2002:a5d:584d:0:b0:385:f1bc:7644 with SMTP id ffacd0b85a97d-3864ce55aa3mr2023500f8f.6.1734003915850;
        Thu, 12 Dec 2024 03:45:15 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21615dba950sm105039195ad.11.2024.12.12.03.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:45:15 -0800 (PST)
Message-ID: <92d413be-286e-49b7-a234-b6e2c8c94581@suse.com>
Date: Thu, 12 Dec 2024 19:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
References: <20241212113107.9792-1-heming.zhao@suse.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20241212113107.9792-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

The 4.19 branch also needs this patch.

- Heming

On 12/12/24 19:31, Heming Zhao wrote:
> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
> unmounting an ocfs2 volume").
> 
> In commit dfe6c5692fb5, the commit log "This bug has existed since the
> initial OCFS2 code." is wrong. The correct introduction commit is
> 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
> 
> The influence of commit dfe6c5692fb5 is that it provides a correct
> fix for the latest kernel. however, it shouldn't be pushed to stable
> branches. Let's use this commit to revert all branches that include
> dfe6c5692fb5 and use a new fix method to fix commit 30dd3478c3cd.
> 
> Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Cc: <stable@vger.kernel.org>
> ---
>   fs/ocfs2/localalloc.c | 19 -------------------
>   1 file changed, 19 deletions(-)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 8ac42ea81a17..5df34561c551 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   		start = bit_off + 1;
>   	}
>   
> -	/* clear the contiguous bits until the end boundary */
> -	if (count) {
> -		blkno = la_start_blk +
> -			ocfs2_clusters_to_blocks(osb->sb,
> -					start - count);
> -
> -		trace_ocfs2_sync_local_to_main_free(
> -				count, start - count,
> -				(unsigned long long)la_start_blk,
> -				(unsigned long long)blkno);
> -
> -		status = ocfs2_release_clusters(handle,
> -				main_bm_inode,
> -				main_bm_bh, blkno,
> -				count);
> -		if (status < 0)
> -			mlog_errno(status);
> -	}
> -
>   bail:
>   	if (status)
>   		mlog_errno(status);


