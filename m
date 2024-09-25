Return-Path: <linux-kernel+bounces-337843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB210984FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5731F24498
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAC13A416;
	Wed, 25 Sep 2024 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYxFo9MR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD91332A1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225605; cv=none; b=llYW7/C/K1YkDSA+6a9gnMCt6wFnlMbmalIuBq8buG3DxZlFU7cGgLA/P+TMmI3hjrh4hfPPJkzStxhTrAjZqA788FiJ85jmY4EHL5JIaPISwLkq5vLqb4k3+qeuJJRpwUe96vMAzJ3o8jaOSXq9Ty0NX6WHMPJok4F/tAKSUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225605; c=relaxed/simple;
	bh=/1zjTSrBUTgwawl8d/0sff9Ucm/5wHfUoU4AYVa6K3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeRM3pn0ospSQgnvXel6BmvOfXdesHvdi2RzgecijLtgp3i1Yejo6MKybnN1S+KqdlNnB9KxKkPWVXrhZ+yR3grgmmdnbFabpDGiGuD2WB9l1GH3TU8EuiINZZoR/GUYYMByMpVywwJqyWCdKwPJ/jhqmkGDwF8/Dys4IRk63nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYxFo9MR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so901566166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727225602; x=1727830402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C9gXTKiKhXSAsoWF7SRVuxbBkuFhBiScsDmep1YlmQ=;
        b=WYxFo9MRNHdO38WNPX1WXEbWTraC200Lhq2fzivXIyaxBldpYplF2p+zKG+nNftH18
         K6OWDFQ8FBE8sWjZzgcJHQvePAlTpnhMxepWJ7DR2gjcZF8etyUdwj1nxPuBaicY9EH9
         Hf5kY230mQFcZ0UQwqaxciF/KmTLyhg/bsbOlOgPmPWCHhEFYVs2Q3yjUzDrjcIGEa8V
         E/qOv5r/6WQXg7nzO4OinlELl0GkOykohXeEuGfj+sGP/JldA4KQ7mTT26VRaU5wIsfi
         AcW+mX4IX7YZ4+f3C2e5vV5BrSwFXEUq5FPabmKs70md9OVuCOJT1uUBUeG4GfWXgvvu
         1a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727225602; x=1727830402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C9gXTKiKhXSAsoWF7SRVuxbBkuFhBiScsDmep1YlmQ=;
        b=BLhfYP+SLX3zRtKrZjCHui8LbthjwEXojETUKSWRVl4WVPTCVr80hEh1rAhAu7B6pN
         hpDb9H6CYHsoayOxbkpWIO0uwZpIUUxE6lFFvgXAWcSuwYYdOpYJ+gEn1qrZbv9MqCBC
         fhnef10ELBvWkVxmHy1DIFWrFStfvXtJ1MN9MVQsW2Ln+e/5KFBcBgsZSy3Qf4z8+EL0
         e8guBc2DyWrcWA27vJ9twif+txAFv0sGd2C/wWUmSLHRhSCxUkicN92Nlt9h1hBBWnJ5
         gO4kkXMlN+2ysIXMBQ06mZ3lrSArMYpQL7PDniwEcqZUX2TzLPQlWaUS/yz3JWURraDD
         jidg==
X-Forwarded-Encrypted: i=1; AJvYcCUpnFhYI/0yl9lYB7RS6CudgEBUH2tDhljZn0LwexhSkENfMAcXbqFX2WUyPdSTHemzsCprqjq1FgABBPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rpgOKYyoilDHItCQgsaUAHBSRgfY2RrdEm4RWJNb6KH9/Y6A
	3ALi2kCTU+kyMBIYS4ALF9EkAxnjOF/uA4m0xCWZzva5XLnpK51nYcwjuFUMCrtZwmKaP7HoLzb
	sH5cSepx8DDh80iDlQuHyDSyknxDV9zpekqg4
X-Google-Smtp-Source: AGHT+IGVZVslwLOc/ZLHTgwX0urxOIsPrhUDpzOCoFQYuYbrgCQ558+RspYWQ75mMyu8A2pRVHqyJAYIovN9ZyGb+eo=
X-Received: by 2002:a17:906:4788:b0:a80:f81c:fd75 with SMTP id
 a640c23a62f3a-a93a0110333mr69872966b.0.1727225601351; Tue, 24 Sep 2024
 17:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
 <CAJD7tkYCXexrP_2xjXqFDpJALCgi84aA7wGOo=6mfuUSpMO-ng@mail.gmail.com> <CAKEwX=OsL10kywer+FkhBSQ3FK_-bkrQLqErZy-hGMWsRjmZrg@mail.gmail.com>
In-Reply-To: <CAKEwX=OsL10kywer+FkhBSQ3FK_-bkrQLqErZy-hGMWsRjmZrg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 17:52:45 -0700
Message-ID: <CAJD7tkaRbsc7Lq7ihfony7sGwyiUjioQVAi7gZoWGxFmc+nT2A@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Sep 24, 2024 at 2:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> >
> > We can also do what we discussed before about double charging. The
> > pages that are being reclaimed are already charged, so technically we
> > don't need to charge them again. We can uncharge the difference
> > between compressed and uncompressed sizes after compression and call
> > it a day. This fixes the limit checking and the double charging in one
> > go.
> > I am a little bit nervous though about zswap uncharing the pages from
> > under reclaim, there are likely further accesses of the page memcg
> > after zswap. Maybe we can plumb the info back to reclaim or set a flag
> > on the page to avoid uncharging it when it's freed.
>
> Hmm this is just for memory usage charging, no? The problem here is
> the zswap usage (zswap.current), and its relation to the limit.
>
> One thing we can do is check the zswap usage against the limit for
> every subpage, but that's likely expensive...?

Ah yes, I totally missed this.

>
> With the new atomic counters Joshua is working on, we can
> check-and-charge at the same time, after we have compressed the whole
> large folio, like this:
>
> for (memcg =3D original_memcg; !mem_cgroup_is_root(memcg);
>      memcg =3D parent_mem_cgroup(memcg));
>      old_usage =3D atomic_read(&memcg->zswap);
>
>      do {
>         new_usage =3D old_usage + size;
>         if (new_usage > limit) {
>            /* undo charging of descendants, then return false */
>         }
>       } while (!atomic_try_cmpxchg(&memcg->zswap, old_usage, new_usage))
> }
>
> But I don't know what we can do in the current design. I gave it some
> more thought, and even if we only check after we know the size, we can
> still potentially overshoot the limit :(

Yeah it's difficult because if we check the limit before compressing,
we have to estimate the compressed size or check using the
uncompressed size. If we wait until after compression we will either
overshoot the limit or free the compressed page and fallback to swap.

Maybe a good compromise is to do the check before compression with an
estimate based on historical compression ratio, and then do the actual
charging after the compression and allow overshooting, hopefully it's
not too much if our estimate is good. We can also improve this later
by adding a backoff mechanism where we make more conservative
estimates the more we overshoot the limit.

