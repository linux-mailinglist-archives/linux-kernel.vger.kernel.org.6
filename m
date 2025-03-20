Return-Path: <linux-kernel+bounces-569767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2AFA6A73F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C6E3BF0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB721638D;
	Thu, 20 Mar 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2CDebSS"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA3221DAC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477737; cv=none; b=Va0jBDU5xvfTdfbrrf3s3A+nDxbujir2eqCP47R+Two00NTfiH0kdu7A0IYVJI9siXdceh9aNd0PX+PSqnLY+jsYAbVc3KwJFwZaQiAZj7685AZYVjOlZ4vdN/bJzS7icZCa2gREnqezc4WdY35nDdn26KNnqstTJ+zH7BWy+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477737; c=relaxed/simple;
	bh=Vc7ZkIzv8oxEJ6+goncNLTFMvXYEeeE5ytAwHO+0mLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPRU2lXEBzDjBrzYgdiQe2OigxD8L4PUAZdx+WTCzubj+zApSM1VlyNoRIdDduQ+p+N+pztdzPOIwbSMf5J7dwmFUn50SmMYxhtIhKrSGk7ujxoxDtQOU6YquHTS/wjlC8CYtf0K02/kfgX3GD0LL5SLkK5NeHik3Mio8yzOf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2CDebSS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Mar 2025 06:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742477733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZwUz6QZstkoXHa6zv2WBNC3kFaN1c29ScZyOwFuwuQ=;
	b=B2CDebSSLH2AF34xHfzkuc/XnnMSxIQwb3jQFJyXO4XUzeGS83OBG24MKkE/3yb/Y97Pr+
	sKnl0AoQmIGtVx2g3chtdV8PXnP4p2IPfe9yt8SngOx0WS5I4vFjqfaTU2R72wn2VNz5L1
	uEXPH6ZozCXMbaA9/K60DGEragrZKjA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-arm tree
Message-ID: <Z9wZm388iYM0Cnrd@linux.dev>
References: <20250320203203.1de92b98@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320203203.1de92b98@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

Hi,

On Thu, Mar 20, 2025 at 08:32:03PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm-arm tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> arch/arm64/kernel/cpu_errata.c: In function 'has_impdef_pmuv3':
> arch/arm64/kernel/cpu_errata.c:279:38: error: passing argument 1 of 'is_midr_in_range_list' makes pointer from integer without a cast [-Wint-conversion]
>   279 |         return is_midr_in_range_list(read_cpuid_id(), impdef_pmuv3_cpus);
>       |                                      ^~~~~~~~~~~~~~~
>       |                                      |
>       |                                      u32 {aka unsigned int}
> arch/arm64/kernel/cpu_errata.c:47:53: note: expected 'const struct midr_range *' but argument is of type 'u32' {aka 'unsigned int'}
>    47 | bool is_midr_in_range_list(struct midr_range const *ranges)
>       |                            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> arch/arm64/kernel/cpu_errata.c:279:16: error: too many arguments to function 'is_midr_in_range_list'
>   279 |         return is_midr_in_range_list(read_cpuid_id(), impdef_pmuv3_cpus);
>       |                ^~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/cpu_errata.c:47:6: note: declared here
>    47 | bool is_midr_in_range_list(struct midr_range const *ranges)
>       |      ^~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   1f561ad4b8f5 ("Merge branch 'kvm-arm64/pv-cpuid' into new-next")
> 
> The merge missed fixing up this instance from commit
> 
>   e1231aacb065 ("arm64: Enable IMP DEF PMUv3 traps on Apple M*")
> 
> I have applied the following patch for today (but this should go into
> the kvm-arm tree (perhaps squashed into the above merge).

Thanks Stephen for the fix. Looks like I forgot to push /next when I
pushed out the tag, addressing now.

Thanks,
Oliver

