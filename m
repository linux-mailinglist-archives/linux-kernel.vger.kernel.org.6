Return-Path: <linux-kernel+bounces-293121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB543957AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F551B23D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5D1B7F4;
	Tue, 20 Aug 2024 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="iAUNKNa6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264202E83F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117474; cv=none; b=W1AQt5m2oEx3e3Ew4uuvJV3ZUh39ZS0RQFKIs72vQsuud/2Y1T0nredxj92hK1hc3Kyu3POh0b2huT5x3WrQ8sLrvDgSZOAD2pWaGTpYmtplNQsi/n4QX3gr+FNimI5lvUsxwnzz72iTeP64nR7BdnHydfBjIZ85TFwtwPAPErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117474; c=relaxed/simple;
	bh=ENK84xtbXBVn9kp5pd3O3iNs5Fc/94dx3O4lR6PNclI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=X/8Fq771OD4FSW/iqQoue/3FyYImHlZyVCafC8Xv44xDoEfPvE9zsWLbclbV2mBqRDdXQUblsYK2i0UEnPuf7h+MbGBc7rrdRSeTJklitc71Tb272bPVCK0HJBoO3VTe7X0Y7s87szypkQrUdmXE4cDJkPwGTPSVEwmFaRWCJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=iAUNKNa6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724117467; x=1724722267; i=efault@gmx.de;
	bh=rGc3NFjdQPmDht8i1OYQqEApRTTBS1nXM6XOint3zx4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iAUNKNa6Lt3Id4xdr8dsNJ1FRdTGKumAZ8rfJbWbiLjWjelSwZhY+QimbrvklCi+
	 bbIcKIRRFTDurVHke01oM/Y9DqkXc9cvxdZUaSsopODN6CfKyvbeS+ebVUb4K+GgA
	 nmF2ENbU4BaZpGPGmA7StTZynE2Csij0kjJIVjU51L+hFXeU72HYkAfGuqBNsH2fZ
	 OdZ8WQ605h8cslqmiOh/T+ZsTOu9io4XmvuqVPo8PyD0pxLZXnR+WNBuJNR81FFVw
	 wR5wDH+2mSWKJkjFN41jAjdo93TTm3tx75+8EuXAaTGauzNi/JX4WcQBqG9GvGsHE
	 q+zwwVl3aqCRX+ZjFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1sGTgU0wa5-00nqZx; Tue, 20
 Aug 2024 03:31:07 +0200
