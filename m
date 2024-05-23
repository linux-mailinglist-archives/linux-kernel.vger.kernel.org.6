Return-Path: <linux-kernel+bounces-186917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A58CCAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE101F21424
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9613A879;
	Thu, 23 May 2024 02:32:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5F13A27D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431523; cv=none; b=smSJ6pYuHloaMfz+CKr+olUzcXS1fjw3AZjmcLT8O0Q/9vMBJLoV+tCVDhiM0VxiK2BgibFbcf08Wva7c8S0CSCZ279FBp7QfEqGYVh9r6viMk9lDZkwbuWRe55buKNBsNtrHvQ+5KdYMe+PN0tt5ho0rJQulc2BKTcMxI7iWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431523; c=relaxed/simple;
	bh=QPiCRoMJCdqxYeyF3+8N6zkCZsq57c/9eWMOOeRn4ws=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tMf9H1xoAjjAFfoVQ8npqL8aT5cOJjN0ptvYVT0y4QKY98R1opRmLExt+oS9GUsUsguu/sOj5B8stQVG904MRAe9tlBeEm5b+qhG5BQRAmF+0evBZMl86so6SpSPYSduPxpueTXzQSUSq+SNIMEAUR+WUoYXBgZjJ/VvwvSnHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VlBtv32yrz1ysLB;
	Thu, 23 May 2024 10:28:55 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id C27F21A016C;
	Thu, 23 May 2024 10:31:57 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 10:31:57 +0800
Subject: Re: [PATCH v3 3/5] mm/memory-failure: improve memory failure
 action_result messages
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-4-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e6827d64-0f05-6874-7566-35d56782a6aa@huawei.com>
Date: Thu, 23 May 2024 10:31:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240521235429.2368017-4-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/22 7:54, Jane Chu wrote:
> Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
> Attemped to document the definition of various action names, and made a few
> adjustment to the action_result() calls.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Thanks for your patch. This really improves the code.

> ---
>  include/linux/mm.h      |  2 ++
>  include/ras/ras_event.h |  2 ++
>  mm/memory-failure.c     | 38 +++++++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..b4598c6a393a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4111,6 +4111,7 @@ enum mf_action_page_type {
>  	MF_MSG_DIFFERENT_COMPOUND,
>  	MF_MSG_HUGE,
>  	MF_MSG_FREE_HUGE,
> +	MF_MSG_GET_HWPOISON,
>  	MF_MSG_UNMAP_FAILED,
>  	MF_MSG_DIRTY_SWAPCACHE,
>  	MF_MSG_CLEAN_SWAPCACHE,
> @@ -4124,6 +4125,7 @@ enum mf_action_page_type {
>  	MF_MSG_BUDDY,
>  	MF_MSG_DAX,
>  	MF_MSG_UNSPLIT_THP,
> +	MF_MSG_ALREADY_POISONED,
>  	MF_MSG_UNKNOWN,
>  };
>  
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index c011ea236e9b..b3f6832a94fe 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -360,6 +360,7 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
>  	EM ( MF_MSG_HUGE, "huge page" )					\
>  	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
> +	EM ( MF_MSG_GET_HWPOISON, "get hwpoison page" )			\
>  	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
>  	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
>  	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
> @@ -373,6 +374,7 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_BUDDY, "free buddy page" )				\
>  	EM ( MF_MSG_DAX, "dax page" )					\
>  	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
> +	EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )		\
>  	EMe ( MF_MSG_UNKNOWN, "unknown page" )
>  
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 739311e121af..1e22d73c9329 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -879,6 +879,28 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  	return ret > 0 ? -EHWPOISON : -EFAULT;
>  }
>  
> +/*
> + * MF_IGNORED - The m-f() handler marks the page as PG_hwpoisoned'ed.
> + * But it could not do more to isolate the page from being accessed again,
> + * nor does it kill the process. This is extremely rare and one of the
> + * potential causes is that the page state has been changed due to
> + * underlying race condition. This is the most severe outcomes.
> + *
> + * MF_FAILED - The m-f() handler marks the page as PG_hwpoisoned'ed. It
> + * should have killed the process, but it can't isolate the page, due to
> + * conditions such as extra pin, unmap failure, etc. Accessing the page
> + * again will trigger another MCE and the process will be killed by the
> + * m-f() handler immediately.
> + *
> + * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed. The
> + * page is unmapped, but perhaps remains in LRU or file mapping. An attempt

Would the page remain in LRU or file mapping? IIUC, MF_DELAYED is returned from two functions:
1. me_swapcache_dirty. Page lives in swap cache and removed from LRU.
2. kvm_gmem_error_folio. Page range is unmapped. It seems page won't be in the LRU or page cache.
Or am I miss something?

> + * to access the page again will trigger page fault and the PF handler
> + * will kill the process.
> + *
> + * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
> + * The page has been completely isolated, that is, unmapped, taken out of
> + * the buddy system, or hole-punnched out of the file mapping.
> + */
>  static const char *action_name[] = {
>  	[MF_IGNORED] = "Ignored",
>  	[MF_FAILED] = "Failed",
> @@ -893,6 +915,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
>  	[MF_MSG_HUGE]			= "huge page",
>  	[MF_MSG_FREE_HUGE]		= "free huge page",
> +	[MF_MSG_GET_HWPOISON]		= "get hwpoison page",
>  	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
>  	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
>  	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
> @@ -906,6 +929,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_BUDDY]			= "free buddy page",
>  	[MF_MSG_DAX]			= "dax page",
>  	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> +	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
>  	[MF_MSG_UNKNOWN]		= "unknown page",
>  };
>  
> @@ -1013,12 +1037,13 @@ static int me_kernel(struct page_state *ps, struct page *p)
>  
>  /*
>   * Page in unknown state. Do nothing.
> + * This is a catch-all in case we fail to make sense of the page state.
>   */
>  static int me_unknown(struct page_state *ps, struct page *p)
>  {
>  	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
>  	unlock_page(p);
> -	return MF_FAILED;
> +	return MF_IGNORED;
>  }
>  
>  /*
> @@ -2055,6 +2080,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		if (flags & MF_ACTION_REQUIRED) {
>  			folio = page_folio(p);
>  			res = kill_accessing_process(current, folio_pfn(folio), flags);
> +			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> +			return res;

We might reuse the below "return res;"?

>  		}
>  		return res;

Besides from the above possible nits, this patch looks good to me.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

