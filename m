Return-Path: <linux-kernel+bounces-321017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBC97135F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53571F23C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC311B4C40;
	Mon,  9 Sep 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oxYD5GmP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Povi5PGE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C91B1512
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873725; cv=none; b=JZWWslTSPX0kVWIXA6cN1OSzNHmIMRMGRjy7lHJnCzDQ7BBNzISzjqefvY4Ov+pu27ExZZhzewBor0bBdVh99SstEzaeoGlWCiODocwecXg72++KT4tVKx4p6S881AI1SdBUMyvEryFlywSdiQfuBJvOIsv6sI8ioaNgm1gUmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873725; c=relaxed/simple;
	bh=/dmQvPI2ZTgPKY0yrHTKpjnXXRnQYTHHd+YPlkMVssc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AXYtVma1hOS5PmhxWuTg7FDP9WsF8tZ3Y9AyQ9StFXbDVOr53fCf6+uHINkYIcIhoZ9QPQn25IkkWaiQfc5TF9sobjKQ7wJf6sJSByPqC44Q0GKUO4CKzWFxIzL1y9ykNlaux9t56/hCnavcfJDPGiNABjlkMyEmlFNDBNe8NEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oxYD5GmP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Povi5PGE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725873721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NA6Ndo7sOGw3CS5f1zFB5J3/TQ66H2kKECgrywYFOtg=;
	b=oxYD5GmPbeTZmqxpt5XQfczHv47Vv+itgOCsi7WMvJxF5K3ZBwYZQ6pVG9TIT9aGFUqpK9
	4TfhMG0G7uf7cEXg1QKBeLEoMB32CR9UeHvSb1HL8PKQWsTuURxH2HNWMfrf5q0FrAmWPJ
	JVYTGLVw93OrQ+BWXhwK2Cz78rR/H89BMUquKJuU4MDAVqw9dXb569EDU+0UAgYMuYQxvw
	64UFkzrsFSZSLFoSnekiQbd2Q/jQJ0kuPAiHA2fAtQ+im2jsK51WzQD4bcg5jUcodZiaBU
	k4YThNIrc6BFZFnpppX1lGoNPK+S1+mAPWXb1E9DxNc81fQD3odrlXPNQi3IMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725873721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NA6Ndo7sOGw3CS5f1zFB5J3/TQ66H2kKECgrywYFOtg=;
	b=Povi5PGEtJIsJa+yEF4wdIIQAqfZUV5WF6hLdAAHP5bwPPNyD80GNk6zWb8mb8z61xrr2a
	fNojlKD4eXUonBDQ==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
In-Reply-To: <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com>
Date: Mon, 09 Sep 2024 11:22:01 +0200
Message-ID: <87ed5tchc6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 05 2024 at 11:45, Leizhen wrote:
> On 2024/9/5 11:11, Leizhen (ThunderTown) wrote:
>   Seems to need to add an additional patch as follows to be foolproof.
> I'll prepare it.
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index e175cc74f7b7899..d3f8cc7dc1c9291 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -245,6 +245,21 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>
>         raw_spin_lock(&pool_lock);
>         obj = __alloc_object(&obj_pool);
> +       if (!obj) {
> +               raw_spin_unlock(&pool_lock);
> +               obj = kmem_cache_zalloc(obj_cache, __GFP_HIGH | GFP_NOWAIT);
> +               if (!obj)
> +                       return NULL;
> +
> +               raw_spin_lock(&pool_lock);
> +               debug_objects_allocated++;
> +
> +               /*
> +                * It can be understood that obj is allocated immediately after
> +                * being added to obj_pool.
> +                */
> +               obj_pool_used++;
> +       }
>         if (obj) {
>                 int cnt = 0;

No. That fails on RT. See debug_object_fill_pool().

Thanks,

        tglx

