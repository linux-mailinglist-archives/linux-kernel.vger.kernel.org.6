Return-Path: <linux-kernel+bounces-536420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39364A47F49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC151885596
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0F22F17B;
	Thu, 27 Feb 2025 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG/VVDMe"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7A221574
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663349; cv=none; b=TZW2Tcgil+k9SqyKp4XKtks/Xo6j5nnZUVLfQ8A72OlJnePQXJbcMfzS1cxg0nTnCOoQd9ZNSV9SvORH5zZFt1Vbxq01xRsrg9sJu32KS8GRSz0uA2x7S6wfFrJDOnrXVPtMd6mgi0Wk42+ndWAbF300UhgIeunLCDT9iQWqq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663349; c=relaxed/simple;
	bh=6Il58BrvrPVO60P6UVsP7CImh149GPv44Rna7LFM1OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKx1AHI/BVcEhfpEsU3IUNgysMPIvAiTKFzI29ga3cYkuy+AnIOYsxLL6DObrAmRe4kENTgVTYi23D+3RAlF6hl6MNjlkW0uaytzlu93GLfZe4Na5KF/L/io3LgNf41uf/43ck+YW2prfUZS9C0Fm0qVNxYt1keo4EmnBqUHAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG/VVDMe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2594435dso19966281fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740663346; x=1741268146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UcX5Ze2cAe7Y7OTQRQkAqDrbuLGej7Q2EGbAJWbbBBk=;
        b=OG/VVDMeriAOCL3yKdTKAIEI6HsQ6HAkhWL2sfyCw7TA/CjD12H57cLaORk1n3IpJm
         WO7Ey7EwFtfX0sUQbcSlVAjwHhw1OrbtzfHfickJuldmYO2+eOaS6AkIdIUb3ScBajDf
         bAaanbVrPw3xJTfAb6rLBpVLZCe5GtZ4tFG22XGIPXQ15nzvOAMH/+mFGtJHxF7uhFM0
         6uE/2yCasYx5S7gDif+Lh2+i+FyVTLofDB7fR4wr00+thpIP3sk5IIA5qBQ1LaFgGZWD
         Ul64lNjV/oGQqylaeg6TSbgAKmg1BaaGTXgiPb/4mqnyrxXdSf/zhimuy0J7BXFVV9Dd
         yhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663346; x=1741268146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcX5Ze2cAe7Y7OTQRQkAqDrbuLGej7Q2EGbAJWbbBBk=;
        b=uikK4TqHndwXgT56gURBm5TaZK+6l6kKfsVR5WY8ZmO+SCzMxnLvChQy8TFWd93zok
         rUBhs2/lBvuEgvUj5JrmF/BY+KNxs2xYGUW28VykX8o6Xx8bq0PjR5I/LxcYAkl/DMqb
         wLAAZ7BTt7BNUv2iyY95z0jcrcJvQ3gcTARXhX5jDvAY+hIRZgrKVqDTj5JEHmDT0Z9I
         88JIYM+zRGq8ZM2cKinxJz+Jh8NwetK8M00JrJfO5HNnMNvNS8XrUswuZrIlSTsprexI
         1baC5ZZS7fvfKmiYuO5suuiyECwMTjMvLx0zed/6C+GIkYBFzsYdPtOiomVsaj/ahxZj
         cd5A==
X-Forwarded-Encrypted: i=1; AJvYcCUYmyrSBDjqDp//uAPHuKufFMqROQRctWTEDH02V34N5nHWfvtwfbBDYWKj1NoPXIaBDpg5nlixuHcVovQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbHM2dAB9inTFSPKRbYXJsP/0sX02mQpoDzf81ipqrE3RKLOF
	R0qkQl4VUD3SRPSPf6TNMffg3G1vzvh6Ym8LBhxipjNRYasATo6BI0P34O6x3ChADcLKW/QPaDg
	R+CI6VYwczkcl4afPNXviXIC/VVc=
X-Gm-Gg: ASbGncsehG+ZbB/j20pInG57jLGT4B/GbRmzagofefbEJVFoXPlNILdlBFIFe/rUYZg
	XezurLgyHOTlPN8+QauGaKE5dh8Y7NvKDFdjNypc/0BTQlMW9MX8ObwzCKBfLmLSoGZC1KXFdf6
	lrOicEZmQ=
