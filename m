Return-Path: <linux-kernel+bounces-270116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DA943C09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A325D1F20F23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE201A3BD1;
	Thu,  1 Aug 2024 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvzTbLWr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E714A629;
	Thu,  1 Aug 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471369; cv=none; b=GlJV+VESMli5LT8JdtPGUkdxkJUqWE7VZFmmpO7KwHg+OOfPWqn5mUnwuG7hNMybLHPsqix3Rq0r2Wju61/0ZFFQPIGTPbWA61pGF11OwwlXsK61Xc6hiMRV56f+jyhtSXwgPZHayOCdDhGKc+x/p87Ejh3p+lwVidORSMiSM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471369; c=relaxed/simple;
	bh=42AfCx3ufc1B2EKtDcTnEcaYqCo8NXBaqlZ17e/CsgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUenC9EBO4yTVZJKWCd6ozNkmVoqEMg1f8FLCuf+veLoesS+4hqbXqeh97dS62pi/mwHY+dgO0WJbbQxb4mlF5gqz7pRkwoj6JbW9uwfPy3ycENChpR6fMl1TJo5peMa4qcsniYLS8mybnN193VmbPAHNeB0szQ0a2A+E30uVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvzTbLWr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368712acb8dso2937371f8f.2;
        Wed, 31 Jul 2024 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722471366; x=1723076166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRkYqO2P8nnqqntdMnDilxg3w2ZBfpu3nGxr3a/WiDk=;
        b=kvzTbLWrXnvQBtAUjymVl6qY2EbQ1bTbp0cYUmds5k0CpKq0O10noTzVGIGg4MgpGZ
         v9aVBbQWSZcHfHv6m5pZTfixm2UlN+gbw87T2XumzZLaa9yMPxVKLFqT68KxEcfhgBxN
         xH4F/kZVtHvJRb1rRd6+7ysG5AL9PDycL+wi8eDytWn1Asaw3QGiu0hk+FPku7xhs7CP
         LidpkeLY4igJ6yVhMj9BYImsRGiYC5vH7KoWhIkEMZl/bLG34ZbJYVB+E3Qw++inWFIQ
         qVjwTy/tg/9Adn++cYyReamN5Wx1kus5LHVZGaBB9C/e8VmtcN3y4uNZ5q7oThZJOA6G
         yWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722471366; x=1723076166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRkYqO2P8nnqqntdMnDilxg3w2ZBfpu3nGxr3a/WiDk=;
        b=Xkz9OIYbX13SqEoFTs2k1HJOP5tayxdMZFR3d1fzXlyvScuoLYGc+fKB3MbL5wVJLq
         MID3hibE9SHoj5+p0Z8pyAxe8Bv/aecunoEpDijIJ1JLrm+T2dcT4FDRV57YdCKHekew
         zB4RTPEmB5bPKgN6tpd+SIjtuhEQgbjhf5S+hO4CEVxC2sxXgUTDNyaDUPwVz83uszy3
         RNxkOJBk6DTymi8V66wyIV2luYTmI71fbPEoJKa6+ThS9fQ5kjcEV0ghLpKJD7Top3oA
         i2Z4MI3SS5PrQxU2bbsc59CCW974Od6i/8NWM/8f5FgBIR6UdkDf5EyhhyAx38dnft4B
         pZdg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5/ZyTCVIrNtRo336zRf1onNywq9QAgEdmGxVkUrobPcBwUy8niScfhaKpiXW3+btR8KDzPG4o9Xa9CEHblrs8fBEjHHvP81i7/YT2JAW/asm946lVW1xkZyO9Q3Kjfk8xFoGx8ij
X-Gm-Message-State: AOJu0Yza74qhDvjpHIuoYc2yZV9R4RCBXKqB5Hii7yR2Crf9+IptiW+q
	/o7FYkPR8OQ8sx7+v+0U4eOQGEfV8vsHNj2ZgU1mfv9lQOPQpoukTX3ItsDkZO1A21E/SuazER4
	YuyZ0sX14vMknzUWlDNA+ojVslCjaLA==
X-Google-Smtp-Source: AGHT+IHihG5fc2TOTPRnyUAhZymj6C0bBOiCsb8eFx7G1NMahwLhNH2jH86SgVkoqCWzawM7NCLfALGA1Zrqmo7Yzqo=
X-Received: by 2002:a5d:58c8:0:b0:368:65ad:529 with SMTP id
 ffacd0b85a97d-36baacd30f6mr418940f8f.17.1722471365246; Wed, 31 Jul 2024
 17:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
 <2024073114-singular-stream-1dd9@gregkh>
