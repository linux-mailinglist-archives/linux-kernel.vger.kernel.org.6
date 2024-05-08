Return-Path: <linux-kernel+bounces-173065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7A68BFAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7AF286085
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365E79B9C;
	Wed,  8 May 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AaMZ6JR6"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D34BA27
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164163; cv=none; b=YlxR7U/EKHXpIiXPz8s7SpIlBqpzg6Tsvprhl2KEwTOFgI8R/yNUH+TVQBPV1knVqnJAfupj5ylrsx9l+jLM7iGz7jcJ87BmS4mVHuBmmrPBiSxSdGQDQgmhvkbpuqZATNqdW7YG3GAHIhNy42VmeH1maN0o1uYbgAypQePZhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164163; c=relaxed/simple;
	bh=6hxnY/6kr68Jv4coWbRBirLa5oPBci7/ve/IiJK6WAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHb7WwmOodRmmwx3wBneWEcDLXXzHyN8MLH2S0+guuiWTA/Dx49iiBnY4YsX2kYGvuuUuowsptiXBuQyALaLQzDYENrxCBHm8R0F1jxhe763OCFBU1QaHaJs/0WbwUy3BelscvjXrfE8pA2Pv0raR+Q4VRRvFYBBBIDwzCnKWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AaMZ6JR6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03536b50-d5bb-41f1-8916-2adff05435f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715164159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVwZL+A9cHtGAyQ2u3Cbb3pzinsuz96Kz1POWPk+6nU=;
	b=AaMZ6JR6QzMY6s/Bt6hrM8uEqE44J3xRmB1GhPM6NmMheRatVvMWySpjMQBmzeAyNsZb1+
	yhWGn670cM8EmVHzRM+ED5xzASOxPPhKOEywRLx3jbAcx8w8Y49PNfE7vnE4EO4Ls+KBLV
	wOBK1+0DlR28YtXEK4yqPeZyl12it18=
Date: Wed, 8 May 2024 18:28:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] mm/ksm: fix some accounting problems
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roesch <shr@devkernel.io>,
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
 <9a1fdac7-8bbd-48f4-bf31-86916ddcf4ed@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <9a1fdac7-8bbd-48f4-bf31-86916ddcf4ed@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/8 18:24, David Hildenbrand wrote:
> On 08.05.24 11:55, Chengming Zhou wrote:
>> We encounter some abnormal ksm_pages_scanned and ksm_zero_pages during
>> some random tests.
>>
>> 1. ksm_pages_scanned unchanged even ksmd scanning has progress.
>> 2. ksm_zero_pages maybe -1 in some rare cases.
>>
>> The first two patches fix these problems and the last two patches 
> 
> Can you find+add "Fixes:" tags for these? They look sane after having a quick peek.
> 

Right, will add "Fixes:" tags.

Thanks.

