Return-Path: <linux-kernel+bounces-275506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B051994869C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB801C20D1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCEC4A15;
	Tue,  6 Aug 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csmHZW59"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284B10F1;
	Tue,  6 Aug 2024 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903729; cv=none; b=V26125xS/C9d1OUu94Dcmgxqc3JQVxeMNLJJsoURxbzQpWN05whOgUSGfIUV2204dVjqp31ckMiiGpFqBIXTlIqw/c52ZMO9FUjqk9H++pWY+v4nannZeNKf94POrs3z5wz9cUuqljhryyxbMqKSSfEy/fL9o6M92GGGUWFflLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903729; c=relaxed/simple;
	bh=7LI+SyKIAMeHUrgTNeBg7NAwZHvCgGvaCTW79mhlUNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjG9VmunPdLGV4J/1bTmJPkDwE6pT/g3+/xOhv3qshcnAx75DmN9H8gsbCVsn/EGjzxYQQOXnuSp3ZLq+fD3czgQGO8ixL6XeZQw9nyQktkHnPVOqL7Bpum8a1eMYiHdLYGZPoRD6wZYpfHMxO2M4HY7iTO0xKkO60l3qmA4PWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csmHZW59; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368380828d6so7551597f8f.1;
        Mon, 05 Aug 2024 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722903726; x=1723508526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdgtCx0yObvg3G9BhDSSvuFzLZYEdkp911WRI3897EA=;
        b=csmHZW59U+/lm5uXpKM6+ahYgN87ZFS56rRCh/X81TO1bhMkQEQN/qijey2L8m3a3/
         /mRbc4p0pVfO0ESveaydpTg9E3+81Bx/ODr7nIjB4zq8FNEYS2Va9sUDLD6jJrQTYEzN
         g7BIOTT9d3M5iOiPYOTg6qmuhfb4RiEK7eh/s27WDmfKoT5nJ7YcIBMwX5KjnNM9xacC
         U9VhpQqVguyIBJRfypa5i3JMJpAeGAjyLsJL1y5ed9Lr8zndFVPbIa4FCOcnDy2fx4dL
         buXpzUJ4gT2eVLr6SCqlJ+uWOBlBdL54Y8ZXWzc5SWCQvi7E3PWaKNvHVOX25jrp9zAT
         Y/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903726; x=1723508526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdgtCx0yObvg3G9BhDSSvuFzLZYEdkp911WRI3897EA=;
        b=U6HmQrV2s+1umyzD+yfZzRCvOQ9pYyZm7AXT2Ut7+r49TPqdT+mmwecA9tNp0X4OZw
         G7q5aKrdHesgRJMVegQuU8ouTjC4LOgPg7ZcDXkWL9it1HONdEG65xjgFHtYRjRrA/ET
         lKG8bR674S/rJLHyvbFdihdUpxKDT53qdWZflSm4ZkLDxlwnKFVrhGfyxqSfeWNffrSk
         zzNvuimm0SUif2h902AvULySuYQLf1jWBO5JQ1rVaCCMzxyc9bdxbNcdEzgsw/jMORev
         nNminn/dhZOhhFJx/o0fB2m51XBSuZOC2//FAz6EO1/Fp46EfcBq5lwOdzEU/R1xCSrb
         Q2CA==
X-Forwarded-Encrypted: i=1; AJvYcCUI4+lwq6PRr7KdEazqwZk6s5u0F1XIb0Z5dprGGvCfEh5XibHLsgnSGqwxpJWmLtKiqbmwsMdI47kTsu+SXf65ySwNsWNMllqYUOzTNfOhvCMmgZ00d7srVmjn2JiW9gTmXMbQ1rU5
X-Gm-Message-State: AOJu0YwCBgyrpNUK2AkJhFZEHZI1EajM9Cv81WgGoXUvcyfNXnEKiLmP
	UlSCgQ0bJ5d07LgYQq/hbTWJ4cGciWgdunsjEATXeMVZ1STyuI+fe6vXH3GwAQavL2zXWyMQjuM
	anEgwZ9dSiPhkORC7lhhk0k65Coo=
