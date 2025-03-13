Return-Path: <linux-kernel+bounces-558641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8791AA5E8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842067AAF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2686AAD;
	Thu, 13 Mar 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YIEHAMzx"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B72E338A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825323; cv=none; b=OGLfXTj0GrpVj+zvdYcKPWkhyG8GfzuDEEM9zhIHC697WwtiJUgit2ee0xLbOf31CzrFKjBRr6OoEGFYP89/6i3lfjRzBtTdwWtBrcoa62Z0TjreZIuVHvDMxl8kmWTK0/R3oBDKy1+WJqNu5B/noSmIhKB4uMNrsrAmZZGxphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825323; c=relaxed/simple;
	bh=fK/ohTw/TsMcFwnx5IOHOIwz5L34zy93o4wP2Ns5sac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDpl6BMvKZcQlb/Ws1PbKoaRRUV0HiGEsLSw0s/C4GKSIcYLmkfe7uyiDF9XSlq6460Fi75WXzyugZ7zc7JaT+wSCb9p5NgeTGAPRqeSclbIftBBxhx8GQmE3NS6S29HiEdwA/K7dzD9ppXqo2xa+iFlSYKWsRPNe0jfnZCgwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YIEHAMzx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso4255651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741825319; x=1742430119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve1CmfI0K+KYT8TLuMs4lWO1u62BwBHsIfFJVhmEIVY=;
        b=YIEHAMzxQyH8q/NuDyktO+7lbI9WFxQDxs1Gbi/x5utyDLRCQmd53gNrqIqn4FC8Js
         A1oGTs+FakVUKAmq8DgF9me6sdIFjQw+rZramji8ulC4ZdSL/cNGi7gdknIEaGDr35As
         5mXMACUOGReV5BZ1AXdczAs8RC0MiUKxBArho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825319; x=1742430119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve1CmfI0K+KYT8TLuMs4lWO1u62BwBHsIfFJVhmEIVY=;
        b=JH/VQggSdF3itmWk82XCMCz/0HUP8srv+wuk89MjD9VHJQK67A9wirDDQkkdnCaGuR
         omVmhW93fqIvQoJIhuST2fapqPUiMjvQbYRyajym5DnECtQP8PxKVCi+TYwxZa2KkP+D
         ZuGse/aniAWtoAET9RE5LXgD126BUu8EnAUyXCpfPdlHWklvu3TXtnp/Wkfse/rBAwcm
         T3vwAu1UVrgZR0CD8g8Pe5PAGPAIke83Bp0OPZfrIxoy5sBa0L0FgEcL03neWdOF/iY9
         BdQfAM7HcZ4Bm8vnst6mtxXhL3B6gNlRso5fczsu2n6Yfyq00liWyeAm8FO9pKPGl7/k
         xi1A==
X-Forwarded-Encrypted: i=1; AJvYcCVkXc+wsDeAHjRzY2Ov2trAxS33pXryZcvwkuR3PKlLsip7Yanjh54zERE1gV0cyg8gGeXdQ0T6H9SmCvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5gxEBToVd9dYSJdiuIbQd3gBHfE0pAG3wM0+SRUUobG6tCfX
	yUNJUnINQ89/sBP9OlNkdVsN8AvWsCyS2zeunUxGk0xzmCUbabrXRW0QfEnkcxvlPHXEPIMDT0D
	rnh3V
X-Gm-Gg: ASbGnctDMmsjxTl7esevFnOv6nzY4qBP8wmKgiosO7NkLlgiMoMt+uoOV+kPB+t6LD2
	udmmvOturpqnyJswAEQma/6b0PLZps4dEMC1HkyepDhGazPga+A9HVeAR/2KByhRCWF/R2AYBE0
	VTl0PgERovAOHNQ6qXnS4TzY+Z1LCXF2RhazOa8KMafWviflHIVQrR9AgLdr+Gb0tXxQ2PFuEH0
	zbkGSCetQo2t/AeRWE2wagP5EVhl2V5AxeEpti/PvO2Oe6mrJ8fsYdirHRZ/pgsk1+qXpe7rDp0
	AJ/qw5LHwIGxqeRYjm/h38A5DYNecz8R2+bceZZ2zle8jIpn0CsZ+tI7USAxBKiDfC40gTJVLHX
	fswEZq3Xz
