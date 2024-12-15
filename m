Return-Path: <linux-kernel+bounces-446487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17579F24EC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456E3188540B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178181B219D;
	Sun, 15 Dec 2024 17:16:16 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBF4C80;
	Sun, 15 Dec 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734282975; cv=none; b=NRnodqAEtcYuKVAYFb13J+zhsjcWIMcfZqWGCc8uQY6wpjgnkzVbZCW+6XhDL9X6LgkFURAYj6foBjBaYIdu68L5IfXAx6axdUh0tgS+vCMwJ8r1gs+TQdyjhX0nRhR39nyXga9pU9olmiR8/+iQJ/0qTqcuP97FUvMQHKXciSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734282975; c=relaxed/simple;
	bh=HUS4FfKPtgSayvK3qJxb00Wy9jUHLfzBBVWGTAF6u9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym3pUBlOsyep/+8E3iJZzqico6UY2GiREEMMhGv88F5BX352Mqtf/yN1CVVIRQ2f5Z6DRWGc74xoxRLmekokQ/UGykiiW77MhQUwNwiY2/8whfLeC/PsWAWjb6F8JG3vl39+9SpASKedwJ6ZcwNcKGiWd31J0w+e4ZSwm8FO87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so11632785ab.3;
        Sun, 15 Dec 2024 09:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734282972; x=1734887772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubda/FnD8RbTCheupJrUskoUPUvXVpb3l4PmondHb9o=;
        b=PuWL5bDl78uO/rmyWShCcRopHG7Fol16XO5lkpiiXIzL1uF1yRCZCRobWNOlpxnKv1
         QvIeTDHbyw2m9S/pZk+vKxhLhYzCp6jHYCYkSa0BpZZxvvr2BW5Pu8fc2SyRH8NoU7FR
         LBhES72OP+aLhjNY2MqUmI8gbGlaX/McEqmmPTKmr4NN+gaIordZXE7+40A4wqZciLh/
         HCOfXhlj933P8F4iZBUFcx/YClrF5TjDOp1iqwxjacyLlFAqiWWDNEQuX1Gq0+OiTlVb
         eiDN9NMI14QFCzgQ6IzWBUprjhvZMkie3XDhoo5xW53uvBAdsCoy7KL3MF1fi0d9b8Ye
         w9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWIjPzIJjVat4CyEPGe7HP8NAx9UMrGsYVNX6LTta5LyAgea8e159nGH/OaNW1gBLpzidlI50oKQg0=@vger.kernel.org, AJvYcCWgP3ngrWERTtwRVYp8Y/1ELWuM9OXYmkt65Ezt89M/ZcyfPjUqaH/L+0eSnFKdvLrqAmGfhoCF1UsztI/7@vger.kernel.org, AJvYcCWqMCwvc6NfmBAEQNuAeOT2ON6pmOjYV/7J7SyfLeeqXg4NXCupkXO/SFi6xaR+nJCvReYt5EtmaQrMmrhfg7iPdU0oxg==@vger.kernel.org, AJvYcCXUZ2WPCCxSR4kQCE/I0UsQ0hDel+tP1EB6m/KL53dfQgw9N2cCO88SE1542RmaPZh1UB2yFnU0z1C07MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGC7tTnuYyFNUXhZIl9hEy1zTgOcp2jrrKQSd+XQwK8+1zXcY
	XW45Etj0sXMvdG7oJaOOr/S3FYvgkBNfAy6SFliKcDtwGVknZhaMyiThRGC6KU4=
X-Gm-Gg: ASbGncsG/HxWuwazqBWdfkQwhFipDDE/pJG74YwnuAyXZQQ2J3bxI8wlslfcY+/PKfF
	BRYU8mSK0kgVH+wM2tZ+B8go55tsjxkE0XAu2bFdAToOv06I6nCdhUHaJArNsfDs5s08S4IBsw1
	GQUjSPTYZP6L/okDVFjATLdWzqTMiMQkCjr+5qcMkvIcUuvonkUL51mpcMHDHJkwgYnq77TRoX8
	eigrxxQ244si+iHoeiBOL3v1dNU4Nqi2PMhto9UdRtuWXz3jux7fMB2rDZ2rB1Y0ut9n13qHQal
	FmuVAB/smTReOoeT2Zy1gCNW5A==
