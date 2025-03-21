Return-Path: <linux-kernel+bounces-571756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB849A6C1C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1FB3ADD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8422DF9E;
	Fri, 21 Mar 2025 17:42:46 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE944C80
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578966; cv=none; b=OPwMjTSZhSAz7gqzEFWa563mIBLUKTLWGwci3Ewb/a6KSYVl1uQrVb0Z5pdqlFi1zxVTWwF9jE5hBiaiwr57YTI2BfX/tUR6d5voAwn9TeEDITUM9J/gxnRLQEA35hMAu2D/+C61JatKqvlren5FS75RkyIa8aT7cCVX4B0GfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578966; c=relaxed/simple;
	bh=gfWIaIrMy1GLDMTnMGkp8pmL07rpbHXzN4BabhJG/uo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnj8/a3ObzFIKRlI1bfxI9uNsTtobhEr06MidCbc1sWd4bCqYOdRCMEg9YjKOTEnPtJwfr/TS/Feyt+HozjInYQOFqN/g7jK6R/LTHmJtNwbHMuvcoyd11dTSt3bwL3VCsZbKlmEjEyWaRf9UOUo/r76zZJyioK504YMBLxfFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK8pG1h8Rz6K91Z;
	Sat, 22 Mar 2025 01:39:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A96C140142;
	Sat, 22 Mar 2025 01:42:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 18:42:33 +0100
Date: Fri, 21 Mar 2025 17:42:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>
Subject: Re: [RFC PATCH V1 09/13] mm: Add heuristic to calculate target node
Message-ID: <20250321174232.000047fa@huawei.com>
In-Reply-To: <20250319193028.29514-10-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
	<20250319193028.29514-10-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Mar 2025 19:30:24 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> One of the key challenges in PTE A bit based scanning is to find right
> target node to promote to.

I have the same problem with the CXL hotpage monitor so very keen to
see solutions to this (though this particular one doesn't work for
me unless A bit scanning is happening as well).

> 
> Here is a simple heuristic based approach:
>    While scanning pages of any mm we also scan toptier pages that belong
> to that mm. We get an insight on the distribution of pages that potentially
> belonging to particular toptier node and also its recent access.
> 
> Current logic walks all the toptier node, and picks the one with highest
> accesses.

Maybe talk through why this heuristic works?  What is the intuition behind it?

I can see that on basis of first touch allocation, we should get a reasonable
number of pages in the node where that CPU doing initialization is. 

Is this relying on some other mechanism to ensure that the pages being touched
are local to the CPUs touching them?

Thanks,

Jonathan


> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
> PS: There are many potential idea possible here.
> 1. we can do a quick sort on toptier nodes scan and access info
>   and maintain the list of preferred nodes/fallback nodes
>  in case of current target_node is getting filled up
> 
> 2. We can also keep the history of access/scan information from last
> scan used its decayed value to get a stable view etc etc.
> 


