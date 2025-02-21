Return-Path: <linux-kernel+bounces-525842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E9A3F630
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797E3AAAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215C20B7F2;
	Fri, 21 Feb 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+oAesvM"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630C1EEE9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145024; cv=none; b=XUUdCwlvO9l9eX9PMR66cltvWMzUeLsqjNUFS59q4w2X5ZoyP4WrY1EuIJDXdHUBwwD14OvlZ9y+MmZ1pvzxbFYIJt2TYHX1cS5F/gZsKTN8MLeA7xXVQxHSyqk4Y2c/s0u3BFAhCGtaYKohsF4Fld8JcodDgWcNPjo4OWfX7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145024; c=relaxed/simple;
	bh=H9k/JQrcvW24i9xCliTsvoLOLTxZkRol6rvcICCe00A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aW2TZbpAiWRb418MfsdqiscfmM+8FE3lRnRRHZHBeEy3yLFHJeFjOueSXCZsSFNGsHXdK+e1sHUqNHumf1GeYntei6Me47/0VP3223KExKfazNh27Uqa0OIwFfsy1g+YroT/ZnWT67QVioutz9ySljQDVT8AnSRGbbVNqIxg8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+oAesvM; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso472562fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145022; x=1740749822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=icYwwJmIDLh+Q39nlIvOFWnLUdpkfVEKItRD8j0gFfI=;
        b=Y+oAesvMVbwyCe/K8Il4HxP4SWbCeJEzt6S1NNh+gh9sskrHeVPMvTDId9A8Rz76oM
         iU15Bw0PEsDkHMqVUYYUAD75l9QWGahXweAtqQsBFcLKUjA42F1MhHoLPcKTdmlPzXGC
         Dk3c8ya4ghbxo7keW3Bsz2bXALkkVbEWHjO0IT6IvKaOX9dgIJbwQG2Tm/k5iBe0liI0
         pDmJR3liW7kiNUFd345PRi3lOLCA/aASsRNHJr5YC17BhM3zC8CD7VVTY5GUBbYnvepe
         kxZ0L9Eb/L0za3UKrXxJdV7Ap9oyl3wHhdC52bmPPrMf8oVOPQuqLs6e1tJ2P6XbLmzm
         IlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145022; x=1740749822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icYwwJmIDLh+Q39nlIvOFWnLUdpkfVEKItRD8j0gFfI=;
        b=mYEA54q1ArfS8/RcloqY7pKYjpDAm0fCaeGnT4qDor/nkeGr5xYVWwtZl2o1heqLKr
         NUvwNLsIphiP8HHvIkYZKiJ46DZhl5n8GWR9l2TrC5ehPTWWhEMG0KypyAMuCb9h4+A5
         a9xYj25kIJGdinYEuenQyFTJJ0s7I1cBp6IgprF+rL43W9cGsWqMyGi5y2DPerFOLiys
         lmJi4/IfltMHQDIyql84si+w7Vx2TH9FRE2+yydIcED6Jsu0Sp2rVXC8KHfSDElnJDfC
         aAO6HI7yBgW8OE/Jqt6lwbJvYnoR3zFTzg4Mz7l3UraWbHh3b1Ozp7fU7cqQ11efRq3b
         FJLw==
X-Forwarded-Encrypted: i=1; AJvYcCUtEm3VTrSz8iJCL7cdoXtD+uc+hOc411pIk+8fwZCq8UQwwCpFv62ZZ5FysqM+XV91QlrOg6U8GPnQHK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFYVspGevH/xmWJ8QUgABtC0Yl7qFKTgjrWEMnc2fLo2DpGzH
	zXibysICN65Mah9sFUS4L4OsU0tYw5aWLW787WNCuRBoq291rzv+CXly601GXOGWL12s8Orve52
	Q3z4oi9VHdmUkAY7yVOkIjZ7qiA==
X-Gm-Gg: ASbGncuHBQbT7/J74ubrLZZbmYOKBQiS7aZIPeyTCD4rp+3+ZQlCCIaqkJKvrAwDck6
	/KqpnyFPC2P1wBcOrwW1eqObvxcgOHuYSgLyDJlCwN5Y4FrS9oLcW+FhRNRjbNsVENgUCXxSsoF
	pAJ6gYzwd1LEnSuuzgH5VzIA==
