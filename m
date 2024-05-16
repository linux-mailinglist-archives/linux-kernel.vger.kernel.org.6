Return-Path: <linux-kernel+bounces-181156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A68C784A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5C1C21B83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB04814B96D;
	Thu, 16 May 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QGa3b+6C"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C8148FE8
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868610; cv=none; b=Q0bqko+Hug9RN8zD2ruBif0ix2RIQL276u5WdvSTh1Zmgr/rKmIycOLx8VQ5bh2rcMh117qo3wvfxO+dUiiXnLgJmallj6+a1Nbcn56Orj6k024JXVn74Yk0tBLDxRsi39g/xDAcQTKS6yQCDghSOFjrfa6keADEE8EqBtPBaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868610; c=relaxed/simple;
	bh=N2VytWc3Egh8GybUPHjqnBmbFBcIGj8lqmYUdttBX0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ+dY5SDn+WPggdYwrepE3KpES4umcVBbHvka3pHimzE+LcVxHrkm8k74tyaPQXrE5ssQixzDFIpVNWXrIrPb69TT97Z6etaI66NaXr4R95t1grKEyAvEwxoC35GzvRPs1vSEDHjWQwfOJK//vFscznSQXWSDRDGKO9P6l8VunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QGa3b+6C; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792bcfde2baso683636385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715868606; x=1716473406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EFjHqt7hZKMcQ8pOSR62lBmFQVRSCJX/1oVvs7X3b4=;
        b=QGa3b+6C/I4OqvJi+06LT2z3QPxKbHb9ecvUwDtdJoAU+EW18PjZFOBtF/VuHc1FoW
         n8hAJJxuVOPiZRiVVV1BOBcpDr1PmvXhWH11soKwN+ZlF3ImofYJn2tkfn7IayaHEaGc
         u4xCcqiZlu/DeVvnGCW7oP7B7wIxVYOqQl5ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868606; x=1716473406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EFjHqt7hZKMcQ8pOSR62lBmFQVRSCJX/1oVvs7X3b4=;
        b=HbLR6YG0UE1jZSXidGO+Lpetr5UZEXPA52uAeI3JmTtslQ85LO3wy34PePGzZwJNgp
         kGYO293K/zYX/t/WxtD0FDOHdN584Iyy3BHLz+/r1gsJEMCLsJj3gyXnwwA7CKfSH/IC
         2Fg3YrbraOAv1tmfoDxIOqJ4bH2nIkewlHQg8LdLF6dBhVlkL2IrVmFHmj6ouoNIoWnK
         2lvrrWjwM4CKsiRJzON5O+08pvWESSo4hZ0ULkE9o2FXYGgcAZDL8AnTZeAcUbj8dVcD
         kDclaZN/XIYzaxs3510dSMCPFQlT3PaejiD70/qDrBnLGnoPRxxRBksqSxtHxKBuQn9B
         dXHw==
X-Forwarded-Encrypted: i=1; AJvYcCUGixTBxYDHCZ7WU3dDn3LCk5ve0Aiq14R4vJCzSgD9U9834kVyBmpnnUb5YPKfKSaL6oY1WYr4Ay3SZ+SUAH6OvSeBVwkSW2IZTeVi
X-Gm-Message-State: AOJu0Yx9k2nvRBlpdPAUJUOzxTvepVFvqbhv5JxxAYFokTpWa5ehbQhp
	WGNoop5GpOr3S/pgskJsLMn6cxjlscjpTRucnyjVuR/23A05bpFx/5Hw7JUNk0t+yh/GuspODTY
	=
X-Google-Smtp-Source: AGHT+IGF5ki1FPT5QQsD+aBCVa3ZaBemFqvWAOaBnfg8pEPyZu+12FEgWy4CU+E8RE1fukDDRKF6dg==
X-Received: by 2002:a05:620a:d84:b0:792:c320:7b6c with SMTP id af79cd13be357-792c760e2c0mr2495863885a.63.1715868605902;
        Thu, 16 May 2024 07:10:05 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275861sm806015685a.19.2024.05.16.07.10.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 07:10:04 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43df9ac3ebcso2682481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:10:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrguThX3cXX3Ox/sj7oqYjvFUzab5JmXHNbZcZ52dA50DFWrTh/p+0fOrnVElwRcPNVWJNBU9gWKthh3QBjpxFGMOQgk0FW7h0ztjM
