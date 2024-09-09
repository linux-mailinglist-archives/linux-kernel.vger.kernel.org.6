Return-Path: <linux-kernel+bounces-320599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C9970C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16851C21B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD49188006;
	Mon,  9 Sep 2024 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="QIisqocC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10422098
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725854676; cv=none; b=qT4IxE7Ii6oQshfQFfpbrmdoL5AlCRwbBgGQhEgkBNfzc9itbkVzXTJI87lSMq9SUeLIk3i+hgfLEmdZTUZarcrK5YSN+1ya8TYj7dILDmDf4leW55RCauSUw0W+OJKJcsF1mZJ7d6Lt3MlMg+UJeeR3VUwjEL32Cv2+OhOLXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725854676; c=relaxed/simple;
	bh=zGnpI0r1a38vxsSIx2hHdtXNq76MHm/ALm9Djc0Vj0k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RqJmGIEUFr2oJmtEMsKaGftaUyqk9eOuR2LUVSew/XkB1kcriUvplLCZMRJfMO2Jc54aOx/+4Epx0ZvgvaJyMThgbZiI+hLygckBjsfg2whLhm0BWoEtDjBrTJAvvLSGpnPDufhIEJnbqcTmieGA6vloQt7GIswo8WrhL0wmPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=QIisqocC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718e25d8b67so401481b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 21:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1725854671; x=1726459471; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84GKDHDuVyhWLTAUTTdGEkdpjWpMWaFn2H0MFutbY4E=;
        b=QIisqocCP9WcxSlnb0S+9y0Ozpt9fyuCzzE27hjZtO7VKT1gds8GpU7kpqQ7apvElU
         acv/TbRe35gD5WA3SgxUgYFfYPTerHkW6UWpKn2K9T+9m28CrVCXphHFcog2BLicQtj9
         YUvd3Bp3ajGvtsgn8DlA0q2AaJKJ28rpe+4eCdjzdsLP1SCdup+10RMkKdaLPnsO/bos
         cPTtlEMoVvdBKoYzGK8IDqlMnm0+/y94mRCbU8uwFU2Uh13I0f+qvvPZb0Kp4kirXLWx
         TNZGz5yMKQ9w25mlkhSeR5uOM3OAN5lSVKYy4U+hy973GAaPO2ywUHUYV9wbvYc14N1Z
         TCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725854671; x=1726459471;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=84GKDHDuVyhWLTAUTTdGEkdpjWpMWaFn2H0MFutbY4E=;
        b=EFjv9InuRUo67KNmWlIttl2NB6S09ROmiJUBOH3RkEnYjTdE4lFj9AwcQIu4Cmz0ng
         tmUteqINchxfVRRTJ5HVcWxYRPqy5Fpka9y02sQhokpnGTb47PMZQCYVnNFBpgBpqyGi
         BdpqoruqjHJfbTQa4er3wlyA/YYkxU+AJMeA6dzMoPeDTcFIG6TJMJAvEM9tiLDg4HlQ
         0oERxGoNsZH1Y5+ClhUnRI9hM4CcE0rUPcIWrkPVXFNYmaN/mvNBB1T4HR4eHmsP6gfl
         1UDh6PVuSOTsGVM2olCdmk2faK6ZWcRCT1SRr7RwqXnrmK0+jeeGE2VrVSAXhVXiPtA9
         7H5g==
X-Gm-Message-State: AOJu0YxHbhYfZ3uzXbKXkjgjGr/4iN9+pev9a7jysuC/ENMGZFm/mjjp
	asrEWbLmka8InoQZsvIlqu/1DgHTjPcZckeG3cJdkUQpx54AnaFfJ8tDZMPM4OZ40ks/EV166Iv
	i
X-Google-Smtp-Source: AGHT+IFgPvvvUWOA+zS4O6tqmQ7yw/i4+DYTQxm/6uvZGn11D8cm2Iv0A6G0jh944wqQ6xIN06Xx5g==
X-Received: by 2002:a05:6a00:919c:b0:710:51cd:ed43 with SMTP id d2e1a72fcca58-718d5e18e5bmr5021200b3a.1.1725854669879;
        Sun, 08 Sep 2024 21:04:29 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:8308:657e:be50:9887? ([2001:56a:f979:1f00:8308:657e:be50:9887])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c68d3sm2622160b3a.84.2024.09.08.21.04.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 21:04:29 -0700 (PDT)
Message-ID: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
Date: Sun, 8 Sep 2024 22:04:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Bob Gill <gillb5@telus.net>
Subject: Can we get a bootable 6.11-rc kernel?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi.  It would be nice to have a 6.11-rc kernel that doesn't crash.  I 
have an AMD video card.  I can boot into recovery, but any time I try to 
run "service lightdm start" or startx, I get a nice black screen, and a 
within a second or 2 my keyboard doesn't even let me type the caps-lock 
key.

My hardware: (taken from kernel 6.10.0)

Graphics:
   Device-1: AMD driver: amdgpu v: kernel
   Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
     Decoder with 3D Comb
     driver: cx23885 v: 0.0.4
   Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
   Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
   Display: x11 server: X.Org v: 1.21.1.4 driver: X: loaded: amdgpu,ati
     unloaded: fbdev,modesetting,radeon,vesa gpu: amdgpu resolution:
     1: 1920x1080~60Hz 2: 1920x1080~60Hz
   OpenGL:
     renderer: AMD Radeon RX 6500 XT (navi24 LLVM 15.0.7 DRM 3.57 6.10.0)
     v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2

  /var/log/Xorg.0.log.old:

