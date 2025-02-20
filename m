Return-Path: <linux-kernel+bounces-523352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75839A3D56B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F8718949FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6468101DE;
	Thu, 20 Feb 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be7LKcc0"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA11C1F22
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045080; cv=none; b=jAvML96/VwLncc5rcBk+l+kW40OAMQ7OoDyU0fFXQDB9t/DZOmAY0k/7KqFKM/u+wOMouBAoYvNlwuxWLrQT/cfd40tdq+FM70OGgR8jz1BZ29hHwtP/sOKgZGzpFCNue07s8B/6VBMQt9+aukZ8uNcHihErN57PgP+aKU4zo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045080; c=relaxed/simple;
	bh=nMUz8exb8ERzXNeqj6kNWklTxOD4/gy6HGfuk/P5E5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca2gVEdlTd9M9u2+20B/nTs3LTs6JULkg6IynewaRyLHC1NwwQN9ul7RfanjYbSxGFTVcb8kYJNmz4r81QlthgkvIMMn7hDg3ZJP/k9yi/q6ufuxeVTqYO7deflq8oUVLe03TEo6y/irMgIW8sWiP3Tm7rDYMjnddUCnNlTFexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be7LKcc0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30a36eecb9dso7181281fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740045076; x=1740649876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W51Fo3UTKpPRzDaWp/vUbSHVfLy8+cyPYbBRCd9k0VA=;
        b=be7LKcc0RYEVB+v9DU/2JAc57f001VWixavCdl9yqenktt/Kz/he721aXlz8YSmxG6
         jhiDm4X9hVsZxkYe8Y77PX0CIgfPU7nqrk+eLVM/jG0lg0ScRHg3DJXy+w2VUJjmD0XW
         kUtcITL/+CXmX8GPzxNNiWVrvowUUiWlK7e3cbccEr5cA50CyMfMV+ERJICAwV6KkoOO
         lP5LnwXMSfOhc4gY8/xNei7cJuo5QBC7qfmia3ZoZDKQKAZr7b7a2mGJfVukPEwNsH8N
         A41a81X0BUtItRmVBZXwDFQ9LHZH5fo94iI24GLHm8GqLwj0ejy/4mGiFBkkgP4O6F+0
         VLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045076; x=1740649876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W51Fo3UTKpPRzDaWp/vUbSHVfLy8+cyPYbBRCd9k0VA=;
        b=m3ZkDZdkcbME+oyTxmFtuI/0b2quaFGrw/6J32KmOuo4vD/WreT/Ol+P5e8PgHaVhZ
         mJbL8RuG7hgBE5O3jxVOQyJdDGaClaL0WHUihq/2jSP8rDaqx3cLS31jbvwTmnBa/EPC
         eaTs02Qe2jbmEMkYEmPvktSmeSwdcaKnh7USOtleETR8mBKCMIv8RfOC4a0pGSskWE3X
         anDrqGF+nfp7+e6s46b4Z9a62+gYFvsyygiiTx4+eVTq1MDQd4O2JZN3a9wmZpZYHzo7
         zFk8HNIIgMpCo1p/xxh1ABVyNvXefPWWULVNuxsWONLiVgZ4tG+YcImxgvE66Py/5xxd
         FhtA==
X-Forwarded-Encrypted: i=1; AJvYcCUs7mP0wEgQ2TlMZ9iiZ0eILVFQgan4AezSb1oTB2M7XATf8/NO+8pcnVugzppdbhbmd7XnfkJqrMyLAXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPD+D5iicyCBxBFua7XEhzbuo5A7tpzsgVDs0JG/+32EPkkS+
	E9tzwv30Y+kY7JnU6hp3odysmeEVDC7ugM9+tjv4rVsWP6hhEUZGKf1ljxbPRh/jEYpzj1qiv5U
	IX5yB0WuEFC/KxUigHogNI2mJurI=
X-Gm-Gg: ASbGncvztuEFrStBYJIFKGRg0XB+E0Fm+d8i2KvnPKrcmHvqqi11Fs1QdrssZR7WPkR
	NHoPdwmOh+JNXiQtbhM0I5KbxOmQQrmEmn+1OL8FDHYvlp3Z4i3CulE9h7ohemsnQjeKqrwLi
