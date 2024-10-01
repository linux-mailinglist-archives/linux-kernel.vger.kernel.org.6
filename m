Return-Path: <linux-kernel+bounces-346382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8998C41D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4141C20F58
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6431CB50B;
	Tue,  1 Oct 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mT85kSF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F318CC0B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802128; cv=none; b=difdE0SGTIkLLLJEPN/YFha/udNmRaAwMXRi+D9a9Zj0+MWrN2XWdMTnae1lAJDp6BvID2o4+G3u/3pI0lJ1E6GhC88Fqm9MQxgOFBrF0E7Div849jbARk97EAMllCvEcl7EmD715QqO/ATKHOHW3SH4QGJeIUuYpKo4xxECyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802128; c=relaxed/simple;
	bh=f6WC1XY5pUQdYKEzXtyNU6wOmRcFQu8VJUxwoxSfoMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaVwfDgaUh9gGyCEPhPH+5AKSpNrGA43r/GIXj3Gv7lV1y2XOGt2GpBZSqbFA6tKnSq073CMt6GovL6819rCG/pkDWFp/gdegu/ZsRQ1JOQZdFEJLjfgc2kavwPnJ0MGJZEmJsX49dooKKVDueH/9uXdIT8Wc+MBWWadQ0necyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mT85kSF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d56155f51so739248966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727802125; x=1728406925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bV3UhRWZD4cI+GXzuTGXGMA1zPWWKRAb8b1c9r2ox4=;
        b=4mT85kSF0z2yRmwDCigYB8pNI5tiTg9sLrKCKfnaT57gCRKPLNFPbVRjuSslq5Itfh
         tCfm5P25CKT0ib88x2Mc4EGqDfs7RvjbReNLMqvdT31Rpeb6gNwiQV69SEX9CM2hr8Cw
         hoUR8q2FyOXB325/T/CRSKkT3fhx9llEmhNGmFLNoxMO55G5RLLTIbDXOBOQnCfBKlOt
         sbYBsRhITJfLiToRsylt+L4Ydl9zMOXJTLt+MGvTuIomT7iOSvTD/Ure6DHh4ZPfhYSX
         0FHw7As/O8GCa3rO2AIyk0l9uoWzXFX0030MiUEOcKjC5ghEo8cSftcHXIzA9RAAmNWX
         1HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802125; x=1728406925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bV3UhRWZD4cI+GXzuTGXGMA1zPWWKRAb8b1c9r2ox4=;
        b=gFAUEGpelz8v4q7mWTMvzL3KKG1SN9UTTSfl+0ypZ9Hm37hPATWHvcvfUsHy7oTC36
         sGfYXFE1uWiDnolDefeV9+5GzYuEo6TmvMDcayPFnKCz4KD2dW7/W8pwJlhdTjXGlNkC
         8vrbfQU30ShjgluNOjEGVGZQv6BQHAV1pZA23ca0NbTK4LlZ02Cl//IjBBzQTyiRUCe0
         n+ov1KqR6XakCTjCz7ctbsM8EVuPgEJl5ancSB+qWoOzxhGICwzVx7T6gvCkfTQZeKh1
         o7WCbJSJjvFaCu6nEeVdMWQrKQ78q1BZ3PjK2uh9zdT80tVjTTFAU+IMya7ehPyBG0dM
         RbSw==
X-Gm-Message-State: AOJu0YzPCYEMweTNHYZHDio/Ud+vTeq+8d4eDhsxcbCxHADevtyZbkqX
	UdT5z/UClNjTKICH8AomOvrZyGbwiQJ1PkzfPmQsPLiESut1EzhIZzOCm1KU3cNVAuaem3/Mmhf
	ivKvN93KfREC0xEOnnX1Q8iQncWLePRkJgj7F
X-Google-Smtp-Source: AGHT+IH8ThQ51HBLCX/kr6qw8fgHXecD6CswhF1p1ZtPySqavrPgiaXJQWg177FX8jIJod+dIFiSBY0G6QeGBiyidDU=
X-Received: by 2002:a17:907:98c:b0:a93:d181:b7fc with SMTP id
 a640c23a62f3a-a98f836eeaamr21140766b.51.1727802124770; Tue, 01 Oct 2024
 10:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com> <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 10:01:26 -0700
Message-ID: <CAJD7tkZk=9Su3vtdFcghD0R+GqSchn5b1L91SgTvxcX79rmdOA@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:58=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Monday, September 30, 2024 11:00 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; shakeel.butt@linux.dev; ryan.roberts@arm.com;
> > Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org; willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>=
;
> > Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_st=
ore().
> >
> > [..]
> > > > >  store_failed:
> > > > >         zpool_free(entry->pool->zpool, entry->handle);
> > > > > -put_pool:
> > > > > -       zswap_pool_put(entry->pool);
> > > > > -freepage:
> > > > > +put_pool_objcg:
> > > > > +       zswap_pool_put(pool);
> > > > > +       obj_cgroup_put(objcg);
> > > >
> > > > I think if we reorder the function we can drop these calls, make th=
e
> > > > comments positioned a bit better, and centralize the entry
> > > > initializations. I am also not a fan of passing a semi-initialized
> > > > entry to zswap_compress() to get the pool pointer.
> > > >
> > > > Does the following diff improve things or did I miss something?
> > >
> > > We shouldn=E2=80=99t be adding the entry to the xarray before initial=
izing its pool
> > > and objcg, right? Please let me know if I am misunderstanding what yo=
u're
> > > proposing in the diff.
> >
> > It should be safe. We already initialize entry->lru after we insert
> > the entry in the tree. See the comment above the call to
> > zswap_lru_add(). Basically we are protected against concurrent
> > stores/loads through the folio lock, and are protected against
> > writeback because the entry is not on the LRU yet.
>
> Thanks for the clarification, Yosry. Since this is a change in the entry
> initialization wrt the mainline, is it Ok if this is done in a follow-up =
patch?

Sure. We can discuss it separately. Do you want me to send a patch or
do you intend to?

