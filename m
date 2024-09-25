Return-Path: <linux-kernel+bounces-339484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02C9865C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4823C1F24FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB781AD2;
	Wed, 25 Sep 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QdSFrvTq"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16FC43AB3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285956; cv=none; b=IrGBQAeetUI5FIZDQNbg9y2cXq2RcwUGRxGrS44Zb7iyoy1jQqQ5EuWxaQKhjLqCgT+s6U8uTtaHMrjseF0z1oMZQX4DWQj7Mmp1mLCS+cSfRjxTPH8CFBRpwdQnagCzauajwUe3CucygXrd1wgWYfoil4/S/E5PsNwCZFlz2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285956; c=relaxed/simple;
	bh=qC+4OzBfHeWAAVnO/kJPIzzGDGo9CNwAPxoUhEvQU+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asuBkOwrCSMUHw4xsNFMHVjoYoyo75LGzu80Ax2Ve2JfcRnMynxzkEb6/a3Ap7MmYLbk2ONo6+jB13qzMvJ6BKXNqEFecx4lApsrrIluTeOv+ZgNls5udNc9MlPsFjui0DIjw/yn4rBCcqZk1/0gafmhvYikNT/tA66kS4qi1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QdSFrvTq; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e026a2238d8so114434276.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727285953; x=1727890753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpxLBhJ2QVf2x8ikOfUcvCWU80ZCC2HwFED15yLhiFc=;
        b=QdSFrvTqKxqueW7+cLgRI9MEKzVh/MPTH4a1i9eFQv54hZeC7jJsNIU8Y2jwa/cJxi
         G5N2o0w4xRe07f7PkYkxkomB7fFYywlBHtMDh3fZ+2RylIJFCAebCfiXB/w4IKiqvbQr
         rOmViuHuJMl43Pfzj9tIm44Tp/QUWV0I2mI4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285953; x=1727890753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpxLBhJ2QVf2x8ikOfUcvCWU80ZCC2HwFED15yLhiFc=;
        b=D60AUreaM4MVhHessQ7THUhHhzLskK6XWAOJSEr6dIdHEzp2RXz/78Rn1+q6dybEfi
         wlumLVD0KUmywEkYIKZWhWvKigrBRMeWs5qWB/KD0Zk1uS1R4gF4NirfdMBAq7bYB0BN
         rmUYuOIQvruaun192fz5ZNQl51HkrUvq9pg/AF2eHNgt39Au/WitoQFlOEOUqlz23Qv8
         TVDhmxT7rGfnpm6+y1EzxzWjK60KgK5Ti/Tt2hT/gqNE/UcAJfoY0R7JcFoebJfzRsQl
         zNa4pUqv6GZtxpnFIZ6T3ddNUG2n8gUhh0rgv/lbdLwz39O7OvONBtnMvrd2UQAwQu84
         pEOg==
X-Forwarded-Encrypted: i=1; AJvYcCX4XzmuF9JuEbCLsPRmpJFZisnmpO3kh28oOWLbgxe8pWvC0KNMEsZiCmxaSYxSJTsxiLQkHqIV6HDeeic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhRMin0IAhzG+H/I8cpFGL6XDNugXL/Bn8PW4bUP73oH+aKN7
	mOeRrDsb7CxlZO8bIQvD1PAfkbhcV3XrVcKpkZfehlms5AXcK/4vhaR8RygjF5V7+AdkQj6MoL7
	P/d/A3X1TrNFutnNokMJ3oB5sJDt/1CxBdtu/
X-Google-Smtp-Source: AGHT+IHoeJYE0kiOXCjFqm5HHKKO5W0RciwhvO8ebo0vvHQt0VZEPxHt/5a9GU1rRQXEcwBldVQ+HbLXzK5kZcEDDEw=
X-Received: by 2002:a05:690c:4289:b0:6e2:1a41:ebe5 with SMTP id
 00721157ae682-6e21d9f2ec5mr23687327b3.41.1727285953595; Wed, 25 Sep 2024
 10:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid> <vnemjw6uo3sydriabdrzwinbnam2xitrezrw3ztcymi63zakep@2rruplyjzuol>
In-Reply-To: <vnemjw6uo3sydriabdrzwinbnam2xitrezrw3ztcymi63zakep@2rruplyjzuol>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 25 Sep 2024 10:39:00 -0700
Message-ID: <CANFp7mVir-XEuVBd+kbQq0+5Si0CBo8TNxcdNpG6X+PDR-J1Zw@mail.gmail.com>
Subject: Re: [PATCH 8/8] platform/chrome: cros_ec_typec: Disable auto_enter
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 10:03=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Sep 25, 2024 at 09:25:09AM GMT, Abhishek Pandit-Subedi wrote:
> > Altmodes with cros_ec are either automatically entered by the EC or
> > entered by typecd in userspace so we should not auto enter from the
> > kernel.
>
> This makes policy decision for the whole platform. Consider somebody
> running normal Linux distro on chromebooks. Can this be configured by
> the userspace itself?

This is just the default for when the driver registers. You will then
find that there is now a sysfs entry for auto_enter that you can
control from userspace to allow you to auto-enter the mode on partner
attach (which you could probably write a udev rule for).

I still need to send a follow-up for how to handle auto-enter when
there are multiple modes available on the partner that are all
enabled. This first patch series is mostly about supporting existing
use-case for ChromeOS.


>
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform=
/chrome/cros_ec_typec.c
> > index ec13d84d11b8..e06a0f2712ce 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -294,6 +294,7 @@ static int cros_typec_register_port_altmodes(struct=
 cros_typec_data *typec,
> >       desc.svid =3D USB_TYPEC_DP_SID;
> >       desc.mode =3D USB_TYPEC_DP_MODE;
> >       desc.vdo =3D DP_PORT_VDO;
> > +     desc.no_auto_enter =3D true;
> >       amode =3D cros_typec_register_displayport(port, &desc,
> >                                               typec->ap_driven_altmode)=
;
> >       if (IS_ERR(amode))
> > @@ -314,6 +315,7 @@ static int cros_typec_register_port_altmodes(struct=
 cros_typec_data *typec,
> >               memset(&desc, 0, sizeof(desc));
> >               desc.svid =3D USB_TYPEC_TBT_SID;
> >               desc.mode =3D TYPEC_ANY_MODE;
> > +             desc.no_auto_enter =3D true;
> >               amode =3D cros_typec_register_thunderbolt(port, &desc);
> >               if (IS_ERR(amode))
> >                       return PTR_ERR(amode);
> > --
> > 2.46.0.792.g87dc391469-goog
> >
>
> --
> With best wishes
> Dmitry

