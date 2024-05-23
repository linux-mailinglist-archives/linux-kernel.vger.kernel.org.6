Return-Path: <linux-kernel+bounces-187698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479258CD6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2214280FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4AF9CC;
	Thu, 23 May 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnzP73v+"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3273B662;
	Thu, 23 May 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477202; cv=none; b=tfsr7N/qSqzX01ZJ28ThVuDlRy1A09zPgG4MNPa0ZewWm+Bzva+TXVvlkOMtCU8bc7T4tnX4/yfIcrjhiHETRJOqfkqbaCM32mQRV6IjVUjrem8DpoYYaaQLRcdQn/eazN6PS/cfsr6RGmjtHBTjcsL7d9DjTRp+iJGdMq90IoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477202; c=relaxed/simple;
	bh=hKvJJQG9yuU0Ms9Dcev2jp80dQS3vFCGF48akVM8cHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soCdMZLYZd0GFIKbltA8+nIs9Vb5P9epgyQi7Tp7yieUEZKPlJq3NlLF4QuhEONbehQjPWrWit1YfzK1KyqNCzxbFXASbXn6r1JuLdSKDPsnLXOLhul1rnVeLTOE1qofXL8H9EO8UyQlPefwRqUS+EDKOLfeF7pyKCETMYy1qcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnzP73v+; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-248f7fdc323so3086160fac.1;
        Thu, 23 May 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716477200; x=1717082000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IurSXSX4036itBqp+pWqeC3ztpRRvIk+WgUaysK+eho=;
        b=cnzP73v+i7qXM8MUHz7fENgjiDwbDvcLghA28iAuBxe3uu+xiEvjSEJOfiyl9vfGAH
         vFoBjWGXDZ7B0lKGHrzhexpRKaUgmTIHeO9i+Mij8s6F4xgtzZauAu8kr6f3l5pa9IQr
         KrqxsGXf3w2sIGXSz65wO7fyMW4D1PRy5gSiL7YYqqfjwA/7Xr1Ihp2qRLGa3XQOfYoO
         6OcQsOskSVY90X3uV2Q2pJf51rYScAAxnyxk2F0otg2pQHNwxXO+z5vllWoKgFp3tQaH
         3OObkQBRmShwEjoM/79E3jypIoLo+ayVxlHiw9JBSFOfKTKxa+kXYffcMz0AJXBNCgmD
         Po0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477200; x=1717082000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IurSXSX4036itBqp+pWqeC3ztpRRvIk+WgUaysK+eho=;
        b=a+lQw9jafMOMe7uJRxu8D19vHSb6IONnE4MBgFJ0rBzWUpnpQKZk1OppgiDCMDasgd
         wMrpnviyMmRpCBRHTzWChjWm2ibQgrchukpeZ1IR1YJb+McDONDgtgiOSGQv2cauuM/Z
         ENtKl7FMQTqJsffyu4ZwVxhxgZygweC/mgxaHAr/5gPk9BkaY8fXXqxjej21+B/RVr9G
         +mTvSudozvfiWDGt6ZvdL6C2azUCDcEtaVLkZdEl2N3XcYdU+I7GpnrTMcTjkIFtIet5
         YWZo8lZEll4K1E27pBAHvPBaWZVyeR2Jwrkk3QVWoJENKSyxc6FQk+HBOKe5KZea4q5y
         9ljA==
X-Forwarded-Encrypted: i=1; AJvYcCVojtM5XrEzKfkEGdWNyT6BBjj1cKZ9h/zWTrQ+XWg0lbvJVPHAPV7NeDc8JzZyjJOzAZcBitNKs5ifSdhe5rJbJ8ZdXpqkFfcuGsBxElE+vzcJr5kublwUSprrcNVIIL1nMP8dWBU+
X-Gm-Message-State: AOJu0Yy1js+3GZtMxmNSe2UaROXDknJ6inNWQWxtKwynGfL840hu3302
	n/Z/itVZrx0AG2KFHAOD1ODcEVmYK9jeo3M9qLT+Rz+OaeFWjGck2HJ+OmIzsVVRj6RYqKmnezz
	ZJeVkI2XTGhqpLwqiO/dUr/P6TO4=
X-Google-Smtp-Source: AGHT+IEY9EBtHDS06AT6ihJseNZxNIwy4aUyENW4GmaibAJd2DyrPO1pRKDivFBswqHjecQBU1Cs8PqUmRR6Gkz1r1I=
X-Received: by 2002:a05:6870:c085:b0:229:f022:ef83 with SMTP id
 586e51a60fabf-24c68d240femr7159783fac.43.1716477199847; Thu, 23 May 2024
 08:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523092608.874986-1-shichaorai@gmail.com> <a0afa88b-f84c-4b45-a265-2e6bcbb84b35@rowland.harvard.edu>
 <bb581989-4ac5-4ffe-9f80-01b5f993146f@rowland.harvard.edu>