X-Google-Smtp-Source: AGHT+IEW5PWS2Apq6jFH22b2q1WguPiBIReIZy552zFrdEyumcXj5U2CYZr/7g4j3PmXpTOEEHl3oSqN+/FKBecd3IA=
X-Received: by 2002:a05:651c:221f:b0:308:eabd:2991 with SMTP id
 38308e7fff4ca-30a51fee786mr5977361fa.1.1740045075709; Thu, 20 Feb 2025
 01:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
In-Reply-To: <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Feb 2025 10:51:03 +0100
X-Gm-Features: AWEUYZnRdS6dq8qUgNkzjkNrgzZImMojZS6YCKrwaf9D-MTqOQGlmT6oKK4xHz4
Message-ID: <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Brian Gerst <brgerst@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a1d19a062e8fd0fc"

--000000000000a1d19a062e8fd0fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:18=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wr=
ote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > > Thank you for doing this series - it all looks pretty good from my
> > > > side and I've applied it experimentally to tip:x86/asm. I fixed up
> > > > the trivial details other reviewers and me noticed.
> > > >
> > > > Note that the merge is tentative, it might still need a rebase if
> > > > some fundamental problem comes up - but let's see how testing goes
> > > > in -next.
> > >
> > > I wonder if there would be any benefit if stack canary is put into
> > > struct pcpu_hot?
> >
> > It should definitely be one of the hottest data structures on x86, so
> > moving it there makes sense even if it cannot be measured explicitly.
> >
>
> It would have to be done with linker tricks, since you can't make the
> compiler use a struct member directly.

Something like the attached patch?

It boots and runs without problems.

However, when building the kernel, I get "Absolute relocations
present" warning with thousands of locations:

  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
WARNING: Absolute relocations present
Offset     Info     Type     Sym.Value Sym.Name
ffffffff81200826 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
__ref_stack_chk_guard
ffffffff81201493 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
__ref_stack_chk_guard
ffffffff81201714 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
__ref_stack_chk_guard
ffffffff81201d66 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
__ref_stack_chk_guard
...
ffffffff834e2a13 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
__ref_stack_chk_guard
ffffffff834e2a6a 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
__ref_stack_chk_guard

  RSTRIP  vmlinux

which I don't understand. Looking at the first one:

ffffffff8120081d <force_ibs_eilvt_setup.cold>:
ffffffff8120081d:    48 8b 44 24 08           mov    0x8(%rsp),%rax
ffffffff81200822:    65 48 2b 05 f6 ed 30     sub
%gs:0x230edf6(%rip),%rax        # ffffffff8350f620
<__ref_stack_chk_guard>
ffffffff81200829:    02

I don't think this is absolute relocation, see (%rip).

The kernel was compiled with gcc-14.2.1, so clang specific issue was not te=
sted.

Uros.