[   124.194]
X.Org X Server 1.21.1.4
X Protocol Version 11, Revision 0
[   124.194] Current Operating System: Linux freedom 6.11.0-rc7 #1 SMP 
PREEMPT_DYNAMIC Sun Sep  8 18:17:08 MDT 2024 x86_64
[   124.194] Kernel command line: BOOT_IMAGE=/vmlinuz-6.11.0-rc7 
root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro recovery nomodeset 
dis_ucode_ldr
[   124.194] xorg-server 2:21.1.4-2ubuntu1.7~22.04.11 (For technical 
support please see http://www.ubuntu.com/support)
[   124.194] Current version of pixman: 0.40.0
[   124.194]    Before reporting problems, check http://wiki.x.org
         to make sure that you have the latest version.
[   124.194] Markers: (--) probed, (**) from config file, (==) default 
setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[   124.194] (==) Log file: "/var/log/Xorg.0.log", Time: Sun Sep 8 
21:34:40 2024
[   124.195] (==) Using system config directory "/usr/share/X11/xorg.conf.d"
[   124.197] (==) No Layout section.  Using the first Screen section.
[   124.197] (==) No screen section available. Using defaults.
[   124.197] (**) |-->Screen "Default Screen Section" (0)
[   124.197] (**) |   |-->Monitor "<default monitor>"
[   124.198] (==) No monitor specified for screen "Default Screen Section".
         Using a default monitor configuration.
[   124.198] (==) Automatically adding devices
[   124.198] (==) Automatically enabling devices
[   124.198] (==) Automatically adding GPU devices
[   124.198] (==) Automatically binding GPU devices
[   124.198] (==) Max clients allowed: 256, resource mask: 0x1fffff
[   124.202] (WW) The directory "/usr/share/fonts/X11/cyrillic" does not 
exist.
[   124.202]    Entry deleted from font path.
[   124.202] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not 
exist.
[   124.202]    Entry deleted from font path.
[   124.202] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not 
exist.
[   124.202]    Entry deleted from font path.
[   124.203] (WW) The directory "/usr/share/fonts/X11/100dpi" does not 
exist.
[   124.203]    Entry deleted from font path.
[   124.203] (WW) The directory "/usr/share/fonts/X11/75dpi" does not exist.
[   124.203]    Entry deleted from font path.
[   124.203] (==) FontPath set to:
         /usr/share/fonts/X11/misc,
         /usr/share/fonts/X11/Type1,
         built-ins
[   124.203] (==) ModulePath set to "/usr/lib/xorg/modules"
[   124.203] (II) The server relies on udev to provide the list of input 
devices.
         If no devices become available, reconfigure udev or disable 
AutoAddDevices.
[   124.203] (II) Loader magic: 0x5640541c6020
[   124.203] (II) Module ABI versions:
[   124.203]    X.Org ANSI C Emulation: 0.4

[   124.203]    X.Org Video Driver: 25.2
[   124.203]    X.Org XInput driver : 24.4
[   124.203]    X.Org Server Extension : 10.0
[   124.203] (++) using VT number 7

[   124.203] (II) systemd-logind: logind integration requires -keeptty 
and -keeptty was not provided, disabling logind integration
[   124.212] (--) PCI:*(4@0:0:0) 1002:743f:148c:2415 rev 193, Mem @ 
0xd0000000/268435456, 0xcfe00000/2097152, 0xfb700000/1048576, I/O @ 
0x0000a000/256, BIOS @ 0x????????/131072
[   124.212] (--) PCI: (9@0:0:0) 14f1:8880:0070:7801 rev 15, Mem @ 
0xfbc00000/2097152
[   124.212] (II) LoadModule: "glx"
[   124.214] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[   124.228] (II) Module glx: vendor="X.Org Foundation"
[   124.229]    compiled for 1.21.1.4, module version = 1.0.0
[   124.229]    ABI class: X.Org Server Extension, version 10.0
[   124.229] (==) Matched ati as autoconfigured driver 0
[   124.229] (==) Matched modesetting as autoconfigured driver 1
[   124.229] (==) Matched fbdev as autoconfigured driver 2
[   124.229] (==) Matched vesa as autoconfigured driver 3
[   124.229] (==) Assigned the driver to the xf86ConfigLayout
[   124.229] (II) LoadModule: "ati"
[   124.229] (II) Loading /usr/lib/xorg/modules/drivers/ati_drv.so
[   124.229] (II) Module ati: vendor="X.Org Foundation"
[   124.229]    compiled for 1.21.1.3, module version = 19.1.0
[   124.229]    Module class: X.Org Video Driver
[   124.229]    ABI class: X.Org Video Driver, version 25.2
[   124.293] (II) LoadModule: "radeon"
[   124.293] (II) Loading /usr/lib/xorg/modules/drivers/radeon_drv.so
[   124.303] (II) Module radeon: vendor="X.Org Foundation"
[   124.303]    compiled for 1.21.1.3, module version = 19.1.0
[   124.303]    Module class: X.Org Video Driver
[   124.303]    ABI class: X.Org Video Driver, version 25.2
[   124.303] (II) LoadModule: "modesetting"
[   124.303] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[   124.306] (II) Module modesetting: vendor="X.Org Foundation"
[   124.306]    compiled for 1.21.1.4, module version = 1.21.1
[   124.306]    Module class: X.Org Video Driver
[   124.306]    ABI class: X.Org Video Driver, version 25.2
[   124.306] (II) LoadModule: "fbdev"
[   124.306] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[   124.307] (II) Module fbdev: vendor="X.Org Foundation"
[   124.307]    compiled for 1.21.1.3, module version = 0.5.0
[   124.307]    Module class: X.Org Video Driver
[   124.307]    ABI class: X.Org Video Driver, version 25.2
[   124.307] (II) LoadModule: "vesa"
[   124.307] (II) Loading /usr/lib/xorg/modules/drivers/vesa_drv.so
[   124.308] (II) Module vesa: vendor="X.Org Foundation"

[   124.308]    compiled for 1.21.1.3, module version = 2.5.0
[   124.308]    Module class: X.Org Video Driver
[   124.308]    ABI class: X.Org Video Driver, version 25.2
[   124.308] (II) RADEON: Driver for ATI/AMD Radeon chipsets:
         ATI Radeon Mobility X600 (M24), ATI FireMV 2400,
         ATI Radeon Mobility X300 (M24), ATI FireGL M24 GL,
         ATI Radeon X600 (RV380), ATI FireGL V3200 (RV380),
         ATI Radeon IGP320 (A3), ATI Radeon IGP330/340/350 (A4),
         ATI Radeon 9500, ATI Radeon 9600TX, ATI FireGL Z1, ATI Radeon 
9800SE,
         ATI Radeon 9800, ATI FireGL X2, ATI Radeon 9600, ATI Radeon 9600SE,
         ATI Radeon 9600XT, ATI FireGL T2, ATI Radeon 9650, ATI FireGL 
RV360,
         ATI Radeon 7000 IGP (A4+), ATI Radeon 8500 AIW,
         ATI Radeon IGP320M (U1), ATI Radeon IGP330M/340M/350M (U2),
         ATI Radeon Mobility 7000 IGP, ATI Radeon 9000/PRO, ATI Radeon 9000,
         ATI Radeon X800 (R420), ATI Radeon X800PRO (R420),
         ATI Radeon X800SE (R420), ATI FireGL X3 (R420),
         ATI Radeon Mobility 9800 (M18), ATI Radeon X800 SE (R420),
         ATI Radeon X800XT (R420), ATI Radeon X800 VE (R420),
         ATI Radeon X850 (R480), ATI Radeon X850 XT (R480),
         ATI Radeon X850 SE (R480), ATI Radeon X850 PRO (R480),
         ATI Radeon X850 XT PE (R480), ATI Radeon Mobility M7,
         ATI Mobility FireGL 7800 M7, ATI Radeon Mobility M6,
         ATI FireGL Mobility 9000 (M9), ATI Radeon Mobility 9000 (M9),
         ATI Radeon 9700 Pro, ATI Radeon 9700/9500Pro, ATI FireGL X1,
         ATI Radeon 9800PRO, ATI Radeon 9800XT,
         ATI Radeon Mobility 9600/9700 (M10/M11),
         ATI Radeon Mobility 9600 (M10), ATI Radeon Mobility 9600 (M11),
         ATI FireGL Mobility T2 (M10), ATI FireGL Mobility T2e (M11),
         ATI Radeon, ATI FireGL 8700/8800, ATI Radeon 8500, ATI Radeon 9100,
         ATI Radeon 7500, ATI Radeon VE/7000, ATI ES1000,

         ATI Radeon Mobility X300 (M22), ATI Radeon Mobility X600 SE (M24C),
         ATI FireGL M22 GL, ATI Radeon X800 (R423), ATI Radeon X800PRO 
(R423),
         ATI Radeon X800LE (R423), ATI Radeon X800SE (R423),
         ATI Radeon X800 XTP (R430), ATI Radeon X800 XL (R430),
         ATI Radeon X800 SE (R430), ATI Radeon X800 (R430),
         ATI FireGL V7100 (R423), ATI FireGL V5100 (R423),
         ATI FireGL unknown (R423), ATI Mobility FireGL V5000 (M26),
         ATI Mobility Radeon X700 XL (M26), ATI Mobility Radeon X700 (M26),
         ATI Radeon X550XTX, ATI Radeon 9100 IGP (A5),
         ATI Radeon Mobility 9100 IGP (U3), ATI Radeon XPRESS 200,
         ATI Radeon XPRESS 200M, ATI Radeon 9250, ATI Radeon 9200,
         ATI Radeon 9200SE, ATI FireMV 2200, ATI Radeon X300 (RV370),
         ATI Radeon X600 (RV370), ATI Radeon X550 (RV370),
         ATI FireGL V3100 (RV370), ATI FireMV 2200 PCIE (RV370),
         ATI Radeon Mobility 9200 (M9+), ATI Mobility Radeon X800 XT (M28),
         ATI Mobility FireGL V5100 (M28), ATI Mobility Radeon X800 (M28),
         ATI Radeon X850, ATI unknown Radeon / FireGL (R480),
         ATI Radeon X800XT (R423), ATI FireGL V5000 (RV410),
         ATI Radeon X700 XT (RV410), ATI Radeon X700 PRO (RV410),
         ATI Radeon X700 SE (RV410), ATI Radeon X700 (RV410),
         ATI Radeon X1800, ATI Mobility Radeon X1800 XT,
         ATI Mobility Radeon X1800, ATI Mobility FireGL V7200,
         ATI FireGL V7200, ATI FireGL V5300, ATI Mobility FireGL V7100,
         ATI FireGL V7300, ATI FireGL V7350, ATI Radeon X1600, ATI RV505,
         ATI Radeon X1300/X1550, ATI Radeon X1550, ATI M54-GL,
         ATI Mobility Radeon X1400, ATI Radeon X1550 64-bit,
         ATI Mobility Radeon X1300, ATI Radeon X1300, ATI FireGL V3300,
         ATI FireGL V3350, ATI Mobility Radeon X1450,
         ATI Mobility Radeon X2300, ATI Mobility Radeon X1350,
         ATI FireMV 2250, ATI Radeon X1650, ATI Mobility FireGL V5200,
         ATI Mobility Radeon X1600, ATI Radeon X1300 XT/X1600 Pro,
         ATI FireGL V3400, ATI Mobility FireGL V5250,
         ATI Mobility Radeon X1700, ATI Mobility Radeon X1700 XT,
         ATI FireGL V5200, ATI Radeon X2300HD, ATI Mobility Radeon HD 2300,
         ATI Radeon X1950, ATI Radeon X1900, ATI AMD Stream Processor,
         ATI RV560, ATI Mobility Radeon X1900, ATI Radeon X1950 GT, ATI 
RV570,
         ATI FireGL V7400, ATI Radeon 9100 PRO IGP,
         ATI Radeon Mobility 9200 IGP, ATI Radeon X1200, ATI RS740,
         ATI RS740M, ATI Radeon HD 2900 XT, ATI Radeon HD 2900 Pro,
         ATI Radeon HD 2900 GT, ATI FireGL V8650, ATI FireGL V8600,

         ATI FireGL V7600, ATI Radeon 4800 Series, ATI Radeon HD 4870 x2,
         ATI Radeon HD 4850 x2, ATI FirePro V8750 (FireGL),
         ATI FirePro V7760 (FireGL), ATI Mobility RADEON HD 4850,
         ATI Mobility RADEON HD 4850 X2, ATI FirePro RV770,
         AMD FireStream 9270, AMD FireStream 9250, ATI FirePro V8700 
(FireGL),
         ATI Mobility RADEON HD 4870, ATI Mobility RADEON M98,
         ATI FirePro M7750, ATI M98, ATI Mobility Radeon HD 4650,
         ATI Radeon RV730 (AGP), ATI Mobility Radeon HD 4670,
         ATI FirePro M5750, ATI RV730XT [Radeon HD 4670], ATI RADEON E4600,
         ATI Radeon HD 4600 Series, ATI RV730 PRO [Radeon HD 4650],
         ATI FirePro V7750 (FireGL), ATI FirePro V5700 (FireGL),
         ATI FirePro V3750 (FireGL), ATI Mobility Radeon HD 4830,
         ATI Mobility Radeon HD 4850, ATI FirePro M7740, ATI RV740,
         ATI Radeon HD 4770, ATI Radeon HD 4700 Series, ATI RV610,
         ATI Radeon HD 2400 XT, ATI Radeon HD 2400 Pro,
         ATI Radeon HD 2400 PRO AGP, ATI FireGL V4000, ATI Radeon HD 2350,
         ATI Mobility Radeon HD 2400 XT, ATI Mobility Radeon HD 2400,
         ATI RADEON E2400, ATI FireMV 2260, ATI RV670, ATI Radeon HD3870,
         ATI Mobility Radeon HD 3850, ATI Radeon HD3850,
         ATI Mobility Radeon HD 3850 X2, ATI Mobility Radeon HD 3870,
         ATI Mobility Radeon HD 3870 X2, ATI Radeon HD3870 X2,
         ATI FireGL V7700, ATI Radeon HD3690, AMD Firestream 9170,
         ATI Radeon HD 4550, ATI Radeon RV710, ATI Radeon HD 4350,
         ATI Mobility Radeon 4300 Series, ATI Mobility Radeon 4500 Series,
         ATI FirePro RG220, ATI Mobility Radeon 4330, ATI RV630,
         ATI Mobility Radeon HD 2600, ATI Mobility Radeon HD 2600 XT,
         ATI Radeon HD 2600 XT AGP, ATI Radeon HD 2600 Pro AGP,
         ATI Radeon HD 2600 XT, ATI Radeon HD 2600 Pro, ATI Gemini RV630,
         ATI Gemini Mobility Radeon HD 2600 XT, ATI FireGL V5600,
         ATI FireGL V3600, ATI Radeon HD 2600 LE,
         ATI Mobility FireGL Graphics Processor, ATI Radeon HD 3470,
         ATI Mobility Radeon HD 3430, ATI Mobility Radeon HD 3400 Series,
         ATI Radeon HD 3450, ATI Radeon HD 3430, ATI FirePro V3700,
         ATI FireMV 2450, ATI Radeon HD 3600 Series, ATI Radeon HD 3650 AGP,
         ATI Radeon HD 3600 PRO, ATI Radeon HD 3600 XT,
         ATI Mobility Radeon HD 3650, ATI Mobility Radeon HD 3670,
         ATI Mobility FireGL V5700, ATI Mobility FireGL V5725,
         ATI Radeon HD 3200 Graphics, ATI Radeon 3100 Graphics,
         ATI Radeon HD 3300 Graphics, ATI Radeon 3000 Graphics, SUMO, SUMO2,
         ATI Radeon HD 4200, ATI Radeon 4100, ATI Mobility Radeon HD 4200,
         ATI Mobility Radeon 4100, ATI Radeon HD 4290, ATI Radeon HD 4250,
         AMD Radeon HD 6310 Graphics, AMD Radeon HD 6250 Graphics,
         AMD Radeon HD 6300 Series Graphics,
         AMD Radeon HD 6200 Series Graphics, PALM, CYPRESS,
         ATI FirePro (FireGL) Graphics Adapter, AMD Firestream 9370,

         AMD Firestream 9350, ATI Radeon HD 5800 Series,
         ATI Radeon HD 5900 Series, ATI Mobility Radeon HD 5800 Series,
         ATI Radeon HD 5700 Series, ATI Radeon HD 6700 Series,
         ATI Mobility Radeon HD 5000 Series, ATI Mobility Radeon HD 5570,
         ATI Radeon HD 5670, ATI Radeon HD 5570, ATI Radeon HD 5500 Series,
         REDWOOD, ATI Mobility Radeon Graphics, CEDAR, ATI FirePro 2270,
         ATI Radeon HD 5450, CAYMAN, AMD Radeon HD 6900 Series,
         AMD Radeon HD 6900M Series, Mobility Radeon HD 6000 Series, BARTS,
         AMD Radeon HD 6800 Series, AMD Radeon HD 6700 Series, TURKS, 
CAICOS,
         ARUBA, TAHITI, PITCAIRN, VERDE, OLAND, HAINAN, BONAIRE, KABINI,
         MULLINS, KAVERI, HAWAII
[   124.310] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[   124.310] (II) FBDEV: driver for framebuffer: fbdev
[   124.310] (II) VESA: driver for VESA chipsets: vesa
[   124.312] (EE) open /dev/dri/card0: No such file or directory
[   124.312] (WW) Falling back to old probe method for modesetting
[   124.312] (EE) open /dev/dri/card0: No such file or directory
[   124.312] (II) Loading sub module "fbdevhw"
[   124.312] (II) LoadModule: "fbdevhw"
[   124.312] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[   124.313] (II) Module fbdevhw: vendor="X.Org Foundation"
[   124.313]    compiled for 1.21.1.4, module version = 0.0.2
[   124.314]    ABI class: X.Org Video Driver, version 25.2
[   124.314] (EE) Unable to find a valid framebuffer device
[   124.314] (WW) Falling back to old probe method for fbdev
[   124.314] (II) Loading sub module "fbdevhw"
[   124.314] (II) LoadModule: "fbdevhw"
[   124.314] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[   124.314] (II) Module fbdevhw: vendor="X.Org Foundation"
[   124.314]    compiled for 1.21.1.4, module version = 0.0.2
[   124.314]    ABI class: X.Org Video Driver, version 25.2
[   124.314] (EE) open /dev/fb0: No such file or directory
[   124.314] (EE) Screen 0 deleted because of no matching config section.
[   124.314] (II) UnloadModule: "modesetting"
[   124.314] (EE) Screen 0 deleted because of no matching config section.
[   124.314] (II) UnloadModule: "fbdev"
[   124.314] (II) UnloadSubModule: "fbdevhw"
[   124.314] (II) Loading sub module "vbe"
[   124.314] (II) LoadModule: "vbe"
[   124.314] (II) Loading /usr/lib/xorg/modules/libint10.so
[   124.316] (II) Module int10: vendor="X.Org Foundation"
[   124.316]    compiled for 1.21.1.4, module version = 1.0.0
[   124.316]    ABI class: X.Org Video Driver, version 25.2
[   124.316] (II) Loading sub module "int10"
[   124.316] (II) LoadModule: "int10"

[   124.316] (II) Loading /usr/lib/xorg/modules/libint10.so
[   124.316] (II) Module int10: vendor="X.Org Foundation"
[   124.316]    compiled for 1.21.1.4, module version = 1.0.0
[   124.316]    ABI class: X.Org Video Driver, version 25.2
[   124.316] (II) VESA(0): initializing int10
[   124.318] (II) VESA(0): Primary V_BIOS segment is: 0xc000
[   124.318] (II) VESA(0): VESA BIOS detected
[   124.318] (II) VESA(0): VESA VBE Version 3.0
[   124.318] (II) VESA(0): VESA VBE Total Mem: 49152 kB
[   124.318] (II) VESA(0): VESA VBE OEM: AMD ATOMBIOS
[   124.318] (II) VESA(0): VESA VBE OEM Software Rev: 20.4
[   124.318] (II) VESA(0): VESA VBE OEM Vendor: (C) 1988-2020, Advanced 
Micro Devices, Inc.
[   124.318] (II) VESA(0): VESA VBE OEM Product: NAVI24
[   124.318] (II) VESA(0): VESA VBE OEM Product Rev: 01.00
[   124.346] (II) VESA(0): Creating default Display subsection in Screen 
section
         "Default Screen Section" for depth/fbbpp 24/32
[   124.346] (==) VESA(0): Depth 24, (--) framebuffer bpp 32
[   124.346] (==) VESA(0): RGB weight 888
[   124.346] (==) VESA(0): Default visual is TrueColor
[   124.346] (==) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
[   124.346] (II) Loading sub module "ddc"
[   124.346] (II) LoadModule: "ddc"
[   124.346] (II) Module "ddc" already built-in
[   124.346] (II) VESA(0): VESA VBE DDC supported
[   124.346] (II) VESA(0): VESA VBE DDC Level 2
[   124.346] (II) VESA(0): VESA VBE DDC transfer in appr. 1 sec.
[   124.347] (II) VESA(0): VESA VBE DDC read successfully
[   124.347] (II) VESA(0): Manufacturer: SAM  Model: 50a  Serial#: 
1162228274
[   124.347] (II) VESA(0): Year: 2009  Week: 13
[   124.347] (II) VESA(0): EDID Version: 1.3
[   124.347] (II) VESA(0): Analog Display Input,  Input Voltage Level: 
0.700/0.300 V
[   124.347] (II) VESA(0): Sync:  Separate  Composite  SyncOnGreen
[   124.347] (II) VESA(0): Max Image Size [cm]: horiz.: 48  vert.: 27
[   124.347] (II) VESA(0): Gamma: 2.20
[   124.347] (II) VESA(0): DPMS capabilities: Off; RGB/Color Display

[   124.347] (II) VESA(0): First detailed timing is preferred mode
[   124.347] (II) VESA(0): redX: 0.651 redY: 0.334   greenX: 0.286 
greenY: 0.600
[   124.347] (II) VESA(0): blueX: 0.152 blueY: 0.075   whiteX: 0.312 
whiteY: 0.329
[   124.347] (II) VESA(0): Supported established timings:
[   124.347] (II) VESA(0): 640x480@60Hz
[   124.347] (II) VESA(0): 800x600@56Hz
[   124.347] (II) VESA(0): 800x600@60Hz
[   124.347] (II) VESA(0): 1024x768@60Hz
[   124.347] (II) VESA(0): Manufacturer's mask: 0
[   124.347] (II) VESA(0): Supported standard timings:
[   124.347] (II) VESA(0): #0: hsize: 1280  vsize 800  refresh: 60  vid: 129
[   124.347] (II) VESA(0): #1: hsize: 1280  vsize 960  refresh: 60  vid: 
16513
[   124.347] (II) VESA(0): #2: hsize: 1280  vsize 1024  refresh: 60  
vid: 32897
[   124.347] (II) VESA(0): #3: hsize: 1440  vsize 900  refresh: 60  vid: 149
[   124.347] (II) VESA(0): #4: hsize: 1680  vsize 1050  refresh: 60  
vid: 179
[   124.347] (II) VESA(0): #5: hsize: 1600  vsize 1200  refresh: 60  
vid: 16553
[   124.347] (II) VESA(0): Supported detailed timing:
[   124.347] (II) VESA(0): clock: 148.5 MHz   Image Size:  477 x 268 mm
[   124.347] (II) VESA(0): h_active: 1920  h_sync: 2008 h_sync_end 2052 
h_blank_end 2200 h_border: 0
[   124.347] (II) VESA(0): v_active: 1080  v_sync: 1084 v_sync_end 1089 
v_blanking: 1125 v_border: 0
[   124.347] (II) VESA(0): Ranges: V min: 56 V max: 61 Hz, H min: 30 H 
max: 81 kHz, PixClock max 175 MHz
[   124.347] (II) VESA(0): Monitor name: SyncMaster
[   124.347] (II) VESA(0): Serial No: HVLS300718
[   124.347] (II) VESA(0): EDID (in hex):
[   124.347] (II) VESA(0):      00ffffffffffff004c2d0a0532324645
[   124.347] (II) VESA(0):      0d1301030e301b782ae611a655499927
[   124.347] (II) VESA(0):      1350542308008100814081809500b300
[   124.348] (II) VESA(0):      a94001010101023a801871382d40582c
[   124.348] (II) VESA(0):      4500dd0c1100001e000000fd00383d1e
[   124.348] (II) VESA(0):      5111000a202020202020000000fc0053
[   124.348] (II) VESA(0):      796e634d61737465720a2020000000ff
[   124.348] (II) VESA(0):      0048564c533330303731380a2020008c
[   124.348] (II) VESA(0): EDID vendor "SAM", prod id 1290
[   124.348] (II) VESA(0): Using EDID range info for horizontal sync
[   124.348] (II) VESA(0): Using EDID range info for vertical refresh
[   124.348] (II) VESA(0): Printing DDC gathered Modelines:[ 124.348] 
(II) VESA(0): Modeline "1920x1080"x0.0  148.50  1920 2008 2052 2200  
1080 1084 1089 1125 +hsync +vsync
  (67.5 kHz eP)
[   124.348] (II) VESA(0): Modeline "800x600"x0.0   40.00  800 840 968 
1056  600 601 605 628 +hsync +vsync (37.9 kH
z e)
[   124.348] (II) VESA(0): Modeline "800x600"x0.0   36.00  800 824 896 
1024  600 601 603 625 +hsync +vsync (35.2 kH
z e)
[   124.348] (II) VESA(0): Modeline "640x480"x0.0   25.18  640 656 752 
800  480 490 492 525 -hsync -vsync (31.5 kHz
  e)
[   124.348] (II) VESA(0): Modeline "1024x768"x0.0   65.00  1024 1048 
1184 1344  768 771 777 806 -hsync -vsync (48.
4 kHz e)
[   124.348] (II) VESA(0): Modeline "1280x800"x0.0   83.50  1280 1352 
1480 1680  800 803 809 831 -hsync +vsync (49.
7 kHz e)
[   124.348] (II) VESA(0): Modeline "1280x960"x0.0  108.00  1280 1376 
1488 1800  960 961 964 1000 +hsync +vsync (60.0 kHz e)
[   124.348] (II) VESA(0): Modeline "1280x1024"x0.0  108.00  1280 1328 
1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz e)
[   124.348] (II) VESA(0): Modeline "1440x900"x0.0  106.50  1440 1520 
1672 1904  900 903 909 934 -hsync +vsync (55.9 kHz e)
[   124.348] (II) VESA(0): Modeline "1680x1050"x0.0  146.25  1680 1784 
1960 2240  1050 1053 1059 1089 -hsync +vsync (65.3 kHz e)
[   124.348] (II) VESA(0): Modeline "1600x1200"x0.0  162.00  1600 1664 
1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz e)
[   124.348] (II) VESA(0): Searching for matching VESA mode(s):
[   124.349] Mode: 110 (640x480)
[   124.349]    ModeAttributes: 0xbb
[   124.349]    WinAAttributes: 0x7
[   124.349]    WinBAttributes: 0x0
[   124.349]    WinGranularity: 64
[   124.349]    WinSize: 64
[   124.349]    WinASegment: 0xa000
[   124.349]    WinBSegment: 0x0
[   124.349]    WinFuncPtr: 0xc0005dc7
[   124.349]    BytesPerScanline: 1280
[   124.349]    XResolution: 640
[   124.349]    YResolution: 480
[   124.349]    XCharSize: 8
[   124.349]    YCharSize: 16
[   124.349]    NumberOfPlanes: 1
[   124.349]    BitsPerPixel: 16
[   124.349]    NumberOfBanks: 1
[   124.349]    MemoryModel: 6
[   124.349]    BankSize: 0
[   124.349]    NumberOfImages: 75
[   124.349]    RedMaskSize: 5

