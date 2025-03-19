Return-Path: <linux-kernel+bounces-567293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C06A6843E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C90173A31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FFE212B0B;
	Wed, 19 Mar 2025 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbI17ZTr"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7718C31;
	Wed, 19 Mar 2025 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359326; cv=none; b=BW3BNHa/GoqUsyNSMX7dqsixqJPtwJiufFTc5AGXgYOLvcdc1gF9GDoH/arEoOpSHV9A9aAd62bRmHdC1sYMillckJOR5yZuUIsYz5yScGIcXvK17a2llFjSa1r6mZ9tBHEL3pugGjioJgKHYZF3bm2wbBaY1WvsSmaDAx9s0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359326; c=relaxed/simple;
	bh=3uIVBmnj+0SZYe9IOIhAyUKLfiUZ/7QQU5HJ0n1CyEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLFLRv7QJ3EWiIFhsrRsrpc7Md5EIhd5QCFHsb0gQ7twQYf+lJ+J1ayoXGTeco1H9eux2AjwoTLroh6k91nbE+Xjq6Epa/0yUMErGv2qZ1GEaIBR/C7lqbRq+YSkG6kZDIm7ahgnqT6pdkejrmtAlG0e0WNbGdQHxDPKSdMucUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbI17ZTr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22403cbb47fso120621755ad.0;
        Tue, 18 Mar 2025 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742359325; x=1742964125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uIVBmnj+0SZYe9IOIhAyUKLfiUZ/7QQU5HJ0n1CyEs=;
        b=QbI17ZTrSskOjTBjslfRwSU2iJb4XweU4TzvMk/azhynoQJLue5JmeZa9K4ELW1SHp
         G6QCSHjn89xZCUTdldQ3A854VRtFqRA2cX2HNxOHLBJSLbxI6C1tjEqMt6ekPuq8W0qd
         dly6/VpnJifsrBqHuUcoiC+zPg6K6d/FMsiVoqUYlsOfsqUlGhML2ZpasnaCZUgiSk1Z
         D8jPafHd2+AcKiLHAix8Pm+WfUDeOXF3RGdk61EmkrvnTJ0uVTWrz8RUMlRlqk0mtun7
         H2WZVpipXZniwn4I55vHK3GPYSYoBec4DV1V/gK5C+QW2Pc1hHRH7i/tg458+yQ/Jp3j
         JOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742359325; x=1742964125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uIVBmnj+0SZYe9IOIhAyUKLfiUZ/7QQU5HJ0n1CyEs=;
        b=NyoPaMLdWtKX0t8Kb15XS9dzSsAtpjIQPWJ9OnODWcgHkpVDzh288tkpGAiqTJR/HK
         fE4R/BVfs3XtQH9qk69j8CW9zn2kxWp9oKj1lyzBZUjbBeutx2gqSdITKt8CCo4E7MM7
         CvevgK3kME/aG3jqkry1Pr4qIwm6KUKoRD2iyGdWKUq4PcOGEEoa0mcdZnUN7lIp/qoi
         GgdY1wf4Lau0Jp+kvd3ptZKBL+7M1ndrgzUk1SGw6kADFNmFGNHpR5+99Forka9L0OcQ
         DLwFcFYNnv4XgweWiJnMhQeyt6Oj+uzE0Gfoq+WjVCF/Lbw68brg9HzdzOMPvALEfmax
         tVTA==
X-Forwarded-Encrypted: i=1; AJvYcCVIjpEo472b/Cs/kJQrb7eH5JxDyLn2wEE8WQSiuIESJBiwxFZFT47HQ1+a5Cj9X/xqCrFFghgwNwc=@vger.kernel.org, AJvYcCWVhLqPH37mUR59Lerb2JBxXTjw/QkGiapUk3YtuNZLcPbSwFexmgmegAWdG5RVNeVONOs7UeTA6W+6U2k35+JCBuyo8g==@vger.kernel.org, AJvYcCWpHOInR04ePGB4gV5Cg57hiCTX4xXLdXT4kH2oC49wfstpgSY2Hl1yDZL9J5Oc1aPeGpKpRIwqIED+Gx8A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KGxE/LaQjXUdr4IotqD8c2FBRguSvnPxcjmC/DjYIt+7b/zA
	HX+pWWZKBgb0RrmecSLgepSQ6+goAcW9Rj9qtaLndegB6q91jTwQ