In-Reply-To: <2024073114-singular-stream-1dd9@gregkh>
From: Chris Wulff <crwulff@gmail.com>
Date: Wed, 31 Jul 2024 20:15:54 -0400
Message-ID: <CAB0kiB+tzV2JPc2X_WKr5yMJ5sy7QO2o0mcqUdD8CMd68EGmhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
To: Greg KH <greg@kroah.com>
Cc: Chris Wulff <Chris.Wulff@biamp.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Sands <David.Sands@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:30=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Apr 17, 2024 at 06:29:27PM +0000, Chris Wulff wrote:
> > While supporting GET_REPORT is a mandatory request per the HID
> > specification the current implementation of the GET_REPORT request resp=
onds
> > to the USB Host with an empty reply of the request length. However, som=
e
> > USB Hosts will request the contents of feature reports via the GET_REPO=
RT
> > request. In addition, some proprietary HID 'protocols' will expect
> > different data, for the same report ID, to be to become available in th=
e
> > feature report by sending a preceding SET_REPORT to the USB Device that
> > defines what data is to be presented when that feature report is
> > subsequently retrieved via GET_REPORT (with a very fast < 5ms turn arou=
nd
> > between the SET_REPORT and the GET_REPORT).
> >
> > There are two other patch sets already submitted for adding GET_REPORT
> > support. The first [1] allows for pre-priming a list of reports via IOC=
TLs
> > which then allows the USB Host to perform the request, with no further
> > userspace interaction possible during the GET_REPORT request. And anoth=
er
> > [2] which allows for a single report to be setup by userspace via IOCTL=
,
> > which will be fetched and returned by the kernel for subsequent GET_REP=
ORT
> > requests by the USB Host, also with no further userspace interaction
> > possible.
> >
> > This patch, while loosely based on both the patch sets, differs by allo=
wing
> > the option for userspace to respond to each GET_REPORT request by setti=
ng
> > up a poll to notify userspace that a new GET_REPORT request has arrived=
. To
> > support this, two extra IOCTLs are supplied. The first of which is used=
 to
> > retrieve the report ID of the GET_REPORT request (in the case of having
> > non-zero report IDs in the HID descriptor). The second IOCTL allows for
> > storing report responses in a list for responding to requests.
> >
> > The report responses are stored in a list (it will be either added if i=
t
> > does not exist or updated if it exists already). A flag (userspace_req)=
 can
> > be set to whether subsequent requests notify userspace or not.
> >
> > Basic operation when a GET_REPORT request arrives from USB Host:
> >
> > - If the report ID exists in the list and it is set for immediate retur=
n
> >   (i.e. userspace_req =3D=3D false) then response is sent immediately,
> > userspace is not notified
> >
> > - The report ID does not exist, or exists but is set to notify userspac=
e
> >   (i.e. userspace_req =3D=3D true) then notify userspace via poll:
> >
> >       - If userspace responds, and either adds or update the response i=
n
> >         the list and respond to the host with the contents
> >
> >       - If userspace does not respond within the fixed timeout (2500ms)
> >         but the report has been set prevously, then send 'old' report
> >         contents
> >
> >       - If userspace does not respond within the fixed timeout (2500ms)
> >         and the report does not exist in the list then send an empty
> >         report
> >
> > Note that userspace could 'prime' the report list at any other time.
> >
> > While this patch allows for flexibility in how the system responds to
> > requests, and therefore the HID 'protocols' that could be supported, a
> > drawback is the time it takes to service the requests and therefore the
> > maximum throughput that would be achievable. The USB HID Specification
> > v1.11 itself states that GET_REPORT is not intended for periodic data
> > polling, so this limitation is not severe.
> >
> > Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loading
> > showed that userspace can typically respond to the GET_REPORT request
> > within 1200ms - which is well within the 5000ms most operating systems =
seem
> > to allow, and within the 2500ms set by this patch.
> >
> > [1] https://marc.info/?t=3D165968296600006 [2]
> > https://marc.info/?t=3D165879768900004
> >
> > Signed-off-by: David Sands <david.sands@biamp.com>
> > Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
> > ---
> >  drivers/usb/gadget/function/f_hid.c | 270 +++++++++++++++++++++++++++-
> >  include/uapi/linux/usb/g_hid.h      |  40 +++++
> >  include/uapi/linux/usb/gadgetfs.h   |   2 +-
> >  3 files changed, 304 insertions(+), 8 deletions(-)
> >  create mode 100644 include/uapi/linux/usb/g_hid.h
>
> Can you rebase this and resubmit against the latest kernel tree?  It's
> been a while since this was last submitted, sorry for the delay in
> reviewing it.

Yeah, I'll rebase it and make sure it still works and then send out an upda=
te.

No worries about the review delay. Seeing the quantity of traffic on
the usb list
I'm sure you keep pretty busy.

>
> greg k-h
>