[   124.349]    RedFieldPosition: 10
[   124.349]    GreenMaskSize: 5
[   124.349]    GreenFieldPosition: 5
[   124.349]    BlueMaskSize: 5
[   124.349]    BlueFieldPosition: 0
[   124.349]    RsvdMaskSize: 0
[   124.349]    RsvdFieldPosition: 0
[   124.349]    DirectColorModeInfo: 0
[   124.349]    PhysBasePtr: 0xd0000000
[   124.349]    LinBytesPerScanLine: 1280
[   124.349]    BnkNumberOfImagePages: 75
[   124.349]    LinNumberOfImagePages: 75
[   124.349]    LinRedMaskSize: 5
[   124.349]    LinRedFieldPosition: 10
[   124.349]    LinGreenMaskSize: 5
[   124.349]    LinGreenFieldPosition: 5
[   124.349]    LinBlueMaskSize: 5
[   124.349]    LinBlueFieldPosition: 0
[   124.349]    LinRsvdMaskSize: 0
[   124.349]    LinRsvdFieldPosition: 0
[   124.349]    MaxPixelClock: 400000000
[   124.351] Mode: 111 (640x480)
[   124.351]    ModeAttributes: 0xbb
[   124.351]    WinAAttributes: 0x7
[   124.351]    WinBAttributes: 0x0
[   124.351]    WinGranularity: 64
[   124.351]    WinSize: 64
[   124.351]    WinASegment: 0xa000
[   124.351]    WinBSegment: 0x0
[   124.351]    WinFuncPtr: 0xc0005dc7
[   124.351]    BytesPerScanline: 1280
[   124.351]    XResolution: 640
[   124.351]    YResolution: 480
[   124.351]    XCharSize: 8
[   124.351]    YCharSize: 16
[   124.351]    NumberOfPlanes: 1
[   124.351]    BitsPerPixel: 16
[   124.351]    NumberOfBanks: 1
[   124.351]    MemoryModel: 6
[   124.351]    BankSize: 0
[   124.351]    NumberOfImages: 75
[   124.351]    RedMaskSize: 5
[   124.351]    RedFieldPosition: 11
[   124.351]    GreenMaskSize: 6
[   124.351]    GreenFieldPosition: 5

