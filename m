Return-Path: <linux-kernel+bounces-297431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDA95B831
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E4628726A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A079A1CB31B;
	Thu, 22 Aug 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XnEHIowt"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2E19DFA2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336444; cv=none; b=eR9oJq3bN81e3FoS+SiTwEed/tiygi9IljiBbFlNJ6DF2dZXnxgM7Vu9ApzG+anKd1ju901uuRfcJPdMeLxaVj+x2eOQMhIXhQY2QZGy6etT58cgK7rAbP1vv2KMgRjT1F1gPSKLvqWX8Sv2SwccTYeTftwBN3+U2qzpfo6G27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336444; c=relaxed/simple;
	bh=shvnY9Rp+NW2z60B0oXjjPbGTvSmW2+pwWaP2gAiU/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9G4qWAF4LeMMNNgRAFQt95eOLTMs9VhvkfuZ38fj+B8+mqSwjnvyc0061BM/lNiwQ9AZRh5y38g2KHAG1f3OQdGjIINd1DvNOu9hHv+wkQDbmhrKvlqqbGEolqTYevs0BLy/A9GfT/TS6asJnHo/AN+ihQmxaSe8B+7q5sIeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XnEHIowt; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5da686531d3so581130eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724336439; x=1724941239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMvcrfJAhB5h4XFF3sFhLtI9e6UgOu5Ml/MtEViBiC0=;
        b=XnEHIowtYm63ZZBCGcgIRnGfuAibkwl0TXH3x/sNMt4wQetpduHDgKT20wx7UcOvi6
         cEbOag7rv3ZKUjmR5bv4zyBwiftYI/dsY2mRlOaIYP/H51i3o39krxa7Rik97RUrm67B
         +vDNbnoQ1cOvRemclqrR9rv/uNSAplu1IAqgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336439; x=1724941239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMvcrfJAhB5h4XFF3sFhLtI9e6UgOu5Ml/MtEViBiC0=;
        b=E1Fny2QjIj7mhRkiFCNSZlTytlXjybGbdytmTD49uNewz4jJ9a6QHKmdz4pH9IkeiY
         u4uSbh0/Ru4syYRIwxQmh7E1DBCoYqlvzjVGHZjYzY49vsQpr0GJxKjqJaIaHZyYPoq2
         JrOONJ6GIXINYTo23dAJMDfpbk4vXz6eRnaLJbwBabTdqbChjne/awRCfuQ5AP2d/g+l
         jpCfFHDiVxrFe8vWPJH88J6CjktHWdS4mykrZX4M+/TLxmVsBOcbOTT5KOAGYK4iODBK
         3931HkNIYQNNhxC2N49tOn8ugCOkI2o3sL1Bn/Q51Jk949R2+8YiIpOQguDXLuhE28eX
         pp7w==
X-Forwarded-Encrypted: i=1; AJvYcCWy2yDi2+k68IEjzjRgwt5giMKxJbmpkOq9NVPLasdswtHLCvgbRJy3QdoYNVdex8eBM1sne4r6elpTS7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGbKdJyYS1/jMu9R8yU6UmKZwvZisqzqQZnWdJrkNEj5kKl06
	mxIrSyvDEUtQRkyc6xmmt8Jj7CZbzEWN6ZJ8CxjiNK7Z6glb8ex66kJ7AxfhNvd0A1j/fH96pFk
	=
X-Google-Smtp-Source: AGHT+IEyGeH/Qf+TmuRqpefnB+4d4cGrKBTaRVKCP2m4hSkXQZ26Ad78sP78z11Nl4ElMJC6JayM+g==
X-Received: by 2002:a05:6820:168d:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5dcb685ac95mr2091000eaf.7.1724336439275;
        Thu, 22 Aug 2024 07:20:39 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dcb5e68964sm280070eaf.34.2024.08.22.07.20.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 07:20:37 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5daa4f8f1c4so601169eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:20:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXebozQSLc5FfPpQ9DC9kjwLoTssbSf/+on8OfNLuoAz4wzC978Nw7S31GYtB2f89SHabyeSJ/Wk7SlI+g=@vger.kernel.org
X-Received: by 2002:a05:6820:180c:b0:5c6:60d9:b0e1 with SMTP id
 006d021491bc7-5dcb64fc8bfmr2617864eaf.2.1724336436661; Thu, 22 Aug 2024
 07:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822093442.4262-1-hanchunchao@inspur.com> <CAHwB_N+1a9pWTVZmWb6tDTR0S1G5tCj7zJx9xaOL_tBTS5oTtQ@mail.gmail.com>
In-Reply-To: <CAHwB_N+1a9pWTVZmWb6tDTR0S1G5tCj7zJx9xaOL_tBTS5oTtQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 22 Aug 2024 07:20:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UapLj46M7jbyg-_qZN77iUjDD7B3sPdOU6wJazqjLtHQ@mail.gmail.com>
Message-ID: <CAD=FV=UapLj46M7jbyg-_qZN77iUjDD7B3sPdOU6wJazqjLtHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: fix null pointer dereference in hx83102_get_modes
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: Charles Han <hanchunchao@inspur.com>, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, liuyanming@ieisystem.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 22, 2024 at 3:02=E2=80=AFAM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> Charles Han <hanchunchao@inspur.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8822=
=E6=97=A5=E5=91=A8=E5=9B=9B 17:34=E5=86=99=E9=81=93=EF=BC=9A
> >
> > In hx83102_get_modes(), the return value of drm_mode_duplicate()
> > is assigned to mode, which will lead to a possible NULL
> > pointer dereference on failure of drm_mode_duplicate(). Add a
> > check to avoid npd.
> >
> > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate d=
river")
> >
> > Signed-off-by: Charles Han <hanchunchao@inspur.com>

Note: please no blank line between "Fixes" and "Signed-off-by". All
tags should be together in the last "paragraph".


> > ---
> >  drivers/gpu/drm/panel/panel-himax-hx83102.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/=
drm/panel/panel-himax-hx83102.c
> > index 6e4b7e4644ce..7c2a5e9b7fb3 100644
> > --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> > +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> > @@ -565,6 +565,10 @@ static int hx83102_get_modes(struct drm_panel *pan=
el,
> >         struct drm_display_mode *mode;
> >
> >         mode =3D drm_mode_duplicate(connector->dev, m);
> > +       if (!mode) {
> > +               dev_err(&ctx->dsi->dev, "bad mode or failed to add mode=
\n");
> > +               return -EINVAL;
> > +       }
>
>  In my V2 series, Doug suggested:
> "nit: no need for an error message when drm_mode_duplicate() fails.
> It is incredibly unlikely that the allocation will fail and the Linux"
>
> https://lore.kernel.org/all/CAD=3DFV=3DV2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKou=
B2mDB+NZug@mail.gmail.com/

Sorry for missing that we still need the NULL check and we should
definitely add it in. Cong is right, though, that the error message
here is pointless. The only way the function can fail is if a small
memory allocation fails. Even though such a small allocation failing
is basically impossible, kernel policy is still to check for NULL so
we should add the check. ...but the kernel already adds a WARN_ON
splat for all failed allocations so the extra message here is just
wasteful.

-Doug

