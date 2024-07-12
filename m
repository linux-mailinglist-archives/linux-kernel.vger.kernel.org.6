Return-Path: <linux-kernel+bounces-250143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C392F4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FD5B22E77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67316426;
	Fri, 12 Jul 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+TvpkiE"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4915E83
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758560; cv=none; b=WV4rYv3qQcaj97sjrRludZejmTxFWJ6zPmAvpOCTBp4aieYmzNuArh2QW3zxCw15VQ6eAazMpOGgqy3uSxggoZ3/TOQ/QGc155uWjMhtABSoyzbqY5soTe6XR/JY56cSI0uQIGcBaRtwiZ+V6QTnJmRDf7ATWIcuznL1us9P2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758560; c=relaxed/simple;
	bh=91kt2GmWN9YbpB1swLWRn5wi5i5GBzkMGgIhKOw2Kfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLd0jgziEQXdOCe9mS+0/XGSeVG8jX97VF/ZaS1LGkj4RkOwilBeQTTVvx5SGVQuuMFCAqp0mPczHbou0D2d5e/qs0g979hxdewcCL6RNin74toEvtG1qwNPR5LMwqeiURusb4YICBh1/NRV/cBkcpakaLuEAgUhKQW8nBDZNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+TvpkiE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kent.overstreet@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720758556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91kt2GmWN9YbpB1swLWRn5wi5i5GBzkMGgIhKOw2Kfg=;
	b=i+TvpkiEJn2vxXXHEwy5YpK5gI3DkJj87abjO3vdr214Fu8eMfTvHm8c4hlgZtnOa9eglb
	mBReAbnoytCvfYX66aNAU0t3C9t6W4s+gRR7lKHRc6ujF/oOYj+A5XyxKI/XoyrQDoM1pX
	8iBo+mXhrhIOd4G4ZEGKNNs+YGkcMM4=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Message-ID: <8ce42a2e-783f-4244-8e75-21dcd578adf5@linux.dev>
Date: Fri, 12 Jul 2024 12:28:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent

On 12/07/2024 12:07, Kent Overstreet wrote:
> On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
>> to error handle the return value to avoid triggering NULL pointer
>> dereference BUG.
>>
>> The issue was triggered for discussion [1],
>> Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
> I see no explanation for why this is the correct fix, and I doubt it is.
> What's the real reason for the NULL lru_list_one, and why doesn't this
> come up on other filesystems?
We can break it down into two questions (independent of each other):
1) Error handling is necessary when l (lru_list_one) is NULL here.
2) Why does marking SLAB_ACCOUNT in bcachefs cause lru_list_one
    to be NULL?

This patch only fixes the first issue, and the real cause of the
second issue still needs to be analyzed.

Thanks,
Youling.

