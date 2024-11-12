Return-Path: <linux-kernel+bounces-406710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5D9C6285
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51593284B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645A21A4DB;
	Tue, 12 Nov 2024 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss2WasX8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D2219CB2;
	Tue, 12 Nov 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443173; cv=none; b=OrvaJ7f0yk94f7RoYnDhOom3B2pX8hYz5MzHKVdbXckuGoxbvmn7eRzUUWmxfEPTqeQyLM5fziqUCSOI1l3ngwfSr9R4To63AVvRZ8/Ym02kkQGiIR9GLGi4s2rQLvAisP7dib66NGfIJVXMeZUB46q0rfuZoGz1BfLRtq6+Yts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443173; c=relaxed/simple;
	bh=V3OkAFsxYbVBbmhzE2X3EXG4muf5JyI5ukKdSjG9AD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kamq98GOLYNaka4cXFZWVWEwPTk5AVyV5FlY5o4lTyM0g79OEUduoTGOZin+22eZnudcnedyzifcwRZExuUSoHKrjonuns9njoFH4nqLezzxiJOUMeQ6HwiEC/DC/t2N6h20j3uZ/FijO9Ogj7pnnlt2w3GvfdSoPYHDzbNKx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss2WasX8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so64653241fa.3;
        Tue, 12 Nov 2024 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731443170; x=1732047970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQWs6oDLhqhN+YcZsnW1nwP0EE615D1OAGENrXVm4Lk=;
        b=Ss2WasX8Osrv+F3yu2xmb9dd8etg/9ikoYSHFs/FD+qyJNyrbUTPjNj7cwIGSq4vLh
         dPvKPJx12HSi6I1TXIJkXNSV6wVN/X4cPljlcWm6rSApHwbj0CQ1oeta6pdU8Y8z7En+
         W0OAHWmcoS9w0wfZ+Xwprrt1AITBErZpwd8PVNss9v2sQaeQSVRrN993LHM9KmEk7hff
         Qqi1x4C+wZRpxr2fC8AAZQH5XLIqp3SDFYEPZjyq0OsppbOIHt3eR2MRTboUYoYX4G/n
         MPa/9SfteAKyMxjCK53BUYQ4pCjmScDTHe41qCMZiMv3Lo6iap7xSw9hnKquo8K0/XdG
         lkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443170; x=1732047970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQWs6oDLhqhN+YcZsnW1nwP0EE615D1OAGENrXVm4Lk=;
        b=ZRlfB/MVfidBEqQrS/pJmI99yfZfXiJafhKR0IOaaVko65TLYp8jxQLVeWaqAYgx8M
         pC+zyNlEFh8tqBlU6XCmdm3Liiyzekh+C2vsXQ88QzJrCfQ8tQZWlrdX3is6C6AcQaLZ
         EBCjJ1ZDoJFXm752kj5BXtY5ToCN5xk4zkFZR9Q+nrMjA2BCWIdvKRCC1/6DDpKliBdp
         69zHO12kU/vn9iajxR+t31KErzsuzN7R2vYe/5gS8QINTeM7yXpzr+siBIb4sAR/cc/U
         gw/x+qaOt+ohjABty6zXeaHlWcj5JBucEAfrT4gqUDaUMQ2fJiWSmpXQgH+RwKyaqwnL
         enSw==
X-Forwarded-Encrypted: i=1; AJvYcCVDqno1ffDFjIW6DgxHsSw3yr1FtiFGg3HjJPAyy5FeCRjEfYYsR6qWb2qNzXus4HZuUuOwd9F+C3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkMzGz6kWA9I8WPiAXaKK89eu2Qr2hSU4G/lWkke/cZY1MAk1
	U5Zu79SChbboPxzsgahdNX51xYoOPHF2HPjIJiK/UC2jqP42XowepW/qlQJ1X4oUxjT53xc/7y7
	70VUT7k3O7+re80CQHlqa0ihYjrONzHLDzgA=
X-Google-Smtp-Source: AGHT+IGhFEyZsGdDiKAEB7l4LMDTpccrTrNYfH0j0Yt1GQB8YtQF7Yd4YMwqHKeXrwKyQjtiZblxCO0PehHo8Ynuuz4=
X-Received: by 2002:a05:651c:1542:b0:2f1:a30c:cd15 with SMTP id
 38308e7fff4ca-2ff202ad40fmr91194841fa.36.1731443169732; Tue, 12 Nov 2024
 12:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105045535.84071-1-yesanishhere@gmail.com> <875xosqk3u.fsf@trenco.lwn.net>
In-Reply-To: <875xosqk3u.fsf@trenco.lwn.net>
From: anish kumar <yesanishhere@gmail.com>
Date: Tue, 12 Nov 2024 12:25:57 -0800
Message-ID: <CABCoZhDb4u=Gj=CPrjH+6tS+W8YENu9Oa2ymNhAegdhEM=ZHww@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Clarify EPROBE_DEFER retry mechanism
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:21=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> anish kumar <yesanishhere@gmail.com> writes:
>
> > The existing documentation for EPROBE_DEFER explains its purpose
> > and usage, but does not specify when deferred probes are retried.
> > This patch adds information about the retry mechanism to provide
> > a more complete explanation of how EPROBE_DEFER works.
> >
> > Specifically, it clarifies that:
> >
> > 1. Deferred probes are added to a pending list
> > 2. A successful probe of any device triggers moving all devices
> >    from the pending list to an active list
> > 3. A workqueue processes the active list to retry deferred probes
> >
> > This additional context helps developers better understand the
> > behavior and implications of using EPROBE_DEFER in their drivers.
> >
> > Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > ---
> >  Documentation/driver-api/driver-model/driver.rst | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documen=
tation/driver-api/driver-model/driver.rst
> > index 06f818b1d622..c86b948d0dfe 100644
> > --- a/Documentation/driver-api/driver-model/driver.rst
> > +++ b/Documentation/driver-api/driver-model/driver.rst
> > @@ -171,10 +171,13 @@ released all resources it allocated.
> >  Optionally, probe() may return -EPROBE_DEFER if the driver depends on
> >  resources that are not yet available (e.g., supplied by a driver that
> >  hasn't initialized yet).  The driver core will put the device onto the
> > -deferred probe list and will try to call it again later. If a driver
> > -must defer, it should return -EPROBE_DEFER as early as possible to
> > -reduce the amount of time spent on setup work that will need to be
> > -unwound and reexecuted at a later time.
> > +deferred probe list and will retry again as and when a device or drive=
r
> > +gets added to the system. A successful probe of any device will trigge=
r
> > +moving all devices from pending list to active list. A workqueue proce=
sses
> > +the active list to retry deferred probes. If a driver must defer, it
> > +should return -EPROBE_DEFER as early as possible to reduce the amount
> > +of time spent on setup work that will need to be unwound and reexecute=
d
> > +at a later time.
>
> Honestly, I don't see how this improves the situation?  How does this
> improve a driver developer's work?

It talks about when the retry mechanism executes. In my workplace we
had the discussion about this and some of the developers were assuming
EPROBE_DEFER gets called a fixed number of times which is not the case.
This explains when EPROBE_DEFER gets called and the mechanism for the
same.

>
> jon