X-Google-Smtp-Source: AGHT+IH06UHMm256p32TdT2WPSu1K5DQoM648J62YpulrnPPVBWU9tC4UdOKcOkSWGNi2ao/3ZwZxRaDg/dSfGIf5wQ=
X-Received: by 2002:a05:6000:2a6:b0:368:31c7:19d9 with SMTP id
 ffacd0b85a97d-36bbc0c54eamr12263479f8f.12.1722903725876; Mon, 05 Aug 2024
 17:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805000639.619232-2-crwulff@gmail.com> <2024080516-flatness-humorous-03ca@gregkh>
In-Reply-To: <2024080516-flatness-humorous-03ca@gregkh>
From: Chris Wulff <crwulff@gmail.com>
Date: Mon, 5 Aug 2024 20:21:54 -0400
Message-ID: <CAB0kiBKGb=vuYbs1C3w2wzmbSZuVp3t9iqjkfL+dYkKQKgA7ow@mail.gmail.com>
Subject: Re: [PATCH v4] usb: gadget: f_fs: add capability for dfu run-time descriptor
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Cercueil <paul@crapouillou.net>, Christian Brauner <brauner@kernel.org>, 
	Eric Farman <farman@linux.ibm.com>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Dmitry Antipov <dmantipov@yandex.ru>, Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Sands <david.sands@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 3:01=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Aug 04, 2024 at 08:06:40PM -0400, crwulff@gmail.com wrote:
> > From: David Sands <david.sands@biamp.com>
> >
> > From: David Sands <david.sands@biamp.com>
>
> Twice?

Oops. Not sure what happened, but I'll try to make it not happen next time.

>
> > Add the ability for FunctionFS driver to be able to create DFU Run-Time
> > descriptors.
>
> As others said, please spell out "DFU" and I do not think that
> "Run-Time" needs Capital letters, or a '-', right?
>
> Also include here a lot more description of how this is to be used.

Ok, I will expand on this (and the associated documentation.)

>
> >
> > Signed-off-by: David Sands <david.sands@biamp.com>
> > Co-developed-by: Chris Wulff <crwulff@gmail.com>
> > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > ---
> > v4: Clean up unneeded change, switch to BIT macros, more documentation
> > v3: Documentation, additional constants and constant order fixed
> > https://lore.kernel.org/all/CO1PR17MB54197F118CBC8783D289B97DE1102@CO1P=
R17MB5419.namprd17.prod.outlook.com/
> > v2: https://lore.kernel.org/linux-usb/CO1PR17MB54198D086B61F7392FA9075F=
E10E2@CO1PR17MB5419.namprd17.prod.outlook.com/
> > v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419AC3907C74E28D80C5021=
E1082@CO1PR17MB5419.namprd17.prod.outlook.com/
> > ---
> >  Documentation/usb/functionfs-desc.rst | 22 ++++++++++++++++++++++
> >  Documentation/usb/functionfs.rst      |  2 ++
> >  Documentation/usb/index.rst           |  1 +
> >  drivers/usb/gadget/function/f_fs.c    | 12 ++++++++++--
> >  include/uapi/linux/usb/ch9.h          |  8 ++++++--
> >  include/uapi/linux/usb/functionfs.h   | 25 +++++++++++++++++++++++++
> >  6 files changed, 66 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/usb/functionfs-desc.rst
> >
> > diff --git a/Documentation/usb/functionfs-desc.rst b/Documentation/usb/=
functionfs-desc.rst
> > new file mode 100644
> > index 000000000000..73d2b8a3f02c
> > --- /dev/null
> > +++ b/Documentation/usb/functionfs-desc.rst
> > @@ -0,0 +1,22 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +FunctionFS Descriptors
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Interface Descriptors
> > +---------------------
> > +
> > +Standard USB interface descriptors may be added. The class/subclass of=
 the
> > +most recent interface descriptor determines what type of class-specifi=
c
> > +descriptors are accepted.
> > +
> > +Class-Specific Descriptors
> > +--------------------------
> > +
>
> Why an empty section?

It was just a heading-2 for the class-specific descriptor section (with eac=
h
of the class-specific descriptors being heading-3). I can add a bit of
text though.

