Return-Path: <linux-kernel+bounces-447464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8749F32E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893E5167BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59C207A15;
	Mon, 16 Dec 2024 14:11:17 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F220DD5D;
	Mon, 16 Dec 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358276; cv=none; b=rPRpIS4HCj7KB5A1sPbJQDHKP6UtIKodIFePGVanThjpUlS/daoAlTAF69nN5UKk7dJgZirP0zmWzNDfMFz1yK7YwR7S9DzG2kSQpJZ9EIVAvMi6PE8IDO9iejp60MocSe/AGD5SjU5mNOmmS7ArCCgl+tULH+bAj2IGD09KOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358276; c=relaxed/simple;
	bh=S9ogmGZZ07owxBeo4tiOKFpP+3Aukgk/QSdeisOSqos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOgZejY9+yOR76eJ3cbj0PqXqWx+ud3VdzEtExSlnOLwRbq2A8E7QvRsT+Fp3qHfwuPi3/TPWJnMXMzRyFA7IX9ePIPz+rLiLQ8xvHeDxhn1oWmW2a9SgDBcjv41fmAZX/5oYN02G5CS5w24NJVD4e8jyKG41VeS58GWFh5N26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a8180205f3so17748375ab.0;
        Mon, 16 Dec 2024 06:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358273; x=1734963073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5B66bD5pVz1oqU5TXnKh2QRogpcU3RP3NVl1GBRw1U=;
        b=Wa3SP/gZuWAeoOiI633rRcFKF4soQAHIlC/4Q7U8ZimBh7FdDs+E273E1MiLO0pGeZ
         xXHjKrmLUp+wyLhKff+IZw/rq6kwJvBvgYsxAzUnv7eB64Qeblu6yP80qMvt346CFTzV
         QJaOHpNbKUDoGUyKBcjhGcQh68r6ARB/4Q1ybN0W4TBXGfTPPd2DJtWoSbQD34tNhfDr
         s4703twGZQdlerQ+JtwE4+aAvqB0Rp/EcsZhzaKR8XyQWerdhUdAWBF5EcBOkNIPS2kW
         /AaWGsv643MTQHA9ei7X1zG1mm7ChHraGNTLIZQdKM4r3bHn6CoqT0oTjwPIyS062dmc
         3TEw==
X-Forwarded-Encrypted: i=1; AJvYcCUf2c4gy6Sr3ZCWdFyHnTFO3yXG9zCBeGdNqidXvN+wK40HvxgaS/8bC9Y8dUlzzdT8qdm0C/hvgzz16BvwdSDAsMV1mg==@vger.kernel.org, AJvYcCWEjIf1nmp8M8t8G3/NtQC5fvRuoNQmT69i266oRh7OLdkYLhsT11VsaOU67UOBAoTPIWm00xz/fqeKTd0=@vger.kernel.org, AJvYcCWJpH+TJUKfbvYb4z6cXwEAZAn6rF5f71QWRdd6MlaAkeTC2QPOtPy+MiOn30Jm1FysJPGOsU0cwAE=@vger.kernel.org, AJvYcCWy+zmF26bNc/y5ywOjQpRgXGddVyPCQ3Q7Md7mlSFwBEfYj2AT+/lmpnBobS5xSgvzpdhWAGKCzFSqq8Dj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WdCJn6IMuaqYvHv0KulJSQsnsz2zzz9BSkzrpzqsf9rR4Mjg
	N8DyU86Xz+W0pMFKoqcWtaEUIQXZFRWsJWSMg6uXgfhv0hGbi7wwR6wrBTuCWew=
X-Gm-Gg: ASbGncsprxe7CKFx3oc19kybW6xFE4Xb+BivZWEGBp8ak2SVsSRQScdR/N8fyWO0u0K
	fYMROz3I6h6ACFrBYhRMK7wTd+SZeioTK7ZPQuAszStE7hjHhMVBDUoE1FgcQb+Zf/4p9HuivsL
	SPGc1FQlXhaqjjjwth4XW+GGPgYDLk8Nfv26Vg4pSZIYNqMqiRC/vXLyBY9cMgohBFxSlFbfO35
	Ysf9s9c0sCWttVWFxg1EhS45iSdX/qk4JAUgs0Bb2aj6b5EM9Fpd07LelfZ/oC6tpe7dbNcAL3O
	77V613QVukgK1oP6DbEJpcNJfw==
