Return-Path: <linux-kernel+bounces-424992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E69DBC27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CEBB20E54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95E1BD9D2;
	Thu, 28 Nov 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKEW6l9d"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CC537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818504; cv=none; b=f4TGfkb/9bSwYU6ursPUp9u2o1Ngl5tOS6wPozRDIMDxzgjpupkbkh695AGXpJMD5tf6x0+nDBd0LU281TealQkHbrXL5MVL7c43yaraBfdNCkQb9mgmLAcBFQVnq5M9CvSNQts0uXrktHx1Iy/EVCSIK39VMMriIWAcPVKoO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818504; c=relaxed/simple;
	bh=tv8OCKFpQ5lMoZqDLhvzgUyfFZsdPxYXsLEcWpy9h0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv9VYFlcziIiXjwhD2tWAWy2FoPyjej7akSYBtXPT5t0hTNqXFpW9PY/1JJ/Y+aVxCW+pTlIGxXDuQmmFb+BqEhqwJRoyBg4VG6vuiuEb0h/ZS7ic/k73nUqlQKhZRgWEQVeNghkwjHev6ZMMYepdytaeEBQjjKEXFB11Eu3ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKEW6l9d; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0aab1aafcso1017a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732818501; x=1733423301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv8OCKFpQ5lMoZqDLhvzgUyfFZsdPxYXsLEcWpy9h0c=;
        b=MKEW6l9dlJm9ZwA5RA3WQImFPibIs4QvIZ4TgG6ngMxAYe0YvAbOOACGCGZ1kNKQuI
         C6Q4xXqcz2kXmkKsSiqkMFX4K2ttiyq1zNMw5Fnnhlbq5h8sKzacsWT1nO59xHO5iIwZ
         VPVhbiaTDlWKb4vVGVD+jvwF/hI6F3Kq/ASQpJD+p+9nVoU+Lkp2UmLVKSTH0+da9ryO
         jLQi3UssnsAPP0DiDrzTlqlVleWWgwnzAcDxGzhS6aBHZL91RPD0RbIedAaO/JMcFU0Y
         oUkpvule2tdfT/MI95p5ABasAzt/zBH7BcFgmbyh99KHGIxY1te7DJxl6evfAL93nzoV
         hsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732818501; x=1733423301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv8OCKFpQ5lMoZqDLhvzgUyfFZsdPxYXsLEcWpy9h0c=;
        b=dOyr9ahy8wpQH+UeARZ4j3/V9sBJAp0bo7Mi/y2MKtkVVOXHreDBljhLq6d1MxktLb
         7YXbSXyVt1pRXzzD0P3uom0WzD9Z8uCcAJ4hb9+MJ98W5n5LL5w3czTYPvZO0s0ZsQ3o
         toGWY3/ubI7h2/XR79KFuUjM88OqcYLl0/L4JsRee263fDAEPlOdZZsOfYLS/6SQjnKp
         MEvEQQyZW/+0m8GbwrgBElMkyBlUowbC55PzMqgeeZssbhlBQr9iG1Bz+se08ZsCE2Rl
         tSRre8ljugK4aT5+QfSS/RNM9YEYqwGjJLCR92lbG7HQnbnopH2KPb1hc5BxnobzSMI0
         QgWg==
X-Forwarded-Encrypted: i=1; AJvYcCVeUxRLr+I/U7EyVdZ1cMkPZhLgGFwQCzs1tfvy5eDErLmwrskfHIbDnjI9FXVIBvB4imR7G9BbXukLmec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg0b4yIogFxmFrXtZjjEI50nMU+N1IAGby7n93/hix8Oq+feS
	Sxl4l4Ov52m5qeBvkXF71EvwLGPIqIM5gu2saYwlpLwvgbVMTEhvvvpjcbweFOXa7L5obAOVbDw
	fkjYEyGv+5Om0hb0DydlFV9vWxIaK1s6uZacZ
X-Gm-Gg: ASbGncv2gJwZJdxochNKHv1zMDIKLQyC8rk2P67uBP3qlO/0vJiyXrb9ftciGRf1P4t
	NxEEWw79Ksh0Y2LdNeeflXSIlh3AvRHHw0xPIOp6Pb+4cCgVAEmLAOf3XeVo=
