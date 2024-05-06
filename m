Return-Path: <linux-kernel+bounces-170227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB488BD3C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BF1C20328
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D14157494;
	Mon,  6 May 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNVL/gB+"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776315746B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016184; cv=none; b=ecS/tsfA+ORKtds4cVtvNIcEQfQFs3IHruKwliZpP0iHe5Pb+HjodOcujC5kY3Kb/lUQhC8F7du2209FWFlsYz6XTVOFD2sJt/PzC6zhbFX1Fvnj9U18hQAJZNYWx0RY4I8JmRnKUhSxM/+zj8fJ17Dxe4u3gJD9B7T5EowpZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016184; c=relaxed/simple;
	bh=WZrKW9lX4tg3tPxy5c0NpUNmhHAib2hOo3+Fq/V8re4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM+ClXZoKNKXySF1Lcr1ETxc5P33mkuwhOXflF7SJJwhAwmywtGJRftiKbiyqPUDGrUUv+1SWsybDtG+DgZT9xMwK+P5f5YdEunMItNnyr8fK0j7qe9OO6MIvMTPtTfmzuUMTv2SLrsWN1vQWXGQtmMUN6XNfL39m3KIHZ7tmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNVL/gB+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso2153992276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715016182; x=1715620982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCrwSzubKtvsGNfMW8E9OfepfV+lPFMQFEMiDBoSQgk=;
        b=VNVL/gB+Mg3B76MU83sheUjwbFvS4E1RgsoxRRe2uYyjNcfotwatf2tP1++SzDAj1Z
         /AP3O6W364YroxdCGCSumXiNeyK/oo58xm8wIe9mDqDKX8Hkn3m8ZoH+aLZdZ9b/N7es
         B4zjd//3VsudDXRd7OYirgWwdqHUjAii+mQf7RHE3/ARu20IPAa7OeNrsbYafLj3NjLK
         7IKQgCwKC7GsMlGuAWGW0M0caQj18NYeTL10cVaA6/Hv0yih2YDGxjpGDMEVwfa78tcn
         qba31ACO8v21Az56qrJDco3A0LTrew8Fd2D1HY7/uXL1xHRqMUA1yFuExSRrh7+BW2cp
         PJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016182; x=1715620982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCrwSzubKtvsGNfMW8E9OfepfV+lPFMQFEMiDBoSQgk=;
        b=wU8IUdhNb/J5Ox4gk9m3zH/oN9DfgUktnjkhP1cbGp93xsaeJspQRtckO/w3XAUiZ2
         qPYhY0oyeA+PWTx8skyl7OZqFagVeIfIXeBCZQMHiwO03ai8QapkT2f88yUg0oKF1ST4
         6x5AMPJLzlTXgGSy7Bv7HByTQcCcLzqTNf11b/0AZvEw7V7//aXBMbpoOsOs5H+0njtV
         9FicLnvJwM/gJgnG9N4gQrddepAaEB+j3lvf7N8dBUynQ0KFNDItKWIoUKK7w9g7syjL
         Ul3uGvzYbKkROt0KnniAp0bE9AQSaHvylh2pEuWMIrYsZhDaP4lch9hbEtb8n3GsXczq
         pf2w==
X-Forwarded-Encrypted: i=1; AJvYcCW1WxlcTtlcq0aHxV2tNM6gOSKQGai7JWTn+17sgMPCdtBArOYzKzHe2RBaxT5AlY1kUQa6d7lEaq/oGIBo/0bUU/AiRqHoU7Jc9961
X-Gm-Message-State: AOJu0YymZDa5h37/gWEXPjJusi+bZOXYe6mSdYRpWgVbwkWo49yCTcMN
	FRSHKzziCq1EcEYGFHDefE9WFDkt9yGMBb4zuQurVtNCHEDVu9bq2vcxLvA4q0ntHIctNNGZYcM
	SdukqUme5HKmvL8vEqxKXD61ats1SPsQrtQ0T