X-Google-Smtp-Source: AGHT+IGiUCub3Y5o26KZmQ7Gn8sv3mAdfH7Rwjh9eI6/EgNkoX7WZ5uhzE16mj9ANUzewyCItXBjIg==
X-Received: by 2002:a05:6e02:160b:b0:3a9:cc7f:2bc5 with SMTP id e9e14a558f8ab-3ae61f23afamr133612095ab.3.1734358272687;
        Mon, 16 Dec 2024 06:11:12 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b248228af7sm15975395ab.25.2024.12.16.06.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 06:11:12 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso13234815ab.1;
        Mon, 16 Dec 2024 06:11:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3+mMDpuvfc3xKhie7xK6tsstuf6yBc6njOHh/LghWQwcOIFu91jkQVPE1mPRrgda/H5dI36/0xgsaOyo=@vger.kernel.org, AJvYcCX6UUtolX7gCyRSEjt1eyvEKZhXnvF5BvFMemAqcnF+z0sU8Yz04G0pfvC67grLTau+O+E6n/Pn3yCK9Ga/RGnRYFM5uw==@vger.kernel.org, AJvYcCXVaUBcDWgUOmzxcwxsB24m5C0N6biRpSO9GtU1U26uAmgz9j05bhFiY2MBJ6ErANvVlUqxXO0EsgA=@vger.kernel.org, AJvYcCXasI6OgghnAL4DpNDoMP1JL7LsYrx89PYosJkeGgkpEk6Cp8Ii3/CZOwcS9slBvw6r87tEV24kubn8nmUU@vger.kernel.org
X-Received: by 2002:a05:6e02:20ca:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3b02adcbf2fmr112204765ab.4.1734358271734; Mon, 16 Dec 2024
 06:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209163720.17597-1-josh@joshuagrisham.com> <53c5075b-1967-45d0-937f-463912dd966d@gmx.de>
In-Reply-To: <53c5075b-1967-45d0-937f-463912dd966d@gmx.de>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Mon, 16 Dec 2024 15:11:00 +0100
X-Gmail-Original-Message-ID: <CAMF+KebYQyN+gkHayAdZZHPU7DbghwpmVQaLFaf0TiBb-CVp7A@mail.gmail.com>
Message-ID: <CAMF+KebYQyN+gkHayAdZZHPU7DbghwpmVQaLFaf0TiBb-CVp7A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
To: Armin Wolf <W_Armin@gmx.de>
Cc: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com, 
	hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Armin,
Really humbled and appreciate the depth of your review; though I have
now created a v3 of the patch (in a separate thread to try and give a
new "clean slate" to the patch) I did want to try and take the time to
respond to your comments and ensure that you and the PDX86 maintainers
feel like everything is really resolved in the best way possible. My
resolutions/comments inline below... !

Den tis 10 dec. 2024 kl 07:29 skrev Armin Wolf <W_Armin@gmx.de>:
>
> > +config SAMSUNG_GALAXYBOOK
> > +     tristate "Samsung Galaxy Book extras driver"
> > +     depends on ACPI
> > +     depends on ACPI_BATTERY
> > +     depends on INPUT
> > +     depends on SERIO_I8042
> > +     depends on HWMON || HWMON = n
>
> Please just use "depends on HWMON" here, see the hwmon part for more details.
>

Now (per your later comments) I have just completely removed all of
the Fan-related stuff from this driver which also includes hwmon, so
this depends should no longer even be present.

> > +#define SAMSUNG_GALAXYBOOK_CLASS  "samsung-galaxybook"
>
> Please call this define "DRIVER_NAME".
>

Done!

> > +#define SAMSUNG_GALAXYBOOK_NAME   "Samsung Galaxy Book Extras"
>
> This is only used once, maybe omit this define and use this string directly?
>

Done!

