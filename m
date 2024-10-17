Return-Path: <linux-kernel+bounces-370578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C19A2F16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582061F22ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25B2281CA;
	Thu, 17 Oct 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U61jhv/B"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659D1DF26C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198656; cv=none; b=D8okBOgIW+TFhSssyoC0YqTnRHDw3cZvLLz0ZwBc85CxzEv6mJUjMy0cB1maPSV297C4Bb1J9N1rcRfdaBcH0HXWC1abBRj/7UnEq3CWT7FktgI0WizF0YMFsJn+GNKjCxxfxplu/dgs2HtmuUGMhbatmruzA674701HVs2RSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198656; c=relaxed/simple;
	bh=/F6YSLte3edSGWFheOgCWVPP3+prQu0BiAqqVtVwz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+wxnhnoWa/e6VsmdhwoRZG8up6tzlAzWe5FZynAQk6hLH2rY8djjMTqR/RTIlg92nXX4VlBIhCpYlpQD+IGEEytU8BdWZ1vfNVyzpTObgZ749VQcVBnt9DxQ1dSeB81nmg/vKpIB/qC9yXCd/jdB2yjEMh/z9rK8AgxkMseH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U61jhv/B; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2888bcc0f15so186040fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729198653; x=1729803453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F6YSLte3edSGWFheOgCWVPP3+prQu0BiAqqVtVwz34=;
        b=U61jhv/BL2stVyitQBLV730XQP3c6I70twh+RVuNGBrNXweE0RHsrAb4hFMDs8zPK6
         d44C/EbNr95Y0n8C28mhVhsdBEju0+kI+VuOmHOpYh2dpYd5abdhEyjkjCvj/QZb4uvu
         3BahPcxTxsiwo8i56OTsZ8ekIoY+/wBpfErbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198653; x=1729803453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F6YSLte3edSGWFheOgCWVPP3+prQu0BiAqqVtVwz34=;
        b=kCInAwEOudQO+8lnHhQh7yhR9o97SHFM9jT2zAcWhINLShFZDCrSNJpuXJG5ib3ody
         yDPcoQSG6saqmQmJBnjC6+Y2kBE4+wc4vUqMpIeGZ5jBYbURmb6LAdDpr7e7f29s50wV
         dA2YC6wvtAAiTcwYaS8vnodXdXvfL0IW1iOeDDD/28zuxa7ksmD1EdJuRsrXD0ImyBev
         JrgusK20WMySwAZ1TdUh/AlP+pDjRaVrllXdkU/fRlZ67SMmRlc884hVbwtiZJJZlpUg
         BS14ra/Ym+MUZQ7YJ5Ir1OYRBPrh8WpomaTbwfvixVv6BjlfNifFdhhnlGrz9qd7Ysn7
         uJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5R+y7ukGcUE/9ifc06Cz4vVlabfkt9Oxru8wZ90E9BMw5KxaWQn/2tJCdpfMal6lpDdhI02ejlhs3oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUcKACOghTvofW18FHVh5rEDygWqh4g7Nx2b5Z/jMd1PQenBG
	im8fSui6uexfxMrqOKBCKdw3YQYSUaDbqmfhjw+uhZ8wHsTHFSnOCmjib3I7zbP9/kDIssXrWKA
	SwHj+RVLuqAfbrY7YGH+8U/HjUMikVxV1Btt3
X-Google-Smtp-Source: AGHT+IHHUuQFxa/zQxSDrqiQJJZOsss48H0nptMvzFPNY8+qKBTv0db1Iu/UCYTZHYAYX2E0/f1IhYkLDQtjkPBNtko=
X-Received: by 2002:a05:6871:3a12:b0:27b:56b1:9ded with SMTP id
 586e51a60fabf-2892c2df315mr63608fac.5.1729198653583; Thu, 17 Oct 2024
 13:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017005105.3047458-1-jeffxu@chromium.org> <20241017005105.3047458-2-jeffxu@chromium.org>
 <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
 <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com> <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
In-Reply-To: <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 13:57:21 -0700
Message-ID: <CABi2SkXArA+yfodoOxDbTTOpWCbU5Ce1p1HadSo0=CL23K4-dQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:49=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Oct 17, 2024 at 01:34:53PM -0700, Jeff Xu wrote:
> > Hi Pedro
> >
> > On Thu, Oct 17, 2024 at 12:37=E2=80=AFPM Pedro Falcato <pedro.falcato@g=
mail.com> wrote:
> > >
> > > > For PROT_NONE mappings, the previous blocking of
> > > > madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibi=
ts
> > > > memory access, madvise(MADV_DONTNEED) should be allowed to proceed =
in
> > > > order to free the page.
> > >
> > > I don't get it. Is there an actual use case for this?
> > >
> > Sealing should not over-blocking API that it can allow to pass without
> > security concern, this is a case in that principle.
>
> Well, making the interface simple is also important. OpenBSD's mimmutable=
()
> doesn't do any of this and it Just Works(tm)...
>
> >
> > There is a user case for this as well: to seal NX stack on android,
> > Android uses PROT_NONE/madvise to set up a guide page to prevent stack
> > run over boundary. So we need to let madvise to pass.
>
> And you need to MADV_DONTNEED this guard page?
>
Yes.

> >
> > > > For file-backed, private, read-only memory mappings, we previously =
did
> > > > not block the madvise(MADV_DONTNEED). This was based on
> > > > the assumption that the memory's content, being file-backed, could =
be
> > > > retrieved from the file if accessed again. However, this assumption
> > > > failed to consider scenarios where a mapping is initially created a=
s
> > > > read-write, modified, and subsequently changed to read-only. The ne=
wly
> > > > introduced VM_WASWRITE flag addresses this oversight.
> > >
> > > We *do not* need this. It's sufficient to just block discard operatio=
ns on read-only
> > > private mappings.
> > I think you meant blocking madvise(MADV_DONTNEED) on all read-only
> > private file-backed mappings.
> >
> > I considered that option, but there is a use case for madvise on those
> > mappings that never get modified.
> >
> > Apps can use that to free up RAM. e.g. Considering read-only .text
> > section, which never gets modified, madvise( MADV_DONTNEED) can free
> > up RAM when memory is in-stress, memory will be reclaimed from a
> > backed-file on next read access. Therefore we can't just block all
> > read-only private file-backed mapping, only those that really need to,
> > such as mapping changed from rw=3D>r (what you described)
>
> Does anyone actually do this? If so, why? WHYYYY?
>
This is a legit use case, I can't argue that it isn't.

> The kernel's page reclaim logic should be perfectly cromulent. Please don=
't do this.
> MADV_DONTNEED will also not free any pages if those are shared (rather th=
ey'll just be unmapped).
>
> If we really need to do this, I'd maybe suggest walking through page tabl=
es, looking for
> anon ptes or swap ptes (maybe inside the actual zap code?). But I would r=
eally prefer if we
> didn't need to do this.
>
I also considered this route, but it is too complicated. The
copy-on-write pages can be put into a swap file, also there is a huge
page to consider, etc, The complication makes it really difficult to
code it right, also scanning those pages on per VMA level will require
lock and also impact performance.


> --
> Pedro