[   124.351]    BlueMaskSize: 5
[   124.351]    BlueFieldPosition: 0
[   124.351]    RsvdMaskSize: 0
[   124.351]    RsvdFieldPosition: 0
[   124.351]    DirectColorModeInfo: 0
[   124.351]    PhysBasePtr: 0xd0000000
[   124.351]    LinBytesPerScanLine: 1280
[   124.351]    BnkNumberOfImagePages: 75
[   124.351]    LinNumberOfImagePages: 75
[   124.351]    LinRedMaskSize: 5
[   124.351]    LinRedFieldPosition: 11
[   124.351]    LinGreenMaskSize: 6
[   124.351]    LinGreenFieldPosition: 5
[   124.351]    LinBlueMaskSize: 5
[   124.351]    LinBlueFieldPosition: 0
[   124.351]    LinRsvdMaskSize: 0
[   124.351]    LinRsvdFieldPosition: 0
[   124.351]    MaxPixelClock: 400000000
[   124.352] Mode: 113 (800x600)
[   124.352]    ModeAttributes: 0xbb
[   124.352]    WinAAttributes: 0x7
[   124.352]    WinBAttributes: 0x0
[   124.352]    WinGranularity: 64
[   124.352]    WinSize: 64
[   124.352]    WinASegment: 0xa000
[   124.352]    WinBSegment: 0x0
[   124.352]    WinFuncPtr: 0xc0005dc7
[   124.352]    BytesPerScanline: 1664
[   124.352]    XResolution: 800
[   124.352]    YResolution: 600
[   124.352]    XCharSize: 8
[   124.352]    YCharSize: 14
[   124.352]    NumberOfPlanes: 1
[   124.352]    BitsPerPixel: 16
[   124.352]    NumberOfBanks: 1
[   124.352]    MemoryModel: 6
[   124.352]    BankSize: 0
[   124.352]    NumberOfImages: 47
[   124.352]    RedMaskSize: 5
[   124.352]    RedFieldPosition: 10
[   124.352]    GreenMaskSize: 5
[   124.352]    GreenFieldPosition: 5
[   124.352]    BlueMaskSize: 5
[   124.352]    BlueFieldPosition: 0
[   124.352]    RsvdMaskSize: 0

[   124.353]    RsvdFieldPosition: 0
[   124.353]    DirectColorModeInfo: 0
[   124.353]    PhysBasePtr: 0xd0000000
[   124.353]    LinBytesPerScanLine: 1664
[   124.353]    BnkNumberOfImagePages: 47
[   124.353]    LinNumberOfImagePages: 47
[   124.353]    LinRedMaskSize: 5
[   124.353]    LinRedFieldPosition: 10
[   124.353]    LinGreenMaskSize: 5
[   124.353]    LinGreenFieldPosition: 5
[   124.353]    LinBlueMaskSize: 5
[   124.353]    LinBlueFieldPosition: 0
[   124.353]    LinRsvdMaskSize: 0
[   124.353]    LinRsvdFieldPosition: 0
[   124.353]    MaxPixelClock: 400000000
[   124.354] Mode: 114 (800x600)
[   124.354]    ModeAttributes: 0xbb
[   124.354]    WinAAttributes: 0x7
[   124.354]    WinBAttributes: 0x0
[   124.354]    WinGranularity: 64
[   124.354]    WinSize: 64
[   124.354]    WinASegment: 0xa000
[   124.354]    WinBSegment: 0x0
[   124.354]    WinFuncPtr: 0xc0005dc7
[   124.354]    BytesPerScanline: 1664
[   124.354]    XResolution: 800
[   124.354]    YResolution: 600
[   124.354]    XCharSize: 8
[   124.354]    YCharSize: 14
[   124.354]    NumberOfPlanes: 1
[   124.354]    BitsPerPixel: 16
[   124.354]    NumberOfBanks: 1
[   124.354]    MemoryModel: 6
[   124.354]    BankSize: 0
[   124.354]    NumberOfImages: 47
[   124.354]    RedMaskSize: 5
[   124.354]    RedFieldPosition: 11
[   124.354]    GreenMaskSize: 6
[   124.354]    GreenFieldPosition: 5
[   124.354]    BlueMaskSize: 5
[   124.354]    BlueFieldPosition: 0
[   124.354]    RsvdMaskSize: 0
[   124.354]    RsvdFieldPosition: 0
[   124.354]    DirectColorModeInfo: 0
[   124.354]    PhysBasePtr: 0xd0000000

