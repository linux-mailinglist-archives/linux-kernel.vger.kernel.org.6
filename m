Return-Path: <linux-kernel+bounces-530392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1273A432DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11403B8007
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD780BFF;
	Tue, 25 Feb 2025 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvXlh+6s"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573E440C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449583; cv=none; b=eqfL7trY+ENcrU03/6tAouJLQWO2+t6iMkJ+l0yZOHyVeepQMEt2U94GgpZQ2md5JvNmwxKWlwHNzq/BiSUjiAzidacMgZYYNZM6JO/8fv0IoA91KRAMEdRlKh4NfMl6cwNYkvoSCtgW9jGHT0QqF0k35QTZZ1r1wQ5qE2XGEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449583; c=relaxed/simple;
	bh=lXRmnwuKZxxXC9VgJj6nwNgsq3hfeZAVMV5ARMeX0Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo/kItr3A3CRaBvdGxatTA4A0POO7e4qXlo5+ufJmEXcPj/0YgkvNS2MjqBfIkSrnkYvSgjoh+yqs657NWE4r6MTmXntDAGBW/AqvQDAW+HBwMu1fhG1THhgobvyv2ZX59iX6OyhaamYMqx7Fo0lWaHSV9RW9YiYjS5HufQa/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvXlh+6s; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc11834404so7880496a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740449581; x=1741054381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DBEs+A6FFB+FcZDjRgx+U08JOjkVxQ1L/gndBhqEk6Y=;
        b=mvXlh+6sJR4W/3Hmfdzs6LEP1G2nbhlNwGvKvb55HWGrI85ppYr6LpgwyyOvYEvG0D
         QcGfDSZmnSJ6UQMHQD7F3t8cVYvfK63T9olo8wgCycqjJgqb5AMYEu6veKgcYUfdx69h
         Tq9Ou7PL6OamKYqklXQyJ1F7CswsZIMnWF+SRV4X06GHbsuyc0qzZCLFIQzf5p5A2zKe
         Z4UPd8GpTKBYdyqxgywcQ6mfjDfqPxOCcYySUzzrBQrr1T43FBha+4CUwsB16K53I/ac
         mUqnRwlVHH32YgS+LUbAN/kgaX7+fxjgozFnPzzLvRzmvBtl7d460xMCsZ5/ofU/HrNP
         muHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449581; x=1741054381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBEs+A6FFB+FcZDjRgx+U08JOjkVxQ1L/gndBhqEk6Y=;
        b=U7X517GVqt3mXSgskFOdaEAuSrHg6uaiio14FTGNvSQ5oCIkFel90T99JPVtOnFvQs
         ExKg7ACejaEdzLwuoGGLEje5JPc5nQrq7MYSryeI3IQlPAQz5BZTczs6gRe2yVMzYA72
         5ljaorm1mqbouaJW+kchvVDtcaRxzeGHed7aw8Ym5SKh7Sng/Cckem1mQIoGrcw/yeCd
         h/szJKi5TUdRK/sxnIQSIy+/fVj0/KteBNxDMOrQOT+851SnIZ4X/KuMVsCc1BIdsu3k
         Z4yZl9o3IHN6uLGFu3bIhQPdBTKlZqTQeDo15l1P9VfFXPZYg0z8Wb+yPtWYqVUgXnwo
         tlwg==
X-Forwarded-Encrypted: i=1; AJvYcCW6By/J+RU/HzTFOeBWaUCU4tWq1clqqIiImOIaPF4i19q8lPHjzTwjOOQDnVGnBkibE6KRmKOISu2sgJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0sjMc+cd3TNKKDUYaaxmOFTomdgAeFO8R5cZ7sRrT5QPS6IW
	FvsDhCM+OUdOC2p7qN4CjsxsvmMGRRLbMp6aoFsaFWDLy30YY2Jr
X-Gm-Gg: ASbGncsf6g2RiOfqLTOp6qC3vhrpqTHRxbPkH0d+OR/WnIIO2Orlq8h9vmI81J7ZDT8
	CAP7Whn/kCExu0EftWTxbOf73bz6lrBv2Wj11lzct461ZcZaNZYggRkKWMxzq+skXmUHBc5420U
	93S4qdfiVc9UvBLrQ7I928+zjTYfEoWuKXhEKjgHi7hyKUVtOUiSGy0RIWC6VDf54ZzqfQDt2D4
	HG08I3RhhmPtXBt8/DTITSngsyeEgz2yJWnf2jOfWGgT4yvVoI7l+7Lr7Og036qlfjKd6mE3bPx
	3e7NXfNYfLOZxnx+6/nfHUeRg2U=
