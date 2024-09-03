Return-Path: <linux-kernel+bounces-313286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C23F96A324
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F301F23E33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FC1898F3;
	Tue,  3 Sep 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7k5BSfk"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CB219E4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378348; cv=none; b=UQKd8UYLDcRwelQDn3RJc+qRL4RiQwtd+XM/m7i/wdFAKxc8GH51ih1Hs3qsZzbT1X5Nu03rPitaknmeLxa5h/BxyQmTZUIkEi4cNVDPXubLdkZMBYZig3VPt5uCEep+LdWztEU73tJGvatrz7DBtu+6PdXETmNCxQnejR7iFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378348; c=relaxed/simple;
	bh=l2mQscuab4OPQKa1/mhIn0/gLgLRV3Jrk0oI9l9ckVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdsV/jqFjvRLompioSBvijL/AxyNeSyHc99V30Q72eMrefRy0FoQnQW8elTJatVjrr+O1t6qGMVDj4em+btY4zKQDP8xUyNhaJqTB/zcWTZE6s27u7LfduD9hAUlVHTYPS3yia+Sc1UTSAw9gd3JOmg0o+gg86H2M1Y/soPVqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j7k5BSfk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso68374161fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725378344; x=1725983144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvLFRuyWoi+K6FtpRUCVpbWJKizzVnbzbq+sI/tpAWs=;
        b=j7k5BSfkFMIrMNQdbDyaiigw2igpteXpxjtqqNRbZgnB9jcf2YujYARFYwGZxKDBU3
         ncg8sWS6lHNgeWtgkAHxJiboplMr7FsAgdkdWk9NSLL0SEajqc7V0Uwj9mCtYXm9tKYU
         P0DerJOUQUBGmiKPPT7LZvZ4fP729YJnda2BtI/KG/Nrizmump2n/rUGoXeGtmrtB6Ec
         d5JFNaJr9ug+lEPpNWxt1XAeHJYTX9irYzTJu74CruAbmX6UOfb5vui6S26I4lgcuj9/
         Nu3bY3NUWxv739mQ9GG0VmaNA+zJelJZ9IfB0L5fnqxvZvPRoWwOXskI21cca0dy9w0S
         23gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378344; x=1725983144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvLFRuyWoi+K6FtpRUCVpbWJKizzVnbzbq+sI/tpAWs=;
        b=Z7x7LyI4FpZg1Qbmv14YVcPFeNN5MubKbRkezXRBmSQkfNis7Qs9Ogs4+s6escDdwd
         QSeMPm0HWC/i77DMfvvzq3wI1yyarsWMxmJ1ZJHGP6ATGZjG2OsraOaltPQbCxMa/HEn
         ioXvuRkdwUDxTheOU5G9+UZuXwp+0Y/bZdMIWQfohTlt0fEMmkd/1Ce2MJ4mg57X28B6
         htLzilU1NS2ssmNv/kZ3Dv8NxZl5NgGDPFFoSm16TnrYTCaRr+FWXxKaIr9WOM8u7N2z
         b/Z7et4pOhWD/4HwYN3JCjT7rUyZK3RhumsEGPRcnz2Q+AvQ8OSPmuuQwmWsfJrv54MA
         Lt2g==
X-Forwarded-Encrypted: i=1; AJvYcCWXQh31bMbzDEnG35q+k23H6066TyZu/szst1ouI3nzovZVRSTpS2CECdUQOnOgmfkTRCUsm2RtZuNvgeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrmz3EmyC7UXlrIUrRV2StuOl+uvcWyab5/K7lGmjQr9FxtH7
	um0rYEGxs/DdsNKuG6ZtpmWHCBdcgkKTtTV70zSbopaRlkNVnybRnuZFyi9GPY7+nXsI7G9aOvh
	FW6+pOig57gkUfvRBDviZ2SPdfVb36ezb6L3yAg==
X-Google-Smtp-Source: AGHT+IFZ2z10mUsHuIeTi5fGP7ImtWV0HNYj0otnbACk3A17lbvrUv4JGfz1TWIR0kU9riHTx1cIgtjOKQUelny19Sc=
X-Received: by 2002:a05:651c:b0f:b0:2f3:e9fb:6d5a with SMTP id
 38308e7fff4ca-2f6105d755amr166291761fa.13.1725378344000; Tue, 03 Sep 2024
 08:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
 <rspuwp3zpnzwfe26hv2yezy5ad5o7wliq7ucpobyaheytvcs3j@qtshf6cewb2f> <p6xw4newsbrpog5ftclvgi2mpg3hn3ujfukmtilqewz7kbjhqh@6geosjawh3ul>
In-Reply-To: <p6xw4newsbrpog5ftclvgi2mpg3hn3ujfukmtilqewz7kbjhqh@6geosjawh3ul>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 23:45:31 +0800
Message-ID: <CABymUCOji3BUyBhSRz-FXh0tge=kwUTiRN5aLhf=O4MUh_4Y3g@mail.gmail.com>
Subject: Re: [PATCH 02/21] drm/msm/dsi: fix DSC width for the bonded DSI case
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Marijn Suijten <marijn.suijten@somainline.org> =E4=BA=8E2024=E5=B9=B49=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=BA=8C 19:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024-09-03 11:50:36, Marijn Suijten wrote:
> > On 2024-08-29 18:17:31, Jun Nie wrote:
> > > From: Jonathan Marek <jonathan@marek.ca>
> > >
> > > For the bonded DSI case, DSC pic_width and timing calculations should=
 use
> > > the width of a single panel instead of the total combined width.
> >
> > When this patch was originally proposed we already discussed [1] that t=
his is
> > **not** universally true.  On my hardware a single bonded panel always =
receives
> > the full width, at least on downstream kernels, and it works [2].
> >
> > [1]: https://lore.kernel.org/linux-arm-msm/eanx45rnasj7lu3r2tfhtg4qkqkc=
idd6zctsz6ci6jlklu4fgi@3nf73w2ka4li/T/#u
> > [2]: https://gitlab.freedesktop.org/drm/msm/-/issues/41
> >
> > Can we please figure this out before landing this patch?
>
> For completeness I've picked this patch, together with the following
> mis-squashed change from patch 03/21:
>
>         diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm=
/msm/dsi/dsi_host.c
>         index 7a4d9c071be5a..5abade8f26b88 100644
>         --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>         +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>         @@ -953,7 +953,7 @@ static void dsi_timing_setup(struct msm_dsi_h=
ost *msm_host, bool is_bonded_dsi)
>                                 return;
>                         }
>
>         -               dsc->pic_width =3D mode->hdisplay;
>         +               dsc->pic_width =3D hdisplay;
>                         dsc->pic_height =3D mode->vdisplay;
>                         DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_heig=
ht);
>
> And this is what it looks like on a bonded DSI CMD-mode display:
> https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2553207
> https://gitlab.freedesktop.org/-/project/2206/uploads/dc5c53d09ecb635fdc9=
f190fbc9b37ac/1000027079.jpg
>
> That's a clear regression :)
>
> - Marijn

Surely we should figure out what's going on here before we land this
patch. Please help me to understand
your setup first. Your panel works well on mainline kernel with
2:2:2(?) topology, and you see issue with applying
the change here, right?
There are several parameter that impact the issue, video/command DSI
mode, single panel with 2 DSI vs
2 panels with single DSI on each panel, 4:4:2 topology on my device vs
your topology. Let's list all of them
before further discussion.

-Jun

