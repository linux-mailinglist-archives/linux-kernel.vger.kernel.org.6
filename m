Return-Path: <linux-kernel+bounces-576130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1BA70B58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F719A1425
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539EA266572;
	Tue, 25 Mar 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlXX0U2b"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D61EB9F4;
	Tue, 25 Mar 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933693; cv=none; b=VKQP4oyXUNKeUIay/un26LPSinKdZDE8NISqIfee9gcTcfEf4TKCYM3pnlOU/MJbqG98DSJjfkGz626XHTYQkyF8u1MPEHCKB8mZ2CVe+Hnf0DRTUiFf7/kc6S2zepFpGOmNnw92YX6EhMXgHxJRL1eEIMihFzho03MAA3RErt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933693; c=relaxed/simple;
	bh=1wmk2PFPiV4WoTPGZqqAvcvR0KTYNxn6noPKr2YRJtM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=epqes41cGcdhXyh0d9tOpuZb9RgMejmWh32LgfvVTrFeJpvhR3D+ujECVLEazhRncHlolCGPthDghnNS9+vpyzF1jY9e5RmREHIuG52zCDom1OKuMKu94oWrL/UJ2QxjEeZCllzlwVX2YGWxGdkU9ZBjQbgCjmi8tsJz/DlAm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlXX0U2b; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22398e09e39so125847565ad.3;
        Tue, 25 Mar 2025 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933691; x=1743538491; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HBinAcb/wy6AurK5zBu8Umuiu3SbLvkoHxzpLsX8Io=;
        b=VlXX0U2blaonST9KZt/rU2exrNANZF7nklZ/l/nUFXMIDxRsB7x7gGAveGQ6vwCsxh
         gNzeanZqK0r5WAvU0dMyCsMTZsRbJABflCxJXuWRAJcEfESVv/Or44GHTbvTtOacDxR/
         Bv1gaOzNWli2ytEyDIMxF1p8tMWNUz0+9USzYTXzbnjUqajg9t5rpcHQU7Ui1jMsH+9i
         P30Z+IN1A5wvwk72ff9iZ/OBCGKQUXarPaFzXDgszDKJ1fm2lBna1Lydl7ZYlu/VPbjG
         vSX5v8PZ3S/7oQzGRICvlxP66BcrK9n4zwkHy+CnGWToik1X3hKCvYijrPpl7B2UkoAn
         NJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933691; x=1743538491;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HBinAcb/wy6AurK5zBu8Umuiu3SbLvkoHxzpLsX8Io=;
        b=MiYi3DMkHPldSrVpP3HASOas4uwMhI9tBt9GrjhVlz1NhSy9I15QVkM9Azy2N1mBCh
         YBBtzu+xfUlJ8+Yy1Vlts0QRAnLL2Jth2FFZUmJ1vk4VVpcZGtilC28l0FBQ1Ofx5IXo
         JY3SP5QzPSVSVsKZF6L7xbmokJwifhvQqIxYv5begobkFhG6Xi6qRa8BwugYY0zV3gyg
         gqRWrs3pSFv4ZyKOOXR/CQn+cW7ZhdquoDDEdEKbrAtGhaTHDwTQAk8ZLZriL6PHnykw
         EmQbJ/2DDze3LMTeJmo5uiOXInV/qjUpstu+YBl7ztaQ1TtM4h8wI2VaTGOpFp/NtgoB
         6mFA==
X-Forwarded-Encrypted: i=1; AJvYcCVBlgzyXgttNrBLqJCN0tHZtyID1BEnQJdqgG8uf9Gn+KHTe8BfRUu2tRYdlFEUGkkV1UmBNcLIM8idQc635XGyKfZV3Q==@vger.kernel.org, AJvYcCVMOUVXT4wkgIDRgrN6W/M0k0jYTBdG/u6gPP7aYamewMmCfHGpJPXVDo/mxgQ+kWI3sQeHLlypOiEF+A==@vger.kernel.org, AJvYcCXbHEfreTgfLWJRKVbzeHiMbwJWs+yYkkVYX+4wIqyRgPKYAZgS99zrBahoZnj334zzNdYzdHo1yxDuXo95@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWaS0LGawWI02EfcbNflj4JWPYUbxWhAlC8srwj3gtAsnvNoK
	5OWBO1seQ/0Ao/4JqTxu+sa5XXCdjtp8nwXAr2dYfYWG0x8XCnfo
