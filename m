Return-Path: <linux-kernel+bounces-560940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F814A60B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E6988215B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217151A23B1;
	Fri, 14 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bDVTCoWM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2219CD0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940558; cv=none; b=Fa1Ls7uI9mXPNIU4ZldGKk7J9zRVjKVZ+jd98tRRqvUsHGNOgrgGJxR8G79Ggc4m0o6Y6h4r3TG5Jt1r8h2P0eb1CF2gTG6zRx5LDDIxXJRADxiLfKtGncmoLFueM3peN6Yl67GxEXoruKycFK9cG+PF/j8mpTgppHt7qgkrx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940558; c=relaxed/simple;
	bh=Ra8NP3VNxIgVc6o906ZEeSTnBARf+zrkd95PLYjRF5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPQd/KPK6X0CE/mecSvsnjVpq9TvsAoO8AiawmQejnFMR9Z9tiGMyJjp65r752HSB1rJCkrlheu4GL8Xy8OEj0iQh7Mydpw4mqLebEB9VJ2wR9u4ciUKj847BwxIr+uyDTJC7r96gU5D8vfPnndUNrxgxhzQ2D/vSN/doFGZtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bDVTCoWM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ulB7sU4TrDWZ83X7O9VxHR74B0B3mMQ+ktSlUJadwxk=; b=bDVTCoWMTivCC6oZVyAvQ1D2FP
	SpZWZEZdK5KtY6u0anf13eYS8NU2lgnOw6au2ujPz3Io1y1MFdQq1aDiYKX4xdQxQ66oYN6DP0ste
	nDnCxuyY8vWvmT6UB2oZb/Rwli3tZuAjAbwYi4FIzJPKTT6gIdGYkg2JYYWc1p32PndKQaQHU20fL
	UP5yaamQIjiTttNt+fFpwG6OT/GxJuFz5vjx5xcToiPZCfih52/qxk/WtTtUQGt7lzSEzGk3up8DA
	QKoCQBttKWQ+hvJjIjkxv+g8DZa7SsFT770kYRDBQiZb4GwbPM/cW+L4eUEJ+50cwTFjKQyBj5OQA
	Uq5ywXZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt0JF-00000002rPI-1dcq;
	Fri, 14 Mar 2025 08:22:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B01E03006C0; Fri, 14 Mar 2025 09:22:23 +0100 (CET)
Date: Fri, 14 Mar 2025 09:22:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
	fbarrat@linux.ibm.com, ajd@linux.ibm.com, mahesh@linux.ibm.com,
	oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
	haren@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] powerpc: fadump: use lock guard for mutex
Message-ID: <20250314082223.GT5880@noisy.programming.kicks-ass.net>
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
 <20250314054544.1998928-4-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314054544.1998928-4-sshegde@linux.ibm.com>

On Fri, Mar 14, 2025 at 11:15:41AM +0530, Shrikanth Hegde wrote:
> use guard(mutex) for scope based resource management of mutex.
> This would make the code simpler and easier to maintain.
> 
> More details on lock guards can be found at
> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4b371c738213..5fd2c546fd8c 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1374,15 +1374,13 @@ static void fadump_free_elfcorehdr_buf(void)
>  
>  static void fadump_invalidate_release_mem(void)
>  {
> -	mutex_lock(&fadump_mutex);
> +	guard(mutex)(&fadump_mutex);
> +
>  	if (!fw_dump.dump_active) {
> -		mutex_unlock(&fadump_mutex);
>  		return;
>  	}
>  
>  	fadump_cleanup();
> -	mutex_unlock(&fadump_mutex);
> -

This will result in running the below functions with the mutex held.

>  	fadump_free_elfcorehdr_buf();
>  	fadump_release_memory(fw_dump.boot_mem_top, memblock_end_of_DRAM());
>  	fadump_free_cpu_notes_buf();


The equivalent transformation for the above code would look like:

static void fadump_invalidate_release_mem(void)
{
	scoped_guard (mutex, &fadump_mutex) {
		if (!fw_dump.dump_active)
			return;

		fadump_cleanup();
	}

	fadump_free_elfcorehdr_buf();
	...

