Return-Path: <linux-kernel+bounces-438211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2E9E9E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932BC16634E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F01179972;
	Mon,  9 Dec 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6TAHYW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1113B59A;
	Mon,  9 Dec 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770146; cv=none; b=NPdmySY+zCzqkr3xwn0ObVJwnVXL7NyqpbndvqYNltlXrKbciNxVOBAXeX7+CJzZ2NtKJrc0eCGagSaqnNIKcRVtJzCDscoVFoAuw7k0eBW+eA16DqPJrJBTL1HXW6Ys2WPUfJh3i2h5hEStagPfwAp1wttfbL03OGQVD94tkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770146; c=relaxed/simple;
	bh=P5zoxWoFN1BE01HLZo2ef4M8VcGARvL2mMMveJm1Xvg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SD2ly9XCZeEolCmdiRh6N+7+UDymUO8EJQZobbXVAbn6KzgHbICKadCl/BPOUOS1TVodCly4Wdn1I0Xxry2Tws53P8qFJsIJT8yJ3R7ocrKmJ2tN2YbuQR4ZcJP7tHCQkrc+w5fY8UwtMb/BMTBi9boqbzU0WYTRapmVtSlH41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6TAHYW+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733770142; x=1765306142;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=P5zoxWoFN1BE01HLZo2ef4M8VcGARvL2mMMveJm1Xvg=;
  b=c6TAHYW+qFSX69wp4NSrfIfk7Jp61MHZfOrphv9wZ+Og8tQFBepxx5+h
   wuPFYabLcnH1pLRkV4NrgP0NMHoUU/i4aO07Wb3lE64rI6hO7GBZWRYV5
   VTcYzippjU9FBfdOa1028JURTb6qCLGGAj9qrznbdw2+wXKa68i1Rqt70
   MAh2f4RSfGkwFmRsjuhpHGxoOqjIQNYW9oo6avcrNDMbykFML9cKJDzUY
   w+tuiMCooOio1Xdv8HkHBbfVZf8u3V/S+giM330nsiK0m24iG0IcfrkIQ
   zdeFx/EUaiG92HO361ZniiJ6cXkCZrmGqAQG4aMi8Nk5DO/HtCKmIIc6m
   g==;
X-CSE-ConnectionGUID: dACNj2VgSzWF03060n5BYA==
X-CSE-MsgGUID: OAgJ2rKcRyKveDUnKCmwww==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34007775"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34007775"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:49:01 -0800
X-CSE-ConnectionGUID: Bw2aTy7EQtiFetJCfNn4vw==
X-CSE-MsgGUID: WaEQ3Y05Tc2UcBCKn5+9Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="132540473"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:48:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Dec 2024 20:48:52 +0200 (EET)
To: Joshua Grisham <josh@joshuagrisham.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    corbet@lwn.net, linux-doc@vger.kernel.org, jdelvare@suse.com, 
    linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
In-Reply-To: <20241209163720.17597-1-josh@joshuagrisham.com>
Message-ID: <9b1630fe-70af-634b-b8ba-7b065d9ce5ae@linux.intel.com>
References: <20241209163720.17597-1-josh@joshuagrisham.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-845421102-1733765605=:938"
Content-ID: <d904d133-9fe7-649e-5713-01a2cbbc1ed2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-845421102-1733765605=:938
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <19bab7c7-af57-f53e-c6d0-3deca170d47a@linux.intel.com>

On Mon, 9 Dec 2024, Joshua Grisham wrote:

> This patch will add a new driver for Samsung Galaxy Book series notebook
> devices. This should hopefully include all suggestions from my original
> mailing list feedback thread [1], as well as a first version for
> associated updates to the documentation, Kconfig, Makefile, and the
> MAINTAINERS file related to this new driver.
>=20
> I have tested the driver both using m and y in the config, as well as
> with various other options mentioned in the patch checklist of the
> documentation.
>=20
> Other users with other device IDs have also tested successfully using
> a version of these same driver updates which I have maintained in a
> separate branch of my GitHub repository [2].
>=20
> I have made an attempt with the coding style to find a balance between wh=
at
> is written in the kernel documentation and what actually exists in curren=
t
> x86 platform drivers, but any feedback on this (or anything else) is
> certainly welcome!
>=20
> [1]: https://lore.kernel.org/platform-driver-x86/CAMF+KeYus9dW00WNJMLVxLL=
HdG9JgCfrGJ491fu7NM8GAEqqCg@mail.gmail.com/
> [2]: https://github.com/joshuagrisham/samsung-galaxybook-extras/pull/44
>=20
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
>  Documentation/admin-guide/laptops/index.rst   |    1 +
>  .../laptops/samsung-galaxybook.rst            |  301 +++
>  MAINTAINERS                                   |    6 +
>  drivers/platform/x86/Kconfig                  |   19 +
>  drivers/platform/x86/Makefile                 |    5 +-
>  drivers/platform/x86/samsung-galaxybook.c     | 1972 +++++++++++++++++
>  6 files changed, 2302 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/admin-guide/laptops/samsung-galaxybook.=
rst
>  create mode 100644 drivers/platform/x86/samsung-galaxybook.c
>=20
> diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation/=
admin-guide/laptops/index.rst
> index cd9a1c269..e71c8984c 100644
> --- a/Documentation/admin-guide/laptops/index.rst
> +++ b/Documentation/admin-guide/laptops/index.rst
> @@ -11,6 +11,7 @@ Laptop Drivers
>     disk-shock-protection
>     laptop-mode
>     lg-laptop
> +   samsung-galaxybook
>     sony-laptop
>     sonypi
>     thinkpad-acpi
> diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/D=
ocumentation/admin-guide/laptops/samsung-galaxybook.rst
> new file mode 100644
> index 000000000..ab12f0001
> --- /dev/null
> +++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
> @@ -0,0 +1,301 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Samsung Galaxy Book Extras
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +December 9, 2024
> +
> +Joshua Grisham <josh@joshuagrisham.com>
> +
> +This is a Linux x86 platform driver for Samsung Galaxy Book series noteb=
ook
> +devices which utilizes Samsung's ``SCAI`` ACPI device in order to contro=
l
> +extra features and receive various notifications.
> +
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +"SAMSUNG ELECTRONICS CO., LTD." devices of type "Notebook" which have on=
e of the
> +supported ACPI device IDs should be supported. This covers most of the "=
Samsung
> +Galaxy Book" series notebooks that are currently available as of this wr=
iting,
> +and could include other Samsung notebook devices as well.
> +
> +
> +Status
> +=3D=3D=3D=3D=3D=3D
> +
> +The following features are currently supported:
> +
> +- :ref:`Keyboard backlight <keyboard-backlight>` control
> +- :ref:`Performance mode <performance-mode>` control implemented using t=
he
> +  platform profile interface
> +- :ref:`Battery charge control end threshold
> +  <battery-charge-control-end-threshold>` (stop charging battery at give=
n
> +  percentage value) implemented as a battery device extension
> +- :ref:`Fan speed <fan-speed>` monitoring via ``fan_speed_rpm`` sysfs at=
tribute
> +  plus a new hwmon device
> +- :ref:`Settings Attributes <settings-attributes>` to allow control of v=
arious
> +  device settings
> +- :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various ac=
tions
> +
> +Because different models of these devices can vary in their features, th=
ere is
> +logic built within the driver which attempts to test each implemented fe=
ature
> +for a valid response before enabling its support (registering additional=
 devices
> +or extensions, adding sysfs attributes, etc). Therefore, it can be impor=
tant to
> +note that not all features may be supported for your particular device.
> +
> +The following features might be possible to implement but will require
> +additional investigation and are therefore not supported at this time:
> +
> +- "Dolby Atmos" mode for the speakers
> +- "Outdoor Mode" for increasing screen brightness on models with ``SAM04=
27``
> +- "Silent Mode" on models with ``SAM0427``
> +
> +
> +Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver includes a list of boolean parameters that allow for manually
> +enabling or disabling various features:
> +
> +- ``kbd_backlight``: Enable Keyboard Backlight control (default on)
> +- ``performance_mode``: Enable Performance Mode control (default on)
> +- ``battery_threshold``: Enable battery charge threshold control (defaul=
t on)
> +- ``fan_speed``: Enable fan speed (default on)
> +- ``allow_recording``: Enable control to allow or block access to camera=
 and
> +  microphone (default on)
> +- ``i8042_filter``: Enable capture and execution of keyboard-based hotke=
y events
> +  (default on)
> +
> +.. note::
> +  Even if you explicitly try to enable a feature using its parameter, su=
pport
> +  for it will still be evaluated by the driver, and the feature will be
> +  disabled if it does not appear to be supported on your device.
> +
> +The availability of various sysfs file-based "settings" attributes
> +(``usb_charge``, ``start_on_lid_open``, etc) will be determined automati=
cally
> +and cannot be manually disabled at this time.
> +
> +
> +.. _keyboard-backlight:
> +
> +Keyboard backlight
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``kbd_backlight``
> +
> +A new LED class named ``samsung-galaxybook::kbd_backlight`` is created w=
hich
> +will then expose the device using the standard sysfs-based LED interface=
 at
> +``/sys/class/leds/samsung-galaxybook::kbd_backlight``. Brightness can be
> +controlled by writing values 0 to 3 to the ``brightness`` sysfs attribut=
e or
> +with any other desired userspace utility.
> +
> +.. note::
> +  Most of these devices have an ambient light sensor which also turns
> +  off the keyboard backlight under well-lit conditions. This behavior do=
es not
> +  seem possible to control at this time, but can be good to be aware of.
> +
> +
> +.. _performance-mode:
> +
> +Performance mode
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``performance_mode``
> +
> +This driver implements the
> +Documentation/userspace-api/sysfs-platform_profile.rst interface for wor=
king
> +with the "performance mode" function of the Samsung ACPI device.
> +
> +Mapping of each Samsung "performance mode" to its respective platform pr=
ofile is
> +done dynamically based on a list of the supported modes reported by the =
device
> +itself. Preference is given to always try and map ``low-power``, ``balan=
ced``,
> +and ``performance`` profiles, as these seem to be the most common profil=
es
> +utilized (and sometimes even required) by various userspace tools.
> +
> +The result of the mapping will be printed in the kernel log when the mod=
ule is
> +loaded. Supported profiles can also be retrieved from
> +``/sys/firmware/acpi/platform_profile_choices``, while
> +``/sys/firmware/acpi/platform_profile`` can be used to read or write the
> +currently selected profile.
> +
> +The ``balanced`` platform profile will be set during module load if no p=
rofile
> +has been previously set.
> +
> +
> +.. _battery-charge-control-end-threshold:
> +
> +Battery charge control end threshold
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``battery_threshold``
> +
> +This platform driver will add the ability to set the battery's charge co=
ntrol
> +end threshold, but does not have the ability to set a start threshold.
> +
> +This feature is typically called "Battery Saver" by the various Samsung
> +applications in Windows, but in Linux we have implemented the standardiz=
ed
> +"charge control threshold" sysfs interface on the battery device to allo=
w for
> +controlling this functionality from the userspace.
> +
> +The sysfs attribute
> +``/sys/class/power_supply/BAT1/charge_control_end_threshold`` can be use=
d to
> +read or set the desired charge end threshold.
> +
> +If you wish to maintain interoperability with Windows, then you should s=
et the
> +value to 80 to represent "on", or 0 to represent "off", as these are the=
 values
> +currently recognized by the various Windows-based Samsung applications a=
nd
> +services as "on" or "off". Otherwise, the device will accept any value b=
etween 0
> +(off) and 99 as the percentage that you wish the battery to stop chargin=
g at.
> +
> +.. note::
> +  If you try to set a value of 100, the driver will also accept this inp=
ut, but
> +  will set the attribute value to 0 (i.e. 100% will "remove" the end thr=
eshold).
> +
> +
> +.. _fan-speed:
> +
> +Fan speed
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``fan_speed``
> +
> +The number and type of fans on these devices can vary, and different met=
hods
> +must be used in order to be able to successfully read their status.
> +
> +In cases where Samsung has implemented the standard ACPI method ``_FST``=
 for a
