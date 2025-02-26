Return-Path: <linux-kernel+bounces-534515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B41A467C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA677A1F49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59C2248B4;
	Wed, 26 Feb 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="byXE6yyU"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0421CC79
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590244; cv=none; b=HHOMSCJNTP7DRN/EWg19gn+wTbKvbqTZlkE0lUNSruHaNrQXwirYqxoSTyCKPJ2f4W+wrP3W1ZTij/axAOyv+V2tQVFd92ZFAD6+JULPuzF01A2HdXCmccDfBMDGhajyfn4FiUCU0SS6jtRr/f6cFedEbonQUiZ62VhYsI5G3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590244; c=relaxed/simple;
	bh=MJbYFWFkAR+EfKDyS6iZ1oNNVh5vDqYiyywcAm87DHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jkO/ShlMqvPWc+ggi9rgElTxTc5pTNwfiXBIpIoqSS0ZsYpssmpxprZ6X60UFJxdM5ZPkpEb1LP99yoPaIgPswj21PO9Q2N3kabJJjCJwRVU1z4O9D7/+cq+gbmk56eCRjzmi7ZoZhRMRcIzc8gRryCl0vGMhWfpkXJg05RDjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=byXE6yyU; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72755fc91d9so601574a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740590242; x=1741195042; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3KO84anUnmKTrv3jqEjVpEjsPZO/Jbwk39A8x7cWXQ=;
        b=byXE6yyUJ+BvoQps0572J0WjD2NWMjlsZC2OZjc23YWmBXEcayhE8HKl0z/e+Tr8g1
         UnknQASV0ScEyhjiZ/XNaKH8F/SYXvWuS4ekHZBoeu3YMf+S//Jkqgf6HQ5eU5/0hV4b
         UQrZxmRKCgnDtGk3V1gu0nVVMPDargVH3F6Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590242; x=1741195042;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3KO84anUnmKTrv3jqEjVpEjsPZO/Jbwk39A8x7cWXQ=;
        b=A6jnw1/KfUI2XSGg6a03UU/3iC7DZ4VSPqZdeXe3pEAtrtSxdYv3/P1dg65dA2rAlf
         ezlAm0FLRJvbdpCj2qpdgje8dyH18fr+q1nKKSKbySdC3KDun9yRSKqkfzpBTr0Nw6Pp
         Fn3F+VXaETSA0jJC9IFdES2fSNIB16iMZX+NF3z2MHJl1fqG+7M667WbC0FsepBohBR5
         0WnF8rrVtBAFctqoHZiYiK7J8ja+ey/FdecO5m9N5xair8jbsvFt4ypHKvCnZ1zRrS8q
         5LIkFP5ZWt94JWSXMWqnPxVB2QcyrdtEQqKNHWd4eF+dRJfLeyL2UyBr3iMpgyALfjT4
         FjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW628bJCg8n8jFloFp9fiHy5AJgjbJVs/qSRfAdgRR0pkmi6yFbg/w74jRpGEXQq1zje/FvhepvziS5U5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wYXAl0cvGnr8kRNMc3IjvXzOKwkG+Nn3tpGIOgJ9FY8TR68C
	OCYnxcZoqSZQpyibKTSJLFHaAzoAhlC6Ql7b7fGq/V5iBEwTRrO7/n9d5gcMSY8pLLdxU8PChZO
	BnHgMlmJOUCd+3REg3VM8tfmaenz+LIunYga4
X-Gm-Gg: ASbGncvIdZ9N4ci4f/j4JTPNaAi5o0jhs9gSsetkB25xDQ87NqlkW+iQveRfVrq/Z59
	JWCxpPrVo/gw4Otl5y61ZTSSUH7wL/HAdSJ1EuoUgiQ/4+FOJrS1XLvJ9js9mnRL4hHu+FpWHh8
	tQTFtzKog=
X-Google-Smtp-Source: AGHT+IEl2EDbG9u5ILAtanAIm0mTUyqIM9Ntd3T2NX5/6VfFM53xNzN8hXgARNQiVlyNgTzogTh4ECQvmcondAgTChA=
X-Received: by 2002:a05:6830:2693:b0:727:25d0:7f45 with SMTP id
 46e09a7af769-7274c0b5017mr5459303a34.0.1740590242451; Wed, 26 Feb 2025
 09:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local> <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local> <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
In-Reply-To: <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 26 Feb 2025 09:17:10 -0800
X-Gm-Features: AQ5f1JqJf9n4Unmz6uj_lnvCtH51CFyB4M8cqMKOxzhVNsJkXQyDA1ITrfYaz_4
Message-ID: <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:12=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> > On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > > On Mon, Feb 24, 2025 at 10:20=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote=
:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, coveri=
ng
> > > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > > >
> > > > > Production release testing passes on Android and Chrome OS.
> > > >
> > > > This is pretty limited (yes yes I know android is massive etc. but =
we must
> > > > account for all the weird and wonderful arm64 devices out there in =
context of
> > > > upstream :)
> > > >
> > > > Have you looking through all arm64-code relating to vdso, vvar, com=
pat-mode
> > > > vectors, sigpage mapping and ensured nothing kernel-side relies upo=
n relocation?
> > > > Some arches actually seem to want to do this. Pretty sure PPC does.=
.. so a bit
> > > > nervous of that.
> > > >
> > > Can you please point out where PPC munmap/mremap the vdso ?
> > >
> > > Previously, when you mentioned that, I thought you meant user space i=
n
> > > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > > tried, but didn't find anything, hence asking.
> >
> > Jeff, please stick to replying to review. 'Have you looking through all
> > arm64-code'.
> >
> > I ended up doing this myself yesterday and found no issues, as with x86=
-64.
> >
> > I said I'm _pretty sure_ PPC does this. Liam mentioned something about
> > it. We can discuss it, and I can find specifics if + when you try to ad=
d
> > this to PPC.
> >
>
> PPC allows the vma to be munmapped then detects and falls back to the
> slower method, iirc.
>
Is this code in the kernel or userspace?

If PPC doesn't want to create vdso for all its userspace apps, we
could instead "don't create" vdso during the execve call.


> They were against the removal of the fallback; other archs also have
> this infrastructure.  Really, if we fixed the fallback to work for
> all platforms then it would probably also remove the possibility of a
> remap over the VDSO being a problem (if it is today, which still isn't
> clear?).
>
Any past thread/communication about this that I can read ?

Thanks
-Jeff


> Thanks,
> Liam