> > +module_param(kbd_backlight, bool, 0644);
> > +MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (default on)");
> > +module_param(battery_threshold, bool, 0644);
> > +MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold control (default on)");
> > +module_param(performance_mode, bool, 0644);
> > +MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (default on)");
> > +module_param(allow_recording, bool, 0644);
> > +MODULE_PARM_DESC(allow_recording,
> > +              "Enable control to allow or block access to camera and microphone (default on)");
> > +module_param(fan_speed, bool, 0644);
> > +MODULE_PARM_DESC(fan_speed, "Enable fan speed (default on)");
> > +module_param(i8042_filter, bool, 0644);
> > +MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey events (default on)");
>
> Is there a reason why those module params have a visibility of 0644? If not, then please change it to 0.
>

No reason other than it came over from copy-paste of other modules;
you are right, there is no value to read or change these after the
module loads (and maybe even could cause some issues) so I have
changed them all to 0.

> > +static const struct acpi_device_id galaxybook_device_ids[] = {
> > +     { "SAM0427" },
> > +     { "SAM0428" },
> > +     { "SAM0429" },
> > +     { "SAM0430" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
> > +
> > +static const struct dmi_system_id galaxybook_dmi_ids[] = {
> > +     {
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> > +                     DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> > +             },
> > +     },
> > +     {}
> > +};
>
> Since you already use the ACPI ids, i suggest that you drop this DMI check.
>

Also done! I guess especially since in theory manufacturers should be
sticking to UEFI's ACPI / PNP ID registry that there should not be
risk that other devices would suddenly magically have the same ACPI
Device ID, so it feels quite safe to only rely on the ACPI device IDs
I would think.

> > +static struct samsung_galaxybook *galaxybook_ptr;
>
> Please use the state container pattern (https://www.kernel.org/doc/html/latest/driver-api/driver-model/design-patterns.html) instead of
> having this global variable. The reason for this is that this will break badly should this driver somehow get instantiated multiple times.
>

This is done now as well, per other comments later in the thread. Note
I have not included i8042 changes in v3 of the patch but did see your
patch which will enable this; my thinking is that if your patch gets
merged to pdx86 for-next then I will go ahead and rebase to it and
then try to implement into a v4 of this patch (plus a comment about
the dependency in the commit msg), so we can actually fully remove the
global variable completely from the start with this driver.  Please
feel free to say if you had any other idea or preference on this!

> Looking at the fan device, it seems that it only supports the _FST ACPI 4 method and is thus being treated
> like a ACPI 1.0 fan device by the fan driver.
>
> According to https://learn.microsoft.com/de-de/windows-hardware/design/device-experiences/design-guide,
> Windows seems to only support the _FST method, so that might be the reason why the other (mandatory)
> ACPI methods seem to be missing.
>
> I think we should rather extend the ACPI fan driver to handle this case. Please remove the fan-related code
> from the driver and talk to the maintainers of the ACPI fan driver instead.
>

I agree 100% with this and have removed all of the fan stuff from this
driver. I will see if I can kick something off with the ACPI folks and
make some progress there as I have some time.

For my specific device I will also try to push this as a bug with
Samsung, as there is a bug in the DSDT of my device which throws an
exception when you try to execute _FST on the fan device if the state
control / speed is greater than 0. I have been able to patch my DSDT
to fix the exception but this is not a super user-friendly process and
will potentially create havoc if I upgrade my BIOS later and I think
this is not a great process for end users to have to put up with :)

> > +static const struct key_entry galaxybook_acpi_keymap[] = {
> > +     { KE_KEY, ACPI_NOTIFY_BATTERY_STATE_CHANGED,   { KEY_BATTERY } },
> > +     { KE_KEY, ACPI_NOTIFY_DEVICE_ON_TABLE,         { KEY_F14 } },
> > +     { KE_KEY, ACPI_NOTIFY_DEVICE_OFF_TABLE,        { KEY_F15 } },
> > +     { KE_KEY, ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE, { KEY_UNKNOWN } },
>
> Can you explain what the original purpose of those ACPI events is? Also if you
> already handle ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE the associated key mapping
> is unnecessary.
>

ACPI_NOTIFY_BATTERY_STATE_CHANGED = notification that battery has
changed state (not 100% what all cases but it is definitely every time
that charging is stopped due to meeting charge control end threshold,
and have seen it (somewhat intermittently, it feels like?) when
connecting or disconnecting the power adapter etc)

ACPI_NOTIFY_DEVICE_ON_TABLE = notification when the motion sensor in
the device detects that the device has been placed on a flat surface /
a "table"

ACPI_NOTIFY_DEVICE_OFF_TABLE = notification when the motion sensor in
the device detects that the device has been removed from a flat
surface / a "table"

ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE is semi-obvious I guess :) But in
the logic there is currently a case where if "performance_mode" is
enabled then it will swallow this key event and then execute the
action to cycle the profile, but if "performance_mode" is disabled
then it will not swallow the event but will instead send the key event
to the input device. Does this make sense or should it just be removed
from the keymap entirely?

> > +#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)
>
> Maybe dev_dbg() is more suitable here?
>
> > +
> > +#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len) \
> > +     do {                                                            \
> > +             pr_debug_prefixed("%s\n", header_str);                  \
> > +             print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",  \
> > +                                  DUMP_PREFIX_NONE, 16, 1, buf_ptr,  \
> > +                                  buf_len, false);                   \
> > +     } while (0)
> > +
>
> Please remove this, it would make the driver very noisy when enabled. You can either
> use the linux tracepoint infrastructure for that or create a debugfs interface.
>
> Those things however are entirely optional, but please remove this debug macro.
>

Removed all of this most of the logging in the driver; created a new
tracepoint with a new trace system called samsung_galaxybook and moved
this ACPI communication tracing there, and then switched anything left
in the driver itself to dev_* version of functions (but only some
dbg/warn/errors are left). Hopefully how I set up the header file and
the tracepoint system and event all looks as it should but any
feedback is welcome on any part of this!

> The ACPI core already provides a helper function for that, but since this function is only used
> by the fan-related code please just drop it.
>

Yes, removed all of the fan stuff :)

> > +static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook, acpi_string method,
> > +                               struct sawb *buf, u32 len, const char *purpose_str,
> > +                               struct sawb *ret)
>
> len should be size_t. Also please remove the purpose string, it adds no value in the end.
>

