Return-Path: <linux-kernel+bounces-540485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367CA4B13C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBBD3B2D56
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CE1DF25D;
	Sun,  2 Mar 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tf3QsNhE"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374021B6CFE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740915640; cv=none; b=jOsOsjhKbK50Xa2D958EpTvxGtdR+kVNo6t80IZsM/zNzjjaVTDbFUVudx60ZR3GTP38xUBcxmG0nbSRdrMQeIbwWdsurSMHHYHuXHaNhpqAQ4kPokwizM0rU1BPQUzePHuA+LEkZ67RaxQlcUTxFV+PEDMjKl/nRqEUbMDiPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740915640; c=relaxed/simple;
	bh=ibJpnIMBMfwg+wEixIQ9dxHR74HBmtgjULFkQgeW35E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MCDKFE2ILSXm7B8scTBEVThxVShRP2tBFTxQqzyjGXZfTShxZ/j+zbvKg95qEyYrBYNLutXKi1e8Ba/GDgq3L616sHCui64fDfabPxuOSY1zS5Or0OGYBOtdW6qcNi/3DnfDxVj9IiCbXpRTydj0k9NzJ/PHcVqAKNedxfh3FlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tf3QsNhE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740915630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=koGqmzgxJVr+i3JPI4Z8o/wAMh9GbzaZsxUAoedZwe0=;
	b=tf3QsNhEJxFXSLuxp70QnWiRq6yh1U1ASF+RlVj1S6mRnM7tCLnLrogfBusKSCKzIvQARX
	67apWnDIijARy09gfyY9L21UIacEz9plULsiytDUpvHfhknuii1Tn3BamsZnoKhr7i3LEt
	p7dqKcsPjLF59RfbqKSGTnfZuz11P2w=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] crypto: bcm - set memory to zero only once
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <Z8P3DdA9d4nqTJVv@gondor.apana.org.au>
Date: Sun, 2 Mar 2025 12:40:17 +0100
Cc: "David S. Miller" <davem@davemloft.net>,
 Chen Ridong <chenridong@huawei.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <91117BEC-B6FC-4FC7-9073-10FAAC13E2FF@linux.dev>
References: <20250219111254.2654-2-thorsten.blum@linux.dev>
 <Z8P3DdA9d4nqTJVv@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On 2. Mar 2025, at 07:13, Herbert Xu wrote:
> On Wed, Feb 19, 2025 at 12:12:53PM +0100, Thorsten Blum wrote:
>> Use kmalloc_array() instead of kcalloc() because sg_init_table() already
>> sets the memory to zero. This avoids zeroing the memory twice.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> drivers/crypto/bcm/cipher.c | 24 ++++++++++++------------
>> 1 file changed, 12 insertions(+), 12 deletions(-)
> 
> This patch has already been applied.  Please check whether there
> is any discrepancy between the applied version and this resend.

My bad, I must have missed it in -next. The patches are identical.

Thanks,
Thorsten


