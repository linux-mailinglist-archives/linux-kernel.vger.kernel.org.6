Return-Path: <linux-kernel+bounces-532812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F021FA4527E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9AC176CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD019D06B;
	Wed, 26 Feb 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vuy8I0AX"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CFE56A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535039; cv=none; b=IfRzlDbEv6nS/Po/pF1tu8h34x4joL+dfGxWNTBu/AlUYVjPbn0YoikjuqoWYI0ukK0gzJmKMWHxg9PRxAqkNtLArwC5aic0nuIWT7DhM1nbkJFiyIbtdAF4QyDS1i1H6S2dAbBj1s4gOaMto2rKcBRweKNUdEFb+a5wZRy3zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535039; c=relaxed/simple;
	bh=2AjpPUgwyW35ZlY25/RBMK6h76d3ORQR2twl+cHmmAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5dVVEbq2WRDyy2bk5SQp0DKnucbCZlxmRma2x8z2QR6LKXXiuK3f6bIXWaoMqfZ1P7GMEEJtzqzijbSZ/AKLZPf+kvZafcXaa0MJpPBXsvAGpvUD4cBTlPDwVSQPD6yA6Fc+qVF846ixEGhaqT9lcTFhy6bO5/9W2KJNSc+2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vuy8I0AX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3db2c2fd-5125-4664-83d0-a0706ef2050f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740535034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AjpPUgwyW35ZlY25/RBMK6h76d3ORQR2twl+cHmmAE=;
	b=vuy8I0AX2kkd1NjVZbGg37cUhDQeJMeKe5nEoM65o5UfhKmbIqzYuU9pBMUWsU4YmLjjI2
	gjcRzkpsMyaCXuTGcI8mbvFGA+9gy8a/YMGgFP3LeKxcEvr+aB1+fNGWNe/JLmacQq47RQ
	FKRd9rCECzhjSHl8Z1zYg+AfqpPSUeM=
Date: Wed, 26 Feb 2025 09:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/4] stmmac: loongson: Remove surplus loop
To: Philipp Stanner <pstanner@redhat.com>, Philipp Stanner
 <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-4-phasta@kernel.org>
 <437d4fad-6cd4-4f90-a1bb-07193d015cad@linux.dev>
 <7df6e1846ed6932c789a913c6a10aa8df5e26519.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <7df6e1846ed6932c789a913c6a10aa8df5e26519.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/25/25 5:15 PM, Philipp Stanner 写道:
> On Tue, 2025-02-25 at 17:06 +0800, Yanteng Si wrote:
>> 在 2/24/25 9:53 PM, Philipp Stanner 写道:
>>> loongson_dwmac_probe() contains a loop which doesn't have an
>>> effect,
>>> because it tries to call pcim_iomap_regions() with the same
>>> parameters
>>> several times. The break statement at the loop's end furthermore
>>> ensures
>>> that the loop only runs once anyways.
>>>
>>> Remove the surplus loop.
>>>
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> It seems that the fix-tag has been forgotten, next two patches as
>> well.
> Not forgotten, I just think that patches 2-4 are code improvements, not
> bug fixes.
>
> The issue in patch 1 would cause actual misbehavior (a useless debug
> information print in case of a resource collision), whereas 2-4 are
> just ugly code, but not actual bugs: the loop always just runs once;
> and unmapping the PCI resources manually is valid, but obviously
> unnecessary.
>
> Agreed?

You bet!


Thanks,

Yanteng

>

