Return-Path: <linux-kernel+bounces-341528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A333098813D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD3D1C21798
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF471BA89D;
	Fri, 27 Sep 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BZkg73XF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994373501
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428997; cv=none; b=GH07oGj0az+p6jnLViK4/TEirm12hALYrkepSAY3cuPqM9E5VgqFONTtcT9GsTOkPoZrXsXKC3Ind7FECLrTeBBgVncz6vz3WkyUG9a4so3dxpS15zQU+LbiM0aSpoU/Z18nQ6VfxAhHqR5Xi7NLVzDU2QD889oR48wfPEqb/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428997; c=relaxed/simple;
	bh=crutcP0xnGvGIZF+MQbEA0++mSe9NvxV4Gn+IsZHwVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfmMN2vGv1vZaIzlOy/8Hl20kGUetaUSst7eej+2DjKMN6Wn/s66bZD9Fgdys5fXwOqR5p/2m7SNbjBbLKyhLdPaI+qxx9lOr82CkStgWOFL3YFUynHRrfeThLT/U1gbmTP11Xpr2UnY06lpZJALTAVpTZMxvtl6Bk9bgF8/UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BZkg73XF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso3318625a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1727428994; x=1728033794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqf7J6uVRTMjV8Mkr5LkK+rt2+orKvSYQp47d/slH6I=;
        b=BZkg73XFwjMYfwPiG8VagS2CmPJkKBqperLhKucETsr8ZzpysPIJp1kXtBuJCIBKxq
         SiULOcfRXImdGya5juW3WUPwkl1SeshJtAr6ll8Nckcf/f46msZiuO218aboQ5QCFAZM
         qcazQczegIF/HlU9phJ6NBGmjKIKJMHgmlQJtY/svK8RYwbGSAYAoJtXgZT/HNucu8Qd
         2ZvoZPF+Cnjy1VPZxiKXRxspQkwo4utC2uYnpeSBptPY2IFPLo5bP6QX2t4c64ISFpOc
         dDJCXrlgSifz/bb+pslFaRSHB3OGzLcF28SzHiGOborb51v1YVyw8i5huhEUyV4luQIF
         lYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428994; x=1728033794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqf7J6uVRTMjV8Mkr5LkK+rt2+orKvSYQp47d/slH6I=;
        b=MdCLUuooLbsL5PcVwHdNGNSGzbvU/zOFAShE7nktK8X6bCpwMl6u6k/G10k5VIs8B4
         dcjC4qYPDbtetr3xRcR5GgvOeH/9ojHfZt208206h8nez9H4+ACJCON5Rc0ugdV93FSQ
         Gya7cSJmRGK9STHYXNBcmkBhkAkOjEhIdUDG2Qv3u4a81tbdlQrAUnrvC3fM4BvrXdiq
         EPFCLi3+HEvnbBL1NAKnr12pcuGboKN+9PozC3oEly4Sz1ScHJidaXajxYZYHufd3/9V
         tayeIzh18GOuLTY5SIJ57HJYQyHmIZHAk9mp8asggaB8g6C092ooLYXYG3kdnzQUgHaw
         qeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXajCkDIPIuxXPZQ5es1+TPfr97q88XyvjzzB+dzcgZfOuEPNBsDXB+/97ofF67XJ/s7VOFBK92fi3DSWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy916Sgaa0Y8hfg4x7lreeLars4bDYNszBt1J9k2ataCPN2Bzti
	05NTi2fs3jBmlYGhkEDrlVmvJ/D4tVW5RWwXJsr5fbFTGFnmz+HYlAtp4+5wIv46UsffpI/NBTU
	ThljEOpOqSLg21VyhG/1poPya/BLXS/c7GO6Brw==
X-Google-Smtp-Source: AGHT+IFGU7PYEBeWJ9XyJiJyw2tA09AFezreXCXdZppeh4nf2YQMIVbOaLNTp72I5G5qbddr12Ia8AF3t2lz4EjKMB4=
X-Received: by 2002:a05:6402:230e:b0:5c3:cc1c:4d9c with SMTP id
 4fb4d7f45d1cf-5c8777eae4amr5673166a12.18.1727428993884; Fri, 27 Sep 2024
 02:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com>
 <20240920-dev-maxh-svukte-rebase-v1-1-7864a88a62bd@sifive.com> <20240921-shock-purge-d91482d191a1@spud>
In-Reply-To: <20240921-shock-purge-d91482d191a1@spud>
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 27 Sep 2024 17:23:02 +0800
Message-ID: <CAHibDyxcxe87mTLMkWZ9Ko3v7uyEbJd_BP7GSTpZFFO1nfmn0A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] dt-bindings: riscv: Add Svukte entry
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Conor,
I will modify the format and send it as RFC v2.

Since the Svukte extension is still in the review stage, I will put
the latest commit of the PR in the riscv-isa-manual as an indication,
Once the Svukte extension is ratified, I will modify it and send it as
a formal patch.

Best,
Max Hsu



On Sun, Sep 22, 2024 at 6:05=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Sep 20, 2024 at 03:39:03PM +0800, Max Hsu wrote:
> > Add an entry for the Svukte extension to the riscv,isa-extensions
> > property.
> >
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index a06dbc6b4928958704855c8993291b036e3d1a63..df96aea5e53a70b0cb89053=
32464a42a264e56e6 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -171,6 +171,13 @@ properties:
> >              memory types as ratified in the 20191213 version of the pr=
ivileged
> >              ISA specification.
> >
> > +        - const: svukte
> > +          description:
> > +            The standard Svukte supervisor-level extensions for making=
 user-mode
> > +            accesses to supervisor memory raise page faults in constan=
t time,
> > +            mitigating attacks that attempt to discover the supervisor
> > +            software's address-space layout, as PR#1564 of riscv-isa-m=
anual.
>
> I'm surprised this doesn't fail dt_binding_check, with the # in it. I'd
> like to see a commit hash here though, in the same format as the other
> extensions using them.
>
> > +
> >          - const: zacas
> >            description: |
> >              The Zacas extension for Atomic Compare-and-Swap (CAS) inst=
ructions
> >
> > --
> > 2.43.2
> >