[   124.354]    LinBytesPerScanLine: 1664
[   124.354]    BnkNumberOfImagePages: 47
[   124.354]    LinNumberOfImagePages: 47
[   124.354]    LinRedMaskSize: 5
[   124.354]    LinRedFieldPosition: 11
[   124.354]    LinGreenMaskSize: 6
[   124.354]    LinGreenFieldPosition: 5
[   124.354]    LinBlueMaskSize: 5
[   124.354]    LinBlueFieldPosition: 0
[   124.354]    LinRsvdMaskSize: 0
[   124.354]    LinRsvdFieldPosition: 0
[   124.354]    MaxPixelClock: 400000000
[   124.355] Mode: 116 (1024x768)
[   124.355]    ModeAttributes: 0xbb
[   124.355]    WinAAttributes: 0x7
[   124.355]    WinBAttributes: 0x0
[   124.355]    WinGranularity: 64
[   124.355]    WinSize: 64
[   124.355]    WinASegment: 0xa000
[   124.355]    WinBSegment: 0x0
[   124.355]    WinFuncPtr: 0xc0005dc7
[   124.355]    BytesPerScanline: 2048
[   124.355]    XResolution: 1024
[   124.355]    YResolution: 768
[   124.355]    XCharSize: 8
[   124.355]    YCharSize: 16
[   124.355]    NumberOfPlanes: 1
[   124.355]    BitsPerPixel: 16
[   124.355]    NumberOfBanks: 1
[   124.355]    MemoryModel: 6
[   124.355]    BankSize: 0
[   124.355]    NumberOfImages: 29
[   124.355]    RedMaskSize: 5
[   124.355]    RedFieldPosition: 10
[   124.355]    GreenMaskSize: 5
[   124.355]    GreenFieldPosition: 5
[   124.355]    BlueMaskSize: 5
[   124.355]    BlueFieldPosition: 0
[   124.355]    RsvdMaskSize: 0
[   124.355]    RsvdFieldPosition: 0
[   124.355]    DirectColorModeInfo: 0
[   124.355]    PhysBasePtr: 0xd0000000
[   124.355]    LinBytesPerScanLine: 2048
[   124.355]    BnkNumberOfImagePages: 29
[   124.355]    LinNumberOfImagePages: 29

[   124.355]    LinRedMaskSize: 5
[   124.355]    LinRedFieldPosition: 10
[   124.355]    LinGreenMaskSize: 5
[   124.355]    LinGreenFieldPosition: 5
[   124.355]    LinBlueMaskSize: 5
[   124.355]    LinBlueFieldPosition: 0
[   124.355]    LinRsvdMaskSize: 0
[   124.355]    LinRsvdFieldPosition: 0
[   124.355]    MaxPixelClock: 400000000
[   124.357] Mode: 117 (1024x768)
[   124.357]    ModeAttributes: 0xbb
[   124.357]    WinAAttributes: 0x7
[   124.357]    WinBAttributes: 0x0
[   124.357]    WinGranularity: 64
[   124.357]    WinSize: 64
[   124.357]    WinASegment: 0xa000
[   124.357]    WinBSegment: 0x0
[   124.357]    WinFuncPtr: 0xc0005dc7
[   124.357]    BytesPerScanline: 2048
[   124.357]    XResolution: 1024
[   124.357]    YResolution: 768
[   124.357]    XCharSize: 8
[   124.357]    YCharSize: 16
[   124.357]    NumberOfPlanes: 1
[   124.357]    BitsPerPixel: 16
[   124.357]    NumberOfBanks: 1
[   124.357]    MemoryModel: 6
[   124.357]    BankSize: 0
[   124.357]    NumberOfImages: 29
[   124.357]    RedMaskSize: 5
[   124.357]    RedFieldPosition: 11
[   124.357]    GreenMaskSize: 6
[   124.357]    GreenFieldPosition: 5
[   124.357]    BlueMaskSize: 5
[   124.357]    BlueFieldPosition: 0
[   124.357]    RsvdMaskSize: 0

[   124.357]    RsvdFieldPosition: 0
[   124.357]    DirectColorModeInfo: 0
[   124.357]    PhysBasePtr: 0xd0000000
[   124.357]    LinBytesPerScanLine: 2048
[   124.357]    BnkNumberOfImagePages: 29
[   124.357]    LinNumberOfImagePages: 29
[   124.357]    LinRedMaskSize: 5
[   124.357]    LinRedFieldPosition: 11
[   124.357]    LinGreenMaskSize: 6
[   124.357]    LinGreenFieldPosition: 5
[   124.357]    LinBlueMaskSize: 5
[   124.357]    LinBlueFieldPosition: 0
[   124.357]    LinRsvdMaskSize: 0
[   124.357]    LinRsvdFieldPosition: 0
[   124.357]    MaxPixelClock: 400000000
[   124.358] Mode: 119 (1280x1024)
[   124.358]    ModeAttributes: 0xbb
[   124.358]    WinAAttributes: 0x7
[   124.358]    WinBAttributes: 0x0
[   124.358]    WinGranularity: 64
[   124.358]    WinSize: 64
[   124.358]    WinASegment: 0xa000
[   124.358]    WinBSegment: 0x0
[   124.358]    WinFuncPtr: 0xc0005dc7
[   124.358]    BytesPerScanline: 2560
[   124.358]    XResolution: 1280
[   124.358]    YResolution: 1024
[   124.358]    XCharSize: 8
[   124.358]    YCharSize: 16
[   124.358]    NumberOfPlanes: 1
[   124.358]    BitsPerPixel: 16
[   124.358]    NumberOfBanks: 1
[   124.358]    MemoryModel: 6
[   124.358]    BankSize: 0
[   124.358]    NumberOfImages: 17
[   124.358]    RedMaskSize: 5
[   124.358]    RedFieldPosition: 10
[   124.358]    GreenMaskSize: 5
[   124.358]    GreenFieldPosition: 5
[   124.358]    BlueMaskSize: 5
[   124.358]    BlueFieldPosition: 0
[   124.358]    RsvdMaskSize: 0
[   124.358]    RsvdFieldPosition: 0
[   124.358]    DirectColorModeInfo: 0
[   124.358]    PhysBasePtr: 0xd0000000

[   124.358]    LinBytesPerScanLine: 2560
[   124.358]    BnkNumberOfImagePages: 17
[   124.358]    LinNumberOfImagePages: 17
[   124.358]    LinRedMaskSize: 5
[   124.358]    LinRedFieldPosition: 10
[   124.358]    LinGreenMaskSize: 5
[   124.358]    LinGreenFieldPosition: 5
[   124.358]    LinBlueMaskSize: 5
[   124.358]    LinBlueFieldPosition: 0
[   124.358]    LinRsvdMaskSize: 0
[   124.358]    LinRsvdFieldPosition: 0
[   124.358]    MaxPixelClock: 400000000
[   124.359] Mode: 11a (1280x1024)
[   124.359]    ModeAttributes: 0xbb
[   124.359]    WinAAttributes: 0x7
[   124.359]    WinBAttributes: 0x0
[   124.359]    WinGranularity: 64
[   124.359]    WinSize: 64
[   124.359]    WinASegment: 0xa000
[   124.359]    WinBSegment: 0x0
[   124.359]    WinFuncPtr: 0xc0005dc7
[   124.359]    BytesPerScanline: 2560
[   124.359]    XResolution: 1280
[   124.359]    YResolution: 1024
[   124.359]    XCharSize: 8
[   124.359]    YCharSize: 16
[   124.359]    NumberOfPlanes: 1
[   124.359]    BitsPerPixel: 16
[   124.359]    NumberOfBanks: 1
[   124.359]    MemoryModel: 6
[   124.359]    BankSize: 0
[   124.359]    NumberOfImages: 17
[   124.359]    RedMaskSize: 5
[   124.359]    RedFieldPosition: 11
[   124.359]    GreenMaskSize: 6
[   124.359]    GreenFieldPosition: 5
[   124.359]    BlueMaskSize: 5
[   124.359]    BlueFieldPosition: 0
[   124.359]    RsvdMaskSize: 0
[   124.359]    RsvdFieldPosition: 0
[   124.359]    DirectColorModeInfo: 0
[   124.359]    PhysBasePtr: 0xd0000000
[   124.359]    LinBytesPerScanLine: 2560
[   124.359]    BnkNumberOfImagePages: 17
[   124.359]    LinNumberOfImagePages: 17

[   124.359]    LinRedMaskSize: 5
[   124.359]    LinRedFieldPosition: 11
[   124.359]    LinGreenMaskSize: 6
[   124.359]    LinGreenFieldPosition: 5
[   124.359]    LinBlueMaskSize: 5
[   124.359]    LinBlueFieldPosition: 0
[   124.359]    LinRsvdMaskSize: 0
[   124.359]    LinRsvdFieldPosition: 0
[   124.359]    MaxPixelClock: 400000000
[   124.361] Mode: 165 (1280x960)
[   124.361]    ModeAttributes: 0xbb
[   124.361]    WinAAttributes: 0x7
[   124.361]    WinBAttributes: 0x0
[   124.361]    WinGranularity: 64
[   124.361]    WinSize: 64
[   124.361]    WinASegment: 0xa000
[   124.361]    WinBSegment: 0x0
[   124.361]    WinFuncPtr: 0xc0005dc7
[   124.361]    BytesPerScanline: 2560
[   124.361]    XResolution: 1280
[   124.361]    YResolution: 960
[   124.361]    XCharSize: 8
[   124.361]    YCharSize: 16
[   124.361]    NumberOfPlanes: 1
[   124.361]    BitsPerPixel: 16
[   124.361]    NumberOfBanks: 1
[   124.361]    MemoryModel: 6
[   124.361]    BankSize: 0
[   124.361]    NumberOfImages: 19
[   124.361]    RedMaskSize: 5
[   124.361]    RedFieldPosition: 11
[   124.361]    GreenMaskSize: 6
[   124.361]    GreenFieldPosition: 5
[   124.361]    BlueMaskSize: 5
[   124.361]    BlueFieldPosition: 0
[   124.361]    RsvdMaskSize: 0
[   124.361]    RsvdFieldPosition: 0
[   124.361]    DirectColorModeInfo: 0
[   124.361]    PhysBasePtr: 0xd0000000
[   124.361]    LinBytesPerScanLine: 2560
[   124.361]    BnkNumberOfImagePages: 19
[   124.361]    LinNumberOfImagePages: 19
[   124.361]    LinRedMaskSize: 5
[   124.361]    LinRedFieldPosition: 11
[   124.361]    LinGreenMaskSize: 6

