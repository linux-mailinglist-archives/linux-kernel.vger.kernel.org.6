Return-Path: <linux-kernel+bounces-337650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527FF984CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F8D284F62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E613C3C2;
	Tue, 24 Sep 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssSaWvxA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344917557
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213699; cv=none; b=EBKHDPfCX1oVrHwKRIsDjcghx6NtuxzSGecsFihHq5Ryl7dGTMlyfF8G4MachYOjBxvtv/qyKcLaelkvEq21MMEdgK9lSxZXbRNy/VOtQJzxgUffzL1CML1wUSf6sRKiCPl/Nq+iVojxZoZbvLXNyzDrww7Goiz8WVsbEPvHMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213699; c=relaxed/simple;
	bh=Ihhqm8m5Qh/kMpRgCqE3tbP5xFH8qdU26SE9syYFc2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4kQKKIrmycOlnl2XwBM5Qgm4HnpcT420qvFyT843ckWS2WnZLYfP0/qO3Dg0UHw4mjJwalDfIzj5k0GvZRqF1cDv9K7MQ6t6TcKkCBNjYlVUj6OVDq4y7wYD1H5DSY8VLqBq5QKMn3bvxrUc7CjEmx8eDGRK/fYoOarye+6B5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssSaWvxA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d56155f51so723128466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727213695; x=1727818495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihhqm8m5Qh/kMpRgCqE3tbP5xFH8qdU26SE9syYFc2A=;
        b=ssSaWvxAnauuVcYlyH1d00I+dDJionR+Ld27NkFcRBFGXBXEQy4Tb/Lqe9O2bvYjIQ
         Lf6Rg1bIZKnExJfTOAGXmSLidLvCUzFxhvqUK+052FzU2RzLR26WlVkc6Q2BIm0xmol7
         PeUfoEXC7gLGJJVNK+tv5g4bjduYIW2GG8KkF045M1QZkFmh3jEV3X7KdpZApN0IiZMW
         QCFX2ECU1M9HL9/hYZawouh5REhzy0hewDMKFXJv039+GcolXVBrDx0aqL0ur1ofsbZF
         XIrbyWwoHuhIlOeDjHAyBA69VGxdtqnl038UcVZIhZSjVtwqgkOIyOHVj888wcXMrvCZ
         y6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727213695; x=1727818495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihhqm8m5Qh/kMpRgCqE3tbP5xFH8qdU26SE9syYFc2A=;
        b=ZmNyEAx0E6MHAG6awkZGwNHHERyn8SzJVWcmXwoNxO2YwuuKwOFq6ExcOmejH0VBB2
         XL36phTjLul74I3X04X2TIeWZ9k9XIekfiHOC1Iy3rB9157RtHUVEGbiVM3xkNAenUhC
         j7P4lKz3DSPE2f/ZNEjIqmQb+fcaK2af6CdHza0QIrP4TSHURGxUK43APqPDFXwc6NMB
         8JqgfMgNLBTWzo+h3GrmlPBmH5bwt6sK7kNq0AN0g9R0P5ZYbv8UvxyzSGAWARUKubUD
         xZmFfu/q1NHDlE/I+PM8f2YUpR1Z45xYHGpmNwVTg73esHTRLD08gbURwfbqqpmwlXDj
         Jz6A==
X-Forwarded-Encrypted: i=1; AJvYcCX7HcUEwXKkItVLM+xz6/KaO0YSfMijt4shVRGl1PZUWUxAe2jTbz+SXf8OYMRAQPEf3iVQoax6TgCTTfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLqq5gAWI7T19zM5lHYbX/9CNy/y1hwlwvHx7mvmtQS+smZCw
	Y/R+5I0KoiKhrf/edrl3Cqa9/+VgivYBhK9/DnaiSBUrHgoBb0efwn2iV6nSwnUtruvcxRac13r
	E1AF26hmpPwjvBiXWs/5Sk3UxmZ7e7721I/3a
X-Google-Smtp-Source: AGHT+IFGjImsKTq8f4NzlhA/wTzA9/r023kIBe/p8GR8g/F0krWD4o68iWS1PDRX+N2NPRHUxMgS4wne5FmDfDOExdE=
X-Received: by 2002:a17:907:1ca7:b0:a86:7cac:f871 with SMTP id
 a640c23a62f3a-a93a06b5943mr52905366b.54.1727213695314; Tue, 24 Sep 2024
 14:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
 <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com>
In-Reply-To: <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 14:34:19 -0700
Message-ID: <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Nhat Pham <nphamcs@gmail.com>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:08=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Sep 24, 2024 at 1:51=E2=80=AFPM Sridhar, Kanchana P
> <kanchana.p.sridhar@intel.com> wrote:
> >
> >
> > This is an excellent point. Thanks Nhat for catching this! I can see tw=
o
> > options to solving this:
> >
> > Option 1: If zswap_mthp_enabled is "false", delete all stored offsets
> > for the mTHP in zswap before exiting. This could race with writeback
> > (either one or more subpages could be written back before zswap_store
> > acquires the tree lock), however, I don't think it will cause data inco=
nsistencies.
> > Any offsets for subpages not written back will be deleted from zswap,
> > zswap_store() will return false, and the backing swap device's subseque=
nt
> > swapout will over-write the zswap write-back data. Could anything go wr=
ong
> > with this?
>
> I think this should be safe, albeit a bit awkward.
>
> At this point (zswap_store()), we should have the folio added to to
> swap cache, and locked. All the associated swap entries will point to
> this same (large) folio.
>
> Any concurrent zswap writeback attempt, even on a tail page, should
> get that folio when it calls __read_swap_cache_async(), and with
> page_allocated =3D=3D false, and should short circuit.
>
> So I don't think we will race with zswap_writeback().
>
> Yosry, Chengming, Johannes, any thoughts?

Why can't we just handle it the same way as we handle zswap
disablement? If it is disabled, we invalidate any old entries for the
offsets and return false to swapout to disk.

Taking a step back, why do we need the runtime knob and config option?
Are there cases where we think zswapout of mTHPs will perform badly,
or is it just due to lack of confidence in the feature?

>
> >
> > Option 2: Only provide a build config option,
> > CONFIG_ZSWAP_STORE_THP_DEFAULT_ON, that cannot be dynamically changed.
>
> This can be a last resort thing, if the above doesn't work. Not the
> end of the world, but not ideal :)
>
> >
> > Would appreciate suggestions on these, and other potential solutions.
> >
> > Thanks,
> > Kanchana

