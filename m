Return-Path: <linux-kernel+bounces-325942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82D975FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E691C22D00
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C161422A2;
	Thu, 12 Sep 2024 04:28:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF27126BFC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726115338; cv=none; b=gUPzzRf2zDube2EGJsanfPMS5BvsLM+Wc3NfWjemytQ4pdmUei5sJD1MVAPBJXYdwHU6+LGDgaA4vkaeQepxqd6th71cqjkLskgcXwLtnjQ96W9xYXd3uC2lX/Ids9LOsKWmzmDvNh3DbivCnEw2RkY3mduDGtkew/vy/MWpibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726115338; c=relaxed/simple;
	bh=y1pV9RyCjU6oePNmT42j1xVB7CjjogSFPqjQsxXjJOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0wuzBe1SaRZCmC/J1m+bpLsd9Qug7EwwyCYGj+9LBFN4iGKdvI5ED/1FXYjVNj1xjWWmre1pt4OJT53jg1jzeypdcbr23FssTU9i8GzOI0AwSVRGKxPCXEFTDh3ZIJg5fAMRA6if3VT/T0SHiozk3YFtk/qPyGPKcXViVKMlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86A70DA7;
	Wed, 11 Sep 2024 21:29:24 -0700 (PDT)
Received: from [10.162.41.18] (e116581.arm.com [10.162.41.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4C53F73B;
	Wed, 11 Sep 2024 21:28:53 -0700 (PDT)
Message-ID: <09efaf91-4d85-47c9-857f-94f1a9c9bce8@arm.com>
Date: Thu, 12 Sep 2024 09:58:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] tools/mm: Use calloc and check the memory allocation
 failure
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240912032457.2780-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240912032457.2780-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/12/24 08:54, Zhu Jun wrote:
> Replace malloc with calloc and add null pointer check
> in case of allocation failure.
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/mm/page_owner_sort.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
> index e1f264444342..8c78265cef67 100644
> --- a/tools/mm/page_owner_sort.c
> +++ b/tools/mm/page_owner_sort.c
> @@ -368,9 +368,10 @@ static __u64 get_ts_nsec(char *buf)
>   
>   static char *get_comm(char *buf)
>   {
> -	char *comm_str = malloc(TASK_COMM_LEN);
> +	char *comm_str = calloc(TASK_COMM_LEN, sizeof(char));
>   
> -	memset(comm_str, 0, TASK_COMM_LEN);
> +	if (!comm_str)
> +		return NULL;
>   
>   	search_pattern(&comm_pattern, comm_str, buf);
>   	errno = 0;

Hello Zhu,

It is pointless to resend if you haven't addressed the queries
raised by Andrew. He notes that the callers aren't handling a
possible NULL return, so there is no point in even checking for
a mem alloc failure. I haven't wandered in tools/mm but from a
programming PoV what Andrew says is correct...if you are returning
NULL then you also must decide what to do with that in the caller,
and so on, on which I cannot comment :)


