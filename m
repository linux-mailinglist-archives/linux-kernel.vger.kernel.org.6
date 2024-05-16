Return-Path: <linux-kernel+bounces-181137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D478C77EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D9A1F2313C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313FE147C62;
	Thu, 16 May 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5/vsaRc"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6C145A1D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867395; cv=none; b=kdduMuQLNaOBv399q1fxSeuVJ1TkHl++7uVEkIsPzjd0OhwHv5WJOiixJFdeGIrzxJQ7fo6t/vbg/NuhwP4/ifp2dBjgzeG04NdQVsCDBEbvI1maD2KZkAMMe5a3rIQHMZX2wel9NQMtIUd5vJb/r4GAMKfQuSzn0ha8mwO4aM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867395; c=relaxed/simple;
	bh=F23kPmSKo4nuPfv8aCwqUfEkCmnyZcNsw+mnflyY+fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvrLOP9urjzU+QDHP2zINqULaS+bmoRuM6+lVB2sNC2WP2aiGPMzGgzuL93gRmmjlnkbbJDHbDnRFng3jyKGlwdPilNKQl/oy8vQuCwjeKcRsBB7LXmUlXp4L/Yov0mkRKGQR4YIPWyAnnQpkFN9RFO02UTGgxVzzor+24A/4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M5/vsaRc; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e1cd52db2eso37618139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715867392; x=1716472192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE+d7Cw90alIT6F0UkuVj3O7o7Oab4n1TKo1NXh8d0Y=;
        b=M5/vsaRcOYGvGeq5Q5m5WA5aRdu3xRjUkcE8vz4Uw8K89M8+vMRcNtmWbuNYSn8oo+
         IEvE7uEM2/kULz0s6WfV3boAM+LoY8if1HBXUDOnJdLE1jovur29WeUgdTV8eL5VX2gG
         a81F5THEcP4h0ywhZFPWdQggRYU2D4uyTr1Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715867392; x=1716472192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE+d7Cw90alIT6F0UkuVj3O7o7Oab4n1TKo1NXh8d0Y=;
        b=bWdqbdcSP0AK8lEK5cXxgCK2nGkivnFhmt3n06WnpQlGq6yQZZIzhSgfGHdm3Emntk
         ZL8+z5J0UXFGuJgHHv97t8EQWP0OpVcS7dCykS25kI1vP5bi7rjuTEKxxGtbIsRFTn4v
         wUTjvZ4r01vIuOS5dmBXxTfpcEX5Xp5W2NXPxxQhSR2uZQxu+YqlqtEI/kgBHQz7SrZv
         1GemCaCVi89wIxU5mczpGcq3F6yg5zMydO4SH3gz7xuIwBXKVZChdNSeWO3MXA0+5ph0
         v+qvQDGQYX6nrk323sd4VSAoEuOu6QR96FLLrCzz67CT0BuRHJLyi9JHF1wbHREI/gc2
         A7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlw2OE/4aO7JUTsqrpTkfdb4E2D69N9kJfvvZ5yYCMSXS4Gxe7/G89gEUadM9JVkG3CCUc7uJi8ewcmnMygeb2voJfTEptVdlbkwly
X-Gm-Message-State: AOJu0YzcdVKUs0D7TmiQNN1w8qlfTfQifTS6vkp1UjV/TiXwF9r2Ok24
	KRYLUx9wkp0Q0Cxuu9BUeU88ssIrMwPqfYLxm6CASPvaPf8aNBR4WFBDNic/4+B7UsupMCHZIbM
	=
X-Google-Smtp-Source: AGHT+IFAXkHdBLdZOBlZn1rmIvu2ol1RBXZJaGECzAQKJEXkT2AfTFI3KoRlbTbdM4zoye+oKBLAiA==
X-Received: by 2002:a05:6602:14d:b0:7e1:b3fa:6470 with SMTP id ca18e2360f4ac-7e1b52205abmr1889725439f.19.1715867392559;
        Thu, 16 May 2024 06:49:52 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1b6bd33casm356985539f.55.2024.05.16.06.49.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 06:49:52 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36db330403fso36085ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:49:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrtu43yhf68yP92nQVAEjKal1Aa5Fg4m1ElcH7VQ5+QeMFCMnFrEkT1ei9IUyh156piK0qwf/JEraHwrXR9l04b4x5Coj/KYIEYSuX