> +fan device, the other methods in the ACPI specification which would caus=
e
> +the kernel to automatically add the ``fan_speed_rpm`` attribute are not =
always
> +present. On top of this, it seems that there are some bugs in the firmwa=
re that
> +throw an exception when the ``_FST`` method is executed.
> +
> +This platform driver attempts to resolve all PNP fans that are present i=
n the
> +ACPI of supported devices, and add support for reading their speed using=
 the
> +following decision tree:
> +
> +1. Do all 4 required methods exist so that the fan speed should be repor=
ted
> +   out-of-the-box by ACPI? If yes, then assume this fan is already set u=
p and
> +   available.
> +
> +2. Does the method ``_FST`` exist and appears to be working (returns a s=
peed
> +   value greater than 0)? If yes, add an attribute ``fan_speed_rpm`` to =
this fan
> +   device and add a fan input channel for it to the hwmon device. The re=
turned
> +   value will be directly read from the ``_FST`` method.
> +
> +3. Does the field ``FANS`` (fan speed level) exist on the embedded contr=
oller,
> +   and the table ``FANT`` (fan speed level table) exist on the fan devic=
e? If
> +   yes, add the ``fan_speed_rpm`` attribute to this fan device and add a=
 fan
> +   input channel for it to the hwmon device. The returned value will be =
based
> +   on a match of the current value of ``FANS`` compared to a list of lev=
el
> +   speeds from the ``FANT`` table.
> +
> +The fan speed for all supported fans can be monitored using hwmon sensor=
s or by
> +reading the ``fan_speed_rpm`` sysfs attribute of each fan device.
> +
> +
> +.. _settings-attributes:
> +
> +Settings Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Various hardware settings can be controlled by the following sysfs attri=
butes:
> +
> +- ``allow_recording`` (allows or blocks usage of built-in camera and mic=
rophone)
> +- ``start_on_lid_open`` (power on automatically when opening the lid)
> +- ``usb_charge`` (allows USB ports to provide power even when device is =
off)
> +
> +These attributes will be available under the path for your supported ACP=
I Device
> +ID's platform device (``SAM0428``, ``SAM0429``, etc), and can most relia=
bly
> +be found by seeing which device has been bound to the ``samsung-galaxybo=
ok``
> +driver. Here are some examples: ::
> +
> +  # find which device ID has been bound to the driver
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/ | grep SAM
> +
> +  # see SAM0429 attributes
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM0429\:00
> +
> +  # see attributes no matter the device ID (using wildcard expansion)
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM*
> +
> +Most shells should support using wildcard expansion to directly read and=
 write
> +these attributes using the above pattern. Example: ::
> +
> +  # read value of start_on_lid_open
> +  cat /sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_ope=
n
> +
> +  # turn on start_on_lid_open
> +  echo true | sudo tee /sys/bus/platform/drivers/samsung-galaxybook/SAM*=
/start_on_lid_open
> +
> +It is also possible to use a udev rule to create a fixed-path symlink to=
 your
> +device under ``/dev`` (e.g. ``/dev/samsung-galaxybook``), no matter the =
device
> +ID, to further simplify reading and writing these attributes in the user=
space.
> +
> +Allow recording (allow_recording)
> +---------------------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/allow_recording``
> +
> +Controlled by parameter: ``allow_recording``
> +
> +Controls the "Allow recording" setting, which allows or blocks usage of =
the
> +built-in camera and microphone (boolean).
> +
> +Start on lid open (start_on_lid_open)
> +-------------------------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_open``
> +
> +Controls the "Start on lid open" setting, which sets the device to power=
 on
> +automatically when the lid is opened (boolean).
> +
> +USB charge (usb_charge)
> +-----------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/usb_charge``
> +
> +Controls the "USB charge" setting, which allows USB ports to provide pow=
er even
> +when the device is turned off (boolean).
> +
> +.. note::
> +  For most devices, this setting seems to only apply to the USB-C ports.
> +
> +
> +.. _keyboard-hotkey-actions:
> +
> +Keyboard hotkey actions (i8042 filter)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``i8042_filter``
> +
> +The i8042 filter will swallow the keyboard events for the Fn+F9 hotkey (=
Multi-
> +level keyboard backlight toggle) and Fn+F10 hotkey (Allow/block recordin=
g
> +toggle) and instead execute their actions within the driver itself.
> +
> +Fn+F9 will cycle through the brightness levels of the keyboard backlight=
=2E A
> +notification will be sent using ``led_classdev_notify_brightness_hw_chan=
ged``
> +so that the userspace can be aware of the change. This mimics the behavi=
or of
> +other existing devices where the brightness level is cycled internally b=
y the
> +embedded controller and then reported via a notification.
> +
> +Fn+F10 will toggle the value of the "Allow recording" setting.
> +
> +
> +ACPI notifications and ACPI hotkey actions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There is a new "Samsung Galaxy Book extra buttons" input device created =
which
> +will send input events for the following notifications from the ACPI dev=
ice:
> +
> +- Notification when the battery charge control end threshold has been re=
ached
> +  and the "battery saver" feature has stopped the battery from charging
> +- Notification when the device has been placed on a table (not available=
 on all
> +  models)
> +- Notification when the device has been lifted from a table (not availab=
le on
> +  all models)
> +
> +The Fn+F11 Performance mode hotkey is received as an ACPI notification. =
It will
> +be handled in a similar way as the Fn+F9 and Fn+F10 hotkeys; namely, tha=
t the
> +keypress will be swallowed by the driver and each press will cycle to th=
e next
> +available platform profile.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3809931b9..21b4fc504 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20733,6 +20733,12 @@ L:=09linux-fbdev@vger.kernel.org
>  S:=09Maintained
>  F:=09drivers/video/fbdev/s3c-fb.c
> =20
> +SAMSUNG GALAXY BOOK EXTRAS DRIVER
> +M:=09Joshua Grisham <josh@joshuagrisham.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +F:=09drivers/platform/x86/samsung-galaxybook.c
> +
>  SAMSUNG INTERCONNECT DRIVERS
>  M:=09Sylwester Nawrocki <s.nawrocki@samsung.com>
>  M:=09Artur =A6wigo=F1 <a.swigon@samsung.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879..b6d28b6a4 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -778,6 +778,25 @@ config BARCO_P50_GPIO
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called barco-p50-gpio.
> =20
> +config SAMSUNG_GALAXYBOOK
> +=09tristate "Samsung Galaxy Book extras driver"
> +=09depends on ACPI
> +=09depends on ACPI_BATTERY
> +=09depends on INPUT
> +=09depends on SERIO_I8042
> +=09depends on HWMON || HWMON =3D n
> +=09select ACPI_PLATFORM_PROFILE
> +=09select INPUT_SPARSEKMAP
> +=09select NEW_LEDS
> +=09select LEDS_CLASS
> +=09help
> +=09  This is a driver for Samsung Galaxy Book series notebooks. It adds
> +=09  support for the keyboard backlight control, performance mode contro=
l, fan
> +=09  speed reporting, function keys, and various other device controls.
> +
> +=09  For more information about this driver, see
> +=09  <file:Documentation/admin-guide/laptops/samsung-galaxybook.rst>.
> +
>  config SAMSUNG_LAPTOP
>  =09tristate "Samsung Laptop driver"
>  =09depends on RFKILL || RFKILL =3D n
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947..32ec4cb9d 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -95,8 +95,9 @@ obj-$(CONFIG_PCENGINES_APU2)=09+=3D pcengines-apuv2.o
>  obj-$(CONFIG_BARCO_P50_GPIO)=09+=3D barco-p50-gpio.o
> =20
>  # Samsung
> -obj-$(CONFIG_SAMSUNG_LAPTOP)=09+=3D samsung-laptop.o
> -obj-$(CONFIG_SAMSUNG_Q10)=09+=3D samsung-q10.o
> +obj-$(CONFIG_SAMSUNG_GALAXYBOOK)=09+=3D samsung-galaxybook.o
> +obj-$(CONFIG_SAMSUNG_LAPTOP)=09=09+=3D samsung-laptop.o
> +obj-$(CONFIG_SAMSUNG_Q10)=09=09+=3D samsung-q10.o
> =20
>  # Toshiba
>  obj-$(CONFIG_TOSHIBA_BT_RFKILL)=09+=3D toshiba_bluetooth.o
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform=
/x86/samsung-galaxybook.c
> new file mode 100644
> index 000000000..ce8b76d91
> --- /dev/null
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -0,0 +1,1972 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Samsung Galaxy Book series extras driver
> + *
> + * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
> + *
> + * With contributions to the SCAI ACPI device interface:
> + * Copyright (c) 2024 Giulio Girardi <giulio.girardi@protechgroup.it>
> + *
> + * Implementation inspired by existing x86 platform drivers.
> + * Thank you to the authors!
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/i8042.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/nls.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
> +#include <linux/serio.h>
> +#include <linux/workqueue.h>
> +#include <acpi/battery.h>
> +
> +#define SAMSUNG_GALAXYBOOK_CLASS  "samsung-galaxybook"
> +#define SAMSUNG_GALAXYBOOK_NAME   "Samsung Galaxy Book Extras"
> +
> +/*
> + * Module parameters
> + */
> +
> +static bool kbd_backlight =3D true;
> +static bool battery_threshold =3D true;
> +static bool performance_mode =3D true;
> +static bool allow_recording =3D true;
> +static bool fan_speed =3D true;
> +static bool i8042_filter =3D true;
> +
> +module_param(kbd_backlight, bool, 0644);
> +MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (defa=
ult on)");
> +module_param(battery_threshold, bool, 0644);
> +MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold con=
trol (default on)");
> +module_param(performance_mode, bool, 0644);
> +MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (def=
ault on)");
> +module_param(allow_recording, bool, 0644);
> +MODULE_PARM_DESC(allow_recording,
> +=09=09 "Enable control to allow or block access to camera and microphone=
 (default on)");
> +module_param(fan_speed, bool, 0644);
> +MODULE_PARM_DESC(fan_speed, "Enable fan speed (default on)");
> +module_param(i8042_filter, bool, 0644);
> +MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey events =
(default on)");
> +
> +/*
> + * Device definitions and matching
> + */
> +
> +static const struct acpi_device_id galaxybook_device_ids[] =3D {
> +=09{ "SAM0427" },
> +=09{ "SAM0428" },
> +=09{ "SAM0429" },
> +=09{ "SAM0430" },
> +=09{},
> +};
> +MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
> +
> +static const struct dmi_system_id galaxybook_dmi_ids[] =3D {
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +=09=09=09DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +=09=09},
> +=09},
> +=09{}
> +};
> +
> +struct galaxybook_fan {
> +=09struct acpi_device fan;
> +=09char *description;
> +=09bool supports_fst;
> +=09unsigned int *fan_speeds;
> +=09int fan_speeds_count;
> +=09struct dev_ext_attribute fan_speed_rpm_ext_attr;
> +};
> +
> +#define MAX_FAN_COUNT 5
> +
> +struct samsung_galaxybook {
> +=09struct platform_device *platform;
> +=09struct acpi_device *acpi;
> +
> +=09struct led_classdev kbd_backlight;
> +=09struct work_struct kbd_backlight_hotkey_work;
> +
> +=09struct input_dev *input;
> +=09struct key_entry *keymap;
> +
> +=09u8 *profile_performance_modes;
> +=09struct platform_profile_handler profile_handler;
> +=09struct work_struct performance_mode_hotkey_work;
> +
> +=09struct work_struct allow_recording_hotkey_work;
> +
> +=09struct galaxybook_fan fans[MAX_FAN_COUNT];
> +=09int fans_count;
> +
> +#if IS_ENABLED(CONFIG_HWMON)
> +=09struct device *hwmon;
> +#endif
> +};
> +static struct samsung_galaxybook *galaxybook_ptr;
> +
> +struct sawb {
> +=09u16 safn;
> +=09u16 sasb;
> +=09u8 rflg;
> +=09union {
> +=09=09struct {
> +=09=09=09u8 gunm;
> +=09=09=09u8 guds[250];
> +=09=09};
> +=09=09struct {
> +=09=09=09u8 caid[16];
> +=09=09=09u8 fncn;
> +=09=09=09u8 subn;
> +=09=09=09u8 iob0;
> +=09=09=09u8 iob1;
> +=09=09=09u8 iob2;
> +=09=09=09u8 iob3;
> +=09=09=09u8 iob4;
> +=09=09=09u8 iob5;
> +=09=09=09u8 iob6;
> +=09=09=09u8 iob7;
> +=09=09=09u8 iob8;
> +=09=09=09u8 iob9;
> +=09=09};
> +=09=09struct {
> +=09=09=09u8 iob_prefix[18];
> +=09=09=09u8 iob_values[10];
> +=09=09};
> +=09};
> +};
> +
> +#define SAWB_LEN_SETTINGS         0x15
> +#define SAWB_LEN_PERFORMANCE_MODE 0x100
> +
> +#define SAFN  0x5843
> +
> +#define SASB_KBD_BACKLIGHT     0x78
> +#define SASB_POWER_MANAGEMENT  0x7a
> +#define SASB_USB_CHARGE_GET    0x67
> +#define SASB_USB_CHARGE_SET    0x68
> +#define SASB_NOTIFICATIONS     0x86
> +#define SASB_ALLOW_RECORDING   0x8a
> +#define SASB_PERFORMANCE_MODE  0x91
> +
> +#define SAWB_RFLG_POS  4
> +#define SAWB_GUNM_POS  5
> +
> +#define RFLG_SUCCESS  0xaa
> +#define GUNM_FAIL     0xff
> +
> +#define GUNM_FEATURE_ENABLE          0xbb
> +#define GUNM_FEATURE_ENABLE_SUCCESS  0xdd
> +#define GUDS_FEATURE_ENABLE          0xaa
> +#define GUDS_FEATURE_ENABLE_SUCCESS  0xcc
> +
> +#define GUNM_GET  0x81
> +#define GUNM_SET  0x82
> +
> +#define GUNM_POWER_MANAGEMENT  0x82
> +
> +#define GUNM_USB_CHARGE_GET              0x80
> +#define GUNM_USB_CHARGE_ON               0x81
> +#define GUNM_USB_CHARGE_OFF              0x80
> +#define GUDS_START_ON_LID_OPEN           0xa3
> +#define GUDS_START_ON_LID_OPEN_GET       0x81
> +#define GUDS_START_ON_LID_OPEN_SET       0x80
> +#define GUDS_BATTERY_CHARGE_CONTROL      0xe9
> +#define GUDS_BATTERY_CHARGE_CONTROL_GET  0x91
> +#define GUDS_BATTERY_CHARGE_CONTROL_SET  0x90
> +#define GUNM_ACPI_NOTIFY_ENABLE          0x80
> +#define GUDS_ACPI_NOTIFY_ENABLE          0x02
> +
> +#define FNCN_PERFORMANCE_MODE       0x51
> +#define SUBN_PERFORMANCE_MODE_LIST  0x01
> +#define SUBN_PERFORMANCE_MODE_GET   0x02
> +#define SUBN_PERFORMANCE_MODE_SET   0x03
> +
> +/* guid 8246028d-8bca-4a55-ba0f-6f1e6b921b8f */
> +static const guid_t performance_mode_guid_value =3D
> +=09GUID_INIT(0x8246028d, 0x8bca, 0x4a55, 0xba, 0x0f, 0x6f, 0x1e, 0x6b, 0=
x92, 0x1b, 0x8f);
> +#define PERFORMANCE_MODE_GUID performance_mode_guid_value
> +
> +#define PERFORMANCE_MODE_ULTRA               0x16
> +#define PERFORMANCE_MODE_PERFORMANCE         0x15
> +#define PERFORMANCE_MODE_SILENT              0xb
> +#define PERFORMANCE_MODE_QUIET               0xa
> +#define PERFORMANCE_MODE_OPTIMIZED           0x2
> +#define PERFORMANCE_MODE_PERFORMANCE_LEGACY  0x1
> +#define PERFORMANCE_MODE_OPTIMIZED_LEGACY    0x0
> +#define PERFORMANCE_MODE_UNKNOWN             0xff
> +
> +#define DEFAULT_PLATFORM_PROFILE PLATFORM_PROFILE_BALANCED
> +
> +#define ACPI_METHOD_ENABLE           "SDLS"
> +#define ACPI_METHOD_ENABLE_ON        1
> +#define ACPI_METHOD_ENABLE_OFF       0
> +#define ACPI_METHOD_SETTINGS         "CSFI"
> +#define ACPI_METHOD_PERFORMANCE_MODE "CSXI"
> +
> +#define ACPI_FAN_DEVICE_ID    "PNP0C0B"
> +#define ACPI_FAN_SPEED_LIST   "FANT"
> +#define ACPI_FAN_SPEED_VALUE  "\\_SB.PC00.LPCB.H_EC.FANS"
> +
> +#define KBD_BACKLIGHT_MAX_BRIGHTNESS  3
> +
> +#define ACPI_NOTIFY_BATTERY_STATE_CHANGED    0x61
> +#define ACPI_NOTIFY_DEVICE_ON_TABLE          0x6c
> +#define ACPI_NOTIFY_DEVICE_OFF_TABLE         0x6d
> +#define ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE  0x70
> +
> +#define GB_KEY_KBD_BACKLIGHT_KEYDOWN    0x2c
> +#define GB_KEY_KBD_BACKLIGHT_KEYUP      0xac
> +#define GB_KEY_ALLOW_RECORDING_KEYDOWN  0x1f
> +#define GB_KEY_ALLOW_RECORDING_KEYUP    0x9f
> +
> +static const struct key_entry galaxybook_acpi_keymap[] =3D {
> +=09{ KE_KEY, ACPI_NOTIFY_BATTERY_STATE_CHANGED,   { KEY_BATTERY } },
> +=09{ KE_KEY, ACPI_NOTIFY_DEVICE_ON_TABLE,         { KEY_F14 } },
> +=09{ KE_KEY, ACPI_NOTIFY_DEVICE_OFF_TABLE,        { KEY_F15 } },
> +=09{ KE_KEY, ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE, { KEY_UNKNOWN } },
> +=09{ KE_END, 0 },
> +};
> +
> +/*
> + * ACPI method handling
> + */
> +
> +#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)
> +
> +#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len)=09\
> +=09do {=09=09=09=09=09=09=09=09\
> +=09=09pr_debug_prefixed("%s\n", header_str);=09=09=09\
> +=09=09print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",=09\

You can use pr_fmt() wrapping here so you don't need to hardcode the=20
prefix.

> +=09=09=09=09     DUMP_PREFIX_NONE, 16, 1, buf_ptr,=09\
> +=09=09=09=09     buf_len, false);=09=09=09\
> +=09} while (0)
> +
> +static char *get_acpi_device_description(struct acpi_device *acpi_dev)
> +{
> +=09struct acpi_buffer str_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09union acpi_object *str_obj;
> +=09struct acpi_buffer name_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };

