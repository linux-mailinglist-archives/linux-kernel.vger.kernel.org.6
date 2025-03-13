Return-Path: <linux-kernel+bounces-559206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD2A5F0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB6D7A42F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739A265CB7;
	Thu, 13 Mar 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VME+fC5m"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3A1BC5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861800; cv=none; b=J0uoalnror6U1OM3J7mL2p4vEV0IfrgkahiJEYaCTNKduJf27rzqj85oyfxHckbIVovIP/9xu1BvELYNtzxYZaeaWjkJMr22imDBZ2kFcC+8KKV7Gv5vpm3d1nCCV5ogFJDQMwSlg3FN6vkW6drQeugZsmpeGD/sI0vZvlW8lG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861800; c=relaxed/simple;
	bh=NEmSl0VCjKfvL7t65VUB5MzMa9tpwGW3y/LTbdNnZVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axJlvYXLMFIBHDwzcBvThUPPBrYdkBkKXp5kJicqLGROtcLRmpbJBvOaie/THrBrwyoqOPpmc0RWE6ESnH05wiT8+ZLvMgYvlz2b9czJXg3W+8tuJ8AFSQpEdb2px84pexGBtjoaQJsMBtEacA2FITNvEPxVcWinRYtve26Ijgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VME+fC5m; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54991d85f99so1957455e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741861796; x=1742466596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pviuwRFdfnui+N+RMClLZiL5AkwReTbr0Jey2Ox0RLI=;
        b=VME+fC5mC0W/AyrSaiA6j+OcR/T8tbx7vplq0U14zwgF46NxayQnajSKdJEB7Rdg8N
         qn50O5s3wOsLXICa6eo5u4mx3imhWJUPRTNK44qQi0oY33dq8cnFaFRNGoMY9/WvPHwK
         qmaToebcslN/dwxlOLakZGiKQ/FD6Mm9jXHD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861796; x=1742466596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pviuwRFdfnui+N+RMClLZiL5AkwReTbr0Jey2Ox0RLI=;
        b=keB8FkbiPkgAbw5fnTEL1bKy3bqAnntTm1Nc/goQCvpvrKYlW2AyE3x2ewBtRt67wr
         eekDRsKHOGXEHqMN7Z2/+4u7tD8U0OtXqzQ4sXrXU2ww4lj1z2lk17RtcBK8sacajX+h
         eVKdL0jwuJ4PS2m9qpzmk4NhAMZaCx/+Yj47d8KAJkWg0Q7zOWs3thRG2BHYPcOzYKJl
         8KvtzFtacKpLKCMRgJvzR7q2Pyn91TYj8ywy1pZ+N4rnUATTEfto8/KPzc+7EcdADbhS
         K9EBdio1CtRhSqs93KqS6Mci8JNUxN7/HaBBawLuOJpJbW7i+FXpf21TDQ90i0ZGZGJ0
         Ym/g==
X-Forwarded-Encrypted: i=1; AJvYcCWbstbVSlYsAOzDHnGPitYf4eiPUxu9OM99mpqBZT69lZZBmdR8clSgbrvcF40Qa6FJNnSnF+YgOXzaBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoxdyijed2+Lb9a6MTM2DgojEdnHHqt7FY/76ZTuwbpxqxhrk
	D6tmNTIQpeNT2ZLOIDbVEPMb14uzt79/JjEETLXYTBmbbM6hl23EJG8n9fOtY4aGz+EUBuL3C4U
	=
X-Gm-Gg: ASbGncuEWksr1piGOeGMrggzgtKxyEWMg6XfLt/OAGN/GwMymZpu8uZPNDxuty9nbmq
	pL7Jw4V7TqY5Dp2MG9HCo+0In7mhbVKOvptq936vqSEEuptA9a3HAJF+NXjdu3QKsflQyeQVDl4
	j8tTwTP6RRjZ5kKfLjthToo3JW7D5U/WiwfeJbrhU2H5iiVje3Wo0XH7yPr79sVBlxMwNUMEr6m
	tZOFwgabWHAAALJf8PS8Vvh/oaNwDMQM0XmivZUM1krZg7L1ufn8HjS0R5LmJ/92xLZg8xk8enA
	M0OlvGxptQaDtvUDyHl0gPsCcE02AkUw1Rq7ydXsnwhBcT8iLQ8A1Nz3KIyIuQzyYyQrCuQ9t4f
	0WtcHc4otmas=