X-Received: by 2002:a05:622a:a14:b0:43b:6b6:8cad with SMTP id
 d75a77b69052e-43e094b2023mr16912951cf.10.1715868603433; Thu, 16 May 2024
 07:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com>
 <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org> <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
 <CAHwB_N+foZpCjqUy0dJdS2wBbUjHVRQQP0p7S_eTG1Yrh0bgPw@mail.gmail.com>
 <7b488473-7fd1-4f4f-8c32-72e84420b478@linaro.org> <CAD=FV=W6mkTwAp6qMVYbPFDYBroAW19-qgvct1dw11ksaW3cYw@mail.gmail.com>
In-Reply-To: <CAD=FV=W6mkTwAp6qMVYbPFDYBroAW19-qgvct1dw11ksaW3cYw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 May 2024 07:09:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0Gq8mkdbF_94=H=G9k6UwjUa43eaxCjU-vZwMxSg+8g@mail.gmail.com>
Message-ID: <CAD=FV=W0Gq8mkdbF_94=H=G9k6UwjUa43eaxCjU-vZwMxSg+8g@mail.gmail.com>
Subject: Re: [v7 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc: cong yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org, 
	daniel@ffwll.ch, linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 6:43=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, May 15, 2024 at 11:55=E2=80=AFPM <neil.armstrong@linaro.org> wrot=
e:
> >
> > On 16/05/2024 08:43, cong yang wrote:
> > > Hi:
> > >
> > > If it is determined that a separately patch needs to be sent, then I
> > > will remove this patch in V8 series?
> > >
> > > Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=
=8816=E6=97=A5=E5=91=A8=E5=9B=9B 05:28=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > >>
> > >> Hi,
> > >>
> > >> On Wed, May 15, 2024 at 2:16=E2=80=AFPM <neil.armstrong@linaro.org> =
wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> On 15/05/2024 03:46, Cong Yang wrote:
> > >>>> DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV10=
1WUM_NL6.
> > >>>> Since the arm64 defconfig had the BOE panel driver enabled, let's =
also
> > >>>> enable the himax driver.
> > >>>>
> > >>>> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com=
>
> > >>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >>>> ---
> > >>>>    arch/arm64/configs/defconfig | 1 +
> > >>>>    1 file changed, 1 insertion(+)
> > >>>>
> > >>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/def=
config
> > >>>> index 2c30d617e180..687c86ddaece 100644
> > >>>> --- a/arch/arm64/configs/defconfig
> > >>>> +++ b/arch/arm64/configs/defconfig
> > >>>> @@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=3Dm
> > >>>>    CONFIG_DRM_PANEL_LVDS=3Dm
> > >>>>    CONFIG_DRM_PANEL_SIMPLE=3Dm
> > >>>>    CONFIG_DRM_PANEL_EDP=3Dm
> > >>>> +CONFIG_DRM_PANEL_HIMAX_HX83102=3Dm
> > >>>>    CONFIG_DRM_PANEL_ILITEK_ILI9882T=3Dm
> > >>>>    CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=3Dm
> > >>>>    CONFIG_DRM_PANEL_RAYDIUM_RM67191=3Dm
> > >>>
> > >>> You should probably sent this one separately since only an ARM SoC =
maintainer
> > >>> can apply this, probably via the qcom tree.
> > >>
> > >> Really? I always kinda figured that this was a bit like MAINTAINERS
> > >> where it can come through a bunch of different trees. Certainly I've
> > >> landed changes to it before through the drm-misc tree. If that was
> > >> wrong then I'll certainly stop doing it, of course.
> >
> > Yeah we usually don't mess with arch specific defconfig from drm tree
>
> In general I agree that makes sense. In this case, though, the new
> config symbol was introduced in the previous patch and split off an
> existing symbol. Updating "all" of the configs (AKA just arm64) that
> had the old symbol to also have the new symbol seems like the nice
> thing to do and it feels like it makes sense to land in the same tree
> that did the "split" just to cause the least confusion to anyone
> affected.
>
> In any case, if it's going to land in some other tree then I guess the
> question is whether it needs to wait a few revisions to land there or
> if it should land right away. Nobody would get a compile error if it
> landed in a different tree right away since unknown config symbols are
> silently ignored, but it feels a little weird to me.
>
> ...of course, I'm also OK just dropping the config patch. I personally
> don't use the upstream "defconfig". It just seemed courteous to update
> it for those who do.

Hmmm, probably should have put Arnd on this thread. Added now in case
he has any opinions. I also did manage to find when this last came up
where I was involved. At that time Will Deacon (who get_maintainer.pl
reports is the official maintainer of this file) said [1]:

> But yes, although there are a few things I really care about
> in defconfig (e.g. things like page size!), generally speaking we don't
> need to Ack everything that changes in there.

[1] https://lore.kernel.org/linux-arm-kernel/20201112004130.17290-1-diander=
s@chromium.org/T/