Reverse xmas tree order is preferred (unless there's a good reason to=20
break it due to dependency).

> +=09acpi_status status;
> +=09int result;
> +
> +=09/* first try to get value of _STR (and also convert it to utf8)  */
> +=09if (!acpi_has_method(acpi_dev->handle, "_STR"))
> +=09=09goto use_name;
> +=09status =3D acpi_evaluate_object_typed(acpi_dev->handle, "_STR", NULL,
> +=09=09=09=09=09   &str_buf, ACPI_TYPE_BUFFER);
> +=09if (ACPI_SUCCESS(status) && str_buf.length > 0) {
> +=09=09str_obj =3D str_buf.pointer;
> +=09=09char *buf =3D kzalloc(sizeof(*buf) * str_obj->buffer.length, GFP_K=
ERNEL);

Don't mix variable declarations with, always put them first in the=20
block/function and leave blank line in between. There's only one exception=
=20
and that is using cleanup.h when ordering of the declarations matter but=20
that's the only exception (it's the reason why it's allowed at all).

> +=09=09result =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> +=09=09=09=09=09 str_obj->buffer.length,
> +=09=09=09=09=09 UTF16_LITTLE_ENDIAN, buf,
> +=09=09=09=09=09 PAGE_SIZE - 1);
> +=09=09kfree(str_obj);
> +=09=09if (result > 0)
> +=09=09=09return buf;
> +=09=09/* if no result then free buf */
> +=09=09kfree(buf);
> +=09}
> +
> +=09kfree(str_buf.pointer);
> +
> +use_name:
> +=09/* if _STR is missing then just use the device name */
> +=09status =3D acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &name_bu=
f);
> +=09if (ACPI_SUCCESS(status) && name_buf.length > 0)
> +=09=09return name_buf.pointer;
> +
> +=09kfree(name_buf.pointer);
> +
> +=09return NULL;
> +}
> +
> +static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook,=
 acpi_string method,
> +=09=09=09=09  struct sawb *buf, u32 len, const char *purpose_str,
> +=09=09=09=09  struct sawb *ret)
> +{
> +=09union acpi_object in_obj, *out_obj;
> +=09struct acpi_object_list input;
> +=09struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +=09acpi_status status;
> +
> +=09in_obj.type =3D ACPI_TYPE_BUFFER;
> +=09in_obj.buffer.length =3D len;
> +=09in_obj.buffer.pointer =3D (u8 *)buf;
> +
> +=09input.count =3D 1;
> +=09input.pointer =3D &in_obj;
> +
> +=09print_acpi_object_buffer_debug(purpose_str, in_obj.buffer.pointer, in=
_obj.buffer.length);
> +
> +=09status =3D acpi_evaluate_object(galaxybook->acpi->handle, method, &in=
put, &output);
> +
> +=09if (ACPI_FAILURE(status)) {
> +=09=09pr_err("failed %s with ACPI method %s; got %s\n", purpose_str, met=
hod,
> +=09=09       acpi_format_exception(status));

Use dev_err()

> +=09=09return status;
> +=09}
> +
> +=09out_obj =3D output.pointer;
> +
> +=09if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
> +=09=09pr_err("failed %s with ACPI method %s; response was not a buffer\n=
",
> +=09=09=09purpose_str, method);
> +=09=09status =3D -EIO;
> +=09=09goto out_free;
> +=09}
> +
> +=09print_acpi_object_buffer_debug("response was: ", out_obj->buffer.poin=
ter,
> +=09=09=09=09       out_obj->buffer.length);
> +
> +=09if (out_obj->buffer.length !=3D len) {
> +=09=09pr_err("failed %s with ACPI method %s; response length mismatch\n"=
,
> +=09=09       purpose_str, method);
> +=09=09status =3D -EIO;
> +=09=09goto out_free;
> +=09}
> +=09if (out_obj->buffer.length < SAWB_GUNM_POS + 1) {
> +=09=09pr_err("failed %s with ACPI method %s; response from device was to=
o short\n",
> +=09=09       purpose_str, method);
> +=09=09status =3D -EIO;
> +=09=09goto out_free;
> +=09}
> +=09if (out_obj->buffer.pointer[SAWB_RFLG_POS] !=3D RFLG_SUCCESS) {
> +=09=09pr_err("failed %s with ACPI method %s; "
> +=09=09       "device did not respond with success code 0x%x\n",
> +=09=09       purpose_str, method, RFLG_SUCCESS);
> +=09=09status =3D -EIO;
> +=09=09goto out_free;
> +=09}
> +=09if (out_obj->buffer.pointer[SAWB_GUNM_POS] =3D=3D GUNM_FAIL) {
> +=09=09pr_err("failed %s with ACPI method %s; device responded with failu=
re code 0x%x\n",
> +=09=09       purpose_str, method, GUNM_FAIL);
> +=09=09status =3D -EIO;
> +=09=09goto out_free;
> +=09}
> +
> +=09memcpy(ret, out_obj->buffer.pointer, len);

In kernel, ret is typically int so I suggest you pick some other name for=
=20
the variable (Yes, I went back to find out what the type is in this case).