Changed len to size_t but for now I have left purpose_str in because
it helps me a lot with the traces in case any users have an issue and
need to provide a trace file (since this is a very chatty device
especially during init, and the payloads can be really long.. it is
easy to get a bit lost without some info in the trace to help navigate
what is supposed to be happening). Is it ok to have it for this usage
or is there any other preferred/better way to try and send this kind
of information in the traces?

> > +     if (out_obj->buffer.length != len) {
> > +             pr_err("failed %s with ACPI method %s; response length mismatch\n",
> > +                    purpose_str, method);
> > +             status = -EIO;
> > +             goto out_free;
> > +     }
> > +     if (out_obj->buffer.length < SAWB_GUNM_POS + 1) {
> > +             pr_err("failed %s with ACPI method %s; response from device was too short\n",
> > +                    purpose_str, method);
> > +             status = -EIO;
> > +             goto out_free;
> > +     }
> > +     if (out_obj->buffer.pointer[SAWB_RFLG_POS] != RFLG_SUCCESS) {
> > +             pr_err("failed %s with ACPI method %s; "
> > +                    "device did not respond with success code 0x%x\n",
> > +                    purpose_str, method, RFLG_SUCCESS);
> > +             status = -EIO;
> > +             goto out_free;
> > +     }
> > +     if (out_obj->buffer.pointer[SAWB_GUNM_POS] == GUNM_FAIL) {
> > +             pr_err("failed %s with ACPI method %s; device responded with failure code 0x%x\n",
> > +                    purpose_str, method, GUNM_FAIL);
> > +             status = -EIO;
> > +             goto out_free;
> > +     }
>
> I think replacing the error messages with a unique error code (ENXIO, ENODATA, ...) would make this code
> more readable. But i will leave it up to you to decide about this.
>