X-Google-Smtp-Source: AGHT+IFayby1JxeVF2jMpTkvZljIuFvqOCUI3nrRiEmeJNUKZuPeZHaFtDgL1O88iyen/vXaPgZeUg==
X-Received: by 2002:a05:6512:2309:b0:545:6a2:e59 with SMTP id 2adb3069b0e04-549ba41c35bmr716913e87.18.1741861795586;
        Thu, 13 Mar 2025 03:29:55 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a81basm170798e87.28.2025.03.13.03.29.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:29:55 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bee278c2aso20039351fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:29:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6rhZDs3jWz34GxVPOMP5xdl1gIjT80xt+3094l1AeaDr9amEQI1tt571RnUEAWFgTCbGoQbcP31ViFOw=@vger.kernel.org
X-Received: by 2002:a05:6512:39c8:b0:548:878b:ccb3 with SMTP id
 2adb3069b0e04-549ba429dcemr762107e87.25.1741861794589; Thu, 13 Mar 2025
 03:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312192528.95838-1-andriy.shevchenko@linux.intel.com>
 <67d1f748.050a0220.353790.339b@mx.google.com> <Z9Kf06nLg86jmcqI@smile.fi.intel.com>
 <4633173e-111a-4659-945d-149e3857896c@xs4all.nl>
In-Reply-To: <4633173e-111a-4659-945d-149e3857896c@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Mar 2025 11:29:41 +0100
X-Gmail-Original-Message-ID: <CANiDSCs5QsyTxYj4DnsYD=18RXGBXGVQ=r_XxY6C011JTmh+LQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqH81eCmniQ-A65SsDIPlCKmBwLLnS5WW7jzue24hdFz1RihLXZRmsS1gk
Message-ID: <CANiDSCs5QsyTxYj4DnsYD=18RXGBXGVQ=r_XxY6C011JTmh+LQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5Bv2=2C1=2F1=5D_media=3A_v4l2=2Dcore=3A_Replace_the_check_for?=
	=?UTF-8?Q?_firmware_registered_I=C2=B2C_devices?=
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Mar 2025 at 10:52, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 13/03/2025 10:05, Andy Shevchenko wrote:
> > On Wed, Mar 12, 2025 at 02:06:16PM -0700, Patchwork Integration wrote:
> >> Dear Andy Shevchenko:
> >>
> >> Thanks for your patches! Unfortunately the Media CI robot detected som=
e
> >> issues:
> >>
> >> # Test media-patchstyle:./0001-media-v4l2-core-Replace-the-check-for-f=
irmware-regis.patch media style
> >> ERROR: ./0001-media-v4l2-core-Replace-the-check-for-firmware-regis.pat=
ch: Missing 'media:' prefix in Subject
> >
> > LOL, what?
>
> Hmm, the 'I=C2=B2C' bit in the Subject header causes it to be UTF-8. The =
Subject line in
> patchwork (1) is now:
>
> Subject: [PATCH v2 1/1] =3D?utf-8?q?media=3D3A_v4l2-core=3D3A_Replace_the=
_check_fo?=3D
>         =3D?utf-8?q?r_firmware_registered_I=3DC2=3DB2C_devices?=3D
>
> so the check for the 'media:' prefix in the Subject line fails.
>
> Interestingly, if I commit the patch (git am) to a test branch, then run
> 'git format-patch -n1' the Subject line now reads:
>
> Subject: [PATCH 1/1] =3D?UTF-8?q?media:=3D20v4l2-core:=3D20Replace=3D20th=
e=3D20check?=3D
>  =3D?UTF-8?q?=3D20for=3D20firmware=3D20registered=3D20I=3DC2=3DB2C=3D20de=
vices?=3D
>
> and that restored the ':'.
>
> Ricardo, can you look at this?

STOP breaking media-ci :P [1]

Thanks for the report. We were not ready to handle that encoding. I am
now leveraging "git log" and it seems to work fine.
https://gitlab.freedesktop.org/linux-media/media-ci/-/merge_requests/246

Regards

>
> I also noticed that the v1 and v2 patches ended up in my spam folder. Whe=
ther that
> is related to UTF-8 in the Subject is not clear (my provider marks way to=
o many
> legit posts as spam).
>
> Andy, can you post a v3 with just 'I2C' in the subject instead of 'I=C2=
=B2C'? If nothing
> else, I'd like to know if that's the reason it ended up in my spam folder=
.
>
> Regards,
>
>         Hans
>
> (1) https://patchwork.linuxtv.org/project/linux-media/patch/2025031219252=
8.95838-1-andriy.shevchenko@linux.intel.com/
>
> >
> >> Please fix your series, and upload a new version. If you have a patchw=
ork
> >> account, do not forget to mark the current series as Superseded.
> >>
> >> For more details, check the full report at:
> >> https://linux-media.pages.freedesktop.org/-/users/patchwork/-/jobs/727=
74130/artifacts/report.htm .
> >
>

[1] No, seriously, thanks for taking the time to report back, it really hel=
ps!
--=20
Ricardo Ribalda

