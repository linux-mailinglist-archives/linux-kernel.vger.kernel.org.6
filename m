Return-Path: <linux-kernel+bounces-510650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF1A31FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7068C7A1366
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73260204682;
	Wed, 12 Feb 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JESZux1A"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E451DACB1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345428; cv=none; b=Aca+vGEHOfDZSsdu5ujSNP6Ax6W5oha6VnBAZT3hFVnGyLc+Xx+hM2QR6sMbkpZCYbCIo8UTgfE01C7S6TcrXQzJa/Iw8OtKkQZp8zUB+c4u9ZiJA0pUsCn595ercTrPD8F0x+BcehC7tqWEvQqqTPRRjAnCqHBoxk9ystK1oQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345428; c=relaxed/simple;
	bh=liUB+vQy91cPqvsQbsA0kidijtsiriBht+TngZlpY70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzazdyWqGs9uyqpRCAjg7PLihGdNCOA/r3oFWzUqVX3GHCWnGbGY+6ig+7tiAypPebhKYXnoWllkssENEpLCPpFA7iPjDK1zsyePWrhVo3D7TDa7TVRu8HIrkbCuG22kjuwLqfFRT8YZiUTJvSUPPO2fRZMdGpUq0Ca1oc15ANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JESZux1A; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa0c039d47so9536885a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739345426; x=1739950226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UblfR+D8Nrr1xWGWMhXPdM3NZsuuKTqKkiEnqxIjVPk=;
        b=JESZux1AgSGJtbWSsVsKU6hB7kMcXlgNOI9hzgTVGsknbEPA/qHMn8tD8dNUqnxalj
         2fk64DMWWbCRT9cJY+0w7wW/cgok7B7h4KBR6ctmx4WykBLbqd/wJH66CcLrCLuiqrOO
         PbUms/CBLI6EDYXLOhElx+vmAfNb13CskhWvjLKi02JjCza9gbYmPFk4CEd3nY7Lb0Xh
         JkeYibbs6SC5I0zKuYFHXch64IW5WjmYqqbrRBU4eTny/FYtAtugRqBeSEymv3lJF2OU
         YpLWbXYBrFENhe03gqtL5l98IQ0C4J3INTxqNWz7dgaXTLPiJ6Tu9mfM7DVdPU//OCyh
         1ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345426; x=1739950226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UblfR+D8Nrr1xWGWMhXPdM3NZsuuKTqKkiEnqxIjVPk=;
        b=Th7x2WBGFGXt13H+zaLrA+dVSxYFyRq1Tkt1qNt/Jp3DssVFIbzAV1dxbY3o1e9szw
         /0tbaoaRQ3A14hB9o1H8HLqLlLLs5P/HB9fN9ZqNlCbiHs37b1wUSMYYOaZ/PwVzD+s9
         Ey/3n73GJpulJicHgFSJ6txqd2Zoyiwf35VD35aKaH4qhbZm4uX2JSMjJrEeQ+FbeNzA
         KPc7XdO01spq85Xo0XFIm3+wT+x73n86cQzdh3wxzZRTLqArulVmjbtLree/oW3pzZLC
         nBPmi4Mb7OyvkYr+ESpM1l9b0NvBu23lizgComW3VG4UfpIiIprRywAZlg/UROhkcp3y
         guXw==
X-Gm-Message-State: AOJu0YyeS7VwImRqjBzkfSlGkMY/3KN4A3ruSVF670rdz8XVeDpWILRB
	huMFRAtBgPo3IgA0YWYLwf4i0xk4CZwmFyU8qGXp3yRBGi8Q8uiBz1hXz2wEwJo=
X-Gm-Gg: ASbGncuoj3DGEJFByI0tJJ1v6P/Z+Ta26Fh1jxySLRLxofBOa4Lf/grGSrAU5DGUBjV
	HXEd+En462U/e4o8I+fQDaQTHFmJMWVSiRGZOWd6A8mBqOmJuFIRANlVI8zBVHXhg5vHnBayzY/
	A9Tgpypnvf3jyR0/zFrHMtUNhf4CjjSY5kVIjJmIS/qh55+Gc2L7wLnXgH9PqYE0Hwq6t7cBROa
	HLcX1862VIMbG3F0jwAfumiGPxwl9bccmvEh8F27tVN27clWRn2ZpDEHKwEAt/FY20Kms+LkAOH
	lPqqAbMKhVMvvUZI+RcEi3sGudGjecjAKBW7
X-Google-Smtp-Source: AGHT+IHiMXIaeQkGDLmj4QLaxRdqosV2WjXomIBTbT6B3CFHOM3mBaT9LMJguECrLMcZrydqDGw60Q==
X-Received: by 2002:a05:6a00:804:b0:730:91fc:f9c4 with SMTP id d2e1a72fcca58-7322c43a997mr3942114b3a.24.1739345425990;
        Tue, 11 Feb 2025 23:30:25 -0800 (PST)
Received: from [10.254.28.19] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf144dsm10531324b3a.85.2025.02.11.23.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 23:30:25 -0800 (PST)
Message-ID: <9c9498a0-342f-4ade-8310-b5a9aaa485b0@bytedance.com>
Date: Wed, 12 Feb 2025 15:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Fix the incorrect bpf_list kfunc API in
 common.bpf.h.
To: tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org
References: <20250212071936.1406029-1-zhouchuyi@bytedance.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20250212071936.1406029-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/12 15:19, Chuyi Zhou 写道:
> Now BPF only supports bpf_list_push_{front,back}_impl kfunc, not bpf_list_
> push_{front,back}.
> 
> This patch fix this issue. Without this patch, if we use bpf_list kfunc
> in scx, the BPF verifier would complain:
> 
> libbpf: extern (func ksym) 'bpf_list_push_back': not found in kernel or
> module BTFs
> libbpf: failed to load object 'scx_foo'
> libbpf: failed to load BPF skeleton 'scx_foo': -EINVAL
> 
> With this patch, the bpf list kfunc will work as expected.
> 

Sorry, I missed the Fixes tag.

Fixes: 2a52ca7c98960 ("sched_ext: Add scx_simple and scx_example_qmap 
example schedulers")

> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   tools/sched_ext/include/scx/common.bpf.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index d72b60a0c582..7849405614b1 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -270,8 +270,16 @@ void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
>   #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
>   #define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
>   
> -void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
> -void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
> +int bpf_list_push_front_impl(struct bpf_list_head *head,
> +				    struct bpf_list_node *node,
> +				    void *meta, __u64 off) __ksym;
> +#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
> +
> +int bpf_list_push_back_impl(struct bpf_list_head *head,
> +				   struct bpf_list_node *node,
> +				   void *meta, __u64 off) __ksym;
> +#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
> +
>   struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
>   struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
>   struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,


