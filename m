Return-Path: <linux-kernel+bounces-365069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C00799DD10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DE62834C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316F17278D;
	Tue, 15 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4HznoaE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C516EB5D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964685; cv=none; b=H/0rA8zAt5KL9WrSEVcpgH30RL4JEkpwrFZUGEzv4KrFO/gGzc39kdvWc5gBrWCvclU6sqOpQqw0xbP7r0fT4cfVEaFOgGlUqpEVm9Z2FEM5MIK3SEKlm66O7PelxdVCsSHrMi8jFKRTnXlIDuo6GwToDyXFP9GQHmTgy1fSHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964685; c=relaxed/simple;
	bh=N40ZSNWwPk28dZ+LQrxhSO5jACT0zCPufmoUUaRuVJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LckYckQQGGRtXJZc1yWzE6svi4p0nOxdvrY834eshXzPqAVoDHrbgJ+CCOfW4FUUmpQlIRdhAkAbAguhqelzLEgqDh7W88nWVOOcrYN3t0+VhmMPyK2E8HNvfTdj7ZVqus2Ca3fKVZ7Kn078wQKgwWFxCl2enYAGaB0rPLgMV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4HznoaE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so35235a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728964681; x=1729569481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9QWKZtDdFz4L73hcRjBFd+xD0iZq8pzY5qOSjjFSZc=;
        b=R4HznoaEDlNPDF6EM7qoHkybgoUZcuH9su7oJQBvY0oqXKrBxJHr/8cCndMM+uLrAh
         8ersWRigFXsZ0/Vi4gpvK9eUrKIDCcNarKZxA/VDQTGxgmh3r3csUFuUJ+LCGKzaGLe4
         8YxjzI7xba9K+TWqNpvkbitMVq6FkGOcX7tihNMsqd0T3zRlOkQbXZReDgAp6kxMoQvQ
         Vj6zA22p/6fymGOR8wINgR9vShNrGpjf9SJCLr8cdyol5/cKtgWWb8L5Pa1/UXG/lrRg
         CZdFbEAh6mmGOg209D8Sab4Ol2RJqj4CeeKZSr9z4x6MT6K9fsxIOTA2vLQpDrukssE+
         AF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728964681; x=1729569481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9QWKZtDdFz4L73hcRjBFd+xD0iZq8pzY5qOSjjFSZc=;
        b=XQ1p9c/5XKLwGShDUnUIq8Wnd3dmBieBropFtr+ND0QRNLYCwqD1d9IU9M/YUzNuAs
         U9loOsx3ji7uWVnfkJTkUPC5gi+DAYJFBDwQVBB8vj7SuiSItvo1sZZGLUqW8M9u1T9B
         V4GHcHHou7ERXQsUV+ryboAb7daZkxECP+VHoGNGRMQRzcPlSqr4LwsnQIJkj1hx4VEe
         oZODop2G/uHRcQebjrt1YChefHyhWqThsBYwiS6upGdNV+Kp1WdTV0MddaJxmXLE0dfW
         5r340cMeSvTScAjbFGY/fjzlHP0lSCdj1B40oyTkksBRBYgbWMjizzqb/1uJeGh0pwOw
         E5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw2zcYANg93E/gRa4Z7KBt6zk0I11c7hjNiJTkS5PcVLmofeJxKDWIXklfBKyX7I1pFFcyZ656i1VZLMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbB44/h1nhujKYLO+q9V2pxEtn8a6AAm+kR8BcmxQWOay2YU8r
	ILV5GSn1rpLwLLXIVeY4mXIdbcsZdoz7UwLJ3w+prnBFgKFfADmUnz6eK8d0Agv9cEurutfCgQs
	rHc42XBnJNhCTfjh5bp+pYNDV+qq8wIKxwhAo