> +
> +out_free:
> +=09kfree(output.pointer);
> +=09return status;
> +}
> +
> +static int galaxybook_enable_acpi_feature(struct samsung_galaxybook *gal=
axybook, const u16 sasb)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D sasb;
> +=09buf.gunm =3D GUNM_FEATURE_ENABLE;
> +=09buf.guds[0] =3D GUDS_FEATURE_ENABLE;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "enabling ACPI feature", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (buf.gunm !=3D GUNM_FEATURE_ENABLE_SUCCESS && buf.guds[0] !=3D GUD=
S_FEATURE_ENABLE_SUCCESS)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
> +/*
> + * Keyboard Backlight
> + */
> +
> +static int kbd_backlight_acpi_set(struct samsung_galaxybook *galaxybook,
> +=09=09=09=09  const enum led_brightness brightness)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_KBD_BACKLIGHT;
> +=09buf.gunm =3D GUNM_SET;
> +
> +=09buf.guds[0] =3D brightness;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "setting kbd_backlight brightness", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09galaxybook->kbd_backlight.brightness =3D brightness;
> +
> +=09pr_debug_prefixed("set kbd_backlight brightness to %d\n", brightness)=
;

Use dev_dbg() directly.

> +
> +=09return 0;
> +}
> +
> +static int kbd_backlight_acpi_get(struct samsung_galaxybook *galaxybook,
> +=09=09=09=09  enum led_brightness *brightness)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_KBD_BACKLIGHT;
> +=09buf.gunm =3D GUNM_GET;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "getting kbd_backlight brightness", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09*brightness =3D buf.gunm;
> +=09galaxybook->kbd_backlight.brightness =3D buf.gunm;
> +
> +=09pr_debug_prefixed("current kbd_backlight brightness is %d\n", buf.gun=
m);
> +
> +=09return 0;
> +}
> +
> +static int kbd_backlight_store(struct led_classdev *led,
> +=09=09=09       const enum led_brightness brightness)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D
> +=09=09container_of(led, struct samsung_galaxybook, kbd_backlight);
> +=09int err;
> +
> +=09err =3D kbd_backlight_acpi_set(galaxybook, brightness);
> +=09if (err)
> +=09=09return err;
> +
> +=09return 0;
> +}
> +
> +static enum led_brightness kbd_backlight_show(struct led_classdev *led)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D
> +=09=09container_of(led, struct samsung_galaxybook, kbd_backlight);
> +=09enum led_brightness brightness;
> +=09int err;
> +
> +=09err =3D kbd_backlight_acpi_get(galaxybook, &brightness);
> +=09if (err)
> +=09=09return err;
> +
> +=09return brightness;
> +}
> +
> +static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *gala=
xybook)
> +{
> +=09enum led_brightness brightness;
> +=09struct led_init_data init_data =3D {};
> +=09int err;
> +
> +=09err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_KBD_BACKLIGHT=
);
> +=09if (err)
> +=09=09return err;
> +
> +=09/* verify we can read the value, otherwise init should stop and fail =
*/
> +=09err =3D kbd_backlight_acpi_get(galaxybook, &brightness);
> +=09if (err)
> +=09=09return err;
> +
> +=09init_data.devicename =3D SAMSUNG_GALAXYBOOK_CLASS;
> +=09init_data.default_label =3D ":kbd_backlight";
> +=09init_data.devname_mandatory =3D true;
> +
> +=09galaxybook->kbd_backlight =3D (struct led_classdev){
> +=09=09.brightness_get =3D kbd_backlight_show,
> +=09=09.brightness_set_blocking =3D kbd_backlight_store,
> +=09=09.flags =3D LED_BRIGHT_HW_CHANGED,
> +=09=09.max_brightness =3D KBD_BACKLIGHT_MAX_BRIGHTNESS,
> +=09};
> +
> +=09pr_info("registering LED class using default name of %s:%s\n",
> +=09=09init_data.devicename, init_data.default_label);
> +
> +=09return led_classdev_register_ext(&galaxybook->platform->dev, &galaxyb=
ook->kbd_backlight,
> +=09=09=09=09=09 &init_data);
> +}
> +
> +static void galaxybook_kbd_backlight_exit(struct samsung_galaxybook *gal=
axybook)
> +{
> +=09led_classdev_unregister(&galaxybook->kbd_backlight);
> +}
> +
> +/*
> + * Platform device attributes (configuration properties which can be con=
trolled via userspace)
> + */
> +
> +/* Start on lid open (device should power on when lid is opened) */
> +
> +static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galaxyb=
ook, const bool value)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_POWER_MANAGEMENT;
> +=09buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +=09buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> +=09buf.guds[1] =3D GUDS_START_ON_LID_OPEN_SET;
> +=09buf.guds[2] =3D value;

This relies on bool -> u8 implicit conversion. While it probably works as=
=20
is, I'd prefer to make the conversion explicit with e.g. ?: operator (and=
=20
let the compiler optimize it if it wants to).

> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "setting start_on_lid_open", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09pr_debug_prefixed("turned start_on_lid_open %s\n", value ? "on (1)" :=
 "off (0)");

Use a helper from linux/string_choices.h.

I'd change it to:
=09dev_dbg(..., "start_on_lid_open %s\n", str_enabled_disabled(value));

> +
> +=09return 0;
> +}
> +
> +static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galaxyb=
ook, bool *value)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_POWER_MANAGEMENT;
> +=09buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +=09buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> +=09buf.guds[1] =3D GUDS_START_ON_LID_OPEN_GET;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "getting start_on_lid_open", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09*value =3D buf.guds[1];
> +
> +=09pr_debug_prefixed("start_on_lid_open is currently %s\n",
> +=09=09=09  (buf.guds[1] ? "on (1)" : "off (0)"));

I suspect a debug print like this is not going to be very useful. You get=
=20
the result right out of the sysfs anyway so why bother printing at all and
it's anyway not the raw value but synthetized on/off string.

> +
> +=09return 0;
> +}
> +
> +static ssize_t start_on_lid_open_store(struct device *dev, struct device=
_attribute *attr,
> +=09=09=09=09       const char *buffer, size_t count)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09if (!count || kstrtobool(buffer, &value))
> +=09=09return -EINVAL;
> +
> +=09err =3D start_on_lid_open_acpi_set(galaxybook, value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return count;
> +}
> +
> +static ssize_t start_on_lid_open_show(struct device *dev, struct device_=
attribute *attr,
> +=09=09=09=09      char *buffer)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(start_on_lid_open);
> +
> +/* USB Charge (USB ports can charge other devices even when device is po=
wered off) */
> +
> +static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, co=
nst bool value)

Don't leave empty line in between.

> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_USB_CHARGE_SET;
> +=09buf.gunm =3D value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "setting usb_charge", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09pr_debug_prefixed("turned usb_charge %s\n", value ? "on (1)" : "off (=
0)");
> +
> +=09return 0;
> +}
> +
> +static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, bo=
ol *value)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_USB_CHARGE_GET;
> +=09buf.gunm =3D GUNM_USB_CHARGE_GET;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "getting usb_charge", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09*value =3D buf.gunm;
> +
> +=09pr_debug_prefixed("usb_charge is currently %s\n", (buf.gunm ? "on (1)=
" : "off (0)"));
> +
> +=09return 0;
> +}
> +
> +static ssize_t usb_charge_store(struct device *dev, struct device_attrib=
ute *attr,
> +=09=09=09=09const char *buffer, size_t count)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09if (!count || kstrtobool(buffer, &value))
> +=09=09return -EINVAL;
> +
> +=09err =3D usb_charge_acpi_set(galaxybook, value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return count;
> +}
> +
> +static ssize_t usb_charge_show(struct device *dev, struct device_attribu=
te *attr, char *buffer)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09err =3D usb_charge_acpi_get(galaxybook, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(usb_charge);
> +
> +/* Allow recording (allows or blocks access to camera and microphone) */
> +
> +static int allow_recording_acpi_set(struct samsung_galaxybook *galaxyboo=
k, const bool value)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_ALLOW_RECORDING;
> +=09buf.gunm =3D GUNM_SET;
> +=09buf.guds[0] =3D value;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "setting allow_recording", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09pr_debug_prefixed("turned allow_recording %s\n", value ? "on (1)" : "=
off (0)");
> +
> +=09return 0;
> +}
> +
> +static int allow_recording_acpi_get(struct samsung_galaxybook *galaxyboo=
k, bool *value)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_ALLOW_RECORDING;
> +=09buf.gunm =3D GUNM_GET;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "getting allow_recording", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09*value =3D buf.gunm;
> +
> +=09pr_debug_prefixed("allow_recording is currently %s\n", (buf.gunm ? "o=
n (1)" : "off (0)"));

For some reason parenthesis are used in this while the others have been=20
w/o them (but use string_choices.h helpers anyway so that probably makes=20
the comment moot).

> +
> +=09return 0;
> +}
> +
> +static ssize_t allow_recording_store(struct device *dev, struct device_a=
ttribute *attr,
> +=09=09=09=09     const char *buffer, size_t count)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09if (!count || kstrtobool(buffer, &value))
> +=09=09return -EINVAL;
> +
> +=09err =3D allow_recording_acpi_set(galaxybook, value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return count;
> +}
> +
> +static ssize_t allow_recording_show(struct device *dev, struct device_at=
tribute *attr, char *buffer)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09err =3D allow_recording_acpi_get(galaxybook, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(allow_recording);
> +
> +/*
> + * Battery Extension (adds charge_control_end_threshold to the battery d=
evice)
> + */
> +
> +static int charge_control_end_threshold_acpi_set(struct samsung_galaxybo=
ok *galaxybook,
> +=09=09=09=09=09=09 const u8 value)

While certainly not forbidden, using const on plain integer types is not=20
extremely useful. In fact, if it wouldn't be const, you could do the 100=20
-> 0 mapping for it separately and not do it twice below.

> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09if (value > 100)
> +=09=09return -EINVAL;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_POWER_MANAGEMENT;
> +=09buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +=09buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
> +=09buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_SET;
> +
> +=09buf.guds[2] =3D (value =3D=3D 100 ? 0 : value); /* if setting to 100,=
 should be set to 0 (off) */

Put comment on line before it so it's easier to read.

"off" -> "no threshold" ?

> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "setting battery charge_control_end_threshold", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09pr_debug_prefixed("set battery charge_control_end_threshold to %d\n",
> +=09=09=09  (value =3D=3D 100 ? 0 : value));

Do you want to differentiate 0 from 0? Should this function actually=20
return -EINVAL if somebody attempts to set 0 threshold?

> +=09return 0;
> +}
> +
> +static int charge_control_end_threshold_acpi_get(struct samsung_galaxybo=
ok *galaxybook, u8 *value)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_POWER_MANAGEMENT;
> +=09buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +=09buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
> +=09buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_GET;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf=
, SAWB_LEN_SETTINGS,
> +=09=09=09=09     "getting battery charge_control_end_threshold", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09*value =3D buf.guds[1];
> +
> +=09pr_debug_prefixed("battery charge control is currently %s; "
> +=09=09=09  "battery charge_control_end_threshold is %d\n",
> +=09=09=09  (buf.guds[1] > 0 ? "on" : "off"), buf.guds[1]);
> +
> +=09return 0;
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev, st=
ruct device_attribute *attr,
> +=09=09=09=09=09=09  const char *buffer, size_t count)
> +{
> +=09u8 value;
> +=09int err;
> +
> +=09if (!count || kstrtou8(buffer, 0, &value))
> +=09=09return -EINVAL;
> +
> +=09err =3D charge_control_end_threshold_acpi_set(galaxybook_ptr, value);
> +=09if (err)
> +=09=09return err;
> +
> +=09return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev, str=
uct device_attribute *attr,
> +=09=09=09=09=09=09 char *buffer)
> +{
> +=09u8 value;
> +=09int err;
> +
> +=09err =3D charge_control_end_threshold_acpi_get(galaxybook_ptr, &value)=
;
> +=09if (err)
> +=09=09return err;
> +
> +=09return sysfs_emit(buffer, "%d\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +
> +static int galaxybook_battery_add(struct power_supply *battery, struct a=
cpi_battery_hook *hook)
> +{
> +=09if (device_create_file(&battery->dev, &dev_attr_charge_control_end_th=
reshold))
> +=09=09return -ENODEV;
> +=09return 0;
> +}
> +
> +static int galaxybook_battery_remove(struct power_supply *battery, struc=
t acpi_battery_hook *hook)
> +{
> +=09device_remove_file(&battery->dev, &dev_attr_charge_control_end_thresh=
old);
> +=09return 0;
> +}
> +
> +static struct acpi_battery_hook galaxybook_battery_hook =3D {
> +=09.add_battery =3D galaxybook_battery_add,
> +=09.remove_battery =3D galaxybook_battery_remove,
> +=09.name =3D "Samsung Galaxy Book Battery Extension",
> +};
> +
> +static int galaxybook_battery_threshold_init(struct samsung_galaxybook *=
galaxybook)
> +{
> +=09u8 value;
> +=09int err;
> +
> +=09err =3D charge_control_end_threshold_acpi_get(galaxybook, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09battery_hook_register(&galaxybook_battery_hook);
> +=09return 0;
> +}
> +
> +static void galaxybook_battery_threshold_exit(struct samsung_galaxybook =
*galaxybook)
> +{
> +=09battery_hook_unregister(&galaxybook_battery_hook);
> +}
> +
> +/*
> + * Fan speed
> + */
> +
> +static int fan_speed_get_fst(struct galaxybook_fan *fan, unsigned int *s=
peed)
> +{
> +=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09union acpi_object *response_obj =3D NULL;
> +=09acpi_status status;
> +=09int ret =3D 0;
> +
> +=09status =3D acpi_evaluate_object(fan->fan.handle, "_FST", NULL, &respo=
nse);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09pr_err("Get fan state failed\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09response_obj =3D response.pointer;
> +=09if (!response_obj || response_obj->type !=3D ACPI_TYPE_PACKAGE ||
> +=09    response_obj->package.count !=3D 3 ||
> +=09    response_obj->package.elements[2].type !=3D ACPI_TYPE_INTEGER) {
> +=09=09pr_err("Invalid _FST data\n");
> +=09=09ret =3D -EINVAL;
> +=09=09goto out_free;
> +=09}
> +
> +=09*speed =3D response_obj->package.elements[2].integer.value;
> +
> +=09pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d\n",
> +=09=09=09  dev_name(&fan->fan.dev), fan->description, *speed);
> +
> +out_free:
> +=09ACPI_FREE(response.pointer);
> +=09return ret;

You're mixing err and ret within a file as the error/return code variable.=
=20
It would be nice to be consistent within a file.

> +}
> +
> +static int fan_speed_get_fans(struct galaxybook_fan *fan, unsigned int *=
speed)
> +{
> +=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09union acpi_object *response_obj =3D NULL;
> +=09acpi_status status;
> +=09int ret =3D 0;
> +=09int speed_level =3D -1;
> +
> +=09status =3D acpi_evaluate_object(NULL, ACPI_FAN_SPEED_VALUE, NULL, &re=
sponse);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09pr_err("Get fan state failed\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09response_obj =3D response.pointer;
> +=09if (!response_obj || response_obj->type !=3D ACPI_TYPE_INTEGER ||
> +=09    response_obj->integer.value > INT_MAX ||

I don't know what's the logic behind doing bound check here but not in the=
=20
previous function.

> +=09    (int)response_obj->integer.value > fan->fan_speeds_count) {
> +=09=09pr_err("invalid fan speed data\n");
> +=09=09ret =3D -EINVAL;
> +=09=09goto out_free;
> +=09}
> +
> +=09speed_level =3D (int)response_obj->integer.value;
> +=09*speed =3D fan->fan_speeds[speed_level];
> +
> +=09pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d (leve=
l %d)\n",
> +=09=09=09  dev_name(&fan->fan.dev), fan->description, *speed, speed_leve=
l);
> +
> +out_free:
> +=09ACPI_FREE(response.pointer);
> +=09return ret;
> +}
> +
> +static int fan_speed_get(struct galaxybook_fan *fan, unsigned int *speed=
)
> +{
> +=09if (!fan)
> +=09=09return -ENODEV;
> +=09if (fan->supports_fst)
> +=09=09return fan_speed_get_fst(fan, speed);
> +=09else
> +=09=09return fan_speed_get_fans(fan, speed);
> +}
> +
> +static ssize_t fan_speed_rpm_show(struct device *dev, struct device_attr=
ibute *attr, char *buffer)
> +{
> +=09struct dev_ext_attribute *ea =3D container_of(attr, struct dev_ext_at=
tribute, attr);
> +=09struct galaxybook_fan *fan =3D ea->var;
> +=09unsigned int speed;
> +=09int ret =3D 0;

Unnecessary init.

> +
> +=09if (!fan)
> +=09=09return -ENODEV;
> +
> +=09ret =3D fan_speed_get(fan, &speed);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return sysfs_emit(buffer, "%u\n", speed);
> +}
> +
> +static int __init fan_speed_list_init(acpi_handle handle, struct galaxyb=
ook_fan *fan)
> +{
> +=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09union acpi_object *response_obj =3D NULL;
> +=09acpi_status status;
> +=09unsigned int speed;
> +=09int i;
> +
> +=09status =3D acpi_evaluate_object(handle, ACPI_FAN_SPEED_LIST, NULL, &r=
esponse);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09pr_err("failed to read fan speed list\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09response_obj =3D response.pointer;
> +=09if (!response_obj || response_obj->type !=3D ACPI_TYPE_PACKAGE ||
> +=09    response_obj->package.count =3D=3D 0) {
> +=09=09pr_err("invalid fan speed list data\n");
> +=09=09status =3D -EINVAL;
> +=09=09goto out_free;
> +=09}
> +
> +=09/*
> +=09 * fan_speeds[] starts with a hard-coded 0 (fan is off), then has som=
e "funny" logic:
> +=09 *  - fetch the speed level values read in from FANT and add 0x0a to =
each value
> +=09 *  - _FST method in the DSDT seems to indicate that level 3 and 4 sh=
ould have same value,
> +=09 *    however real-life observation suggests that the speed actually =
does change
> +=09 *  - _FST says that level 5 should give the 4th value from FANT but =
it seems significantly
> +=09 *    louder -- we will just "guess" it is 1000 RPM faster than the h=
ighest value from FANT?
> +=09 */
> +
> +=09fan->fan_speeds =3D kzalloc(sizeof(unsigned int) * (response_obj->pac=
kage.count + 2),

kcalloc()

> +=09=09=09=09  GFP_KERNEL);
> +=09if (!fan->fan_speeds)
> +=09=09return -ENOMEM;
> +
> +=09/* hard-coded "off" value (0) */
> +=09fan->fan_speeds[0] =3D 0;

Name with a define and drop the comment?

> +=09fan->fan_speeds_count =3D 1;
> +
> +=09/* fetch and assign the next values from FANT response */
> +=09i =3D 0;

Does nothing.

> +=09for (i =3D 1; i <=3D response_obj->package.count; i++) {
> +=09=09if (response_obj->package.elements[i - 1].type !=3D ACPI_TYPE_INTE=
GER) {
> +=09=09=09pr_err("invalid fan speed list value at position %d; "
> +=09=09=09       "expected type %d, got type %d\n",
> +=09=09=09       i - 1, ACPI_TYPE_INTEGER,
> +=09=09=09       response_obj->package.elements[i - 1].type);
> +=09=09=09status =3D -EINVAL;
> +=09=09=09goto err_fan_speeds_free;
> +=09=09}
> +=09=09fan->fan_speeds[i] =3D response_obj->package.elements[i - 1].integ=
er.value + 0x0a;

Add a local variable to avoid repeating response_obj->package.elements[i - =
1] ?

> +=09=09fan->fan_speeds_count++;
> +=09}
> +
> +=09/* add the missing final level where we "guess" 1000 RPM faster than =
highest from FANT */

Fold comments at 80 chars.

> +=09if (fan->fan_speeds_count > 1) {
> +=09=09fan->fan_speeds[i] =3D fan->fan_speeds[i - 1] + 1000;
> +=09=09fan->fan_speeds_count++;
> +=09}
> +
> +=09/* test that it actually works to read the speed, otherwise the init =
should fail */
> +=09status =3D fan_speed_get_fans(fan, &speed);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09pr_err("failed to read fan speed level from FANS\n");
> +=09=09goto err_fan_speeds_free;
> +=09}
> +
> +=09pr_info("initialized fan speed reporting for device %s (%s) with the =
following levels:\n",
> +=09=09dev_name(&fan->fan.dev), fan->description);
> +=09for (i =3D 0; i < fan->fan_speeds_count; i++)
> +=09=09pr_info("  %s (%s) fan speed level %d =3D %d\n",
> +=09=09=09dev_name(&fan->fan.dev), fan->description, i, fan->fan_speeds[i=
]);

On successful probe, the driver should not print anything.

> +
> +out_free:
> +=09ACPI_FREE(response.pointer);
> +=09return status;
> +
> +err_fan_speeds_free:
> +=09kfree(fan->fan_speeds);
> +=09goto out_free;
> +}
> +
> +static acpi_status galaxybook_add_fan(acpi_handle handle, u32 level, voi=
d *context,
> +=09=09=09=09      void **return_value)
> +{
> +=09struct acpi_device *adev =3D acpi_fetch_acpi_dev(handle);
> +=09struct samsung_galaxybook *galaxybook =3D context;
> +=09struct galaxybook_fan *fan;
> +=09int speed =3D -1;
> +
> +=09pr_info("found fan device %s\n", dev_name(&adev->dev));
> +
> +=09/* if fan meets acpi4 fan device requirements, assume it is added alr=
eady under ACPI */
> +=09if (acpi_has_method(handle, "_FIF") &&
> +=09    acpi_has_method(handle, "_FPS") &&
> +=09    acpi_has_method(handle, "_FSL") &&
> +=09    acpi_has_method(handle, "_FST")) {
> +=09=09pr_info("fan device %s should already be available as an ACPI fan;=
 skipping\n",
> +=09=09=09dev_name(&adev->dev));
> +=09=09return 0;
> +=09}
> +
> +=09if (galaxybook->fans_count >=3D MAX_FAN_COUNT) {
> +=09=09pr_err("maximum number of %d fans has already been reached\n", MAX=
_FAN_COUNT);
> +=09=09return 0;
> +=09}
> +
> +=09fan =3D &galaxybook->fans[galaxybook->fans_count];
> +=09fan->fan =3D *adev;
> +=09fan->description =3D get_acpi_device_description(&fan->fan);
> +
> +=09/* try to get speed from _FST */
> +=09if (ACPI_FAILURE(fan_speed_get_fst(fan, &speed))) {
> +=09=09pr_debug_prefixed("_FST is present but failed on fan device %s (%s=
); "
> +=09=09=09=09  "will attempt to add fan speed support using FANT and FANS=
\n",
> +=09=09=09=09  dev_name(&fan->fan.dev), fan->description);
> +=09=09fan->supports_fst =3D false;
> +=09}
> +=09/* if speed was 0 and FANT and FANS exist, they should be used anyway=
 due to bugs in ACPI */
> +=09else if (speed <=3D 0 &&
> +=09=09 acpi_has_method(handle, ACPI_FAN_SPEED_LIST) &&
> +=09=09 acpi_has_method(NULL, ACPI_FAN_SPEED_VALUE)) {
> +=09=09pr_debug_prefixed("_FST is present on fan device %s (%s) but retur=
ned value of 0; "
> +=09=09=09=09  "will attempt to add fan speed support using FANT and FANS=
\n",
> +=09=09=09=09  dev_name(&fan->fan.dev), fan->description);
> +=09=09fan->supports_fst =3D false;
> +=09} else {
> +=09=09fan->supports_fst =3D true;
> +=09}
> +
> +=09if (!fan->supports_fst) {
> +=09=09/* since FANS is a field on the EC, it does not make sense to use =
more than once */
> +=09=09for (int i =3D 0; i < galaxybook->fans_count; i++) {
> +=09=09=09if (!galaxybook->fans[i].supports_fst) {
> +=09=09=09=09pr_err("more than one fan using FANS is not supported\n");
> +=09=09=09=09return 0;
> +=09=09=09}
> +=09=09}
> +=09=09if (ACPI_FAILURE(fan_speed_list_init(handle, fan))) {
> +=09=09=09pr_err("unable to initialize fan speeds for fan device %s (%s)\=
n",
> +=09=09=09       dev_name(&fan->fan.dev), fan->description);
> +=09=09=09return 0;
> +=09=09}
> +=09} else {
> +=09=09pr_info("initialized fan speed reporting for device %s (%s) using =
method _FST\n",
> +=09=09=09dev_name(&fan->fan.dev), fan->description);
> +=09}
> +
> +=09/* set up RO dev_ext_attribute */
> +=09fan->fan_speed_rpm_ext_attr.attr.attr.name =3D "fan_speed_rpm";
> +=09fan->fan_speed_rpm_ext_attr.attr.attr.mode =3D 0444;
> +=09fan->fan_speed_rpm_ext_attr.attr.show =3D fan_speed_rpm_show;
> +=09/* extended attribute var points to this galaxybook_fan so it can use=
d in the show method */
> +=09fan->fan_speed_rpm_ext_attr.var =3D fan;
> +
> +=09if (sysfs_create_file(&adev->dev.kobj, &fan->fan_speed_rpm_ext_attr.a=
ttr.attr))
> +=09=09pr_err("unable to create fan_speed_rpm attribute for fan device %s=
 (%s)\n",
> +=09=09       dev_name(&fan->fan.dev), fan->description);

You can use is_visible function to decide which sysfs files are shown so=20
you don't need to do the manual sysfs handling like this per fan.

But why you need this whole dev_ext_attribute thing in the first place?

> +=09galaxybook->fans_count++;
> +
> +=09return 0;
> +}
> +
> +static int __init galaxybook_fan_speed_init(struct samsung_galaxybook *g=
alaxybook)
> +{
> +=09acpi_status status;
> +
> +=09/* get and set up all fans matching ACPI_FAN_DEVICE_ID */
> +=09status =3D acpi_get_devices(ACPI_FAN_DEVICE_ID, galaxybook_add_fan, g=
alaxybook, NULL);
> +
> +=09if (galaxybook->fans_count =3D=3D 0)
> +=09=09return -ENODEV;
> +
> +=09return status;
> +}
> +
> +static void galaxybook_fan_speed_exit(struct samsung_galaxybook *galaxyb=
ook)
> +{
> +=09for (int i =3D 0; i < galaxybook->fans_count; i++)
> +=09=09sysfs_remove_file(&galaxybook->fans[i].fan.dev.kobj,
> +=09=09=09=09  &galaxybook->fans[i].fan_speed_rpm_ext_attr.attr.attr);
> +}
> +
> +/*
> + * Hwmon device
> + */
> +
> +#if IS_ENABLED(CONFIG_HWMON)
> +static umode_t galaxybook_hwmon_is_visible(const void *drvdata, enum hwm=
on_sensor_types type,
> +=09=09=09=09=09   u32 attr, int channel)
> +{
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09if (channel < galaxybook_ptr->fans_count &&
> +=09=09    (attr =3D=3D hwmon_fan_input || attr =3D=3D hwmon_fan_label))
> +=09=09=09return 0444;
> +=09=09return 0;
> +=09default:
> +=09=09return 0;
> +=09}
> +}
> +
> +static int galaxybook_hwmon_read(struct device *dev, enum hwmon_sensor_t=
ypes type,
> +=09=09=09=09 u32 attr, int channel, long *val)
> +{
> +=09unsigned int speed;
> +
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09if (channel < galaxybook_ptr->fans_count && attr =3D=3D hwmon_fan_=
input) {
> +=09=09=09if (fan_speed_get(&galaxybook_ptr->fans[channel], &speed))
> +=09=09=09=09return -EIO;
> +=09=09=09*val =3D speed;
> +=09=09=09return 0;
> +=09=09}
> +=09=09return -EOPNOTSUPP;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +}
> +
> +static int galaxybook_hwmon_read_string(struct device *dev, enum hwmon_s=
ensor_types type,
> +=09=09=09=09=09u32 attr, int channel, const char **str)
> +{
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09if (channel < galaxybook_ptr->fans_count && attr =3D=3D hwmon_fan_=
label) {
> +=09=09=09*str =3D galaxybook_ptr->fans[channel].description;
> +=09=09=09return 0;
> +=09=09}
> +=09=09return -EOPNOTSUPP;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +}
> +
> +static const struct hwmon_ops galaxybook_hwmon_ops =3D {
> +=09.is_visible =3D galaxybook_hwmon_is_visible,
> +=09.read =3D galaxybook_hwmon_read,
> +=09.read_string =3D galaxybook_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info *const galaxybook_hwmon_info[] =
=3D {
> +=09/* note: number of max possible fan channel entries here should match=
 MAX_FAN_COUNT */
> +=09HWMON_CHANNEL_INFO(fan,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL),
> +=09NULL
> +};
> +
> +static const struct hwmon_chip_info galaxybook_hwmon_chip_info =3D {
> +=09.ops =3D &galaxybook_hwmon_ops,
> +=09.info =3D galaxybook_hwmon_info,
> +};
> +
> +static int galaxybook_hwmon_init(struct samsung_galaxybook *galaxybook)
> +{
> +=09int ret =3D 0;
> +

No empty lines in between variable declarations.

> +=09char *hwmon_device_name =3D devm_hwmon_sanitize_name(&galaxybook->pla=
tform->dev,
> +=09=09=09=09=09=09=09   SAMSUNG_GALAXYBOOK_CLASS);

Declare variable separately since you have to split the line.

> +=09galaxybook->hwmon =3D devm_hwmon_device_register_with_info(
> +=09=09&galaxybook->platform->dev, hwmon_device_name, NULL,
> +=09=09&galaxybook_hwmon_chip_info, NULL);
> +=09if (PTR_ERR_OR_ZERO(galaxybook->hwmon)) {
> +=09=09ret =3D PTR_ERR(galaxybook->hwmon);
> +=09=09galaxybook->hwmon =3D NULL;
> +=09}
> +
> +=09return ret;
> +}
> +
> +static void galaxybook_hwmon_exit(struct samsung_galaxybook *galaxybook)
> +{
> +=09if (galaxybook->hwmon)
> +=09=09hwmon_device_unregister(galaxybook->hwmon);
> +}
> +#endif
> +
> +/*
> + * Platform Profile / Performance mode
> + */
> +
> +static int performance_mode_acpi_set(struct samsung_galaxybook *galaxybo=
ok,
> +=09=09=09=09     const u8 performance_mode)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_PERFORMANCE_MODE;
> +=09export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +=09buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +=09buf.subn =3D SUBN_PERFORMANCE_MODE_SET;
> +=09buf.iob0 =3D performance_mode;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MO=
DE, &buf,
> +=09=09=09=09     SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", =
&buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09return 0;
> +}
> +
> +static int performance_mode_acpi_get(struct samsung_galaxybook *galaxybo=
ok, u8 *performance_mode)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_PERFORMANCE_MODE;
> +=09export_guid(buf.caid, &PERFORMANCE_MODE_GUID);

Add linux/uuid.h

> +=09buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +=09buf.subn =3D SUBN_PERFORMANCE_MODE_GET;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MO=
DE, &buf,
> +=09=09=09=09     SAWB_LEN_PERFORMANCE_MODE, "getting performance_mode", =
&buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09*performance_mode =3D buf.iob0;
> +
> +=09return 0;
> +}
> +
> +static enum platform_profile_option
> +profile_performance_mode(struct samsung_galaxybook *galaxybook, const u8=
 performance_mode)
> +{
> +=09for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> +=09=09if (galaxybook->profile_performance_modes[i] =3D=3D performance_mo=
de)
> +=09=09=09return i;
> +=09return -1;

Returning value that is not part of enum looks a bit hacky.

> +}
> +
> +/* copied from platform_profile.c; better if this could be fetched from =
a public function, maybe? */

You are allowed to propose patches in the patch series for things you=20
need. :-)

> +static const char *const profile_names[] =3D {
> +=09[PLATFORM_PROFILE_LOW_POWER] =3D "low-power",
> +=09[PLATFORM_PROFILE_COOL] =3D "cool",
> +=09[PLATFORM_PROFILE_QUIET] =3D "quiet",
> +=09[PLATFORM_PROFILE_BALANCED] =3D "balanced",
> +=09[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
> +=09[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +};
> +static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);

Is this assert compatible with the custom platform profile series that is=
=20
practically ready to be merged?

> +static int galaxybook_platform_profile_set(struct platform_profile_handl=
er *pprof,
> +=09=09=09=09=09   enum platform_profile_option profile)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D
> +=09=09container_of(pprof, struct samsung_galaxybook, profile_handler);
> +=09int err;
> +
> +=09err =3D performance_mode_acpi_set(galaxybook, galaxybook->profile_per=
formance_modes[profile]);
> +=09if (err)
> +=09=09return err;
> +
> +=09pr_debug_prefixed("set platform profile to '%s' (performance mode 0x%=
x)\n",
> +=09=09=09  profile_names[profile], galaxybook->profile_performance_modes=
[profile]);
> +=09return 0;
> +}
> +
> +static int galaxybook_platform_profile_get(struct platform_profile_handl=
er *pprof,
> +=09=09=09=09=09   enum platform_profile_option *profile)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D
> +=09=09container_of(pprof, struct samsung_galaxybook, profile_handler);
> +=09u8 performance_mode;
> +=09int err;
> +
> +=09err =3D performance_mode_acpi_get(galaxybook, &performance_mode);
> +=09if (err)
> +=09=09return err;
> +
> +=09*profile =3D profile_performance_mode(galaxybook, performance_mode);
> +=09if (*profile =3D=3D -1)
> +=09=09return -EINVAL;
> +
> +=09pr_debug_prefixed("platform profile is currently '%s' (performance mo=
de 0x%x)\n",
> +=09=09=09  profile_names[*profile], performance_mode);
> +
> +=09return 0;
> +}
> +
> +#define IGNORE_PERFORMANCE_MODE_MAPPING  -1
> +
> +static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook=
)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int mode_profile, err;
> +=09u8 current_performance_mode;
> +
> +=09galaxybook->profile_handler.profile_get =3D galaxybook_platform_profi=
le_get;
> +=09galaxybook->profile_handler.profile_set =3D galaxybook_platform_profi=
le_set;
> +
> +=09/* fetch supported performance mode values from ACPI method */
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_PERFORMANCE_MODE;
> +=09export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +=09buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +=09buf.subn =3D SUBN_PERFORMANCE_MODE_LIST;
> +
> +=09err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MO=
DE,
> +=09=09=09=09     &buf, SAWB_LEN_PERFORMANCE_MODE,
> +=09=09=09=09     "get supported performance modes", &buf);
> +=09if (err)
> +=09=09return err;
> +
> +=09/* set up profile_performance_modes with "unknown" as init value */
> +=09galaxybook->profile_performance_modes =3D
> +=09=09kzalloc(sizeof(u8) * PLATFORM_PROFILE_LAST, GFP_KERNEL);

