Return-Path: <linux-kernel+bounces-174293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F88C0C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A85282038
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83216127E1F;
	Thu,  9 May 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLanWswx"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560638D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243538; cv=none; b=M1FOFH7WWozstrHnSGT9pzG7fbFkuHiFVM5P6U5EcOxGs6wriir/9E0rrypiasO9WjTvvoInykya+F3ROydPe9z6O+V8fLwwP9gEqM/ckTwu9F11QRy20HmEcjd/v9eXpu+z2W6xzyVqrbiiPXhM8YuFa5SOGXxr7CzHw1APocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243538; c=relaxed/simple;
	bh=3O93YwQUI5Pf8qmKmqy00kECcOrLz0z1CgeG/ZiG9Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH9/rloXKSB+PqrVfpayUxrZ8pi1gLrqtrS8gk6D2izMLnnL58Gb+2IXfAykonH6k0nQ3vfB1BtTdg4sxv42PXgXanhnGAv5I4B92ZlmLxQ3TUcqpptKo++vNFZqgGE8ePymtzMTX9Plzpa7bzATtb8Iu+O8uxnNUNXix9rkB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLanWswx; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df3e3c674fso246693e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715243535; x=1715848335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vex5Pnrbj6pXdLB6wrqH+dw5zwsnYQyV11tpN7ZxBo0=;
        b=gLanWswxt7T/eu66tcDXtyggSDrWUlDuygm5ibHv7sGq6HqHCWyh3P919EeWYBb83z
         R68Jq2PIczwbtPoBElGsc961foKWFfDBT1PzX9OHjk+H86nJQorwfckA17AVRWwVxlEo
         nfHN108LEqBHyulqnMZhHv8kqinCeJ/e6q+QtrAoC/DipgXs1rviembhGfNbm3rZenjl
         TgmUWxcF70RBCYiOXZ6A4UF6Ev2dRGtTBguHcDEMLyIB+73qfvF4JJr/y2RbpKivBOyh
         BASF+rL+GFQ9yufym2eJ0y97n/IOXu03RJ0BQc8GlWnKXraZ5Rdr7T2C/+N2WUSRAxEH
         8iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243535; x=1715848335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vex5Pnrbj6pXdLB6wrqH+dw5zwsnYQyV11tpN7ZxBo0=;
        b=aoyG6qXWw+cDJSMyDGfMGMLgrR/o2r8jNrSXYUUiKnNn22l1NBURoVzNMbIvfezasU
         6WCAg5oWF6rHHCmRREOnKZpwT2Q5CoSy14v0jMP4K8zur/wjr9eywq0Nj8oUOdWh73WR
         +n7+XZPYU87HGXhubFXGoSXPRkngF3ctYt2oAmimOGLov78usS5q5sSUNbIPZC46THVC
         jgLvRYmxEsDuVOCC/lqCV9U4OoX4nuj6DBEtxykGtneHKxAFFd0WWg99sXd0ZFc4/qjk
         6yDYluXqDoA04zWXxWA1vv6QSgenwbR/l96olrXRYZcVy7RTMeWl4YzB5um317MGpbUw
         vTdw==
X-Forwarded-Encrypted: i=1; AJvYcCUwgVdRd0CQc/medfq7z6aqgw5yBONCHv+HF6g1pwf9q6BychjZ76zDDlZKXNL2jVbbahm8gdG358tt2ZPG87eaPSpLUZScFIPI0v2/
X-Gm-Message-State: AOJu0YykPlta1sLuJSBFh1yi98f1XlFuYBtCv3DUDeN79IDfMFHU73F/
	3zrSsxqrW8D3+piv2ZG58OFxW+4pLZi4BWLjeHxCerpg6M6qSSJYSLhE6/XqwRWLeeoapA6HiBY
	nwioFVlzlSiCcI6V6+hHzDhS89HgB2pjm
X-Google-Smtp-Source: AGHT+IGQOakR1UQwRPkvNnKqUu7WsXnibCzsIFljlK/L8T8rvDRaWR+S2xPmwYnG/KM7tJ8xJOCxoqjMX8kj6N/DtCQ=
X-Received: by 2002:a05:6122:411a:b0:4da:ced8:b09a with SMTP id
 71dfb90a1353d-4df69001fbfmr5570961e0c.0.1715243535532; Thu, 09 May 2024
 01:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <Zjx_6F3Fti_EBD_e@tiehlicka>
 <20240509080636.bauxbgpqdluzpein@oppo.com>
In-Reply-To: <20240509080636.bauxbgpqdluzpein@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 20:32:04 +1200
Message-ID: <CAGsJ_4wLF2+O2ydr8EvPqgrsOPsWStUxpzRvi3rJpktU_FSP1w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org, 
	Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:21=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> w=
rote:
>
> On Thu, 09. May 09:48, Michal Hocko wrote:
> > On Wed 08-05-24 20:58:08, hailong.liu@oppo.com wrote:
> > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > >
> > > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc"=
)
> > > includes support for __GFP_NOFAIL, but it presents a conflict with
> > > commit dd544141b9eb ("vmalloc: back off when the current task is
> > > OOM-killed"). A possible scenario is as belows:
> > >
> > > process-a
> > > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> > >     __vmalloc_node_range()
> > >     __vmalloc_area_node()
> > >         vm_area_alloc_pages()
> > >             --> oom-killer send SIGKILL to process-a
> > >             if (fatal_signal_pending(current)) break;
> > > --> return NULL;
> > >
> > > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pag=
es()
> > > if __GFP_NOFAIL set.
> > >
> > > Reported-by: Oven <liyangouwen1@oppo.com>
> > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > > ---
> > >  mm/vmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 6641be0ca80b..2f359d08bf8d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >
> > >     /* High-order pages or fallback path if "bulk" fails. */
> > >     while (nr_allocated < nr_pages) {
> > > -           if (fatal_signal_pending(current))
> > > +           if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current=
))
> >
> > Use nofail instead of gfp & __GFP_NOFAIL.
> >
> > Other than that looks good to me. After that is fixed, please feel free
> > to add Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > I believe this should also have Fixes: 9376130c390a ("mm/vmalloc: add s=
upport for __GFP_NOFAIL")
> > --
> > Michal Hocko
> > SUSE Labs
>
> Thanks for the review and the Ack!
>
> Add Fixes in V2 patch.
>
> IIUC, nofail could not used for this case.
>
>         /*
>          * For order-0 pages we make use of bulk allocator, if
>          * the page array is partly or not at all populated due
>          * to fails, fallback to a single page allocator that is
>          * more permissive.
>          */
>         if (!order) {
>                 /* bulk allocator doesn't support nofail req. officially =
*/
>                 xxx
> -> nofail =3D false;

isn't it another bug that needs a fix?

>         } else if (gfp & __GFP_NOFAIL) {
>                 /*
>                  * Higher order nofail allocations are really expensive a=
nd
>                  * potentially dangerous (pre-mature OOM, disruptive recl=
aim
>                  * and compaction etc.
>                  */
>                 alloc_gfp &=3D ~__GFP_NOFAIL;
>                 nofail =3D true;
>         }
>
>         /* High-order pages or fallback path if "bulk" fails. */
>         while (nr_allocated < nr_pages) {
>
> -> nofail is false here if bulk allocator fails.
>                 if (fatal_signal_pending(current))
>                         break;
>
> --
>
> Best Regards,
> Hailong.

