Return-Path: <linux-kernel+bounces-213227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB6907220
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD0E1C20F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB57142623;
	Thu, 13 Jun 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S65Gq2yB"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28817FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282635; cv=none; b=XCOatwVAKBgdFBBo0I65k1PfBKSa+YJ9fEz2+yd02CMEX+hqgMMhfye1D1LWBffyWG4JuaXC4HnQKOfjCRuHwwMwYyAhRMNsMGAGfgW6XFkdGS6UXaFe6sZ61iL1NJmGkyzRjrym+f0m+yS/jEu6UqgcNdyXcGRyK6iADPFTryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282635; c=relaxed/simple;
	bh=h+xpkY7WSFIBvT9Gb60qWH87G4yPyQPGboaiQzUeWMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltHG8sT+lzzITEnfOdKyttWl5hFP+bUljBPdHo3IyO7WB4H6orPTiy1W850XvY9V60U1IN+n7tzYxASTdj3DFdF36ZkspKLv8wpoF9Nc7nWe8AATuqPDb/6v/EZKiIvcPdtJPldJq+UaS7159ushX0HiXTSFO81ZvqJSvvbfIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S65Gq2yB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so75142a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718282632; x=1718887432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+xpkY7WSFIBvT9Gb60qWH87G4yPyQPGboaiQzUeWMM=;
        b=S65Gq2yBdifleod2wk5mnosBYfetXSzG9z3D0NlJUkA7HLbb+mM4+HEacU3tBkWQR7
         YTgLmQBbA7N4sCRKcZhNn3x6MOdYS/P3T5xRRr6NZAsTiahonpyLG+kLAiOshZJTHL1k
         jIC1oJ8e8VZ5xUcBdAf6PZizLVtYolSmXsG5cxXeVNQrelYOBp+6SYeYo3h/ADmrsSC5
         mvE6ZFpI5IPDmSFwnsc7CUDyyAySZDOYCsjpCx9qodGmNFrissfLeJychkYh1tKAuMcc
         K5odVidpH+YZYarLWhYTt0dOAmDbA3QCPtgEOmnr0pmaAQZuIozKqtLp0Mbhd1gs3JIT
         B2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282632; x=1718887432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+xpkY7WSFIBvT9Gb60qWH87G4yPyQPGboaiQzUeWMM=;
        b=gYK8PLF/LUcMt698SlJOXgL9D1RZ+slWNP8vxu5DIt34blmooH3inGfnDQeE6o5vto
         OllrJV2w2F/GTF19FQ/7qfhydq22ERKXwXVKRdQx7XlPltmYhotjYv+j8nVlLA4iupUg
         dwxcR4rfgt/nQ/fNhZkuwDGRqPrNtDWDtPTLVF6yVQXM3qs5SccetDBC15IkJ3mEXgQO
         sximkC4QpnBfVvAmdPDbrTkrerS8ceZPf1jwJPpIgmSKsiEBdvEkKPiyfybt4I3US5TD
         Zxc5DNw/TNeRYK2LdMZ2fkPfEpmpPKjuI/ljSPVUeh4paZmsJ3u+Cj8xr4w0+e2om1S8
         UqqA==
X-Forwarded-Encrypted: i=1; AJvYcCW+piugpAR9jX768QEd09tNIdYImnA6ekV1zJVTQ4srFgEFpH2o7chi1pl11m355yCqV0ECE9nTRqnBI+ur2GQd8zoSdajI9zXbSyTA
X-Gm-Message-State: AOJu0YxnVXk6lp96LaPD6f2NjX9dyNhcKKa0sqHgqyaJ9ZYF7WRXO7it
	lwYgXvVGb21/CNZ2UjDkXoszheGibt9nb6QlIJ/mXpk7u/RDfqavlRv3q/9z7cb/cxjUDUTU+co
	qG+okFN4TR8+G64fvgIZJSIermJw=
X-Google-Smtp-Source: AGHT+IHWEnhEAG7BIKzNUmdChKpRz4XU/chxrEqTqjIokiG3GESbbaPfbcO1r4pT+VE2ZOBA9+VCkv5DKbE6sUU47XU=
X-Received: by 2002:a50:fa83:0:b0:579:fa8e:31a0 with SMTP id
 4fb4d7f45d1cf-57cb4bc275bmr2089842a12.10.1718282631462; Thu, 13 Jun 2024
 05:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120209.66311-1-ioworker0@gmail.com> <20240610120209.66311-2-ioworker0@gmail.com>
 <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com>
 <be85ddcc-88ee-4f8d-9f73-b388f4d47b71@redhat.com> <CAK1f24kWHWL=nT2uDp=GF6dLp9AYuEVr4=ipUsWGK=cf9Qbfbg@mail.gmail.com>
In-Reply-To: <CAK1f24kWHWL=nT2uDp=GF6dLp9AYuEVr4=ipUsWGK=cf9Qbfbg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 13 Jun 2024 20:43:39 +0800
Message-ID: <CAK1f24k24dEYWsoQ3avPufaL-A1EaudWtscLpc6XeVOdrZFcFw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, mhocko@suse.com, fengwei.yin@intel.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:49=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> On Thu, Jun 13, 2024 at 4:27=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 13.06.24 09:52, Barry Song wrote:
> > > On Tue, Jun 11, 2024 at 12:02=E2=80=AFAM Lance Yang <ioworker0@gmail.=
com> wrote:
> > >>
> > >> Introduce the labels walk_done and walk_done_err as exit points to
> > >> eliminate duplicated exit code in the pagewalk loop.
> > >>
> > >> Reviewed-by: Zi Yan <ziy@nvidia.com>
> > >> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > >> Reviewed-by: David Hildenbrand <david@redhat.com>
> > >> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > >
>
> Hi Barry and David,
>
> Thanks for taking time to review!
>
> > > I don't think "return false" necessarily indicates an error, so
> > > "walk_done_err" doesn't seem like an appropriate name.
> > > However, this is a minor issue.
> >
> > Agreed. As we only have a single walk_done user, should we instead
> > remove "walk_done", keep the "page_vma_mapped_walk_done" for that singl=
e
> > user, and rename "walk_done_err" to "abort_walk" ?
>
> Yeah, I agree that 'abort_walk' is better than 'walk_done_err', and let's
> keep 'page_vma_mapped_walk_done' for that single user ;)

I just realized that there is another walk_done user, which is
unmap_huge_pmd_locked().

Could I keep "walk_done" but rename it to "done_walk"?

Thanks,
Lance

>
> Thanks again for the suggestions!
> Lance
>
> >
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