Now I have combined the first two cases and have it returning
ETOOSMALL (best guess I could come to for this based on the various
errno lists) but for the second two I was not really sure what
specific error code would fit best there (missing success code vs
existence of error code in response payload). So I have left them as
EIO and write a dev_err() for them but please feel free say if there
are specific error codes that should represent these kind of cases (as
I could not find anything too obvious in the few different lists I
managed to find..).

> > +out_free:
> > +     kfree(output.pointer);
> > +     return status;
>
> acpi_status is a ACPICA-internal type. Please use "int" for return code handling.
>

Here I have redone this a bit so that only ints with valid error codes
are always returned, but in several cases there is an ACPI failure
given that I need to then provide an int error code, so I have tried
to choose a reasonable int error code to return in all of these cases
but please feel free to suggest if anything looks off!

> > +     err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
> > +                                  "setting kbd_backlight brightness", &buf);
> > +     if (err)
> > +             return err;
> > +
> > +     galaxybook->kbd_backlight.brightness = brightness;
>
> You probably need to have some locking here, but see my comment regarding galaxybook_kbd_backlight_hotkey_work()
> for details.
>

Here I have now added locking within galaxybook_acpi_method itself, so
it always locks on galaxybook->acpi_lock for anything that will be
working with the ACPI device (calling various methods etc). Does this
work ok for handling locks from when the i8042 keyboard filters
triggers actions (which will then execute acpi methods and make use of
this acpi_lock) or should this be done a bit differently outside of
that method instead? (e.g. is it also / more important to lock on
updating the brightness value itself and/or when executing
led_classdev_notify_brightness_hw_changed() etc ? or is it reasonable
to say that locking within the acpi method function anyway will take
care of any issue that could happen here?)

Then for notification to the new input device via the sparse keymap I
have also added another lock galaxybook->input_lock

> > +     err = kbd_backlight_acpi_set(galaxybook, brightness);
> > +     if (err)
> > +             return err;
> > +
> > +     return 0;
>
> Use "return kbd_backlight_acpi_set(galaxybook, brightness);" here and remove the err variable please.
>

Thanks for this catch! This was leftover from when I had some extra
debug printing here before returning but now I have hopefully cleaned
this up here as well as all other similar instances.


> > +     init_data.devicename = SAMSUNG_GALAXYBOOK_CLASS;
> > +     init_data.default_label = ":kbd_backlight";
>
> Use LED_FUNCTION_KBD_BACKLIGHT here.
>

Done, but I used `":" LED_FUNCTION_KBD_BACKLIGHT` so that the
resulting name will be "samsung-galaxybook::kbd_backlight", hopefully
this seems ok?

> > +     galaxybook->kbd_backlight = (struct led_classdev){
> > +             .brightness_get = kbd_backlight_show,
> > +             .brightness_set_blocking = kbd_backlight_store,
> > +             .flags = LED_BRIGHT_HW_CHANGED,
> > +             .max_brightness = KBD_BACKLIGHT_MAX_BRIGHTNESS,
> > +     };
>
> Please assign those values one-by-one.
>

Done!

> > +
> > +     pr_info("registering LED class using default name of %s:%s\n",
> > +             init_data.devicename, init_data.default_label);
>
> This debug info is unnecessary, please remove.
>

Done!

> > +     return led_classdev_register_ext(&galaxybook->platform->dev, &galaxybook->kbd_backlight,
> > +                                      &init_data);
>
> Consider using devm_led_classdev_register_ext(), it would allow you to have this LED device be cleaned
> up automatically in case of an probe error or driver removal.
>

Done and also tried to ensure usage of devres/devm_* functions and/or
at least trigger a devm_add_action_or_reset() to remove instead of
handling it in the driver remove -- please say if it looks I missed
anything :)

> > +     if (!count || kstrtobool(buffer, &value))
> > +             return -EINVAL;
>
> Please us the return value of kstrtobool as the error code if appropriate.
>

Done here plus anywhere else that had this same pattern.

> > +static DEVICE_ATTR_RW(charge_control_end_threshold);
>
> As a side note: take a look at the dell-wmi-ddv driver on how to handle those battery device attributes without
> having to use global variables like galaxybook_ptr.
>

Done in v3 of the patch as written in other places :)

