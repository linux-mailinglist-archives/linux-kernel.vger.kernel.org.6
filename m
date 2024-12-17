Return-Path: <linux-kernel+bounces-448632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F249F4332
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7705C16143D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9159814F117;
	Tue, 17 Dec 2024 05:52:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4C18E20
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414769; cv=none; b=CidUxN8Sb/yEhexKFUkd5Vd9Zw9D/t1E6dzsEsjDKQcDdNPkzre62c0x5RHdHVKyU4Je22APHXmTV3cZ0tzP38Ter7NMz+oQmriiIFMrwNHu7+nkGY5KAPM6MVIXVtwTG5lG09+KuG3ai4rT5PsnRU0ZjEqEQ5mQLIsCxe7DvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414769; c=relaxed/simple;
	bh=JlMVmc1XtXQGtIUauuRy+ILK+g60vLcQcBqfJA7UrSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAS4TBrtZ5URCg5Zfiat1tWn2XvZrXdz0cXZoFhRuBXzYfVksoWtM1rP1002NiBl6AIVQbXOVM4N45uhvt6sYVXL71ylpKoQRJ0MT3DsNuN0EFW+86ZpJViXvTcd17wmN2nALzEhEzLj3qyLzTfYRmRri1OYW2gSX4olD+zhYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFBD11007;
	Mon, 16 Dec 2024 21:53:13 -0800 (PST)
Received: from [10.162.40.67] (K4MQJ0H1H2.blr.arm.com [10.162.40.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ECAE3F528;
	Mon, 16 Dec 2024 21:52:35 -0800 (PST)
Message-ID: <ebf79c15-6ba3-4327-91d9-83b9a21e6dc5@arm.com>
Date: Tue, 17 Dec 2024 11:22:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] khugepaged: Rename hpage_collapse_scan_pmd() ->
 ptes()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com,
 kirill.shutemov@linux.intel.com, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-2-dev.jain@arm.com>
 <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/12/24 9:48 am, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 10:20:54PM +0530, Dev Jain wrote:
>> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> +static int hpage_collapse_scan_ptes(struct mm_struct *mm,
> i don't think this is necessary at all.  you're scanning a pmd.
> you might not be scanning in order to collapse to a pmd, but pmd
> is the level you're scanning at.

I did that if at all in the review process we note that we need to even drop
down the starting scan order, so that we do not skip smaller VMAs. I kinda
agree with you so till that time I have no problem reverting.

>