X-Gm-Gg: ASbGncti0Joek+rLrXcCkIQ4DQybu6uzJi0VqsqHYCMQCfrc4Kp8UlVpdcygNcw8eRE
	o1p/cxlZVbIIVu9D42YEDoFP2F9JV8Tf5WAw4hvCaoPeL7JJm8cecOcNsJgsS8nWxx6GVBz/Htw
	zCks9c2fsoQ889Q35LIHMMdgqSqSxRJa+cWGZdG2HqknzDWocntnYgT1jc4kSvMOm4xQhGEnEnU
	EATfnf9kDT2F1yawv63BeSsS+MLC54Vgp0unTFuYIenVPCP/GBW28g2EUKnVKpi4BI0MS0hHDz/
	VJygmFRGP/LNHBWs/th5pi7Ufzu7zYWBHlhQBA==
X-Google-Smtp-Source: AGHT+IEgMGKpQRJiJRgzad2YRv9qQgfGpZKXa1T2ITvhZX2hPnZNiJStXAeTyMF06nQh3Hi9EEk8QQ==
X-Received: by 2002:a17:902:f644:b0:224:26f2:97d7 with SMTP id d9443c01a7336-22780c54385mr233841995ad.8.1742933691248;
        Tue, 25 Mar 2025 13:14:51 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f4383sm94312165ad.229.2025.03.25.13.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 17:14:46 -0300
Message-Id: <D8PMFDWIJJUB.196935MS2OZ7J@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, "Jean
 Delvare" <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>, "Bagas
 Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 00/12] platform/x86: alienware-wmi-wmax: HWMON
 support + DebugFS + Improvements
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Armin Wolf" <W_Armin@gmx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>

On Thu Mar 13, 2025 at 11:29 AM -03, Kurt Borja wrote:
> Hi all,
>
> This set mainly adds hwmon and manual fan control support (patches 7-8)
> to the alienware-wmi driver, after some improvements.
>
> Thank you for your feedback :)
>
> ---
> Changes in v6:
>
> [08/12]
>   - Define dev_pm_ops statically (kernel test robot)
>
> Link to v5: https://lore.kernel.org/r/20250312-hwm-v5-0-deb15ff8f3c6@gmai=
l.com
>
> ---
> Kurt Borja (12):
>       platform/x86: alienware-wmi-wmax: Rename thermal related symbols
>       platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode()
>       platform/x86: alienware-wmi-wmax: Improve internal AWCC API
>       platform/x86: alienware-wmi-wmax: Modify supported_thermal_profiles=
[]
>       platform/x86: alienware-wmi-wmax: Improve platform profile probe
>       platform/x86: alienware-wmi-wmax: Add support for the "custom" ther=
mal profile
>       platform/x86: alienware-wmi-wmax: Add HWMON support
>       platform/x86: alienware-wmi-wmax: Add support for manual fan contro=
l
>       platform/x86: alienware-wmi-wmax: Add a DebugFS interface
>       Documentation: wmi: Improve and update alienware-wmi documentation
>       Documentation: admin-guide: laptops: Add documentation for alienwar=
e-wmi
>       Documentation: ABI: Add sysfs platform and debugfs ABI documentatio=
n for alienware-wmi
>
>  Documentation/ABI/testing/debugfs-alienware-wmi    |   44 +
>  .../ABI/testing/sysfs-platform-alienware-wmi       |   14 +
>  .../admin-guide/laptops/alienware-wmi.rst          |  128 +++
>  Documentation/admin-guide/laptops/index.rst        |    1 +
>  Documentation/wmi/devices/alienware-wmi.rst        |  383 +++-----
>  MAINTAINERS                                        |    3 +
>  drivers/platform/x86/dell/Kconfig                  |    1 +
>  drivers/platform/x86/dell/alienware-wmi-wmax.c     | 1023 ++++++++++++++=
+++---
>  8 files changed, 1187 insertions(+), 410 deletions(-)
> ---
> base-commit: f895f2493098b862f1ada0568aba278e49bf05b4
> change-id: 20250305-hwm-f7bd91902b57
>
> Best regards,

Hi Ilpo,

Is there still a chance for this to go into v6.15? or are you planning
to review it on the next cycle?

Thank you either way!

--=20
 ~ Kurt