> > +static int galaxybook_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
> > +{
> > +     if (device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold))
> > +             return -ENODEV;
>
> Please return the error code of the function here.
>

Done!

> > +     battery_hook_register(&galaxybook_battery_hook);
> > +     return 0;
>
> Please do proper error handling here, as battery_hook_register() can fail. You should also
> consider using devm_battery_hook_register().
>

Done (both) ! :)

>
> Regarding the whole fan logic:
>
> This belongs into the ACPI fan driver. The FANT value seems to be available thru a _DSM on the ACPI fan device
> using GUID a7611840-99fe-41ae-a488-35c75926c8eb. This GUID is documented in the Microsoft design guide, see
> https://learn.microsoft.com/de-de/windows-hardware/design/device-experiences/design-guide for details.
>
> If you want to add support for this, please talk with the maintainers of the ACPI fan driver.
>

As mentioned, agree 100% on this and have taken it out completely
(including the hwmon device). Very good link as well from Microsoft
which I think will provide good support for having this in the Linux
driver, as well (that there are likely many other devices in the wild
that have the exact condition as these Samsung devices, since their
goal was only to provide support in Windows).

> > +/* copied from platform_profile.c; better if this could be fetched from a public function, maybe? */
> > +static const char *const profile_names[] = {
> > +     [PLATFORM_PROFILE_LOW_POWER] = "low-power",
> > +     [PLATFORM_PROFILE_COOL] = "cool",
> > +     [PLATFORM_PROFILE_QUIET] = "quiet",
> > +     [PLATFORM_PROFILE_BALANCED] = "balanced",
> > +     [PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
> > +     [PLATFORM_PROFILE_PERFORMANCE] = "performance",
> > +};
> > +static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>
> This is only used for debugging, please remove this and the associated print statements as they
> add no real value.
>

Agreed 100% -- it's gone :)

> > +static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *work)
> > +{
> > +     struct samsung_galaxybook *galaxybook =
> > +             container_of(work, struct samsung_galaxybook, kbd_backlight_hotkey_work);
> > +
> > +     if (galaxybook->kbd_backlight.brightness < galaxybook->kbd_backlight.max_brightness)
> > +             kbd_backlight_acpi_set(galaxybook, galaxybook->kbd_backlight.brightness + 1);
> > +     else
> > +             kbd_backlight_acpi_set(galaxybook, 0);
> > +
> > +     led_classdev_notify_brightness_hw_changed(
> > +             &galaxybook->kbd_backlight,
> > +             galaxybook->kbd_backlight.brightness);
>
> Use the KEY_KBDILLUMDOWN/KEY_KBDILLUMUP key codes to let userspace do this for you. This also allows
> userspace applications to ignore those requests when necessary.
>

Here I think there is maybe a discrepancy with what was said by Hans:
https://lore.kernel.org/platform-driver-x86/40b82b39-3bba-4eac-8eb0-b4cee4868737@redhat.com/

As I understand from his comment that the desire is to handle this
"like the EC performs the action" and then just give the built-in
notification i.e. led_classdev_notify_brightness_hw_changed (and no
key event) to avoid risk that people will "accidentally" create double
events or loops etc.

For now I have tried to achieve what I took from Han's reply (swallow
the event and do the action, but then send the hw notification) but if
this should be changed then I can do whatever is most appropriate.

