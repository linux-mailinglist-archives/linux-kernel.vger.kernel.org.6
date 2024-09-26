Return-Path: <linux-kernel+bounces-340948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34B987962
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D89BB271BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50217BB33;
	Thu, 26 Sep 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMLu+cJI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4918660D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376372; cv=none; b=YnXo5aJMP9RpsHxnF3ztRDAV/irgKXerCpgYRNgds/d3NoRwAQ0tAplmqwQyMoPCoHYsh1p+XDrp3AAA1DJ+UtKxTYGiYSUAuWZPi8uOkF1fQPZOmOnlcQ8v7G/x73xsAKrkS5emr+Y+bzt7ln+h0s6fXLuEvh7GID0xrzE0/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376372; c=relaxed/simple;
	bh=Wkjsf6OaIHAMxqZEX13iA4RkR7BrPEoXhjBy8uqk7m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3/2elahe9gAAuSKbWwVGF++7K2hPrkB1ObFk0//lCd4SyUX9W1+o7JvikeiRuqR/4LcGDoSWO6W4fvqSDh5yZPxiYXa079D75D2KiJXvo4u32nFOesEiXB/3uv41z65gsFA4yFq6jOFKPo2YZXspXe9W/p8BGtGWwt2FE3nv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMLu+cJI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so1353084a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727376369; x=1727981169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk4UTkfwIuITGHz9uOfYgqgRx4tdqdVUB6KNEJ6hUiA=;
        b=gMLu+cJI+5mLcLxcHhY/JPhJ5fvTjN1bxyssx0ZAAOxAjwJcVUvwmMa4NiS85CGcp8
         o065e9ePo0Q65elaE4+4JYi+/knMPvnWKMjRlbdd0ENHiARtvDyUWugG6uHiDICH/F4C
         Na2IRAHClRLqm8xznuvpddG2wkEkDLqEy8MJe/byX78tnR1+7mk0FyxtURIwr+U7jX1c
         Kp+kZaLwWBuJGAMjDKpOkXe+LD2UlcZqd4oJAPXasogOoy8KDAuxDkZHcaH/CZeqSrt0
         aerRzmsGm+P0iQ6cg+8x0OghGzhaMz3tamZozJleOyYjEISUXpPN8rQMJoQeYYq3zQg7
         nGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376369; x=1727981169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk4UTkfwIuITGHz9uOfYgqgRx4tdqdVUB6KNEJ6hUiA=;
        b=GkX+t/lUm90aD2SLE4kHCAG810BWmJfu2JYyvb4iSJszTXkpDw7X1Vo01fTGuCfu5E
         Rp0YgN4j1PEyo49p91InKRgZd49dldqbSBLxFhGBC7eqM87PfoeddGzrUMLUlliEZAQ6
         7Q8YEOZfOpvnCG6my2pFVJicZVxN6/nZWdlPwWG/24F7byQGwPn+r/hVZhVSDd/T/h01
         oQKurY3pv9YtyaRlhdwYY/fSFebsbQQi2HKxjahxTCN7LPRoOm7ExLwBLCzazaDWuMZ1
         zMwo9pJqxDAUMGWfthDlA02/S7fre6ut6Gh2AyvR+zyEA9UgpmFq2MKAmg0sGvWaVtjr
         Ka5g==
X-Forwarded-Encrypted: i=1; AJvYcCVefiwGJ5zB4ygQ6MvKpBnYoCRfHclS365j4FlUvXmKqvex9dMUFRiYarsrE1OwL2DF/KW2DFMh1sx2mX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk37QeUent3GQdw6GGqBszUamPYetmZcNIVQfr0TQjnaQD++Aa
	T0tVW73nRMC5XGZgIMppl9UGuKM78W5ZQwVHWFKomn8t83Yws0X3Y3vLK161xB76ZicwnncVVSq
	u7LyLZA44Wmaz6xmU6uLBtnSTRExW7o7Srftb
X-Google-Smtp-Source: AGHT+IF6mjmm9+8cOinmmP7Rpa+erJ49P6fmsyYj/zNyOkhh4bzdxLi7MHTNWAUoTVFqdTQOykj5Qcy3TD1iHOvIWAo=
X-Received: by 2002:a17:906:dac8:b0:a8d:4b02:334c with SMTP id
 a640c23a62f3a-a93c4c284b7mr41231566b.64.1727376369220; Thu, 26 Sep 2024
 11:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925192006.GB876370@cmpxchg.org> <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org> <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
 <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20240926184301.GA883850@cmpxchg.org>
In-Reply-To: <20240926184301.GA883850@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 26 Sep 2024 11:45:32 -0700
Message-ID: <CAJD7tkZTBLbx3-RUwUv8UpUt=-XiMd1mzUzC387dNTyreyFrJA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:43=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Thu, Sep 26, 2024 at 05:29:30PM +0000, Sridhar, Kanchana P wrote:
> > > > 3) Keep the approach in v7 where obj_cgroup_get/put is localized to
> > > >     zswap_store_page for both success and error conditions, and any
> > > unwinding
> > > >     state in zswap_store will take care of dropping references obta=
ined from
> > > >     prior successful writes (from this or prior invocations of zswa=
p_store).
> > >
> > > I am also fine with doing that and doing the reference batching as a =
follow up.
> >
> > I think so too! We could try and improve upon (3) with reference batchi=
ng
> > in a follow-up patch.
>
> Yeah, I agree. The percpu-refcounts are not that expensive, we should
> be able to live with per-page ops for now.
>
> One thing you *can* do from the start is tryget a pool reference in
> zswap_store(), to prevent the pools untimely demise while you work on
> it, and then in zswap_store_page() you can do gets instead of trygets.
>
> You'd have to rename zswap_pool_get() to zswap_pool_tryget() (which is
> probably for the best) and implement the trivial new zswap_pool_get().

Yeah I was actually planning to send a follow-up patch to do exactly
that until we figure out proper patching for the refcounts. Even
better if Kanchana incorporates it in the next version :)

