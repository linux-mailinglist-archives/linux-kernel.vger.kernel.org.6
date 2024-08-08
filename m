Return-Path: <linux-kernel+bounces-280032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF994C4D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B3528BC8F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453314EC62;
	Thu,  8 Aug 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JpbONcjt"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF913E043
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142730; cv=none; b=S76SMb3817fuyFpBo6u8fWDk32A11ZHKMkAziyGu83IFVDV1wIr5aCUZNL/B6oeljZhqgxk05Yawk6tmy5ts/9ObTmC+4Xxtx0ilAdt6q6TY7SKt6t0oVCd6DpSha7ylQoqqYLJIZQMmmPRN9z3rc2QtR2YnIgBdZfDfAvy2RJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142730; c=relaxed/simple;
	bh=VNwfPNIDrZEQhR6zUkI5fMJgN7wQ0VNlQDZOxtdoxPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0JxTgSLNwJxz5SdeoIKdObVPM6xbCdWE+quQiRIxhAVuK9dpT5iie5lRb/OBkaUq62n/yeJ46cVNA422EMl1brm6odsyT3r+gD603N5HCPBZa+Pb+AcVhuFPfAEhf+dYDVTkImTlvk/k10j90YLLOk0ui/RdGYxIp6QmRiDuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JpbONcjt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4ef76f04977so449559e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723142726; x=1723747526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNkhoqvKuiIgMp2Dxoqrfnd9iwX4pwdtbywMo2F68wE=;
        b=JpbONcjt3mJDfkGiYxZCFOEbhDUSujV4m/SGdrBHxQWLSjcQImqUzYx9r+mrVhxmMq
         4pC2icUwkC1JTJxefA972iYtAc3u5RAOiMUCsfKfsynSO2/pmTza6GGxV21JfOC1bpCX
         XM7LLGAeHgFfdIQ6VMtneu46VB7ELMbgjNb5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142726; x=1723747526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNkhoqvKuiIgMp2Dxoqrfnd9iwX4pwdtbywMo2F68wE=;
        b=Txz1pTS8SHbfjzKWgKS1Fen0ZhtoT+9yv/UUHAL8TrCPWwtsZz5TjIOH0Q5ngsLdNW
         i897htMSO3EROrNmNQfEuP6XZSAG1ISGHAru1k98ussu0kZrPlUTRK1U1NwSFf7lN4y6
         RmwRCJQDZ/M5TPC8Hl69+sOIiqipD0u4n/tPRAH/o81Qq5U65fYTjow6jHp2JHjfVMYQ
         btqvq2b5UVFpudv7gqeVHOdZMHPEW6r2f11xeyQlqJEgRCN3AE6NSL8UkzFWcERRzpFR
         yJM2cYNb8TqcX0r9S0bkdlvYvff6CBawaDpp7rom9azPQ0lnZy/YzXV718GA5Ogfxqo4
         Prwg==
X-Forwarded-Encrypted: i=1; AJvYcCU58Pe4HHWamp0MeAYbFJYZF5saiz7mYeac8vcj9IsQYMViIkxgFuQB9PNRd5gyaxQZPYkyuw/FpofRfdESuB2tpac1ypAtyVO77Bk7
X-Gm-Message-State: AOJu0Yy960LhO3I6ZYrfKeHt0ksGgQX8iiuF3plJuHjmGssK4xbM9zdn
	I8VPKKw5eUPj/WMXaSIsxz5/sxDxbNFOpe52XNMWGsgffpLnfblkHW6mpXWaSy5LUF7k6iP5o6/
	q9nMs
X-Google-Smtp-Source: AGHT+IHOOrAtbnxUglpGDh8GYYMExc4dIIhbzANpwHRo4c6R4XYLorLAIDXhV2XW+dsOyD9eA2cH+w==
X-Received: by 2002:a05:6122:3689:b0:4f5:12d3:799a with SMTP id 71dfb90a1353d-4f90275ee61mr3456302e0c.2.1723142726086;
        Thu, 08 Aug 2024 11:45:26 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e0798sm184705585a.44.2024.08.08.11.45.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:45:25 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45029af1408so23401cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:45:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0rIPAEtZU+BtMR27QrNRxqjZttc+aoCAkmbYc5CLOjoTC4idL3zFD5vSsj4q13N3PfZWYDgQ/UM5LpI9678/nRS4YpSCclBthaM01
X-Received: by 2002:a05:622a:241:b0:444:dc22:fb1d with SMTP id
 d75a77b69052e-4530dcd66e9mr383971cf.12.1723142724490; Thu, 08 Aug 2024
 11:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729205726.7923-1-robdclark@gmail.com> <CAD=FV=Wo2nVzn6qvwSAFAnrFX4wtv6_ZCVZaL1K_DBBFg9DJ=w@mail.gmail.com>
 <CAD=FV=XMJ7b=2tt6_2oTGFXuL8XcmBxuDtQBoWdf_65YyS49XA@mail.gmail.com> <CAL_JsqLRTgQRPcfXy4G9hLoHMd-Uax4_C90BV_OZn4mK+-82kw@mail.gmail.com>
In-Reply-To: <CAL_JsqLRTgQRPcfXy4G9hLoHMd-Uax4_C90BV_OZn4mK+-82kw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Aug 2024 11:45:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWAoQ3Njq14uwSrA2zA=Wx_Jm7F1c7gFyk4Jysut1Thg@mail.gmail.com>
Message-ID: <CAD=FV=XWAoQ3Njq14uwSrA2zA=Wx_Jm7F1c7gFyk4Jysut1Thg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: samsung,atna45dc02:
 Document ATNA45DC02
To: Rob Herring <robh@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@chromium.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 8, 2024 at 11:14=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > The Samsung ATNA45DC02 panel is an AMOLED eDP panel, similar to the
> > > > existing ATNA45AF01 and ATNA33XC20 panel but with a higher resoluti=
on.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../bindings/display/panel/samsung,atna33xc20.yaml       | 9 +++++=
+---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > I'll plan to land this in drm-misc-fixes next week unless someone
> > > objects. "fixes" instead of "next" for the same reasons discussed
> > > previously [1] that the dts patch should probably be considered a fix
> > > and there's a chance that the dts patch could land in an earlier
> > > version of mainline than the bindings unless we consider the bindings
> > > a fix.
> > >
> > > [1] https://patchwork.freedesktop.org/patch/msgid/20240715-x1e80100-c=
rd-backlight-v2-1-31b7f2f658a3@linaro.org
> >
> > Landed in drm-misc-fixes.
> >
> > [1/2] dt-bindings: display: panel: samsung,atna45dc02: Document ATNA45D=
C02
> >       commit: 1c4a057d01f4432704c4dc8842b6e888a91d95df
>
> And now warning in linux-next:
>
> ./Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml=
:21:9:
> [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml=
:23:11:
> [warning] wrong indentation: expected 12 but found 10 (indentation)
>
> Please send a fix.

Doh! I'm just about to hop out on vacation, but here's a fix. If
someone reviews in the next 30 minutes or so I'll land it. Otherwise
hopefully someone else can land...

https://lore.kernel.org/r/20240808114407.1.I099e8e9e36407a0785d846b953031d4=
0ea71e559@changeid

