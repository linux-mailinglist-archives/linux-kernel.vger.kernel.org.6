Return-Path: <linux-kernel+bounces-411132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A59CF385
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22D01F222AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DB1D89E4;
	Fri, 15 Nov 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="sz6b1Bi2"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD01D5CD4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693786; cv=none; b=PFP0glBJkyS1rt/3on4dtahw0TMcekYL653/HRY2roT1RqGfubdq1i0bmOzS5Fyr+FEv19PYfWXDAM4y6mINmeqtM1lbSB2Ngy8rnCF/yE/8KRCT9t1/28lNth74+H/RQYiK5AvZoiPO87ccrYAw1sHr9pOUv0LzvtOa8u5t42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693786; c=relaxed/simple;
	bh=OR6cvZwHMTvSAZNQ/w8R8ZnSOAWIkAcQavcGcuXV3nA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni/Q5jZ0mH2Ns5eUc7zkFMqy7CwkGJO+nQlTvYS9rKMaypj8BB3g3376tmckLZZVP05FSjGSHJBy8Q6oppnL4ALHnHxdb/PF8E8L7SOEsRERiqqY66uV0HR9AezD5g/oXmo/fhxxuk2ciTF6uEm6wyCFzhcCMQfwx4sQCEyCPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=sz6b1Bi2; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id B65DF1770E5; Fri, 15 Nov 2024 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731693783; bh=OR6cvZwHMTvSAZNQ/w8R8ZnSOAWIkAcQavcGcuXV3nA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=sz6b1Bi2mwGOq5jsiSHDSDqi/NyPQUqLD77RUQT6Kl5urEfWsDiqVXbOLLKIq6fJS
	 iLMeFG4AU4SfMkRMcUAaLI2zER+865zeTRp8AT5bgSX999anQIsyp4yrXGwSXCF2ed
	 aWxpjCMTw8R3366he3VwNivnUfVUaLe3UIgcRrDegyDMoFacDDno6EK8fezNsqWBnm
	 9uT4aXEfdmXkwvkJiWqv3f2pnrjnGPbSE9lAwoJhAi0LO86ejI7sd3djh6MJ6chlf0
	 ZDEMcOKwK0ohdPn/hyhBGZOXS8QONXF44of3FRGEfH0/dZgBXANYJgfj4vYqakf88q
	 9GFYzVxvmfD2g==
Date: Fri, 15 Nov 2024 18:03:03 +0000
From: Nir Lichtman <nir@lichtman.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, kees@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: fix no kernel module found error to be more clear
Message-ID: <20241115180303.GA209620@lichtman.org>
References: <20241115165541.GB209124@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115165541.GB209124@lichtman.org>

On Fri, Nov 15, 2024 at 04:55:41PM +0000, Nir Lichtman wrote:
> Problem: Before starting the enumeration of the supported formats the
> default return value is set to no entity which is misleading since if
> the kernel module of the binary format is not found, it would return no
> entity to user mode which is misleading since it is signaling that a
> file was not found, but in this case the more suitable error is that the
> executable has an unsupported format

Disregard this, I have come to the conclusion that it is unnecessary,
since at least one built-in binary format supported directly in the kernel 
is required for loading kernel modules, this is because the kernel executes
a user mode modprobe to load the module.

Interestingly, placing a "modprobe" in /sbin/modprobe and adding 0
supported formats in the kernel configuration, but adding module support,
results in a loop of calls to the search_binary_handler function,
since it keeps trying to load a module to load "modprobe", it does give up
though at some point and just panics as expected, but it does result in some
visible hold before hand.

Thanks and sorry for the confusion,
Nir

> 
> Solution: Refactor to return no-exec error instead
> 
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 3394de5882af..6324f9546b09 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1740,7 +1740,7 @@ static int search_binary_handler(struct linux_binprm *bprm)
>  	if (retval)
>  		return retval;
>  
> -	retval = -ENOENT;
> +	retval = -ENOEXEC;
>   retry:
>  	read_lock(&binfmt_lock);
>  	list_for_each_entry(fmt, &formats, lh) {
> -- 
> 2.39.2
> 

