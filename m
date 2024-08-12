Return-Path: <linux-kernel+bounces-283443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4ED94F476
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F7DB24E17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE3187552;
	Mon, 12 Aug 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOq2bm4q"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51845183CD3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480238; cv=none; b=iDbhI2T3PZBSRHiwEuHc0iUENK/fQW4sJRtp7fp0tLs6Jvr21UvdpfdGcp1peigrBVN2OyELJidcr7p4Z394wKjRPQ3zfqOc+2js2NcRVgRWe0RGHOW6XywvSqUAgIn44ChEYswd1qhj70fBKFdFmoCDsXgpxplbztwAAyUhkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480238; c=relaxed/simple;
	bh=AjR2e9So+IHI1Cls34E6cNKwZvfQ+GJ8AQO2unVOgzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew+mC++F6Uv9qSUyyY1amcJeZS+kbJiJNGPv9rh7RxbQqBW5DEDgRnx9QQOkMwGC5oEFHvJ9Q8yre36HKfLq/YDmAgQF0fgZdeXlRQY/C9NADLZqZM8qXYZps+m2VJ1vHKYdWK1vtdZYlpXAq1FRIObST2Wawhdkmwkvm+/XyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOq2bm4q; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a81bd549eso312401266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723480235; x=1724085035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh/ZheNui15fU6+AXHk2A7ofzsw2gwL6IA1lX6l2+yg=;
        b=EOq2bm4qP97UYnGluHIq0LvVcnSGDcZ5xIhyYAAQzKhEfWlK8ysElxKeejYjxmIOUE
         HEOz4x+/aQINjqFByLfNCZSuztF2hWU33m6YP2So8mwgT3o+628vLUIrfr+uNaaDKxms
         5BhJ87z2+4qKi/rfxD26qDX0qFCWsvMnkrOMW8AzkLtQxq/ZHbAwwFx4krowljsB3Niy
         NpwrXq7QnsXAk91djZmNXtvKZwzs3oD7eRg1etnj1xT93SlXftEkHFgOlsGvIEteU/lH
         JJsL51/weCyQ9qevsYX7j/ZxPo9bwI2Jnz951WbfpaBXjWFtEN9w9BP13VYDJlyNZK/c
         fbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480235; x=1724085035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh/ZheNui15fU6+AXHk2A7ofzsw2gwL6IA1lX6l2+yg=;
        b=WCiUDAdP3xmrBpCMKIspf1BEz5+s9AhqAxxDsvSgQVjiZzZih6kiAwYhIIFVU9lq60
         GqD/KRSoUc5soMvAy7r/8+NkjqLFxppCImjXXNklIglk22I8t4D54DWb/qatUeixz95z
         J/uOGEsqfg+sgntsVEqJ61JjhsajwUpk0ZNe0T0tgb11OexV3wPlyFIQBhd2IJCI9OVj
         5eWLgxuXprHjMo0puXrd4Ob1Id8zaZCeSuHhfqhJh6Un6vYAucBfTbxbfEVrMTwDlvgB
         ODvgsPtep1LJKdEbNUqxtBVQ9yua0V7fjym1K3eTsIYBX7Zg43ZlLYgD6ALzPQ2Ww0zV
         qBrA==
X-Forwarded-Encrypted: i=1; AJvYcCW/gf1xnJo0KIC/V4GmJrayuD4/tvdKj8gDRHxyI88G+KYLOwI7mF+BdWmVIVgOaWXArmqIHP4Fzb6DMGQdE3UW/n7XIkXb2AGMNRPv
X-Gm-Message-State: AOJu0YyoJrVWscZbfd6+f+PGKv+Hjw7qQWOmhD5olmf4twv80tSyWVpy
	LuxoXtdS+XEeTawHg3dOdMHQ5PPP73UPU4B1V0/So3kPEqmh1wJN284m2i9LWdEYNGRnMuTHckM
	K6XXv8luJwXrsTFpyskrM1kDE304=
X-Google-Smtp-Source: AGHT+IEi3ijVRmgqPYAuk2JNGk5MQ8Fw3FiDN1n6sSx8/RjW+0p8rwr1AmyNmtT1vWdTmXSjAzYI+KL4iz5My99rCdU=
X-Received: by 2002:a17:906:bc19:b0:a77:c84b:5a60 with SMTP id
 a640c23a62f3a-a80ed1c2522mr67312766b.26.1723480234262; Mon, 12 Aug 2024
 09:30:34 -0700 (PDT)
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
 <CAGudoHF=oPXU1RaCn3G0Scqw8+yr_0-Mj4ENZSYMyyGwc5Cgcg@mail.gmail.com> <CAJuCfpFHyzCwGov7YzrE1UDc+0jxKjfm_Kcn3NHR=NXPma3PnQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFHyzCwGov7YzrE1UDc+0jxKjfm_Kcn3NHR=NXPma3PnQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 12 Aug 2024 18:30:22 +0200
Message-ID: <CAGudoHEsqG00UW8DfsCW3t8jyKXXwCcUxaom=t5uAoeeXFuWzg@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Suren Baghdasaryan <surenb@google.com>
Cc: Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Liam.Howlett@oracle.com, pedro.falcato@gmail.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 5:27=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Aug 11, 2024 at 9:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > That aside as I mentioned earlier the dedicated vma lock cache results
> > in false sharing between separate vmas, except this particular
> > benchmark does not test for it (which in your setup should be visible
> > even if the cache grows the  SLAB_HWCACHE_ALIGN flag).
>
> When implementing VMA locks I did experiment with SLAB_HWCACHE_ALIGN
> for vm_lock cache using different benchmarks and didn't see
> improvements above noise level. Do you know of some specific benchmark
> that would possibly show improvement?
>

I don't know anything specific, I'm saying basic multicore hygiene
says these locks need to land in dedicated cachelines.

Consider the following: struct rw_semaphore is 40 bytes and the word
modified in the lock/unlock fast path is at offset 0.

I don't know how much waste is there in the allocator, if there is
anything less than 24 bytes (which obviously will be the case) there
will be massive false-sharing. 24 bytes of the *second* lock land in
the same cacheline as the first one, including the stuff which is
modified in the fast path. iow the locks allocated this way are
guaranteed to keep bouncing.

I don't believe any effort is warranted to try to find a real scenario
with this problem or synthetically trying to write one.

> > If there are still problems and the lock needs to remain separate, the
> > bare minimum damage-controlling measure would be to hwalign the vma
> > lock cache -- it wont affect the pts benchmark, but it should help
> > others.
>
> Sure but I'll need to measure the improvement and for that I need a
> banchmark or a workload. Any suggestions?
>

I believe I addressed this above.

If there is an individual who in your opinion is going to protest such
a patch on the grounds that no benchmark is being provided, I can give
them a talking to.

Even then, it may be this bit wont be applicable anyway, so....

> >
> > Should the decision be to bring the lock back into the struct, I'll
> > note my patch is merely slapped together to a state where it can be
> > benchmarked and I have no interest in beating it into a committable
> > shape. You stated you already had an equivalent (modulo keeping
> > something in a space previously occupied by the pointer to the vma
> > lock), so as far as I'm concerned you can submit that with your
> > authorship.
>
> Thanks! If we end up doing that I'll keep you as Suggested-by and will
> add a link to this thread.

sgtm

--=20
Mateusz Guzik <mjguzik gmail.com>

