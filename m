Return-Path: <linux-kernel+bounces-281025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D056594D1FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D461F233B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF2197512;
	Fri,  9 Aug 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTxp6Je9"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE5183CD5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213079; cv=none; b=ImSbYMxlbpsG1aGQcX4vNiZeVe34W+S9MTue9Ih59wgsrXrCju7YSy1Ch2GImJfVQFuJt/x9GFSRaKyL6dT1tXyztNW7NMO2rBxJjR/L0vBvV4KQFEG07kfqav7HDYWYLQF35ScnBH2ZaRBxIvqwVWiLvXhB8JbP/DvVNoghm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213079; c=relaxed/simple;
	bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koch21YaOm59xedRnVQIv7sEm3KULsvXn0qMCTWfSv7fLryiaPWjRAO81+wOmLfE3QyicABbHXfl+pSzfQQ6PxFKtHH3hvIjXZ5rbj/e0cH3/l+t67LhardIYHlj49aa+uMvmEIiChH07tIBR/W7+woh3/7mrGdnuex5WtkrpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTxp6Je9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so9933a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723213076; x=1723817876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
        b=WTxp6Je999t+kn1Ow5M76Wtg9iLz+QJ6kALtH0vxLcMSRf0V0m33+9C7v3/mBWBZoD
         a8lKpuTztTJKt41fGLLCaVsSBDoXoKh1+Ni1T+wzhNpkfx2jNqihCqeX0hA8QMSbnXiO
         cpZKQ3iOeMriPjTODa+QgPBvkJGbk92agqgPKBwf/d6QuwYPlLyZGD1LHG+Cxfv1ocMY
         iM3Q+ow9T6UiG1tt0IOOd2adJVCEZgCEWSxiB7cmeaQZG/aeviCpoqnXhr2KyPl+2poU
         EE6MwjDmHSL2v7Z7vsS0ZLgSksztC5fu5VQ54j5fd0Or7yvrLE/xXlIufcbz29BVxm15
         9cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213076; x=1723817876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
        b=XgMso3DUMeKRCL2FyCgWTdN5Aa8dRrnoOOTtswRSLGNgOD9MmOWjxsz+nnpBo3x9mj
         hXiVUwBYkoEzNZdVRdbrOSOhda4z+R22Di7zVgiSpdlr2Xlh3DxeqQ5kq0/yeGBqT2JB
         W/qr12wF6eUuxmXaCkU+yAV58LkLj4tTtR/3h4mBbCMxSM6HLB9yw2NTOZdWzlK52szg
         Yg3VQweQpPW1N1nBqoqSKgH+bbvQCwQRhnpYEdfRmbGe8N2ayUJTbhFGP1GQu3rCXin+
         /gvG50q4Z740Jv5SsuVaTeUa8hv1M5hxe/+F3dWETNL3SANHN4SaQc4Xgisw+61tGmHt
         855g==
X-Forwarded-Encrypted: i=1; AJvYcCX+ksJ37O+UPAbrzzlUW6K8uHX26Z9ZiJXp3HCVsI888QqAOZPVQjeeIrpLfveaZ+mHGwBcyC1Cf0WHCm4Zc0HgORZLVp2ZN/y1/9Qa
X-Gm-Message-State: AOJu0YzgDjR3tsPeGdJF6AbmwkyXhGATO44dAvbFqj5c7G+kdQUq3W05
	jghasHb9nOeDhan00stWquvy0nv5wQVkm+EjdMMg219kGeRGj8CswYObCz6q4bicVoh77ToVvPV
	PRfJQkMY49jCKVukX80fzBM9P3U/3JK/LDkoE
X-Google-Smtp-Source: AGHT+IG4FJuMRgOPLrNVllaBIrEDQBkPDDIpRd/2JU+QjaXaE3XDW4T5ngFYVh/mKQgDCJH+Vn9glx33KtIoCA3ICtA=
X-Received: by 2002:a05:6402:26c3:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bbbc4d3f2bmr168346a12.2.1723213074852; Fri, 09 Aug 2024
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
 <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com> <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
In-Reply-To: <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 16:17:16 +0200
Message-ID: <CAG48ez2vzhYcgt2dtZLx0j6eK92xEHwjFfowg57fAuhQ-0_zCg@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:00=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> On Tue, Jul 30, 2024 at 11:29=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> > On Tue, Jul 30, 2024, at 22:15, Jann Horn wrote:
> > > Refactor the list of constant variables into a macro.
> > > This should make it easier to add more constants in the future.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I'm not sure whose tree this has to go through - I guess Arnd's?
> >
> > This is for 6.12, right?
>
> Yeah.
>
> > I can take it through the asm-generic
> > tree if that helps, but someone else should review it first.
> >
> > If you have any other patches that would depend on this patch,
> > you can also take it through the other tree and add
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > for cross-architecture bits.
>
> Thanks!
>
> I was thinking of maybe trying to write a patch based on it that'd
> have to go through the MM tree (for using this in kfence), though I'm
> not sure whether I'll actually do that yet. So your suggestion makes
> sense, maybe hold off on putting this in a tree for now...

I don't think I'll get around to doing anything on top of this patch
for the next few months at least, please take it through your tree.