[   124.361]    LinGreenFieldPosition: 5
[   124.361]    LinBlueMaskSize: 5
[   124.361]    LinBlueFieldPosition: 0
[   124.361]    LinRsvdMaskSize: 0
[   124.361]    LinRsvdFieldPosition: 0
[   124.361]    MaxPixelClock: 400000000
[   124.362] *Mode: 166 (1280x960)
[   124.362]    ModeAttributes: 0xbb
[   124.362]    WinAAttributes: 0x7
[   124.362]    WinBAttributes: 0x0
[   124.362]    WinGranularity: 64
[   124.362]    WinSize: 64
[   124.362]    WinASegment: 0xa000
[   124.362]    WinBSegment: 0x0
[   124.362]    WinFuncPtr: 0xc0005dc7
[   124.362]    BytesPerScanline: 5120
[   124.362]    XResolution: 1280
[   124.362]    YResolution: 960
[   124.362]    XCharSize: 8
[   124.362]    YCharSize: 16
[   124.362]    NumberOfPlanes: 1
[   124.362]    BitsPerPixel: 32
[   124.362]    NumberOfBanks: 1
[   124.362]    MemoryModel: 6
[   124.362]    BankSize: 0
[   124.362]    NumberOfImages: 9
[   124.362]    RedMaskSize: 8
[   124.362]    RedFieldPosition: 16
[   124.362]    GreenMaskSize: 8
[   124.362]    GreenFieldPosition: 8
[   124.362]    BlueMaskSize: 8
[   124.362]    BlueFieldPosition: 0
[   124.362]    RsvdMaskSize: 0
[   124.362]    RsvdFieldPosition: 0
[   124.362]    DirectColorModeInfo: 0
[   124.362]    PhysBasePtr: 0xd0000000
[   124.362]    LinBytesPerScanLine: 5120
[   124.362]    BnkNumberOfImagePages: 9
[   124.362]    LinNumberOfImagePages: 9
[   124.362]    LinRedMaskSize: 8
[   124.362]    LinRedFieldPosition: 16
[   124.362]    LinGreenMaskSize: 8
[   124.362]    LinGreenFieldPosition: 8
[   124.362]    LinBlueMaskSize: 8
[   124.362]    LinBlueFieldPosition: 0

[   124.362]    LinRsvdMaskSize: 0
[   124.362]    LinRsvdFieldPosition: 0
[   124.362]    MaxPixelClock: 400000000
[   124.363] *Mode: 121 (640x480)
[   124.363]    ModeAttributes: 0xbb
[   124.363]    WinAAttributes: 0x7
[   124.363]    WinBAttributes: 0x0
[   124.363]    WinGranularity: 64
[   124.363]    WinSize: 64
[   124.363]    WinASegment: 0xa000
[   124.363]    WinBSegment: 0x0
[   124.363]    WinFuncPtr: 0xc0005dc7
[   124.364]    BytesPerScanline: 2560
[   124.364]    XResolution: 640
[   124.364]    YResolution: 480
[   124.364]    XCharSize: 8
[   124.364]    YCharSize: 16
[   124.364]    NumberOfPlanes: 1
[   124.364]    BitsPerPixel: 32
[   124.364]    NumberOfBanks: 1
[   124.364]    MemoryModel: 6
[   124.364]    BankSize: 0
[   124.364]    NumberOfImages: 39
[   124.364]    RedMaskSize: 8
[   124.364]    RedFieldPosition: 16
[   124.364]    GreenMaskSize: 8
[   124.364]    GreenFieldPosition: 8
[   124.364]    BlueMaskSize: 8
[   124.364]    BlueFieldPosition: 0
[   124.364]    RsvdMaskSize: 0
[   124.364]    RsvdFieldPosition: 0
[   124.364]    DirectColorModeInfo: 0
[   124.364]    PhysBasePtr: 0xd0000000
[   124.364]    LinBytesPerScanLine: 2560
[   124.364]    BnkNumberOfImagePages: 39
[   124.364]    LinNumberOfImagePages: 39
[   124.364]    LinRedMaskSize: 8
[   124.364]    LinRedFieldPosition: 16
[   124.364]    LinGreenMaskSize: 8
[   124.364]    LinGreenFieldPosition: 8
[   124.364]    LinBlueMaskSize: 8
[   124.364]    LinBlueFieldPosition: 0
[   124.364]    LinRsvdMaskSize: 0
[   124.364]    LinRsvdFieldPosition: 0
[   124.364]    MaxPixelClock: 400000000

[   124.365] *Mode: 122 (800x600)
[   124.365]    ModeAttributes: 0xbb
[   124.365]    WinAAttributes: 0x7
[   124.365]    WinBAttributes: 0x0
[   124.365]    WinGranularity: 64
[   124.365]    WinSize: 64
[   124.365]    WinASegment: 0xa000
[   124.365]    WinBSegment: 0x0
[   124.365]    WinFuncPtr: 0xc0005dc7
[   124.365]    BytesPerScanline: 3328
[   124.365]    XResolution: 800
[   124.365]    YResolution: 600
[   124.365]    XCharSize: 8
[   124.365]    YCharSize: 14
[   124.365]    NumberOfPlanes: 1
[   124.365]    BitsPerPixel: 32
[   124.365]    NumberOfBanks: 1
[   124.365]    MemoryModel: 6
[   124.365]    BankSize: 0
[   124.365]    NumberOfImages: 23
[   124.365]    RedMaskSize: 8
[   124.365]    RedFieldPosition: 16
[   124.365]    GreenMaskSize: 8
[   124.365]    GreenFieldPosition: 8
[   124.365]    BlueMaskSize: 8
[   124.365]    BlueFieldPosition: 0
[   124.365]    RsvdMaskSize: 0
[   124.365]    RsvdFieldPosition: 0
[   124.365]    DirectColorModeInfo: 0
[   124.365]    PhysBasePtr: 0xd0000000
[   124.365]    LinBytesPerScanLine: 3328
[   124.365]    BnkNumberOfImagePages: 23
[   124.365]    LinNumberOfImagePages: 23
[   124.365]    LinRedMaskSize: 8
[   124.365]    LinRedFieldPosition: 16
[   124.365]    LinGreenMaskSize: 8
[   124.365]    LinGreenFieldPosition: 8
[   124.365]    LinBlueMaskSize: 8
[   124.365]    LinBlueFieldPosition: 0
[   124.365]    LinRsvdMaskSize: 0
[   124.365]    LinRsvdFieldPosition: 0
[   124.365]    MaxPixelClock: 400000000
[   124.366] *Mode: 123 (1024x768)
[   124.366]    ModeAttributes: 0xbb
[   124.366]    WinAAttributes: 0x7

[   124.366]    WinBAttributes: 0x0
[   124.366]    WinGranularity: 64
[   124.366]    WinSize: 64
[   124.366]    WinASegment: 0xa000
[   124.366]    WinBSegment: 0x0
[   124.366]    WinFuncPtr: 0xc0005dc7
[   124.366]    BytesPerScanline: 4096
[   124.366]    XResolution: 1024
[   124.366]    YResolution: 768
[   124.366]    XCharSize: 8
[   124.366]    YCharSize: 16
[   124.366]    NumberOfPlanes: 1
[   124.366]    BitsPerPixel: 32
[   124.366]    NumberOfBanks: 1
[   124.366]    MemoryModel: 6
[   124.366]    BankSize: 0
[   124.366]    NumberOfImages: 14
[   124.366]    RedMaskSize: 8
[   124.366]    RedFieldPosition: 16
[   124.366]    GreenMaskSize: 8
[   124.366]    GreenFieldPosition: 8
[   124.366]    BlueMaskSize: 8
[   124.366]    BlueFieldPosition: 0
[   124.366]    RsvdMaskSize: 0
[   124.366]    RsvdFieldPosition: 0
[   124.366]    DirectColorModeInfo: 0
[   124.366]    PhysBasePtr: 0xd0000000
[   124.366]    LinBytesPerScanLine: 4096
[   124.367]    BnkNumberOfImagePages: 14
[   124.367]    LinNumberOfImagePages: 14
[   124.367]    LinRedMaskSize: 8
[   124.367]    LinRedFieldPosition: 16
[   124.367]    LinGreenMaskSize: 8
[   124.367]    LinGreenFieldPosition: 8
[   124.367]    LinBlueMaskSize: 8
[   124.367]    LinBlueFieldPosition: 0
[   124.367]    LinRsvdMaskSize: 0
[   124.367]    LinRsvdFieldPosition: 0
[   124.367]    MaxPixelClock: 400000000
[   124.368] *Mode: 124 (1280x1024)
[   124.368]    ModeAttributes: 0xbb
[   124.368]    WinAAttributes: 0x7
[   124.368]    WinBAttributes: 0x0
[   124.368]    WinGranularity: 64
[   124.368]    WinSize: 64

[   124.368]    WinASegment: 0xa000
[   124.368]    WinBSegment: 0x0
[   124.368]    WinFuncPtr: 0xc0005dc7
[   124.368]    BytesPerScanline: 5120
[   124.368]    XResolution: 1280
[   124.368]    YResolution: 1024
[   124.368]    XCharSize: 8
[   124.368]    YCharSize: 16
[   124.368]    NumberOfPlanes: 1
[   124.368]    BitsPerPixel: 32
[   124.368]    NumberOfBanks: 1
[   124.368]    MemoryModel: 6
[   124.368]    BankSize: 0
[   124.368]    NumberOfImages: 8
[   124.368]    RedMaskSize: 8
[   124.368]    RedFieldPosition: 16
[   124.368]    GreenMaskSize: 8
[   124.368]    GreenFieldPosition: 8
[   124.368]    BlueMaskSize: 8
[   124.368]    BlueFieldPosition: 0
[   124.368]    RsvdMaskSize: 0
[   124.368]    RsvdFieldPosition: 0
[   124.368]    DirectColorModeInfo: 0
[   124.368]    PhysBasePtr: 0xd0000000
[   124.368]    LinBytesPerScanLine: 5120
[   124.368]    BnkNumberOfImagePages: 8
[   124.368]    LinNumberOfImagePages: 8
[   124.368]    LinRedMaskSize: 8
[   124.368]    LinRedFieldPosition: 16
[   124.368]    LinGreenMaskSize: 8
[   124.368]    LinGreenFieldPosition: 8
[   124.368]    LinBlueMaskSize: 8
[   124.368]    LinBlueFieldPosition: 0
[   124.368]    LinRsvdMaskSize: 0
[   124.368]    LinRsvdFieldPosition: 0
[   124.368]    MaxPixelClock: 400000000
[   124.369] Mode: 145 (1400x1050)
[   124.369]    ModeAttributes: 0xbb
[   124.369]    WinAAttributes: 0x7
[   124.369]    WinBAttributes: 0x0
[   124.369]    WinGranularity: 64
[   124.369]    WinSize: 64
[   124.369]    WinASegment: 0xa000
[   124.369]    WinBSegment: 0x0
[   124.369]    WinFuncPtr: 0xc0005dc7

