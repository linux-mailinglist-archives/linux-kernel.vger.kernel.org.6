Return-Path: <linux-kernel+bounces-337880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5F985099
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC07B21BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCBC13D291;
	Wed, 25 Sep 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYzaRDoV"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10A13C683
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227209; cv=none; b=M+iTK+GSz+3jzrmZjgvjERqSuqDUKtrOSQ458YfuHGpWT/MkL+PVG943FiYm0UTf5qEyYg8q6Xocx4BK9It9EAQzDfwm4X4Y+Cw7EHIMJoP4jkklaL5Ta1MkJWsX0B+eAx+a9Em3So8wSrEEzgdS8pptqn8MrHMeaxlwQNS6Tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227209; c=relaxed/simple;
	bh=NULoKCzRIuNomnWX4SruKfJJ9qFPgKy4sAZ/EnbPYiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dveDpxE0d3ZOUUTfVpcRNDW14Cp5o9kbGS/TBhvcrjNyYGeNud/WTZWC2RmNBIN8IjpjKP2dpTc30pK6+FKBul5BQA0YmNT0ngE9/ZItbnODBh3vL8pfbz7OEJXJnRa+IxsEDMO7QOYEGVudK0c6EVjF9lWVeQwzzuqZ8b2ORYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QYzaRDoV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb6eebfa1so10186075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727227205; x=1727832005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs0AVZk2FLWrt2LrgFC0RhBODHzfoatv725m/+jHwQI=;
        b=QYzaRDoVUIHMDnz1hqU6GuNcWOlr9Td80fXhh8N8leUlTNcvhavnpCLR9S/82WqLmy
         BjsZNTvxzI7JiT9NYacugw/OxSJfodD+Ehj7YWKpkduRwVkIJcTQtIYxi7fBdsJRzaNQ
         9EqwqW1Yh/F+Hq59/oIm6bpaHgF0KMCt40OHCt9mVI62e0k1TnkXjG9kqtht+7v/wu+f
         gYrYZuorD9+bLZVk+vuuBpqT2XPtneVez5kCFg+/PuNN7peldFRzGyiauCOY6B/u/1hQ
         ACwFynIYKGt4IbZ+4VwSX7fLR05TrAdl2Uz0L4iwV6JcbyggMkC127Kzi4Corsc2NVAA
         4KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727227205; x=1727832005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs0AVZk2FLWrt2LrgFC0RhBODHzfoatv725m/+jHwQI=;
        b=Sm9x4E8dKfEnX0BtF18PWJvKfPwmin4XSAfortwVnBvTfQXvTW9Bq5GsTvVM66nvp2
         Ovwx7STvuodOJwKCX+NiV0U4paM4MLuIvz1mrGZa92rd8QjgnL1HGNhQrLRoYL3YZWJK
         HKBQGdqq/yxDKVovbacyH7j42sJRtw29EqHDwZfow8/9hRmyy1xXvoFGF3+qV3IQXZ09
         1P1CeONZ3ljM9Rrh6vkskLvNph5po2/u8NYczjIn6F5cLAoqwr72XYCi4yHDhJLWbWq9
         6AEjWODk4+NPK50RuJt2408nT4pL9nwMGEighk0DNg5n5Yj0ejhA8d8ULtAfO8UvN+Ta
         WG3w==
X-Forwarded-Encrypted: i=1; AJvYcCWjRjjk/CLe/q+C1C4FRrVD8H1ElGBi7tHm2QvsQHFIo2igENOSBmPdEGJieOnybjPPWj5QEo9uLHcsKQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qfocX0t9gW7d082l4EX6IpyyL+CyGkil0jBf0KMxpiNwXvza
	idSFfIj7rk4nAxslqQHhFHEnaNQGPEe1gIdHyO7wrWPZUwdtFADfEUbU0ot0ORLgE83ZcPsj7e0
	unBGyTJWxZshh8qBVvN6BtA5aRiTUIGwY/x/ogA==
X-Google-Smtp-Source: AGHT+IH+iFK7y8aE03rQ6NFQhlZMRzXmQpUxS8kKrhs3d7Nbvecq7OUeXWSs1iydGYss6EL6ah3GJcV3VJl+xbqAqBQ=
X-Received: by 2002:a5d:47c2:0:b0:374:c92b:80a0 with SMTP id
 ffacd0b85a97d-37cc2463ef4mr367129f8f.3.1727227205355; Tue, 24 Sep 2024
 18:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923134227.11383-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240923134227.11383-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <42f0b4b1-87c7-4ebe-94a1-e2ad1a759dd7@quicinc.com> <CA+6=WdTTwXSyqGFGM6mqG3djDBH28mAzBUxUEUdr6z7W2g-A7A@mail.gmail.com>
 <c5f575d9-ea47-4f08-883d-36f01f304d75@quicinc.com>