In-Reply-To: <bb581989-4ac5-4ffe-9f80-01b5f993146f@rowland.harvard.edu>
From: shichao lai <shichaorai@gmail.com>
Date: Thu, 23 May 2024 23:13:08 +0800
Message-ID: <CACjpba5iJ5dC=rB_Ckaqe4BKesrAN2VmsDCPZJ=frufNgA96Uw@mail.gmail.com>
Subject: Re: [PATCHv2] Check whether divisor is non-zero before division
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, linux-usb@vger.kernel.org, 
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org, 
	xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:15=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, May 23, 2024 at 09:58:21AM -0400, Alan Stern wrote:
> > On Thu, May 23, 2024 at 05:26:08PM +0800, Shichao Lai wrote:
> > > Since uzonesize may be zero, so judgements for non-zero are nessesary=
 in both place.
> > > Previous check is moved out of loop, and one more check is added in a=
lauda_write_lba.
> > >
> > > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > > Reported-by: yue sun <samsun1006219@gmail.com>
> > > Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> > > ---
> > >  drivers/usb/storage/alauda.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alaud=
a.c
> > > index 115f05a6201a..a6e60ef5cb0d 100644
> > > --- a/drivers/usb/storage/alauda.c
> > > +++ b/drivers/usb/storage/alauda.c
> > > @@ -818,6 +818,8 @@ static int alauda_write_lba(struct us_data *us, u=
16 lba,
> > >     unsigned int blocksize =3D MEDIA_INFO(us).blocksize;
> > >     unsigned int lba_offset =3D lba % uzonesize;
> > >     unsigned int new_pba_offset;
> > > +   if (!uzonesize)
> > > +           return USB_STOR_TRANSPORT_ERROR;
> > >     unsigned int zone =3D lba / uzonesize;
> > >
> > >     alauda_ensure_map_for_zone(us, zone);
> > > @@ -923,6 +925,8 @@ static int alauda_read_data(struct us_data *us, u=
nsigned long address,
> > >     unsigned int uzonesize =3D MEDIA_INFO(us).uzonesize;
> > >     struct scatterlist *sg;
> > >     int result;
> > > +   if (!uzonesize)
> > > +           return USB_STOR_TRANSPORT_ERROR;
> > >
> > >     /*
> > >      * Since we only read in one block at a time, we have to create
> >
> > This is definitely NOT the right way to fix the bug!
> >
> > uzonesize is set once, when the device is probed, in
> > alauda_init_media().  That is where the check belongs; if uzonesize is =
0
> > then the function should print a warning and return
> > USB_STOR_TRANSPORT_ERROR, because the device is unusable.
> >
> > It's probably a good idea to check pagesize, blocksize, and zonesize at
> > the same time, even though none of them are used for any divisions.
>
> Wait a minute.  I just went through the code more carefully.  It should
> not be possible for uzonesize to be 0, because it is defined by:
>
>         MEDIA_INFO(us).uzonesize =3D ((1 << media_info->zoneshift) / 128)=
 * 125;
>
> where media_info->zoneshift is always a value between 8 and 12.
>
> So the whole idea behind this patch is misguided.  The real problem is
> to find out why uzonesize ended up being 0.
>
> (And it's not necessary to check pagesize, blocksize, or zonesize,
> because none of them can ever be 0 either.)
>
> Alan Stern

Thanks for your comprehensive analysis.
I added some pr_info() to check the workflow, and I found that the
uzonesize was not initialized in fact!

The workflow is shown as below.
Before alauda_read_data(), there are in fact many alauda_check_media(),
but none of them enter the branch of alauda_init_media(), where
uzonesize is set to nonzero value.
The key branch condition is "status[0] & 0x08", which is always
unsatisfied in this repro.

```
alauda_transport
    alauda_check_media
        if (status[0] & 0x08) // not satisfied
            alauda_init_media()
                // initialize uzonesize
    alauda_read_data
```

I also print status[0] before the branch, which may be helpful for you
to analyze.

The part you should focus on is the information beginning with
"alauda_check_media".
e.g. "alauda_check_media: before alauda_get_media_status, status[0]:
0000000000000000" means in alauda_check_media(), before calling
alauda_get_media_status()
It seems that alauda_get_media_status() will transform the status[0]
to 0x0000000000000036, which doesn't satisfy the condition of
"status[0] & 0x08".
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@syzkaller:~# ./exp
[   28.645451][ T2386] usb 1-1: new high-speed USB device number 2
using dummy_hcd
[   28.885289][ T2386] usb 1-1: Using ep0 maxpacket: 16
[   29.005519][ T2386] usb 1-1: config 0 has an invalid interface
number: 192 but max is 0
[   29.007448][ T2386] usb 1-1: config 0 has no interface number 0
[   29.008759][ T2386] usb 1-1: config 0 interface 192 altsetting 0
endpoint 0x9 has invalid wMaxPacketSize 0
[   29.010799][ T2386] usb 1-1: config 0 interface 192 altsetting 0
bulk endpoint 0x9 has invalid maxpacket 0
[   29.012467][ T2386] usb 1-1: config 0 interface 192 altsetting 0
endpoint 0x8F has invalid maxpacket 59960, setting to 1024
[   29.012959][ T2386] usb 1-1: config 0 interface 192 altsetting 0
bulk endpoint 0x8F has invalid maxpacket 1024
[   29.013413][ T2386] usb 1-1: New USB device found, idVendor=3D07b4,
idProduct=3D010a, bcdDevice=3D 1.02
[   29.013809][ T2386] usb 1-1: New USB device strings: Mfr=3D0,
Product=3D0, SerialNumber=3D0
[   29.015193][ T2386] usb 1-1: config 0 descriptor??
[   29.035791][ T4124] raw-gadget.0 gadget.0: fail, usb_ep_enable returned =
-22
[   29.057576][ T2386] ums-alauda 1-1:0.192: USB Mass Storage device detect=
ed
[   29.062276][ T2386] scsi host2: usb-storage 1-1:0.192
[   30.098931][ T2386] scsi 2:0:0:0: Direct-Access     Olympus
MAUSB-10 (Alauda 0102 PQ: 0 ANSI: 0 CCS
[   30.102903][ T4131] alauda_check_media: before
alauda_get_media_status, status[0]: 0000000000000000
[   30.104297][ T2386] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   30.135805][ T4131] alauda_get_media_status: data=3D54, rc=3D0
[   30.137113][ T4131] alauda_check_media: after
alauda_get_media_status, status[0]: 0000000000000036
[   30.138991][ T4131] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   30.141727][ T4131] alauda_check_media: before
alauda_get_media_status, status[0]: 0000000000000036
[   30.355544][ T4131] alauda_get_media_status: data=3D54, rc=3D0
[   30.356815][ T4131] alauda_check_media: after
alauda_get_media_status, status[0]: 0000000000000036
[   30.358728][ T4131] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   30.361408][ T4131] alauda_check_media: before
alauda_get_media_status, status[0]: 00000000000000ff
[   30.575607][ T4131] alauda_get_media_status: data=3D54, rc=3D0
[   30.576910][ T4131] alauda_check_media: after
alauda_get_media_status, status[0]: 0000000000000036
[   30.578823][ T4131] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   30.580999][ T4131] alauda_check_media: before
alauda_get_media_status, status[0]: 00000000000000ff
[   30.795625][ T4131] alauda_get_media_status: data=3D54, rc=3D0
[   30.796899][ T4131] alauda_check_media: after
alauda_get_media_status, status[0]: 0000000000000036
[   30.798773][ T4131] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   30.801017][ T4131] alauda_check_media: before
alauda_get_media_status, status[0]: 00000000000000ff
[   31.015362][ T4131] alauda_get_media_status: data=3D54, rc=3D0
[   31.016679][ T4131] alauda_check_media: after
alauda_get_media_status, status[0]: 0000000000000036
[   31.018565][ T4131] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   31.020543][  T263] sd 2:0:0:0: [sdb] Very big device. Trying to
use READ CAPACITY(16).
[   31.023323][  T263] sd 2:0:0:0: [sdb] Using 0xffffffff as device size
[   31.035382][ T2386] scsi 2:0:0:1: Direct-Access     Olympus
MAUSB-10 (Alauda 0102 PQ: 0 ANSI: 0 CCS
[   31.035466][ T4131] alauda_transport: before alauda_check_media
[   31.038810][ T4131] alauda_check_media: before
alauda_get_media_status, status[0]: 0000000000000000
[   31.043663][ T2386] sd 2:0:0:1: Attached scsi generic sg3 type 0
[   31.235486][ T4131] alauda_get_media_status: data=3D54, rc=3D0
[   31.237015][ T4131] alauda_check_media: after
alauda_get_media_status, status[0]: 0000000000000036
[   31.239266][ T4131] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   31.241273][ T4131] alauda_transport: after alauda_check_media ->
alauda_read_data
[   31.243134][ T4131] alauda_read_data: 0
[   31.244148][ T4131] divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI

