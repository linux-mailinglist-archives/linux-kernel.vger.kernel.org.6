Return-Path: <linux-kernel+bounces-448689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6FC9F4459
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354257A60F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483E919F13C;
	Tue, 17 Dec 2024 06:43:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D57156230
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417823; cv=none; b=imtPXXyYI3SGfC3wHweN916NqinvTziPR3ijECl2p3qSvbVkQ+HFnPAsOvRp0j/MFAfhpQy5cKMnncsfy812n7X9F8sbvX0US0Ho//eaStPfl/5SAJesdSHuAo0sws5toXs2EIe0tLaKltkUkHSSh7WgpjIXU/W7YwwfV4XA4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417823; c=relaxed/simple;
	bh=jveWgxfLXLRGkrv5az/fOu+EI6bEi3NCZ0MMgDBzS9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lp4nCwd0Fd/M8xm9BUmjMqnQvMFrbvX+EYeeKeSQ4csR03R3HBnHIyBGmkZHwqRoFOdYASPEHce3xh9HyDYD/S8FFiqh6XtMUKcjOa7Xp3K59K37xB18j/iFP/9ZS7tR1S1Jlo0aFSAs50y17urQMv5GmEtAe4X68pgYzIIfczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C7A1007;
	Mon, 16 Dec 2024 22:44:09 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3F43F528;
	Mon, 16 Dec 2024 22:43:35 -0800 (PST)
Message-ID: <0a33f5c1-c974-4d4a-94dd-6741399e186e@arm.com>
Date: Tue, 17 Dec 2024 06:43:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] khugepaged: Rename hpage_collapse_scan_pmd() ->
 ptes()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 kirill.shutemov@linux.intel.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu,
 haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
 surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
 zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-2-dev.jain@arm.com>
 <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2024 04:18, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 10:20:54PM +0530, Dev Jain wrote:
>> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> +static int hpage_collapse_scan_ptes(struct mm_struct *mm,
> 
> i don't think this is necessary at all.  you're scanning a pmd.
> you might not be scanning in order to collapse to a pmd, but pmd
> is the level you're scanning at.
> 

Sorry Matthew, I don't really understand this statement. Prior to the change we
were scanning all PTE entries in a PTE table with the aim of collapsing to a PMD
entry. After the change we are scanning some PTE entries in a PTE table with the
aim of collapsing to either to a multi-PTE-mapped folio or a single-PMD-mapped
folio.

So personally I think "scan_pmd" was a misnomer even before the change - we are
scanning the ptes.

