Return-Path: <linux-kernel+bounces-274935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 017AC947E77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56464B20BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71528158D87;
	Mon,  5 Aug 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOxsqe3c"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CB3CF5E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872781; cv=none; b=iDIShgvX7k/XSZGuQ2aCSA/Dga4IPifBhkoczEAf1bySx4WWknFDwvl1QIXRWXQC55cRk0tA9ZZ8yZR6+2JxRhrGm7ghERIJEMmyX615/ywFqHpa5xTIcxfloO5zOEsrlhjJYaU82Ls1FqwAvRKs97pIP2hSlp+J5QGuvODbhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872781; c=relaxed/simple;
	bh=5wjHU1wKHRRchFX2cqWEk5v6q0TdpGyDqI3gFeTqBiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkBs0N56iCptQ4IxOOc3GMq2bucB7XOTqeG8B32fAMeyNQz6eFVOvMUxxn66vrQjb+lOPKTPLpfPFbo7ySgMvg+hEatuuJAuJh4vTJrVMwqO8uPDCvNQSAv3N0tucwXcYAd06rpznZZEeqsc8sypA2+9AgRSUBZmRifV2qjJmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UOxsqe3c; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093997dffdso3459912a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722872779; x=1723477579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqOaptwxc12t3A/k1QIs7JMco9pX/hGJo5YaprxUknE=;
        b=UOxsqe3cbqludNtOBbYkk/wjzak5Sst16gQvEGUWEK3sclUoWL+DeodBNdSEBlouZK
         J1uEhdL01XbyWqbCSsZkMy850FTnvcS1oTC7rSFOML/hdXmFl2kkDxgZ1tZFaCMmWe7D
         RATHh4qapcb4ZPs9bJD9ZKCNAj0a7vS8oHCWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872779; x=1723477579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqOaptwxc12t3A/k1QIs7JMco9pX/hGJo5YaprxUknE=;
        b=Ww3scdpuUPQ4Z9INQeWcPrNjY/u9UFhquyAIkm/fcHHQqM77uX8LHm3rRp/NCpX4yH
         z+9Pi3oZ2tgMDIZ+tCcEICTIPuPotGaooVaJzVPTVPuyNtSSBvzrv+xcw7G8W2G2nHaL
         yzav+O1tChK95zFFhlnBSptI7xb/3F+rG3z4Iy0qnta9/i8LVN0buF9borS/mo57Y+IP
         OnIj7A2HHQhVutUHUe02Rtafyy8zLYSfJi2y2hhbMXokc5RifjGvaCmTnuacyccahH/e
         2f/bp1fdJDcOS00ucEXKqBWJWLwMiwVWK182639iEB4mWzEaqnAm0MvnU73LbxW5ITpz
         p+5w==
X-Forwarded-Encrypted: i=1; AJvYcCUfKzwo5y/1MPl8MCiE7dYA8Ko/e4VMd3weg5g42X+IqrAhBDFfUyCG86BT6fJqfp1y/Xxiii693MgMug6P41Q/RFq7OzslHQdL0hx8
X-Gm-Message-State: AOJu0Yz0oaZKXDYkTVHEEBTOyFDf/p87Ec3gvPnWDHSDSoOoEA+fncmL
	7+b2PNI+zuoi4Dr6Ie+YIhslF94LuQLe6XGxXycYdrB4mlhakqq6rGWSxlH3pjQWuyEb8ww5tX8
	=
X-Google-Smtp-Source: AGHT+IFwAmdxVhmaAA4/ikGDdVqr7UveeUr8vwj51g6uHT1Qqbw/ABAhfdIW0GEbC3AdmMUEwI5MPQ==
X-Received: by 2002:a05:6358:12a6:b0:1ac:f722:4d2 with SMTP id e5c5f4694b2df-1af3ba7c41fmr1235254755d.18.1722872778608;
        Mon, 05 Aug 2024 08:46:18 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78b17fsm36932976d6.34.2024.08.05.08.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:46:18 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4518d9fa2f4so849151cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD1fCvQoJHX4wUASJeXA71hzZ+6Vczpx2g2YbWJvk5+fhLoCfjaEqhPys2y7Lep9GNxPFCRz3OWpJfDKX4uL+z39Gerp6B5t22vyYL
X-Received: by 2002:a05:622a:282:b0:447:e542:93a7 with SMTP id
 d75a77b69052e-4519ad00ecbmr5909431cf.12.1722872777503; Mon, 05 Aug 2024
 08:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
 <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
In-Reply-To: <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:46:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Message-ID: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 7:28=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 5 Aug 2024, Jiri Slaby (SUSE) wrote:
>
> > Coverity reports (as CID 1536978) that uart_poll_init() passes
> > uninitialized pm_state to uart_change_pm(). It is in case the first 'if=
'
> > takes the true branch (does "goto out;").
> >
> > Fix this and simplify the function by simple guard(mutex). The code
> > needs no labels after this at all. And it is pretty clear that the code
> > has not fiddled with pm_state at that point.
> >
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> > Cc: stable@vger.kernel.org
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/serial_core.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 3afe77f05abf..d63e9b636e02 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2690,14 +2690,13 @@ static int uart_poll_init(struct tty_driver *dr=
iver, int line, char *options)
> >       int ret =3D 0;
> >
> >       tport =3D &state->port;
> > -     mutex_lock(&tport->mutex);
> > +
> > +     guard(mutex)(&tport->mutex);
> >
> >       port =3D uart_port_check(state);
> >       if (!port || port->type =3D=3D PORT_UNKNOWN ||
> > -         !(port->ops->poll_get_char && port->ops->poll_put_char)) {
> > -             ret =3D -1;
> > -             goto out;
> > -     }
> > +         !(port->ops->poll_get_char && port->ops->poll_put_char))
> > +             return -1;
> >
> >       pm_state =3D state->pm_state;
> >       uart_change_pm(state, UART_PM_STATE_ON);
> > @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *dr=
iver, int line, char *options)
> >               ret =3D uart_set_options(port, NULL, baud, parity, bits, =
flow);
> >               console_list_unlock();
> >       }
> > -out:
> > +
> >       if (ret)
> >               uart_change_pm(state, pm_state);
> > -     mutex_unlock(&tport->mutex);
> > +
> >       return ret;
> >  }
>
> This too needs #include.

Why? I see in "mutex.h" (which is already included by serial_core.c):

DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))

...so we're using the mutex guard and including the header file that
defines the mutex guard. Seems like it's all legit to me.

