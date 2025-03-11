Return-Path: <linux-kernel+bounces-556415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA2A5C77B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644DA189B8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195125EFA4;
	Tue, 11 Mar 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Ni+W+Ssk"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CD25DD0A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707038; cv=none; b=swR7tNh1TWaEvs1NaNTChy81XQF5UuMsrWYRhHNFNXQw/QsG2OB9iF+ogefPOhPgfpCiiWKFSVrM0oLNR8G6jam/VoA6NJ2zzBCMlqAjr2P/m/dd8711Gb7VIBUXvopIB2KWOfCxQgoyOvw/nwNkYVDVkcVzjYdUCi4LFfhUnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707038; c=relaxed/simple;
	bh=f8WXdNINpbVnO+wl6UpJ+DrRRinxZU2pLsjZyk1/OMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai8WEZUpTtlwf/C8RjDrS9gPpR5/BD1lpvj7VLpwe8HMhuDt75SoJVjksRu3YS43lh8VMgJwkZm7L9/Zm8a2+N8qH9/0c1tN4PRVaMDa0N5u5MneQLrurlf9tHnI3LQjfGFFu1F4Y2ZqP2/6/nPJjkS+iRHcx9voyAozxGUk1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Ni+W+Ssk; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0a159ded2so598973985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741707034; x=1742311834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tj/ZAgYAWLVaIefJKjFIbhLbjv4Cos+iOgFdwRh3dU=;
        b=Ni+W+Sskbe5OzpQs8ep1GR5vNz+u13DhnuuUU0WYXQYJthBaCBozzMmxquhHB0Xc3f
         ihpVHAQ0QKzbmJr3I3Xwa2LlLrLVsBOVM3V20+6r9L90Erju3fK2QATj+bEYe6Sx2+NH
         +AiDf3EOkltq8jcXIoLCh9GmNiLOTOOCdQmRCXKi4uU8U/XHqDOYSZN9j+VI6kBFtKd5
         l64EeCLSpGdyxGkHXMZ7p7dUcCW5c2ftVKMZnwdx4ibVIqBRhOE+n1EgKvtU80OSPZ86
         DRLvvjdrSHXYxiKmOBil+2t5h/t8Cmzy03GFMIJbNwRQpS/svEG6z8kKOhX1lgNp8y5B
         ppeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707034; x=1742311834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tj/ZAgYAWLVaIefJKjFIbhLbjv4Cos+iOgFdwRh3dU=;
        b=V8yXbo09oXhxYarCaZc4Re2dYVLdfBAODMJVHDd1vKFWLqTf5N6nLGUP7Is9+KdMcN
         sghaWHamgeshf/y7yIU7SX3ZrJZsuXCY288Y23TGp49ypSinvENo45ogWahfM2Mm1KAe
         D7+b3o2NwkK9MiOAuhXNK5TIB6uLpdB/omQdVagu8Hg5TY1tSUmul2/uzQeRTp7b6l+2
         tltigFVhn+MjyvQxB16ZdaiBCo/8IK8wjoq4ftWUg3YYRur+9jXsaR8J0H1+6lebEVMp
         XUjrD5qetPdDksN4DlgKNoRpOO74+O9wvg5ocJlN/0n6oLwuZ9cElvF6xuAUX2yEYhcK
         wwNw==
X-Forwarded-Encrypted: i=1; AJvYcCXcHUZMO3V7jc8S4vJ3jsVBJsdpvweiJMCg0M5D57f/KHkKA1NzRCHOpy5gIZm88XDppDyXTIMtf86rivU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0KpiJj8CzTU9CD5KbYUi7/maqMjArc4YPilwYhFo+IP5iQUr
	tpdF1+NV6WX1Ll9NzMhBnBsq7z+BMZ4m3Gu8x157/+Uum/GqXHXsuy3iSmm4yyk=
X-Gm-Gg: ASbGnct7dRYNv0ba6KVcFVOK2dXFEtixAVrmAweDf4SaLfmlQOVt8s7UgWiCjbdmDOc
	4oamp66nQmD8aDh40aeNah1gbArjDIPe/ZRFY1bBF2AlLkVkZwwEl97MDfxRCF5JKOmnblxApaH
	9SYsFDyn4iB9EwNm+jkLa/rtOIy33TUTzgeLo3LFKL7jhe089YYsnTpjG3QP2Dty1e+vGE0QWFA
	3AN2DSbchF1nGwQc4tpf9S9GEouqMxgnPk9+wjfqSKFi5IAIQ1qd/3P7ScBMChPsnQ3ndIj98Mv
	BbbYPQHECyrm53gcjoKP6NcILQdGsNTvdycBoOQtIeo=
X-Google-Smtp-Source: AGHT+IENmNilEy0vcw7hrxou0wF3L/Z9Vv4f8uUpsENzYSWwJpybBI0+STVaLXgcmHtw+muodFyH0Q==
X-Received: by 2002:a05:620a:618e:b0:7c5:4c49:76a5 with SMTP id af79cd13be357-7c54c4981admr1332276185a.12.1741707033689;
        Tue, 11 Mar 2025 08:30:33 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c553c14c37sm351315585a.112.2025.03.11.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:30:33 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:30:32 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <20250311153032.GB1211411@cmpxchg.org>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310230934.2913113-1-shakeel.butt@linux.dev>

On Mon, Mar 10, 2025 at 04:09:34PM -0700, Shakeel Butt wrote:
> Currently on cpu hotplug teardown, only memcg stock is drained but we
> need to drain the obj stock as well otherwise we will miss the stats
> accumulated on the target cpu as well as the nr_bytes cached. The stats
> include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
> addition we are leaking reference to struct obj_cgroup object.
> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org>

Wow, that's old. Good catch.

> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4de6acb9b8ec..59dcaf6a3519 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  {
>  	struct memcg_stock_pcp *stock;
> +	struct obj_cgroup *old;
> +	unsigned long flags;
>  
>  	stock = &per_cpu(memcg_stock, cpu);
> +
> +	/* drain_obj_stock requires stock_lock */
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	old = drain_obj_stock(stock);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +
>  	drain_stock(stock);
> +	obj_cgroup_put(old);

It might be better to call drain_local_stock() directly instead. That
would prevent a bug of this type to reoccur in the future.

