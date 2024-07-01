Return-Path: <linux-kernel+bounces-235531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD56291D645
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766241F21436
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA55C144;
	Mon,  1 Jul 2024 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ei9mi7B0"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070B79FE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802166; cv=none; b=ETOPsPtxmir4KnqajAp4IpGsjLHsje/oZKBwPPzikSlfGIti8E09QqMt87mz5Q8t5OS0Kly7yM6aG6AqOtFTyTm4eCBTEla6oglCb/YuDDxHsRvgjgwpIfd0tWKpGZlG8TR0xqCLV05g0vQkSOFg2+HtbQHn8SGE0AZI0SG+OoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802166; c=relaxed/simple;
	bh=keqjdE0I+X6l14hJzH5UBvrkJI7iwlUuj7mnK9jbMJI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fuVQshgxkBojLNyx5d16MnKZe1LlH6DU6w7AYu5DMfUxBzwGyYT+nqm20lc2/E3BTV8rCTYpjcG5gnWYsS16MaTkapZif3GN9MCG/61sULw54dGtcPiFYBVkE2t5dRVf7q5DZ8xpZ533SRf5PSB/6XzdGca1vyZndUocgbb0HOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ei9mi7B0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719802159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mFxjC1U9/7JygpJdsg86O8Ayb0TyOCDXKOYMsrvCw0=;
	b=Ei9mi7B0/RVD3/lgBL1ONKhW0K810nMsBJltQ6rAP5LVFw8dP2N3FIgV34ysxAFQj3yIMb
	jQhuD/i0IcIjuJNuCFFBmLJX/ubb1qTzi5KIZs5Ew9usL2WCH1/AJmMResu6YJzlDbvinQ
	zySfDA08FINQDopG7cM78XBatmiw8S8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <8163966f-d31d-425c-97cb-3d18ab28ac1f@linux.dev>
Date: Mon, 1 Jul 2024 10:49:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240628005523.GC15925@google.com> <20240628010812.GD15925@google.com>
 <caf4b05d-6adf-4976-9961-fa30d3a9969c@linux.dev>
 <20240701013731.GA3232210@google.com>
 <4f2a5cf1-3132-4bc6-965f-8dc5a8ffc05a@linux.dev>
In-Reply-To: <4f2a5cf1-3132-4bc6-965f-8dc5a8ffc05a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/1 10:20, Chengming Zhou wrote:
> On 2024/7/1 09:37, Sergey Senozhatsky wrote:
>> On (24/06/28 11:19), Chengming Zhou wrote:
>>> Andrew, could you please help to change the subject as Sergey asked?
>>> Sorry, I should have noted these details in the changelog when I wrote
>>> this subject.
>>
>> Chengming, can I ask you to resend these patches with a proper commit
>> message?
> 
> Of course, will update and send later.

I just pulled mm/mm-unstable and ready to update, but find Andrew has 
already helped to change the subject and commit message as below, which
is great enough! Thanks!

commit 84d0abc5905bbdf29dc7ff8083d21145d78a3ffe
Author: Chengming Zhou <chengming.zhou@linux.dev>
Date:   Thu Jun 27 15:59:58 2024 +0800

     mm/zsmalloc: clarify class per-fullness zspage counts

     We always use insert_zspage() and remove_zspage() to update zspage's
     fullness location, which will account correctly.

     But this special async free path use "splice" instead of 
remove_zspage(),
     so the per-fullness zspage count for ZS_INUSE_RATIO_0 won't decrease.

     Clean things up by decreasing when iterate over the zspage free list.

     This doesn't actually fix anything.  ZS_INUSE_RATIO_0 is just a
     "placeholder" which is never used anywhere.

     Link: 
https://lkml.kernel.org/r/20240627075959.611783-1-chengming.zhou@linux.dev
     Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
     Cc: Minchan Kim <minchan@kernel.org>
     Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