Message-ID: <af56820e03d9a52a472ec914a17310d11f8d0227.camel@gmx.de>
Subject: regression: 9eac534db001 ("firmware/sysfb: Set firmware-framebuffer
 parent device") broke nomodeset boot?
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 20 Aug 2024 03:31:06 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0yXI+7vevk0jWPhSkCWaVmunAVuLX4dkEG0FJJlJwf0MUEFmiZQ
 s+eLo5j/fThJCi2RKsgu2VbKNyfDkLkDsIvgmxiyQ3U9ZUMfVWmry4RZeGJQQ0X5uLj55j2
 gZ+ZNZt4OdZKwcf8iKZpeDGS/24+rXmcDfWAdZECRCypwVuUgDX3TU1XcHtBnHe2wviJMtp
 wmTomFmkgX27MHf/4bYqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ukSe/b5CZ9A=;ULRbPz2bsWGiq+xcBw6FzeeOlFm
 SB+IfnrUSnxBm5r3IAoOH2BTw91qkzhBr1rjbS2899cvcZoeMNy1azw/4m+k++QfUB7LBFWbE
 tFxCAOPFxVfUKMnvoLnY7zHDntI2JCbtJelP0spvQxF4IEgVt5awdZoNuM+vf85X8QIyc3nU/
 gbMOsfUkl2KK0QGoQS4EzB6OJpFSaXpBBu82Nw/1ET02k6GIOPC73JyWlF5tCEoAAtd9Gmu/U
 xwfZ9JE7FrZFD70Ew7zvt6WCjOJDLabX2V9b4CiWrRsk1B8Mg8mbvJzp6XJYU0XjkzdsoEYZy
 RVWCEjDnL43XhkFopaofhjQTuHCWgSky8gY4BpeTQt+KSWxK0dno36p2nMjRmc0RiM1U8wKPl
 sged7i+4oW5LMwU8Af9Mzz/zauGWT7NPXLd4BJgSGncNlPkEvtkctz2fGLDCxuWvotAHhSDRp
 pfjA2HtJpjmsYNB6Sy3N66og93QJ8VpA021NK1NlOKo4IIucYEpR9s0I1XY8DAsv1LomXHgIF
 qAd7TUHeavp8GXyCxG0e2b/39wLcOgm2+zN5fVA9cG8TKajn+JK40bhj+YeNk9/tSX1lS670T
 82S4ifPybZbwnB/l455NPthNdYQ6J1+qRBTtK+xgX97hSX553t/4gzCq1y0fhGbJzDptv+Qhx
 sIj4FJeaJoycMN5H+bzgY+8BligTN/cE5gSeJxBMuqUnhVVs0WY6EjWRF7DZEzPdn6XDAJ+34
 4INpLcgKUSuDYNq2lgdRv+ohQIuPHmlU4ylF56Cxy7nLn7lJF0TM4ltnjFAm/nwIz9VB7EoKy
 WwFiYNYYpdU+0aHGUE4sm4jA==

Greetings,

I normally use nouveau so I can suspend, but it's horrid for RT, so
when doing RT latency tracing, I boot with nomodeset.  Yesterday I
decided to check out master-rt cyclictest numbers, but found that X
will no longer start, tracked it back to a v6.9 issue, then bisected
v6.8..v6.9, which fingered $subject.

I haven't yet tried reverting the series the fingered commit is part
of, but did try turning on CONFIG_SYSFB_SIMPLEFB/CONFIG_FB_SIMPLE, and
even the once upon a time used CONFIG_FB_NVIDIA for grins, but alas,
config twiddling did not revive fbdev X.

nomodeset/fbdev X nogo=3D=3D>go startup log diff:
=2D-- yy	2024-08-20 02:40:05.003271212 +0200
+++ xx	2024-08-20 02:39:06.532061201 +0200
@@ -1,9 +1,9 @@
- (--) Log file renamed from "/var/log/Xorg.pid-2439.log" to "/var/log/Xor=
g.0.log"
+ (--) Log file renamed from "/var/log/Xorg.pid-2298.log" to "/var/log/Xor=
g.0.log"

 X.Org X Server 1.21.1.4
 X Protocol Version 11, Revision 0
- Current Operating System: Linux homer 6.9.12-stable #6 SMP Mon Aug 19 09=
:53:59 CEST 2024 x86_64
- Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.9.12-stable root=3DUUI=
D=3D891c2a1f-cc1a-464b-a529-ab6add65aa21 scsi_mod.use_blk_mq=3D1 ftrace_du=
mp_on_oops skew_tick=3D1 nortsched nodelayacct nowatchdog audit=3D0 mitiga=
tions=3Doff noresume panic=3D60 ignore_loglevel showopts crashkernel=3D204=
M nomodeset
+ Current Operating System: Linux homer 6.8.12-stable #7 SMP Mon Aug 19 11=
:12:36 CEST 2024 x86_64
+ Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.8.12-stable root=3DUUI=
D=3D891c2a1f-cc1a-464b-a529-ab6add65aa21 scsi_mod.use_blk_mq=3D1 ftrace_du=
mp_on_oops skew_tick=3D1 nortsched nodelayacct nowatchdog audit=3D0 mitiga=
tions=3Doff noresume panic=3D60 ignore_loglevel showopts crashkernel=3D204=
M nomodeset

  Current version of pixman: 0.40.0
  	Before reporting problems, check http://wiki.x.org
@@ -11,7 +11,7 @@ X Protocol Version 11, Revision 0
  Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
 	(++) from command line, (!!) notice, (II) informational,
 	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
- (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Tue Aug 20 02:33:32 2024
+ (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Tue Aug 20 02:30:29 2024
  (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
  (=3D=3D) Using system config directory "/usr/share/X11/xorg.conf.d"
  (=3D=3D) No Layout section.  Using the first Screen section.
@@ -40,7 +40,7 @@ X Protocol Version 11, Revision 0
  (WW) Ignoring unrecognized extension "XFree86-DGA"
  (II) The server relies on udev to provide the list of input devices.
 	If no devices become available, reconfigure udev or disable AutoAddDevic=
es.
- (II) Loader magic: 0x556d72b5ede0
+ (II) Loader magic: 0x56547fcffde0
  (II) Module ABI versions:
  	X.Org ANSI C Emulation: 0.4
  	X.Org Video Driver: 25.2
@@ -111,20 +111,282 @@ X Protocol Version 11, Revision 0
  (II) Module fbdevhw: vendor=3D"X.Org Foundation"
  	compiled for 1.21.1.4, module version =3D 0.0.2
  	ABI class: X.Org Video Driver, version 25.2
- vesa: Refusing to run, Framebuffer or dri device present
+ (II) FBDEV(2): using default device
  (EE) Screen 0 deleted because of no matching config section.
  (II) UnloadModule: "modesetting"
  (EE) Screen 0 deleted because of no matching config section.
  (II) UnloadModule: "fbdev"
  (II) UnloadSubModule: "fbdevhw"
- (EE) Device(s) detected, but none match those in the config file.
- (EE)
-Fatal server error:
- (EE) no screens found(EE)
- (EE)
-Please consult the The X.Org Foundation support
-	 at http://wiki.x.org
- for help.
- (EE) Please also check the log file at "/var/log/Xorg.0.log" for additio=
nal information.
- (EE)
- (EE) Server terminated with error (1). Closing log file.
+ (II) FBDEV(0): Creating default Display subsection in Screen section
+	"Default Screen Section" for depth/fbbpp 24/32
+ (=3D=3D) FBDEV(0): Depth 24, (=3D=3D) framebuffer bpp 32
+ (=3D=3D) FBDEV(0): RGB weight 888
+ (=3D=3D) FBDEV(0): Default visual is TrueColor
+ (=3D=3D) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
+ (II) FBDEV(0): hardware: EFI VGA (video memory: 8640kB)
+ (DB) xf86MergeOutputClassOptions unsupported bus type 0
+ (II) FBDEV(0): checking modes against framebuffer device...
+ (II) FBDEV(0): checking modes against monitor...
+ (II) FBDEV(0): Virtual size is 1920x1080 (pitch 1920)
+ (**) FBDEV(0):  Built-in mode "current": 207.4 MHz, 85.3 kHz, 77.2 Hz
+ (II) FBDEV(0): Modeline "current"x0.0  207.38  1920 1952 2192 2432  1080=
 1084 1088 1104 -hsync -vsync -csync (85.3 kHz b)
+ (=3D=3D) FBDEV(0): DPI set to (96, 96)
+ (II) Loading sub module "fb"
+ (II) LoadModule: "fb"
+ (II) Module "fb" already built-in
+ (**) FBDEV(0): using shadow framebuffer
+ (II) Loading sub module "shadow"
+ (II) LoadModule: "shadow"
+ (II) Loading /usr/lib64/xorg/modules/libshadow.so
+ (II) Module shadow: vendor=3D"X.Org Foundation"
+ 	compiled for 1.21.1.4, module version =3D 1.1.0
+ 	ABI class: X.Org ANSI C Emulation, version 0.4
+ (II) UnloadModule: "vesa"
+ (II) Unloading vesa
+ (II) FBDEV(0): FBIOBLANK: Invalid argument (Screen blanking not supporte=
d by kernel - disabling)
+ (=3D=3D) FBDEV(0): Backing store enabled
+ (=3D=3D) FBDEV(0): DPMS enabled
+ (II) Initializing extension Generic Event Extension
+ (II) Initializing extension SHAPE
+ (II) Initializing extension MIT-SHM
+ (II) Initializing extension XInputExtension
+ (II) Initializing extension XTEST
+ (II) Initializing extension BIG-REQUESTS
+ (II) Initializing extension SYNC
+ (II) Initializing extension XKEYBOARD
+ (II) Initializing extension XC-MISC
+ (II) Initializing extension SECURITY
+ (II) Initializing extension XFIXES
+ (II) Initializing extension RENDER
+ (II) Initializing extension RANDR
+ (II) Initializing extension COMPOSITE
+ (II) Initializing extension DAMAGE
+ (II) Initializing extension MIT-SCREEN-SAVER
+ (II) Initializing extension DOUBLE-BUFFER
+ (II) Initializing extension RECORD
+ (II) Initializing extension DPMS
+ (II) Initializing extension Present
+ (II) Initializing extension DRI3
+ (II) Initializing extension X-Resource
+ (II) Initializing extension XVideo
+ (II) Initializing extension XVideo-MotionCompensation
+ (II) Initializing extension GLX
+ (II) AIGLX: Screen 0 is not DRI2 capable
+ (II) IGLX: Loaded and initialized swrast
+ (II) GLX: Initialized DRISWRAST GL provider for screen 0
+ (II) Initializing extension XFree86-VidModeExtension
+ (II) Initializing extension XFree86-DGA
+ (II) Initializing extension XFree86-DRI
+ (II) Initializing extension DRI2
+ (II) config/udev: Adding input device Power Button (/dev/input/event1)
+ (**) Power Button: Applying InputClass "evdev keyboard catchall"
+ (**) Power Button: Applying InputClass "libinput keyboard catchall"
+ (**) Power Button: Applying InputClass "system-keyboard"
+ (II) LoadModule: "libinput"
+ (II) Loading /usr/lib64/xorg/modules/input/libinput_drv.so
+ (II) Module libinput: vendor=3D"X.Org Foundation"
+ 	compiled for 1.21.1.4, module version =3D 1.2.1
+ 	Module class: X.Org XInput Driver
+ 	ABI class: X.Org XInput driver, version 24.4
+ (II) Using input driver 'libinput' for 'Power Button'
+ (**) Power Button: always reports core events
+ (**) Option "Device" "/dev/input/event1"
+ (II) event1  - Power Button: is tagged by udev as: Keyboard
+ (II) event1  - Power Button: device is a keyboard
+ (II) event1  - Power Button: device removed
+ (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXPWRBN:00/inp=
ut/input1/event1"
+ (II) XINPUT: Adding extended input device "Power Button" (type: KEYBOARD=
, id 6)
+ (**) Option "xkb_model" "pc105"
+ (**) Option "xkb_layout" "de"
+ (**) Option "xkb_variant" "nodeadkeys"
+ (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
+ (II) event1  - Power Button: is tagged by udev as: Keyboard
+ (II) event1  - Power Button: device is a keyboard
+ (II) config/udev: Adding input device Power Button (/dev/input/event0)
+ (**) Power Button: Applying InputClass "evdev keyboard catchall"
+ (**) Power Button: Applying InputClass "libinput keyboard catchall"
+ (**) Power Button: Applying InputClass "system-keyboard"
+ (II) Using input driver 'libinput' for 'Power Button'
+ (**) Power Button: always reports core events
+ (**) Option "Device" "/dev/input/event0"
+ (II) event0  - Power Button: is tagged by udev as: Keyboard
+ (II) event0  - Power Button: device is a keyboard
+ (II) event0  - Power Button: device removed
+ (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0C0C:00/input/input0/event0"
+ (II) XINPUT: Adding extended input device "Power Button" (type: KEYBOARD=
, id 7)
+ (**) Option "xkb_model" "pc105"
+ (**) Option "xkb_layout" "de"
+ (**) Option "xkb_variant" "nodeadkeys"
+ (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
+ (II) event0  - Power Button: is tagged by udev as: Keyboard
+ (II) event0  - Power Button: device is a keyboard
+ (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=3D3 (/dev/i=
nput/event9)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=3D7 (/dev/i=
nput/event10)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=3D8 (/dev/i=
nput/event11)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=3D9 (/dev/i=
nput/event12)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device GASIA PS2toUSB Adapter (/dev/input=
/event2)
+ (**) GASIA PS2toUSB Adapter: Applying InputClass "evdev keyboard catchal=
l"
+ (**) GASIA PS2toUSB Adapter: Applying InputClass "libinput keyboard catc=
hall"
+ (**) GASIA PS2toUSB Adapter: Applying InputClass "system-keyboard"
+ (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter'
+ (**) GASIA PS2toUSB Adapter: always reports core events
+ (**) Option "Device" "/dev/input/event2"
+ (II) event2  - GASIA PS2toUSB Adapter: is tagged by udev as: Keyboard
+ (II) event2  - GASIA PS2toUSB Adapter: device is a keyboard
+ (II) event2  - GASIA PS2toUSB Adapter: device removed
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-1/3-1:1.0/0003:0E8F:0020.0001/input/input2/event2"
+ (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter" (type=
: KEYBOARD, id 8)
+ (**) Option "xkb_model" "pc105"
+ (**) Option "xkb_layout" "de"
+ (**) Option "xkb_variant" "nodeadkeys"
+ (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
+ (II) event2  - GASIA PS2toUSB Adapter: is tagged by udev as: Keyboard
+ (II) event2  - GASIA PS2toUSB Adapter: device is a keyboard
+ (II) config/udev: Adding input device GASIA PS2toUSB Adapter Mouse (/dev=
/input/event3)
+ (**) GASIA PS2toUSB Adapter Mouse: Applying InputClass "evdev pointer ca=
tchall"
+ (**) GASIA PS2toUSB Adapter Mouse: Applying InputClass "libinput pointer=
 catchall"
+ (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter Mouse'
+ (**) GASIA PS2toUSB Adapter Mouse: always reports core events
+ (**) Option "Device" "/dev/input/event3"
+ (II) event3  - GASIA PS2toUSB Adapter Mouse: is tagged by udev as: Mouse
+ (II) event3  - GASIA PS2toUSB Adapter Mouse: device is a pointer
+ (II) event3  - GASIA PS2toUSB Adapter Mouse: device removed
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input3/event3"
+ (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter Mouse"=
 (type: MOUSE, id 9)
+ (**) Option "AccelerationScheme" "none"
+ (**) GASIA PS2toUSB Adapter Mouse: (accel) selected scheme none/0
+ (**) GASIA PS2toUSB Adapter Mouse: (accel) acceleration factor: 2.000
+ (**) GASIA PS2toUSB Adapter Mouse: (accel) acceleration threshold: 4
+ (II) event3  - GASIA PS2toUSB Adapter Mouse: is tagged by udev as: Mouse
+ (II) event3  - GASIA PS2toUSB Adapter Mouse: device is a pointer
+ (II) config/udev: Adding input device GASIA PS2toUSB Adapter Mouse (/dev=
/input/mouse0)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device GASIA PS2toUSB Adapter System Cont=
rol (/dev/input/event4)
+ (**) GASIA PS2toUSB Adapter System Control: Applying InputClass "evdev k=
eyboard catchall"
+ (**) GASIA PS2toUSB Adapter System Control: Applying InputClass "libinpu=
t keyboard catchall"
+ (**) GASIA PS2toUSB Adapter System Control: Applying InputClass "system-=
keyboard"
+ (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter System Co=
ntrol'
+ (**) GASIA PS2toUSB Adapter System Control: always reports core events
+ (**) Option "Device" "/dev/input/event4"
+ (II) event4  - GASIA PS2toUSB Adapter System Control: is tagged by udev =
as: Keyboard
+ (II) event4  - GASIA PS2toUSB Adapter System Control: device is a keyboa=
rd
+ (II) event4  - GASIA PS2toUSB Adapter System Control: device removed
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input4/event4"
+ (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter System=
 Control" (type: KEYBOARD, id 10)
+ (**) Option "xkb_model" "pc105"
+ (**) Option "xkb_layout" "de"
+ (**) Option "xkb_variant" "nodeadkeys"
+ (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
+ (II) event4  - GASIA PS2toUSB Adapter System Control: is tagged by udev =
as: Keyboard
+ (II) event4  - GASIA PS2toUSB Adapter System Control: device is a keyboa=
rd
+ (II) config/udev: Adding input device GASIA PS2toUSB Adapter Consumer Co=
ntrol (/dev/input/event5)
+ (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "evdev=
 keyboard catchall"
+ (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "libin=
put keyboard catchall"
+ (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "syste=
m-keyboard"
+ (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter Consumer =
Control'
+ (**) GASIA PS2toUSB Adapter Consumer Control: always reports core events
+ (**) Option "Device" "/dev/input/event5"
+ (II) event5  - GASIA PS2toUSB Adapter Consumer Control: is tagged by ude=
v as: Keyboard
+ (II) event5  - GASIA PS2toUSB Adapter Consumer Control: device is a keyb=
oard
+ (II) event5  - GASIA PS2toUSB Adapter Consumer Control: device removed
+ (II) libinput: GASIA PS2toUSB Adapter Consumer Control: needs a virtual =
subdevice
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input5/event5"
+ (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter Consum=
er Control" (type: MOUSE, id 11)
+ (**) Option "AccelerationScheme" "none"
+ (**) GASIA PS2toUSB Adapter Consumer Control: (accel) selected scheme no=
ne/0
+ (**) GASIA PS2toUSB Adapter Consumer Control: (accel) acceleration facto=
r: 2.000
+ (**) GASIA PS2toUSB Adapter Consumer Control: (accel) acceleration thres=
hold: 4
+ (II) event5  - GASIA PS2toUSB Adapter Consumer Control: is tagged by ude=
v as: Keyboard
+ (II) event5  - GASIA PS2toUSB Adapter Consumer Control: device is a keyb=
oard
+ (II) config/udev: Adding input device Logitech K330 (/dev/input/event7)
+ (**) Logitech K330: Applying InputClass "evdev keyboard catchall"
+ (**) Logitech K330: Applying InputClass "libinput keyboard catchall"
+ (**) Logitech K330: Applying InputClass "system-keyboard"
+ (II) Using input driver 'libinput' for 'Logitech K330'
+ (**) Logitech K330: always reports core events
+ (**) Option "Device" "/dev/input/event7"
+ (II) event7  - Logitech K330: is tagged by udev as: Keyboard
+ (II) event7  - Logitech K330: device is a keyboard
+ (II) event7  - Logitech K330: device removed
+ (II) libinput: Logitech K330: needs a virtual subdevice
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-2/3-2:1.2/0003:046D:C52B.0005/0003:046D:4016.0007/input/input20/event7=
"
+ (II) XINPUT: Adding extended input device "Logitech K330" (type: MOUSE, =
id 12)
+ (**) Option "AccelerationScheme" "none"
+ (**) Logitech K330: (accel) selected scheme none/0
+ (**) Logitech K330: (accel) acceleration factor: 2.000
+ (**) Logitech K330: (accel) acceleration threshold: 4
+ (II) event7  - Logitech K330: is tagged by udev as: Keyboard
+ (II) event7  - Logitech K330: device is a keyboard
+ (II) config/udev: Adding input device Logitech M215 2nd Gen (/dev/input/=
event6)
+ (**) Logitech M215 2nd Gen: Applying InputClass "evdev pointer catchall"
+ (**) Logitech M215 2nd Gen: Applying InputClass "libinput pointer catcha=
ll"
+ (II) Using input driver 'libinput' for 'Logitech M215 2nd Gen'
+ (**) Logitech M215 2nd Gen: always reports core events
+ (**) Option "Device" "/dev/input/event6"
+ (II) event6  - Logitech M215 2nd Gen: is tagged by udev as: Mouse
+ (II) event6  - Logitech M215 2nd Gen: device is a pointer
+ (II) event6  - Logitech M215 2nd Gen: device removed
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-2/3-2:1.2/0003:046D:C52B.0005/0003:046D:401B.0006/input/input19/event6=
"
+ (II) XINPUT: Adding extended input device "Logitech M215 2nd Gen" (type:=
 MOUSE, id 13)
+ (**) Option "AccelerationScheme" "none"
+ (**) Logitech M215 2nd Gen: (accel) selected scheme none/0
+ (**) Logitech M215 2nd Gen: (accel) acceleration factor: 2.000
+ (**) Logitech M215 2nd Gen: (accel) acceleration threshold: 4
+ (II) event6  - Logitech M215 2nd Gen: is tagged by udev as: Mouse
+ (II) event6  - Logitech M215 2nd Gen: device is a pointer
+ (II) config/udev: Adding input device Logitech M215 2nd Gen (/dev/input/=
mouse1)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA Intel PCH Front Mic (/dev/inpu=
t/event13)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA Intel PCH Rear Mic (/dev/input=
/event14)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA Intel PCH Line (/dev/input/eve=
nt15)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA Intel PCH Line Out (/dev/input=
/event16)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device HDA Intel PCH Front Headphone (/de=
v/input/event17)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (II) config/udev: Adding input device PC Speaker (/dev/input/event8)
+ (II) No input driver specified, ignoring this device.
+ (II) This device may have been added with another device file.
+ (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "evdev=
 keyboard catchall"
+ (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "libin=
put keyboard catchall"
+ (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "syste=
m-keyboard"
+ (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter Consumer =
Control'
+ (**) GASIA PS2toUSB Adapter Consumer Control: always reports core events
+ (**) Option "Device" "/dev/input/event5"
+ (II) libinput: GASIA PS2toUSB Adapter Consumer Control: is a virtual sub=
device
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input5/event5"
+ (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter Consum=
er Control" (type: KEYBOARD, id 14)
+ (**) Option "xkb_model" "pc105"
+ (**) Option "xkb_layout" "de"
+ (**) Option "xkb_variant" "nodeadkeys"
+ (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
+ (**) Logitech K330: Applying InputClass "evdev keyboard catchall"
+ (**) Logitech K330: Applying InputClass "libinput keyboard catchall"
+ (**) Logitech K330: Applying InputClass "system-keyboard"
+ (II) Using input driver 'libinput' for 'Logitech K330'
+ (**) Logitech K330: always reports core events
+ (**) Option "Device" "/dev/input/event7"
+ (II) libinput: Logitech K330: is a virtual subdevice
+ (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb=
3/3-2/3-2:1.2/0003:046D:C52B.0005/0003:046D:4016.0007/input/input20/event7=
"
+ (II) XINPUT: Adding extended input device "Logitech K330" (type: KEYBOAR=
D, id 15)
+ (**) Option "xkb_model" "pc105"
+ (**) Option "xkb_layout" "de"
+ (**) Option "xkb_variant" "nodeadkeys"
+ (**) Option "xkb_options" "terminate:ctrl_alt_bksp"


