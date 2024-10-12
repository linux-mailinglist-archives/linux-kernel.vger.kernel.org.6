Return-Path: <linux-kernel+bounces-362089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A299B0D8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D382837BC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C486277;
	Sat, 12 Oct 2024 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktS4NuG9"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BD38B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728708520; cv=none; b=bWfxjx0/T1jp8o097f6Eis8+AbOJDbULeiZYee+oK/b821hRypHWg66o7vDLOOMKD7TionuLd9Xpz6eBb7z9GO1gPA5ZGQbViwO+Dg0zcn3WTDsi/K4qpeRLttEj59MWFM27kQ5hts9em8aaDF0sQDDNfC2+HholqOH/VA9VOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728708520; c=relaxed/simple;
	bh=/i34JxoHFSY0Lta4UrBoomeDzeEHjnwLeIdpleXXzC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dh2XdgAQo0f9p+69hsDQCgSFH4W/cPOo0+lNsiVC2oxeH4VPPrqVeJ1Wb0ScTUd9F0WkwG2gFEjYvguBhApC/UpxXG2uSlLytLcA2Sew6LUnvclrsTx5Q3C9butx3ZZQy4Sq1Fh3TDOjwIiB0wa6lDOMwcBtxEhZhfl6L0wGnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktS4NuG9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so28626971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728708517; x=1729313317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eesDKQEIstQvISC6jTfHky3SdAH9qcctfJOq1P1i/YE=;
        b=ktS4NuG9KKRa1QdHybi2ir4DyevfU62wY0tqb+JZ0LvAkyV1pvK7k/f2HMMWTSiI5s
         PVlS8qiXssSSSEBy3G9LCupoVML/v7JRNMj6OGP1iidcQ0SuVZrZFHkHnT0xrIQPXgSg
         aXbTCl8GKhpGU/L52YOnsMR2JStaICQ6aiM3QhhoChAmHCJKonDx/X1bltiz5ajso5Q7
         JSXuMpzAyXXHz6haj46kI2SX1yERR56pvMHa3lr8FYlhDJsAQZJL/SKvkj3JliFb9egH
         pGY77SK9dxltcGMtczApKOUK7kMEXxXyIxDJr3hHhpSRvqr/YYslJjndj3F6X6ts3jA6
         UcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728708517; x=1729313317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eesDKQEIstQvISC6jTfHky3SdAH9qcctfJOq1P1i/YE=;
        b=YnIgM5DLT6zBzyyVi3FPDZ6h0x3DNQrCHf2P0EVPaDK0JYvGV52uiyxCyIP4OWc+PF
         SCdUWlD9/pVqYBjBPlT62Sv2ct1U0kX6D5W+twGqWt0aUHhbQPdWvsGcKs4gvwem6V6u
         NGfL7fMWQaro4Dgov6nfvjmgHDhoc7PDOLdhsQUVV82O2xLSvMONo/CwG5d1HY6rtfgF
         afQzpiSyFuBavwug/2n4keEvOTI3jGhSD3KEyp5/CvRinJHQWv7JRt5xavsDA1Tbl0eg
         Kb81NOW9caH4wC2OHrxSoooraDmXYzpcU8zT8XflQRKBciMrQnO8i0ngADqya1/S9+rc
         Yt6A==
X-Forwarded-Encrypted: i=1; AJvYcCUYPLCylvifMTW5ZoD5oSdpciea0he6RcEGNDhPsDEREA87n+hnKbiMJkvESbgx4jn/PKDGSzl0q8z8edA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXRWNKolbT9Ie4fBKuGwi2MT9MeVAXFIxitbCSiIi7bgugxKT
	LL0DPLHJsgqvH5yRJHR9tBVXALmqNvTKr7C3ikn73OltitzJnWb8zmXyD6oTtsXgJaS4z5Bk0Rn
	gtNKMKfSHVgfW9I3C823ZyeiUV6c=
X-Google-Smtp-Source: AGHT+IFp6fHtCxWou7iOJNcqwlXIO5faifAB/ntjKYzPVnp6RiwB6q7mpuRZGS+K1eY4XTogLEibzPE8sKSG4oKuV7I=
X-Received: by 2002:a2e:f1a:0:b0:2fb:3a92:d1a7 with SMTP id
 38308e7fff4ca-2fb3a92d591mr18536591fa.33.1728708516310; Fri, 11 Oct 2024
 21:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011171950.62684-1-ryncsn@gmail.com> <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
 <20241011182831.GC351101@cmpxchg.org> <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
 <5fa01666-51d4-4ccb-bcd4-3b3620dd2e2b@linux.dev>
In-Reply-To: <5fa01666-51d4-4ccb-bcd4-3b3620dd2e2b@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 12 Oct 2024 12:48:19 +0800
Message-ID: <CAMgjq7D9LJgsg4RT640=3E7KMDURbzjt=+RhX_5YX7a2Nk6W+Q@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary invalidation
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	"Huang, Ying" <ying.huang@intel.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 11:33=E2=80=AFAM Chengming Zhou
<chengming.zhou@linux.dev> wrote:
>
> On 2024/10/12 11:04, Kairui Song wrote:
> > Johannes Weiner <hannes@cmpxchg.org> =E4=BA=8E 2024=E5=B9=B410=E6=9C=88=
12=E6=97=A5=E5=91=A8=E5=85=AD 02:28=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Fri, Oct 11, 2024 at 10:53:31AM -0700, Yosry Ahmed wrote:
> >>> On Fri, Oct 11, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.co=
m> wrote:
> >>>>
> >>>> From: Kairui Song <kasong@tencent.com>
> >>>>
> >>>> zswap_invalidation simply calls xa_erase, which acquires the Xarray
> >>>> lock first, then does a look up. This has a higher overhead even if
> >>>> zswap is not used or the tree is empty.
> >>>>
> >>>> So instead, do a very lightweight xa_empty check first, if there is
> >>>> nothing to erase, don't touch the lock or the tree.
> >>
> >> Great idea!
> >>
> >>> XA_STATE(xas, ..);
> >>>
> >>> rcu_read_lock();
> >>> entry =3D xas_load(&xas);
> >>> if (entry) {
> >>>      xas_lock(&xas);
> >>>      WARN_ON_ONCE(xas_reload(&xas) !=3D entry);
> >>>      xas_store(&xas, NULL);
> >>>      xas_unlock(&xas);
> >>> }
> >>> rcu_read_unlock():
> >>
> >> This does the optimization more reliably, and I think we should go
> >> with this version.
> >
> > Hi Yosry and Johannes,
> >
> > This is a good idea. But xa_empty is just much lighweighter, it's just
> > a inlined ( =3D=3D NULL ) check, so unsurprising it has better performa=
nce
> > than xas_load.
> >
> > And surprisingly it's faster than zswap_never_enabled. So I think it
>
> Do you have CONFIG_ZSWAP_DEFAULT_ON enabled? In your case, CPU will go
> to the unlikely branch of static_key every time, which maybe the cause.

No, it's off by default. Maybe it's just noise, the performance
difference is very tiny.

