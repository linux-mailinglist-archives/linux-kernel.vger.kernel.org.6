Return-Path: <linux-kernel+bounces-354645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037A99408D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9835D285474
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A720124C;
	Tue,  8 Oct 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8qmOsHX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4D201245
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371845; cv=none; b=CcEXjDmWwtcECN7naxzGQMimurGbTNNYLktbG7TdEAH0HWvTh34Bh4WWLPcCzRgyRV1hQDN+y44HqXOy51OqeHBMyvRDFsPazOfdecuUj6iZbRgnHHqcDdJkmxv/YkQjEa2majArrvIerIw/jv71erE7QmY9+i3liIqK0D5ITrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371845; c=relaxed/simple;
	bh=tg8mFgAKE1e2NQDGKN/+Rfe85QnrsUYocJhRdCCgTbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0a3RUYahZ2KkVX9gvD2OgMYWEbMO9aM8bREqb71UFm79JXH3ndpOnbgSNbvG/WGGTA0xOIKCLo6P29Uw3Q1WLnlKb0HhwJO8YdXPasRwS5fNZa4XhXZiyydRcUlZqaKien/ali0kUrZFkg1xGBaMj5ufZzIu0vvT8H0t5btSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8qmOsHX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so53633375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728371842; x=1728976642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqD8iqeCt0GqppWDT8y8/ry5l0Y/IERdHPAHK2N/B+k=;
        b=M8qmOsHXdUI6aZRGIAQZoPD5TkFK+Ymg39MHuOXBBVlMywNRsjQ74Vsw0S1Y/UnD/q
         Z++W5QCBRdH9HoJjmH3/G7rAha0IuJ4ELZnK6ALM1SerLEEaB82GpP+RzEZtwU3Of9Rn
         Q3MnaTwF7dQhb/fp/89Gb0CWcJBDy5ZKo6QeJx7b8E2J/oI8TqymwlNRfDsoC2CAPsnz
         y7iPg9uoN6mI/D68JCj68XCyiBwCHOLZcR4yK1ru06cLVCTmtsCBgvu34WjngYt4h3Zb
         EyEMp8LfmBE7Kct1LKuwh5PbMS5rZYS4XuTqLZbGHj67zpgAusd62CdC3GwMyBc7T4z2
         bL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371842; x=1728976642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqD8iqeCt0GqppWDT8y8/ry5l0Y/IERdHPAHK2N/B+k=;
        b=vkR5qHKbJ9+gjV4FmKUl7HIh7qVgY1K48NsCvLYHr82DU0XF7lUVQPppT4yU69ZWog
         5+E63FsWD/RgZx529sH8iCSe3h/BqMBlDX7KjAUsbCVVzLlHZYlTh1FQtieIorflHwdu
         usErieCjvCXFcJbqVH2egVlvrTdDACC84cuZcDVHjCCfDuqHbwcOKvt2E8jM/hbcc/UM
         SA5aAPuGPQwtyBbnlh4Q4oUOa8dog20j0aFdxcv5co8hYSAkQjk1nYq0NxhWP4JOExNU
         6MrdEf85hF4D2yY5JhQyRGP8X6qpUukiKKf8ZGREEXyOdKoH+YNmlXAj9tqFOtZ1LpPZ
         XPOg==
X-Forwarded-Encrypted: i=1; AJvYcCVsX0jOQlIuUI1roQvDyV1v7dCa9Xh/zWkLv+Oe5ZdTZJmY4Cyzd9OfLI/g6bKOf+TOYavdqriAwGGUnAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYYlUsmIh0IHWUh/ObWvWCn+TuoBxXSZ6eZcZJ/HrZtp3xYGV
	G2XMIOLrlCPT59DrFnMuqWPkQhOVSYIYwH/4QVg1gsrNtaEopCaF6GioXd8PS7CtA+LfPvowolZ
	m2PrAezZJHp7iQ+QQaTE/wMZ20A==
X-Google-Smtp-Source: AGHT+IHYqrHlksLmb+lIQAF3s95zgOe5Mj7cA+9ugMm8JXbL5HBLLAud3+BbO/26fB1ycD4CsNH4EPqGVpbnhy5L/Lk=
X-Received: by 2002:a05:600c:4e89:b0:42c:b750:19d8 with SMTP id
 5b1f17b1804b1-42f85a700ecmr103217595e9.4.1728371841994; Tue, 08 Oct 2024
 00:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007201356.10430-1-alex.vinarskis@gmail.com> <CAD=FV=UsLHQ5KkOekMntQ1GK=TFoGKN9kaMcLnUmXBLtrmP4qA@mail.gmail.com>
In-Reply-To: <CAD=FV=UsLHQ5KkOekMntQ1GK=TFoGKN9kaMcLnUmXBLtrmP4qA@mail.gmail.com>
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Date: Tue, 8 Oct 2024 09:17:11 +0200
Message-ID: <CAMcHhXpSDe_kMc0hbOEzKu5fOqKTb_u-_H2CjFHdyi7TpTNQ=Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/edp-panel: Add panels used by Dell XPS 13 9345
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com, 
	Peter de Kraker <peterdekraker@umito.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 01:04, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Oct 7, 2024 at 1:14=E2=80=AFPM Aleksandrs Vinarskis
> <alex.vinarskis@gmail.com> wrote:
> >
> > Introduce low-res IPS and OLED panels for mentioned device.
> >
> > SHP panel's timings were picked experimentally, without this patch or w=
ith
> > `delay_200_500_e50` panel sometimes fails to boot/stays black on startu=
p.
> >
> > LGD panel's timings were copied from other LGD panels and tested to be
> > working.
> >
> > Particular laptop also comes in high-res IPS variant, which unfortunate=
ly
> > I do not have access to verify.
> >
> > Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> > Tested-by: Peter de Kraker <peterdekraker@umito.nl>
>
> Your signed-off-by should be _below_ Peter's Tested-by. That means
> that you're the one that signed-off on the fact that Peter tested
> this.
>

Got it. I thought the author's signoff (me) would always be first.

> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> This looks OK to me. I've been requesting people include the RAW EDID
> of panels that they add in the commit message, though. Could you do
> that and send a v2?

Probably missed that requirement, my bad, will respin.

> Also: note that since I didn't see Peter provide
> his Tested-by himself, I'd probably wait a little longer before
> landing to give him a chance to object.

I'll drop his test-by, and he can mail in himself directly then.

Thanks for the review
Alex
>
> -Doug