X-Google-Smtp-Source: AGHT+IFF+xrCiZxZzYs8KepraXuOLw4ukSfLThnPpCCYdtURoAqdQvuK/9ekO9RvFnQzQ2yuIw0Z6Hw7T7hUsdyFDBA=
X-Received: by 2002:a05:6902:2747:b0:dc7:465d:c06d with SMTP id
 ea7-20020a056902274700b00dc7465dc06dmr12341901ybb.28.1715016182087; Mon, 06
 May 2024 10:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183527.1548119-1-tjmercier@google.com> <20240504101651.7de5106f@meshulam.tesarici.cz>
In-Reply-To: <20240504101651.7de5106f@meshulam.tesarici.cz>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 10:22:50 -0700
Message-ID: <CABdmKX06v23-w8PQJab8kgfPDRYLU3bQSQ4AsC3zrzxYL955gQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only to dma-direct
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, hch@infradead.org, robin.murphy@arm.com, joro@8bytes.org, 
	will@kernel.org, akpm@linux-foundation.org, isaacmanjarres@google.com, 
	iommu@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 1:16=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Fri,  3 May 2024 18:35:26 +0000
> "T.J. Mercier" <tjmercier@google.com> wrote:
>
> > IOMMU implementations now sometimes bounce memory through SWIOTLB to
> > achieve cacheline alignment [1], or prevent DMA attacks by untrusted
> > devices [2]. These uses of SWIOTLB differ conceptually from historical
> > use which was a solution to the problem of device addressing
> > limitations that prevent DMA to some portion of system memory
> > (typically beyond 4 GiB). IOMMUs also solve the problem of device
> > addressing limitations and therefore eliminate the need for SWIOTLB for
> > that purpose. However as mentioned, IOMMUs can use SWIOTLB for other
> > purposes.
> >
> > The swiotlb kernel command line parameter does not impact IOMMU related
> > use of SWIOTLB, and that is intentional. IOMMUs cannot be forced to use
> > SWIOTLB for all buffers. Update the documentation for the swiotlb
> > parameter to clarify that SWIOTLB use can only be forced in scenarios
> > where an IOMMU is not involved.
> >
> > [1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marina=
s@arm.com
> > [2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.i=
ntel.com/
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 1 +
> >  Documentation/arch/x86/x86_64/boot-options.rst  | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 213d0719e2b7..84c582ac246c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6486,6 +6486,7 @@
> >                                to a power of 2.
> >                       force -- force using of bounce buffers even if th=
ey
> >                                wouldn't be automatically used by the ke=
rnel
> > +                              where a hardware IOMMU is not involved
> >                       noforce -- Never use bounce buffers (for debuggin=
g)
> >
> >       switches=3D       [HW,M68k,EARLY]
>
> Yes, this part is correct. SWIOTLB cannot be forced if there is an IOMMU.
>
> > diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documenta=
tion/arch/x86/x86_64/boot-options.rst
> > index 137432d34109..066b4bc81583 100644
> > --- a/Documentation/arch/x86/x86_64/boot-options.rst
> > +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> > @@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART hardwar=
e IOMMU:
> >        Always panic when IOMMU overflows.
> >
> >  iommu options only relevant to the software bounce buffering (SWIOTLB)=
 IOMMU
> > -implementation:
> > +implementation where a hardware IOMMU is not involved:
> >
> >      swiotlb=3D<slots>[,force,noforce]
> >        <slots>
>
> But this part needs some improvement. The "swiotlb" option is not
> entirely ignored if there is a hardware IOMMU. For example, the size of
> the SWIOTLB can be adjusted using "swiotlb=3D<slots>", and since SWIOTLB
> can be used by IOMMUs for other purposes (as you correctly note in the
> commit message), this setting is relevant even where a hardware IOMMU
> is involved.
>
> Petr T

Thanks. I think I should also update the commit message:
"The swiotlb=3Dforce kernel command line parameter does not impact IOMMU
related use of SWIOTLB"
and title:
"Clarify swiotlb=3Dforce option applies only to dma-direct"

As for fixing boot-options.txt, I think it makes the most sense to
expand on just the force option rather than the section summary like
above:
       force
         Force all IO through the software TLB.
+        Hardware IOMMU implementations can use SWIOTLB bounce buffering in
+        some circumstances, but they cannot be forced to always use them, =
so
+        this option only has an effect when no hardware IOMMU is involved.
       noforce