--000000000000a1d19a062e8fd0fc
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m7d5um5v0>
X-Attachment-Id: f_m7d5um5v0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzMyLlMgYi9hcmNoL3g4Ni9lbnRyeS9l
bnRyeV8zMi5TCmluZGV4IDIwYmU1NzU4YzJkMi4uOTQwZWZjMDdmMmMxIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9lbnRyeS9lbnRyeV8zMi5TCisrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzMyLlMK
QEAgLTY5MSw3ICs2OTEsNyBAQCBTWU1fQ09ERV9TVEFSVChfX3N3aXRjaF90b19hc20pCiAKICNp
ZmRlZiBDT05GSUdfU1RBQ0tQUk9URUNUT1IKIAltb3ZsCVRBU0tfc3RhY2tfY2FuYXJ5KCVlZHgp
LCAlZWJ4Ci0JbW92bAklZWJ4LCBQRVJfQ1BVX1ZBUihfX3N0YWNrX2Noa19ndWFyZCkKKwltb3Zs
CSVlYngsIFBFUl9DUFVfVkFSKHBjcHVfaG90ICsgWDg2X3N0YWNrX2NhbmFyeSkKICNlbmRpZgog
CiAJLyoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMgYi9hcmNoL3g4Ni9l
bnRyeS9lbnRyeV82NC5TCmluZGV4IDQ5ZDNiMjIyZmU5OS4uNGY0YzBjZjQ5NjNmIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TCisrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5
XzY0LlMKQEAgLTE5Myw3ICsxOTMsNyBAQCBTWU1fRlVOQ19TVEFSVChfX3N3aXRjaF90b19hc20p
CiAKICNpZmRlZiBDT05GSUdfU1RBQ0tQUk9URUNUT1IKIAltb3ZxCVRBU0tfc3RhY2tfY2FuYXJ5
KCVyc2kpLCAlcmJ4Ci0JbW92cQklcmJ4LCBQRVJfQ1BVX1ZBUihfX3N0YWNrX2Noa19ndWFyZCkK
Kwltb3ZxCSVyYngsIFBFUl9DUFVfVkFSKHBjcHVfaG90ICsgWDg2X3N0YWNrX2NhbmFyeSkKICNl
bmRpZgogCiAJLyoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaCBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaAppbmRleCBiZjU5NTM4ODNlYzMuLmE0ZDUx
NWNkNmEzMSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3VycmVudC5oCisrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaApAQCAtMjIsNiArMjIsOSBAQCBzdHJ1Y3Qg
cGNwdV9ob3QgewogCQkJdTY0CQkJY2FsbF9kZXB0aDsKICNlbmRpZgogCQkJdW5zaWduZWQgbG9u
ZwkJdG9wX29mX3N0YWNrOworI2lmZGVmIENPTkZJR19TVEFDS1BST1RFQ1RPUgorCQkJdW5zaWdu
ZWQgbG9uZwkJc3RhY2tfY2FuYXJ5OworI2VuZGlmCiAJCQl2b2lkCQkJKmhhcmRpcnFfc3RhY2tf
cHRyOwogCQkJdTE2CQkJc29mdGlycV9wZW5kaW5nOwogI2lmZGVmIENPTkZJR19YODZfNjQKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N0YWNrcHJvdGVjdG9yLmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zdGFja3Byb3RlY3Rvci5oCmluZGV4IGQ0M2ZiNTg5ZmNmNi4uNWU1MjI5
YWMxYzQ2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdGFja3Byb3RlY3Rvci5o
CisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N0YWNrcHJvdGVjdG9yLmgKQEAgLTIwLDggKzIw
LDYgQEAKIAogI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+CiAKLURFQ0xBUkVfUEVSX0NQVSh1bnNp
Z25lZCBsb25nLCBfX3N0YWNrX2Noa19ndWFyZCk7Ci0KIC8qCiAgKiBJbml0aWFsaXplIHRoZSBz
dGFja3Byb3RlY3RvciBjYW5hcnkgdmFsdWUuCiAgKgpAQCAtMzgsMTIgKzM2LDEyIEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBib290X2luaXRfc3RhY2tfY2FuYXJ5KHZvaWQpCiAJdW5z
aWduZWQgbG9uZyBjYW5hcnkgPSBnZXRfcmFuZG9tX2NhbmFyeSgpOwogCiAJY3VycmVudC0+c3Rh
Y2tfY2FuYXJ5ID0gY2FuYXJ5OwotCXRoaXNfY3B1X3dyaXRlKF9fc3RhY2tfY2hrX2d1YXJkLCBj
YW5hcnkpOworCXRoaXNfY3B1X3dyaXRlKHBjcHVfaG90LnN0YWNrX2NhbmFyeSwgY2FuYXJ5KTsK
IH0KIAogc3RhdGljIGlubGluZSB2b2lkIGNwdV9pbml0X3N0YWNrX2NhbmFyeShpbnQgY3B1LCBz
dHJ1Y3QgdGFza19zdHJ1Y3QgKmlkbGUpCiB7Ci0JcGVyX2NwdShfX3N0YWNrX2Noa19ndWFyZCwg
Y3B1KSA9IGlkbGUtPnN0YWNrX2NhbmFyeTsKKwlwZXJfY3B1KHBjcHVfaG90LnN0YWNrX2NhbmFy
eSwgY3B1KSA9IGlkbGUtPnN0YWNrX2NhbmFyeTsKIH0KIAogI2Vsc2UJLyogU1RBQ0tQUk9URUNU
T1IgKi8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hc20tb2Zmc2V0cy5jIGIvYXJjaC94
ODYva2VybmVsL2FzbS1vZmZzZXRzLmMKaW5kZXggYTk4MDIwYmYzMWJiLi41OWU4YjI5NGNiZGMg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9hc20tb2Zmc2V0cy5jCisrKyBiL2FyY2gveDg2
L2tlcm5lbC9hc20tb2Zmc2V0cy5jCkBAIC0xMDksNiArMTA5LDkgQEAgc3RhdGljIHZvaWQgX191
c2VkIGNvbW1vbih2b2lkKQogCU9GRlNFVChUU1Nfc3AyLCB0c3Nfc3RydWN0LCB4ODZfdHNzLnNw
Mik7CiAJT0ZGU0VUKFg4Nl90b3Bfb2Zfc3RhY2ssIHBjcHVfaG90LCB0b3Bfb2Zfc3RhY2spOwog
CU9GRlNFVChYODZfY3VycmVudF90YXNrLCBwY3B1X2hvdCwgY3VycmVudF90YXNrKTsKKyNpZmRl
ZiBDT05GSUdfU1RBQ0tQUk9URUNUT1IKKwlPRkZTRVQoWDg2X3N0YWNrX2NhbmFyeSwgcGNwdV9o
b3QsIHN0YWNrX2NhbmFyeSk7CisjZW5kaWYKICNpZmRlZiBDT05GSUdfTUlUSUdBVElPTl9DQUxM
X0RFUFRIX1RSQUNLSU5HCiAJT0ZGU0VUKFg4Nl9jYWxsX2RlcHRoLCBwY3B1X2hvdCwgY2FsbF9k
ZXB0aCk7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jCmluZGV4IDIxMDc4OTA3YWY1Ny4uZjMwZDZh
OWM0YWJkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jCisrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKQEAgLTI0LDcgKzI0LDYgQEAKICNpbmNsdWRlIDxs
aW51eC9pby5oPgogI2luY2x1ZGUgPGxpbnV4L3N5c2NvcmVfb3BzLmg+CiAjaW5jbHVkZSA8bGlu
dXgvcGd0YWJsZS5oPgotI2luY2x1ZGUgPGxpbnV4L3N0YWNrcHJvdGVjdG9yLmg+CiAjaW5jbHVk
ZSA8bGludXgvdXRzbmFtZS5oPgogCiAjaW5jbHVkZSA8YXNtL2FsdGVybmF0aXZlLmg+CkBAIC0y
MDg3LDEzICsyMDg2LDYgQEAgdm9pZCBzeXNjYWxsX2luaXQodm9pZCkKIH0KICNlbmRpZiAvKiBD
T05GSUdfWDg2XzY0ICovCiAKLSNpZmRlZiBDT05GSUdfU1RBQ0tQUk9URUNUT1IKLURFRklORV9Q
RVJfQ1BVKHVuc2lnbmVkIGxvbmcsIF9fc3RhY2tfY2hrX2d1YXJkKTsKLSNpZm5kZWYgQ09ORklH
X1NNUAotRVhQT1JUX1BFUl9DUFVfU1lNQk9MKF9fc3RhY2tfY2hrX2d1YXJkKTsKLSNlbmRpZgot
I2VuZGlmCi0KIC8qCiAgKiBDbGVhciBhbGwgNiBkZWJ1ZyByZWdpc3RlcnM6CiAgKi8KZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC94ODYva2VybmVsL3Zt
bGludXgubGRzLlMKaW5kZXggMTc2OWE3MTI2MjI0Li5hMzVlNGViZTAzMmUgMTAwNjQ0Ci0tLSBh
L2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TCisrKyBiL2FyY2gveDg2L2tlcm5lbC92bWxp
bnV4Lmxkcy5TCkBAIC00NjgsNyArNDY4LDcgQEAgU0VDVElPTlMKIAkgICAia2VybmVsIGltYWdl
IGJpZ2dlciB0aGFuIEtFUk5FTF9JTUFHRV9TSVpFIik7CiAKIC8qIG5lZWRlZCBmb3IgQ2xhbmcg
LSBzZWUgYXJjaC94ODYvZW50cnkvZW50cnkuUyAqLwotUFJPVklERShfX3JlZl9zdGFja19jaGtf
Z3VhcmQgPSBfX3N0YWNrX2Noa19ndWFyZCk7CitQUk9WSURFKF9fcmVmX3N0YWNrX2Noa19ndWFy
ZCA9IHBjcHVfaG90ICsgWDg2X3N0YWNrX2NhbmFyeSk7CiAKICNpZmRlZiBDT05GSUdfWDg2XzY0
CiAK
--000000000000a1d19a062e8fd0fc--

