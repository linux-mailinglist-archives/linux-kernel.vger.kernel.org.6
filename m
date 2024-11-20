Return-Path: <linux-kernel+bounces-416012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A89D3F23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C0F1F24CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6D4690;
	Wed, 20 Nov 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="i0VGvw7N"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928684B5C1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116856; cv=none; b=W9FFg3HxIbTpfqdVGkqwFElZZGblxvNr3/X9zPYQEgE9rzQ7+n4nVJkbRMr9D8Ld/ovmmE8/56Vtyey4cnyM518HvwyaQ1vYHdDUdokALVv18EhYjH5OEwDMa6jUwWLkraiU8JjOjyW/tQVSgbxLqMkyySkLqo11temLqieifaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116856; c=relaxed/simple;
	bh=tapspqOc3LuINmsY9rmIJdgI/iII+12IiBiFvTeBICM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VapFR7CGt65Pj7EoltRGnMAdlunVWTpkHS3HFAesKcbj8OVPWuRxZKppl1Q+y08L4pGJMzF2tx07LoBF7ve+2rc6shI1cEXZL064uQge8l4O8vzNu/aqynoSfx3lL6puRsbtFVolugGEnHwy65EdQtOmmpc/kZL4uFNqCa2Z7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=i0VGvw7N; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a77c066a15so7320835ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1732116853; x=1732721653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcM59+8TfsvtZUlPOhwHkunXZn/aPvaA5x4RA/2fbaw=;
        b=i0VGvw7NmCLy5l2LcWFsVbSw9GAYY9lzJgPyKqR/t4BFu3CQdHS8nKUiYc60FIkSf9
         hgv14hx5z8pXqdbter8gk01LBV1TXrJkZ5Zxtw6K9e+VanHCUW4EhxLxJgcNZWPaXir0
         7yz8jmfkfesvZpFrkC19OyGQwSf1lZNPcJh3X7B2s3Ln5/QC3fu1gFOK6REYQC/GoEW5
         3HnKygrC7Rv6Ygo+wY4Bt1mz9dqnuDU8K8oTm8+VSrCl2VJ5XUJM6+5Ym/6caJISL5Th
         3avqh9GfqzCiINHKFY4GWuIFxwVYbOnUzmOYF7yA730sBWgvSDoDgYio3Op2zHj4v794
         A4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116853; x=1732721653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcM59+8TfsvtZUlPOhwHkunXZn/aPvaA5x4RA/2fbaw=;
        b=P/OaByLP3CEa3bhTCGzygmBL+xVmWdPAQ7lQA4/7JQi19FB+9vEYyzEPujx+0cgFkL
         czS6ZsXcTRoH3hBuvrnhmwwzu8LFha92KODHHzlisDSUqdD/Iq4tZMwjE1GiMfdQVhwz
         V2XoAs2usF7ZsyowRMcm9izKKNmcS3ZyEQI7hKdDcRjWGPnrwCo5cFT2lOD5e90OefTu
         cq6UjkC0uqFk0x9UK0niMcZPGzBZlhmNtdfT/2FJMy4zNdZzEAmGa38i0IZdAlyjeaXA
         ltWZyJf/hv5RixI6YohXlPqKw+V4fVlyrcglbmWNYActSYYyntC8EeMMXxVb+LXEfcwG
         Y0jg==
X-Forwarded-Encrypted: i=1; AJvYcCVMoblQFxcI0Ju3hkWiGAwQ2S101w/3CAmIv7T1ZgjWSBVDJtHmjHdyacAwaGCJjXCDQzAmD5kOYLaHz8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGIotX5J579nUYo8J0GRgQq5tigEJn73+pJNk27b4NXnanJJ5
	dR8PO05slm78+Dxz8BOBeZIegKiNQjS2U3ABN7pXS+xTIY178II1UlR13pSmAi0=
X-Google-Smtp-Source: AGHT+IFPsi16Sc1ScQxHAt2zv4mWqJHo5ZB3ZAX2DX28qdi/G7PLyBH6ZUWtH19EKbUwdn26IKCIXg==
X-Received: by 2002:a05:6e02:1a85:b0:3a7:8ee6:cd6e with SMTP id e9e14a558f8ab-3a78ee6ce0emr7280365ab.8.1732116853354;
        Wed, 20 Nov 2024 07:34:13 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a748115b79sm30804095ab.53.2024.11.20.07.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 07:34:12 -0800 (PST)
Message-ID: <ad32f0aa-79df-41b2-90d0-9d98de695a18@riscstar.com>
Date: Wed, 20 Nov 2024 09:34:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: Use xchg() in xlog_cil_insert_pcp_aggregate()
To: Uros Bizjak <ubizjak@gmail.com>, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, Dave Chinner <dchinner@redhat.com>
References: <20241120150725.3378-1-ubizjak@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20241120150725.3378-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 9:06 AM, Uros Bizjak wrote:
> try_cmpxchg() loop with constant "new" value can be substituted
> with just xchg() to atomically get and clear the location.

You're right.  With a constant new value (0), there is no need
to loop to ensure we get a "stable" update.

Is the READ_ONCE() is still needed?

					-Alex

> The code on x86_64 improves from:
> 
>      1e7f:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
>      1e84:	48 03 14 c5 00 00 00 	add    0x0(,%rax,8),%rdx
>      1e8b:	00
> 			1e88: R_X86_64_32S	__per_cpu_offset
>      1e8c:	8b 02                	mov    (%rdx),%eax
>      1e8e:	41 89 c5             	mov    %eax,%r13d
>      1e91:	31 c9                	xor    %ecx,%ecx
>      1e93:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
>      1e97:	75 f5                	jne    1e8e <xlog_cil_commit+0x84e>
>      1e99:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
>      1e9e:	45 01 e9             	add    %r13d,%r9d
> 
> to just:
> 
>      1e7f:	48 03 14 cd 00 00 00 	add    0x0(,%rcx,8),%rdx
>      1e86:	00
> 			1e83: R_X86_64_32S	__per_cpu_offset
>      1e87:	31 c9                	xor    %ecx,%ecx
>      1e89:	87 0a                	xchg   %ecx,(%rdx)
>      1e8b:	41 01 cb             	add    %ecx,%r11d
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Chandan Babu R <chandan.babu@oracle.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dave Chinner <dchinner@redhat.com>
> ---
>   fs/xfs/xfs_log_cil.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> index 80da0cf87d7a..9d667be1d909 100644
> --- a/fs/xfs/xfs_log_cil.c
> +++ b/fs/xfs/xfs_log_cil.c
> @@ -171,11 +171,8 @@ xlog_cil_insert_pcp_aggregate(
>   	 */
>   	for_each_cpu(cpu, &ctx->cil_pcpmask) {
>   		struct xlog_cil_pcp	*cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
> -		int			old = READ_ONCE(cilpcp->space_used);
>   
> -		while (!try_cmpxchg(&cilpcp->space_used, &old, 0))
> -			;
> -		count += old;
> +		count += xchg(&cilpcp->space_used, 0);
>   	}
>   	atomic_add(count, &ctx->space_used);
>   }


