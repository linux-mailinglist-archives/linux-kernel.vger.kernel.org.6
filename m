Return-Path: <linux-kernel+bounces-437932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB179E9AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C31285F13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CF1C5CAF;
	Mon,  9 Dec 2024 15:37:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1A1B423A;
	Mon,  9 Dec 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758647; cv=none; b=Xnecs2wodbTW63A9ZYdeeecwZqEk/OTiyQANDWD6qkchznpdsQ5vqiF18Lx05Nrr/un/pwRROXHcehG6/W/D9dS7WFPtTotEhctziJ8Qd8htn3wg3F4hA+b9tmRo1FVCo0yrBRwdInhY/x2xWWMLulAVQ1c7H/1zPPbT8Nq2Wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758647; c=relaxed/simple;
	bh=lkBrgp6rkOeLfvB7fdrtpF13W4DkNBpJo7urfDYaWkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usoaa20UmNFW6W61awxSowCK/u5s815PucRJi6fwnJIpIw5vbVxWxlSSPce1ETz/mZAShN0PrN1Po+SE68MbSatLk0nSqtaMBJYjscTsBInVJVBphTd+yeLBpObS/fhEEmsWOwicuodUV2xdwexllJm6xlFhrmsNrekkxv6gRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E052DC4CED1;
	Mon,  9 Dec 2024 15:37:25 +0000 (UTC)
Date: Mon, 9 Dec 2024 15:37:23 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: Mark Brown <broonie@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Subject: Re: arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <Z1cOs2sGff1_TtQZ@arm.com>
References: <202412082005.OBJ0BbWs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412082005.OBJ0BbWs-lkp@intel.com>

On Mon, Dec 09, 2024 at 12:47:33PM +0800, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
> >> arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes address space '__user' of expression
>    arch/arm64/kernel/signal.c:1054:9: sparse: sparse: cast removes address space '__user' of expression
>    arch/arm64/kernel/signal.c:1461:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void ( [noderef] [usertype] __user *[assigned] [usertype] sigtramp )( ... ) @@     got void * @@
>    arch/arm64/kernel/signal.c:1461:26: sparse:     expected void ( [noderef] [usertype] __user *[assigned] [usertype] sigtramp )( ... )
>    arch/arm64/kernel/signal.c:1461:26: sparse:     got void *
> 
> vim +/__user +1046 arch/arm64/kernel/signal.c

Thanks for this, the warning is valid.

> 2c020ed8d148f7 Catalin Marinas 2012-03-05  1010  
> eaf62ce1563b85 Mark Brown      2024-10-01  1011  #ifdef CONFIG_ARM64_GCS
> eaf62ce1563b85 Mark Brown      2024-10-01  1012  static int gcs_restore_signal(void)
> eaf62ce1563b85 Mark Brown      2024-10-01  1013  {
> eaf62ce1563b85 Mark Brown      2024-10-01  1014  	unsigned long __user *gcspr_el0;

I think we should keep this as u64 since it's a sysreg.

> eaf62ce1563b85 Mark Brown      2024-10-01  1015  	u64 cap;
> eaf62ce1563b85 Mark Brown      2024-10-01  1016  	int ret;
> eaf62ce1563b85 Mark Brown      2024-10-01  1017  
> eaf62ce1563b85 Mark Brown      2024-10-01  1018  	if (!system_supports_gcs())
> eaf62ce1563b85 Mark Brown      2024-10-01  1019  		return 0;
> eaf62ce1563b85 Mark Brown      2024-10-01  1020  
> eaf62ce1563b85 Mark Brown      2024-10-01  1021  	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
> eaf62ce1563b85 Mark Brown      2024-10-01  1022  		return 0;
> eaf62ce1563b85 Mark Brown      2024-10-01  1023  
> eaf62ce1563b85 Mark Brown      2024-10-01  1024  	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);

Remove the cast here.

> eaf62ce1563b85 Mark Brown      2024-10-01  1025  
> eaf62ce1563b85 Mark Brown      2024-10-01  1026  	/*
> eaf62ce1563b85 Mark Brown      2024-10-01  1027  	 * Ensure that any changes to the GCS done via GCS operations
> eaf62ce1563b85 Mark Brown      2024-10-01  1028  	 * are visible to the normal reads we do to validate the
> eaf62ce1563b85 Mark Brown      2024-10-01  1029  	 * token.
> eaf62ce1563b85 Mark Brown      2024-10-01  1030  	 */
> eaf62ce1563b85 Mark Brown      2024-10-01  1031  	gcsb_dsync();
> eaf62ce1563b85 Mark Brown      2024-10-01  1032  
> eaf62ce1563b85 Mark Brown      2024-10-01  1033  	/*
> eaf62ce1563b85 Mark Brown      2024-10-01  1034  	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap.
> eaf62ce1563b85 Mark Brown      2024-10-01  1035  	 * We don't enforce that this is in a GCS page, if it is not
> eaf62ce1563b85 Mark Brown      2024-10-01  1036  	 * then faults will be generated on GCS operations - the main
> eaf62ce1563b85 Mark Brown      2024-10-01  1037  	 * concern is to protect GCS pages.
> eaf62ce1563b85 Mark Brown      2024-10-01  1038  	 */
> eaf62ce1563b85 Mark Brown      2024-10-01  1039  	ret = copy_from_user(&cap, gcspr_el0, sizeof(cap));

Add one here.

> eaf62ce1563b85 Mark Brown      2024-10-01  1040  	if (ret)
> eaf62ce1563b85 Mark Brown      2024-10-01  1041  		return -EFAULT;
> eaf62ce1563b85 Mark Brown      2024-10-01  1042  
> eaf62ce1563b85 Mark Brown      2024-10-01  1043  	/*
> eaf62ce1563b85 Mark Brown      2024-10-01  1044  	 * Check that the cap is the actual GCS before replacing it.
> eaf62ce1563b85 Mark Brown      2024-10-01  1045  	 */
> eaf62ce1563b85 Mark Brown      2024-10-01 @1046  	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))

Drop the cast here.

> eaf62ce1563b85 Mark Brown      2024-10-01  1047  		return -EINVAL;
> eaf62ce1563b85 Mark Brown      2024-10-01  1048  
> eaf62ce1563b85 Mark Brown      2024-10-01  1049  	/* Invalidate the token to prevent reuse */
> eaf62ce1563b85 Mark Brown      2024-10-01  1050  	put_user_gcs(0, (__user void*)gcspr_el0, &ret);

We need a cast here if we are to go with u64 gcspr_el0 (it wasn't needed
before, not sure why it was cast to void *).

> eaf62ce1563b85 Mark Brown      2024-10-01  1051  	if (ret != 0)
> eaf62ce1563b85 Mark Brown      2024-10-01  1052  		return -EFAULT;
> eaf62ce1563b85 Mark Brown      2024-10-01  1053  
> eaf62ce1563b85 Mark Brown      2024-10-01  1054  	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);

And this would be +8 I guess.

> eaf62ce1563b85 Mark Brown      2024-10-01  1055  
> eaf62ce1563b85 Mark Brown      2024-10-01  1056  	return 0;
> eaf62ce1563b85 Mark Brown      2024-10-01  1057  }
> eaf62ce1563b85 Mark Brown      2024-10-01  1058  

-- 
Catalin

