Return-Path: <linux-kernel+bounces-554508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A4A59908
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C0188804F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053D22DFA4;
	Mon, 10 Mar 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0zYmuTP"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8622A4EF;
	Mon, 10 Mar 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618683; cv=none; b=bH5dmlWzJ6c7pnDQeaZvTkc8DLXYaU8A6sk+ai47fjeBym0bHueGn71UuwDT7vdzP051kS6rEkwmy3639Ibdp9+EocIUYw+XlcnZQ1SQYhxw2rBSKwXEPL4u5gcnIFWELNewbmZ7zT5bLxdc1SXgy+QLXDWZqCnGuxnhXECPBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618683; c=relaxed/simple;
	bh=nKeMJqcXOybsOCtgidoWKKriWWEU+V6EOHzym+y4Rww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DI5NRNNiSyI5apSHMrY/SRGypHvlx01noBVhKU6HFxvX8Tyd03jqeXaE1tEInuYQKAhCCdIBW/G73IzHiSmWO/ycT06Ddzvjst1JPQsr5WhfSqVwzKFtu0IwvhBQN9NXAYbEOmTZNEx51xLOikoPSjT6io4P/cXNV7wel1qsBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0zYmuTP; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523eb86b31aso1118864e0c.0;
        Mon, 10 Mar 2025 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741618680; x=1742223480; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrdG1fpL5CikYynfNpId4ukhi3X0kK30B2xjj7IytkY=;
        b=j0zYmuTPA7YB/7EwdNN8EXYtfOGUCAhBvk6VPeI5+43BmyZKhiO53U96xS34hQwPcP
         KqkDJ5PifJSUvAIn3TGlsG5wljKwhXRXTe+Oj16FKqaY1OG3q0jkBKGxRxTV5COY9soq
         FhwkQSousFprxy7uMyTqG0RY7Con0PCac/r8cLy3zXcDl/zhG5paSaFgf6Dn6zlIsaPv
         bPjrju4M+fp3UCvzawkF4HdJN34sc/JGxcPttugw8r6a9Au2xtHqmy+75sZPFl+EixCs
         1mv+f0UcOlUILtPWZsXHjFPFk9LaLuv71YUP9JsFyRcv+7S/QSyXbJwrKiMzOTvXMShK
         Xr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618680; x=1742223480;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xrdG1fpL5CikYynfNpId4ukhi3X0kK30B2xjj7IytkY=;
        b=CEJwLfTQE7iHJJTTL4gWWZ9YEWt6bgRNgbCDlwnRYKm9xpmwXeTEf+O8eLI6i/iiYK
         yvKfX0L5cXtpysvW01H8RNXhiF3uf5SxMs7n+ToTLNTtK81ccD1wAwtogkQgzxW4LmQV
         hE3M/DkKcsu6syGE6D/h71Xrg1CZSiYoLSytEbubB6Aic6Nnem2zhhU101m8N8HyBNkY
         5XISmhO6xk2upxcXJqfkbhGo0rb1THtkbDMeoIHW7MfC6PigCjmeGg0eKe8nJ1Xr08d6
         UUNw96S+SroP2YJTVVklxrO7oXmJBgA/H6DdNkElydrW3dzD28T+rbMc44ETIkiBX5JF
         ARWw==
X-Forwarded-Encrypted: i=1; AJvYcCVGNu2QH0mpOamgMtSfai4QJPBmRDbtViOa4G6wcDUQEjdlqUe3OXnmDqRI7ZTcfCQU9Bqq/7Ob+Z2iA3dCt4edIZ5Btw==@vger.kernel.org, AJvYcCXNjdh9w4OfZk3xXlwphKZBZhF7ab72Sy9KGUKPMdBn9pQpVmVve+1PQshieldAGmwza9L3Uhl4gA35wyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pGt2LQb3eGmPstQJuZDu93bZnRPG6FKnpfZQ2Wx3g+cLwUjZ
	A5+xOtM3xtkSFUBx8ywOLy3Q4ZQxLKTyO913St6zOaKCI105odOW36H7YTuq
X-Gm-Gg: ASbGncv6tVi2TSssQjMZ9d+1xlWVH61Q93/oDnMD+4840Uiai9XbWth0SGJfEbWMS1t
	GpEkA1hNO7a8agvXyvL4zoDdytzxeMnONbeYhidhkdcY2HHyg2kcWWZ8T04GFU7kzA0G0sMCQCN
	QQn6OP7/cWTQ7CBfQ3Aqbor4KNSMVPtFGjsW3xPvuMEOq4+ROw2a7iaLfDSDaKb6/2OYlK0uUNq
	1ELYXpgG1jq32j0+HhKjyO9I79A3iPwlMVBWz1hqUqWakgeOTMEw55lJO1ZhP2s3oC15ySeA+Zx
	z7YnW1An4e+fg2GvPvhvgmZd3z5yWOQQ4V6d
X-Google-Smtp-Source: AGHT+IHUDZIuIbHcr33yulbymoIlv7q2VlkrSuz2EsmPrJWcWsAcy1tmH7sM08Qnglzp4x9fp1DZ5g==
X-Received: by 2002:a05:6122:3191:b0:520:61ee:c815 with SMTP id 71dfb90a1353d-523e4188194mr7105607e0c.10.1741618680357;
        Mon, 10 Mar 2025 07:58:00 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8ac3266sm1490598e0c.15.2025.03.10.07.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 07:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 09:57:57 -0500
Message-Id: <D8COAMZV0RBJ.1C66Q3AVETTD8@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] platform/x86: dell: Fix ALIENWARE_WMI dependencies
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250309-dell-kconfig-fix-v1-1-38a2308d0ac6@gmail.com>
 <8d219429-b13f-2610-960e-58851d53696f@linux.intel.com>
In-Reply-To: <8d219429-b13f-2610-960e-58851d53696f@linux.intel.com>

Hi Ilpo,

On Mon Mar 10, 2025 at 9:29 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Sun, 9 Mar 2025, Kurt Borja wrote:
>
>> If ACPI_PLATFORM_PROFILE is selected by ALIENWARE_WMI_WMAX, the former
>> is forced to be at least =3Dm, because the latter is a bool.
>>=20
>> This allows the following config:
>>=20
>> 	CONFIG_ALIENWARE_WMI=3Dy
>> 	CONFIG_ACPI_PLATFORM_PROFILE=3Dm
>
> Hi,
>
> selecting from =3Dy should not result in =3Dm for the other symbol. This =
is=20
> a bug in Kconfig infrastructure.
>
> I ran across this a few years back and even had a test case to prove the=
=20
> select bug but back then the original problem eventually was solved in a=
=20
> different way which no longer hit the problem. I never could figure out
> how to fix the kconfig logic though without breaking something and it=20
> ended up into low priority bin and never got solved.
>
> Sadly, it seems I've lost the test case patch that exhibits the bug=20
> somewhere... I'll try to look for it from my archived files.

That's funny.

I thought this was a Kconfig quirk, that resulted from the following
hierarchy:

Type		0	1	2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
Bool		n	y
Tristate	n	m	y

So a <bool> selecting the <tristate> would force it to be at least =3Dm.

The same thing happens with depend, where a dependecy would be fulfilled
for a <bool> if a <tristate> was at least =3Dm. That's why in the kernel
robot report the linking error was also due to the HWMON dependency.

Anyway, this patch could serve as a workaround if you feel it's
necessary. I'm going to put the HWMON dependecy in the ALIENWARE_WMI
symbol for my other series.

--=20
 ~ Kurt