X-Google-Smtp-Source: AGHT+IE+AQzSKTtQXERT8HvyBiH74HXMnpTakPkfha42J4EAdOhM36VP8EOBJCeEvnw7PfpTYCiOxs6qzdKNnCH1m94=
X-Received: by 2002:a2e:ad0b:0:b0:309:2999:77d4 with SMTP id
 38308e7fff4ca-30b84650d3dmr17304321fa.6.1740663345647; Thu, 27 Feb 2025
 05:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213190119.3449103-1-matt@readmodwrite.com>
 <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
 <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
 <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com>
 <Z8BY_AZPQQm0BJTu@gmail.com> <CAFULd4aCBMXcco_GdTYu9Zmc5A6+Z=J4XrsjLXWe1dydRD0oDQ@mail.gmail.com>
 <Z8BekITYkuc4F4b1@gmail.com>
In-Reply-To: <Z8BekITYkuc4F4b1@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 27 Feb 2025 14:35:33 +0100
X-Gm-Features: AQ5f1JorbHPwjE3-2yO0d1g4rFj_UfCZcf4xd4xv-ZTHEsObbL_-_R55Q19Z1dQ
Message-ID: <CAFULd4YsMAqqVApUdtib-n6JuaFzyOXmi3fBuUNKdnnNKK=iig@mail.gmail.com>
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
To: Ingo Molnar <mingo@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>, Jakub Jelinek <jakub@redhat.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: multipart/mixed; boundary="000000000000642d51062f1fc4f6"

--000000000000642d51062f1fc4f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:46=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Thu, Feb 27, 2025 at 1:22=E2=80=AFPM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > On Mon, Dec 16, 2024 at 5:20=E2=80=AFPM Matt Fleming <matt@readmodw=
rite.com> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2024 at 1:17=E2=80=AFAM Uros Bizjak <ubizjak@gmai=
l.com> wrote:
> > > > > >
> > > > > > Does your config include CONFIG_UBSAN_BOOL=3Dy ?
> > > > >
> > > > > Yes, it does!
> > > > >
> > > > > > There is a rare interaction between CONFIG_KASAN and CONFIG_UBS=
AN_BOOL
> > > > > > (aka -fsanitize=3Dbool), reported in [1] and fixed for gcc-14.2=
 in [2].
> > > > > >
> > > > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736#c42
> > > > > >
> > > > > > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115172
> > > > > >
> > > > > > Otherwise, please attach your .config, and I'll look into this =
issue.
> > > > >
> > > > > Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels =
boot again.
> > > > >
> > > > > Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?
> > > >
> > > > No, this is a very rare Oops that triggers only with gcc-14.1 versi=
on
> > > > and only when both KASAN and UBSAN are enabled. This is actually th=
e
> > > > problem with sanitization of the percpu address when named address
> > > > spaces are enabled (IOW, sanitization of __seg_gs prefixed address)=
.
> > > > UBSAN creates a temporary in memory, but forgets to copy memory tag=
s,
> > > > including named address space qualifier from the original. Later AS=
AN
> > > > sanitizes this location as a normal variable (due to missing
> > > > qualifier), but actually should be disabled for __seg_gs prefixed
> > > > addresses.
> > > >
> > > > Your report is only *the second* since sanitizers were re-enabled w=
ith
> > > > named address spaces. gcc-14.2 that includes the fix is available
> > > > since August 2024, and since sanitizers are strictly development
> > > > tools, my proposed solution would be to simply upgrade the compiler=
 to
> > > > gcc-14.2 release.
> > >
> > > So unless this is difficult to test for, it would be nice to have a
> > > compiler version cutoff for the feature. Especially if it's been
> > > reported twice already, chances are that a lot more people have
> > > experienced it already.
> > >
> > > The kernel build should avoid this known oops automatically.
> >
> > The patch could be as simple as:
> >
> > --cut here--
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 95ea2b4b95db..c94c37889917 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2370,7 +2370,7 @@ config CC_HAS_NAMED_AS
> >      depends on CC_IS_GCC
> >
> >  config CC_HAS_NAMED_AS_FIXED_SANITIZERS
> > -    def_bool CC_IS_GCC && GCC_VERSION >=3D 130300
> > +    def_bool CC_IS_GCC && GCC_VERSION >=3D 140200
> >
> >  config USE_X86_SEG_SUPPORT
> >      def_bool y
> > --cut here--
> >
> > but it will disable all sanitizers for a very rare Oops that needs the
> > combination of CONFIG_KASAN and CONFIG_UBSAN_BOOL.
>
> Can we not limit the version quirk to KASAN && UBSAN_BOOL?

