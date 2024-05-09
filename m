Return-Path: <linux-kernel+bounces-174072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC158C09F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31791F22062
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475B13C3DE;
	Thu,  9 May 2024 02:55:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7B13BC35
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715223304; cv=none; b=GAyVQqRFd31zzhaJTPIgoetvwSNtEvhBs8GsJFy1N8koI1DB3Q9/TiBoPSfJRBV4Sn/La5JYRSkwzDrnzbWVkAwO35jGmbEuVKvOSMnm9ZJ4HWOlgKp/uH+4GBTOj/hLBGMOcL/KWIIUdLCXRhiOGsuLkHW82JjGk+E3K0jgLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715223304; c=relaxed/simple;
	bh=auRLcGEMSLstBD+6gugZx6gvyMdXRAmUdtAvgnFwsIQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c8auafeq770VIUAt0jiG0gNCfif8hKtF8dzptqOYblnoiETQXaYLUrPUOz+2uffss4m6fEfEeI7U0/d38sUO+PuS9BrzVQJ1Z7+qHKya8QdKHAd0+lbl7jpG0vGT1T/sd6F0rCw+uZcAVaySkv7rH0CJImhiT2TXOiuisDg90Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VZc3Z1nGHzvSW1;
	Thu,  9 May 2024 10:51:38 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AABC140414;
	Thu,  9 May 2024 10:54:59 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 10:54:58 +0800
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d5dc761e-3f66-99a3-5325-dd2f161235cf@huawei.com>
Date: Thu, 9 May 2024 10:54:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240501232458.3919593-2-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/2 7:24, Jane Chu wrote:
> For years when it comes down to kill a process due to hwpoison,
> a SIGBUS is delivered only if unmap has been successful.
> Otherwise, a SIGKILL is delivered. And the reason for that is
> to prevent the involved process from accessing the hwpoisoned
> page again.
> 
> Since then a lot has changed, a hwpoisoned page is marked and
> upon being re-accessed, the process will be killed immediately.
> So let's take out the '!unmap_success' factor and try to deliver
> SIGBUS if possible.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9e62a00b46dd..7fcf182abb96 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -519,19 +519,14 @@ void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
>   * Also when FAIL is set do a force kill because something went
>   * wrong earlier.
>   */
> -static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
> +static void kill_procs(struct list_head *to_kill, int forcekill,
>  		unsigned long pfn, int flags)
>  {
>  	struct to_kill *tk, *next;
>  
>  	list_for_each_entry_safe(tk, next, to_kill, nd) {
>  		if (forcekill) {
> -			/*
> -			 * In case something went wrong with munmapping
> -			 * make sure the process doesn't catch the
> -			 * signal and then access the memory. Just kill it.
> -			 */
> -			if (fail || tk->addr == -EFAULT) {
> +			if (tk->addr == -EFAULT) {
>  				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
>  				       pfn, tk->tsk->comm, tk->tsk->pid);
>  				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
> @@ -1666,7 +1661,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  	 */

There is comment above the forcekill saying:

    When there was a problem unmapping earlier use a more force-full
uncatchable kill to prevent any accesses to the poisoned memory.

This might need to be changed too.
Thanks.
.

>  	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL) ||
>  		    !unmap_success;
> -	kill_procs(&tokill, forcekill, !unmap_success, pfn, flags);
> +	kill_procs(&tokill, forcekill, pfn, flags);
>  
>  	return unmap_success;
>  }
> @@ -1730,7 +1725,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>  		unmap_mapping_range(mapping, start, size, 0);
>  	}
>  
> -	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
> +	kill_procs(to_kill, flags & MF_MUST_KILL, pfn, flags);
>  }
>  
>  /*
> 


