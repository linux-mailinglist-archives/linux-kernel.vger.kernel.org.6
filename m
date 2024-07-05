Return-Path: <linux-kernel+bounces-242815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B76D928D7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA181C2197E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085313D2BB;
	Fri,  5 Jul 2024 18:25:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5818224F2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203903; cv=none; b=mGr79+CfDgquyRtQJmYawZI8F0vmemVDMb0cRbyP9rpPSoynOMlxXkcPJuLQJ7+qnQxm2YIzCZ+45eYZ7dNnym0MCBzhKLmwks6qOneF4lXS0XkZbpqU1OigtX7mGS1aTglN6a4x5F2mP9aHRyTzd5ODkE1wDGsTtI1NVaG8DeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203903; c=relaxed/simple;
	bh=xr8QZU6ctkVkEXnZa8uSzs/Y75a3rxwCLycz0IHu4og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVXxQm58MOp9/IbkGsjNN1QE6LQWuXLiVdQjOZmB7d159F5hCCRgvFvHZt+q4iFzw8wH9vVwhSpv7ZROq3Ncz4s51dNYufBiOCgVRkS9TczMC7srtQYZyZoOIEVOGqx/HpwLxbrbHElwGt8mjTxQ/wEAVtScg/YSfZqKINGmcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AF8DA7;
	Fri,  5 Jul 2024 11:25:24 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7EB3F73B;
	Fri,  5 Jul 2024 11:24:58 -0700 (PDT)
Date: Fri, 5 Jul 2024 19:24:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zog6eFF1zDl4IRHX@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <b0315df9-b122-46cd-12b2-7704d4a4392e@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0315df9-b122-46cd-12b2-7704d4a4392e@gentwo.org>

On Fri, Jul 05, 2024 at 10:05:29AM -0700, Christoph Lameter (Ampere) wrote:
> On Thu, 4 Jul 2024, Catalin Marinas wrote:
> > It could be worked around with a new flavour of get_user() that uses the
> > non-T LDR instruction and the user mapping is readable by the kernel
> > (that's the case with EPAN, prior to PIE and I think we can change this
> > for PIE configurations as well). But it adds to the complexity of this
> > patch when the kernel already offers a MADV_POPULATE_WRITE solution.
> 
> The use of MADV_POPULATE_WRITE here is arch specific and not a general
> solution. It requires specialized knowledge and research before someone can
> figure out that this particular trick is required on Linux ARM64 processors.
> The builders need to detect this special situation in the build process and
> activate this workaround.

Not really, see this OpenJDK commit:

https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a

There's nothing about arm64 in there and it looks like the code prefers
MADV_POPULATE_WRITE if THPs are enabled (which is the case in all
enterprise distros). I can't tell whether the change was made to work
around the arm64 behaviour, there's no commit log (it was contributed by
Ampere).

There's a separate thread with the mm folk on the THP behaviour for
pmd_none() vs pmd mapping the zero huge page but it is more portable for
OpenJDK to use madvise() than guess the kernel behaviour and touch small
pages or a single large pages. Even if one claims that atomic_add(0) is
portable across operating systems, the OpenJDK code was already treating
Linux as a special case in the presence of THP.

> It would be much simpler to just merge the patch and be done with it.
> Otherwise this issue will continue to cause uncountably many hours of
> anguish for sysadmins and developers all over the Linux ecosystem trying to
> figure out what in the world is going on with ARM.

People will be happy until one enables execute-only ELF text sections in
a distro and all that opcode parsing will add considerable overhead for
many read faults (those with a writeable vma).

I'd also like to understand (probably have to re-read the older threads)
whether the overhead is caused mostly by the double fault or the actual
breaking of a THP. For the latter, the mm folk are willing to change the
behaviour so that pmd_none() and pmd to the zero high page are treated
similarly (i.e. allocate a huge page on write fault). If that's good
enough, I'd rather not merge this patch (or some form of it) and wait
for a proper fix in hardware in the future.

Just to be clear, there are still potential issues to address (or
understand the impact of) in this patch with exec-only mappings and
the performance gain _after_ the THP behaviour changed in the mm code.
We can make a call once we have more data but, TBH, my inclination is
towards 'no' given that OpenJDK already support madvise() and it's not
arm64 specific.

-- 
Catalin

