Return-Path: <linux-kernel+bounces-406976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34249C66EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2121F2583C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3A64A8F;
	Wed, 13 Nov 2024 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWn0XDky"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4218654
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462955; cv=none; b=C76vHxde0oHsbRLUoRW0wHPfmxWdSgxmFlfyw5Ci9oct/Iwn0EErQ6U3RXR7WaO18oQmEvyDhUov8JdE8oCpdh1tmKZ2qq2cO0dcfH6l2MxRBvc4bm27qNNGH+bIWd64wVYfo7vNm3GaAY6n5Woh/+/zzReD29LA9pAq1ixZzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462955; c=relaxed/simple;
	bh=umYQD1NTC+uOYbwAJrPfesP8Hfu/vo+Zg5Im/v1Msjs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oKkmUoxQwnDazsXu7ftNSUcV3/4MLWGysr4GchVlg8j65OBIfNEMzYFYPCOkVP0UQx6XG6iPmTnM/Gbf6oo93qr3M3hUmFUfr+Y6hv7UrsHESdCwTlpRzYjDaCxTCv2SJClMMK6igbYz0+9Hc/PSddGFOvAYzd3auyogobp01YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWn0XDky; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5f968230bso2822470b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731462953; x=1732067753; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=11EhO1dZz6gEnF3YkMG0XqMweNwg8PY4ZG+oYYjEKOc=;
        b=MWn0XDky+GHWuJ1JVyzNZQuNiISoCSX4FWvJX1NP8wRnvmKQmlZgFpjg490pR4yM2x
         1yE43rOY//NVbtHl7O8U3uMmYmd9qvforBlIB2de+t1MQj58ozVXBj+TapvwiJJo1+DI
         Lmm88K5KJarwOBEvevhdZg1lCSWsua0S4/6IK67Z/eTIMdj9ULn9F/r6QjLSpEGWBIqN
         yYjlAbCYBP0/k1/7mG++JSgTjzJ5Dy+epv24L/LgVfXMOubzVgvaL2YSLI6jspdkIn6B
         AgMZ3VhbrN9VYyp9bZBYiqFgNZHmgSL9mvH7hdeRNBhEQPtSmvQ7eBB0O6Ps2f9TLolj
         VPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731462953; x=1732067753;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11EhO1dZz6gEnF3YkMG0XqMweNwg8PY4ZG+oYYjEKOc=;
        b=AyL9NUPsXf1d3Vozz8YIeav1Vg0JOSW1gzExTzmlJS9T3kj4R+jZKwFEyZ1wP+Yml6
         x007HAcb6BIfRMai6nvdtNfFuoLNW4Bpi4bmjWczRtkRcwDqa/x0GtWh3JquGxC0E9c7
         BfZL7XLVK0nqmPz01ojn/7mo7Wa86C2gaTpSHAtaSbqtk/p8n+brid55fT8yzs/5DALs
         nZaXBp4qiJ2oEgQMGy89X8nFubx5PZe/HTPYgvuJsKfEyAyaCN1CN0yxp4+BNmcyIqjc
         9sPC8tiTe3QTn5PqX7GB/lgtRigQz1F6vIc7ZL8CTjQVeZFD4khiaOE+TnzD1fh4Vl+F
         QtLw==
X-Forwarded-Encrypted: i=1; AJvYcCXBdMuuHML5lDCeUXDVZJpu9zvmBCSGSOqZBNT7w+bIdpyU/O67hvqVD/Z4wAmWpWrjuUT4QE8LoZxG9+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFTfI250fsLjIR1psRAZPys/vDtg7c2tmHtrjDI+oN/UF1Wkf
	xd/5SXqCBttUhEpZHbIfMENATHrwrUiC2kh9BYuUD839ZNlb0dVH
X-Google-Smtp-Source: AGHT+IEw04kTyzxcDHeFkrUT0IqyioyF+6yN2dm4ArNEx6RbxWzlwtPmy+r8/kX0HzwsE7aRsIYj0w==
X-Received: by 2002:a05:6808:e8a:b0:3e4:863a:91b3 with SMTP id 5614622812f47-3e79469311dmr18550625b6e.8.1731462952993;
        Tue, 12 Nov 2024 17:55:52 -0800 (PST)
Received: from dw-tp ([171.76.87.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644db5sm11310584a12.55.2024.11.12.17.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 17:55:52 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC v3 -next] cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
In-Reply-To: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
Date: Wed, 13 Nov 2024 07:23:43 +0530
Message-ID: <87h68bnbko.fsf@gmail.com>
References: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> cma_init_reserved_mem() checks base and size alignment with
> CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
> early boot when pageblock_order is 0. That means if base and size does
> not have pageblock_order alignment, it can cause functional failures
> during cma activate area.
>
> So let's enforce pageblock_order to be non-zero during
> cma_init_reserved_mem().
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> v2 -> v3: Separated the series into 2 as discussed in v2.
> [v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/
>
>  mm/cma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Gentle ping. Is this going into -next?

-ritesh

>
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..36d753e7a0bf 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -182,6 +182,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	if (!size || !memblock_is_region_reserved(base, size))
>  		return -EINVAL;
>
> +	/*
> +	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
> +	 * needs pageblock_order to be initialized. Let's enforce it.
> +	 */
> +	if (!pageblock_order) {
> +		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
> +		return -EINVAL;
> +	}
> +
>  	/* ensure minimal alignment required by mm core */
>  	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
>  		return -EINVAL;
> --
> 2.46.0