X-Received: by 2002:a05:622a:5a8c:b0:43e:398a:b0c0 with SMTP id
 d75a77b69052e-43e398ab190mr5529521cf.12.1715867022285; Thu, 16 May 2024
 06:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com>
 <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org> <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
 <CAHwB_N+foZpCjqUy0dJdS2wBbUjHVRQQP0p7S_eTG1Yrh0bgPw@mail.gmail.com> <7b488473-7fd1-4f4f-8c32-72e84420b478@linaro.org>
In-Reply-To: <7b488473-7fd1-4f4f-8c32-72e84420b478@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 May 2024 06:43:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6mkTwAp6qMVYbPFDYBroAW19-qgvct1dw11ksaW3cYw@mail.gmail.com>
Message-ID: <CAD=FV=W6mkTwAp6qMVYbPFDYBroAW19-qgvct1dw11ksaW3cYw@mail.gmail.com>
Subject: Re: [v7 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: neil.armstrong@linaro.org
Cc: cong yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org, 
	daniel@ffwll.ch, linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 15, 2024 at 11:55=E2=80=AFPM <neil.armstrong@linaro.org> wrote:
>
> On 16/05/2024 08:43, cong yang wrote:
> > Hi:
> >
> > If it is determined that a separately patch needs to be sent, then I
> > will remove this patch in V8 series?
> >
> > Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=881=
6=E6=97=A5=E5=91=A8=E5=9B=9B 05:28=E5=86=99=E9=81=93=EF=BC=9A
> >
> >>
> >> Hi,
> >>
> >> On Wed, May 15, 2024 at 2:16=E2=80=AFPM <neil.armstrong@linaro.org> wr=
ote:
> >>>
> >>> Hi,
> >>>
> >>> On 15/05/2024 03:46, Cong Yang wrote:
> >>>> DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101W=
UM_NL6.
> >>>> Since the arm64 defconfig had the BOE panel driver enabled, let's al=
so
> >>>> enable the himax driver.
> >>>>
> >>>> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> >>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>>> ---
> >>>>    arch/arm64/configs/defconfig | 1 +
> >>>>    1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defco=
nfig
> >>>> index 2c30d617e180..687c86ddaece 100644
> >>>> --- a/arch/arm64/configs/defconfig
> >>>> +++ b/arch/arm64/configs/defconfig
> >>>> @@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=3Dm
> >>>>    CONFIG_DRM_PANEL_LVDS=3Dm
> >>>>    CONFIG_DRM_PANEL_SIMPLE=3Dm
> >>>>    CONFIG_DRM_PANEL_EDP=3Dm
> >>>> +CONFIG_DRM_PANEL_HIMAX_HX83102=3Dm
> >>>>    CONFIG_DRM_PANEL_ILITEK_ILI9882T=3Dm
> >>>>    CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=3Dm
> >>>>    CONFIG_DRM_PANEL_RAYDIUM_RM67191=3Dm
> >>>
> >>> You should probably sent this one separately since only an ARM SoC ma=
intainer
> >>> can apply this, probably via the qcom tree.
> >>
> >> Really? I always kinda figured that this was a bit like MAINTAINERS
> >> where it can come through a bunch of different trees. Certainly I've
> >> landed changes to it before through the drm-misc tree. If that was
> >> wrong then I'll certainly stop doing it, of course.
>
> Yeah we usually don't mess with arch specific defconfig from drm tree

In general I agree that makes sense. In this case, though, the new
config symbol was introduced in the previous patch and split off an
existing symbol. Updating "all" of the configs (AKA just arm64) that
had the old symbol to also have the new symbol seems like the nice
thing to do and it feels like it makes sense to land in the same tree
that did the "split" just to cause the least confusion to anyone
affected.

In any case, if it's going to land in some other tree then I guess the
question is whether it needs to wait a few revisions to land there or
if it should land right away. Nobody would get a compile error if it
landed in a different tree right away since unknown config symbols are
silently ignored, but it feels a little weird to me.

..of course, I'm also OK just dropping the config patch. I personally
don't use the upstream "defconfig". It just seemed courteous to update
it for those who do.

-Doug

