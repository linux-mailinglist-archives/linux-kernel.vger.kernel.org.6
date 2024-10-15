Return-Path: <linux-kernel+bounces-366434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CB99F546
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AF01F25053
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780622911B;
	Tue, 15 Oct 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNTRTKPY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076B22911A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016860; cv=none; b=rElP7FWcNHOrpd+JPdvdTEA259Jb//zKkuz8XHDA80W2FMvXU68HPfqfYyDpM2g9UwfnKMkB/xDOauFEAeNTTZhXQHYFGufITYS9+/DxHCTp97bPXPCd847b6hb2Jc88j/xat5a0u3A4abQp1TLNCDThKtu6uWjo0CigjMFy5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016860; c=relaxed/simple;
	bh=7P5eDtewB/XXvdIouhuiVrA5JcIwFJRwjUeMhlF9l9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8ACOesXR/QCUAAPXlEiAXo8lLp6rCMVmssKrofQvUpchku/NKh+Oeclv9mYmbqE4jz2yW7JmUWq8qeB3X/GwlrojDsgB6gzriBkc+DBEoKKvLwZMsd98yxXwefrayNM0mBqcYqWUkeAqPvn+1qnE8vZBx89UD5f/zhd35eZ1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNTRTKPY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso52866a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016857; x=1729621657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0XGeskGBljrZ3o31WnXq6th/S7en+muGJ/z0yASC/c=;
        b=WNTRTKPYFIpRuwNY1DpLWfDDWo0pvvytPyV+2mJOChElnm0iXKKwaEiR5n76yR4f0J
         5mdfTlC4bsIN69mAn1kKUJp2aW7Yop+1RS3Se3dUoFGKWRiDhV+qDiQAOEEJ2IRcL2AX
         wUXCw4pJP9Ie3D6MycCe6MCPFSnJaJ6E60n4iCrtdOSFYx8pw6YPETp7Bj9KYwIdnkkE
         T19Njl3nCxKRwXdZ3xDMjE9xRrPGElzPkbZTJXMsb1+URsBvLoR8F93XiAWbMb1pHVJi
         +gorPnsEKuXGoymP3Nhxin06dThzmtNEIgSvLNRfvDdEagXVzPHJi8WRWdbXjqcoM8OR
         BjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016857; x=1729621657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0XGeskGBljrZ3o31WnXq6th/S7en+muGJ/z0yASC/c=;
        b=aK+itNUUH+OwEEsrwFqgjhM2m6K+A+ymUVQTMeovx/XPoPJgnMoQdYJGSW0TewEMwp
         p3zfiCzkZSqzZWAIOF4ft4HcqM/Yv9L+QQlaYxLwfFigT2Z9j8tJ//QXc0HjrD0y93qp
         ol49fizPvhXBYVFn2B4snkGlLEWRmuKO1m+R/aH/h/ddJ5pUT/YuKyVcOnfElso6t2lY
         g2wdrMC8GvxgDvbng7Z+EUZF4zayKxgQ6y4BUzEUwDogPMxRiN0nYTNmMnQ18NjGQ9ug
         ZHqJx1yTEJejgGvHrxJXZ9Dy2nQC2zRrRXBCIjgP2nFcH1XCOCctgfRkIVWsem8rBfm6
         coTg==
X-Forwarded-Encrypted: i=1; AJvYcCUliRHxtmZ6Ao+h914d5k+v7wtRqwC1pd/9tXEBzgAAVSfAddl0b8Bm3n/073ST62o/7k5Uow2s8UYSOtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZr/3wDSKhM8GscnCYtu0RKJ77l9MjSG9NTrOtgTj5iR9fzK63
	Hs5WKkWDo7xK4UUO2akgweB/WULqlqmeRWLmUlYwwYALmj0w4LB7YSzDRQ0nFTq9d3yrWyeIAgd
	XRQf4vqwfWbLHEF3zK1KlQ0BoPVzhyWX2+tF2w1X6AaJRkV6o87mATts=
X-Google-Smtp-Source: AGHT+IG4vFTd1o5zCc770+Uz/qc/CsRimYoCsoJN/cKl8KhAFmwiLaJcjOltJw+t0AxqekveFNe7U+xaHEYwjMReqAE=
X-Received: by 2002:a05:6402:35c3:b0:5c5:c44d:484e with SMTP id
 4fb4d7f45d1cf-5c997ab0ca9mr35635a12.1.1729016856288; Tue, 15 Oct 2024
 11:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-comedi-tlb-v1-1-4b699144b438@google.com> <4f531d06-9802-4086-8463-db4c9b6ba11c@mev.co.uk>
In-Reply-To: <4f531d06-9802-4086-8463-db4c9b6ba11c@mev.co.uk>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Oct 2024 20:26:58 +0200
Message-ID: <CAG48ez2_86QrYnDe5xKxbngqF7OBQ3=HDF55bDP0hKvbasNCQQ@mail.gmail.com>
Subject: Re: [PATCH] comedi: Flush partial mappings in error case
To: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:19=E2=80=AFPM Ian Abbott <abbotti@mev.co.uk> wro=
te:
> On 14/10/2024 21:50, Jann Horn wrote:
> > If some remap_pfn_range() calls succeeded before one failed, we still h=
ave
> > buffer pages mapped into the userspace page tables when we drop the buf=
fer
> > reference with comedi_buf_map_put(bm). The userspace mappings are only
> > cleaned up later in the mmap error path.
> >
> > Fix it by explicitly flushing all mappings in our VMA on the comedi_mma=
p()
> > error path.
> >
> > See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around=
 in
> > error case").
> >
> > Cc: stable@vger.kernel.org
>
> Your patched version won't compile before 6.1 so you may want to
> indicate that in the Cc line.

Ah, thanks for pointing that out - I can just use zap_vma_ptes()
instead, which is available in older kernels, that way it will be more
concise and the backport will be easier.

> > Fixes: ed9eccbe8970 ("Staging: add comedi core")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Note: compile-tested only; I don't actually have comedi hardware, and I
> > don't know anything about comedi.
> > ---
> >   drivers/comedi/comedi_fops.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.=
c
> > index 1b481731df96..0e573df8646f 100644
> > --- a/drivers/comedi/comedi_fops.c
> > +++ b/drivers/comedi/comedi_fops.c
> > @@ -2414,6 +2414,15 @@ static int comedi_mmap(struct file *file, struct=
 vm_area_struct *vma)
> >               vma->vm_private_data =3D bm;
> >
> >               vma->vm_ops->open(vma);
> > +     } else {
> > +             /*
> > +              * Leaving behind a partial mapping of a buffer we're abo=
ut to
> > +              * drop is unsafe, see remap_pfn_range_notrack().
> > +              * We need to zap the range here ourselves instead of rel=
ying
> > +              * on the automatic zapping in remap_pfn_range() because =
we call
> > +              * remap_pfn_range() in a loop.
> > +              */
> > +             zap_page_range_single(vma, vma->vm_start, size, NULL);
> >       }
> >
> >   done:
> >
> > ---
> > base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> > change-id: 20241014-comedi-tlb-400246505961
>
> I guess this doesn't need to be done for the path that calls
> dma_mmap_coherent() since that does not do any range splitting. Would it
> be better to move it into the branch that calls remap_pfn_range() in a lo=
op?

Sure, I'll move it up into the branch.

> Note that I have no commit access to pulled-from repositories.  Greg-KH
> usually commits them on one of his repos, so could you Cc him too?  Thank=
s.

Ack, will do.

