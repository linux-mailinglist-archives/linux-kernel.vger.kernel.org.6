Return-Path: <linux-kernel+bounces-558381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB3CA5E512
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE21916DA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB81EBFF0;
	Wed, 12 Mar 2025 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlpGPeub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553D1EA7C8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810301; cv=none; b=jD23LsvCs0Lk2P9oxGq5aXISVedCeJo50oxL+Env4mL+7iwt24tXYb/hVsRdzrhk8PjUXwl+oaoc7t0Qj3VXc6xrWaBCnEo55Wl5u1kTnmFy2ZwbWauqpQUBRAQiSTNt7kH//QFr+us4Da9/XYcwps4j584Vhm6aKKrf6gUqBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810301; c=relaxed/simple;
	bh=nUvK5QSlWouoKts1hziqxpMybmXDATURg6I3GYwAYvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUwBTH0DVndGiQI0b61EDrFW6r/kTVdm3pN4jWCFkpQwhWLqgqzcmkFvjnBy2ZCujvpTp+eG/n7AqGWjn8+gFWo8SpU1oNc8NojsOeRcJXiMm2URBC7+jbuKpPBg5+cBh5zfIxCnc5BRKhEdxAZOhI1K2ITsTmzeE15/tLKHgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlpGPeub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
	b=RlpGPeubXh2/Btu0Ntl/+N0pDf75cmtkmxzBO+JfX7L6tqqwVC1CE7FsgRIf4631OMwLQI
	tTPYuYk+sa8NVB9D3UXS58RJD/ZzrR15lR9yaCNSvW1PvVALBuwDLwihAFP3BJTMD+A5fA
	fVDVEG8wzfSgB7GBclHDtvj+rMqDPWI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-LHWSqmrdMnCW-V6RZAiVrA-1; Wed, 12 Mar 2025 16:11:37 -0400
X-MC-Unique: LHWSqmrdMnCW-V6RZAiVrA-1
X-Mimecast-MFC-AGG-ID: LHWSqmrdMnCW-V6RZAiVrA_1741810297
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e549c458692so389284276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810297; x=1742415097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
        b=PCcflWXc5k85n1mCt3VbMtY6LpJFuNac4ScIPisv14D3Ng0E95Q7HFruKWI3E4zfPG
         p2Xz9TYGXuqfggm5L56iM0TDBpXc7VF5ukXqVFxDXGB4Pr+ET8vD4ZfJ0Bnn+q3nxoKr
         k4sBiUcQohGr79BPHtpe/P7zwzcjv8iWA9wEKojdEO1XWmy+mSXgQMlOA80EosCpyaX7
         ePfeWoVovtaS2xwEs/6bbvVjdHqtQXQAWWMcXggALvR+agdk2Et/KZWWWiq5A+Rpbvud
         oSFJLFPkJw42CP6Hkl0o5FL7tYjtzt0SVctYvXybCLDFrflhfxZrZs3AfV/9obEs3R9z
         H47w==
X-Forwarded-Encrypted: i=1; AJvYcCW7A2KB5rdTXUAWQ2bHxkhrkyfASXvpqT77YB/7i434CFe/E844EzoykZineTaXoYlcQ9rz6myUg3antkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZcCLor29Z2L/0xe+1ai0RbjAa6YbC3Znm0qhPPVe/8b7g6jO
	W8XzShnFCbkf3MVKq0C/W4PbUhmM3fbDgyLxJfYRfzyhbQkhzWEJTY1pqWd2pQau0P9TVQAmugN
	/KFcr6BQmt94C5BqoiPGG6+1JHiuiiW3yIK8Lfpu2yuie66edSfttokcg8c/AEP8YJOdIKuI5yj
	wfugOI5zHF1CmKpJ94wr8J0NWQk2QfysLTpGLw
X-Gm-Gg: ASbGncsclYrMBRn+Nw24h99so5E/bge4x4X8NoW+bIqq3RNWQsyQgC2upBcaSzKEqOf
	qRHwr15Ar3tHr5qXW4/249I8P1dFrJ2cCAJf4UGpb/MNZSMY7LiG73UTjQDa+j4rOcZF7PY1h30
	HJdY98xoAcmXA=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id 3f1490d57ef6-e6371cf7f99mr23022228276.19.1741810296830;
        Wed, 12 Mar 2025 13:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILEwS4y4Eu7CtZytQ1AMLlSYSOVDPPOZAL/URaaVOd4HXzYxT1BzN9xV4mLg1LOlVPDho5H2JPLVwRxAT/sw=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id
 3f1490d57ef6-e6371cf7f99mr23022141276.19.1741810296082; Wed, 12 Mar 2025
 13:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250312025607-mutt-send-email-mst@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:11:09 -0600
X-Gm-Features: AQ5f1JpCzw-OMEiWJ5oWmnRpNTzG9s0Jia2dTAgWmtQzoaspW3JJPq9uXITvZCU
Message-ID: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:57=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> > Update the NR_BALLOON_PAGES counter when pages are added to or
> > removed from the VMware balloon.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  drivers/misc/vmw_balloon.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > index c817d8c21641..2c70b08c6fb3 100644
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballo=
on *b,
> >
> >                       vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT=
_ALLOC,
> >                                                ctl->page_size);
> > +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_=
PAGES,
> > +                             vmballoon_page_in_frames(ctl->page_size))=
;
>
>
> same issue as virtio I think - this counts frames not pages.
I agree with the viritio issue since PAGE_SIZE can be larger than
VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
for each page. I fixed that one, thanks!

For the Vmware one, the code is littered with mentions of counting in
4k or 2M but as far as I can tell from looking at the code it actually
operates in PAGE_SIZE or PMD size chunks and this count would be
correct.
Perhaps I am missing something though.

>
> >               }
> >
> >               if (page) {
> > @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list=
_head *page_list,
> >       list_for_each_entry_safe(page, tmp, page_list, lru) {
> >               list_del(&page->lru);
> >               __free_pages(page, vmballoon_page_order(page_size));
> > +             mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > +                     -vmballoon_page_in_frames(page_size));
> >       }
> >
> >       if (n_pages)
> > @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b=
)
> >
> >               /* Update the balloon size */
> >               atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> > -
>
>
> unrelated change
Fixed, Thanks for reviewing!
>
> >               vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
> >                                           ctl.page_size);
> >
> > --
> > 2.48.1
>