kcalloc() ?

> +=09if (!galaxybook->profile_performance_modes)
> +=09=09return -ENOMEM;
> +=09for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> +=09=09galaxybook->profile_performance_modes[i] =3D PERFORMANCE_MODE_UNKN=
OWN;
> +
> +=09/*
> +=09 * Value returned in iob0 will have the number of supported performan=
ce modes.
> +=09 * The performance mode values will then be given as a list after thi=
s (iob1-iobX).
> +=09 * Loop backwards from last value to first value (to handle fallback =
cases which come with
> +=09 * smaller values) and map each supported value to its correct platfo=
rm_profile_option.
> +=09 */
> +=09err =3D -ENODEV; /* set err to "no device" to signal that we have not=
 yet mapped profiles */
> +=09for (int i =3D buf.iob0; i > 0; i--) {
> +=09=09/*
> +=09=09 * Prefer mapping to at least performance, balanced, and low-power=
 profiles, as they
> +=09=09 * are the profiles which are typically supported by userspace too=
ls
> +=09=09 * (power-profiles-daemon, etc).
> +=09=09 * - performance =3D "ultra", otherwise "performance"
> +=09=09 * - balanced    =3D "optimized", otherwise "performance" when "ul=
tra" is supported
> +=09=09 * - low-power   =3D "silent", otherwise "quiet"
> +=09=09 * Different models support different modes. Additional supported =
modes will be
> +=09=09 * mapped to profiles that fall in between these 3.
> +=09=09 */
> +=09=09switch (buf.iob_values[i]) {
> +
> +=09=09case PERFORMANCE_MODE_ULTRA:
> +=09=09=09/* ultra always maps to performance */
> +=09=09=09mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +=09=09=09break;
> +
> +=09=09case PERFORMANCE_MODE_PERFORMANCE:
> +=09=09=09/* if ultra exists, map performance to balanced-performance */
> +=09=09=09if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERF=
ORMANCE] !=3D
> +=09=09=09    PERFORMANCE_MODE_UNKNOWN)
> +=09=09=09=09mode_profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +=09=09=09else /* otherwise map it to performance instead */
> +=09=09=09=09mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +=09=09=09break;
> +
> +=09=09case PERFORMANCE_MODE_SILENT:
> +=09=09=09/* silent always maps to low-power */
> +=09=09=09mode_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +=09=09=09break;
> +
> +=09=09case PERFORMANCE_MODE_QUIET:
> +=09=09=09/* if silent exists, map quiet to quiet */
> +=09=09=09if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_LOW_=
POWER] !=3D
> +=09=09=09    PERFORMANCE_MODE_UNKNOWN)
> +=09=09=09=09mode_profile =3D PLATFORM_PROFILE_QUIET;
> +=09=09=09else /* otherwise map it to low-power for better userspace tool=
 support */
