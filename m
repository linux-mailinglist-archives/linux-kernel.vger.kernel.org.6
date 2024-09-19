Return-Path: <linux-kernel+bounces-333184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C097C50A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B40FB21A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B7194C6E;
	Thu, 19 Sep 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TCwh5+UU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611A23A6
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731887; cv=none; b=G1vBkv9WTIZSg8Pg+s6uUuCFE5PAYaRNdCtZNoU/Fp8MgxYtlyzzle/NUidipd92kFlcLStFzRZnwJNx4AnBKaVsWZ1JoO59dp+zur16hvXjIhpla40A1A271lTcYTcT3QKg3qguTQ//urZ87iue8Du6MpD8+8xhV/tXr1Ir1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731887; c=relaxed/simple;
	bh=4QhxGoyk5nQU1ZqkTKte61SE9/xYOOBpuxmqOGCRHBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZHDUJY0nB96SE8ji+yw8+Yj11/7rYOe0AYO8g7538rJ/FmYlf8EX/jzkHMUPvA7b0rZ/kCXAGqLxkWv/xg++pb4ECp0DumCnOFtN4YvNMC1gwtlZ0FcQOhkbPinG8LpO/RrMVJTwTQ9N3Pv+BMkOToSpWGxG0fC0unPMMpTr5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TCwh5+UU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb3c6c353so848955e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726731884; x=1727336684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYgS1bx6CKLlYwen0cd10S/R5x4JBVI14kwUyO677dw=;
        b=TCwh5+UUFgjkwFAe0gFjt9hm9T/WCWmzTrsP+ncxp4iHoT/SWIyJRbtXETm4GADRyu
         FsW8OvFlNaNpeH2aZO7US4isAQs374qUZoaWeiDZv9pNL2iRhFICoamlNDiuLtAnQX9G
         m/DNklK5rhc6OKTmvZNr5iFcYrZBRhm7ygyt4HBxe8mxhGFETbLuTyfCvduOooiAmTdZ
         nN2cdWsZRPWWBoik6tNaV+ootkIm7j0KeI6ID/A2XPh+bgKD4LYGUFlr3ABpVnFmIUCt
         TCM7e8bN6kRNeCFpo4dVUlqtloPnotauQY/9a0UwooIJjfwVi9C5fODRfs9QQTEC4fVZ
         R6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726731884; x=1727336684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYgS1bx6CKLlYwen0cd10S/R5x4JBVI14kwUyO677dw=;
        b=B00M+afVCW+ZSbtFfO8EI5uEHmQN/UrBy6SdM//5tb1mzd2q8dn2CdfuBFGhwjxIK8
         eJ3qkJLLlGDBxvvaw4hLeCredcbAuNEirnrg8mniOxN3m1u9QRd6S7Kb9ohhHAsMzcWP
         A7cOEn4JoldNvfxRUl5g1SvzbWCNRTM8HIv+B/kqnbAfpeN1/9AMYUgGcqQhI8nJYw4A
         tZoTCJDgvj1njd/qcY5Ib1FbC8nhcDsf1tQIDh19EILLxjakQ9MKv/UhV+767mW5jubJ
         JuvqtxcrEmnLUdIx5bkUEJzhhkQ+AX6y4Kkor22MhR0AmPzlUoueYJYryFQoYKWXyIRc
         3svg==
X-Forwarded-Encrypted: i=1; AJvYcCV2S44e9EQRUlajbnUkvWCof3RYm+1l0DyrUNrE4kiaswqXOb51+E5C+VpR1vQFWeikaNUPw+4F7kj973E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8geKDH86C6NcZ1eWZ45vXXwZvcGSutBrE1Tgee3q0wgGHBNx
	y1HW5661SggjbNd8nrx0cEfR2O+JE3tfoCT0iGZKWez53FxIuUJdcR7DHt18iyvULmWPW+j8wLY
	GXRM=
X-Google-Smtp-Source: AGHT+IFApZ8JUxsqP+nFEp/TdVEQ7Zsf62AeqvRIT6tCZLHeH3EkmftxsPYqWjkQTXZISA69jun0Tg==
X-Received: by 2002:a05:6000:1f89:b0:374:d2b4:d9d0 with SMTP id ffacd0b85a97d-378c295451cmr7335912f8f.0.1726731884033;
        Thu, 19 Sep 2024 00:44:44 -0700 (PDT)
Received: from ?IPV6:2408:8409:2432:371d:7607:a570:bf1c:aad6? ([2408:8409:2432:371d:7607:a570:bf1c:aad6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef93b2fsm1033853a91.49.2024.09.19.00.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 00:44:43 -0700 (PDT)
Message-ID: <e068a56d-959c-43ad-aaea-839b89344693@suse.com>
Date: Thu, 19 Sep 2024 15:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] osfs2: Fix kernel BUG in ocfs2_write_cluster
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
References: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
 <20240918172026.2532-3-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240918172026.2532-3-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/24 01:20, Mohammed Anees wrote:
> syzbot has found a kernel BUG in ocfs2_write_cluster_by_desc [1].
> 
> The issue arises because ocfs2_insert_extent receives start_blk
> as 0, which incorrectly maps to a physical address of 0. This
> occurs when block is 0 after the call to ocfs2_clusters_to_blocks
> which is invoked inside the ocfs2_add_clusters_in_btree. The block
> value is then passed to ocfs2_insert_extent, leading to the problem.
> 
> [1] https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
> 
> Reported-and-tested-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>   fs/ocfs2/alloc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 395e23920..926ffeed8 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -4843,6 +4843,13 @@ int ocfs2_add_clusters_in_btree(handle_t *handle,
>   	}
>   
>   	block = ocfs2_clusters_to_blocks(osb->sb, bit_off);> +	if (block == 0) {
> +		mlog(ML_ERROR, "Conversion resulted in zero block number");
> +		status = -EIO;
> +		need_free = 1;
> +		goto bail;
> +	}
> +

If you check this function, there is no IO operation, so -EIO is not suitable.
In the the ocfs2_clusters_to_blocks() code, there are two possible cases where
the result is zero:
bit_off is 0 or bit_off is out of range for a u64 after a bit shift.
It seems that the root cause is that __ocfs2_claim_clusters allocates an
incorrect bit_off.

-Heming

>   	trace_ocfs2_add_clusters_in_btree(
>   	     (unsigned long long)ocfs2_metadata_cache_owner(et->et_ci),
>   	     bit_off, num_bits);

