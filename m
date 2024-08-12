Return-Path: <linux-kernel+bounces-282554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3194E5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FD0281DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178EC1494BA;
	Mon, 12 Aug 2024 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcdjGIDV"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AC1304B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723436995; cv=none; b=cCjLrbbCaBXWv09C/LO9+6Z2gxOXrev1Uji56tcsKURHbm5zY7tOR0f+zz8Kcvpn5zoQcmymKsOIfoB422EctmqTafRXoFqCCUlgCUs8kOdhnoba9bGSYiy7T+Lz3R1+0oFXcrn6MGydgLtzcLhOf7mbeyAwSuMPMaNnRadhgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723436995; c=relaxed/simple;
	bh=64JaR5glgbGvah++UUZGWDLKuW0lxhhqjAh+LpOGo7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fifKSb2uxqQKqLujioslYM8Ed8etw3PGwl41Dvocd4X33pLf1pPY/3l7kJyzlo9n5ejHXVl4nfrX4EhBM61ocuZm/kVVj2GBBSk6PmEKqSKZ7HFiAVvFPysFzG+mGt2p3EBDdMHmAZoZsGHy0FXg8aNZiDut7LzJ970GCc1hnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcdjGIDV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so4465687a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723436992; x=1724041792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNMyygeVNgEAwx9iJlCggUVVUh6pFJu2DlL4gUoLISM=;
        b=lcdjGIDV7hTG9m1BoIc6SMFdtbGfbkqskshJN6z8gWuE2174P6xm32+gDniViO4Zul
         PDrsbbi+8uv/MehS/KHE745GHUGJ90ReBtAqns9mj6XcJOSsweyPvGProQlp+qDn4q4z
         PPrvzW5wN6dJAzJ7WSfEJBDhy5cFE/WVaDS9UUi+TiZpgxQJe5YVCYE0KaLK9B7stTAG
         6F4xIIdU9BfUpr5sHqxqUKKKhuuughTDxH92K1nP+SCEp6vH7ZAJjNerB02sw4Kd/Dmy
         nICmqRFxH755e9twszFIXvylcT44NNUQkYu9SeHbuHElKQVxfPT/x9zmSY/F/AgExgEz
         NUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723436992; x=1724041792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNMyygeVNgEAwx9iJlCggUVVUh6pFJu2DlL4gUoLISM=;
        b=pD03eoND4gvs+SOm5pTGdkY8nOOfEE9M3wIQLfUpvWIiSNH9NMuvgiPbF+N3SwunAd
         AyC3Yz7wQaHYalSxG+2uu+lu9LeKmUUBgzB05IX3l+8DovBvjqMV8jyDr5C9uEgeEdNC
         LrqxdzvBD22AzfSKVi0Inda2yWdWF8qsDtZnoPrZx7L4lEtm88dx6hCOLkhHOqyTFwnl
         MCfPRwYdImqUh1pyE7w9yVeeagJLuPHDd+qfFr4ZExwRI9/lcGmSAqiLXlfTXsQquXqO
         PgZlxbviJFDm3pb8PWLiae5ZYH2qR71KRgTsW7s1eXExM5muf0vHrOGpf7L373rPEtTD
         l12A==
X-Forwarded-Encrypted: i=1; AJvYcCUrPoWvW6VJ1NK9XwRGSiKVFN537vOV3UBQ6YLUmnANJVIewUhYM7apDBrYg+3k2WiKT36Dr4rzbdBvB+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUWB3Bz4nqxSJxugjlkR1YdZOE/AYn2Of/EuElhsvUFKwwcdj
	aqAYqTchDzYDniUXtMMstqNS+3Fyl/D3dQiFmqfeoJAl0+xTqqXaMdcPaZinsHDSZtxzciAmUoH
	nVUUuASih+fGCl66kmMYVXlTDBxk=
X-Google-Smtp-Source: AGHT+IHZ/UQ0l7NCmkXYTApz/zNg7ux6+r5p94v9JKh/7y/3DhGUrfnzSVtGwaD9JtUj5ZRlXmPT8tZezMNQFLkDpB4=
X-Received: by 2002:a17:907:1c2a:b0:a77:b054:ba7d with SMTP id
 a640c23a62f3a-a80aa65a401mr488737966b.46.1723436991580; Sun, 11 Aug 2024
 21:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
 <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com>
 <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com>
 <be0be869-4daf-4530-b90d-6dd6c27c8736@suse.cz> <CAJuCfpEMyRATp+6Xhe_XX-8hPKzONKonWbt_Jnkyp-wOJkN9ng@mail.gmail.com>
 <CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com>
