Return-Path: <linux-kernel+bounces-309649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BAA966E52
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F58AB22242
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F81B970;
	Sat, 31 Aug 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AunijzZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072BF2C9D
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065944; cv=none; b=ldLsCJScEDXg2W9nEDSJppmw4xrWFyEN2Syx7P2vnEgnzSz9obA5xAkn3N2MHVA1ZZRDzhWtBtPZP7KbL8lqn5T/YpncZsSFmvMRZTN/T0m3Ggcc+8V8wcCFWjeL5Lr6g+JKyEpayYei+jbNRwrDe9LxFkJLmsSp+SRoUUtrTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065944; c=relaxed/simple;
	bh=HjXW+A1M0PT2CqqxncN2ISGNKCnPAFywGMSvYvNaWt4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tkjTLQQuUJZqs3J8EBHx09JhRleudpC+2xgN51qh2fGhIZ8Lyys8UG1OyY4sfv3KYEOQXcFWbIoqQmFrHuoAl7JE0SdNvzCy97PooSAb5j5x8cLFWP1+dvXxVOiab868LZXO0/Nvjr8tFIwDOH1pGsTAdyo4jKw4OlNE3PY+Xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AunijzZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65657C4CEC2;
	Sat, 31 Aug 2024 00:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725065943;
	bh=HjXW+A1M0PT2CqqxncN2ISGNKCnPAFywGMSvYvNaWt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AunijzZHoDfDlJwGqw2S9WHH1G6SZly0dIowtzTlTpRMwL3yNfAexaEDeoV2GHXSZ
	 gnrIErqerX3udeXvhFVY9yNHAa9wxzsFObqRIMtHb4UtjVvHsIbwGJFdzu1BjD0mf3
	 XfrfXhLt/JeA1HxVzUxviBThgJQ+9ik5sAKnrzM8=
Date: Fri, 30 Aug 2024 17:59:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/mm: Use calloc and check the memory allocation
 failure
Message-Id: <20240830175902.2cbdb98ed746001896f57fe5@linux-foundation.org>
In-Reply-To: <20240829092144.5851-1-zhujun2@cmss.chinamobile.com>
References: <20240829092144.5851-1-zhujun2@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 02:21:44 -0700 Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> Replace malloc with calloc and add null pointer check
> in case of allocation failure.
> 
> ...
>
> --- a/tools/mm/page_owner_sort.c
> +++ b/tools/mm/page_owner_sort.c
> @@ -368,9 +368,10 @@ static __u64 get_ts_nsec(char *buf)
>  
>  static char *get_comm(char *buf)
>  {
> -	char *comm_str = malloc(TASK_COMM_LEN);
> +	char *comm_str = calloc(TASK_COMM_LEN, sizeof(char));
>  
> -	memset(comm_str, 0, TASK_COMM_LEN);
> +	if (!comm_str)
> +		return NULL;

It seems rather pointless doing this when the caller aren't coded to
handle the NULL return.

And really, for these little userspace tools it's OK for us to just
assume that malloc() alway succeeds, isn't it?


