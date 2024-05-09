Return-Path: <linux-kernel+bounces-174312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE58C0CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45E8B22701
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428F14A0A3;
	Thu,  9 May 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkUeArbY"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BAA14A09D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245035; cv=none; b=YBJbKtLg+tD5j1G4wpq82B3zcwGD0yFtBEaZysx7wIDBjZGIvJFuoyN7BBUSxUdJzvIwsEYOwPQk6mDHjo0GK3lXJa4VoSZ7kdw2lHsyxW0zc9JoKtP4PLusIhkeom6wniDcEuj/EcoUBpZYHPmlfRRP3WRz9achOnhHd2bCnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245035; c=relaxed/simple;
	bh=zmrIhCP7JxRQY/Beh0wu2cp0ImuYtIcEh7ZxUNRpu8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQH+IzarrWV06/Fcff+Cy5diuMxcXY7P7H4zyAEXAXDU+Tw94BAjgrpZj0G7VvZF4M0ZFDvreXFUcV87+6//5lY9NTGiw8FZxdKCuMwe4iTnvBM6gu8f7FP4LKwKe02hBkOE2ibO3MT1b+0OjBcj6hYE9LT2YhhxTh1dE8RcQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkUeArbY; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7f170dc5f70so227064241.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715245033; x=1715849833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfKhm+2hvPQl8Oso+dQHqxM5T+rG2L/B/sQ5bPGSyGY=;
        b=DkUeArbY3sPRoJw2MYj9kp3ZmXybLXh6Qv4jMVWbkgTFWCGhGyp8Z+1/Vd09Bhh78P
         Td10qhS/EV04sw0dHKDPtupti+eCHvClcddEB9mz/Ec/aZ35I08RboykpQPrgcm8ryYm
         vIkEIxuJnu8O/bYJgaO7cIna9L56ac1BnC3DsQm2rhjmyPCJvkcyLsbeDNMK3xr2V8RW
         iWjaCzZByodL0Mp2ibIScb9qc5AvlCXF6MP0zJb1IO2ICRRBXVBdFvBch4RdOoRQeGot
         sSLKBHgzJPUqW/XRBeAM+vvL3RL7UmACh5xQ1ABmW8yyd3qM2vIqzM8r4gyPe08OMNiZ
         iJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245033; x=1715849833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfKhm+2hvPQl8Oso+dQHqxM5T+rG2L/B/sQ5bPGSyGY=;
        b=qT0t1ys9qTrbwPhRN8/r027eegc7aw7BDX93OzH2sBuV+GgaSPNrhIcIq2WOK7l1Zs
         r1tTxzU5m8dQGL2Lyw16208uDupJ35MtGHvs62otO7WFeNQ5levQBET8oKlBhCq6sZpT
         FVdzD2PhMh7P7mIRTacaRcvnwg+BqpH9W0gpDgWYDUDJuCSkfS1DkEQqgv5jqdfqNli3
         l2pfTs0G/5JoK4KX7CluPwG5PIJv4d+yxch0xDlVSf3P2MIpLw5nOqGOg1S0aJXMuUAQ
         cRClz8dtSvsnqsDgWMM5HsWtL80Xr3mYC2br6VE+qUOIO1Q6YUmSDdfQqbw54Hn6sMZY
         L47Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8cNOClPPZucQ4bpwNq6aRu4uvjQ8Fs72BiaUUI9+OtFCdkPbzwmUgqd55yViyLTkplzYiiNOFcAZYjUf59Zp2iwO6AWzPd/Wzcok0
X-Gm-Message-State: AOJu0YxJYJue61hkPvA0l0FmfS86q7VpYLTFSIT5JtiEAg0Tx9evnu1D
	tq0bIimYR/+7VDDiCfTRnDTkEJE10Cb0MRFsWYh2+dO1bx7ryY6ekajSqCBdMGyI9E1iFfk6igS
	S5WPj+3h0YGi+PUarXQ1of4cw56k=
X-Google-Smtp-Source: AGHT+IFYUDF9N+GGbD4pPAwt0Qso0dyrFmiNKcjQMb09BOpKvCTUFL9zPSEJaYJ38fr6aytRinvJmqD7kfFiAp1NNPg=
X-Received: by 2002:a05:6102:345:b0:47e:f593:2b8a with SMTP id
 ada2fe7eead31-47f3c38ff83mr4773563137.24.1715245032831; Thu, 09 May 2024
 01:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <Zjx_6F3Fti_EBD_e@tiehlicka>
 <20240509080636.bauxbgpqdluzpein@oppo.com> <CAGsJ_4wLF2+O2ydr8EvPqgrsOPsWStUxpzRvi3rJpktU_FSP1w@mail.gmail.com>
In-Reply-To: <CAGsJ_4wLF2+O2ydr8EvPqgrsOPsWStUxpzRvi3rJpktU_FSP1w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 20:57:00 +1200
Message-ID: <CAGsJ_4xqg7+xwsbXpU1yp_HkTBcpJwRN-ErEwzOZx915hgsyrQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org, 
	Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:32=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, May 9, 2024 at 8:21=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com>=
 wrote:
> >
> > On Thu, 09. May 09:48, Michal Hocko wrote:
> > > On Wed 08-05-24 20:58:08, hailong.liu@oppo.com wrote:
> > > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > > >
> > > > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmallo=
c")
> > > > includes support for __GFP_NOFAIL, but it presents a conflict with
> > > > commit dd544141b9eb ("vmalloc: back off when the current task is
> > > > OOM-killed"). A possible scenario is as belows:
> > > >
> > > > process-a
> > > > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> > > >     __vmalloc_node_range()
> > > >     __vmalloc_area_node()
> > > >         vm_area_alloc_pages()
> > > >             --> oom-killer send SIGKILL to process-a
> > > >             if (fatal_signal_pending(current)) break;
> > > > --> return NULL;
> > > >
> > > > to fix this, do not check fatal_signal_pending() in vm_area_alloc_p=
ages()
> > > > if __GFP_NOFAIL set.
> > > >
> > > > Reported-by: Oven <liyangouwen1@oppo.com>
> > > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > > > ---
> > > >  mm/vmalloc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 6641be0ca80b..2f359d08bf8d 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > > >
> > > >     /* High-order pages or fallback path if "bulk" fails. */
> > > >     while (nr_allocated < nr_pages) {
> > > > -           if (fatal_signal_pending(current))
> > > > +           if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(curre=
nt))
> > >
> > > Use nofail instead of gfp & __GFP_NOFAIL.
> > >
> > > Other than that looks good to me. After that is fixed, please feel fr=
ee
> > > to add Acked-by: Michal Hocko <mhocko@suse.com>
> > >
> > > I believe this should also have Fixes: 9376130c390a ("mm/vmalloc: add=
 support for __GFP_NOFAIL")
> > > --
> > > Michal Hocko
> > > SUSE Labs
> >
> > Thanks for the review and the Ack!
> >
> > Add Fixes in V2 patch.
> >
> > IIUC, nofail could not used for this case.
> >
> >         /*
> >          * For order-0 pages we make use of bulk allocator, if
> >          * the page array is partly or not at all populated due
> >          * to fails, fallback to a single page allocator that is
> >          * more permissive.
> >          */
> >         if (!order) {
> >                 /* bulk allocator doesn't support nofail req. officiall=
y */
> >                 xxx
> > -> nofail =3D false;
>
> isn't it another bug that needs a fix?

Upon further examination, it's not a bug, but we can still utilize 'nofail'=
.
The current code is very hard to read about gfp and "nofail" :-)

maybe:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6641be0ca80b..7c66fe16c2ad 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3498,7 +3498,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 {
        unsigned int nr_allocated =3D 0;
        gfp_t alloc_gfp =3D gfp;
-       bool nofail =3D false;
+       bool nofail =3D !!(gfp & __GFP_NOFAIL);
        struct page *page;
        int i;

@@ -3555,7 +3555,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
                 * and compaction etc.
                 */
                alloc_gfp &=3D ~__GFP_NOFAIL;
-               nofail =3D true;
        }

        /* High-order pages or fallback path if "bulk" fails. */

>
> >         } else if (gfp & __GFP_NOFAIL) {
> >                 /*
> >                  * Higher order nofail allocations are really expensive=
 and
> >                  * potentially dangerous (pre-mature OOM, disruptive re=
claim
> >                  * and compaction etc.
> >                  */
> >                 alloc_gfp &=3D ~__GFP_NOFAIL;
> >                 nofail =3D true;
> >         }
> >
> >         /* High-order pages or fallback path if "bulk" fails. */
> >         while (nr_allocated < nr_pages) {
> >
> > -> nofail is false here if bulk allocator fails.
> >                 if (fatal_signal_pending(current))
> >                         break;
> >
> > --
> >
> > Best Regards,
> > Hailong.