I am testing the attached patch that resolves the issue.

Thanks,
Uros.

--000000000000642d51062f1fc4f6
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m7ndzw2b0>
X-Attachment-Id: f_m7ndzw2b0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnCmluZGV4IDk1
ZWEyYjRiOTVkYi4uYjkyZTBjM2Y3ZjE5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9LY29uZmlnCisr
KyBiL2FyY2gveDg2L0tjb25maWcKQEAgLTIzNjksMTggKzIzNjksMjAgQEAgY29uZmlnIENDX0hB
U19OQU1FRF9BUwogCWRlZl9ib29sICQoc3VjY2VzcyxlY2hvICdpbnQgX19zZWdfZnMgZnM7IGlu
dCBfX3NlZ19ncyBnczsnIHwgJChDQykgLXggYyAtIC1TIC1vIC9kZXYvbnVsbCkKIAlkZXBlbmRz
IG9uIENDX0lTX0dDQwogCisjCisjIC1mc2FuaXRpemU9a2VybmVsLWFkZHJlc3MgKEtBU0FOKSBh
bmQgLWZzYW5pdGl6ZT10aHJlYWQgKEtDU0FOKQorIyBhcmUgaW5jb21wYXRpYmxlIHdpdGggbmFt
ZWQgYWRkcmVzcyBzcGFjZXMgd2l0aCBHQ0MgPCAxMy4zCisjIChzZWUgR0NDIFBSIHNhbml0aXpl
ci8xMTE3MzYgYW5kIGFsc28gUFIgc2FuaXRpemVyLzExNTE3MikuCisjCisKIGNvbmZpZyBDQ19I
QVNfTkFNRURfQVNfRklYRURfU0FOSVRJWkVSUwotCWRlZl9ib29sIENDX0lTX0dDQyAmJiBHQ0Nf
VkVSU0lPTiA+PSAxMzAzMDAKKwlkZWZfYm9vbCB5CisJZGVwZW5kcyBvbiAhKEtBU0FOIHx8IEtD
U0FOKSB8fCBHQ0NfVkVSU0lPTiA+PSAxMzAzMDAKKwlkZXBlbmRzIG9uICEoS0FTQU4gJiYgVUJT
QU5fQk9PTCkgfHwgR0NDX1ZFUlNJT04gPj0gMTQwMjAwCiAKIGNvbmZpZyBVU0VfWDg2X1NFR19T
VVBQT1JUCi0JZGVmX2Jvb2wgeQotCWRlcGVuZHMgb24gQ0NfSEFTX05BTUVEX0FTCi0JIwotCSMg
LWZzYW5pdGl6ZT1rZXJuZWwtYWRkcmVzcyAoS0FTQU4pIGFuZCAtZnNhbml0aXplPXRocmVhZAot
CSMgKEtDU0FOKSBhcmUgaW5jb21wYXRpYmxlIHdpdGggbmFtZWQgYWRkcmVzcyBzcGFjZXMgd2l0
aAotCSMgR0NDIDwgMTMuMyAtIHNlZSBHQ0MgUFIgc2FuaXRpemVyLzExMTczNi4KLQkjCi0JZGVw
ZW5kcyBvbiAhKEtBU0FOIHx8IEtDU0FOKSB8fCBDQ19IQVNfTkFNRURfQVNfRklYRURfU0FOSVRJ
WkVSUworCWRlZl9ib29sIENDX0hBU19OQU1FRF9BUworCWRlcGVuZHMgb24gQ0NfSEFTX05BTUVE
X0FTX0ZJWEVEX1NBTklUSVpFUlMKIAogY29uZmlnIENDX0hBU19TTFMKIAlkZWZfYm9vbCAkKGNj
LW9wdGlvbiwtbWhhcmRlbi1zbHM9YWxsKQo=
--000000000000642d51062f1fc4f6--

