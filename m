Return-Path: <linux-kernel+bounces-228297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FFA915DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E491C21958
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42B13C9BD;
	Tue, 25 Jun 2024 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sengvy8/"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AB1EB3D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290995; cv=none; b=TZcSWWZftZFQjtyt659q+Nzb/qmXuDdb5Cw+ev+E/NUJF2jktEZOW+c42g6fCWPi8vhtrp1beD35j6YOMS8qhfKFyc0jqg+OGk22XXNQhrsIeClYOSBMzk1BxVNSGdPHZ2h5MfgrYLpTeX9a7R+ETt+ZYqk8BWLozi/RrjF2Tz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290995; c=relaxed/simple;
	bh=ZTsViRf18NvOneXfi+xgDEd3bh5pDLz4AuvQb3N72/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SYs+leWhm3WzrSLnbKUiGtTxzHEoJD4JASQAloAc429Zt8QoqgMUTDFyIxk4AWb+URLsF0Fa46E9rVCt8rm7OEDsXrdbGhoSOfaGUEqqJ3Ohx8mp2R+E+TCr8SzC3qaSQZFUahrf2/6+U6FqF0sAXzoxPSucfZwOkWs9OEfrWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sengvy8/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7067a2e9607so1759742b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719290993; x=1719895793; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuqG7biAOqgDgQrrsZ67iRk9Ad3cri9ERlzvBniIlQU=;
        b=Sengvy8/RjQ6RL0JIpKax3IHLMe0EuZyNrUv/+28nNn5C/0PB+lj6T4uAu8feDi8Ek
         lGJQHGL+EVTBPpFPWctI4UehLbHliykj3fOgz2VBQ3E+D3OKEQNg2t/DlA1CXS9O9GdW
         rUKannPL1frqe1vy7K77k4DVJlLnRIOkFQaCB9ofghUorhjJiBv/OdKFVJMsj0Ovf2n5
         KrGpoafwYNppfcjKSXS8Q1ScT6LMpdhBlr80FGNW/pIHgJXlHgsoCmDdePYRJwNvWgj2
         r9NMpGEZQwZHkiNJZ7wDqbirGfgaaQh24Z4aTcxkb4OdFkcZr+uUjRoZ/5OJbbnyQtEP
         GNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719290993; x=1719895793;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuqG7biAOqgDgQrrsZ67iRk9Ad3cri9ERlzvBniIlQU=;
        b=ZbZDcitKxY+TXVd8TAHJQWtbzjgVgyeVIYJj0FTbuKz22CTvRzfgYFcxpAolN6XljO
         l+SRJWHfrOfP+tP1tpBX+4pHAMm+d19nZXmZwCU8CgqEQ08N6YqWHKetHHMUyKrXd9KF
         ADyuC+Ip1bIH+tZVN6u+76evDipNRGWnl+dBFelZw7a3XltfgpqpSebyBPM5ssHKGJIN
         eR4UaorfwQGhmR0dMBBR0hMngKmcG7OX+i5ez2zKHiyhICZQLRpZM/+D5CrjEzG9zSKG
         EwO4eK9Gb4bui3PAtuKNHHv8nh1W/YiqIwWtuUfhpXnafCjcaw3kwj1sUQXvDwdMy64o
         h+aQ==
X-Gm-Message-State: AOJu0YxEcYqTvchGOSd9MSuJkfKPsRe8/RqDsm9TaPyGsv7zNYeMM+XC
	WK5rYXVxf8NS2Esbt6ec1BVADs/WlE+WvoQhvSFOkIko0hXvbZIJ
X-Google-Smtp-Source: AGHT+IEMY8o/252qBDFEIJQKQoJP+4B/vRW3iANS8a4tWuh2eFp5ixvi1C+Zofa9uCivrKn8XtAURA==
X-Received: by 2002:a05:6a20:be13:b0:1bd:2292:e592 with SMTP id adf61e73a8af0-1bd2292e5efmr233523637.22.1719290992767;
        Mon, 24 Jun 2024 21:49:52 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8b832639bsm275497a91.1.2024.06.24.21.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 21:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Jun 2024 14:49:45 +1000