[   124.369]    BytesPerScanline: 2816
[   124.369]    XResolution: 1400
[   124.369]    YResolution: 1050
[   124.369]    XCharSize: 8
[   124.369]    YCharSize: 16
[   124.369]    NumberOfPlanes: 1
[   124.369]    BitsPerPixel: 16
[   124.369]    NumberOfBanks: 1
[   124.369]    MemoryModel: 6
[   124.369]    BankSize: 0
[   124.369]    NumberOfImages: 15
[   124.369]    RedMaskSize: 5
[   124.369]    RedFieldPosition: 11
[   124.369]    GreenMaskSize: 6
[   124.369]    GreenFieldPosition: 5
[   124.369]    BlueMaskSize: 5
[   124.369]    BlueFieldPosition: 0
[   124.369]    RsvdMaskSize: 0
[   124.369]    RsvdFieldPosition: 0
[   124.369]    DirectColorModeInfo: 0
[   124.369]    PhysBasePtr: 0xd0000000
[   124.369]    LinBytesPerScanLine: 2816
[   124.369]    BnkNumberOfImagePages: 15
[   124.369]    LinNumberOfImagePages: 15
[   124.369]    LinRedMaskSize: 5
[   124.369]    LinRedFieldPosition: 11
[   124.369]    LinGreenMaskSize: 6
[   124.369]    LinGreenFieldPosition: 5
[   124.369]    LinBlueMaskSize: 5
[   124.369]    LinBlueFieldPosition: 0
[   124.369]    LinRsvdMaskSize: 0
[   124.369]    LinRsvdFieldPosition: 0
[   124.369]    MaxPixelClock: 400000000
[   124.370] *Mode: 146 (1400x1050)
[   124.370]    ModeAttributes: 0xbb
[   124.370]    WinAAttributes: 0x7
[   124.370]    WinBAttributes: 0x0
[   124.370]    WinGranularity: 64
[   124.370]    WinSize: 64
[   124.370]    WinASegment: 0xa000
[   124.370]    WinBSegment: 0x0
[   124.370]    WinFuncPtr: 0xc0005dc7
[   124.370]    BytesPerScanline: 5632
[   124.370]    XResolution: 1400
[   124.370]    YResolution: 1050[   124.370]    XCharSize: 8
[   124.370]    YCharSize: 16
[   124.370]    NumberOfPlanes: 1
[   124.370]    BitsPerPixel: 32
[   124.370]    NumberOfBanks: 1
[   124.370]    MemoryModel: 6
[   124.370]    BankSize: 0
[   124.370]    NumberOfImages: 7
[   124.370]    RedMaskSize: 8
[   124.370]    RedFieldPosition: 16
[   124.370]    GreenMaskSize: 8
[   124.370]    GreenFieldPosition: 8
[   124.370]    BlueMaskSize: 8
[   124.370]    BlueFieldPosition: 0
[   124.370]    RsvdMaskSize: 0
[   124.371]    RsvdFieldPosition: 0
[   124.371]    DirectColorModeInfo: 0
[   124.371]    PhysBasePtr: 0xd0000000
[   124.371]    LinBytesPerScanLine: 5632
[   124.371]    BnkNumberOfImagePages: 7
[   124.371]    LinNumberOfImagePages: 7
[   124.371]    LinRedMaskSize: 8
[   124.371]    LinRedFieldPosition: 16
[   124.371]    LinGreenMaskSize: 8
[   124.371]    LinGreenFieldPosition: 8
[   124.371]    LinBlueMaskSize: 8
[   124.371]    LinBlueFieldPosition: 0
[   124.371]    LinRsvdMaskSize: 0
[   124.371]    LinRsvdFieldPosition: 0
[   124.371]    MaxPixelClock: 400000000
[   124.372] Mode: 175 (1600x1200)
[   124.372]    ModeAttributes: 0xba
[   124.372]    WinAAttributes: 0x7
[   124.372]    WinBAttributes: 0x0
[   124.372]    WinGranularity: 64
[   124.372]    WinSize: 64
[   124.372]    WinASegment: 0xa000
[   124.372]    WinBSegment: 0x0
[   124.372]    WinFuncPtr: 0xc0005dc7
[   124.372]    BytesPerScanline: 3200
[   124.372]    XResolution: 1600
[   124.372]    YResolution: 1200
[   124.372]    XCharSize: 8
[   124.372]    YCharSize: 16
[   124.372]    NumberOfPlanes: 1

[   124.372]    BitsPerPixel: 16
[   124.372]    NumberOfBanks: 1
[   124.372]    MemoryModel: 6
[   124.372]    BankSize: 0
[   124.372]    NumberOfImages: 12
[   124.372]    RedMaskSize: 5
[   124.372]    RedFieldPosition: 11
[   124.372]    GreenMaskSize: 6
[   124.372]    GreenFieldPosition: 5
[   124.372]    BlueMaskSize: 5
[   124.372]    BlueFieldPosition: 0
[   124.372]    RsvdMaskSize: 0
[   124.372]    RsvdFieldPosition: 0
[   124.372]    DirectColorModeInfo: 0
[   124.372]    PhysBasePtr: 0xd0000000
[   124.372]    LinBytesPerScanLine: 3200
[   124.372]    BnkNumberOfImagePages: 12
[   124.372]    LinNumberOfImagePages: 12
[   124.372]    LinRedMaskSize: 5
[   124.372]    LinRedFieldPosition: 11
[   124.372]    LinGreenMaskSize: 6
[   124.372]    LinGreenFieldPosition: 5
[   124.372]    LinBlueMaskSize: 5
[   124.372]    LinBlueFieldPosition: 0
[   124.372]    LinRsvdMaskSize: 0
[   124.372]    LinRsvdFieldPosition: 0
[   124.372]    MaxPixelClock: 400000000
[   124.374] Mode: 176 (1600x1200)
[   124.374]    ModeAttributes: 0xba
[   124.374]    WinAAttributes: 0x7
[   124.374]    WinBAttributes: 0x0
[   124.374]    WinGranularity: 64
[   124.374]    WinSize: 64
[   124.374]    WinASegment: 0xa000
[   124.374]    WinBSegment: 0x0
[   124.374]    WinFuncPtr: 0xc0005dc7
[   124.374]    BytesPerScanline: 6400
[   124.374]    XResolution: 1600
[   124.374]    YResolution: 1200
[   124.374]    XCharSize: 8
[   124.374]    YCharSize: 16
[   124.374]    NumberOfPlanes: 1
[   124.374]    BitsPerPixel: 32
[   124.374]    NumberOfBanks: 1
[   124.374]    MemoryModel: 6

[   124.374]    BankSize: 0
[   124.374]    NumberOfImages: 5
[   124.374]    RedMaskSize: 8
[   124.374]    RedFieldPosition: 16
[   124.374]    GreenMaskSize: 8
[   124.374]    GreenFieldPosition: 8
[   124.374]    BlueMaskSize: 8
[   124.374]    BlueFieldPosition: 0
[   124.374]    RsvdMaskSize: 0
[   124.374]    RsvdFieldPosition: 0
[   124.374]    DirectColorModeInfo: 0
[   124.374]    PhysBasePtr: 0xd0000000
[   124.374]    LinBytesPerScanLine: 6400
[   124.374]    BnkNumberOfImagePages: 5
[   124.374]    LinNumberOfImagePages: 5
[   124.374]    LinRedMaskSize: 8
[   124.374]    LinRedFieldPosition: 16
[   124.374]    LinGreenMaskSize: 8
[   124.374]    LinGreenFieldPosition: 8
[   124.374]    LinBlueMaskSize: 8
[   124.374]    LinBlueFieldPosition: 0
[   124.374]    LinRsvdMaskSize: 0
[   124.374]    LinRsvdFieldPosition: 0
[   124.374]    MaxPixelClock: 400000000
[   124.375] Mode: 1d2 (1920x1080)
[   124.375]    ModeAttributes: 0xbb
[   124.375]    WinAAttributes: 0x7
[   124.375]    WinBAttributes: 0x0
[   124.375]    WinGranularity: 64
[   124.375]    WinSize: 64
[   124.375]    WinASegment: 0xa000
[   124.375]    WinBSegment: 0x0
[   124.375]    WinFuncPtr: 0xc0005dc7
[   124.375]    BytesPerScanline: 3840
[   124.375]    XResolution: 1920
[   124.375]    YResolution: 1080
[   124.375]    XCharSize: 8
[   124.375]    YCharSize: 16
[   124.375]    NumberOfPlanes: 1
[   124.376]    BitsPerPixel: 16
[   124.376]    NumberOfBanks: 1
[   124.376]    MemoryModel: 6
[   124.376]    BankSize: 0
[   124.376]    NumberOfImages: 11
[   124.376]    RedMaskSize: 5