X-Google-Smtp-Source: AGHT+IE/Mbk48UdN6n+R06D0061d9x0T4HYynAxMG9ehl5kqxUTk/rg+uyWs8G1J3z3EpkLDqsneJzTbxqupOe4TGro=
X-Received: by 2002:a05:6402:26c1:b0:5c2:5641:af79 with SMTP id
 4fb4d7f45d1cf-5c95b0bd39amr641707a12.0.1728964680865; Mon, 14 Oct 2024
 20:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014085816.1401364-1-guanyulin@google.com>
 <20241014085816.1401364-6-guanyulin@google.com> <9b5fe5d2-77a7-40b7-b260-856c35d9dcec@rowland.harvard.edu>
In-Reply-To: <9b5fe5d2-77a7-40b7-b260-856c35d9dcec@rowland.harvard.edu>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 15 Oct 2024 11:56:00 +0800
Message-ID: <CAOuDEK2f_mtfiye7MdnOqEkq3pYW1kcdkwEMMBC5CkkQ1OGu3A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] usb: host: enable sideband transfer during system sleep
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	mathias.nyman@intel.com, yajun.deng@linux.dev, sumit.garg@linaro.org, 
	kekrby@gmail.com, oneukum@suse.com, dianders@chromium.org, perex@perex.cz, 
	tiwai@suse.com, niko.mauno@vaisala.com, andreyknvl@gmail.com, 
	christophe.jaillet@wanadoo.fr, tj@kernel.org, stanley_chang@realtek.com, 
	quic_jjohnson@quicinc.com, ricardo@marliere.net, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, badhri@google.com, 
	albertccwang@google.com, quic_wcheng@quicinc.com, pumahsu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:56=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Mon, Oct 14, 2024 at 08:50:29AM +0000, Guan-Yu Lin wrote:
> >
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index e713cf9b3dd2..eb85cbb1a2ff 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t=
 msg)
> >       struct usb_device       *udev =3D to_usb_device(dev);
> >       int r;
> >
> > +     if (msg.event =3D=3D PM_EVENT_SUSPEND && usb_sideband_check(udev)=
) {
> > +             dev_dbg(dev, "device accessed via sideband\n");
> > +             return 0;
> > +     }
>
> I'm not so sure about this.  By returning early, you prevent the drivers
> bound to this device from suspending.  But they can't operate properly
> when the system is in a low-power mode.  Won't that cause problems?
>
> Maybe this really belongs in usb_suspend_device(), and its counterpart
> belongs in usb_resume_device().
>

To my understanding, after the system is suspended, the USB driver
will do nothing as the main processor has been suspended. May I check
what forms of low power mode and operation we are discussing here?

usb_suspend_device() did close the required port/bus to maintain usb
transfer. However, there are additional usb_hcd_flush_endpoint() calls
aside from usb_suspend_device(). Maybe we should consider not doing
those also since some of the endpoints are now handled by the
sideband.

> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 1ff7d901fede..9876b3940281 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -2593,6 +2593,7 @@ struct usb_hcd *__usb_create_hcd(const struct hc_=
driver *driver,
> >       timer_setup(&hcd->rh_timer, rh_timer_func, 0);
> >  #ifdef CONFIG_PM
> >       INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
> > +     refcount_set(&hcd->sb_usage_count, 0);
>
> Did I miss something?  I didn't notice this field in any of the earlier
> patches.  Was it already created by the prerequisite series?  If so, why
> didn't that series do this initialization?
>
> >  #endif
> >
> >       INIT_WORK(&hcd->died_work, hcd_died_work);
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 0b4685aad2d5..d315d066a56b 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -671,6 +671,7 @@ struct usb_device *usb_alloc_dev(struct usb_device =
*parent,
> >       dev->state =3D USB_STATE_ATTACHED;
> >       dev->lpm_disable_count =3D 1;
> >       atomic_set(&dev->urbnum, 0);
> > +     refcount_set(&dev->sb_usage_count, 0);
>
> And doesn't this belong in the 3/5 patch, the one that creates the
> sb_usage_count field?
>
> Alan Stern

Thanks for the suggestion, I'll move this, as well as the
initialization of hcd->sb_usage_count, to corresponding earlier
patches.

Regards,
Guan-Yu

