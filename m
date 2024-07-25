Return-Path: <linux-kernel+bounces-262036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0493BFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBACB1F21D52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A1198E9E;
	Thu, 25 Jul 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbS+sS++"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D91741F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902942; cv=none; b=jBlXIE9/ol+hLhzWOzJySwiz8XO1olC7X1RU5TOUUL4xCME9GAYbPSUqRCMty45YTyjlvkxPdaW1bQeDvtjAIOf4ps87fP7FYRELboHmQgoITuLwBDyXAQiusZDhcWyP+Arty5qbiR6K53p146fOFPZL6Q0MfQGud1gqMc/+ZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902942; c=relaxed/simple;
	bh=dMLCn18ig/M7lNewVyTQeUHg7Mhsc465/o9GBMv5XU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZ7hZnqLroRX+6eZbfyPiJrFk20iDFTvyPBsvSC1Jbbd2GeNefkXFB8ht8d0WYo1gHB/HCNZHNqRBc+BwMx4UMe/udMHBMe2a/8euWez/6wJwQj/yHcCpfZof3ra+gHRLspEBSQeVqMKftw8cgfJcfPbhKOWBg2/7zwQDYdDL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbS+sS++; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-492aae5fd78so270797137.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721902939; x=1722507739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35QGeM2NRB2w4L23NxDgGsutAUSkEkUeceaTp3ZD6A0=;
        b=SbS+sS++ouEihMeKttQ+QIEvAKUzvFJZLu/EiGfpoyEERplpyZFVkWSCRHTLCT+qhS
         yki462BtBOd5rkoZ2kOJdMP/cu45PpRHA2ISl4TLmyeAVb/vHw8nLD4UGBvVbg0q0lEs
         QFptAXBGPpdCt83M0f5N5VNZBM7F+HDV1DRjA6be8SOuXtS1YM1qEbSW+BFQLT40ARkK
         Om+IgXd0NK4kLWAqAXhXsN26mDFo5WA0zQVdWrGgPmdBMtDZU/zCva6DgRMWUAqrkL/r
         yvnrIc786TST7jdF3ohbERNSlFATP4WGLlMqy1cWDiv042kQcQfElRrj2EY4r3ch4Kxl
         I1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721902939; x=1722507739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35QGeM2NRB2w4L23NxDgGsutAUSkEkUeceaTp3ZD6A0=;
        b=adQ1cedtahmhyFOQOtUiD0w+a+vxZTfNGlGm0528RCBkspB2wMIA8UmSDnhWguEitw
         IivCF3SpPK6YvMBDni3YcJxyuIFEAl1Vea+hthbVC2iB/yr4lUpFPwe1O0vmi6PnTqjc
         Xf1VSPR0tUrRUi8vnw3APvlw0OrPkO3ejNN0H1WFimRWCLy9YRmvB6M+5jr7dXgWHlP7
         YNys7xh/ayw+byP8iaPgVltkP3ZT2BuxFfDZNcbVFqazMgbjETIeOwietf8jvn1hhsfr
         Fy1rjgB3VZnuks0Fa0b6C7eUavblxoxDav0VrbyOnApQcXiXaeLcQC29970arfzesXNL
         z2kA==
X-Forwarded-Encrypted: i=1; AJvYcCX4TpQ+3DPTfxnJCjV3z3d7KhGuD7mafH6vmA2CtocvZ7cZJXNdrRQYDCodyN6MsJplvg1qrHgU2hFDFTII5pLW1mxdNIwQGcKVnXbr
X-Gm-Message-State: AOJu0YzvESJs7XYz2o9y5JlF2TxW+MYpGpXaLD+Xgpi3jmaKn3/pe/op
	scPPf5aDP2oT7NM2CqxmVDSgAh+X/4Jwbt4peWj3M8y9Iu3gBgsjPTPzSMwC/nz7020paMW/Fnm
	qkJWI3sUSJENuKoww77tCKu7oCx9XGg==