>
> > +DFU Functional Descriptor
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +When the interface class is USB_CLASS_APP_SPEC and  the interface subc=
lass
>
> Extra space?
>
>
> > +is USB_SUBCLASS_DFU, a DFU functional descriptor can be provided.
>
> Provided how?

I will expand on this a bit more. Most of the functionfs descriptor
behavior wasn't documented. The functionfs page talks about how
these are written to the ep0 file, but doesn't mention anything about
what descriptors can be written other than mentioning that ep# files
are created when endpoint descriptors are written.

>
> > +
> > +.. kernel-doc:: include/uapi/linux/usb/functionfs.h
> > +   :doc: usb_dfu_functional_descriptor
> > diff --git a/Documentation/usb/functionfs.rst b/Documentation/usb/funct=
ionfs.rst
> > index d05a775bc45b..4f96e4b93d7b 100644
> > --- a/Documentation/usb/functionfs.rst
> > +++ b/Documentation/usb/functionfs.rst
> > @@ -70,6 +70,8 @@ have been written to their ep0's.
> >  Conversely, the gadget is unregistered after the first USB function
> >  closes its endpoints.
> >
> > +For more information about FunctionFS descriptors see :doc:`functionfs=
-desc`
> > +
> >  DMABUF interface
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
> > index 27955dad95e1..826492c813ac 100644
> > --- a/Documentation/usb/index.rst
> > +++ b/Documentation/usb/index.rst
> > @@ -11,6 +11,7 @@ USB support
> >      dwc3
> >      ehci
> >      functionfs
> > +    functionfs-desc
>
> That's an odd name for a DFU-specific file, right?
>
> Where are the Documentation/ABI/ entries?