X-Google-Smtp-Source: AGHT+IF4elDJ5oQsFPW4V2HQgCdcZ4+fbW09x2aFjr1nn8V0wIL/8OB/nG4BdD5OkcuJB/VhQgqqTieDfTBuz8J4w7Q=
X-Received: by 2002:a50:ed8f:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5d0acf3e47amr752a12.1.1732818500889; Thu, 28 Nov 2024 10:28:20
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
 <CAHijbEV6wtTQy01djSfWBJksq4AEoZ=KYUsaKEKNSXbTTSM-Ww@mail.gmail.com> <03678794-2e09-4b93-aacb-90ca6ab36682@lucifer.local>
In-Reply-To: <03678794-2e09-4b93-aacb-90ca6ab36682@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Thu, 28 Nov 2024 19:27:44 +0100
Message-ID: <CAG48ez39-GaWbLYX77ZTJFW5oe0V7GS5MEQUaKSjYeCEDM0-vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Julian Orth <ju.orth@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 7:21=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Nov 28, 2024 at 06:58:21PM +0100, Julian Orth wrote:
> > (Re-sending the message below since I forgot to reply-all)
> >
> > On Thu, Nov 28, 2024 at 6:46=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Thu, Nov 28, 2024 at 4:06=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > In commit 158978945f31 ("mm: perform the mapping_map_writable() che=
ck after
> > > > call_mmap()") (and preceding changes in the same series) it became =
possible
> > > > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> > > >
> > > > This was previously unnecessarily disallowed, despite the man page
> > > > documentation indicating that it would be, thereby limiting the use=
fulness
> > > > of F_SEAL_WRITE logic.
> > > >
> > > > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_=
WRITE
> > > > seal (one which disallows future writes to the memfd) to also be us=
ed for
> > > > F_SEAL_WRITE.
> > > >
> > > > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE fo=
r a
> > > > read-only mapping to disallow mprotect() from overriding the seal -=
 an
> > > > operation performed by seal_check_write(), invoked from shmem_mmap(=
), the
> > > > f_op->mmap() hook used by shmem mappings.
> > > >
> > > > By extending this to F_SEAL_WRITE and critically - checking
> > > > mapping_map_writable() to determine if we may map the memfd AFTER w=
e invoke
> > > > shmem_mmap() - the desired logic becomes possible. This is because
> > > > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we =
will
> > > > have cleared.
> > > >
> > > > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > > > behaviour") unintentionally undid this logic by moving the
> > > > mapping_map_writable() check before the shmem_mmap() hook is invoke=
d,
> > > > thereby regressing this change.
> > > >
> > > > We reinstate this functionality by moving the check out of shmem_mm=
ap() and
> > > > instead performing it in do_mmap() at the point at which VMA flags =
are
> > > > being determined, which seems in any case to be a more appropriate =
place in
> > > > which to make this determination.
> > > >
> > > > In order to achieve this we rework memfd seal logic to allow us acc=
ess to
> > > > this information using existing logic and eliminate the clearing of
> > > > VM_MAYWRITE from seal_check_write() which we are performing in do_m=
map()
> > > > instead.
> > >
> > > If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> > > do_mmap(), without holding any kind of lock or counter on the file
> > > yet, then this check is clearly racy somehow, right? I think we have =
a
> > > race where we intermittently reject shared-readonly mmap() calls?
> >
> > Apropos race, some time ago I reported a way to get a mutable mapping
> > for a write-sealed memfd via a race:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219106
>
> Kind of hard to read rust code, but it looks like you're intentionally
> trying to race sealing on the assumption it's atomic when it's not? That
> doesn't seem like a bug?
>
> The intent of sealing memfds is you establish the memfd buffer, then seal
> it and _only then_ expose it elsewhere.
>
> I may be missing something here, however.

AFAIU memfds are supposed to also guarantee *to the recipient* of the
shared memfd that the memory inside it won't change anymore, so that
the recipient can parse data out of this shared memory buffer without
having to worry about the data concurrently changing. udmabuf_create()
looks like it indeed breaks that assumption by first calling
check_memfd_seals() and then doing udmabuf_pin_folios() without any
lock that prevents a seal being added in between those.

That's also why we have memfd_wait_for_pins(), which ensures that
folios in the memfd don't have elevated refcounts when a F_SEAL_WRITE
seal is added.

(I believe that's one of the major differences in usecases of
F_SEAL_WRITE and F_SEAL_FUTURE_WRITE: F_SEAL_FUTURE_WRITE is enough
for cases where only the creator of the memfd wants to prevent other
tasks from writing into it, while F_SEAL_WRITE is suitable for cases
where the creator and recipient of the memfd want mutual protection.)

