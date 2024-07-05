Return-Path: <linux-kernel+bounces-242825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47B928DA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07071F228AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0A16D32C;
	Fri,  5 Jul 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="XUzn69ez"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEA13A879
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720205495; cv=none; b=dNYqnH/WdMeXmXuNTxcJJUlGneX5GS/3rinKhsl++wd2GFOmCBMtAQXRJsIF93ROi0ytvpzP5yVHADu00ZRF2XNaB18XxV11ATrNIr8igTVWrmpFzi8RUksGirazEYFM9k6hEdGTeauuOhf4YBCpMBC+vzsaVCcO902uni0xX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720205495; c=relaxed/simple;
	bh=cKyY+4XUI1SkNydNHSERke5eqFG+HXyrpLg7rZU84Ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EfT+4dxslTZHDF4j5L2jx/jknnLYuGK6qEv6lyR+tLiYoGrawNfOX0gk7JWJKZGK/tRNIsdG3tXkZ9GNFfgOdO/3NptMx2Pl92dD6xsKxOHjxn4RQpXq17nHkWABz5qaTSzCAc5abC/d7+WgPe1ZUsIhdq0/yd+eg+wycJqARPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=XUzn69ez; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1720205493;
	bh=cKyY+4XUI1SkNydNHSERke5eqFG+HXyrpLg7rZU84Ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XUzn69ezoT9ouWujaDn4eAmmXvnv0HGa1fydv3k9cqsF1d+T613pzu3/thmHG4cTV
	 BlwAyiw/UrFCVH1Z1zDNOvZdIUoT+GZ0zUoDHKIFR7Z29Jb+KbSsL340JXC0MxXvnR
	 anzrw5fD08tr//sUam5HGWy3VL7PvbZAx6JxtiAI=
Received: by gentwo.org (Postfix, from userid 1003)
	id 607AD4035D; Fri,  5 Jul 2024 11:51:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 5F95A401E2;
	Fri,  5 Jul 2024 11:51:33 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:51:33 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org, 
    anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <Zog6eFF1zDl4IRHX@arm.com>
Message-ID: <b1b52185-595a-b4e7-cc96-90faf34c8077@gentwo.org>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com> <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org> <Zn7xs6OYZz4dyA8a@arm.com> <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com> <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com> <ZoZzhf9gGQxADLFM@arm.com> <b0315df9-b122-46cd-12b2-7704d4a4392e@gentwo.org> <Zog6eFF1zDl4IRHX@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 5 Jul 2024, Catalin Marinas wrote:

> There's nothing about arm64 in there and it looks like the code prefers
> MADV_POPULATE_WRITE if THPs are enabled (which is the case in all
> enterprise distros). I can't tell whether the change was made to work
> around the arm64 behaviour, there's no commit log (it was contributed by
> Ampere).

It took us a long time and numerous developers and QA teams  to get to 
this insight. You dont want to replicate this for other applications.

> There's a separate thread with the mm folk on the THP behaviour for
> pmd_none() vs pmd mapping the zero huge page but it is more portable for
> OpenJDK to use madvise() than guess the kernel behaviour and touch small
> pages or a single large pages. Even if one claims that atomic_add(0) is
> portable across operating systems, the OpenJDK code was already treating
> Linux as a special case in the presence of THP.

Other apps do not have such a vibrant developer community and no ampere 
employees contributing. They will never know and just say ARM has bad 
performance.


>> It would be much simpler to just merge the patch and be done with it.
>> Otherwise this issue will continue to cause uncountably many hours of
>> anguish for sysadmins and developers all over the Linux ecosystem trying to
>> figure out what in the world is going on with ARM.
>
> People will be happy until one enables execute-only ELF text sections in
> a distro and all that opcode parsing will add considerable overhead for
> many read faults (those with a writeable vma).

The opcode is in the l1 cache since we just faulted on it. There is no 
"considerable" overhead.

> I'd also like to understand (probably have to re-read the older threads)
> whether the overhead is caused mostly by the double fault or the actual
> breaking of a THP. For the latter, the mm folk are willing to change the
> behaviour so that pmd_none() and pmd to the zero high page are treated
> similarly (i.e. allocate a huge page on write fault). If that's good
> enough, I'd rather not merge this patch (or some form of it) and wait
> for a proper fix in hardware in the future.

THP is secondary effect here. Note that similar approaches have been 
implemented for other architectures. This is not a new approach and the 
approach is widely used on other platforms.

If those on other Linux platforms encounter this strange discussion here 
then they would come to the same conclusion that I have.

> Just to be clear, there are still potential issues to address (or
> understand the impact of) in this patch with exec-only mappings and
> the performance gain _after_ the THP behaviour changed in the mm code.
> We can make a call once we have more data but, TBH, my inclination is
> towards 'no' given that OpenJDK already support madvise() and it's not
> arm64 specific.

It is arm64 specific. Other Linux architectures have optimizations for 
similar issues in their arch code as mentioned in the patch or the 
processors will not double fault.

Is there a particular reason for ARM as processor manufacturer to oppose 
this patch? We have mostly hand waving and speculations coming from you 
here.

What the patch does is clearly beneficial and it is an established 
way of implementing read->write fault handling.