X-Gm-Gg: ASbGncvUQUCBcw5xYPGjMnHKHi9a4E7Xof5ico9Goz3hyEYd8e5mqK6CBa49KGHuRBR
	0/WFV30tcuVnFNXalfXqTtuQ5+xbGuo3w4TdIE/6rs0R6nSJnVPiR5yDf0tfQUTDYy4GhJvBI80
	E4dvUDaB48BmxPCq7LD6Q/tKQXHk+JO7ZuUOOIpSvMjn1jQyBjAmcTCelDebhKraXKA4GFa9Lfy
	pbMBleA3ile/o3hts0lW76NElJqXudRK4djVNyu0m7RxDCO56qZhcDIxEZpfUMZWm87iJ7MWo0T
	Btte0rPTf3VruC126bVx0PyQhCy4Pj1WzOoldk+CJRfM
X-Google-Smtp-Source: AGHT+IHWuCBhKEsjXtQ4DIJZBQJLUoo82IC6D7js71gbV+WlwvYHFZsnSowow/tW3UPppH+xZYqHVg==
X-Received: by 2002:a05:6a21:9209:b0:1f5:a3e8:64c1 with SMTP id adf61e73a8af0-1fbe872776dmr2496671637.0.1742359324570;
        Tue, 18 Mar 2025 21:42:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7bd6asm8287677a12.50.2025.03.18.21.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 21:42:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 51444424184A; Wed, 19 Mar 2025 11:41:58 +0700 (WIB)
Date: Wed, 19 Mar 2025 11:41:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6 RESEND] platform/x86: Add lenovo-wmi-* driver
 Documentation
Message-ID: <Z9pLFaSOPCF7G40s@archie.me>
References: <20250317144326.5850-1-derekjohn.clark@gmail.com>
 <20250317144326.5850-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GdRlsZOwyvMtMSuy"
Content-Disposition: inline
In-Reply-To: <20250317144326.5850-2-derekjohn.clark@gmail.com>


--GdRlsZOwyvMtMSuy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 07:43:21AM -0700, Derek J. Clark wrote:
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Lenovo WMI Interface Gamezone Driver (lenovo-wmi-gamezone)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
><snipped>...
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Lenovo WMI Interface Other Mode Driver (lenovo-wmi-other)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I get htmldocs warnings due to SPDX line not being separated with title
heading:

Documentation/wmi/devices/lenovo-wmi-gamezone.rst:2: WARNING: Explicit mark=
up ends without a blank line; unexpected unindent. [docutils]
Documentation/wmi/devices/lenovo-wmi-other-method.rst:2: WARNING: Explicit =
markup ends without a blank line; unexpected unindent. [docutils]

> +The Other Mode WMI interface uses the firmware_attributes class to expose
> +various WMI attributes provided by the interface in the sysfs. This enab=
les
> +CPU and GPU power limit tuning as well as various other attributes for
> +devices that fall under the "Gaming Series" of Lenovo devices. Each
> +attribute exposed by the Other Mode interface has corresponding
> +capability data blocks which allow the driver to probe details about the
> +attribute. Each attribute has multiple pages, one for each of the platfo=
rm
> +profiles managed by the Gamezone interface. Attributes are exposed in sy=
sfs
> +under the following path:
> +
> +::
> +/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/

sysfs path above isn't outputted as literal code block as it lacks indentat=
ion
in the block text.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--GdRlsZOwyvMtMSuy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9pLEQAKCRD2uYlJVVFO
o9eDAQDkjcdVaXzTHoVPhRpjAY1s2w46xgH5RSS8aiz5eUZ0FwD9FbKfUepNlJbO
8/CROdX8dQN64Vk77DLbiNEsoc5UMAk=
=f2uF
-----END PGP SIGNATURE-----

--GdRlsZOwyvMtMSuy--

