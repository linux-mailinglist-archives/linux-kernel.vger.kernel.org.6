Return-Path: <linux-kernel+bounces-237601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED54923B58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E475282A24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6BE15884B;
	Tue,  2 Jul 2024 10:26:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E996154449
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915987; cv=none; b=UNHbcrv74ZttF82DWtry5bkKwCWlY0Z92HLBX1tf//1My2UzB6p7IL3g7x6J+gK2QSXiHZds7Px0ZbAmqaF3B5DDfdj2CfRBD8O8eLk1p1VGyHO4tQePh+eGGXCgM06LDs88ych6FzYJu/gSfdDXcDM2ukVqshFJroeCnKJCv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915987; c=relaxed/simple;
	bh=VR9tXPykvNiwoEziiNPsUhmQ7VutUy7dDdMJOePa788=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYw642Ld7ZDPR49RMySREv6JM5ov1s2/0ktURWJt/g2mj311JU0rwnZ681b4tkF4MiFB9INmsJz49PGh6AW/juqLwPeamNHwt0hWZqSVtbDKTpfSkaafkAiEnlKoUh6ociHkUeErUxUciPuuPwMwcOJm03bqKkPTsHI3UTicnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849DD339;
	Tue,  2 Jul 2024 03:26:48 -0700 (PDT)
Received: from [10.1.32.193] (XHFQ2J9959.cambridge.arm.com [10.1.32.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34F593F762;
	Tue,  2 Jul 2024 03:26:22 -0700 (PDT)
Message-ID: <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
Date: Tue, 2 Jul 2024 11:26:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZoMG6n4hQp5XMhUN@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2024 20:43, Catalin Marinas wrote:
> On Fri, Jun 28, 2024 at 11:20:43AM -0700, Yang Shi wrote:
>> On 6/28/24 10:24 AM, Catalin Marinas wrote:
>>> This patch does feel a bit like working around a non-optimal user choice
>>> in kernel space. Who knows, madvise() may even be quicker if you do a
>>> single call for a larger VA vs touching each page.
>>
>> IMHO, I don't think so. I viewed this patch to solve or workaround some ISA
>> inefficiency in kernel. Two faults are not necessary if we know we are
>> definitely going to write the memory very soon, right?
> 
> I agree the Arm architecture behaviour is not ideal here and any
> timelines for fixing it in hardware, if they do happen, are far into the
> future. Purely from a kernel perspective, what I want though is make
> sure that longer term (a) we don't create additional maintenance burden
> and (b) we don't keep dead code around.
> 
> Point (a) could be mitigated if the architecture is changed so that any
> new atomic instructions added to this range would also come with
> additional syndrome information so that we don't have to update the
> decoding patterns.
> 
> Point (b), however, depends on the OpenJDK and the kernel versions in
> distros. Nick Gasson kindly provided some information on the OpenJDK
> changes. The atomic_add(0) change happened in early 2022, about 5-6
> months after MADV_POPULATE_WRITE support was added to the kernel. What's
> interesting is Ampere already contributed MADV_POPULATE_WRITE support to
> OpenJDK a few months ago:
> 
> https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a
> 
> The OpenJDK commit lacks explanation but what I gathered from the diff
> is that this option is the preferred one in the presence of THP (which
> most/all distros enable by default). If we merge your proposed kernel
> patch, it will take time before it makes its way into distros. I'm
> hoping that by that time, distros would have picked a new OpenJDK
> version already that doesn't need the atomic_add(0) pattern. If that's
> the case, we end up with some dead code in the kernel that's almost
> never exercised.
> 
> I don't follow OpenJDK development but I heard that updates are dragging
> quite a lot. I can't tell whether people have picked up the
> atomic_add(0) feature and whether, by the time a kernel patch would make
> it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.
> 
> There's a point (c) as well on the overhead of reading the faulting
> instruction. I hope that's negligible but I haven't measured it.
> 

Just to add to this, I note the existing kernel behaviour is that if a write
fault happens in a region that has a (RO) huge zero page mapped at PMD level,
then the PMD is shattered, the PTE of the fault address is populated with a
writable page and the remaining PTEs are populated with order-0 zero pages
(read-only).

This seems like odd behaviour to me. Surely it would be less effort and more
aligned with the app's expectations to notice the huge zero page in the PMD,
remove it, and install a THP, as would have been done if pmd_none() was true? I
don't think there is a memory bloat argument here because, IIUC, with the
current behaviour, khugepaged would eventually upgrade it to a THP anyway?

Changing to this new behaviour would only be a partial solution for your use
case, since you would still have 2 faults. But it would remove the cost of the
shattering and ensure you have a THP immediately after the write fault. But I
can't think of a reason why this wouldn't be a generally useful change
regardless? Any thoughts?

Thanks,
Ryan


