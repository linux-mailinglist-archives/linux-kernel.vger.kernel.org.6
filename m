Return-Path: <linux-kernel+bounces-573128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FFA6D354
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C63818940D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9817186287;
	Mon, 24 Mar 2025 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cd9aa4K6"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B841C69
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742786738; cv=none; b=KqS8LzHGU9H21kzvugqc/IQ5/2ep49jG3fqrwqxLO2hSUvhREBmIusrDclUW3L8/WXZi0NWy+j+GY9cEykhykAp+wTVzvdEdGH+K/TZbIDSGS3uvdyZGJ+6MBtxucDbdkOm7IBBKaQ5nen2wdXbttGJlDyWZRP6+kgnL2z78MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742786738; c=relaxed/simple;
	bh=2RsNrHBPeiTV/KGoBuTX4+LkDKeG1yy/Gh87Th+pOyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewnh10stSvXVyWDJGi9QbXwwphJPWNpFQOaCOmkFnRPwxbSsrGDTGB6gVpeLHLfTTLZ1/lkEP83no6Hdl8h1KA18ei77G5ZY6T1cFtiyXyvsyoa3jLRus8nP6jtNE1nLjKi4X9gmWcj8ZpbS3bc/DqqMLsTsSX45CfCJG7sICJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cd9aa4K6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549924bc82aso4468e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742786733; x=1743391533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93QQCUzi6u14I2syzV0j3AvYvvOWRX6mB9orIqjNnIs=;
        b=cd9aa4K6E6DrJlNTSTy+QSYIBDjx+WwsXym938jeAwaRGOe7+eCFG7ZpqUKgqwjpaL
         inG24+aepceR3V/5PLs0Ot9d3CGQGVjvC4z5y2yxUx0L1pmPEBWaN2riZvCj/s6WA52Z
         JJ/nV3qk6Ms8zRwkQYSUsLr6RVkEBf2IeqPZAkBn0f3BVSYzEwP/Bl7OhdqvFiV6xNrs
         VyzjXGZTBFfGSRACRMcvQ9McOnRsKIATYU4xw2sC+dpm8MyXP2Ee7Tsr8+E8miWzNTFp
         FjGFqxUx2I4o4T81ueSExArr/nvXUJcTTRYGVSYF/7n7jLzvA2/3UkSw0TP8C0dj0Lrx
         XqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742786733; x=1743391533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93QQCUzi6u14I2syzV0j3AvYvvOWRX6mB9orIqjNnIs=;
        b=U8Vws5JmO9e/yhXYianJkZWxYSM5cayj/B0auyEsmSMQmAtoPvXCbsvLwTMdklxQWS
         5mBwZNqJKShFsOXCNpPBOKLZ7B9Z85GEqzH8eT+azmElgeinT16yGx3tnIDgDaKZb7+m
         vch4MVcZaO5dy+CPL3FEX3EGPyJW86/t5WEOJOdQO3tfGDJYD7+9h32FlAXQtDYgVAPQ
         ZHvBGb7eSHgX8nikIzGZbE9Zjnz3Jb456yKK6pcqq8HxojbY9Zm6OVc6SdPBK4qyef4r
         YcV79kRll151j49P/Ah1+1hGGV10dwDXI8romKcioIktUENlmSERUQNqGdI1Yx9hEuA/
         4LKg==
X-Forwarded-Encrypted: i=1; AJvYcCV2l/hmYFVSsLuBB01sRlDZCVRAT2aUiKjpoA1ufwX+jx92YFrlfDjAErabSGMGyDJXFdHerZATfTNEHPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hPzuk4G+91TYu/KUdR6GUY/GnmgYsQ7R8rhYIX3DJMLPHMiG
	uKMvZlm7BZczwufzGBG4a5rcf3oZGatyYvWvfiG6UhmHoH6AdehF1W908abwHsxmdxW6GVX9r7U
	kR5nXJZ4Kbs4R1UHR6yno8VLKvW25ZiBhXgnN
X-Gm-Gg: ASbGnctM3oPy7KB1ScREIsaioeQmBFOqyfYHxpIGLpUyJOdEsTSBHVswPuMCZCeKCjX
	r8J9AWGOEvB5qLytWNxjEw/hYaLEa2LgetTTT0DZGz5oPM0W5tdzZm59UYpT9sxgp8bba+NV0QO
	dbTANFjgoUNBG/L9YdaZLOOvbKn/cBNl4InMlYZAV5JtU9CtllLPWv
X-Google-Smtp-Source: AGHT+IFyLONDsmo4q+s/Se+asT70Fizp6jQ0wtmTB8UY4hyRCcY4MwRiME7C7lDD3pd9NG8mZH/C3OyNJ5NWWIzys4Q=
X-Received: by 2002:ac2:4c39:0:b0:549:4bc4:d3f7 with SMTP id
 2adb3069b0e04-54adef08baemr145746e87.5.1742786732985; Sun, 23 Mar 2025
 20:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320135734.3778611-1-khtsai@google.com> <20250321220346.wwt3vfwmrcq3qwzj@synopsys.com>
