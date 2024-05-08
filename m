Return-Path: <linux-kernel+bounces-172852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55D8BF781
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486E7B23F44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A722E41C;
	Wed,  8 May 2024 07:48:06 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C63A1C2
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154486; cv=none; b=RtuLq6z1El/5GJ6Ii1HugSNo5rnaUTMXnQKoysZ1c/Q8g17THSy8eWxUU8Fo7BcQJydyj02M7H28soUvCB44ulArmpDAOxuQ8L4wG/aMuviGiCmm63iYlG3RuUyokLhqdkMcPZfgjAlKDjz2XzMpsMrtBpjSGXAABb94r3l3Ozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154486; c=relaxed/simple;
	bh=8lXQB+2Y1fPOXJPGP2yr2ygKE7iD4jiNn3e2udp3iGc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dBYx4P/j0VHYoTyPTh79gwEVqsIIirkTGWzs0/4sEEvLOICEmiE3HBtvGfoxXNASnau1WpT82AyQlZjPCP5m8zP2O8EmGsxGOo1LEurw662tIsvAhdw0M5Xq+i9Q0kdv1UwoFnJhh3lhhNdZa6H3YGawCIyOrksGAjF/YJdnKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VZ6ch6wsyzNwRV;
	Wed,  8 May 2024 15:45:08 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9119F1400FD;
	Wed,  8 May 2024 15:47:55 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 15:47:55 +0800
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1bc8c5ff-1452-11d3-edee-9f45a87015a9@huawei.com>
Date: Wed, 8 May 2024 15:47:54 +0800
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Since @fail is removed, above comment should be removed too.
Thanks.
.


