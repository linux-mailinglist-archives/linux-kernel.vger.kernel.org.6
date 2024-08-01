Return-Path: <linux-kernel+bounces-271369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D4B944D44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F6284C46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D51A38C1;
	Thu,  1 Aug 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFukTa8O"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9418E04C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519462; cv=none; b=aHFG60OtydyYZF529QKfifKHgszz9g8rilN8GtuISgDdBpMQODz78e3A3h1w5PdpA3HGX55UXJeZOtGZn4JgZmsWdbF/Gr/BgnEwZGUPdTQCqj2DZkNcYXKtxYJiIh+FlhJIpD3hfz2Hry4zdjpC7B5sEVKnTqWvYZR+lkwEntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519462; c=relaxed/simple;
	bh=1nlM8D+ejojDkFR9ik7oR51jAClmQAousUOI6P/ZAy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X52p8MSMEak+qEyzd1KtrbC4RZQEtk0Hpl3vGFVpsgvZ+jmx+zUFgmxPQvmSOoNbv1ofQyxZPpT+19uefQJgj0YdZgHmqlI0bTneQ88rkysvjocvgRM0Wm+CCB5PncoOQ8j0IlVa6SW7ijDhKekuMI2wjSaIQnKRSta4NuNBiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFukTa8O; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so901487866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722519459; x=1723124259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MJGq9K50tWQqmXkPFfvIuTp2wsCjmWRK4EiU3yCi8g=;
        b=nFukTa8OcPBnYGY1jauZ5W6ZUv5jcZrA017PWmfykRpLiDbGrBpl2mbwwAMgNN2u/A
         xXZCm6SlsUPXSWJdpWhSdtEHjUi8lqeyZTVV4wcNWjcpvLg4eKxnh84E+dT2XEFImkY5
         d/fjdTO+gsJpgbOalNwNkVrO3aUHT8Z4O0DQe7ts5nJe5PYl+3SXRcK5zYCq+UgNo5Ja
         +AO/ZL2IxBK1exuWMADPYPjutsU5hCwBbWigHrTbu+xfluZSigZkjvUX43C/e6s3aF3+
         480iBocwxYzASYpDVoZipHAaPlrHTvUMl1R3oX0+383EIp+1N88htzVd6PbSjDTk7xtr
         EiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519459; x=1723124259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MJGq9K50tWQqmXkPFfvIuTp2wsCjmWRK4EiU3yCi8g=;
        b=Pdd8gRQjwgt2sQ+aDS4DG6eKEio835f/tEnxZOfzrTX2Kgnuf8Foi7NjSZJ9kyTVcZ
         2IAHT9qnSfjwBCFzKQrq4piFd1Hl8qGYTAXOScF3Teo8Q0W5rZkLRiMXjUtSZlxSxiFa
         G75frzwv0PfGdAfrzbm+g1ui2ccc5gYP2b3vbzsba2rWjlicYyEPs5ahFBxQsq7Zg4no
         nJIKceIpInZxwCmgn7BWAFAUDJ65jpWKTHST0prWHPtcSxoy9EW0vZU4nGzjA6k+46Dv
         K8aCBhZp1htQGV9Aw0sIDs1HgMtOnQhiDUyw8c/1XdTcLkyPJkI5EF+7UKAREAtkoiZ2
         EynA==
X-Forwarded-Encrypted: i=1; AJvYcCX3aykNkxvm9T0nxbeUkeOyVsHC/Xs069DR5igGU1+XXjEW5S53vwt6VUJAdsWBSOLn+EGSTANl5IyZXktcckq0SHAcEr9mw5ZoCSCW
X-Gm-Message-State: AOJu0YyDeknFnDQTAaGSNAcRfLuHMYOdkalEoC6T7BEcrAA3eYuXDllf
	BxrdbmFYq/Ua/iTUXBo0aBimp9PaRcrDdAwlTMZSIxfHSvL/lQwIPEoRHgXsO45ed+NXmJ+sUJk
	qlOPLmUSY2oeE1GZxW5cJI03wtuk=
X-Google-Smtp-Source: AGHT+IFvvHRv7PGT4EkPAH/+ZprZ5eQncaACyC1qBnx9bkqUCl/jQLddYQKFDWzGGuy8yHz0oezB7mTPpyzOtIZidgg=
X-Received: by 2002:a17:907:1c16:b0:a7a:a06b:eec9 with SMTP id
 a640c23a62f3a-a7dc4db9ef1mr15331666b.4.1722519458457; Thu, 01 Aug 2024
 06:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407301049.5051dc19-oliver.sang@intel.com> <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com> <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x> <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
In-Reply-To: <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 1 Aug 2024 15:37:26 +0200
Message-ID: <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9% regression
To: David Hildenbrand <david@redhat.com>
Cc: "Yin, Fengwei" <fengwei.yin@intel.com>, kernel test robot <oliver.sang@intel.com>, 
	Peter Xu <peterx@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org, 
	ying.huang@intel.com, feng.tang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 3:34=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.08.24 15:30, Mateusz Guzik wrote:
> > On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
> >> Yes indeed. fork() can be extremely sensitive to each added instructio=
n.
> >>
> >> I even pointed out to Peter why I didn't add the PageHuge check in the=
re
> >> originally [1].
> >>
> >> "Well, and I didn't want to have runtime-hugetlb checks in
> >> PageAnonExclusive code called on certainly-not-hugetlb code paths."
> >>
> >>
> >> We now have to do a page_folio(page) and then test for hugetlb.
> >>
> >>      return folio_test_hugetlb(page_folio(page));
> >>
> >> Nowadays, folio_test_hugetlb() will be faster than at c0bff412e6 times=
, so
> >> maybe at least part of the overhead is gone.
> >>
> >
> > I'll note page_folio expands to a call to _compound_head.
> >
> > While _compound_head is declared as an inline, it ends up being big
> > enough that the compiler decides to emit a real function instead and
> > real func calls are not particularly cheap.
> >
> > I had a brief look with a profiler myself and for single-threaded usage
> > the func is quite high up there, while it manages to get out with the
> > first branch -- that is to say there is definitely performance lost for
> > having a func call instead of an inlined branch.
> >
> > The routine is deinlined because of a call to page_fixed_fake_head,
> > which itself is annotated with always_inline.
> >
> > This is of course patchable with minor shoveling.
> >
> > I did not go for it because stress-ng results were too unstable for me
> > to confidently state win/loss.
> >
> > But should you want to whack the regression, this is what I would look
> > into.
> >
>
> This might improve it, at least for small folios I guess:
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5769fe6e4950..7796ae116018 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1086,7 +1086,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>    */
>   static inline bool PageHuge(const struct page *page)
>   {
> -       return folio_test_hugetlb(page_folio(page));
> +       return PageCompound(page) && folio_test_hugetlb(page_folio(page))=
;
>   }
>
>   /*
>
>
> We would avoid the function call for small folios.
>

why not massage _compound_head back to an inlineable form instead? for
all i know you may even register a small win in total

--=20
Mateusz Guzik <mjguzik gmail.com>