In-Reply-To: <20250321220346.wwt3vfwmrcq3qwzj@synopsys.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Mon, 24 Mar 2025 11:25:06 +0800
X-Gm-Features: AQ5f1Jqct093Fmcmrd_6vJLJFARrA4kA9RxtRRr-REHnftM_9zxYRo89GNiEeME
Message-ID: <CAKzKK0o__XbUhbFAn-uh-r-dLDCVOUr4JDYGDYnM2K0v_FrWPw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Abort suspend on soft disconnect failure
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 6:03=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Thu, Mar 20, 2025, Kuen-Han Tsai wrote:
> > When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> > going with the suspend, resulting in a period where the power domain is
> > off, but the gadget driver remains connected.  Within this time frame,
> > invoking vbus_event_work() will cause an error as it attempts to access
> > DWC3 registers for endpoint disabling after the power domain has been
> > completely shut down.
> >
> > Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> > controller and proceeds with a soft connect.
> >
> > CC: stable@vger.kernel.org
>
> Please add Fixes tag.

Sent out v2 version of the patch.
https://lore.kernel.org/linux-usb/20250324031758.865242-1-khtsai@google.com=
/

>
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> >
> > Kernel panic - not syncing: Asynchronous SError Interrupt
> > Workqueue: events vbus_event_work
> > Call trace:
> >  dump_backtrace+0xf4/0x118
> >  show_stack+0x18/0x24
> >  dump_stack_lvl+0x60/0x7c
> >  dump_stack+0x18/0x3c
> >  panic+0x16c/0x390
> >  nmi_panic+0xa4/0xa8
> >  arm64_serror_panic+0x6c/0x94
> >  do_serror+0xc4/0xd0
> >  el1h_64_error_handler+0x34/0x48
> >  el1h_64_error+0x68/0x6c
> >  readl+0x4c/0x8c
> >  __dwc3_gadget_ep_disable+0x48/0x230
> >  dwc3_gadget_ep_disable+0x50/0xc0
> >  usb_ep_disable+0x44/0xe4
> >  ffs_func_eps_disable+0x64/0xc8
> >  ffs_func_set_alt+0x74/0x368
> >  ffs_func_disable+0x18/0x28
> >  composite_disconnect+0x90/0xec
> >  configfs_composite_disconnect+0x64/0x88
> >  usb_gadget_disconnect_locked+0xc0/0x168
> >  vbus_event_work+0x3c/0x58
> >  process_one_work+0x1e4/0x43c
> >  worker_thread+0x25c/0x430
> >  kthread+0x104/0x1d4
> >  ret_from_fork+0x10/0x20
> >
> > ---
> >  drivers/usb/dwc3/core.c   | 10 +++++++---
> >  drivers/usb/dwc3/gadget.c | 22 +++++++++-------------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 66a08b527165..d64d17677bdb 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2387,7 +2387,7 @@ static int dwc3_core_init_for_resume(struct dwc3 =
*dwc)
> >  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >  {
> >       u32 reg;
> > -     int i;
> > +     int i, ret;
>
> Minor nit: Can we keep declarations in separate lines.

Fixed.

>
> >
> >       if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
> >               dwc->susphy_state =3D (dwc3_readl(dwc->regs, DWC3_GUSB2PH=
YCFG(0)) &
> > @@ -2406,7 +2406,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >       case DWC3_GCTL_PRTCAP_DEVICE:
> >               if (pm_runtime_suspended(dwc->dev))
> >                       break;
> > -             dwc3_gadget_suspend(dwc);
> > +             ret =3D dwc3_gadget_suspend(dwc);
> > +             if (ret)
> > +                     return ret
> >               synchronize_irq(dwc->irq_gadget);
> >               dwc3_core_exit(dwc);
> >               break;
> > @@ -2441,7 +2443,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >                       break;
> >
> >               if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE) {
> > -                     dwc3_gadget_suspend(dwc);
> > +                     ret =3D dwc3_gadget_suspend(dwc);
> > +                     if (ret)
> > +                             return ret;
> >                       synchronize_irq(dwc->irq_gadget);
> >               }
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 89a4dc8ebf94..316c1589618e 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -4776,26 +4776,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> >       int ret;
> >
> >       ret =3D dwc3_gadget_soft_disconnect(dwc);
> > -     if (ret)
> > -             goto err;
> > -
> > -     spin_lock_irqsave(&dwc->lock, flags);
> > -     if (dwc->gadget_driver)
> > -             dwc3_disconnect_gadget(dwc);
> > -     spin_unlock_irqrestore(&dwc->lock, flags);
> > -
> > -     return 0;
> > -
> > -err:
> >       /*
> >        * Attempt to reset the controller's state. Likely no
> >        * communication can be established until the host
> >        * performs a port reset.
> >        */
> > -     if (dwc->softconnect)
> > +     if (ret && dwc->softconnect) {
> >               dwc3_gadget_soft_connect(dwc);
> > +             return ret;
> > +     }
> >
> > -     return ret;
> > +     spin_lock_irqsave(&dwc->lock, flags);
> > +     if (dwc->gadget_driver)
> > +             dwc3_disconnect_gadget(dwc);
> > +     spin_unlock_irqrestore(&dwc->lock, flags);
> > +
> > +     return 0;
> >  }
> >
> >  int dwc3_gadget_resume(struct dwc3 *dwc)
> > --
> > 2.49.0.395.g12beb8f557-goog
> >
>
> The rest looks good.
>
> Thanks,
> Thinh

Thanks,
Kuen-Han

