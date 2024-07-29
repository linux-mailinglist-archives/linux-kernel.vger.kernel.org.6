Return-Path: <linux-kernel+bounces-265520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91993F258
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C152813C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140B13B780;
	Mon, 29 Jul 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpMjoXmZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QtOQUdL1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487F28FF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248118; cv=none; b=TXNUHzA2bsZyy3m0W5oZocWB72wfuHauI8jTnT42YnJyJThjTg8IodbYnM6pQW4Za2Q+Gigze9X9T+YF4Htw48B4zrXQHOqGk5SITH1RbCIHLKrxmv1kYweyH50YlqQNUvABMmq2aiGBuXdttMyeL5wAhgMt8xrRN06v1jUuD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248118; c=relaxed/simple;
	bh=rI3ExtRhNpZtuklBz/NwIEO77N1uYemiiUfVa06bI7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHt6kAqiTxQB+yQaeWh/QVAug7G5d0xqQ+FwQz25zR5QMMIXuWCHfslgH0g6d1SVYzApXEtye4ZGtPX7FxefpQK2G0pqwqggl9qkk1whqx0TyqDjVDc5GH72TdHN5bgeqLp/WoqpUmRyEO5SIldLdnJveDj1KSY3k+JyQfeWOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpMjoXmZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QtOQUdL1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfdndD/Xx64Wa78DiIlYHBcJxUQnI0VAD9raf5njdF4=;
	b=vpMjoXmZxB1nEqSKrt3KxuiRJoeBW3nsUe4BTGr3QBLJfMy1UnxiNkVBiRfnPhsg24+tWw
	jbTxipYmOto+k0amyuEZlkF3JDOyfGzpSM7BvdXXQ67lV+QLD4ppkgIqzC9iZRjBXx5ufO
	1GdEhPQcw6kzmd5Ns1AfK488obgD6NO8oBUQ6GyMJM6yZQLbhcBTuMg0fRw47jtkK/Ht76
	r3IcPRBq4fu3faFHPq+tNIPntfQFGw1AJKBE5Wt6nxDaiykc1343kwCceB32OTlGUBnK6f
	4nLshhmsdp1obSYma0CeMXN4oyM78VXxGSLdP6d4fnGesHfKa0e/dqr06oOHQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfdndD/Xx64Wa78DiIlYHBcJxUQnI0VAD9raf5njdF4=;
	b=QtOQUdL1oE/+ojtVnJcZpu70vMRwGTwRyEwIvGRZLAv+ac4MYpogdy5CwM1O2WzQc7F/8S
	LUJmDQJYyBL6qBBw==
To: Yipeng Zou <zouyipeng@huawei.com>, maz@kernel.org, majun258@huawei.com,
 guohanjun@huawei.com, wangwudi@hisilicon.com, liaochang1@huawei.com,
 linux-kernel@vger.kernel.org
Cc: zouyipeng@huawei.com
Subject: Re: [PATCH] irqchip/mbigen: Fix mbigen node address layout
In-Reply-To: <20240720013538.3251995-1-zouyipeng@huawei.com>
References: <20240720013538.3251995-1-zouyipeng@huawei.com>
Date: Mon, 29 Jul 2024 12:15:14 +0200
Message-ID: <87r0bc8pxp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 20 2024 at 09:35, Yipeng Zou wrote:
> Mbigen chip contains several mbigen nodes, and mapped address space per
> nodes one by one.
>
>                     mbigen chip
>        |-----------------|------------|--------------|
>    mgn_node_0         mgn_node_1     ...         mgn_node_i
> |--------------|   |--------------|       |----------------------|
> [0x0000, 0x1000)   [0x1000, 0x2000)       [i*0x1000, (i+1)*0x1000)
>
> Mbigen also defined a clear register with all other mbigen nodes in
> uniform address space.
>
>                          mbigen chip
>     |-----------|--------|--------|---------------|--------|
> mgn_node_0  mgn_node_1  ...  mgn_clear_register  ...   mgn_node_i
>                             |-----------------|
>                              [0xA000, 0xB000)
>
> Everything is OK for now, when the mbigen nodes number less than 10,
> there is no conflict with clear register.
>
> Once we defined mbigen node more than 10, it's going to touch clear
> register in unexpected way.
>
> There should have a gap of 0x1000 between mgn_node9 and mgn_node10.
>
> The simplest solution is directly skip clear register when access to
> more than 10 mbigen nodes.

I see what you are trying to tell. Something like this makes it more
clear:

   The mbigen interrupt chip has its per node registers located in a
   contiguous region of page sized chunks. The code maps them into
   virtual address space as a contiguous region and determines the
   address of a node by using the node ID as index.

   This works correctly up to 10 nodes, but then fails because the
   11th's array slot is used for the MGN_CLEAR registers.

   Skip the MGN_CLEAR register space when calculating the offset for
   node IDs greater or equal ten.

Hmm?

> Fixes: a6c2f87b8820 ("irqchip/mbigen: Implement the mbigen irq chip operation functions")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 58881d313979..b600637f5cd7 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -64,6 +64,20 @@ struct mbigen_device {
>  	void __iomem		*base;
>  };
>  
> +static inline unsigned int get_mbigen_node_offset(unsigned int nid)
> +{
> +	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
> +
> +	/**

This is not a kernel doc comment. Please use '/*'

> +	 * To avoid touched clear register in unexpected way, we need to directly
> +	 * skip clear register when access to more than 10 mbigen nodes.
> +	 */

> @@ -72,7 +86,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>  	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>  	pin = hwirq % IRQS_PER_MBIGEN_NODE;
>  
> -	return pin * 4 + nid * MBIGEN_NODE_OFFSET
> +	return pin * 4 + get_mbigen_node_offset(nid)
>  			+ REG_MBIGEN_VEC_OFFSET;

Please get rid of these pointless line breaks.

Thanks,

        tglx

