Return-Path: <linux-kernel+bounces-563439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F6A641DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E589B188F775
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D145219EAD;
	Mon, 17 Mar 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUQp0JvD"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF421931B;
	Mon, 17 Mar 2025 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193622; cv=none; b=hulZ69SgFeY8XVkqjr7tNF+oIzXqyM+VgO5DBkoYYw7sxF6yI8Uxhm7MvuQiwA51jyacklb3loDaokyZvRYYzV2KUdBF9jJ3ula4V5PyRRDumW3ZI0AF73UTqHhVy08s8RgLBkwJ32tH0ZheXam0Q+1eKiPJq1WfeHJhJlrZa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193622; c=relaxed/simple;
	bh=zzk4mS2ouvlwknp5wkyygJtV7VT4S7Kc374rDxcdDhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhMVPdX1zUA+xD4aBAdR8UX30DzoIi4dJT9lbxQrZSQwXlTirW4F39oAGPv0nDQWmrMogIuTHK6KKOkLvEhK9+wQHtvjkmJN7yuq3uLSYwV3tLVZvSUxwBWVawKO0jIUTt+1bxQmuyHaY9eSsHqQWAYTBfBDCe3+2+FQA1TinFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUQp0JvD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fc176825so36371606d6.0;
        Sun, 16 Mar 2025 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193620; x=1742798420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpYp1sWwQErQLR470cKM+5ZRvUm9FDPScwHkEhF5p1A=;
        b=EUQp0JvDn+5YFKXQZCIQ5ilQ7UjUnrSE6J2HuZQNOsd5nrS5V5CuGPceSUdbQDMmaP
         rFNssHjyfNtr5vZT8iSkxaB09aO2qWVZaUnPxsDFD1DrT5g1et52L597sGsKqdASwQJS
         5TK0dKLWgLVBnJqCkt5DXyEf0cAkZVrpitdkSYaYd+NByU23RNgIyrWGE3IlXXROwsk/
         1d25CIPZFwFMEijbc8zxMDjHbOaDuNGcZJw6RW4+4A6lVsSQ2eFYK9uIO5/ba2C3vStn
         yG1PklrlB1bPmUT0PisHPqCb1XSBpVQ5HO1ObynxjM1x1p7CPE+/e0IH/RGeMCdCYIsO
         kRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193620; x=1742798420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpYp1sWwQErQLR470cKM+5ZRvUm9FDPScwHkEhF5p1A=;
        b=jJT4TLbYpk71WmnsnwCEc3m41q56ltcoy7CANa9jBgEMDbp05k2lBWpNUgYcGbSHHS
         agzq0nSnhxdWzWg6qkjH/CfZTFtHhAUbee0icsWVMeFSgR6rv4qlzBG0zA9ATj4RCyhc
         W/2TCVFthImGNQ5vx2GYX+Hl5CxPDe3qVRq0KH6KDw1pf8oByqHw0gYyQYWG6/vAWPhe
         8T3W7nPNvBE2yy4CgUrGS22wVxOUMrPBiOIq8yvkcec6QnITtf6U7XQQBXH3VO0RWLOO
         egO6xFsDYi4b4al9FYgklUqZJHDx+z+uMmbHSDlolKSXHtw4NAfdaSnjPu1+ZO6UA+/U
         LUzw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSy0BdWnUlUzTj6H5CzTCjTCCXBeMNnf2eQbcXkpbt21GDZNJH1MMeEXdibdTfFuhqrc/Hzg/SQKj8Usm@vger.kernel.org, AJvYcCUeUsmuJrtUv5rXY9tY9niUmlBlS3/Trc1NoTzHQwC6LTyaGDk6svHpxBpvsBNh9mcCbSPmCjrrietq+z2AXIfrJMAtuw==@vger.kernel.org, AJvYcCWEsSBBjPqSdcGo3DqdnaDLLgdrELHl7w0/NtpAxt/xdrFI5YmoaJNTszu0U7mYAOBaWqhTNhvhS/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pYhDyV36KgJCWgj0bsbPMevErt9sFXCvMvxtQgX3ok2S2r6n
	JUZ7cK0OxfbLH3TRDsD17Kw1QqlznWNqXPLexkqGM8hZxv6CEuXLEZKrzOc8Q6dYlpubQSiy64x
	Sk3MdKc18xy92v0STHKtZKZZ/RKU=
X-Gm-Gg: ASbGncuAdO49+h9sSBQEF8mU5LieJywyr8v5qEeBYilRHX9CINwSY6yN5Ds6/pYHMyC
	t14v5UiAMWu5CyAL978kXRQc0jXLYBs4REn/tPKLtWZO955NA1YPJVDznKDyfqq0pDRYqK7S1gE
	WBmPEVu87WigrZ/dRpthEKVQYfuto=
