Return-Path: <linux-kernel+bounces-263743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C846293DA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755A3283BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08485149E06;
	Fri, 26 Jul 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcN9XJs9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cOCSwCuD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538A143C6C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722027164; cv=none; b=ceBlkdJ2aiw0iDkuggW57nSf1AJ+3jW3SboRl1xGSofUiPh+viQGmHBPMn/ojjCpauQqeVsMstthskOWx8BdZLiGESpMJK/y6WLbZuaJYmBRiyzpq5oeYTNBsv+KaI5ysZisrWJT+zzdFZQjC7DcvY8F84Rhuv9Amz+C9E8KlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722027164; c=relaxed/simple;
	bh=x1BH1nqjMrYl68KE0LLEgctLKaQiQhxQqw0BW9Zzsvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hsseVDepnGcqf100A1e8btQEpBeDWpDGCFVZtkozx8o4aEfPyQYaOIdGF5rcgSGcySRdNEH8B1Q6h/O8VJQG3iyX1GrERvaGTU5yWuxIplJvKRODa9+ZTL3zJ2RuZjJwHj5Cs38wCj99Epiv2p7BGxD/cTbt+J+kg+FvplGCcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcN9XJs9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cOCSwCuD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722027160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJjVTOzPMOKO8sf3WAcIuIk+edxQ6cfoXcc37dmsV38=;
	b=rcN9XJs9fYG1k+rNZ0j1nuJT+ODX3Yg26vWj79uJNUCNMoQASKocndv19OxFiPjM8j0naD
	2f94Tg8HpVrV/T+4dHP5FvIafGdWcpD7U3VdxxH9ZnB3qiyJ1jPBSBeB3qKGs8uFQrkVuP
	A+LWweAJYUxL2ojius1Uf377zSCAy6onD0MOyZbnIb9I4vjn9zir831yKFBaZaF6M4tgly
	ab5uumybmRVaMV7gpEtRDtDnqMYREgb+No+6h4fQUughoMytr2mTuo+c9I1tblFKiEFDgu
	T+l5mEF59a3S86GQgLLh7kN5Oujw+tldGk01VkeSM/kuEE4ZOhkAaki606h/Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722027160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJjVTOzPMOKO8sf3WAcIuIk+edxQ6cfoXcc37dmsV38=;
	b=cOCSwCuDpVIr2TFJhTo9QOqGQazUa67NFkTnED5AMxpTB1ZGtvCwJV90R3vv0MLfqAw0rF
	CK1+yAOd0bsl/6CQ==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v4: Fix ordering between vmapp and vpe locks
In-Reply-To: <20240723175203.3193882-1-maz@kernel.org>
References: <20240723175203.3193882-1-maz@kernel.org>
Date: Fri, 26 Jul 2024 22:52:40 +0200
Message-ID: <875xsrvpt3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 23 2024 at 18:52, Marc Zyngier wrote:
> @@ -3808,7 +3802,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>  	unsigned int from, cpu = nr_cpu_ids;
>  	struct cpumask *table_mask;
> -	unsigned long flags;
> +	unsigned long flags, vmapp_flags;

What's this flags business for? its_vpe_set_affinity() is called with
interrupts disabled, no?
  
>  	/*
>  	 * Changing affinity is mega expensive, so let's be as lazy as
> @@ -3822,7 +3816,14 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	 * protect us, and that we must ensure nobody samples vpe->col_idx
>  	 * during the update, hence the lock below which must also be
>  	 * taken on any vLPI handling path that evaluates vpe->col_idx.
> +	 *
> +	 * Finally, we must protect ourselves against concurrent
> +	 * updates of the mapping state on this VM should the ITS list
> +	 * be in use.
>  	 */
> +	if (its_list_map)
> +		raw_spin_lock_irqsave(&vpe->its_vm->vmapp_lock, vmapp_flags);

Confused. This changes the locking from unconditional to
conditional. What's the rationale here?

Thanks,

        tglx

