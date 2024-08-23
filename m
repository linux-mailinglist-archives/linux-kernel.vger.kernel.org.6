Return-Path: <linux-kernel+bounces-298283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80D95C525
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC12B1F2548B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5886745F4;
	Fri, 23 Aug 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KsCOz7uY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2B6F2FD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393265; cv=none; b=VirQS2CXkW6EU8bjQ9q+orFezxsW/ym2aWyoeVHGbF5BtFhMh5GQ8V8HOBt7q+RFnTFdwGxVAiW2sjaziS1cXAb6C3cg/FD4K0+fvX87nr7p8D+dh4vBy2pYYI85sq7BGYiVKSAKS3Fe1pNPHs60BE1DJJrt3Pi9tb3sg5EBAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393265; c=relaxed/simple;
	bh=wxNZSekHTKoSKE+CbfLd5jS+7F+qS6R1Z4ygAcr0oR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFShpxLYHhu0EdVXzRNwAW3tDva7s7c8lF1Qxy+z19q/p/clKvOe3qL+9fa1GZDOZxJbWdjefYb66zWJGbmo80NRNzGzmu0AWh5Y0Hq9y1xc161iAsk7B+YOFGjew5aN4T3aqr/rI5+iTFmlGtrgvaxZv4WMKnpQb+9j4nTILZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KsCOz7uY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f9f50184-364c-4082-bf19-ea953c3c1429@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724393260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxNZSekHTKoSKE+CbfLd5jS+7F+qS6R1Z4ygAcr0oR8=;
	b=KsCOz7uYHX/RXqmZv47etZyYwQS3+H8H6rjWyuQq90fUduAefe2fqXchNONmPpzcnfyxM/
	/5bshXnC43fDi/NNLbMUGqWX4rzVRujrA6rRVFlayaXp8TdqFx+37DbgVxt5xiUPgZbC1Q
	/tS5W1XLNsNiYwoc+2dWLzpCdcG6P7k=
Date: Fri, 23 Aug 2024 14:07:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bcachefs: Remove the handling of bch2_trans_iter_exit()
 in __bch2_bkey_get_iter()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240823031955.202795-1-youling.tang@linux.dev>
 <f2uohiy7zaaiv33r7xhofaprv6tk5mumvzzf7plvagdtavrini@3orfgcehid7q>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <f2uohiy7zaaiv33r7xhofaprv6tk5mumvzzf7plvagdtavrini@3orfgcehid7q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/08/2024 11:55, Kent Overstreet wrote:
> On Fri, Aug 23, 2024 at 11:19:55AM GMT, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> - Reduces bkey_err() calls.
>> - Avoid redundant calls to bch2_trans_iter_exit() in some functions.
> no, a function that returns an error should clean up after itself
Yes, functions should self-clean when they fail.

However, there are repeated calls to bch2_trans_iter_exit in
some functions, take lookup_inode() as an example,

When bkey_err(k) returns a non-zero, call bch2_trans_iter_exit()
once in bch2_bkey_get_iter(). It is then called again in
lookup_inode() via 'goto err'. (We can correct it by simply changing
it to 'return ret', but there are many similar cases.)

Thanks,
Youling.

