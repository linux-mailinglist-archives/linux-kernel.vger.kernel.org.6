Return-Path: <linux-kernel+bounces-422580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215309D9B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6717285ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D701D8DE4;
	Tue, 26 Nov 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICmP/x/C"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693DBE46
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638496; cv=none; b=j+Z0u64LLlcPeNGjDy7CKDfLEoixxw63NrusoNqCNDhgi2df+ZJbPh+STKvJit0ZcX46Cv6fGVlm87ZRfVhq4dMwsj/SiAabvPgCosWp/xkU4KNMzBpx3tfD65Z5+54BZnxIeT1jq6mPvKyIarZVTm2datXTftjg4lj0OKDL6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638496; c=relaxed/simple;
	bh=/VFh394bqpoPVPaVYrZD7casHaZGYWi9G0Bs0UrwOhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fx09TYszyC8EjjEHhpThp9y5GRgbZNAfLaCW4ellmaZewPLCOXVg1YjjM3F6mpTmUunxX437rLVerMGzUbiEToSBe0Tp6AD/cVMObHelA3Cug+B4MJbBRQSKXpQArUnQDUj7fYkxBDtRU6zaGgVjNS8eJcFa3yJDDkbfqLYNrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICmP/x/C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-212a3067b11so49493435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638493; x=1733243293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VFh394bqpoPVPaVYrZD7casHaZGYWi9G0Bs0UrwOhs=;
        b=ICmP/x/CIhjOEjccWcAP6H+mpnFt4HZxv+HrsAWupAOagnTvCOXRdJ1rz5C5v+5TnS
         UFPlJy2PWucmcS3UuyXbzIDfCzTT/GqESR/BV7GcToaC4jmtPf9PgwqPloOCwvUbxOth
         y5wpE43VOdlFcL5nnyblEni9ktltpumY7yyWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638493; x=1733243293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VFh394bqpoPVPaVYrZD7casHaZGYWi9G0Bs0UrwOhs=;
        b=lBqa32E8Vyg/qvJbWecGYzXLJFGbK9BIIe4CXsg+ZuJ+bQNwoNdJkOUWlOjEkSZx/A
         pP8hRkrnf7GwrSH70/0EoqYyrFVH/x0pv+nuOndPkbPoLJmya1NI05N9PuySxdDEqg8M
         kFtOKoyesz0hHx1IaElOaTfA/MUi4EuIz7v+M7N9HqsTRbnmJeS70WasTbKi1qrOpdu5
         unU6M39fVnpdcn0AewzBJFBHLb2Ns3gsZfeHs0DDS1NdUKYqCPR+n14OO2YGSEcZ/R4q
         ve7JnVxsnDyZ9sq2Y1rRwb3gxm/Jdanq3eI+LX1QoxRUeOvpd8SjKkfoz9ZbCxK+9Z/r
         7f2A==
X-Forwarded-Encrypted: i=1; AJvYcCUvH3yHhUm7tJ+wel6pfe7CcHF9YPZPG4TkEhR4BK6hDEKk8ORTkETCPIrDQQxn8wuoONWltL95Ei49qr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFRXrIR8KFYXcLj4bMk2B7f8yEbxCrZDwKo6dIiAdTzOVPIsh
	5hlM/QpImYy8w9eEy/vakAk6CnkboQzVObbg1/LZOPqwtyC5BCX/GCYbmI5Mq9ll26nkmtzdyt8
	=
X-Gm-Gg: ASbGncu1Cj4f6ycx1dPatx6xG3P5fmW0SMMvnyX5Hd/N1D8qDAaICuivwNTVeLHPajo
	vhffpY86aHT8YccA4hW8Lre1TtaBDxX4YPwbpDxNgXd4PR/w6I9GocsWwtTmXojQtjsJ8+1QWoO
	rDXpdp7weDV3s2ifxvXgQesN1sUmkXxWOVUDYS9peffEy+sB6qQyYHoCnh+Bra5idaP8F8277xj
	q7KFZVJMEUJMDYSJ1TfOP212xi6aMxELH9HJVxyYRDcOXrtUan7xejzGt0tW38Q5Tn7lcL26M1A
	kmcO91Bui9Ya
