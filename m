Return-Path: <linux-kernel+bounces-275636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED19487DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC51F23EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04935A7AA;
	Tue,  6 Aug 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fT2jd/UV"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72457CB6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913846; cv=none; b=SYKtkrQZMjLItw9+oCpNCCh8Fl5vJZnVWmuqrY3u2nAtr8d6ZEXx3xjl7Fx5vDf8P910wVpDX5YGlL/PX0WYitOpa9G96um5l4HDVtphbqV7466tHmDAF1VMwjo0HrFgOLE6rU4t4JCcpAisS1VgjhIOMn03gSnpFR8tdPovJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913846; c=relaxed/simple;
	bh=U4HEFD8CUVMLfWTgw9z7V6Ux1UCzXOA+F012FnD1b5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2nyCcUFTfnNAybWPmM9VdZaC/K2DqD/iD0E6qcWno8Qk4oQjnTgmQR5ZzThF1CEfoGIWeI7x1WahOIpH7QVgQEOWTCU5xxKfCXkDgX8rnDZtMIjO8530/lq3jt1T9XD4Y987yuhVzzzsSBbvKBhNOevsHuCKnNzMztB/dGsRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fT2jd/UV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb4b6ecb3dso208300a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722913844; x=1723518644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4HEFD8CUVMLfWTgw9z7V6Ux1UCzXOA+F012FnD1b5w=;
        b=fT2jd/UVWchKQB4APsPLTd75h6W6V9znAByLgY5fhPP5+saxBQBuiz01gNTmKN8rys
         lCfEKhRi8H66VTZaA1LxMvyJ0p1snVM2h8a6ch7lMyRfYGBI4r9pgpUiFsjXdHygpvJ4
         m8/Z0sjqLX+fCMKdHZFYeilDR51Xxo6BDJm7usyfTuDQiwCHMjf4vMhnADyYmezYO+m5
         2mhGMx1MoIpB7ZUUaiUSm2SDGLJ8qouwdD4w3W+Icm7xXY0h9Zm2+OUZk5Dp6WJWP7+0
         kcIkI5gAqYWvjE4IZ2k37S4N94VQzKe7U2G8yBdSIg435b/gZpw5mJAtnYflMpywYFuy
         X0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913844; x=1723518644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4HEFD8CUVMLfWTgw9z7V6Ux1UCzXOA+F012FnD1b5w=;
        b=br0D3RKUeexJXlTO1sXxBSAZBP0VQnCTRye1f+HhRsrCpbnCYovZq9J6OFksw3E6yV
         1QlavE/uO/L49Ov0FM/bP1ezbKQkfo/MFUt0fqNin73ehCqAJqnLy2Vtg4/9QnDr9gmw
         BKQ2q7NxjHjvOqagCLN7p2P1a7Mb5Giin5TShzt5iTTkWL4ftaBkeR/EoQvDCobghay8
         MwLErEoU8IX23ZxN2hj0XaYmf5/cQKCqPShC3HFRbSc6Iwi1r1Ha+w1J/T8IRLgqPNN4
         V2n0f7YItkpH42Oqi60uoHlp/Q06soZjHZf4wBrPEKshYb/FBkvCPU3e3csteqRp8rFJ
         zKbw==
X-Forwarded-Encrypted: i=1; AJvYcCUo7rfKVjHPbMw9mr4LMlbFWIITGsYEcec2or8BXQd1/PNwl3/9Zd6xs91/k0hacR6w3SiU8S4ab02XXkTj7wvB2TQDaf8r7ydAENHg
X-Gm-Message-State: AOJu0YxW7CgIeblozDKfLqbeBL1KghiYUu2h6iYtgTwAQj020nzP8Cg4
	623nmLvu/x9m5xDOOy9EJtReCI549UTBXpsDWIpi9SF4+t1wd5Edf1J03/4hwRwgCUTROme8osL
	DZoDevILxlJK/MQED46FlYVTHhud6ixZE7PIE
X-Google-Smtp-Source: AGHT+IHTYparmt/OTUThIPTlzIvOrqD9cz4WdKpTshz9lzOsNEUt309813jePKD3C5KsZ33asBZLz3EEOnXCpOLA/34=
X-Received: by 2002:a17:90a:680d:b0:2c9:a56b:8db6 with SMTP id
 98e67ed59e1d1-2cff9559125mr12349178a91.37.1722913843669; Mon, 05 Aug 2024
 20:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com> <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
In-Reply-To: <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 6 Aug 2024 11:10:32 +0800
Message-ID: <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > Barry said [1]:
> > > >
> > > > """
> > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > loop within non-sleepable contexts.
> > > > ""=E2=80=9C
> > > >
> > > > Unfortuantely, we do that under read lock. A possible way to fix th=
at
> > > > is to move the pages allocation out of the lock into the caller, bu=
t
> > > > having to allocate a huge number of pages and auxiliary page array
> > > > seems to be problematic as well per Tetsuon [2]:
> > > >
> > > > """
> > > > You should implement proper error handling instead of using
> > > > __GFP_NOFAIL if count can become large.
> > > > """
> > > >
> >
> > I think the problem is it's hard to do the error handling in
> > fops->release() currently.
>
> vduse_dev_dereg_umem() should be the same, it's very hard to allow it to =
fail.
>
> >
> > So can we temporarily hold the user page refcount, and release it when
> > vduse_dev_open()/vduse_domain_release() is executed. The kernel page
> > allocation and memcpy can be done in vduse_dev_open() which allows
> > some error handling.
>
> Just to make sure I understand this, the free is probably not the big
> issue but the allocation itself.
>

Yes, so defer the allocation might be a solution.

> And if we do the memcpy() in open(), it seems to be a subtle userspace
> noticeable change? (Or I don't get how copying in vduse_dev_open() can
> help here).
>

Maybe we don't need to do the copy in open(). We can hold the user
page refcount until the inflight I/O is completed. That means the
allocation of new kernel pages can be done in
vduse_domain_map_bounce_page() and the release of old user pages can
be done in vduse_domain_unmap_bounce_page(). Of course, we still have
a copy (old user page -> new user spage) if the daemon calls
vduse_dev_reg_umem() again.

Thanks,
Yongji