X-Google-Smtp-Source: AGHT+IG83NF6/7F7raRvroX/yEdLNpC0D4Ri639SqNTmZmYc30ey+C+/PsGQ2Wnp8hw/z4jk1JJxlQ==
X-Received: by 2002:a17:90b:3ec7:b0:2fa:1451:2d56 with SMTP id 98e67ed59e1d1-2fce873af1amr25575495a91.25.1740449581456;
        Mon, 24 Feb 2025 18:13:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:464c:6229:2280:227e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3f1c5dsm416193a91.21.2025.02.24.18.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:13:01 -0800 (PST)
Date: Mon, 24 Feb 2025 18:12:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 2/2] driver core: fix potential NULL pointer dereference
 in dev_uevent()
Message-ID: <Z70nKlCqhs0I1nvJ@google.com>
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
 <20250220064647.2437048-2-dmitry.torokhov@gmail.com>
 <CAJZ5v0geh6yAfOgo+ayvXaTTpq=ubQkM-qU22ETB6b24EOULLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0geh6yAfOgo+ayvXaTTpq=ubQkM-qU22ETB6b24EOULLg@mail.gmail.com>

On Thu, Feb 20, 2025 at 11:59:02AM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 20, 2025 at 7:47 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > If userspace reads "uevent" device attribute at the same time as another
> > threads unbinds the device from its driver, change to dev->driver from a
> > valid pointer to NULL may result in crash. Fix this by using READ_ONCE()
> > when fetching the pointer, and take bus' drivers klist lock to make sure
> > driver instance will not disappear while we access it.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/base/base.h |  1 +
> >  drivers/base/bus.c  |  2 +-
> >  drivers/base/core.c | 32 ++++++++++++++++++++++++++++++--
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 8cf04a557bdb..91b786891209 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp)
> >                 kset_put(&sp->subsys);
> >  }
> >
> > +struct subsys_private *bus_to_subsys(const struct bus_type *bus);
> >  struct subsys_private *class_to_subsys(const struct class *class);
> >
> >  struct driver_private {
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index 6b9e65a42cd2..c8c7e0804024 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -57,7 +57,7 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
> >   * NULL.  A call to subsys_put() must be done when finished with the pointer in
> >   * order for it to be properly freed.
> >   */
> > -static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
> > +struct subsys_private *bus_to_subsys(const struct bus_type *bus)
> >  {
> >         struct subsys_private *sp = NULL;
> >         struct kobject *kobj;
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 9f4d4868e3b4..670f77b9b378 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2623,6 +2623,34 @@ static const char *dev_uevent_name(const struct kobject *kobj)
> >         return NULL;
> >  }
> >
> > +/*
> > + * Try filling "DRIVER=<name>" uevent variable for a device. Because this
> > + * function may race with binding and unbinding device from a driver we need to
> > + * be careful. Binding is generally safe, at worst we miss the fact that device
> > + * is already bound to a driver (but the driver information that is delivered
> > + * through uevents is best-effort, it may become obsolete as soon as it is
> > + * generated anyways). Unbinding is more risky as driver transitioning to NULL,
> > + * so READ_ONCE() should be used to make sure we are dealing with the same
> > + * pointer, and to ensure that driver structure is not going to disappear from
> > + * under us we take bus' drivers klist lock. The assumption that only registered
> > + * driver can be bound to a device, and to unregister a driver bus code will
> > + * take the same lock.
> > + */
> > +static void dev_driver_uevent(const struct device *dev, struct kobj_uevent_env *env)
> > +{
> > +       struct subsys_private *sp = bus_to_subsys(dev->bus);
> > +
> > +       if (sp) {
> > +               scoped_guard(spinlock, &sp->klist_drivers.k_lock) {
> > +                       struct device_driver *drv = READ_ONCE(dev->driver);
> 
> I think you need to use a matching WRITE_ONCE() on the update side
> because you don't want to READ_ONCE() a partially updated memory
> location.

Yes, indeed, thank you Rafael. I forgot that it is no longer guaranteed
that we won't have tearing when writing native word sizes.

Thanks.

-- 
Dmitry

