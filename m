Return-Path: <linux-kernel+bounces-168905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D758BBF8A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5E71C20AC8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF6763A5;
	Sun,  5 May 2024 07:02:56 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEA33EA
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714892576; cv=none; b=A/qIpgcTSXLZMtz9j8dEqQoQt0BMi1+G3j6ralwWzBJfpDSqFsQAIx14rrFVjXE8bStDZClG7VhBOdY+LHlE314ceU4Z51pKTV5AN+pp4bQbnYUkiMFbWcgxyxOf/rB9w9dPRguXjOJR/oEQHsCCTfZjG/L136FzTfrSFvyzLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714892576; c=relaxed/simple;
	bh=K7DwWR1hViRkrpWSUHR20Q62lrruKvXub2PhHgeBhkU=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oIrIo8d8Iy4PRONjEpTooWZNOXu+ZJ6oOiAqiELGtSmTQXfcmWNJDnOgX71x/G5O0BkphhO7zOttCh07/c6Ds+W9OBV/V+s25DFDkgmkcNrzuIi0zZLVapdFCoMVr0NeZxCLuPC9yF8/p4kY/YOa+YhqoIwESJ+sikTjgwj7I8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VXFlN49lPz1RBvN;
	Sun,  5 May 2024 14:59:28 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 453F4140384;
	Sun,  5 May 2024 15:02:44 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 15:02:43 +0800
Subject: Re: [PATCH 2/3] mm/madvise: Add MF_ACTION_REQUIRED to
 madvise(MADV_HWPOISON)
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-3-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0c7dbf7d-dcb6-f9f2-4a2a-9700ea465a47@huawei.com>
Date: Sun, 5 May 2024 15:02:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240501232458.3919593-3-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/2 7:24, Jane Chu wrote:
> The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
> a synchrous way in a sense, the injector is also a process under
> test, and should it have the poisoned page mapped in its address
> space, it should legitimately get killed as much as in a real UE
> situation.

Will it be better to add a method to set MF_ACTION_REQUIRED explicitly when inject soft hwpoison?
Thanks.
.

> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 1a073fcc4c0c..eaeae5252c02 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1127,7 +1127,7 @@ static int madvise_inject_error(int behavior,
>  		} else {
>  			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>  				 pfn, start);
> -			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
> +			ret = memory_failure(pfn, MF_ACTION_REQUIRED | MF_COUNT_INCREASED | MF_SW_SIMULATED);
>  			if (ret == -EOPNOTSUPP)
>  				ret = 0;
>  		}
> 


