Return-Path: <linux-kernel+bounces-174108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112D8C0A48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB351F2524E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713C13BC3C;
	Thu,  9 May 2024 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgwZvM5c"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801313A87A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226516; cv=none; b=rdIYMRTsSdTAZpt+r1KY0B3a/xFSNyVkDD+o9CeqJkUA1VJJyeRpBuk6AHjZakFQQrwt88wdYQRrsBWj08rX4+cFCTa9mYSHdNdMyjs1m3etJVQQSizZ9R68OfccI4gfcFZqd6PrqA/HfP+dltPJrb+vzJjLKznPddsTVstTKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226516; c=relaxed/simple;
	bh=bzdGSI+iKK1kLsVREslaWzUeb5yy2hka0j/sBhWVX5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7CCpqkrp6t9GCaZCnLaz/gihJnnk85K6f19hSIuSNLEGJR+AbBYvkxJGJWGr/aqE/Pqvp7briFIsDA+bJcf2sdm2npEW55X24SohIkHizMYEdSWUHgXzxJFiV9Yq6ENW7DmJ+0X0W65wQ+1A8w7MQKUzVLBZtqKiAId1Uc2mao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgwZvM5c; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4dedcd1821eso127123e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 20:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715226514; x=1715831314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2kbdYwZr/StZkaW0rQUvJuzVp6hX8mt1IHQedQnonc=;
        b=ZgwZvM5cIeBXVKW4s4teiS+dzbYJY7TcIRzkYS0zngFXifahhZtz76eWeohyvLsPzP
         AN0gpiWoT/L5d2qn0PQrfDs35W7bc9HHHY4diHCXgDctzQbbowFCzi3iK/c/SAl1Vcxn
         3rRbViSmjBayiPnw3Lb/1GR2cC6UGQtpso1raclHvDh1cD9lmYvwMejnVqQpybe1jNaf
         6Ym4njJt3CEelXPiGnetYeKEOnQHUyJfdgDmFbSIagBKp97Uu1y2Kq8g54mftDTfKWZr
         YGf4FKhldwaXSF8jUR9Cz0PS389DMi+Q4/eN6K1egdIflvm3SOZV2Ce4SUgk12oC2MYw
         pPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715226514; x=1715831314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2kbdYwZr/StZkaW0rQUvJuzVp6hX8mt1IHQedQnonc=;
        b=UJtv8pllFFMCyBJ8BDo9Sc/RGJ6xBH90MPOaIKjj7coXpFFTnGf8Vw0PyS9XALB7/V
         qjpdiSlWAO3sjBh4hjE0obcDmfRbm+aXknScv54008siB/PbuYJIHcWChA7tgZFaPwEg
         Q1s0aNXND/lyH7EDS4pFIm/P+HHXzxGvv7R0xFd1jmCzHXY6hT5iGsWeX9ofsSyCQBiP
         nfD7gZWcindsLyrgeULp8DFBcXsV4UxZS5QR0fDdyW0fjYWex7x90vvkm/MYFLkAuixw
         tHqj0wsGITGPrKYfBr+dtm4nWo+9vlnn3Bfh4NX+fTih0UGa/Y6iqc0iGgFjmUbrIW1u
         XKHw==
X-Forwarded-Encrypted: i=1; AJvYcCUGE9b5/4nsIHxT7nGvfviGp0+zv0tnqhzCC2ek+noNPXHNtn+Mvv6jtSssAukERwUtTj1DknIqubR2+2FRwTk6/YwwQ1xpN2Eguj/P
X-Gm-Message-State: AOJu0Yzn+z7grvsEa5wVstNNqmtjpqNB9FNOd7+p7zkN6NlQiyxh2nRy
	51lcYgXh6OBRasW/yLFglzRZCpQn8A9OFJV/JZiKHcKB9bKvS3DY6f2KWe2HqLCVRjFn/zb4OBd
	qoSzjxJoJPYvBa7yRePw6zvnv7pg=
X-Google-Smtp-Source: AGHT+IFC/lgzjrVqZw+SleZf89wRJcsCNPreGa0RhO3+/VS3jdtugrLVI+7JH7JXPY94dD6KKU/3DGMnS1vtCndIKEQ=
X-Received: by 2002:a05:6122:3c8c:b0:4d8:690d:c02a with SMTP id
 71dfb90a1353d-4df69193916mr4166973e0c.6.1715226513923; Wed, 08 May 2024
 20:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <20240509033328.q2gwgaurpeg2mqqi@oppo.com>
In-Reply-To: <20240509033328.q2gwgaurpeg2mqqi@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 15:48:22 +1200
Message-ID: <CAGsJ_4xjaPfGPaPiAn69U1LoLZRPGAjCCd5iYajXhZh1qY8JBw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Hailong Liu <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:33=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> w=
rote:
>
> On Thu, 09. May 14:20, Barry Song wrote:
> > On Thu, May 9, 2024 at 12:58=E2=80=AFAM <hailong.liu@oppo.com> wrote:
> > >
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
> > >         __vmalloc_area_node()
> > >             vm_area_alloc_pages()
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
> > >         /* High-order pages or fallback path if "bulk" fails. */
> > >         while (nr_allocated < nr_pages) {
> > > -               if (fatal_signal_pending(current))
> > > +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(cur=
rent))
> > >                         break;
> >
> > why not !nofail ?
>
> if order =3D 0, nofail would not be set true in bulk allocator. in such a=
 case,
> it is still possible to break early
>
> >
> > This seems a correct fix, but it undermines the assumption made in
> > commit dd544141b9eb
> >  ("vmalloc: back off when the current task is OOM-killed")
> >
> > "
> >     This may trigger some hidden problems, when caller does not handle
> >     vmalloc failures, or when rollaback after failed vmalloc calls own
> >     vmallocs inside.  However all of these scenarios are incorrect: vma=
lloc
> >     does not guarantee successful allocation, it has never been called =
with
> >     __GFP_NOFAIL and threfore either should not be used for any rollbac=
ks or
> >     should handle such errors correctly and not lead to critical failur=
es.
> > "
> >
> > If a significant kvmalloc operation is performed with the NOFAIL flag, =
it risks
> > reverting the fix intended to address the OOM-killer issue in commit
> > dd544141b9eb.
> > Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>
> IMO, if we encounter this issue, it should be fixed by the
> caller, not here.

I agree. but could we WARN_ON a large kvmalloc(NOFAIL) allocation?

> >
>
> >
> > Thanks
> > Barry
>
> --
>
> Best Regards,
> Hailong.