> +=09=09=09=09mode_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +=09=09=09break;
> +
> +=09=09case PERFORMANCE_MODE_OPTIMIZED:
> +=09=09=09/* optimized always maps to balanced */
> +=09=09=09mode_profile =3D PLATFORM_PROFILE_BALANCED;
> +=09=09=09break;
> +
> +=09=09case PERFORMANCE_MODE_PERFORMANCE_LEGACY:
> +=09=09=09/* map to performance if performance is not already supported *=
/
> +=09=09=09if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERF=
ORMANCE] =3D=3D
> +=09=09=09    PERFORMANCE_MODE_UNKNOWN)
> +=09=09=09=09mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +=09=09=09else /* otherwise, ignore */
> +=09=09=09=09mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +=09=09=09break;
> +
> +=09=09case PERFORMANCE_MODE_OPTIMIZED_LEGACY:
> +=09=09=09/* map to balanced if balanced is not already supported */
> +=09=09=09if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_BALA=
NCED] =3D=3D
> +=09=09=09    PERFORMANCE_MODE_UNKNOWN)
> +=09=09=09=09mode_profile =3D PLATFORM_PROFILE_BALANCED;
> +=09=09=09else /* otherwise, ignore */
> +=09=09=09=09mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +=09=09=09break;
> +
> +=09=09default: /* any other value is not supported */
> +=09=09=09mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +=09=09=09break;
> +=09=09}
> +
> +=09=09/* if current mode value mapped to a supported platform_profile_op=
tion, set it up */
> +=09=09if (mode_profile > IGNORE_PERFORMANCE_MODE_MAPPING) {
> +=09=09=09err =3D 0; /* clear err to signal that at least one profile is =
now mapped */
> +=09=09=09galaxybook->profile_performance_modes[mode_profile] =3D buf.iob=
_values[i];
> +=09=09=09set_bit(mode_profile, galaxybook->profile_handler.choices);
> +=09=09=09pr_info("will support platform profile '%s' (performance mode 0=
x%x)\n",
> +=09=09=09=09profile_names[mode_profile], buf.iob_values[i]);
> +=09=09} else {
> +=09=09=09pr_debug_prefixed("unmapped performance mode 0x%x will be ignor=
ed\n",
> +=09=09=09=09=09  buf.iob_values[i]);
> +=09=09}
> +=09}
> +
> +=09/* if no performance modes were mapped (err is still -ENODEV) then st=
op and fail here */
> +=09if (err)
> +=09=09return err;

It would be much more obvious to count number of mapped modes with a=20
variable and not play with err variable like this. You needed lots of=20
comment to explain which all could be dropped and this could just return=20
-ENODEV directly.

I'll stop here as I'm out of time.

--=20
 i.

> +=09err =3D platform_profile_register(&galaxybook->profile_handler);
> +=09if (err)
> +=09=09return err;
> +
> +=09/* now check currently set performance mode; if not supported then se=
t default profile */
> +=09err =3D performance_mode_acpi_get(galaxybook, &current_performance_mo=
de);
> +=09if (err)
> +=09=09pr_warn("failed with code %d when fetching initial performance mod=
e\n", err);
> +=09if (profile_performance_mode(galaxybook, current_performance_mode) =
=3D=3D -1) {
> +=09=09pr_debug_prefixed("initial performance mode value is not supported=
 by device; "
> +=09=09=09=09  "setting to default\n");
> +=09=09err =3D galaxybook_platform_profile_set(&galaxybook->profile_handl=
er,
> +=09=09=09=09=09=09      DEFAULT_PLATFORM_PROFILE);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void galaxybook_profile_exit(struct samsung_galaxybook *galaxyboo=
k)
> +{
> +=09platform_profile_remove();
> +}
> +
> +/*
> + * Hotkey work and filters
> + */
> +
> +static void galaxybook_performance_mode_hotkey_work(struct work_struct *=
work)
> +{
> +=09platform_profile_cycle();
> +}
> +
> +static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *wor=
k)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D
> +=09=09container_of(work, struct samsung_galaxybook, kbd_backlight_hotkey=
_work);
> +
> +=09if (galaxybook->kbd_backlight.brightness < galaxybook->kbd_backlight.=
max_brightness)
> +=09=09kbd_backlight_acpi_set(galaxybook, galaxybook->kbd_backlight.brigh=
tness + 1);
> +=09else
> +=09=09kbd_backlight_acpi_set(galaxybook, 0);
> +
> +=09led_classdev_notify_brightness_hw_changed(
> +=09=09&galaxybook->kbd_backlight,
> +=09=09galaxybook->kbd_backlight.brightness);
> +}
> +
> +static void galaxybook_allow_recording_hotkey_work(struct work_struct *w=
ork)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D
> +=09=09container_of(work, struct samsung_galaxybook, allow_recording_hotk=
ey_work);
> +=09bool value;
> +
> +=09allow_recording_acpi_get(galaxybook, &value);
> +=09allow_recording_acpi_set(galaxybook, !value);
> +}
> +
> +static bool galaxybook_i8042_filter(unsigned char data, unsigned char st=
r, struct serio *port)
> +{
> +=09static bool extended;
> +
> +=09if (str & I8042_STR_AUXDATA)
> +=09=09return false;
> +
> +=09if (unlikely(data =3D=3D 0xe0)) {
> +=09=09extended =3D true;
> +=09=09return true;
> +=09} else if (unlikely(extended)) {
> +=09=09extended =3D false;
> +=09=09switch (data) {
> +
> +=09=09case GB_KEY_KBD_BACKLIGHT_KEYDOWN:
> +=09=09=09return true;
> +=09=09case GB_KEY_KBD_BACKLIGHT_KEYUP:
> +=09=09=09if (kbd_backlight)
> +=09=09=09=09schedule_work(&galaxybook_ptr->kbd_backlight_hotkey_work);
> +=09=09=09return true;
> +
> +=09=09case GB_KEY_ALLOW_RECORDING_KEYDOWN:
> +=09=09=09return true;
> +=09=09case GB_KEY_ALLOW_RECORDING_KEYUP:
> +=09=09=09if (allow_recording)
> +=09=09=09=09schedule_work(&galaxybook_ptr->allow_recording_hotkey_work);
> +=09=09=09return true;
> +
> +=09=09default:
> +=09=09=09/*
> +=09=09=09 * Report the previously filtered e0 before continuing
> +=09=09=09 * with the next non-filtered byte.
> +=09=09=09 */
> +=09=09=09serio_interrupt(port, 0xe0, 0);
> +=09=09=09return false;
> +=09=09}
> +=09}
> +
> +=09return false;
> +}
> +
> +/*
> + * Input device (hotkeys and notifications)
> + */
> +
> +static void galaxybook_input_notify(struct samsung_galaxybook *galaxyboo=
k, int event)
> +{
> +=09if (!galaxybook->input)
> +=09=09return;
> +=09pr_debug_prefixed("input notification event: 0x%x\n", event);
> +=09if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
> +=09=09pr_warn("unknown input notification event: 0x%x\n", event);
> +}
> +
> +static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
> +{
> +=09struct input_dev *input;
> +=09int error;
> +
> +=09input =3D input_allocate_device();
> +=09if (!input)
> +=09=09return -ENOMEM;
> +
> +=09input->name =3D "Samsung Galaxy Book Extra Buttons";
> +=09input->phys =3D SAMSUNG_GALAXYBOOK_CLASS "/input0";
> +=09input->id.bustype =3D BUS_HOST;
> +=09input->dev.parent =3D &galaxybook->platform->dev;
> +
> +=09error =3D sparse_keymap_setup(input, galaxybook_acpi_keymap, NULL);
> +=09if (error) {
> +=09=09pr_err("Unable to setup input device keymap\n");
> +=09=09goto err_free_dev;
> +=09}
> +=09error =3D input_register_device(input);
> +=09if (error) {
> +=09=09pr_err("Unable to register input device\n");
> +=09=09goto err_free_dev;
> +=09}
> +
> +=09galaxybook->input =3D input;
> +=09return 0;
> +
> +err_free_dev:
> +=09input_free_device(input);
> +=09return error;
> +}
> +
> +static void galaxybook_input_exit(struct samsung_galaxybook *galaxybook)
> +{
> +=09if (galaxybook->input)
> +=09=09input_unregister_device(galaxybook->input);
> +=09galaxybook->input =3D NULL;
> +}
> +
> +/*
> + * Platform device attributes
> + */
> +
> +/* galaxybook_attrs can include start_on_lid_open, usb_charge, and/or al=
low_recording */
> +#define MAX_NUM_DEVICE_ATTRIBUTES 3
> +
> +static struct attribute *galaxybook_attrs[MAX_NUM_DEVICE_ATTRIBUTES + 1]=
 =3D { NULL };
