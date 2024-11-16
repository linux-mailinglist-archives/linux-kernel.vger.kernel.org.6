Return-Path: <linux-kernel+bounces-411539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296739CFBB3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E333A284A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8FBA2D;
	Sat, 16 Nov 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eqv7VY2h"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAE944E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717191; cv=none; b=Kg0tmDboMrOE3zdF4Kw8o1J0C9KjnRVpOqDk4sZ8kgIDRMnbcGjJWh2fyPhb7W2mAQ7KxWwTCwm8FHs51ndaj+mmif0RuPrUXhYEkSSaG0vrqhIWKQGoQ6kyDRk2mgKgfzAv/onpm7wQJKJoteMvC6Pmp0gtnxvSaemzjOqpc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717191; c=relaxed/simple;
	bh=F6fU7KlLSzUs1gveo2BCh7OFm372YDhjsxyCVNn+gQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD/kM1tYLv8Bfl8lM4kk43Hzbp6+9GhXZe57OcRlT4WjVJvZRasazixd9uGCT9QXWuVG3kKdbHFFUUD6zo0NeN0uND8vBczhXpVEgGIldEEEE1g5QEFlrIbcSv19E4/xFgd0fIl3dC0B5O5t2sh8AXHZhwJGZXx/tqXQHLeUQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eqv7VY2h; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb9476ac-74da-4a58-b997-14b25d3ec2a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731717186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6fU7KlLSzUs1gveo2BCh7OFm372YDhjsxyCVNn+gQw=;
	b=eqv7VY2hqwalOemrPrMnqrHOsLRx0dzdCNIWgJGlTfxdGhEbUIFRU6taalMso/HIkZsKaz
	JflZEFhlDgBvvNXxsd9DkJXRYCutgMfxGt8XtWvG+D9JCmraW74oi8BkSdzS6TAoOPwbCu
	5Pc6mO51yuHeWL2Qd6DTdYVrLTEVAwU=
Date: Fri, 15 Nov 2024 16:32:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ARC: bpf: Correct conditional check in 'check_jmp_32'
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: vadim.fedorenko@linux.dev, tarang.raval@siliconsignals.io,
 Vineet Gupta <vgupta@kernel.org>, bpf@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
References: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
 <920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org>
 <f5f49eee8979985439408e7bd6fbd1534e91a115@vahedi.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <f5f49eee8979985439408e7bd6fbd1534e91a115@vahedi.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/15/24 07:55, Shahab Vahedi wrote:
> Hi Vineet,
>
> Could you pick up this patch [1] in your "next"?
>
> Thanks,
> Shahab
>
> [1]
> https://lore.kernel.org/bpf/920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org/T/#t

Done. Given We are in the last week this all will land in 6.13 cycle.

-Vineet