X-Google-Smtp-Source: AGHT+IEppCQxMau/20PEfgL/M4nn3XnSgWPui12jXz2fSQKv4SEChYRQ1/3z7/r5WqMimhseS5enDe7l5pEigiYpZRk=
X-Received: by 2002:a05:6102:2b9c:b0:48f:eb5f:84d8 with SMTP id
 ada2fe7eead31-493d6540a10mr3588189137.27.1721902939321; Thu, 25 Jul 2024
 03:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com> <CAGsJ_4zWsh50Pzp0ntskT=eyfStALxD5BMNdWFrYJewrrx7V5Q@mail.gmail.com>
 <20240725091703.tsjpgltwgu3jwy5e@oppo.com> <CAGsJ_4xF2J=xxG1rVvFARJtVrvfrGAr7ZLtMCgp8obL6Q0TcMw@mail.gmail.com>
 <20240725095826.pqt4shyiw6odgcem@oppo.com>
In-Reply-To: <20240725095826.pqt4shyiw6odgcem@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 18:22:08 +0800
Message-ID: <CAGsJ_4yRJFEUrqxO0guv2kVUgj4aDSzvjkUimg9Bkn5ADNWJNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:58=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> On Thu, 25. Jul 21:34, Barry Song wrote:
> > On Thu, Jul 25, 2024 at 9:17=E2=80=AFPM Hailong Liu <hailong.liu@oppo.c=
om> wrote:
> > >
> > > On Thu, 25. Jul 18:21, Barry Song wrote:
> > > > On Thu, Jul 25, 2024 at 3:53=E2=80=AFPM <hailong.liu@oppo.com> wrot=
e:
> > > [snip]
> > > >
> > > > This is still incorrect because it undoes Michal's work. We also ne=
ed to break
> > > > the loop if (!nofail), which you're currently omitting.
> > >
> > > IIUC, the origin issue is to fix kvcalloc with __GFP_NOFAIL return NU=
LL.
> > > https://lore.kernel.org/all/ZAXynvdNqcI0f6Us@dhcp22.suse.cz/T/#u
> > > if we disable huge flag in kmalloc_node, the issue will be fixed.
> >
> > No, this just bypasses kvmalloc and doesn't solve the underlying issue.=
 Problems
> > can still be triggered by vmalloc_huge() even after the bypass. Once we
> > reorganize vmap_huge to support the combination of PMD and PTE
> > mapping, we should re-enable HUGE_VMAP for kvmalloc.
> Totally agree, This will take some time to support. As in [1] I prepare t=
o fix
> with a offset in page_private to indicate the location of fallback.
>
> >
> > I would consider dropping VM_ALLOW_HUGE_VMAP() for kvmalloc as
> > an short-term "optimization" to save memory rather than a long-term fix=
. This
> > 'optimization' is only valid until we reorganize HUGE_VMAP in a way
> > similar to THP. I mean, for a 2.1MB kvmalloc, we can map 2MB as PMD
> > and 0.1 as PTE.
> However this just fixed the kvmalloc_node, but for others who call
> vmalloc_huge(), the issue exits. so I remove the Michal's code. sorry for=
 this.

My proposal was to fallback to order-0 for __GFP_NOFAIL even before
vm_area_alloc_pages() as a short-term quick "fix".

We need to meet three conditions to do HUGE_VMAP
1. vmap_allow_huge
2. vm_flags & VM_ALLOW_HUGE_VMAP
3. !__GFP_NOFAIL gfp_flags

This is because if we fallback within vm_area_alloc_pages(), the
caller still expects
vm_area_alloc_pages() to return contiguous 2MB memory. By removing this
assumption from its callers, its caller will realize
vm_area_alloc_pages() is returning
small pages. That means, vm_area gets 0 as page_order from the first
beginning if we
have __GFP_NOFAIL in gfp_flags.

Other fixes appear to require significant changes to the source code
and can't be
done quickly.


>
> >
> > > >
> > > > To avoid reverting Michal's work, the simplest "fix" would be,
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index caf032f0bd69..0011ca30df1c 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3775,7 +3775,7 @@ void *__vmalloc_node_range_noprof(unsigned lo=
ng
> > > > size, unsigned long align,
> > > >                 return NULL;
> > > >         }
> > > >
> > > > -       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > > > +       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP) &
> > > > !(gfp_mask & __GFP_NOFAIL)) {
> > > >                 unsigned long size_per_node;
> > > >
> > > >                 /*
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20240724182827.nlgdckimtg2gwns5@=
oppo.com/
> > > > > 2.34.1
> > > >
> > > > Thanks
> > > > Barry
> > >
> > > --
> > > help you, help me,
> > > Hailong.
>
> --
> help you, help me,
> Hailong.