> +static const struct attribute_group galaxybook_attrs_group =3D {
> +=09.attrs =3D galaxybook_attrs,
> +};
> +
> +static int galaxybook_device_attrs_init(struct samsung_galaxybook *galax=
ybook)
> +{
> +=09bool value;
> +=09int err;
> +=09int i =3D 0;
> +
> +=09/* attempt to get each attribute's value and add them if the get does=
 not fail */
> +
> +=09err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +=09if (err)
> +=09=09pr_debug_prefixed("failed to get start_on_lid_open value; "
> +=09=09=09=09  "this feature will not be enabled\n");
> +=09else
> +=09=09galaxybook_attrs[i++] =3D &dev_attr_start_on_lid_open.attr;
> +
> +=09err =3D usb_charge_acpi_get(galaxybook, &value);
> +=09if (err)
> +=09=09pr_debug_prefixed("failed to get usb_charge value; "
> +=09=09=09=09  "this feature will not be enabled\n");
> +=09else
> +=09=09galaxybook_attrs[i++] =3D &dev_attr_usb_charge.attr;
> +
> +=09if (allow_recording) {
> +=09=09pr_debug_prefixed("initializing ACPI allow_recording feature\n");
> +=09=09err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECO=
RDING);
> +=09=09if (err) {
> +=09=09=09pr_debug_prefixed("failed to initialize ACPI allow_recording fe=
ature\n");
> +=09=09=09allow_recording =3D false;
> +=09=09=09return 0;
> +=09=09}
> +
> +=09=09err =3D allow_recording_acpi_get(galaxybook, &value);
> +=09=09if (err) {
> +=09=09=09pr_debug_prefixed("failed to get allow_recording value; "
> +=09=09=09=09=09  "this feature will not be enabled\n");
> +=09=09=09allow_recording =3D false;
> +=09=09} else {
> +=09=09=09galaxybook_attrs[i++] =3D &dev_attr_allow_recording.attr;
> +=09=09}
> +=09}
> +
> +=09return device_add_group(&galaxybook->platform->dev, &galaxybook_attrs=
_group);
> +};
> +
> +static void galaxybook_device_attrs_exit(struct samsung_galaxybook *gala=
xybook)
> +{
> +=09device_remove_group(&galaxybook->platform->dev, &galaxybook_attrs_gro=
up);
> +}
> +
> +/*
> + * ACPI device setup
> + */
> +
> +static void galaxybook_acpi_notify(acpi_handle handle, u32 event, void *=
data)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D data;
> +
> +=09if (event =3D=3D ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
> +=09=09pr_debug_prefixed("hotkey: performance_mode keydown\n");
> +=09=09if (performance_mode) {
> +=09=09=09schedule_work(&galaxybook->performance_mode_hotkey_work);
> +=09=09=09return;
> +=09=09}
> +=09}
> +
> +=09galaxybook_input_notify(galaxybook, event);
> +}
> +
> +static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *gala=
xybook)
> +{
> +=09struct sawb buf =3D { 0 };
> +=09int err;
> +
> +=09err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_NOTIFICATIONS=
);
> +=09if (err)
> +=09=09return err;
> +
> +=09buf.safn =3D SAFN;
> +=09buf.sasb =3D SASB_NOTIFICATIONS;
> +=09buf.gunm =3D GUNM_ACPI_NOTIFY_ENABLE;
> +=09buf.guds[0] =3D GUDS_ACPI_NOTIFY_ENABLE;
> +
> +=09return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +=09=09=09=09      "activate ACPI notifications", &buf);
> +}
> +
> +static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
> +{
> +=09return acpi_execute_simple_method(galaxybook->acpi->handle,
> +=09=09=09=09=09  ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_ON);
> +}
> +
> +static void galaxybook_acpi_exit(struct samsung_galaxybook *galaxybook)
> +{
> +=09acpi_execute_simple_method(galaxybook->acpi->handle,
> +=09=09=09=09   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
> +}
> +
> +/*
> + * Platform driver
> + */
> +
> +static int galaxybook_probe(struct platform_device *pdev)
> +{
> +=09struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
> +=09struct samsung_galaxybook *galaxybook;
> +=09acpi_status status;
> +=09int err;
> +
> +=09dmi_check_system(galaxybook_dmi_ids);
> +
> +=09pr_info("found matched device %s; loading driver\n", dev_name(&adev->=
dev));
> +
> +=09galaxybook =3D kzalloc(sizeof(struct samsung_galaxybook), GFP_KERNEL)=
;
> +=09if (!galaxybook)
> +=09=09return -ENOMEM;
> +=09/* set static pointer here so it can be used in various methods for h=
otkeys, hwmon, etc */
> +=09galaxybook_ptr =3D galaxybook;
> +
> +=09galaxybook->platform =3D pdev;
> +=09galaxybook->acpi =3D adev;
> +
> +=09dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
> +
> +=09pr_debug_prefixed("initializing ACPI device\n");
> +=09err =3D galaxybook_acpi_init(galaxybook);
> +=09if (err) {
> +=09=09pr_err("failed to initialize the ACPI device\n");
> +=09=09goto err_free;
> +=09}
> +
> +=09pr_debug_prefixed("initializing ACPI power management features\n");
> +=09err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEM=
ENT);
> +=09if (err) {
> +=09=09pr_warn("failed to initialize ACPI power management features; "
> +=09=09=09"many features of this driver will not be available\n");
> +=09=09performance_mode =3D false;
> +=09=09battery_threshold =3D false;
> +=09}
> +
> +=09if (performance_mode) {
> +=09=09pr_debug_prefixed("initializing performance mode and platform prof=
ile\n");
> +=09=09err =3D galaxybook_profile_init(galaxybook);
> +=09=09if (err) {
> +=09=09=09pr_debug_prefixed(
> +=09=09=09=09"failed to initialize performance mode and platform profile\=
n");
> +=09=09=09performance_mode =3D false;
> +=09=09}
> +=09} else {
> +=09=09pr_debug_prefixed("performance_mode is disabled\n");
> +=09}
> +
> +=09if (battery_threshold) {
> +=09=09pr_debug_prefixed("initializing battery charge threshold control\n=
");
> +=09=09err =3D galaxybook_battery_threshold_init(galaxybook);
> +=09=09if (err) {
> +=09=09=09pr_debug_prefixed(
> +=09=09=09=09"failed to initialize battery charge threshold control\n");
> +=09=09=09battery_threshold =3D false;
> +=09=09}
> +=09} else {
> +=09=09pr_debug_prefixed("battery_threshold is disabled\n");
> +=09}
> +
> +=09pr_debug_prefixed("adding platform device attributes\n");
> +=09err =3D galaxybook_device_attrs_init(galaxybook);
> +=09if (err)
> +=09=09pr_err("failed to add platform device attributes\n");
> +
> +=09if (kbd_backlight) {
> +=09=09pr_debug_prefixed("initializing kbd_backlight\n");
> +=09=09err =3D galaxybook_kbd_backlight_init(galaxybook);
> +=09=09if (err) {
> +=09=09=09pr_debug_prefixed("failed to initialize kbd_backlight\n");
> +=09=09=09kbd_backlight =3D false;
> +=09=09}
> +=09} else {
> +=09=09pr_debug_prefixed("kbd_backlight is disabled\n");
> +=09}
> +
> +=09if (fan_speed) {
> +=09=09pr_debug_prefixed("initializing fan speed\n");
> +=09=09err =3D galaxybook_fan_speed_init(galaxybook);
> +=09=09if (err) {
> +=09=09=09pr_debug_prefixed("failed to initialize fan speed\n");
> +=09=09=09fan_speed =3D false;
> +=09=09} else {
> +#if IS_ENABLED(CONFIG_HWMON)
> +=09=09=09pr_debug_prefixed("initializing hwmon device\n");
> +=09=09=09err =3D galaxybook_hwmon_init(galaxybook);
> +=09=09=09if (err)
> +=09=09=09=09pr_warn("failed to initialize hwmon device\n");
> +#endif
> +=09=09}
> +=09} else {
> +=09=09pr_debug_prefixed("fan_speed is disabled\n");
> +=09}
> +
> +=09/* i8042_filter should be disabled if kbd_backlight and allow_recordi=
ng are disabled */
> +=09if (!kbd_backlight && !allow_recording)
> +=09=09i8042_filter =3D false;
> +
> +=09if (i8042_filter) {
> +=09=09pr_debug_prefixed("installing i8402 key filter to capture hotkey i=
nput\n");
> +
> +=09=09/* initialize hotkey work queues */
> +=09=09if (kbd_backlight)
> +=09=09=09INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
> +=09=09=09=09  galaxybook_kbd_backlight_hotkey_work);
> +=09=09if (allow_recording)
> +=09=09=09INIT_WORK(&galaxybook->allow_recording_hotkey_work,
> +=09=09=09=09  galaxybook_allow_recording_hotkey_work);
> +
> +=09=09err =3D i8042_install_filter(galaxybook_i8042_filter);
> +=09=09if (err) {
> +=09=09=09pr_err("failed to install i8402 key filter\n");
> +=09=09=09cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +=09=09=09cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +=09=09=09i8042_filter =3D false;
> +=09=09}
> +=09} else {
> +=09=09pr_debug_prefixed("i8042_filter is disabled\n");
> +=09}
> +
> +=09pr_debug_prefixed("installing ACPI notify handler\n");
> +=09status =3D acpi_install_notify_handler(galaxybook->acpi->handle, ACPI=
_ALL_NOTIFY,
> +=09=09=09=09=09     galaxybook_acpi_notify, galaxybook);
> +=09if (ACPI_SUCCESS(status)) {
> +=09=09pr_debug_prefixed("enabling ACPI notifications\n");
> +=09=09err =3D galaxybook_enable_acpi_notify(galaxybook);
> +=09=09if (err) {
> +=09=09=09pr_warn("failed to enable ACPI notifications; "
> +=09=09=09=09"some hotkeys will not be supported\n");
> +=09=09} else {
> +=09=09=09/* initialize ACPI hotkey work queues */
> +=09=09=09INIT_WORK(&galaxybook->performance_mode_hotkey_work,
> +=09=09=09=09  galaxybook_performance_mode_hotkey_work);
> +
> +=09=09=09pr_debug_prefixed("initializing input device\n");
> +=09=09=09err =3D galaxybook_input_init(galaxybook);
> +=09=09=09if (err) {
> +=09=09=09=09pr_err("failed to initialize input device\n");
> +=09=09=09=09cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> +=09=09=09=09galaxybook_input_exit(galaxybook);
> +=09=09=09}
> +=09=09}
> +=09} else {
> +=09=09pr_debug_prefixed("failed to install ACPI notify handler\n");
> +=09}
> +
> +=09pr_info("driver successfully loaded\n");
> +
> +=09return 0;
> +
> +err_free:
> +=09kfree(galaxybook);
> +=09return err;
> +}
> +
> +static void galaxybook_remove(struct platform_device *pdev)
> +{
> +=09struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(&pdev->dev)=
;
> +
> +=09pr_info("removing driver\n");
> +
> +=09galaxybook_device_attrs_exit(galaxybook);
> +
> +=09galaxybook_input_exit(galaxybook);
> +=09cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> +
> +=09if (i8042_filter) {
> +=09=09i8042_remove_filter(galaxybook_i8042_filter);
> +=09=09cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +=09=09cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +=09}
> +
> +=09acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> +=09=09=09=09   galaxybook_acpi_notify);
> +
> +=09if (fan_speed) {
> +=09=09galaxybook_fan_speed_exit(galaxybook);
> +#if IS_ENABLED(CONFIG_HWMON)
> +=09=09galaxybook_hwmon_exit(galaxybook);
> +#endif
> +=09}
> +
> +=09if (kbd_backlight)
> +=09=09galaxybook_kbd_backlight_exit(galaxybook);
> +
> +=09if (battery_threshold)
> +=09=09galaxybook_battery_threshold_exit(galaxybook);
> +
> +=09if (performance_mode)
> +=09=09galaxybook_profile_exit(galaxybook);
> +
> +=09galaxybook_acpi_exit(galaxybook);
> +
> +=09if (galaxybook_ptr)
> +=09=09galaxybook_ptr =3D NULL;
> +
> +=09kfree(galaxybook);
> +
> +=09pr_info("driver successfully removed\n");
> +}
> +
> +static struct platform_driver galaxybook_platform_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D SAMSUNG_GALAXYBOOK_CLASS,
> +=09=09.acpi_match_table =3D galaxybook_device_ids,
> +=09},
> +=09.probe =3D galaxybook_probe,
> +=09.remove =3D galaxybook_remove,
> +};
> +
> +static int __init samsung_galaxybook_init(void)
> +{
> +=09return platform_driver_register(&galaxybook_platform_driver);
> +}
> +
> +static void __exit samsung_galaxybook_exit(void)
> +{
> +=09platform_driver_unregister(&galaxybook_platform_driver);
> +}
> +
> +module_init(samsung_galaxybook_init);
> +module_exit(samsung_galaxybook_exit);
> +
> +MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
> +MODULE_DESCRIPTION(SAMSUNG_GALAXYBOOK_NAME);
> +MODULE_LICENSE("GPL");
>=20
--8323328-845421102-1733765605=:938--