In-Reply-To: <CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 12 Aug 2024 06:29:38 +0200
Message-ID: <CAGudoHF=oPXU1RaCn3G0Scqw8+yr_0-Mj4ENZSYMyyGwc5Cgcg@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Liam.Howlett@oracle.com, pedro.falcato@gmail.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:50=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
> Ok, disabling adjacent cacheline prefetching seems to do the trick (or
> at least cuts down the regression drastically):
>
> Hmean     faults/cpu-1    470577.6434 (   0.00%)   470745.2649 *   0.04%*
> Hmean     faults/cpu-4    445862.9701 (   0.00%)   445572.2252 *  -0.07%*
> Hmean     faults/cpu-7    422516.4002 (   0.00%)   422677.5591 *   0.04%*
> Hmean     faults/cpu-12   344483.7047 (   0.00%)   330476.7911 *  -4.07%*
> Hmean     faults/cpu-21   192836.0188 (   0.00%)   195266.8071 *   1.26%*
> Hmean     faults/cpu-30   140745.9472 (   0.00%)   140655.0459 *  -0.06%*
> Hmean     faults/cpu-48   110507.4310 (   0.00%)   103802.1839 *  -6.07%*
> Hmean     faults/cpu-56    93507.7919 (   0.00%)    95105.1875 *   1.71%*
> Hmean     faults/sec-1    470232.3887 (   0.00%)   470404.6525 *   0.04%*
> Hmean     faults/sec-4   1757368.9266 (   0.00%)  1752852.8697 *  -0.26%*
> Hmean     faults/sec-7   2909554.8150 (   0.00%)  2915885.8739 *   0.22%*
> Hmean     faults/sec-12  4033840.8719 (   0.00%)  3845165.3277 *  -4.68%*
> Hmean     faults/sec-21  3845857.7079 (   0.00%)  3890316.8799 *   1.16%*
> Hmean     faults/sec-30  3838607.4530 (   0.00%)  3838861.8142 *   0.01%*
> Hmean     faults/sec-48  4882118.9701 (   0.00%)  4608985.0530 *  -5.59%*
> Hmean     faults/sec-56  4933535.7567 (   0.00%)  5004208.3329 *   1.43%*
>
> Now, how do we disable prefetching extra cachelines for vm_area_structs o=
nly?

I'm unaware of any mechanism of the sort.

The good news is that Broadwell is an old yeller and if memory serves
right the impact is not anywhere near this bad on newer
microarchitectures, making "merely" 64 alignment (used all over in the
kernel for amd64) a practical choice (not just for vma).

Also note that in your setup you are losing out on performance in
other multithreaded cases, unrelated to anything vma.

That aside as I mentioned earlier the dedicated vma lock cache results
in false sharing between separate vmas, except this particular
benchmark does not test for it (which in your setup should be visible
even if the cache grows the  SLAB_HWCACHE_ALIGN flag).

I think the thing to do here is to bench on other cpus and ignore the
Broadwell + adjacent cache line prefetcher result if they come back
fine -- the code should not be held hostage by an old yeller.

To that end I think it would be best to ask the LKP folks at Intel.
They are very approachable so there should be no problem arranging it
provided they have some spare capacity. I believe grabbing the From
person and the cc list from this thread will do it:
https://lore.kernel.org/oe-lkp/ZriCbCPF6I0JnbKi@xsang-OptiPlex-9020/ .
By default they would run their own suite, which presumably has some
overlap with this particular benchmark in terms of generated workload
(but I don't think they run *this* particular benchmark itself,
perhaps it would make sense to ask them to add it?). It's your call
here.

If there are still problems and the lock needs to remain separate, the
bare minimum damage-controlling measure would be to hwalign the vma
lock cache -- it wont affect the pts benchmark, but it should help
others.

Should the decision be to bring the lock back into the struct, I'll
note my patch is merely slapped together to a state where it can be
benchmarked and I have no interest in beating it into a committable
shape. You stated you already had an equivalent (modulo keeping
something in a space previously occupied by the pointer to the vma
lock), so as far as I'm concerned you can submit that with your
authorship.
--=20
Mateusz Guzik <mjguzik gmail.com>