functionfs-desc was intended to be for more than DFU. I was thinking
it would be nice to also talk about other descriptors that can be
written to functionfs since I couldn't find any documentation on
that, but I didn't want to add documentation for a bunch of existing
stuff to this same patch. It seems like that would be better submitted
separately (which I can work on if you think it's useful.) I only included
the descriptors that were relevant to DFU.

I will see what I can add for the ABI documentation as well.

>
> >      gadget_configfs
> >      gadget_hid
> >      gadget_multi
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/fu=
nction/f_fs.c
> > index d8b096859337..ba5c6e4827ba 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -2478,7 +2478,7 @@ typedef int (*ffs_os_desc_callback)(enum ffs_os_d=
esc_type entity,
> >
> >  static int __must_check ffs_do_single_desc(char *data, unsigned len,
> >                                          ffs_entity_callback entity,
> > -                                        void *priv, int *current_class=
)
> > +                                        void *priv, int *current_class=
, int *current_subclass)
> >  {
> >       struct usb_descriptor_header *_ds =3D (void *)data;
> >       u8 length;
> > @@ -2535,6 +2535,7 @@ static int __must_check ffs_do_single_desc(char *=
data, unsigned len,
> >               if (ds->iInterface)
> >                       __entity(STRING, ds->iInterface);
> >               *current_class =3D ds->bInterfaceClass;
> > +             *current_subclass =3D ds->bInterfaceSubClass;
> >       }
> >               break;
> >
> > @@ -2559,6 +2560,12 @@ static int __must_check ffs_do_single_desc(char =
*data, unsigned len,
> >                       if (length !=3D sizeof(struct ccid_descriptor))
> >                               goto inv_length;
> >                       break;
> > +             } else if (*current_class =3D=3D USB_CLASS_APP_SPEC &&
> > +                        *current_subclass =3D=3D USB_SUBCLASS_DFU) {
> > +                     pr_vdebug("dfu functional descriptor\n");
> > +                     if (length !=3D sizeof(struct usb_dfu_functional_=
descriptor))
> > +                             goto inv_length;
> > +                     break;
> >               } else {
> >                       pr_vdebug("unknown descriptor: %d for class %d\n"=
,
> >                             _ds->bDescriptorType, *current_class);
> > @@ -2621,6 +2628,7 @@ static int __must_check ffs_do_descs(unsigned cou=
nt, char *data, unsigned len,
> >       const unsigned _len =3D len;
> >       unsigned long num =3D 0;
> >       int current_class =3D -1;
> > +     int current_subclass =3D -1;
> >
> >       for (;;) {
> >               int ret;
> > @@ -2640,7 +2648,7 @@ static int __must_check ffs_do_descs(unsigned cou=
nt, char *data, unsigned len,
> >                       return _len - len;
> >
> >               ret =3D ffs_do_single_desc(data, len, entity, priv,
> > -                     &current_class);
> > +                     &current_class, &current_subclass);
> >               if (ret < 0) {
> >                       pr_debug("%s returns %d\n", __func__, ret);
> >                       return ret;
> > diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.=
h
> > index 44d73ba8788d..91f0f7e214a5 100644
> > --- a/include/uapi/linux/usb/ch9.h
> > +++ b/include/uapi/linux/usb/ch9.h
> > @@ -254,6 +254,9 @@ struct usb_ctrlrequest {
> >  #define USB_DT_DEVICE_CAPABILITY     0x10
> >  #define USB_DT_WIRELESS_ENDPOINT_COMP        0x11
> >  #define USB_DT_WIRE_ADAPTER          0x21
> > +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> > +#define USB_DT_DFU_FUNCTIONAL                0x21
> > +/* these are from the Wireless USB spec */
> >  #define USB_DT_RPIPE                 0x22
> >  #define USB_DT_CS_RADIO_CONTROL              0x23
> >  /* From the T10 UAS specification */
> > @@ -329,9 +332,10 @@ struct usb_device_descriptor {
> >  #define USB_CLASS_USB_TYPE_C_BRIDGE  0x12
> >  #define USB_CLASS_MISC                       0xef
> >  #define USB_CLASS_APP_SPEC           0xfe
> > -#define USB_CLASS_VENDOR_SPEC                0xff
> > +#define USB_SUBCLASS_DFU                     0x01
> >
> > -#define USB_SUBCLASS_VENDOR_SPEC     0xff
> > +#define USB_CLASS_VENDOR_SPEC                0xff
> > +#define USB_SUBCLASS_VENDOR_SPEC             0xff
> >
> >  /*--------------------------------------------------------------------=
-----*/
> >
> > diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/u=
sb/functionfs.h
> > index 9f88de9c3d66..40f87cbabf7a 100644
> > --- a/include/uapi/linux/usb/functionfs.h
> > +++ b/include/uapi/linux/usb/functionfs.h
> > @@ -37,6 +37,31 @@ struct usb_endpoint_descriptor_no_audio {
> >       __u8  bInterval;
> >  } __attribute__((packed));
> >
> > +/**
> > + * struct usb_dfu_functional_descriptor - DFU Functional descriptor
> > + * @bLength:         Size of the descriptor (bytes)
> > + * @bDescriptorType: USB_DT_DFU_FUNCTIONAL
> > + * @bmAttributes:    DFU attributes
> > + * @wDetachTimeOut:  Maximum time to wait after DFU_DETACH (ms, le16)
> > + * @wTransferSize:   Maximum number of bytes per control-write (le16)
> > + * @bcdDFUVersion:   DFU Spec version (BCD, le16)
> > + */
> > +struct usb_dfu_functional_descriptor {
> > +     __u8  bLength;
> > +     __u8  bDescriptorType;
> > +     __u8  bmAttributes;
> > +     __le16 wDetachTimeOut;
> > +     __le16 wTransferSize;
> > +     __le16 bcdDFUVersion;
> > +} __attribute__ ((packed));
> > +
> > +/* from DFU functional descriptor bmAttributes */
> > +#define DFU_FUNC_ATT_CAN_DOWNLOAD    BIT(0)
> > +#define DFU_FUNC_ATT_CAN_UPLOAD              BIT(1)
> > +#define DFU_FUNC_ATT_MANIFEST_TOLERANT       BIT(2)
> > +#define DFU_FUNC_ATT_WILL_DETACH     BIT(3)
>
> Wrong macro for bit fields for uapi .h files :(

Oh. I'm surprised there is more than one macro for bits. I will
change this to _BITUL().

>
> thanks,
>
> greg k-h