X-Google-Smtp-Source: AGHT+IGKbLDLjlEKouHdVtggfuJI7HIm7Ezc+a9VNvtrV2/BfRH8/BluC/p7OOZzXPY8wUWmgI2yxw==
X-Received: by 2002:a17:903:22ca:b0:20b:7a46:1071 with SMTP id d9443c01a7336-2129f67ae78mr258578405ad.4.1732638492688;
        Tue, 26 Nov 2024 08:28:12 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db88ff0sm86587285ad.53.2024.11.26.08.28.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 08:28:11 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so4928466a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:28:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHG7xS+IARKLY5sbw9YZeO74W2N2/OxEd/mFnO8rgaw8X0aXYWUJr5UKhMTaPTLDnu2RAmnRIHkLauIgU=@vger.kernel.org
X-Received: by 2002:a17:90b:1a8c:b0:2ea:65a1:9861 with SMTP id
 98e67ed59e1d1-2eb0e8856ebmr21070959a91.37.1732638490136; Tue, 26 Nov 2024
 08:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
 <bd68178f-1de9-491f-8209-f67065d29283@redhat.com> <CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com>
 <20241114230630.GE31681@pendragon.ideasonboard.com> <CANiDSCt_bQ=E1fkpH1SAft1UXiHc2WYZgKDa8sr5fggrd7aiJg@mail.gmail.com>
 <d0dd293e-550b-4377-8a73-90bcfe8c2386@redhat.com> <CANiDSCvS1qEfS9oY=R05YhdRQJZmAjDCxVXxfVO4-=v4W1jTDg@mail.gmail.com>
 <5a199058-edab-4f9d-9e09-52305824f3bf@redhat.com> <20241125131428.GD32280@pendragon.ideasonboard.com>
 <233eaf78-49f1-43c1-b320-c75cfc04103f@redhat.com> <20241125213521.GV19381@pendragon.ideasonboard.com>
In-Reply-To: <20241125213521.GV19381@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 17:27:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCvfnNKG8KUQEeBsr3JhWjUE+nBr4BTaR-sfaQQV9ZqSwQ@mail.gmail.com>
Message-ID: <CANiDSCvfnNKG8KUQEeBsr3JhWjUE+nBr4BTaR-sfaQQV9ZqSwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a evdev
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 at 22:35, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Nov 25, 2024 at 03:41:19PM +0100, Hans de Goede wrote:
> > Hi,
> >
> > On 25-Nov-24 2:14 PM, Laurent Pinchart wrote:
> > > On Mon, Nov 25, 2024 at 01:01:14PM +0100, Hans de Goede wrote:
> > >> On 18-Nov-24 5:47 PM, Ricardo Ribalda wrote:
> > >>> On Mon, 18 Nov 2024 at 16:43, Hans de Goede wrote:
> > >>>> On 15-Nov-24 9:20 AM, Ricardo Ribalda wrote:
> > >>>>> On Fri, 15 Nov 2024 at 00:06, Laurent Pinchart wrote:
> >
> > <snip>
> >
> > >>>>>> Is there any ACPI- or WMI-provided information that could assist=
 with