> > +static void galaxybook_allow_recording_hotkey_work(struct work_struct *work)
> > +{
> > +     struct samsung_galaxybook *galaxybook =
> > +             container_of(work, struct samsung_galaxybook, allow_recording_hotkey_work);
> > +     bool value;
> > +
> > +     allow_recording_acpi_get(galaxybook, &value);
> > +     allow_recording_acpi_set(galaxybook, !value);
>
> I am pretty sure a suitable keycode(s) exists for that so userspace can show a OSD icon.
> Also you might need some locking here.
>

Regarding locking, do you think the acpi_lock here within
galaxybook_acpi_method will cover this in a good way or anything else
should be done specifically here?

Regarding the keycode do you mean that this should send something to
the input device via the sparse keymap or that the i8042 filter should
emit a key event, or? And/or that it could be handled with a hwdb
update in systemd so that this key gets mapped to the right event?

Regarding the specific keycode I assume that maybe the appropriate one
would be KEY_CAMERA_ACCESS_TOGGLE ? (though I have not seen any OSD
notification with this keycode but maybe it was only with older
versions of userspace tools I was originally testing this with..).

> > +             case GB_KEY_KBD_BACKLIGHT_KEYDOWN:
> > +                     return true;
> > +             case GB_KEY_KBD_BACKLIGHT_KEYUP:
> > +                     if (kbd_backlight)
> > +                             schedule_work(&galaxybook_ptr->kbd_backlight_hotkey_work);
> > +                     return true;
> > +
> > +             case GB_KEY_ALLOW_RECORDING_KEYDOWN:
> > +                     return true;
> > +             case GB_KEY_ALLOW_RECORDING_KEYUP:
> > +                     if (allow_recording)
> > +                             schedule_work(&galaxybook_ptr->allow_recording_hotkey_work);
>
> You should forward the keyup/keydown presses to a real input device so userspace can act on them accordingly.
> Still i think you can keep the special handling of GB_KEY_ALLOW_RECORDING_KEYUP.
>

Here I took the same approach (swallow the key event "like it was
handled by the EC" and don't send a key event that would allow for
double events) but there is no built-in hw event for this from what I
can see. But I would say it is related to the comment above -- how
should this actually work? (e.g. send KEY_CAMERA_ACCESS_TOGGLE via
sparse keymap to the input device instead of letting the event pass
through to the AT keyboard device i.e. return true to filter out the
event in the i8042 filter) ?

> > +static void galaxybook_input_notify(struct samsung_galaxybook *galaxybook, int event)
> > +{
> > +     if (!galaxybook->input)
> > +             return;
> > +     pr_debug_prefixed("input notification event: 0x%x\n", event);
> > +     if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
> > +             pr_warn("unknown input notification event: 0x%x\n", event);
>
> Please also call acpi_bus_generate_netlink_event() so users can use acpid to listen to
> those events. Also you need to use a mutex when calling the sparse keymap since multiple
> ACPI notifications might happen concurrently.
>

Here I have added both a mutex lock (input_lock) that wrapped the
sparse_keymap_report_event plus I have added
acpi_bus_generate_netlink_event() -- took some liberties with the
names to pass to the event (DRIVER_NAME and then the ACPI Device ID)
if these look ok? Tested with acpid and it did look ok but I could not
see any clear standard on what to use for these labels.

> > +     error = input_register_device(input);
> > +     if (error) {
> > +             pr_err("Unable to register input device\n");
> > +             goto err_free_dev;
> > +     }
> > +
>
> Please remove the print statements and just return the error code. Also consider
> using devm_input_allocate_device() to simplify the error handling.
>

Done and done!

> > [...]
> > +     return device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
> > +};
>
> Use the .is_visible callback for that please.
>
> > +
> > +static void galaxybook_device_attrs_exit(struct samsung_galaxybook *galaxybook)
> > +{
> > +     device_remove_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
> > +}
>
> You can attach this group to your driver by using .dev_groups. Those will then be handled
> automatically by the driver core.
>

Here I have changed the "visibility" to use is_visible with a function
per your first suggestion, but as I needed things in this is_visible
to call the ACPI methods then I needed to control exactly when they
ran.. so I have not added them to .dev_groups of the driver but
instead added them in the probe function after the ACPI device is
setup and initialized (using devm_device_add_group()) -- does this
seem ok?

> > +static void galaxybook_acpi_notify(acpi_handle handle, u32 event, void *data)
> > +{
> > +     struct samsung_galaxybook *galaxybook = data;
> > +
> > +     if (event == ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
> > +             pr_debug_prefixed("hotkey: performance_mode keydown\n");
> > +             if (performance_mode) {
> > +                     schedule_work(&galaxybook->performance_mode_hotkey_work);
> > +                     return;
> > +             }
> > +     }
>
> You do not need to use schedule_work() inside a ACPI notify handler, it already runs inside
> a workqueue.
>

Based on this I have just completely removed the
performance_mode_hotkey_work queue and just directly call the function
here within galaxybook_acpi_notify. I noticed in the tracepoint trace
that every execution of this action from the hotkey is in fact
happening in a separate thread so that seems as desired, but please
let me know if anything seems off with this now!

> > +static void galaxybook_acpi_exit(struct samsung_galaxybook *galaxybook)
> > +{
> > +     acpi_execute_simple_method(galaxybook->acpi->handle,
> > +                                ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
>
> Consider using devm_add_action_or_reset() to call this method at removal time or in
> case of an probe error.
>

Done!

> > +     pr_info("found matched device %s; loading driver\n", dev_name(&adev->dev));
>
> Working drivers should be silent by default. Also please check adev for NULL first.
>

Yes, done, totally silent now if you have not enabled debug and there
are no warnings/failures :)

> > +     galaxybook = kzalloc(sizeof(struct samsung_galaxybook), GFP_KERNEL);
>
> Please use sizeof(*galaxybook) here. Also consider using devm_kzalloc() to simplify the error handling.
>

Done!

> > +     pr_debug_prefixed("installing ACPI notify handler\n");
> > +     status = acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> > +                                          galaxybook_acpi_notify, galaxybook);
> > +     if (ACPI_SUCCESS(status)) {
> > +             pr_debug_prefixed("enabling ACPI notifications\n");
> > +             err = galaxybook_enable_acpi_notify(galaxybook);
> > +             if (err) {
> > +                     pr_warn("failed to enable ACPI notifications; "
> > +                             "some hotkeys will not be supported\n");
> > +             } else {
> > +                     /* initialize ACPI hotkey work queues */
> > +                     INIT_WORK(&galaxybook->performance_mode_hotkey_work,
> > +                               galaxybook_performance_mode_hotkey_work);
> > +
> > +                     pr_debug_prefixed("initializing input device\n");
> > +                     err = galaxybook_input_init(galaxybook);
> > +                     if (err) {
> > +                             pr_err("failed to initialize input device\n");
> > +                             cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> > +                             galaxybook_input_exit(galaxybook);
> > +                     }
> > +             }
>
> The input device provides open() and close() callbacks, maybe you can do the event enabling there?
> Also you should call INIT_WORK() earlier in case the ACPI firmware gives you an early notification
> my mistake.
>

There is no longer a workqueue associated with the input device (per
previous comments) so hopefully this part is no longer valid. I have
also revamped a bit of the flow of this and baked a lot of it into the
function galaxybook_acpi_init() -- please take a look and see if it
looks ok/better now and/or if there is more work to be done on this?

> > +     } else {
> > +             pr_debug_prefixed("failed to install ACPI notify handler\n");
>
> This should result in a probe error.
>

Yes now this will fail.

> > +     galaxybook_input_exit(galaxybook);
> > +     cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> > +
> > +     if (i8042_filter) {
> > +             i8042_remove_filter(galaxybook_i8042_filter);
> > +             cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> > +             cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> > +     }
> > +
> > +     acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> > +                                galaxybook_acpi_notify);
>
> Maybe you should remove the ACPI notify handler first to avoid submitting a input request
> on a unregistered input device.
>

Now I have changed this so that they are both handled via devm
functions; I think this order should be achieved but in case I missed
something then please feel free to say!

> > +static int __init samsung_galaxybook_init(void)
> > +{
> > +     return platform_driver_register(&galaxybook_platform_driver);
> > +}
> > +
> > +static void __exit samsung_galaxybook_exit(void)
> > +{
> > +     platform_driver_unregister(&galaxybook_platform_driver);
> > +}
>
> Please use module_platform_driver() here.
>

Done!

> In general i am ok with the general design of this driver. The things which need a bit more work are:
>
> - the fan handling code should be inside the ACPI fan driver
> - most debug messages should be replaced by tracepoints, etc or just removed
> - replacing galaxybook_ptr with the state container pattern
> - using devres (devm_* functions) would simplify error handling
> - some events should trigger a input device event with an appropriate keycode
>
> Thanks,
> Armin Wolf
>

Thank you again and please feel free to write here or just take any
comments directly in response to the v3 patch and we can take anything
needed further from there!

Great review!!

Best regards,
Joshua

