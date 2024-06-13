Return-Path: <linux-kernel+bounces-214126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796B907FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38AF1F21D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8F14EC49;
	Thu, 13 Jun 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrV8AOyH"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181D80624
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322420; cv=none; b=ZusxWTCEnQQiK2+OHeJXPICMhXvM1bpgqZr5OERHQNS2d8Dv3R7mhKsKdM58sqYF756lBGPUm7u/jm2akx6vTyNOFv3KsPHqBzQLs92MEJ2HYCgAH12E95EA0FfQMS+C+iPmu1lqh++Ow7BFlIspE5eUQJ+wN6bN1UyjIEGEtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322420; c=relaxed/simple;
	bh=wP/HLGKUMKt2CBNQYC7OtGWy1rIdw+mGfSWEcQsldfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfDzIL5qdVpoytS51CN5D6dIGoqWGtPzSF9h8Y9CklIM7KSuNwtAI+zj1APpQD+mvR99LAS/LPYdonkhqG5uYQ7kbZ7lNspPRFZ2o8OJqY5MLLKEZLgtNn29KrNw0q4pGx3c1riodkuXp/oo8WsPghRd0bgJYreY+78RRcvkP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hrV8AOyH; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff0067a263so1865204276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718322416; x=1718927216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEs/MJ91AXBCx+XV1sNfRd2WKurEXTx/CpAA2PzFqNM=;
        b=hrV8AOyHdh++RZd/9WPz8DMuOZg7kYSGU51+kmSakyc7KmdzD40Xa5zkd8hdkDbcw8
         CjpwtesLjVBCl6jpp3WMOcwlMFrpHeCxMu7r7K7tjOcLp43/sNE+oZ9kY4QCR4n9PzFY
         I7gHK7m8Rhlz/GoeNXsWQTCahm42FdXRx0z7bm8GrDKMLITzQ+UkHRfLw8Lck3ZX3ajU
         DPbNKh7IWinvlBurctFF3NNkb5e37QdiElm3qK+Dvf+Hn1Z4Y5dP8aPHPbp8Qec0Eb18
         jJVNrUvJKvyM1eShLGaYBAVTzGRcmmBkd590SFih8zHbbFQC1Iqq1ip6lpNwL0Mgk10V
         30Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718322416; x=1718927216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEs/MJ91AXBCx+XV1sNfRd2WKurEXTx/CpAA2PzFqNM=;
        b=tskTz+k0trf9wL6Uly+mUyx9DsPlhfVx6RK53XRADCxAnhCF0XEiBK1ulbHMKQkr/v
         UE0DTPmyjmyjHI03BSI0RAZxXU7MhoDNWIIbpLYsZ5IyfkP8F9rhm/o6eQ+fvS3+MkJa
         uD/sTHmGq1g+t16DfEIjcJN3jVr2DWHJjBRCtA/pn7lIQlR9C2c2gZicYjHHoPL4qJpe
         675izCd1Bid+HeTB8aXZ1MBh7qd9se/JGXbcE82D5ui0F40QxEo+oJ5weYnGYu1SOJZS
         9WEqI2NHhgYAdB55k41h/kYo3L1h/OJn0cntmvd0uS7rF8qdGYZqF9Hl/S02UDFIVnIF
         zSgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTK42aWa5XOar2z3euJqtUr2gAlDLhySEfEzg1mn2ug1XzEXcQngT7NKokOhOTnG7MDeWT4tAA47YZ16FJZvNV9ubH6slctjKz0ep
X-Gm-Message-State: AOJu0YwfDQPiyqSeVfQJGM4jkB6kTcFEoW37ReQdcElc8+FQdC6RXjHL
	SAcsRZyjikT1SQPs+NWPtkbyb1piXyWfwSvpWzg9HQq5qvfp3PTEFWcJSzkjCEd5qAWzXs14yJe
	UthlygK8l2hqRv16SrCPvPqhLOxcGsW0FeRFeCg==
X-Google-Smtp-Source: AGHT+IGiJhJpFryify+qxF19/kgtKnn7FCRMi3GgkxofxcO1FwYT0lIDH0lAFLgNph1HdwztGXlRBE4vuQOGf1kjVqA=
X-Received: by 2002:a25:2fd7:0:b0:dfd:a575:f309 with SMTP id
 3f1490d57ef6-dff15343238mr988582276.4.1718322416407; Thu, 13 Jun 2024
 16:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-dtbo-check-schema-v1-1-ee1094f88f74@linaro.org> <CAL_Jsq+cmNmm4we6B6OdeS_Qty44FxKmtZHDjLBi9f=DaBw4GA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+cmNmm4we6B6OdeS_Qty44FxKmtZHDjLBi9f=DaBw4GA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 02:46:45 +0300
Message-ID: <CAA8EJpqgjeLd138ABGBusvitCQcPee5x9LvyJDgsJNQyeD97qg@mail.gmail.com>
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
>
> Looks good otherwise and I can fix that up.

This patch was sent two weeks ago. Is there anything on me with respect to =
it?

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