> > >>>>>> associating a privacy GPIO with a camera ?
> > >>
> > >> I just realized I did not answer this question from Laurent
> > >> in my previous reply.
> > >>
> > >> No unfortunately there is no ACPI- or WMI-provided information that
> > >> could assist with associating ACPI/WMI camera privacy controls with
> > >> a specific camera. Note that these are typically not exposed as a GP=
IO,
> > >> but rather as some vendor firmware interface.
> > >>
> > >> Thinking more about this I'm starting to believe more and more
> > >> that the privacy-control stuff should be handled by libcamera
> > >> and then specifically by the pipeline-handler, with some helper
> > >> code to share functionality where possible.
> > >>
> > >> E.g. on IPU6 equipped Windows laptops there may be some ACPI/WMI
> > >> driver which provides a /dev/input/event# SW_CAMERA_LENS_COVER node.
> > >
> > > Using an event device means that the user would need permissions to
> > > access it. Would distributions be able to tell the device apart from
> > > other event devices such as mouse/keyboard, where a logged user may n=
ot
> > > have permission to access all event devices in a multi-seat system ?
> >
> > input events modaliases contain a lot of info, including what sort
> > of events they report, e.g. :
> >
> > [hans@shalem uvc]$ cat /sys/class/input/input36/modalias
> > input:b0003v046Dp405Ee0111-e0,1,2,3,4,11,14,k71,72,73,74,75,77,78,79,7A=
,7B,7C,7D,7E,7F,80,81,82,83,84,85,86,87,88,89,8A,8B,8C,8E,8F,90,96,98,9B,9C=
,9E,9F,A1,A3,A4,A5,A6,A7,A8,A9,AB,AC,AD,AE,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA=
,BB,BC,BD,BE,BF,C0,C1,C2,CC,CE,CF,D0,D1,D2,D4,D8,D9,DB,DF,E0,E1,E4,E5,E6,E7=
,E8,E9,EA,EB,F0,F1,F4,100,110,111,112,113,114,115,116,117,118,119,11A,11B,1=
1C,11D,11E,11F,161,162,166,16A,16E,172,174,176,177,178,179,17A,17B,17C,17D,=
17F,180,182,183,185,188,189,18C,18D,18E,18F,190,191,192,193,195,197,198,199=
,19A,19C,1A0,1A1,1A2,1A3,1A4,1A5,1A6,1A7,1A8,1A9,1AA,1AB,1AC,1AD,1AE,1AF,1B=
0,1B1,1B7,1BA,240,241,242,243,244,245,246,247,248,249,24A,24B,24C,24D,250,2=
51,260,261,262,263,264,265,r0,1,6,8,B,C,a20,m4,l0,1,2,3,4,sfw
> >
> > So I believe that we can create a udev rule which matches on input
> > devices with SW_CAMERA_LENS_COVER functionality and set a uaccess
> > tag on those just like it is done for /dev/video# nodes.
> >
> > Or we can just use a specific input-device-name (sub) string
> > and match on that.
> >
> > This may require using a separate input_device with just
> > the SW_CAMERA_LENS_COVER functionality in some of the laptop
> > ACPI / WMI drivers, but that is an acceptable compromise IMHO.
>
> As long as it's doable I'm OK with it.
>
> > (we don't want to report privacy sensitive input events on
> > these nodes to avoid keylogging).
> >
> > > Would compositors be able to ignore the device to let libcamera handl=
e
> > > it ?
> >
> > input devices can be opened multiple times and we want the compositor
> > to also open it to show camera on/off OSD icons / messages.
>
> I'm not sure we want that though, as the event should be associated with
> a particular camera in messages. It would be better if it still went
> through libcamera and pipewire.

For OSD we do not necessarily need to know what camera the GPIO is
associated with.

We just want to give instant feedback about a button on their device.
Eg in ChromeOS we just say: "camera off" not "user facing camera off"


>
> > If opened multiple times all listeners will get the events.
> >
> > >>>>>> We could include the evdev in the MC graph. That will of course =
only be
> > >>>>>> possible if the kernel knows about that association in the first=
 place.
> > >>>>>> At least the 1st category of devices would benefit from this.
> > >>>>
> > >>>> Yes I was thinking about adding a link to the MC graph for this to=
o.
> > >>>>
> > >>>> Ricardo I notice that in this v3 series you still create a v4l2-su=
bdev
> > >>>> for the GPIO handling and then add an ancillary link for the GPIO =
subdev
> > >>>> to the mc-graph. But I'm not sure how that is helpful. Userspace w=
ould
> > >>>> still need to do parent matching, but then match the evdev parent =
to
> > >>>> the subdev after getting the subdev from the mc. In that case it m=
ight
> > >>>> as well look at the physical (USB-interface) parent of the MC/vide=
o
> > >>>> node and do parent matching on that avoiding the need to go throug=
h
> > >>>> the MC at all.
> > >>>>
> > >>>> I think using the MC could still be useful by adding a new type of
> > >>>> ancillary link to the MC API which provides a file-path as info to
> > >>>> userspace rather then a mc-link and then just directly provide
> > >>>> the /dev/input/event# path through this new API?
> > >
> > > I don't think we need that. MC can model any type of entity and repor=
t
> > > the device major:minor. That plus ancillary links should give us most=
 of
> > > what we need, the only required addition should be a new MC entity
> > > function.
> >
> > Ah interesting yes that should work nicely.
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda

