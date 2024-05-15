Return-Path: <linux-kernel+bounces-180390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8E8C6DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AE72834C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB615B55B;
	Wed, 15 May 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIlCCFDR"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311E6FBF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808522; cv=none; b=t1W7BfYMaSSL2pLnLL6G0nASdDX/KtvSXrvL5YCKSmBBrBtlmVLI9y3o6oLTUNhbYRMFM+XoF3/AeM208wkL3I/KFJ2nbTc7XA5W8aooC1fg5Mq4rpTtDr/ct40GYLYBJt10eoyPGSH4dXYvo54D7OI6HXdcBoGgbwXaVixhHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808522; c=relaxed/simple;
	bh=qnHnvFuVyROhLpvYWHN3fSpsAcLNu13yLY8dAISoFtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A99gxHVEP9u/IA/fP8dctgalI9yKyyk0T9lSS+415UgQmFOcg2PFPic+RlOq/7Hgds+kOMj8bfqSwyZVduO8nmUmYH5GF64wpgHyefTCi5+/HFekiNRDSSBsSQv5BCugM5ouWIKIMFHa2Emw1nUfk+jQqQ5y8vEgjRJesYZOLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hIlCCFDR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a077a861e7so52177026d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715808518; x=1716413318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UmNEhsA1PVQGVB4IPr+WxtggKmtowmQmNLiJoenwI8=;
        b=hIlCCFDRjbzsptmQLMFlJJI0QOOOuaqcj5XxmM7JwW/o24V9p7fkD4egenqG6xpggn
         GqrFJI5mNqPhCV4enz6+zfWUFtNR8LuLjRNWQVvUfpxgWVse1+8g5iq9ztwK1eldoi/J
         2QtWAJoE1Wfg98mtAZL7Q42pqF8CTuPNDc2yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808518; x=1716413318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UmNEhsA1PVQGVB4IPr+WxtggKmtowmQmNLiJoenwI8=;
        b=MpjqqQVPktHHMpY/G5SXf21yd9d51f3h+10qv9JWkZyr7myie0XUIWm5gsz1iS8iVS
         pORQBnpV+geluRffwZ5qnnUsmmcHgorh+SNvVO9k0dJX4Z8e62OqKsTjVFrOIoeeU7D3
         LAoDALld/5BaLKPio3pJ7ChFTDmMrnMQSzQTqNehi9bwFgIKzU0tYh0n5n0/+/7e+QC+
         pISfKEC0PhNsGCTVqS2GadgcRgd5VnXKHrMLYmjiPBbGuB6DZxNZLxdmONCwzHTsSj3e
         LNac7B6FXeynSivsTRyLsvzl3uxLLA21dZmVuVf33yjjZehVy8xJ/DLFQ9H9WPyY4zxi
         B2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPuj/Ze+8LdArQekczD0G3ajqG3Ih6Ttf0hiAsQdlZYXP6wrnpevd+gxfcXym0C+EHRsG2o4/C7qvhuNUvgO6diQdiVoz0Fsa7P7/O
X-Gm-Message-State: AOJu0YxFlQWoJNmB6UBKrJTJ3eFjgBk/DdyvRUPb9KiNWbckHnRExrV7
	hzKPRpwhx7aT9UllPbjMGrJMexeZqulwhLK+LYOhyVjErbHoEZS1ol/MX1Jreb08AKXgSZYgUMs
	=
X-Google-Smtp-Source: AGHT+IEPQpBTnTiRKcNP+mJtmcbkGZNP+dEA+zv3sGYAmwa4bIA3lgxWGJAXdSyjQP/CF9KecD/tSQ==
X-Received: by 2002:a05:6214:4487:b0:69b:5889:8eff with SMTP id 6a1803df08f44-6a168212cfemr194345596d6.43.1715808518576;
        Wed, 15 May 2024 14:28:38 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a166309ba5sm62523246d6.122.2024.05.15.14.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 14:28:37 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43dfe020675so2312221cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:28:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRqvdjAaZdfeAi5LzZ/zwgIISGPWKsxMXK6RkEPzfY75HkMReHM1e5hchiWuHnhOep58Uvg3znG00PWz9T7hWa6SNBrDO7bJYmV28K
X-Received: by 2002:a05:622a:1928:b0:43e:1124:3c4c with SMTP id
 d75a77b69052e-43e11243d95mr12242171cf.28.1715808517355; Wed, 15 May 2024
 14:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com> <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org>
In-Reply-To: <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 15 May 2024 14:28:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
Message-ID: <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
Subject: Re: [v7 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: neil.armstrong@linaro.org
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org, 
	daniel@ffwll.ch, linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 15, 2024 at 2:16=E2=80=AFPM <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 15/05/2024 03:46, Cong Yang wrote:
> > DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_=
NL6.
> > Since the arm64 defconfig had the BOE panel driver enabled, let's also
> > enable the himax driver.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >   arch/arm64/configs/defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 2c30d617e180..687c86ddaece 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=3Dm
> >   CONFIG_DRM_PANEL_LVDS=3Dm
> >   CONFIG_DRM_PANEL_SIMPLE=3Dm
> >   CONFIG_DRM_PANEL_EDP=3Dm
> > +CONFIG_DRM_PANEL_HIMAX_HX83102=3Dm
> >   CONFIG_DRM_PANEL_ILITEK_ILI9882T=3Dm
> >   CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=3Dm
> >   CONFIG_DRM_PANEL_RAYDIUM_RM67191=3Dm
>
> You should probably sent this one separately since only an ARM SoC mainta=
iner
> can apply this, probably via the qcom tree.

Really? I always kinda figured that this was a bit like MAINTAINERS
where it can come through a bunch of different trees. Certainly I've
landed changes to it before through the drm-misc tree. If that was
wrong then I'll certainly stop doing it, of course.

-Doug