Message-Id: <D28TSEV6QV38.2NWPFRY8KCQK7@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 21/23] powerpc/64s: Use contiguous PMD/PUD instead of
 HUGEPD
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Peter Xu"
 <peterx@redhat.com>, "Oscar Salvador" <osalvador@suse.de>, "Michael
 Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.17.0
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
 <23f3fe9e8fe37cb164a369850d4569dddf359fdf.1719240269.git.christophe.leroy@csgroup.eu>
In-Reply-To: <23f3fe9e8fe37cb164a369850d4569dddf359fdf.1719240269.git.christophe.leroy@csgroup.eu>

On Tue Jun 25, 2024 at 12:45 AM AEST, Christophe Leroy wrote:
> On book3s/64, the only user of hugepd is hash in 4k mode.
>
> All other setups (hash-64, radix-4, radix-64) use leaf PMD/PUD.
>
> Rework hash-4k to use contiguous PMD and PUD instead.
>
> In that setup there are only two huge page sizes: 16M and 16G.
>
> 16M sits at PMD level and 16G at PUD level.
>
> pte_update doesn't know page size, lets use the same trick as
> hpte_need_flush() to get page size from segment properties. That's
> not the most efficient way but let's do that until callers of
> pte_update() provide page size instead of just a huge flag.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

[snip]

> +static inline unsigned long hash__pte_update(struct mm_struct *mm,
> +					 unsigned long addr,
> +					 pte_t *ptep, unsigned long clr,
> +					 unsigned long set,
> +					 int huge)
> +{
> +	unsigned long old;
> +
> +	old =3D hash__pte_update_one(ptep, clr, set);
> +
> +	if (IS_ENABLED(CONFIG_PPC_4K_PAGES) && huge) {
> +		unsigned int psize =3D get_slice_psize(mm, addr);
> +		int nb, i;
> +
> +		if (psize =3D=3D MMU_PAGE_16M)
> +			nb =3D SZ_16M / PMD_SIZE;
> +		else if (psize =3D=3D MMU_PAGE_16G)
> +			nb =3D SZ_16G / PUD_SIZE;
> +		else
> +			nb =3D 1;
> +
> +		WARN_ON_ONCE(nb =3D=3D 1);	/* Should never happen */
> +
> +		for (i =3D 1; i < nb; i++)
> +			hash__pte_update_one(ptep + i, clr, set);
> +	}
>  	/* huge pages use the old page table lock */
>  	if (!huge)
>  		assert_pte_locked(mm, addr);
> =20
> -	old =3D be64_to_cpu(old_be);
>  	if (old & H_PAGE_HASHPTE)
>  		hpte_need_flush(mm, addr, ptep, old, huge);
> =20

We definitely need a bit more comment and changelog about the atomicity
issues here. I think the plan should be all hash-side access just
operates on PTE[0], which should avoid that whole race. There could be
some cases that don't follow that. Adding some warnings to catch such
things could be good too.

I'd been meaning to do more on this sooner, sorry. I've started
tinkering with adding a bit of debug code. I'll see if I can help with
adding a bit of comments.

[snip]

> diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/boo=
k3s64/hugetlbpage.c
> index 5a2e512e96db..83c3361b358b 100644
> --- a/arch/powerpc/mm/book3s64/hugetlbpage.c
> +++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
> @@ -53,6 +53,16 @@ int __hash_page_huge(unsigned long ea, unsigned long a=
ccess, unsigned long vsid,
>  		/* If PTE permissions don't match, take page fault */
>  		if (unlikely(!check_pte_access(access, old_pte)))
>  			return 1;
> +		/*
> +		 * If hash-4k, hugepages use seeral contiguous PxD entries
> +		 * so bail out and let mm make the page young or dirty
> +		 */
> +		if (IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> +			if (!(old_pte & _PAGE_ACCESSED))
> +				return 1;
> +			if ((access & _PAGE_WRITE) && !(old_pte & _PAGE_DIRTY))
> +				return 1;
> +		}
> =20
>  		/*
>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was

I'm hoping we wouldn't have to do this, if we follow the PTE[0] rule.

I think is minor enough that should not prevent testing in -mm.

Thanks,
Nick