In-Reply-To: <c5f575d9-ea47-4f08-883d-36f01f304d75@quicinc.com>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Wed, 25 Sep 2024 09:19:54 +0800
Message-ID: <CA+6=WdTuq4rOakKPwnC82twT1yWG09w6bcpztAXQ3p_vQqrnyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel: jd9365da: Modify Kingdisplay and Melfas
 panel timing
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:11=E2=80=AFAM Jessica Zhang
<quic_jesszhan@quicinc.com> wrote:
>
>
>
> On 9/23/2024 7:13 PM, zhaoxiong lv wrote:
> > On Tue, Sep 24, 2024 at 5:14=E2=80=AFAM Jessica Zhang <quic_jesszhan@qu=
icinc.com> wrote:
> >>
> >>
> >>
> >> On 9/23/2024 6:42 AM, Zhaoxiong Lv wrote:
> >>> In MTK chips, if the system starts suspending before the DRM runtime
> >>> resume has not completed, there is a possibility of a black screen
> >>> after waking the machine. Reduce the disable delay resolves this issu=
e,
> >>
> >> Hi Zhaoxiong,
> >>
> >> Do you mean "if the system starts suspending before the DRM runtime
> >> resume *has* completed" here?
> >
> > Hi Jessica
> >
> > Sorry, my description may not be clear enough. It should be when the
> > DRM runtime resume has not yet completed and the system enters sleep
> > mode at the same time.
>
> Got it, yes I think the reworded explanation in your reply is much cleare=
r.
>
> >
> >
> >>
> >>>
> >>> The "backlight_off_to_display_off_delay_ms" was added between
> >>> "backlight off" and "display off"  to prevent "display off" from bein=
g
> >>> executed when the backlight is not fully powered off, which may cause
> >>> a white screen. However, we removed this
> >>> "backlight_off_to_display_off_delay_ms" and found that this situation
> >>> did not occur. Therefore, in order to solve the problem mentioned
> >>> above, we We reduced it from 100ms to 3ms (tCMD_OFF >=3D 1ms).
> >>
> >> So from my understanding of this paragraph,
> >> `backlight_off_to_display_off_delay_ms` was added to prevent the displ=
ay
> >> powering off before backlight is fully powered off. You recently teste=
d
> >> dropping this completely and saw no issue with this.
> >>
> >> If that's the case, why not drop this delay completely?
> >>
> >> Thanks,
> >>
> >> Jessica Zhang
> >
> > Yes, there are currently no other issue after removing this delay.
> > The reason why I didn't completely remove this delay is because the
> > panel spec states that a delay of more than 1ms  (tCMD_OFF >=3D 1ms) is
> > required when entering diaplay_off (0x28H), so I reserved 3ms.
>
> Thanks for the clarification -- I see why you included the "(tCMD_OFF >=
=3D
> 1ms)" part now. Can you please specify in the commit message that the
> tCMD_OFF delay requirement is from the spec?
>
> Also can you remove the extra "We" in "we We reduced it from 100ms to 3ms=
"?
>
> Thanks,
>
> Jessica Zhang

OK, thanks for your correction, we will modify the commit message in
the next patch.

>
> >
> >>
> >>>
> >>> This is the timing specification for the two panels:
> >>> 1. Kingdisplay panel timing spec:
> >>> https://github.com/KD54183/-JD9365DA_Power-On-Off-Sequence_V012024092=
3
> >>> 2. LMFBX101117480 timing spec: https://github.com/chiohsin-lo/TDY-JD_=
LIB
> >>>
> >>>
> >>> Fixes: 2b976ad760dc ("drm/panel: jd9365da: Support for kd101ne3-40ti =
MIPI-DSI panel")
> >>> Fixes: c4ce398cf18a ("drm/panel: jd9365da: Support for Melfas lmfbx10=
1117480 MIPI-DSI panel")
> >>>
> >>> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.c=
om>
> >>> ---
> >>> Changes between V2 and V1:
> >>> -  1. Modify the commit message
> >>> -  2. Modify the value of backlight_off_to_display_off_delay_ms.
> >>> v1: https://lore.kernel.org/all/20240915080830.11318-2-lvzhaoxiong@hu=
aqin.corp-partner.google.com/
> >>> ---
> >>>    drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drive=
rs/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> >>> index 44897e5218a6..486aa20e5518 100644
> >>> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> >>> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> >>> @@ -858,7 +858,7 @@ static const struct jadard_panel_desc kingdisplay=
_kd101ne3_40ti_desc =3D {
> >>>        .reset_before_power_off_vcioo =3D true,
> >>>        .vcioo_to_lp11_delay_ms =3D 5,
> >>>        .lp11_to_reset_delay_ms =3D 10,
> >>> -     .backlight_off_to_display_off_delay_ms =3D 100,
> >>> +     .backlight_off_to_display_off_delay_ms =3D 3,
> >>>        .display_off_to_enter_sleep_delay_ms =3D 50,
> >>>        .enter_sleep_to_reset_down_delay_ms =3D 100,
> >>>    };
> >>> @@ -1109,7 +1109,7 @@ static const struct jadard_panel_desc melfas_lm=
fbx101117480_desc =3D {
> >>>        .reset_before_power_off_vcioo =3D true,
> >>>        .vcioo_to_lp11_delay_ms =3D 5,
> >>>        .lp11_to_reset_delay_ms =3D 10,
> >>> -     .backlight_off_to_display_off_delay_ms =3D 100,
> >>> +     .backlight_off_to_display_off_delay_ms =3D 3,
> >>>        .display_off_to_enter_sleep_delay_ms =3D 50,
> >>>        .enter_sleep_to_reset_down_delay_ms =3D 100,
> >>>    };
> >>> --
> >>> 2.17.1
> >>>
> >>
>

