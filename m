Return-Path: <linux-kernel+bounces-293861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3409585DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7318282801
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA818E04E;
	Tue, 20 Aug 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UMm5b3Gt"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9118CBF3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153532; cv=none; b=DemW2Bx+c9Ue/tIXd/Fj2FIJmEb9Vkbn99xrPSsR0zgSIwpNV2sOtVErVBGrLQQ+7sB+AwqDVbn3vn4PaXDWt6J40JTVmCouhoaJrlXe5qRbqtKQcgrlp/MIknbseicnOEgB4VfH/+sUmvfepyO98IJXiCsFUClocrLg4p3jFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153532; c=relaxed/simple;
	bh=/NEEXoU7cN84Cc0lPoORDgJ/bZuFQM/jQxKs3CTG6BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seeDXM9nAwbx/xdhIoFfNm/ZggHIOxjjdUGZ5oEgkF0fp/e8V2uUGGm+8WuR3UfEAwuT3GCp4MUyOrm/RjZ+1c9S9HHLsycIYQ0HCBvfsOC/n9ToAtK5I56T5aiW4fQZ5Upcf/UhAmSQLseI0X3BXXSEqT3k8HkFVdbgzwnIx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UMm5b3Gt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368633ca4ffso646138f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724153529; x=1724758329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klUHlM+lvRCjI1JDvDMDWuADlMNeKPhZGgQeek32rrE=;
        b=UMm5b3GtzWBdbWX3ENHeZBkoty6dSe5FioOJeMfFT+wT5f/Jn8Qo1waQxAnhIy3OgB
         /j8fx8brz7KNrxxZ8e/Ku+biuPNdk4ZaW2qkGUBVdv7E3L2MzDtNX6cLoNdv3G0WaYO8
         mg4ZbhTw9JXeAtOq7jvwl4OONRCHgl89RZWDyeBpt7ALc4TOTOQIH6H6fxN7JTHEU1le
         aHKMC/r7lz5LopSOaFC7IOpaJdpT6cn8mLZITVE8GALgJkhWP3bvNJUqPATiSjOAULQY
         Djje7d0SQ28ObV6tim4B6IeqAdywjmU6KwVclh6zzlvOClCL6RzyyCp1d+oodSSdveXk
         1NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153529; x=1724758329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klUHlM+lvRCjI1JDvDMDWuADlMNeKPhZGgQeek32rrE=;
        b=HX/7672wlucXsF4ydUZYq5tscSv329GEZ5tvMKrIWMIlgzX06RLgpwRxhwuDnfgAKl
         bjRL1NzUC0cyaVu4KlGSWUdrUkPvYW/WFUF1AT4r6A0yKVAAA3GChms+oShnKAu9MG4G
         QhoMl0QQe/dvA+gf1pXbjYHtElTH+MMPuqsfcqxdAVJUaUxcmu9lNHmxvJvy2yATudYN
         9zTm9c5WSLSt6S1f6gb0e1DReyzV44rXfRgqgQxvTR3QY4zgX7VTtnxYO3zos32m60eb
         kgWAiVt1RMWEBPTjOpP2yiT0DEg9pXTtXGyaOJmiQ2UA8fb5LcVS1XsPlnADqVTJpx0J
         BbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfDZTQ8jXnFrdtBbQ9YSqgRZ6PjEIcWl8zla9IG3BBar/aH09OW1HFe1Qo45NfYGxsmsJGGAi6Ui8qWLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI93pHC6nm5xNqCJpKQtNf7hUeesC0wQuWEOy7TS2qU26mBCys
	hNaR1i6IqoSDKndjNY+ATyLywDii/zkTQ8JUWXAeqjjDQszPmf1Vz8kZWdetxDZef6eWD++7X8k
	h
X-Google-Smtp-Source: AGHT+IFe6UqPkZ/6faH/rOIEKAsRbPKV+z7PDLxqzU4epWauYJ+IjaWsJm8efnmozk5MbJ6Th4zkkA==
X-Received: by 2002:a5d:5f8b:0:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3719468bb8emr5637683f8f.8.1724153528257;
        Tue, 20 Aug 2024 04:32:08 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0319a74sm76412785ad.92.2024.08.20.04.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 04:32:07 -0700 (PDT)
Message-ID: <e6f16317-6d11-4f14-ba88-6c7b33276285@suse.com>
Date: Tue, 20 Aug 2024 19:32:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] ocfs2: Fix uaf in ocfs2_set_buffer_uptodate
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>, joseph.qi@linux.alibaba.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <980b3f4d-f265-4eb4-96a3-8f1a75588193@suse.com>
 <20240820094512.2228159-1-lizhi.xu@windriver.com>
 <20240820094512.2228159-2-lizhi.xu@windriver.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240820094512.2228159-2-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 17:45, Lizhi Xu wrote:
> In the for-loop after the 'read_failure' label, the condition
> '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
> When this contidion is true, this for-loop will call ocfs2_set_buffer
> _uptodate(ci, bh), which then triggers a NULL pointer access error.
> 
> Changes from V2:
> * Make the code more concise
> 
> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reviewed-by: Heming Zhao <heming.zhao@suse.com>

I didn't give you my "Reviewed-by" tag for this patch, and you
can add my tag only after I send it to you.
(take easy, you can get my "Reviewed-by" tag now.)
Please remember this rule for next time.

Another issue with this mail is that the change log should be
placed before the file list, not in the commit message section.

ref: Documentation/process/submitting-patches.rst

Thanks,
Heming

> ---
>   fs/ocfs2/buffer_head_io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e62c7e1de4eb..8f714406528d 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>   		/* Always set the buffer in the cache, even if it was
>   		 * a forced read, or read-ahead which hasn't yet
>   		 * completed. */
> -		ocfs2_set_buffer_uptodate(ci, bh);
> +		if (bh)
> +			ocfs2_set_buffer_uptodate(ci, bh);
>   	}
>   	ocfs2_metadata_cache_io_unlock(ci);
>   


