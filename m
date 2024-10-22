Return-Path: <linux-kernel+bounces-376846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1339AB6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD64283C61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB61CB30C;
	Tue, 22 Oct 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbU9V73R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB01BDA8D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624809; cv=none; b=jsR4tRzrah8Gjt9yl4L+IS9l5wdz9Jt6Pn4Tt3+MIAkpxc1Byo23lJBL+D9g4F+933w0WQnYgaRVgg79Vl2O/RQFcWi6Zgpw5EmpYsLO9TQhHjZHIjjtngmSl5MQdPmTZljAW+0m1cm1SgIeTO46JwOIKL+Kgknk75xl0hhoA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624809; c=relaxed/simple;
	bh=LZ2EybuFq1FkBRq13QtwAEuugNtKJzKtWb0yOGerabA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRF9kGx51PWJa5X7iBBwOBuaXt5Qu0MpnoTzQ4k5fz2p1X9qebvv1+nOt9DUC/y7BLPMVyi9na+1SwWzlwfReLGLvXigNaea4bevxBpJ5xlO76kECB3QBxB4BFNIto/KIzvs9TiaJm/lMxTIe0x0tXOfLFfiApUaCaYil5p9cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbU9V73R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4162C4CEC3;
	Tue, 22 Oct 2024 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729624808;
	bh=LZ2EybuFq1FkBRq13QtwAEuugNtKJzKtWb0yOGerabA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbU9V73RoCqhv8aL0V3VEYxUwwDr7AZr6pe6EYfLXMxl15hUPVbxAXVuTmYPsRnQm
	 lJDcPoOG8d3AzZwCY8yrSeUAJHqk9mH//pKIXG4qHg3gt1+Mhuh861kEeyHXN+7S8o
	 EtbqxBMyxihFdAcm9BMApe4G5BzoksYrLx9gIGdN+cpb3VzdgJslZvN6nvTRnEPx0R
	 jt3zTeXlkUoK5QDiz+Zw5eFUm4GFYw/B0im0+WfcZDf95MoNey46n5a/35o0R8YPK4
	 oR6VlgFZ7MGx7h6lqeKSJsh6JzYSSgBpXhgpx8/BQk+Khu10UCbUTbS2YWnVEoJue2
	 dxTkO/1vLkjUA==
Date: Tue, 22 Oct 2024 21:12:48 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] sysctl: simplify the min/max boundary check
Message-ID: <5yfnu64fqsuahcmifvqdaynvdesqvaehhikhjff46ndoaacxyd@jvjrd3ivdpyz>
References: <20240905134818.4104-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905134818.4104-1-wen.yang@linux.dev>

On Thu, Sep 05, 2024 at 09:48:18PM +0800, Wen Yang wrote:
> The do_proc_dointvec_minmax_conv_param structure provides the minimum and
> maximum values for doing range checking for the proc_dointvec_minmax()
> handler, while the do_proc_douintvec_minmax_conv_param structure also
> provides these min/max values for doing range checking for the
> proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.
Finally got around to reviewing this. Sorry for the wait. Thx for the
patch but I don't like how this looks in terms of Integer promotion in
32b architectures.

> 
> To avoid duplicate code, a new proc_minmax_conv_param structure has been
I'm not seeing duplicate code here as one is handling the int case and
the other is handling the uint case. And it is making sure that all
assignments and comparisons are without any Integer Promotion issues.
I'm not saying that it cannot be done, but it has to address Integer
Promotion issues in 32b architectures. 

> introduced to replace both do_proc_dointvec_minmax_conv_param and
> do_proc_douintvec_minmax_conv_param mentioned above.
> 
> This also prepares for the removal of sysctl_vals and sysctl_long_vals.
If I'm not mistaken this is another patchset that you sent separetly. Is
it "sysctl: encode the min/max values directly in the table entry"?

...

> @@ -904,8 +890,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>  		return ret;
>  
>  	if (write) {
> -		if ((param->min && *param->min > tmp) ||
> -		    (param->max && *param->max < tmp))
> +		if ((param->min > tmp) || (param->max < tmp))
>  			return -ERANGE;
>  
>  		WRITE_ONCE(*valp, tmp);
> @@ -936,10 +921,10 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>  int proc_douintvec_minmax(const struct ctl_table *table, int write,
>  			  void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct do_proc_douintvec_minmax_conv_param param = {
> -		.min = (unsigned int *) table->extra1,
> -		.max = (unsigned int *) table->extra2,
> -	};
> +	struct proc_minmax_conv_param param;
> +
> +	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
> +	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
This is one of the cases where there is potential issues. Here, if the
unsigned integer value of table->extra{1,2}'s value is greater than when
the maximum value of a signed long, then the value assigned would be
incorrect. Note that the problem does not go away if you remove the
"unsigned" qualifier; it remains if table->extra{1,2} are originally
unsigned.

I'm not sure if there are more, but just having one of these things
around make me uncomfortable. Please re-work the patch in order to
remove this issue in order to continue review.

best

-- 

Joel Granados