X-Google-Smtp-Source: AGHT+IH1VAgh4t9BGudJJoVO7K8hbUFBqB7OHh+7w2NKhVfQXMgliRGtJH/AURyCPa2cwb+MiGxxCA==
X-Received: by 2002:a05:6e02:12e8:b0:3a7:e592:55ee with SMTP id e9e14a558f8ab-3aff8b9d0admr115742625ab.20.1734282972438;
        Sun, 15 Dec 2024 09:16:12 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475af0d1sm11043365ab.3.2024.12.15.09.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:16:12 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a8f1c97ef1so9878295ab.2;
        Sun, 15 Dec 2024 09:16:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyLpbqGHI/m7wDlrnCsK1GuH0aFMUEi2eSfREyYZ1ixYT9KouatVU/9rIfAYvz6i/HO3sZs9Bn3WInKo8=@vger.kernel.org, AJvYcCVVYXmsxNE43OniVUC6QpOU24FcjTVjxzv6DCRy0wtpcMmdNF2wmBP8T8sFO4AYxpSUrmPD0fV8vnE=@vger.kernel.org, AJvYcCVgETfbdhQKMCZQ61RBqxbKW4ljMdfdqBx7tXjBWncWmHd/tPnKiqPmxkhFvBUMHV6W+IXx3iQ9HdDn+8aXekkpLixemw==@vger.kernel.org, AJvYcCWPFf+7uBMptrgbW36FFm64kEggpl/o3KsW5uf1AnkTIV1v0BUXUGpjPa5engVzUSDNTkG/T4NcP3LEjBGL@vger.kernel.org
X-Received: by 2002:a05:6e02:3042:b0:3a7:9347:5465 with SMTP id
 e9e14a558f8ab-3aff470f92cmr112706635ab.3.1734282971656; Sun, 15 Dec 2024
 09:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209163720.17597-1-josh@joshuagrisham.com> <9b1630fe-70af-634b-b8ba-7b065d9ce5ae@linux.intel.com>
In-Reply-To: <9b1630fe-70af-634b-b8ba-7b065d9ce5ae@linux.intel.com>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sun, 15 Dec 2024 18:16:00 +0100
X-Gmail-Original-Message-ID: <CAMF+KeYHWrfEGF5mUashzE9cmC+fU-X825bRRNJc3FS2me6eMQ@mail.gmail.com>
Message-ID: <CAMF+KeYHWrfEGF5mUashzE9cmC+fU-X825bRRNJc3FS2me6eMQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Joshua Grisham <josh@joshuagrisham.com>, Hans de Goede <hdegoede@redhat.com>, 
	platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net, 
	linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for looking into this in detail, Ilpo! I tried to address
everything you mentioned in my v2 of this patch, but will comment on
each of your comments below so it will hopefully be more clear with
exactly what I changed, where, and the reasoning behind it.