X-Google-Smtp-Source: AGHT+IE0PyhTe/rQgxdk0wCjxFaqm5scSvsW4D1RpJtAjxoLT72STKex5Qg/WXrBI5dyvrZ0UXOZNigbEqVP+KdORRg=
X-Received: by 2002:a05:6820:554:b0:5fd:c5f:3937 with SMTP id
 006d021491bc7-5fd1a572dd0mr1809863eaf.1.1740145021860; Fri, 21 Feb 2025
 05:37:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
In-Reply-To: <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 21 Feb 2025 08:36:45 -0500
X-Gm-Features: AWEUYZkiVDSWLMYScUJ5Z-NWkh20J7R7pKOsdlTsA9MAQojJURiUvw0KR8yoXjc
Message-ID: <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e2e9a1062ea71527"

--000000000000e2e9a1062ea71527
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 8:25=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Fri, Feb 21, 2025 at 1:54=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Thu, Feb 20, 2025 at 3:04=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > Move stack canary from __stack_chk_guard to struct pcpu_hot and
> > > alias __stack_chk_guard to point to the new location in the
> > > linker script.
> > >
> > > __stack_chk_guard is one of the hottest data structures on x86, so
> > > moving it there makes sense even if its benefit cannot be measured
> > > explicitly.
> > >
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Brian Gerst <brgerst@gmail.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/include/asm/current.h | 13 +++++++++++++
> > >  arch/x86/kernel/cpu/common.c   |  1 -
> > >  arch/x86/kernel/vmlinux.lds.S  |  2 ++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/cu=
rrent.h
> > > index bf5953883ec3..e4ff1d15b465 100644
> > > --- a/arch/x86/include/asm/current.h
> > > +++ b/arch/x86/include/asm/current.h
> > > @@ -15,6 +15,9 @@ struct task_struct;
> > >  struct pcpu_hot {
> > >         union {
> > >                 struct {
> > > +#ifdef CONFIG_STACKPROTECTOR
> > > +                       unsigned long           stack_canary;
> > > +#endif
> > >                         struct task_struct      *current_task;
> > >                         int                     preempt_count;
> > >                         int                     cpu_number;
> > > @@ -35,6 +38,16 @@ struct pcpu_hot {
> > >  };
> > >  static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> > >
> > > +/*
> > > + * stack_canary should be at the beginning of struct pcpu_hot to avo=
id:
> > > + *
> > > + * Invalid absolute R_X86_64_32S relocation: __stack_chk_guard
> >
> > This should be R_X86_64_PC32 relocations.
>
> This is what the build system reports if any offset (including 0) is adde=
d to
>
> PROVIDE(__stack_chk_guard =3D pcpu_hot);
>
> It is not a warning, but an error that fails the build.
>
> As was discussed in the previous thread, the above is required to
> handle !SMP case, where mstack-protector-guard=3Dglobal (used by !SMP
> builds) ignores the
> -mstack-protector-guard-symbol option and always uses __stack_chk_guard.

I got a warning from the relocs tool, but not a hard error.  What
compiler/linker are you using?

Does the attached patch build in your configuration?


Brian Gerst

--000000000000e2e9a1062ea71527
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x86-stackprotector-Move-canary-to-pcpu_hot.patch"
Content-Disposition: attachment; 
	filename="0001-x86-stackprotector-Move-canary-to-pcpu_hot.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7etc5cu0>
X-Attachment-Id: f_m7etc5cu0

RnJvbSBlZTMwZjNhOTM2ZTY0MTk3OGM5NjVkODI5OTBjMTE3OTJiNTk4ZmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCcmlhbiBHZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+CkRhdGU6
IFdlZCwgMTkgRmViIDIwMjUgMTI6Mzg6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSB4ODYvc3Rh
Y2twcm90ZWN0b3I6IE1vdmUgY2FuYXJ5IHRvIHBjcHVfaG90CgpUaGUgc3RhY2sgcHJvdGVjdG9y
IGNhbmFyeSB2YWx1ZSBpcyBmcmVxdWVudGx5IGFjY2Vzc2VkIG9uIGZ1bmN0aW9uCmVudHJ5IGFu
ZCBleGl0LCBzbyBtb3ZlIGl0IHRvIHRoZSBwY3B1X2hvdCBzdHJ1Y3Qgd2hlcmUgaXQgd2lsbCBo
YXZlCmZhc3QgYWNjZXNzLgoKSW4gb3JkZXIgdG8ga2VlcCBub24tU01QIGJ1aWxkcyB3b3JraW5n
LCByZW5hbWUgX19yZWZfc3RhY2tfY2hrX2d1YXJkIHRvCl9fc3RhY2tfY2hrX2d1YXJkLgoKU2ln
bmVkLW9mZi1ieTogQnJpYW4gR2Vyc3QgPGJyZ2Vyc3RAZ21haWwuY29tPgotLS0KIGFyY2gveDg2
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgfCAyICstCiBhcmNoL3g4Ni9lbnRyeS9lbnRy
eS5TICAgICAgICAgICAgICAgIHwgMiArLQogYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUyAgICAg
ICAgICAgICB8IDIgKy0KIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMgICAgICAgICAgICAgfCAy
ICstCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9hc20tcHJvdG90eXBlcy5oIHwgMiArLQogYXJjaC94
ODYvaW5jbHVkZS9hc20vY3VycmVudC5oICAgICAgICB8IDMgKysrCiBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zdGFja3Byb3RlY3Rvci5oIHwgNyArKystLS0tCiBhcmNoL3g4Ni9rZXJuZWwvYXNtLW9m
ZnNldHMuYyAgICAgICAgIHwgNCArKysrCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jICAg
ICAgICAgIHwgOCAtLS0tLS0tLQogYXJjaC94ODYva2VybmVsL21vZHVsZS5jICAgICAgICAgICAg
ICB8IDIgKy0KIGFyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TICAgICAgICAgfCA0ICsrKy0K
IGFyY2gveDg2L3Rvb2xzL3JlbG9jcy5jICAgICAgICAgICAgICAgfCAxICsKIDEyIGZpbGVzIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L01ha2VmaWxlIGIvYXJjaC94ODYvTWFrZWZpbGUKaW5kZXggODhhMTcwNTM2NmY5Li5j
YzYxOWQzMWNjZmUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L01ha2VmaWxlCisrKyBiL2FyY2gveDg2
L01ha2VmaWxlCkBAIC0xOTcsNyArMTk3LDcgQEAgZW5kaWYKIGlmZXEgKCQoQ09ORklHX1NUQUNL
UFJPVEVDVE9SKSx5KQogICAgIGlmZXEgKCQoQ09ORklHX1NNUCkseSkKIAlLQlVJTERfQ0ZMQUdT
ICs9IC1tc3RhY2stcHJvdGVjdG9yLWd1YXJkLXJlZz0kKHBlcmNwdV9zZWcpCi0JS0JVSUxEX0NG
TEFHUyArPSAtbXN0YWNrLXByb3RlY3Rvci1ndWFyZC1zeW1ib2w9X19yZWZfc3RhY2tfY2hrX2d1
YXJkCisJS0JVSUxEX0NGTEFHUyArPSAtbXN0YWNrLXByb3RlY3Rvci1ndWFyZC1zeW1ib2w9X19z
dGFja19jaGtfZ3VhcmQKICAgICBlbHNlCiAJS0JVSUxEX0NGTEFHUyArPSAtbXN0YWNrLXByb3Rl
Y3Rvci1ndWFyZD1nbG9iYWwKICAgICBlbmRpZgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkv
ZW50cnkuUyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5LlMKaW5kZXggZmU1MzQ0YTI0OWExLi5kNzc5
MzgxYTA2N2MgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2VudHJ5L2VudHJ5LlMKKysrIGIvYXJjaC94
ODYvZW50cnkvZW50cnkuUwpAQCAtNjMsNSArNjMsNSBAQCBUSFVOSyB3YXJuX3RodW5rX3RodW5r
LCBfX3dhcm5fdGh1bmsKICAqIGluc3RlYWQuCiAgKi8KICNpZmRlZiBDT05GSUdfU1RBQ0tQUk9U
RUNUT1IKLUVYUE9SVF9TWU1CT0woX19yZWZfc3RhY2tfY2hrX2d1YXJkKTsKK0VYUE9SVF9TWU1C
T0woX19zdGFja19jaGtfZ3VhcmQpOwogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRy
eS9lbnRyeV8zMi5TIGIvYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUwppbmRleCAyMGJlNTc1OGMy
ZDIuLjk0MGVmYzA3ZjJjMSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUwor
KysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV8zMi5TCkBAIC02OTEsNyArNjkxLDcgQEAgU1lNX0NP
REVfU1RBUlQoX19zd2l0Y2hfdG9fYXNtKQogCiAjaWZkZWYgQ09ORklHX1NUQUNLUFJPVEVDVE9S
CiAJbW92bAlUQVNLX3N0YWNrX2NhbmFyeSglZWR4KSwgJWVieAotCW1vdmwJJWVieCwgUEVSX0NQ
VV9WQVIoX19zdGFja19jaGtfZ3VhcmQpCisJbW92bAklZWJ4LCBQRVJfQ1BVX1ZBUihwY3B1X2hv
dCArIFg4Nl9zdGFja19jYW5hcnkpCiAjZW5kaWYKIAogCS8qCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9lbnRyeS9lbnRyeV82NC5TIGIvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUwppbmRleCAzM2E5
NTVhYTAxZDguLmVkNDM1NTlkNjZkYyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvZW50cnlf
NjQuUworKysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TCkBAIC0xOTIsNyArMTkyLDcgQEAg
U1lNX0ZVTkNfU1RBUlQoX19zd2l0Y2hfdG9fYXNtKQogCiAjaWZkZWYgQ09ORklHX1NUQUNLUFJP
VEVDVE9SCiAJbW92cQlUQVNLX3N0YWNrX2NhbmFyeSglcnNpKSwgJXJieAotCW1vdnEJJXJieCwg
UEVSX0NQVV9WQVIoX19zdGFja19jaGtfZ3VhcmQpCisJbW92cQklcmJ4LCBQRVJfQ1BVX1ZBUihw
Y3B1X2hvdCArIFg4Nl9zdGFja19jYW5hcnkpCiAjZW5kaWYKIAogCS8qCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9hc20tcHJvdG90eXBlcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vYXNtLXByb3RvdHlwZXMuaAppbmRleCAzNjc0MDA2ZTM5NzQuLjQzOTc3Yzc0YjIyZiAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXNtLXByb3RvdHlwZXMuaAorKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9hc20tcHJvdG90eXBlcy5oCkBAIC0yMSw1ICsyMSw1IEBAIGV4dGVy
biB2b2lkIGNtcHhjaGc4Yl9lbXUodm9pZCk7CiAjZW5kaWYKIAogI2lmIGRlZmluZWQoX19HRU5L
U1lNU19fKSAmJiBkZWZpbmVkKENPTkZJR19TVEFDS1BST1RFQ1RPUikKLWV4dGVybiB1bnNpZ25l
ZCBsb25nIF9fcmVmX3N0YWNrX2Noa19ndWFyZDsKK2V4dGVybiB1bnNpZ25lZCBsb25nIF9fc3Rh
Y2tfY2hrX2d1YXJkOwogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9j
dXJyZW50LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jdXJyZW50LmgKaW5kZXggYmY1OTUzODgz
ZWMzLi5jZjBjZTQ0YzFkOTUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJl
bnQuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jdXJyZW50LmgKQEAgLTI4LDYgKzI4LDkg
QEAgc3RydWN0IHBjcHVfaG90IHsKIAkJCWJvb2wJCQloYXJkaXJxX3N0YWNrX2ludXNlOwogI2Vs
c2UKIAkJCXZvaWQJCQkqc29mdGlycV9zdGFja19wdHI7CisjZW5kaWYKKyNpZmRlZiBDT05GSUdf
U1RBQ0tQUk9URUNUT1IKKwkJCXVuc2lnbmVkIGxvbmcJCXN0YWNrX2NhbmFyeTsKICNlbmRpZgog
CQl9OwogCQl1OAlwYWRbNjRdOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc3Rh
Y2twcm90ZWN0b3IuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N0YWNrcHJvdGVjdG9yLmgKaW5k
ZXggZDQzZmI1ODlmY2Y2Li40MTQyYzg4MzkwZDMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3N0YWNrcHJvdGVjdG9yLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc3RhY2tw
cm90ZWN0b3IuaApAQCAtMTcsMTEgKzE3LDEwIEBACiAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci5o
PgogI2luY2x1ZGUgPGFzbS9wZXJjcHUuaD4KICNpbmNsdWRlIDxhc20vZGVzYy5oPgorI2luY2x1
ZGUgPGFzbS9jdXJyZW50Lmg+CiAKICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgogCi1ERUNMQVJF
X1BFUl9DUFUodW5zaWduZWQgbG9uZywgX19zdGFja19jaGtfZ3VhcmQpOwotCiAvKgogICogSW5p
dGlhbGl6ZSB0aGUgc3RhY2twcm90ZWN0b3IgY2FuYXJ5IHZhbHVlLgogICoKQEAgLTM4LDEyICsz
NywxMiBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgYm9vdF9pbml0X3N0YWNrX2NhbmFy
eSh2b2lkKQogCXVuc2lnbmVkIGxvbmcgY2FuYXJ5ID0gZ2V0X3JhbmRvbV9jYW5hcnkoKTsKIAog
CWN1cnJlbnQtPnN0YWNrX2NhbmFyeSA9IGNhbmFyeTsKLQl0aGlzX2NwdV93cml0ZShfX3N0YWNr
X2Noa19ndWFyZCwgY2FuYXJ5KTsKKwl0aGlzX2NwdV93cml0ZShwY3B1X2hvdC5zdGFja19jYW5h
cnksIGNhbmFyeSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfaW5pdF9zdGFja19jYW5h
cnkoaW50IGNwdSwgc3RydWN0IHRhc2tfc3RydWN0ICppZGxlKQogewotCXBlcl9jcHUoX19zdGFj
a19jaGtfZ3VhcmQsIGNwdSkgPSBpZGxlLT5zdGFja19jYW5hcnk7CisJcGVyX2NwdShwY3B1X2hv
dC5zdGFja19jYW5hcnksIGNwdSkgPSBpZGxlLT5zdGFja19jYW5hcnk7CiB9CiAKICNlbHNlCS8q
IFNUQUNLUFJPVEVDVE9SICovCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYXNtLW9mZnNl
dHMuYyBiL2FyY2gveDg2L2tlcm5lbC9hc20tb2Zmc2V0cy5jCmluZGV4IGE5ODAyMGJmMzFiYi4u
NGMwMmY1ZDI0N2YyIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXNtLW9mZnNldHMuYwor
KysgYi9hcmNoL3g4Ni9rZXJuZWwvYXNtLW9mZnNldHMuYwpAQCAtMTEyLDYgKzExMiwxMCBAQCBz
dGF0aWMgdm9pZCBfX3VzZWQgY29tbW9uKHZvaWQpCiAjaWZkZWYgQ09ORklHX01JVElHQVRJT05f
Q0FMTF9ERVBUSF9UUkFDS0lORwogCU9GRlNFVChYODZfY2FsbF9kZXB0aCwgcGNwdV9ob3QsIGNh
bGxfZGVwdGgpOwogI2VuZGlmCisjaWZkZWYgQ09ORklHX1NUQUNLUFJPVEVDVE9SCisJT0ZGU0VU
KFg4Nl9zdGFja19jYW5hcnksIHBjcHVfaG90LCBzdGFja19jYW5hcnkpOworI2VuZGlmCisKICNp
ZiBJU19FTkFCTEVEKENPTkZJR19DUllQVE9fQVJJQV9BRVNOSV9BVlhfWDg2XzY0KQogCS8qIE9m
ZnNldCBmb3IgZmllbGRzIGluIGFyaWFfY3R4ICovCiAJQkxBTksoKTsKZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5j
CmluZGV4IDhiNDliMTMzOGY3Ni4uMTczNWU0YTExZDllIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2NvbW1vbi5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKQEAg
LTI0LDcgKzI0LDYgQEAKICNpbmNsdWRlIDxsaW51eC9pby5oPgogI2luY2x1ZGUgPGxpbnV4L3N5
c2NvcmVfb3BzLmg+CiAjaW5jbHVkZSA8bGludXgvcGd0YWJsZS5oPgotI2luY2x1ZGUgPGxpbnV4
L3N0YWNrcHJvdGVjdG9yLmg+CiAjaW5jbHVkZSA8bGludXgvdXRzbmFtZS5oPgogCiAjaW5jbHVk
ZSA8YXNtL2FsdGVybmF0aXZlLmg+CkBAIC0yMDg3LDEzICsyMDg2LDYgQEAgdm9pZCBzeXNjYWxs
X2luaXQodm9pZCkKIH0KICNlbmRpZiAvKiBDT05GSUdfWDg2XzY0ICovCiAKLSNpZmRlZiBDT05G
SUdfU1RBQ0tQUk9URUNUT1IKLURFRklORV9QRVJfQ1BVKHVuc2lnbmVkIGxvbmcsIF9fc3RhY2tf
Y2hrX2d1YXJkKTsKLSNpZm5kZWYgQ09ORklHX1NNUAotRVhQT1JUX1BFUl9DUFVfU1lNQk9MKF9f
c3RhY2tfY2hrX2d1YXJkKTsKLSNlbmRpZgotI2VuZGlmCi0KIC8qCiAgKiBDbGVhciBhbGwgNiBk
ZWJ1ZyByZWdpc3RlcnM6CiAgKi8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9tb2R1bGUu
YyBiL2FyY2gveDg2L2tlcm5lbC9tb2R1bGUuYwppbmRleCBhMjg2ZjMyYzU1MDMuLmZiYWRjNzg5
NTdkZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL21vZHVsZS5jCisrKyBiL2FyY2gveDg2
L2tlcm5lbC9tb2R1bGUuYwpAQCAtMTM0LDcgKzEzNCw3IEBAIHN0YXRpYyBpbnQgX193cml0ZV9y
ZWxvY2F0ZV9hZGQoRWxmNjRfU2hkciAqc2VjaGRycywKICNpZiBkZWZpbmVkKENPTkZJR19TVEFD
S1BST1RFQ1RPUikgJiYgXAogICAgIGRlZmluZWQoQ09ORklHX0NDX0lTX0NMQU5HKSAmJiBDT05G
SUdfQ0xBTkdfVkVSU0lPTiA8IDE3MDAwMAogCQljYXNlIFJfWDg2XzY0X1JFWF9HT1RQQ1JFTFg6
IHsKLQkJCXN0YXRpYyB1bnNpZ25lZCBsb25nIF9fcGVyY3B1ICpjb25zdCBhZGRyID0gJl9fc3Rh
Y2tfY2hrX2d1YXJkOworCQkJc3RhdGljIHVuc2lnbmVkIGxvbmcgX19wZXJjcHUgKmNvbnN0IGFk
ZHIgPSAmcGNwdV9ob3Quc3RhY2tfY2FuYXJ5OwogCiAJCQlpZiAoc3ltLT5zdF92YWx1ZSAhPSAo
dTY0KWFkZHIpIHsKIAkJCQlwcl9lcnIoIiVzOiBVbnN1cHBvcnRlZCBHT1RQQ1JFTCByZWxvY2F0
aW9uXG4iLCBtZS0+bmFtZSk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5s
ZHMuUyBiL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TCmluZGV4IDE3NjlhNzEyNjIyNC4u
Y2IwYWI4NzM2MTZlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUwor
KysgYi9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUwpAQCAtNDY3LDggKzQ2NywxMCBAQCBT
RUNUSU9OUwogLiA9IEFTU0VSVCgoX2VuZCAtIExPQURfT0ZGU0VUIDw9IEtFUk5FTF9JTUFHRV9T
SVpFKSwKIAkgICAia2VybmVsIGltYWdlIGJpZ2dlciB0aGFuIEtFUk5FTF9JTUFHRV9TSVpFIik7
CiAKKyNpZmRlZiBDT05GSUdfU1RBQ0tQUk9URUNUT1IKIC8qIG5lZWRlZCBmb3IgQ2xhbmcgLSBz
ZWUgYXJjaC94ODYvZW50cnkvZW50cnkuUyAqLwotUFJPVklERShfX3JlZl9zdGFja19jaGtfZ3Vh
cmQgPSBfX3N0YWNrX2Noa19ndWFyZCk7CitfX3N0YWNrX2Noa19ndWFyZCA9IHBjcHVfaG90ICsg
WDg2X3N0YWNrX2NhbmFyeTsKKyNlbmRpZgogCiAjaWZkZWYgQ09ORklHX1g4Nl82NAogCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni90b29scy9yZWxvY3MuYyBiL2FyY2gveDg2L3Rvb2xzL3JlbG9jcy5j
CmluZGV4IDU3NzhiYzQ5ODQxNS4uYmY2MTJmMWY4YzhhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni90
b29scy9yZWxvY3MuYworKysgYi9hcmNoL3g4Ni90b29scy9yZWxvY3MuYwpAQCAtODksNiArODks
NyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0CXN5bV9yZWdleF9rZXJuZWxbU19OU1lNVFlQ
RVNdID0gewogCSJfX2VuZF9yb2RhdGFfYWxpZ25lZHwiCiAJIl9faW5pdHJhbWZzX3N0YXJ0fCIK
IAkiKGppZmZpZXN8amlmZmllc182NCl8IgorCSJfX3N0YWNrX2Noa19ndWFyZHwiCiAjaWYgRUxG
X0JJVFMgPT0gNjQKIAkiX19lbmRfcm9kYXRhX2hwYWdlX2FsaWdufCIKICNlbmRpZgoKYmFzZS1j
b21taXQ6IDAxMTU3ZGRjNThkYzJmZTQyOGVjMTdkZDVhMThjYzEzZjEzNDYzOWYKLS0gCjIuNDgu
MQoK
--000000000000e2e9a1062ea71527--

