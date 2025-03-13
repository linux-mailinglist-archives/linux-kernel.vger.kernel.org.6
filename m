Return-Path: <linux-kernel+bounces-559239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505AA5F131
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9643AE558
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB282571BF;
	Thu, 13 Mar 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfwuO4E7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCA16BE17
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862688; cv=none; b=O5Xw4RrAEtoKSYUnwXCkkcAuuaLyiVcpONpAgYeZI0HxEj6hYPn+cRgvpquR/Nw/fC5Y/DkGykeoWvzGr88MohWXjv1a9QAo4moyR6b3QysFTFmmeo3faRiIWTQaT/LrTyPMGVjFSjPoocPjKcs+ekFRsRx/ttpAfK31WQCgsE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862688; c=relaxed/simple;
	bh=Ea/nF/6yF8q+yD6HjryxJLrzxjPzAhV6V2F/wso++vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZARHBxDrdoRscRwMIjlTd6TEI/1e1B0aErgpJrLI3KDLy2mBIaWSoRSA4wHOupEXAb4nStLsKwlksXnZq5iFdkcMiylpM9uCdr7iSeAzYscvaHqfL52fXnhMU5MHb8xvzcmEh0hdYHsg62fcWUD+eRe28XJjXEyg89lQHpINQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfwuO4E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E27C4CEDD;
	Thu, 13 Mar 2025 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862688;
	bh=Ea/nF/6yF8q+yD6HjryxJLrzxjPzAhV6V2F/wso++vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfwuO4E7CBH0225uI4SAo32VIdUKvpQ2GRBTZkOarnahlXaW9r933s3zWIgLiurhe
	 /RZbf0TQLYgyWwGN9gqyZ067XyA3AUe60Z8xL9UB1KynBpWSH4tReS6K+hvnwgxUMj
	 RQEFKCEbTeXXH7uyPtnlm/aqiZ+hAZFrJLW/WS2JLmVS2Ouc4QKk9vY3dRLzykS2a7
	 1PJsvBSbGr53MrI9FvxGdwaDom62AUo68cqHlP3dHM2G6cIwm3WH1fskmz0nubAen/
	 F5XtF8pZjchZ5e2ZHS83RaIVya7AcB73xx3N3IR/0JYmJVXdsZx+KjYGCVdMP2pQc/
	 2x86DWb/qTzwQ==
Date: Thu, 13 Mar 2025 11:44:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 7/8] [DO NOT MERGE] x86/kexec: Add int3 in kexec path
 for testing
Message-ID: <Z9K3GXSaZUcVr8cb@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-8-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-8-dwmw2@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 17d41e6e1a4b..2b7fc59af373 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -158,7 +158,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	lidt	(%rsp)
>  	addq	$10, %rsp
>  
> -	//int3
> +	int3

So this is all boot-serialized functionality with no SMP concerns 
whatsoever, right?

If yes then we could use something like this:

	static int exception_selftest = 1;

and add the INT3 point:

	int3
.globl after_int3
after_int3:

And do this in the early exception handler:

	...
	
	if (exception_selftest) {
		exception_selftest = 0;

		print_something_warm_and_fuzzy();

		IRET-to-after_int3;
	}

	...

	... regular exception path ...

... but all in assembly or so ;-)

This would make it reasonably certain that the most complex bits of 
this new debuging code are in working order, all the time.

Thanks,

	Ingo