X-Google-Smtp-Source: AGHT+IEl0zHmabh4gyjxtyqbmsROM4LqPh54oFN03IJOqqObVNZO+hcl0qjDXBP88tiE9fV3hEqBIw==
X-Received: by 2002:a2e:99ce:0:b0:30b:e936:e832 with SMTP id 38308e7fff4ca-30c3de187eamr1869971fa.13.1741825319359;
        Wed, 12 Mar 2025 17:21:59 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1ec0f4sm147731fa.109.2025.03.12.17.21.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 17:21:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499da759e8so1683344e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:21:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj4NXSg/Pt7zQtdypQmOOvBSqtRwFzq8IIyM6Yn5sOgL1CRhgmBoYLGbAXLZtXQYCJGH6UeCGDDEMGWZc=@vger.kernel.org
X-Received: by 2002:a05:6512:3c8a:b0:545:2474:2c9b with SMTP id
 2adb3069b0e04-549ba428698mr204467e87.22.1741825317941; Wed, 12 Mar 2025
 17:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>
 <20250311-warm-icy-rottweiler-cefcdd@houat> <CAN9Xe3Qwu=E=VVZZ_8EHPF7Xsk6Zcbp=R_b=cRgF=9SWCkmsqA@mail.gmail.com>
 <CAD=FV=XdngrNhUn8jQ3FGitkBCkiQO1dXnPhCKj+S5Jo8_WUrQ@mail.gmail.com> <CAN9Xe3RQ_L5a+PbXCBbzpn3VxyWEL1_wqA5trY0h=Xj-YMcA1g@mail.gmail.com>
In-Reply-To: <CAN9Xe3RQ_L5a+PbXCBbzpn3VxyWEL1_wqA5trY0h=Xj-YMcA1g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 17:21:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJDHAdDCD=Mhffawuz8U7=MkzDueXmAvKpJ-o5eOT6DQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqR2ONbIt8VCOUlU6wE07GPZEZIhiBEtbAX58jcej3ZuGEyEk_GhqGWc0o
Message-ID: <CAD=FV=WJDHAdDCD=Mhffawuz8U7=MkzDueXmAvKpJ-o5eOT6DQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Maxime Ripard <mripard@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	Michael Trimarchi <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 12, 2025 at 5:00=E2=80=AFPM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
>
>
> On Wed, Mar 12, 2025 at 11:48=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
>>
>> Hi,
>>
>> On Wed, Mar 12, 2025 at 8:06=E2=80=AFAM Anusha Srivatsa <asrivats@redhat=
.com> wrote:
>> >
>> >> > @@ -106,53 +107,46 @@ static int r63353_panel_power_off(struct r633=
53_panel *rpanel)
>> >> >  static int r63353_panel_activate(struct r63353_panel *rpanel)
>> >> >  {
>> >> >       struct mipi_dsi_device *dsi =3D rpanel->dsi;
>> >> > -     struct device *dev =3D &dsi->dev;
>> >> > -     int i, ret;
>> >> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>> >> > +     int i;
>> >> >
>> >> > -     ret =3D mipi_dsi_dcs_soft_reset(dsi);
>> >> > -     if (ret < 0) {
>> >> > -             dev_err(dev, "Failed to do Software Reset (%d)\n", re=
t);
>> >> > +     mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
>> >> > +     if (dsi_ctx.accum_err)
>> >> >               goto fail;
>> >> > -     }
>> >>
>> >> This changes was definitely not what the script is doing.
>> >
>> >
>> > It isnt. Using coccinelle for the major part of pattern matching and r=
eplacing the newer _multi variant API. Some handling (including a newline t=
hat it introduces) and  the returns depend on a case by case basis, which h=
ad to be done manually.
>>
>> ...and now you're getting to see why I didn't think a coccinelle
>> script could fully handle this task. ;-) IMO instead of trying to get
>> a coccinelle script to do the full conversion, the right approach
>> would be to use a coccinelle script (or equivalent) to get the basics
>> done (just so you don't make any typos) and then cleanup the result
>> manually. Spending more time on the coccinelle script than it would
>> take to do the conversion manually is probably not the right approach.
>>
>> If your patch wasn't fully generated by a coccinelle script you should
>> document that in the commit message. Something like "Initial patch was
>> generated by a coccinelle script and the result was cleaned up
>> manually." If the script is too long to fit in the commit message,
>> it's fine to put it somewhere online and provide a link. "Somewhere
>> online" could easily be a mailing list post.
>>
>
> You know I have been thinking if it makes sense to have this script merge=
d to coccinelle project and add those details in the commit log.... Was hav=
ing an offline discussion with  @Maxime Ripard today and he rightly pointed=
 out that since it is too specific, once all the conversions are done , the=
 script  would not be further useable....
> About having the script online and providing a link, something link a git=
hub link?

That feels overkill. It seems like you could just send an email to
LKML or dri-devel and then link it that way. It could be in reply to
this thread or a totally separate email. lore.kernel.org links are
great.

-Doug

