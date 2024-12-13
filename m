Return-Path: <linux-kernel+bounces-444975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437F89F0F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE971654B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAC1E1C03;
	Fri, 13 Dec 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSqFRLag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8F1E0DD9;
	Fri, 13 Dec 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100996; cv=none; b=cqtSo6zUo48DkrwRmu9NQrh8aJHNNp9RcuBpEBaqsAviRGaS3bglK+lFDpviMZj6BSxPTcyoZOWHdcaich8ocIbbnWWMt2WPU9letuMgLV+ryqNp/PaN0DJYtoGSDlEhKcyM54/suBY64OPyeDlYgPzqiiE6N7OQYqizCzYWYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100996; c=relaxed/simple;
	bh=xHn6a5wElsmEOUOFPDI4crebQOhSkal5Lkbg08s23S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaWSXop3lhYWZd1vE8qpmoO41g4urz20DW6shZpA9GB0ZkiGSN/widBhN986aLBcdjxfwggsW3dnL3cTmyJkiYpBL4HwhjYyJq89S+wI9YVSMC9rxmAis+gKsViTGmDS3hg7I3xKKhFNuq8C5V4luxTSw7P0DfmU9e1aEBp5Wj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSqFRLag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491E5C4CED0;
	Fri, 13 Dec 2024 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100995;
	bh=xHn6a5wElsmEOUOFPDI4crebQOhSkal5Lkbg08s23S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSqFRLagMGas50mU54QfLwhNrrp64BEZOsBP7cdyDYQqeVMIr9I83xRBTEphGWkf4
	 Xc0dPsvGXeGKh8II3dTVJTjsKYse5w3tmjG6A4ZOaV6asKwfrNFbmBBlBB1vNUxBlA
	 T3LKsnOKQ7ZC8HcQWdr+R5jyUXPSmhVoaIHbCDuh9VWY0Qvb5LGMicGlAd9BE/hWcN
	 dit6AmEq8KPhnhAY55h6kwALtM91J6hhFJp+xj8hQQegiUeGg6K4rDST0A/WszERGE
	 EhF85CAvh194w9kaaZ1MIJ7XVtKApiPQalVIAJ81h75bw9JKuhwCTbCI5+DdIx4Ie/
	 nS4JgWWkGAbpQ==
Date: Fri, 13 Dec 2024 15:43:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Chen Yu <yu.c.chen@intel.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] kthread: Fix a NULL vs IS_ERR() bug
Message-ID: <Z1xIAezMPKXAj9MC@localhost.localdomain>
References: <64c234af-5141-4062-9170-2122c3edf088@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64c234af-5141-4062-9170-2122c3edf088@stanley.mountain>

Le Fri, Dec 13, 2024 at 05:25:02PM +0300, Dan Carpenter a écrit :
> The kthread_create_worker_on_node() function returns error pointers,
> never NULL.  Fix the check to match.
> 
> Fixes: e9853c812f86 ("treewide: Introduce kthread_run_worker[_on_cpu]()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  kernel/kthread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 83bf73d2355c..922f15762ec3 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1124,7 +1124,7 @@ kthread_create_worker_on_cpu(int cpu, unsigned int flags,
>  	struct kthread_worker *worker;
>  
>  	worker = kthread_create_worker_on_node(flags, cpu_to_node(cpu), namefmt, cpu);
> -	if (worker)
> +	if (!IS_ERR(worker))
>  		kthread_bind(worker->task, cpu);

Whoops!

Can I fold this to the offending patch? I can add your
Co-developed-by: / Signed-off-by: ?

Thanks.

>  
>  	return worker;
> -- 
> 2.45.2
> 