[   124.376]    RedFieldPosition: 11
[   124.376]    GreenMaskSize: 6
[   124.376]    GreenFieldPosition: 5
[   124.376]    BlueMaskSize: 5
[   124.376]    BlueFieldPosition: 0
[   124.376]    RsvdMaskSize: 0
[   124.376]    RsvdFieldPosition: 0
[   124.376]    DirectColorModeInfo: 0
[   124.376]    PhysBasePtr: 0xd0000000
[   124.376]    LinBytesPerScanLine: 3840
[   124.376]    BnkNumberOfImagePages: 11
[   124.376]    LinNumberOfImagePages: 11
[   124.376]    LinRedMaskSize: 5
[   124.376]    LinRedFieldPosition: 11
[   124.376]    LinGreenMaskSize: 6
[   124.376]    LinGreenFieldPosition: 5
[   124.376]    LinBlueMaskSize: 5
[   124.376]    LinBlueFieldPosition: 0
[   124.376]    LinRsvdMaskSize: 0
[   124.376]    LinRsvdFieldPosition: 0
[   124.376]    MaxPixelClock: 400000000
[   124.377] *Mode: 1d4 (1920x1080)
[   124.377]    ModeAttributes: 0xbb
[   124.377]    WinAAttributes: 0x7
[   124.377]    WinBAttributes: 0x0
[   124.377]    WinGranularity: 64
[   124.377]    WinSize: 64
[   124.377]    WinASegment: 0xa000
[   124.377]    WinBSegment: 0x0
[   124.377]    WinFuncPtr: 0xc0005dc7
[   124.377]    BytesPerScanline: 7680
[   124.377]    XResolution: 1920
[   124.377]    YResolution: 1080
[   124.377]    XCharSize: 8
[   124.377]    YCharSize: 16
[   124.377]    NumberOfPlanes: 1
[   124.377]    BitsPerPixel: 32
[   124.377]    NumberOfBanks: 1
[   124.377]    MemoryModel: 6
[   124.377]    BankSize: 0
[   124.377]    NumberOfImages: 5
[   124.377]    RedMaskSize: 8
[   124.377]    RedFieldPosition: 16
[   124.377]    GreenMaskSize: 8
[   124.377]    GreenFieldPosition: 8

[   124.377]    BlueMaskSize: 8
[   124.377]    BlueFieldPosition: 0
[   124.377]    RsvdMaskSize: 0
[   124.377]    RsvdFieldPosition: 0
[   124.377]    DirectColorModeInfo: 0
[   124.377]    PhysBasePtr: 0xd0000000
[   124.377]    LinBytesPerScanLine: 7680
[   124.377]    BnkNumberOfImagePages: 5
[   124.377]    LinNumberOfImagePages: 5
[   124.377]    LinRedMaskSize: 8
[   124.377]    LinRedFieldPosition: 16
[   124.377]    LinGreenMaskSize: 8
[   124.377]    LinGreenFieldPosition: 8
[   124.377]    LinBlueMaskSize: 8
[   124.377]    LinBlueFieldPosition: 0
[   124.377]    LinRsvdMaskSize: 0
[   124.377]    LinRsvdFieldPosition: 0
[   124.377]    MaxPixelClock: 400000000
[   124.378] Mode: 1d8 (1280x720)
[   124.378]    ModeAttributes: 0xbb
[   124.378]    WinAAttributes: 0x7
[   124.378]    WinBAttributes: 0x0
[   124.378]    WinGranularity: 64
[   124.378]    WinSize: 64
[   124.378]    WinASegment: 0xa000
[   124.378]    WinBSegment: 0x0
[   124.378]    WinFuncPtr: 0xc0005dc7
[   124.378]    BytesPerScanline: 2560
[   124.378]    XResolution: 1280
[   124.378]    YResolution: 720
[   124.378]    XCharSize: 8
[   124.378]    YCharSize: 16
[   124.378]    NumberOfPlanes: 1
[   124.378]    BitsPerPixel: 16
[   124.378]    NumberOfBanks: 1
[   124.378]    MemoryModel: 6
[   124.378]    BankSize: 0
[   124.378]    NumberOfImages: 25
[   124.378]    RedMaskSize: 5
[   124.378]    RedFieldPosition: 11
[   124.378]    GreenMaskSize: 6
[   124.378]    GreenFieldPosition: 5
[   124.378]    BlueMaskSize: 5
[   124.378]    BlueFieldPosition: 0
[   124.378]    RsvdMaskSize: 0[   124.378]    RsvdFieldPosition: 0
[   124.378]    DirectColorModeInfo: 0
[   124.378]    PhysBasePtr: 0xd0000000
[   124.378]    LinBytesPerScanLine: 2560
[   124.378]    BnkNumberOfImagePages: 25
[   124.378]    LinNumberOfImagePages: 25
[   124.378]    LinRedMaskSize: 5
[   124.378]    LinRedFieldPosition: 11
[   124.378]    LinGreenMaskSize: 6
[   124.378]    LinGreenFieldPosition: 5
[   124.378]    LinBlueMaskSize: 5
[   124.379]    LinBlueFieldPosition: 0
[   124.379]    LinRsvdMaskSize: 0
[   124.379]    LinRsvdFieldPosition: 0
[   124.379]    MaxPixelClock: 400000000
[   124.380] *Mode: 1d9 (1280x720)
[   124.380]    ModeAttributes: 0xbb
[   124.380]    WinAAttributes: 0x7
[   124.380]    WinBAttributes: 0x0
[   124.380]    WinGranularity: 64
[   124.380]    WinSize: 64
[   124.380]    WinASegment: 0xa000
[   124.380]    WinBSegment: 0x0
[   124.380]    WinFuncPtr: 0xc0005dc7
[   124.380]    BytesPerScanline: 5120
[   124.380]    XResolution: 1280
[   124.380]    YResolution: 720
[   124.380]    XCharSize: 8
[   124.380]    YCharSize: 16
[   124.380]    NumberOfPlanes: 1
[   124.380]    BitsPerPixel: 32
[   124.380]    NumberOfBanks: 1
[   124.380]    MemoryModel: 6
[   124.380]    BankSize: 0
[   124.380]    NumberOfImages: 12
[   124.380]    RedMaskSize: 8
[   124.380]    RedFieldPosition: 16
[   124.380]    GreenMaskSize: 8
[   124.380]    GreenFieldPosition: 8
[   124.380]    BlueMaskSize: 8
[   124.380]    BlueFieldPosition: 0
[   124.380]    RsvdMaskSize: 0
[   124.380]    RsvdFieldPosition: 0
[   124.380]    DirectColorModeInfo: 0
[   124.380]    PhysBasePtr: 0xd0000000

[   124.380]    LinBytesPerScanLine: 5120
[   124.380]    BnkNumberOfImagePages: 12
[   124.380]    LinNumberOfImagePages: 12
[   124.380]    LinRedMaskSize: 8
[   124.380]    LinRedFieldPosition: 16
[   124.380]    LinGreenMaskSize: 8
[   124.380]    LinGreenFieldPosition: 8
[   124.380]    LinBlueMaskSize: 8
[   124.380]    LinBlueFieldPosition: 0
[   124.380]    LinRsvdMaskSize: 0
[   124.380]    LinRsvdFieldPosition: 0
[   124.380]    MaxPixelClock: 400000000
[   124.380]
[   124.380] (II) VESA(0): Total Memory: 768 64KB banks (49152kB)
[   124.380] (II) VESA(0): <default monitor>: Using hsync range of 
30.00-81.00 kHz
[   124.380] (II) VESA(0): <default monitor>: Using vrefresh range of 
56.00-61.00 Hz
[   124.380] (II) VESA(0): <default monitor>: Using maximum pixel clock 
of 175.00 MHz
[   124.380] (WW) VESA(0): Unable to estimate virtual size
[   124.380] (II) VESA(0): Not using built-in mode "1400x1050" (no mode 
of this name)
[   124.380] (II) VESA(0): Not using built-in mode "1280x1024" (no mode 
of this name)
[   124.380] (II) VESA(0): Not using built-in mode "1280x960" (no mode 
of this name)
[   124.380] (II) VESA(0): Not using built-in mode "1280x720" (no mode 
of this name)
[   124.380] (II) VESA(0): Not using built-in mode "1024x768" (no mode 
of this name)
[   124.380] (II) VESA(0): Not using built-in mode "800x600" (no mode of 
this name)
[   124.380] (II) VESA(0): Not using built-in mode "640x480" (no mode of 
this name)
[   124.380] (II) VESA(0): Virtual size is 1920x1080 (pitch 1920)
[   124.380] (**) VESA(0): *Built-in mode "1920x1080"
[   124.380] (**) VESA(0): Display dimensions: (480, 270) mm
[   124.380] (**) VESA(0): DPI set to (101, 101)
[   124.380] (**) VESA(0): Using "Shadow Framebuffer"
[   124.380] (II) Loading sub module "shadow"
[   124.380] (II) LoadModule: "shadow"
[   124.380] (II) Loading /usr/lib/xorg/modules/libshadow.so
[   124.382] (II) Module shadow: vendor="X.Org Foundation"
[   124.382]    compiled for 1.21.1.4, module version = 1.1.0
[   124.382]    ABI class: X.Org ANSI C Emulation, version 0.4
[   124.382] (II) Loading sub module "fb"
[   124.382] (II) LoadModule: "fb"
[   124.382] (II) Module "fb" already built-in
[   124.382] (II) UnloadModule: "radeon"
[   124.382] (II) Unloading radeon
[   124.382] (II) Loading sub module "int10"
[   124.382] (II) LoadModule: "int10"
[   124.382] (II) Loading /usr/lib/xorg/modules/libint10.so
[   124.382] (II) Module int10: vendor="X.Org Foundation"

[   124.382]    compiled for 1.21.1.4, module version = 1.0.0
[   124.382]    ABI class: X.Org Video Driver, version 25.2
[   124.382] (II) VESA(0): initializing int10
[   124.382] (II) VESA(0): Primary V_BIOS segment is: 0xc000
[   124.383] (II) VESA(0): VESA BIOS detected
[   124.383] (II) VESA(0): VESA VBE Version 3.0
[   124.383] (II) VESA(0): VESA VBE Total Mem: 49152 kB
[   124.383] (II) VESA(0): VESA VBE OEM: AMD ATOMBIOS
[   124.383] (II) VESA(0): VESA VBE OEM Software Rev: 20.4
[   124.383] (II) VESA(0): VESA VBE OEM Vendor: (C) 1988-2020, Advanced 
Micro Devices, Inc.
[   124.383] (II) VESA(0): VESA VBE OEM Product: NAVI24
[   124.383] (II) VESA(0): VESA VBE OEM Product Rev: 01.00
[   124.383] (II) VESA(0): virtual address = 0x7fe58c200000, VGAbase = 
0x7fe58f8cd000
         physical address = 0xd0000000, size = 50331648
[   124.395] (II) VESA(0): Setting up VESA Mode 0x1D4 (1920x1080)
[   124.396] (II) VESA(0): VBESetVBEMode failed


-------------------------------------------------------

Sorry for the long post.

Thanks in advance.  For more information you will have to email me 
directly as I'm not on the list.

Bob













