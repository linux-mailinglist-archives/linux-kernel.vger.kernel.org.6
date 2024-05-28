Return-Path: <linux-kernel+bounces-192394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054968D1CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B425C28749F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFFF16F29D;
	Tue, 28 May 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KX+o0AOb"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE616DEC1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902201; cv=none; b=LMn1jbLtCh3R4HBa25BPU4o/IAF4RdFb2qk+MuDAoSP6Ciw2xl2W1V4KfaDlMqjKmSaHEc/CS95oBqvDZ7cl9xY9zUC7JDVJBFimKQzPdbr5QiZCM61T2EbPcR+JCnQGGeEuYEb6d9OsPboA8qyWckZeiySIaTHohXSFitUOmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902201; c=relaxed/simple;
	bh=LUoz2Z7YH8Bk418zn5vn5z/l6JE7CEfbQyLS2RHxegM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6ZxXZ2nW8c2HGYkK4yUOti4xbuhx9zo0MToiCEQKHTMFnDbtzv47Pm0G2ZOa0Pe2uklNYlNceKAbiR7R2KNxSLSWJU7C+GqFiQTR8XEMY+NJGN5Rp95LjScw74Ac7hbWwJCb0ofn8bNH5yRGdmBMWihkJEgAXe4gjreXZOyhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KX+o0AOb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6818811cb8aso534801a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716902200; x=1717507000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMy7d3yNdOpqMd77ZF/zy2rrJf07kj/yM6vzAE/9RAU=;
        b=KX+o0AOba21ckrnL4JvMY5v7oBeXlpAVpkCIifqTiIgJpsznGX3PjybnZxhNnlhdJc
         2Zu1JTAFQFvKamH7Z6BJ0cy+A5UuwxDgCQ+IJB97h6BNXqMAn4I7IsiMJkT/hKk/g+Px
         EU8dRM+yqB6ND2K/8q0WMEh8TmreWFngtQPJE1YF+9KGhrUoGzu//xz3yVxAwmz7qCS9
         KXpgb3BC2k2r8Vnn2nQqq2Y9R3vgk74bvSVnzKb8VnoWDFhYBxaSQYEL+wk75ocwRm00
         TNlbDdKSIkIuy1L3DnQMVkezM0saTAuCpiviQJbW6bFatxEj8f0boCev0A3Nskd+RuQn
         6lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902200; x=1717507000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMy7d3yNdOpqMd77ZF/zy2rrJf07kj/yM6vzAE/9RAU=;
        b=erKbBtOfMXOa5PYY2/qcSe+e9nUubWvQ8+GWB+AoIkt1ac0V2H/5Txj65ijWfn0aHI
         hz9X2DGHzlAD+Nq/bUrUtWVo6DBFGqQKwcYKn/7IKySwEIG5iBZ/Q907KL2KJbJNrdhq
         juUivyjeockll0NAywj2W4EIP1T6DjqcbSKTuO0JL/hhGx4jcz98xsxgm8TUJIoY0TJm
         5xKy0PazRJaWUJ4ynZ7ph7mhPnqy/UEcsP7fqPU3uX13UiCrfssLg30JYfBtczDzdfWC
         XCUvvAwKs4ErLo3FBzPZv3vNdDiJaJp4pZ8cqla1GuKCZlJEjU1P3xIeuQvJ6Wy0GlD9
         WmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV6hrmWdRSPdlcf9Wz2qmdtuP3+1K1C+ICyQZTQPKR3SW0DpsecSjiVBj3bhPzq/x2bzfTMG+e4gIJP3H9LUbbN3CXlVCbziE9zC0b
X-Gm-Message-State: AOJu0Yx7NCWkGSaLGD1LVvxZQIyR93Prd3ornAuYbngNQGcj+/eu2LkF
	bv6vSFLECy54mP9OhAIvlUnviRPIhKgJN+k3aEAZJkdKIHeViMizDVv5HL8jRk7wpTwy0WBztQB
	Ia+oY0hjERdc+ZUamKsXuUypooPT5xBAK3nva9w==
X-Google-Smtp-Source: AGHT+IHspkrG6W4zRKwlxVNAppmAeEBlw6gj1LvinbY9kZFql6H3eexc9cOPVdVxPozgIm9yjGMMMa39TQ/eyvDIfFM=
X-Received: by 2002:a17:90a:a103:b0:2bf:e9cd:c858 with SMTP id
 98e67ed59e1d1-2bfe9cdd3d3mr3711458a91.17.1716902199614; Tue, 28 May 2024
 06:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-dtbo-check-schema-v1-1-ee1094f88f74@linaro.org> <CAL_Jsq+cmNmm4we6B6OdeS_Qty44FxKmtZHDjLBi9f=DaBw4GA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+cmNmm4we6B6OdeS_Qty44FxKmtZHDjLBi9f=DaBw4GA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 16:16:27 +0300
Message-ID: <CAA8EJpoeGTitM1vYg712Q2fFPenJJvvA7HS7GBA9pqY87zbOjw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: verify dtoverlay files against schema
To: Rob Herring <robh@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 at 16:15, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 27, 2024 at 6:34=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Currently only the single part device trees are validated against DT
> > schema. For the multipart schema files only the first file is validated=
.
>
> What do you mean by multipart schema files? Did you mean multipart DTs
> (i.e. base plus overlays)?

Yes, multipart DT files, dts + dtso =3D> dtb + dtbo =3D> final dtb

>
> Looks good otherwise and I can fix that up.

Awesome, thanks!

>
> > Extend the fdtoverlay commands to validate the resulting DTB file
> > against schema.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  scripts/Makefile.lib | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 9f06f6aaf7fc..29da0dc9776d 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -407,8 +407,15 @@ cmd_dtc =3D $(HOSTCC) -E $(dtc_cpp_flags) -x assem=
bler-with-cpp -o $(dtc-tmp) $< ;
> >                 -d $(depfile).dtc.tmp $(dtc-tmp) ; \
> >         cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> >
> > +DT_CHECK_CMD =3D $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_=
BINDING_DIR) -p $(DT_TMP_SCHEMA)
> > +
> > +ifneq ($(CHECK_DTBS),)
> > +quiet_cmd_fdtoverlay =3D DTOVLCH $@
> > +      cmd_fdtoverlay =3D $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(=
real-prereqs) ; $(DT_CHECK_CMD) $@ || true
> > +else
> >  quiet_cmd_fdtoverlay =3D DTOVL   $@
> >        cmd_fdtoverlay =3D $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(=
real-prereqs)
> > +endif
> >
> >  $(multi-dtb-y): FORCE
> >         $(call if_changed,fdtoverlay)
> > @@ -421,7 +428,7 @@ DT_BINDING_DIR :=3D Documentation/devicetree/bindin=
gs
> >  DT_TMP_SCHEMA :=3D $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> >
> >  quiet_cmd_dtb =3D        DTC_CHK $@
> > -      cmd_dtb =3D        $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS=
) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > +      cmd_dtb =3D        $(cmd_dtc) ; $(DT_CHECK_CMD) $@ || true
> >  else
> >  quiet_cmd_dtb =3D $(quiet_cmd_dtc)
> >        cmd_dtb =3D $(cmd_dtc)
> >
> > ---
> > base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> > change-id: 20240527-dtbo-check-schema-4f695cb98de5
> >
> > Best regards,
> > --
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >



--=20
With best wishes
Dmitry

