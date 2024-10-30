Return-Path: <linux-kernel+bounces-388292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966659B5D46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B50283E41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927A1DFE0D;
	Wed, 30 Oct 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/wHybIR"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24554BD4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275068; cv=none; b=Hc15ZSIZJAdk97eqeNSHXvKPz2l9Cz/4cwTO9Jh9HYVz44K4hBPgd0vwml2IlGdNFsFXgdKXAuJleAelfdTihbcrk4qZzEtgGGkwFW1dmR5yHqTX1IE52F3sCdK5lVl/KMU5GzwPiQf6+gaxHbxGTC4OB2fGc6We3OjZZ/+BZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275068; c=relaxed/simple;
	bh=e6gmkpVmkGUFFyBEb4vmvov3+W0/2u16RMkFwzeJHu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8WB25gG6AfEBvXoRtrfoCnI5sq13ZCGosLxNYKR0fxvotxoP9RXGMpxVxSK7pjeNc09Ud2M+wW7fnnvyVsccZzMovfrh9rIuRgEBUGVHPA+ezEhWFGO+CuT+YzwuaUjcqEJJefiNl4rlt+o2VcDzl9aaHjQwC22ycidBWI3Vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/wHybIR; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a47d70cd8aso2012444137.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730275065; x=1730879865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plX3x5h0hTHCjTaj8H96Ts4cSpt3nFr9HgDXxvsW4oQ=;
        b=K/wHybIR7zJzpmCgtUpQ+pVa4o4GK05wKquMXAGRTLZBJCPROSRk7FWeprpWKKaeSf
         mQpa6bD1nZkldrVv0YQKTvYZ76WML3d29mjDuMlC1WUbi2lAOSAzRWkp6NeUS32tV5JC
         hcv6sgEXmPtceguEJ1lGYp4XtjuNrTyDV5sQNbqNWQJyx985Ppod4gGh3s1FYXBrozDT
         OZ8yTBNPCFcKM59UIcXXy4hwx411z1H2pTuG1E5RbBCMfnniBOn625do7Abbo36eSKEO
         HAjZc9Lnaz68L/wdsqEqwr1xBFhS9cW/6B+5xXuHkReKcFJPGO8UYf3pIUVR7BAziDa/
         crPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275065; x=1730879865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plX3x5h0hTHCjTaj8H96Ts4cSpt3nFr9HgDXxvsW4oQ=;
        b=W1Vb5ll1oiHFuG9zbnyMZZ2uVJ1waKCn/f3TDzcjj3bwJZMO8ulqJKNUkfyBevVt0N
         Vw14l3z+0R8UvcfaBKuEmvqlX+P5hn3xlTpbmVYlvg1s6oiGpWteDsp3iVajvoz04vJx
         bYEG5TT+0GpOX8Q+ogbTsIunlL6vXcVnChvw9AM6DdH4chCtcrkpY226fM7CKKZ2ajTS
         ESV0B6YSNiJYGf1Ice8X0zeFhGG9QW1B5IzdNCjUsavtDLg5PF6myXDfTCoaqukL8mRR
         3W2a4VfJi8vw3uA0fVnNngJlaxbJvGtqIAaSj+FJr/GlIGx/g/nnY1WfNR/H6pgjCNpg
         ywtA==
X-Forwarded-Encrypted: i=1; AJvYcCXPYEaOzQYGnFVP9EJuNeGgiR4l1JeF7oZ1GvJfbJC5x5E/6lMT4rUe7xvVNx4s1ZVRVfJD8T1y7WYMY4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+dO3SxWn5bekzkvz91Z452junuWmyyREKIIOwSPKAHGY0hcz
	0lt/aN83uElPiomX5KbIbhBZrB2vCvesuMGFAdcgRxCPmFvWCZalhaGxHTge7Ja6bhavkKKfaPA
	yeMn859DOLRSuR+8+i54yiDNJx60=
X-Google-Smtp-Source: AGHT+IEqiA5Q0Rv/EJu5wbAw/dqZArPeLiDTJwRLpnZjmTFmm/xf0WozX2i1W+xBiZaEBIwDQ1HBHFdv/eE2Jxda36c=
X-Received: by 2002:a05:6102:290e:b0:4a5:e63f:3655 with SMTP id
 ada2fe7eead31-4a8cfb27a53mr14674627137.1.1730275065081; Wed, 30 Oct 2024
 00:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026082423.26298-1-21cnbao@gmail.com> <87o7329s0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4yv0CqAyiA1WaPdNm8HSUL5pda9frgT_1H31+FZt1fGjg@mail.gmail.com> <87jzdq9n6h.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzdq9n6h.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 30 Oct 2024 20:57:33 +1300
Message-ID: <CAGsJ_4wP4E8pUnhjOZ3HX1e-dgJO=0URA2RwkwpPYw4H=ZNPgw@mail.gmail.com>
Subject: Re: [PATCH] mm: add per-order mTHP swpin counters
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 6:29=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Oct 30, 2024 at 4:45=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >
> >> > This helps profile the sizes of folios being swapped in. Currently,
> >> > only mTHP swap-out is being counted.
> >>
> >> Better to describe the user space interface in patch description?
> >>
> >
> > Do you mean something as below?
> >
> > The new interface can be found at:
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >          swapin
>
> Yes.  Some example output may be even better.

ok. let me add some examples in changelog:

cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
12809

cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
4763

>
> --
> Best Regards,
> Huang, Ying