X-Google-Smtp-Source: AGHT+IHMZYgz/MuSsByro3MRuFo1ySupyV51QFkq+6zKs1xyNTFpahk+3oKqGPCUM96xf2hP5L+Q8scMsRilufWFx6o=
X-Received: by 2002:a05:6214:496:b0:6e8:f166:b1a0 with SMTP id
 6a1803df08f44-6eaeab05fc1mr206814606d6.36.1742193620004; Sun, 16 Mar 2025
 23:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317063337.352966-1-derekjohn.clark@gmail.com>
In-Reply-To: <20250317063337.352966-1-derekjohn.clark@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sun, 16 Mar 2025 23:40:09 -0700
X-Gm-Features: AQ5f1JoiAIfCeAqSNTVEdS2wSK2hq5pN7LIAWbDK-uGT-q-cmlWU_bGLNgykOzE
Message-ID: <CAFqHKTmGo2CG43gOCFPnWiF5zSJgV8=yV=PzR7y8kfXvYvq0eA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] platform/x86: Add Lenovo Gaming Series WMI Drivers
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
	Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>, 
	Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, "Cody T . -H . Chiu" <codyit@gmail.com>, 
	John Martens <johnfanv2@gmail.com>, platform-driver-x86@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 11:33=E2=80=AFPM Derek J. Clark
<derekjohn.clark@gmail.com> wrote:
>
> Adds support for the Lenovo "Gaming Series" of laptop hardware that use
> WMI interfaces that control various power settings. There are multiple WM=
I
> interfaces that work in concert to provide getting and setting values as
> well as validation of input. Currently only the "Gamezone", "Other
> Mode", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, but
> I attempted to structure the driver so that adding the "Custom Mode",
> "Lighting", and other data block interfaces would be trivial in a later
> patches.
>
> This driver is distinct from, but should be considered a replacement for
> this patch:
> https://lore.kernel.org/all/20241118100503.14228-1-jonmail@163.com/
>
> This driver attempts to standardize the exposed sysfs by mirroring the
> asus-armoury driver currently under review. As such, a lot of
> inspiration has been drawn from that driver.
> https://lore.kernel.org/platform-driver-x86/20250316230724.100165-1-luke@=
ljones.dev/
>
> The drivers have been tested by me on the Lenovo Legion Go and Legion Go
> S.
>
> Suggested-by: Mario Limonciello <superm1@kernel.org>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v4:
>  - Added lenovo-wmi-events driver
>  - Added headers for every driver
>  - Fixes requested from v3 review
> v3:
> https://lore.kernel.org/platform-driver-x86/20250225220037.16073-1-derekj=
ohn.clark@gmail.com/
> v2:
> https://lore.kernel.org/platform-driver-x86/20250102004854.14874-1-derekj=
ohn.clark@gmail.com/
> v1:
> https://lore.kernel.org/platform-driver-x86/20241217230645.15027-1-derekj=
ohn.clark@gmail.com/
> Derek J. Clark (6):
>   platform/x86: Add lenovo-wmi-* driver Documentation
>   platform/x86: Add lenovo-wmi-helpers
>   platform/x86: Add Lenovo WMI Events Driver
>   platform/x86: Add Lenovo Capability Data 01 WMI Driver
>   platform/x86: Add Lenovo Other Mode WMI Driver
>   platform/x86: Add Lenovo Gamezone WMI Driver
>
>  .../wmi/devices/lenovo-wmi-gamezone.rst       | 203 ++++++
>  .../wmi/devices/lenovo-wmi-other-method.rst   | 108 +++
>  MAINTAINERS                                   |  17 +
>  drivers/platform/x86/Kconfig                  |  40 ++
>  drivers/platform/x86/Makefile                 |   5 +
>  drivers/platform/x86/lenovo-wmi-capdata01.c   | 136 ++++
>  drivers/platform/x86/lenovo-wmi-capdata01.h   |  29 +
>  drivers/platform/x86/lenovo-wmi-events.c      | 132 ++++
>  drivers/platform/x86/lenovo-wmi-events.h      |  21 +
>  drivers/platform/x86/lenovo-wmi-gamezone.c    | 380 +++++++++++
>  drivers/platform/x86/lenovo-wmi-gamezone.h    |  18 +
>  drivers/platform/x86/lenovo-wmi-helpers.c     |  64 ++
>  drivers/platform/x86/lenovo-wmi-helpers.h     |  24 +
>  drivers/platform/x86/lenovo-wmi-other.c       | 626 ++++++++++++++++++
>  drivers/platform/x86/lenovo-wmi-other.h       |  19 +
>  15 files changed, 1822 insertions(+)
>  create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>  create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst
>  create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.h
>  create mode 100644 drivers/platform/x86/lenovo-wmi-events.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-events.h
>  create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.h
>  create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.h
>  create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-other.h
>
> --
> 2.49.0
>

All,

I accidentally attached some misnamed patches that I didn't realize
got duplicated. The correct patches are all v4 X/6. Apologies for the
confusion.

Cheers,
Derek.

