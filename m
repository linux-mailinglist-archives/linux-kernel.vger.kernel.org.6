Return-Path: <linux-kernel+bounces-220288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DFA90DF11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9FD1F23381
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868417B50E;
	Tue, 18 Jun 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hSS+7wxc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E01741F5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718749207; cv=none; b=VmX9RZBnX8qQ5P19T0tR6pDjN0FyO95gb7hPx9YStri29sOZYqsDNpp+EpPutcr+CU5QnHflCOUachx+PG2y842gR5TqBk6/FI/3RBsHo4Nx0xkHwhe9DMJDEMFDt24XJyzPTrv+GhoIAB8D0g3sTbAHMdF0Zk55hR4FmxUJWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718749207; c=relaxed/simple;
	bh=35h6ze1zJZ+OgWBD4gckSCnHdtaUNLMCu8GabLGhIh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMMMkBtU2wm2Ug4dNvYjUY9DtXtuUmYenxH5PmS135eVVRCjkkAqakdBqKblG6u7ZPf3+3m7qvVHPKCwKxaGW903n9rLwLRftBwj80NmnI7RRHT3TmFWpSHrvXILb2bVbFnMxjdSGmg+N+V4AJ6FhjKi2PRifgj8N2SoszbPQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=hSS+7wxc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6efae34c83so728451566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718749202; x=1719354002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMFwqDR8TJSRy7VIYztyOJK3wl/e3SP4rLA6DqZsekc=;
        b=hSS+7wxcaxfU5nG/xiaMthy1nb3vq82huLu04EwsJ7Cq8f5NsQEEgze8Zftt/Bvf9X
         7PAudpN+A7EL8bLeLW0N80hCAG60vU5rF97eX3gqG3VOq5C7X7q8HAi7I8eGbgDNStKj
         rPHqDBM9iRUeUTSu8+J+ZjOwdAQ4eZxO523jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718749202; x=1719354002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMFwqDR8TJSRy7VIYztyOJK3wl/e3SP4rLA6DqZsekc=;
        b=MKC5v0kNYfMdpllWkF+Scjn81Z57RiwjKz9Njgo/oSeaZxTqMHEXy1lyCnEV6sYqrI
         NnMAkR/UnbapwOoVyKXNdzYGTmOvKra9epK+4UBzcsMz2ciUDuBXoSQgK9rrlIi2GUeQ
         1RV3NsFo5n67rAidqYtTu+wxLw49eaFTq+z448QMzxOwoKKe5VGw8epQ8HyULg7rzX72
         gTPg1Q4s7ar1Us41b4FDPGDMhiyn1lFMFdpx5Q/5Y6qXAsJhoLVooehzCevesGG0g/5t
         KASKoKvYFFzQUVwv55Eck9ZoupIhPl5WoIBq2HUcIpeHFUi2P/t+EpMdJJjZuXf6F7Oz
         FzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+PdN0d8LpZ5UZ6z7h1nKxkxb0fmYuJA3krhsUelwJ6BoiTW70w2jqtGYYiR0+5YOVKsgT7OtuZS+e8Ppf6CW5aOkDe4fQcTDxI1C
X-Gm-Message-State: AOJu0YzfQlTBdJBBkiM6zhKg24OdeWSKT5oFx90wb7n0LgbvFsIr6A9P
	cvrclVmdbdVGNJlAZIF5Jld7S5Op3rm7mZGIwciEju6s1jBjp1+uQyGg0d6oFr+cdHXlr4Q2ZRX
	MH2CVVJAB4dnwvIqnUnxDgjBsDUNsZCwv5APreg==
X-Google-Smtp-Source: AGHT+IEcnwdEEzm35b0Ly3AyKEbVIyLPgApanb5AxSOTbcBB3uQd9HQSmoRkPjvhwNQrN0vYJ/7DI5//7+ZO0EQ+wHQ=
X-Received: by 2002:a17:906:ba84:b0:a6f:4c39:8aeb with SMTP id
 a640c23a62f3a-a6fab779ba8mr34922566b.50.1718749202428; Tue, 18 Jun 2024
 15:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618031918.2585799-1-Meng.Li@windriver.com> <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
In-Reply-To: <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 00:19:51 +0200
Message-ID: <CAOf5uwm82WzuqOHfBHLkursywfA8JNYp8RPPh+8K9DamVtyD=w@mail.gmail.com>
Subject: Re: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Meng Li <Meng.Li@windriver.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 18, 2024 at 11:55=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsy=
s.com> wrote:
>
> On Tue, Jun 18, 2024, Meng Li wrote:
> > When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
> > to enter suspend status with below command:
> > echo mem > /sys/power/state
> > There will be a deadlock issue occurring. Detailed invoking path as
> > below:
> > dwc3_suspend_common()
> >     spin_lock_irqsave(&dwc->lock, flags);              <-- 1st
> >     dwc3_gadget_suspend(dwc);
> >         dwc3_gadget_soft_disconnect(dwc);
> >             spin_lock_irqsave(&dwc->lock, flags);      <-- 2nd


In resume path the spinlock was taken too and I see that there is a call
dwc3_gadget_soft_connect that call the dwc3_core_soft_reset that can poll
using msleep for time.  I don't know if this is a valid fix but seems
does not fix
only commit c7ebd8149ee5

Michael

> > This issue is exposed by commit c7ebd8149ee5 ("usb: dwc3: gadget: Fix
> > NULL pointer dereference in dwc3_gadget_suspend") that removes the code
> > of checking whether dwc->gadget_driver is NULL or not. It causes the
> > following code is executed and deadlock occurs when trying to get the
> > spinlock. In fact, the root cause is the commit 5265397f9442("usb: dwc3=
:
> > Remove DWC3 locking during gadget suspend/resume") that forgot to remov=
e
> > the lock of otg mode. So, remove the redundant lock of otg mode during
> > gadget suspend/resume.
> >
> > Fixes: 5265397f9442 ("usb: dwc3: Remove DWC3 locking during gadget susp=
end/resume")
> > Cc: Xu Yang <xu.yang_2@nxp.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> >
> > ---
> > v1->v2:
> >  - improve commit log, correct the Fixes commit id.
> >
> > ---
> >  drivers/usb/dwc3/core.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 7ee61a89520b..9d47c3aa5777 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2250,7 +2250,6 @@ static int dwc3_core_init_for_resume(struct dwc3 =
*dwc)
> >
> >  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >  {
> > -     unsigned long   flags;
> >       u32 reg;
> >       int i;
> >
> > @@ -2293,9 +2292,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >                       break;
> >
> >               if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE) {
> > -                     spin_lock_irqsave(&dwc->lock, flags);
> >                       dwc3_gadget_suspend(dwc);
> > -                     spin_unlock_irqrestore(&dwc->lock, flags);
> >                       synchronize_irq(dwc->irq_gadget);
> >               }
> >
> > @@ -2312,7 +2309,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >
> >  static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> >  {
> > -     unsigned long   flags;
> >       int             ret;
> >       u32             reg;
> >       int             i;
> > @@ -2366,9 +2362,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, p=
m_message_t msg)
> >               if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_HOST) {
> >                       dwc3_otg_host_init(dwc);
> >               } else if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEV=
ICE) {
> > -                     spin_lock_irqsave(&dwc->lock, flags);
> >                       dwc3_gadget_resume(dwc);
> > -                     spin_unlock_irqrestore(&dwc->lock, flags);
> >               }
> >
> >               break;
> > --
> > 2.34.1
> >
>
> Did you use "git format-patch -v"? The $subject version prefix order is
> different. In any case,
>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>
> Thanks,
> Thinh

