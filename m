Return-Path: <linux-kernel+bounces-374025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85459A60C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998842847C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438A1E3DD3;
	Mon, 21 Oct 2024 09:55:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED381E2822
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504524; cv=none; b=gh8e+14uJbqy4+PjNGHGSpbwHMmkWPRd8V+Hi71p+Cpa9UDndCab4f5fHlXpDME0ajI+FCYYrTTk6/HcCqke08dOGJOMwfd3J5PIYj/donYYhA8aG35v+WvJnMpnwDZibKJqpMkdsq1v2cjIedLCPDOuAtwZSgowZcvD/lBapL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504524; c=relaxed/simple;
	bh=qIpPXtC0SNrnkKvcXFjN5JdPncjjfBJ4E+7B2L34Oh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iU2nNryImzH/DwClHCYK7U8brNRG6RFtAFQ8isC1SA4uquyymUMNJ41p+NfEGNExLg7Xlf0qRsBeBRGn+rW5FpCr//cJDhd6y5pLeiGM6fTmXocXm1OuzJ9TudhbDuxvBsvvq7/5vrxN3ejamtOn7cvrJgdIphoRM8weQZAIy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2BF4DA7;
	Mon, 21 Oct 2024 02:55:50 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1DC3F73B;
	Mon, 21 Oct 2024 02:55:18 -0700 (PDT)
Message-ID: <745cb0c5-35ce-4879-9d98-52816f3241df@arm.com>
Date: Mon, 21 Oct 2024 10:55:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [RFC PATCH v1 00/57] Boot-time page size
 selection for arm64
Content-Language: en-GB
To: Joseph Salisbury <joseph.salisbury@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <f5baa653-fec1-4f6e-91b0-ed8368d3c725@oracle.com>
 <915e2f0c-f603-4617-8429-da4dacc862c4@redhat.com>
 <aa4b6c90-6e8c-4943-ba83-6688cdf776a1@oracle.com>
 <3f096ba0-b6f0-4db7-9d65-ba0550eb98b1@redhat.com>
 <eb0c7c21-5a45-4a36-a96a-1abaaf3bbd61@oracle.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <eb0c7c21-5a45-4a36-a96a-1abaaf3bbd61@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/10/2024 21:06, Joseph Salisbury wrote:
> 
> 
> 
> On 10/18/24 15:27, David Hildenbrand wrote:
>>
>>>>> Hi Ryan,
>>>>>
>>>>> First off, this is excellent work!  Your cover page was very detailed
>>>>> and made the patch set easier to understand.

Thanks!

>>>>>
>>>>> Some questions/comments:
>>>>>
>>>>> Once a kernel is booted with a certain page size, could there be issues
>>>>> if it is booted later with a different page size?  How about if this is
>>>>> done frequently?
>>>>
>>>> I think that is the reason why you are only given the option in RHEL
>>>> to select the kernel (4K vs. 64K) to use at install time.
>>>>
>>>> Software can easily use a different data format for persistance based
>>>> on the base page size. I would suspect DBs might be the usual suspects.
>>>>
>>>> One example is swap space I think, where the base page size used when
>>>> formatting the device is used, and it cannot be used with a different
>>>> page size unless reformatting it.
>>>>
>>>> So ... one has to be a bit careful ...
>>>>
>>> Yes, that is what I was thinking.  Once a userspace process does an I/O
>>> and if it is based on PAGE_SIZE things can go south.  I think this is
>>> not an issue with THP, so maybe it's possible with boot-time page selection?
>>
>> THP is a different beast and has different semantics: the base page size
>> doesn't change: the result of getpagesize() is unmodified ("transparent").
>>
>> One would have to emulate for a given user space process a different page
>> size ... and Ryan can likely tell some stories about that.
>>
>> Not that I consider it reasonable to have dynamic page sizes in the kernel and
>> then try emulating a different one for all user space.
> 
> This is probably  a case of ensuring proper documentation from the distro or
> application vendor.
> 
> Or maybe some type of "Safety gate" could be implemented outside of the kernel.
> Some check for the prior use of different page sizes, in the cases where it
> could cause problems.

I agree there are likely to be problems in some corner cases if switching page
size between boots, if persisted data makes assumptions about the page size. I
would argue that any problems that are observed should really be considered bugs
in the user space SW though.

But I don't think this is really any different from today; With Ubuntu, for
example, you can install both 4K and 64K kernels concurrently, then choose which
one to boot via Grub. So the issue exists there already. This proposed boot-time
page size selection series, doesn't make that any worse, it just simplifies the
distribution model, given the reality that distros are now having to support
multiple page sizes.

Thanks,
Ryan