Den m=C3=A5n 9 dec. 2024 kl 19:49 skrev Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com>:
>
> > +#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)
> > +
> > +#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len) \
> > +     do {                                                            \
> > +             pr_debug_prefixed("%s\n", header_str);                  \
> > +             print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",  \
>
> You can use pr_fmt() wrapping here so you don't need to hardcode the
> prefix.
>

After comments from Armin (which I agree with!) I have actually just
completely removed all of the pr_* functions including these macros in
the v2 of this patch, and for detailed buffer traces I have
implemented a new tracepoint system + event for samsung_galaxybook. I
assume now as the format of dev_dbg / warn / error looks correct
without defining pr_fmt(), it is also not needed ? (I have removed it
for now in v2 but can add it back if it is needed).

> > +static char *get_acpi_device_description(struct acpi_device *acpi_dev)
> > +{
> > +     struct acpi_buffer str_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > +     union acpi_object *str_obj;
> > +     struct acpi_buffer name_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
>
> Reverse xmas tree order is preferred (unless there's a good reason to
> break it due to dependency).
>

Thanks for catching this; hopefully I have now fixed everything to use
reverse xmas tree ordering in the entire module. Please feel free to
let me know if I missed anything!

> > +     if (ACPI_SUCCESS(status) && str_buf.length > 0) {
> > +             str_obj =3D str_buf.pointer;
> > +             char *buf =3D kzalloc(sizeof(*buf) * str_obj->buffer.leng=
th, GFP_KERNEL);
>
> Don't mix variable declarations with, always put them first in the
> block/function and leave blank line in between. There's only one exceptio=
n
> and that is using cleanup.h when ordering of the declarations matter but
> that's the only exception (it's the reason why it's allowed at all).
>

This was originally done as a "workaround" to get a device description
from the "_STR" method in the same way that ACPI's device_sysfs.c did
it, ... but yes I agree it was not at all optimal and because I have
actually removed everything to do with ACPI fan devices in v2 of this
patch, all of this is gone now, too :)

> > +     if (ACPI_FAILURE(status)) {
> > +             pr_err("failed %s with ACPI method %s; got %s\n", purpose=
_str, method,
> > +                    acpi_format_exception(status));
>
> Use dev_err()
>
(+ all other references to using dev_* in your comments...)

Thank you for pointing this out; I have hopefully switched everything
to use dev_* functions for printing (and removed most of them,
actually) but please feel free to mention if I seem to have missed or
should adjust anything.

> > +
> > +     memcpy(ret, out_obj->buffer.pointer, len);
>
> In kernel, ret is typically int so I suggest you pick some other name for
> the variable (Yes, I went back to find out what the type is in this case)=
.
>

Good catch here, as well! I have renamed these variables a bit; now
this is called "out_buf" (and the incoming buffer is called "in_buf")
so hopefully it is super clear but please feel free to make any other
suggestion.

> > +static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galax=
ybook, const bool value)
> > +{
> > +     struct sawb buf =3D { 0 };
> > +     int err;
> > +
> > +     buf.safn =3D SAFN;
> > +     buf.sasb =3D SASB_POWER_MANAGEMENT;
> > +     buf.gunm =3D GUNM_POWER_MANAGEMENT;
> > +     buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> > +     buf.guds[1] =3D GUDS_START_ON_LID_OPEN_SET;
> > +     buf.guds[2] =3D value;
>
> This relies on bool -> u8 implicit conversion. While it probably works as
> is, I'd prefer to make the conversion explicit with e.g. ?: operator (and
> let the compiler optimize it if it wants to).
>

Now in v2 I changed this to `buf.guds[2] =3D value ? 1 : 0` -- please
let me know if that is what you had in mind otherwise I can adjust
this to anything!

> > +     pr_debug_prefixed("turned start_on_lid_open %s\n", value ? "on (1=
)" : "off (0)");
>
> Use a helper from linux/string_choices.h.
>
> I'd change it to:
>         dev_dbg(..., "start_on_lid_open %s\n", str_enabled_disabled(value=
));
>

Really great recommendation, but even here as I removed all of this
stuff as well then there is no longer a need for string_choices.h I
think!

> > +     pr_debug_prefixed("start_on_lid_open is currently %s\n",
> > +                       (buf.guds[1] ? "on (1)" : "off (0)"));
>
> I suspect a debug print like this is not going to be very useful. You get
> the result right out of the sysfs anyway so why bother printing at all an=
d
> it's anyway not the raw value but synthetized on/off string.
>

Yes, agreed, and I removed all of these (but please feel free to say
if I seemed to have missed something!).

> > +static DEVICE_ATTR_RW(start_on_lid_open);
> > +
> > +/* USB Charge (USB ports can charge other devices even when device is =
powered off) */
> > +
> > +static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, =
const bool value)
>
> Don't leave empty line in between.
>

Actually the comments like these were intended to be a sort of
separator for all of the related functions etc related to each
individual attribute (e.g. "usb_charge" as an attribute has 4
functions and a device_attribute defined, then the next set of
functions+attribute are for "allow_recording" etc). I left this empty
line so that the comment would not be associated only with the single
usb_charge_acpi_set function but instead could be considered a sort of
label for the entire grouping.

How should comments like this be formatted or does it just not even
make sense to have them at all and they should be removed ?

> > +static int charge_control_end_threshold_acpi_set(struct samsung_galaxy=
book *galaxybook,
> > +                                              const u8 value)
>
> While certainly not forbidden, using const on plain integer types is not
> extremely useful. In fact, if it wouldn't be const, you could do the 100
> -> 0 mapping for it separately and not do it twice below.
>
> [...]
>
> Put comment on line before it so it's easier to read.
>
> "off" -> "no threshold" ?
>
> [...]

Good idea, now I have handled this in the v2 of the patch as follows:

if (value > 100)
        return -EINVAL;
/* if setting to 100, should be set to 0 (no threshold) */
if (value =3D=3D 100)
        value =3D 0;

Does this make sense now or do you see anything that should be adjusted her=
e?

>
> Do you want to differentiate 0 from 0? Should this function actually
> return -EINVAL if somebody attempts to set 0 threshold?
>

And regarding this, the device requires that you send 0 to represent
that the feature is "turned off", so to speak (no threshold is enabled
and the battery will charge all the way to 100%). So yes, in my mind,
we want to send 0 to the device if you are attempting to set either 0
or 100. Also I seem to recall that I tried to dig into how this is
handled in upower and the coming features in GNOME, and have a vague
memory that I saw somewhere in there that they were also converting
100 to a 0, but now I am having a bit of trouble finding this again.
Do you know if it would be better to have this driver provide an
interface where "100" means "no threshold" and that it should be
translated within the driver (that samsung_galaxybook sends a 0 to the
ACPI in case the user has requested "100" ?) or is it better if "0"
means "no threshold/charge to 100%" (or both?)?

I can also do some testing with the device to see if it accepts the
value 100 anyway, and how it behaves, though I would be a little
concerned with this longer term as it is not how the driver and
settings applications work in Windows (they are hard-coded with a
toggle and it always sets either 0 (off) or 80 (on)), and I could see
where even if it works today, sending the value of 100 to mean "off"
could be altered by potential BIOS updates?

> > +out_free:
> > +     ACPI_FREE(response.pointer);
> > +     return ret;
>
> You're mixing err and ret within a file as the error/return code variable=
.
> It would be nice to be consistent within a file.
>

Here I have tried to look over and make sure to use "err" for
everything but please say if it seems I missed something!

> > +     response_obj =3D response.pointer;
> > +     if (!response_obj || response_obj->type !=3D ACPI_TYPE_INTEGER ||
> > +         response_obj->integer.value > INT_MAX ||
>
> I don't know what's the logic behind doing bound check here but not in th=
e
> previous function.
>

Removed all fan stuff from the driver in v2 so all of this is gone now anyw=
ay :)

> But why you need this whole dev_ext_attribute thing in the first place?
>

Though the fan stuff is removed, I have done this now with the battery
charge control attribute. The reason in this new case is to be able to
give a pointer to the "samsung_galaxybook" struct so that the handle
can be grabbed from this private data and avoid using a global pointer
variable.

> > +static enum platform_profile_option
> > +profile_performance_mode(struct samsung_galaxybook *galaxybook, const =
u8 performance_mode)
> > +{
> > +     for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> > +             if (galaxybook->profile_performance_modes[i] =3D=3D perfo=
rmance_mode)
> > +                     return i;
> > +     return -1;
>
> Returning value that is not part of enum looks a bit hacky.
>

Good catch, this was a total oversight. Now in v2 of this patch I have
changed this to a more typical int return code function (returning
-ENODATA) and the value is assigned to a pointer that the caller
passes in. Please let me know if anything looks fishy with this or it
seems ok now!

> > +/* copied from platform_profile.c; better if this could be fetched fro=
m a public function, maybe? */
>
> You are allowed to propose patches in the patch series for things you
> need. :-)
>
> > +static const char *const profile_names[] =3D {
> > +     [PLATFORM_PROFILE_LOW_POWER] =3D "low-power",
> > +     [PLATFORM_PROFILE_COOL] =3D "cool",
> > +     [PLATFORM_PROFILE_QUIET] =3D "quiet",
> > +     [PLATFORM_PROFILE_BALANCED] =3D "balanced",
> > +     [PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance=
",
> > +     [PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> > +};
> > +static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
>
> Is this assert compatible with the custom platform profile series that is
> practically ready to be merged?
>

All of this was just for printing the strings out in the debug
information, and really not actually necessary. So I have removed it
all, now.

> > +     galaxybook->profile_performance_modes =3D
> > +             kzalloc(sizeof(u8) * PLATFORM_PROFILE_LAST, GFP_KERNEL);
>
> kcalloc() ?
>

Great catch, this has been changed.

> > +     /* if no performance modes were mapped (err is still -ENODEV) the=
n stop and fail here */
> > +     if (err)
> > +             return err;
>
> It would be much more obvious to count number of mapped modes with a
> variable and not play with err variable like this. You needed lots of
> comment to explain which all could be dropped and this could just return
> -ENODEV directly.
>

Agreed and now I have added a new int "mapped_profiles" and tweaked
this logic a bit so hopefully it is slightly more self-explanatory.
Please say if it seems like I am still missing the mark on this one!

> I'll stop here as I'm out of time.
>
> --
>  i.
>

Thank you again for all of your help and feedback! Please feel free to
look at the rest of the changes I added with the v2 of the patch and
send any feedback that you would like.

Best regards,
Joshua

> [...]

