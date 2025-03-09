Return-Path: <linux-kernel+bounces-553211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178BA585B4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6479A3A75F9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3581DE8A6;
	Sun,  9 Mar 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnSVatdS"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A9184F;
	Sun,  9 Mar 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536317; cv=none; b=X3LVnNUOvCTfzReKGjt05gjbw8c2dz+IBuWGR1i1QZPqek3puFFDWZ0K7D8DbHVwtu5N6jTN8YN6IzSAWmKsNck9XzXeZ6mnTIB+GcKcpMhuz11rx2+XEZX1TvUkRP7CpwiWoEgUXGsCL3StIm6W73/b8wJWMZqC/6MIGkOzq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536317; c=relaxed/simple;
	bh=1dug6tuMzl79qjj9p0x90LqVI5l1SsUtVT9qTZFaXnE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=u/3rak/G8tuLYs7E3kl0nGSShWzJ4eY0nytN/Qd58BWR91S1Y8fCgxUzQ7O2H+Le4twFHpq5iJeVEy9sSlGPvpZz+PzUpa7pPFAJdV73KeDJWY+pv0rIbAobwvZ9bm8QgsRcnW+OvPabOCad0z1xEa6QYEebME5grKBApHSZGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnSVatdS; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so606996241.1;
        Sun, 09 Mar 2025 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741536314; x=1742141114; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWkRnX3QsMWBcGgnuSQDdkHTRxtHOBOp1UfOK3Y2j0k=;
        b=XnSVatdS8/0me9RdWb7TbKZQm+OqjSgayX+ILV7AA5+5lgRt+Gc0Zz4HX+fkVbVFMx
         fZrh2Qa+Gy/gf3WZdQ/UVz01nD6MUluzAYeCIfHxsb1qfqTHzqcpKYA7O50uj15fshRL
         XIEkoUSAtnUVJjZER/qORR0SQDC8hFw57+PRNhA+liFG/Z3cb5UhbItEo6hDZ8cnOeWa
         Sdw3BLNg3y8C+vufTduWYNNm6By6AtAil3WBNGoJetNBsh0Jkj5Tm4XXwO8Rquut9Cez
         RtcDd2FGw9JdZOeIpKd+80B0+f5qb0ST2M5y5MeU+Z9pdnne9ZplHk7I3J66b6lE7Ulp
         jvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741536314; x=1742141114;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EWkRnX3QsMWBcGgnuSQDdkHTRxtHOBOp1UfOK3Y2j0k=;
        b=jBO3n8NyX2J6qhhTViFWdw/+oWmS0X0L9Hpmd/6APFDdCHNXqrt2SFkOwZvbiOAaKo
         WraGpqUgHcM2XkSUqw0dXj5X7y73me+1ZVdN8MEwoFTCzwWxOF13MVMCma/XFsfC5yHX
         hrX56Ig3axQQkutUYAj5jbaUV3GYSGB/HjXY5Xgwa1v8nix5//0234jSjDojTQofyiYc
         inDpGUGfPoLp47qWs1fdt+r/lHUbBAgU6AliAzcls0z89WpM/r9nL8OCoqHy32aBM8WP
         bXZPmrSHTORA0SvX25TW8FiOgP1PBDRN72xrZFcdJoSFxA8FkkskvWKxP3eDfsvpjtdS
         JJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOpo0ydL/XSsPa02Kxhtj4vR7TQfYvBBM7S37e5l2MZFudEHA86qJOXC9voC7hiSbZDuLKbCNTumP6p+R/@vger.kernel.org, AJvYcCXHlJiZMKWoDO7I1WnrWHZatvaTsOY8RbJzwKFxRKr0VFbp6t0EYyX+46hEElWR/L23l1pE23y6mgL31A==@vger.kernel.org, AJvYcCXkHLgZX3xDEqppdJni1gQTrG5d41ikaB8/jUyHf5LPLX9vYW7vNAzQNCOMLN8mWVK27rqkHZMomPwUCI3r9vvNJbwi6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZKWXIuCuR/b8NtY2BxNC8//SSZBwbISq8RiuRcLKPGH+hTR2
	I0dwmfP6q7rtrc1xq0UNur9VWqLRw5eWrRzMOEOPn8hRpKW7webt
X-Gm-Gg: ASbGncvj59wTpSPVcwiLj0a/VHkYL/aIEYaJYiWtA7Y0yr8OA0lunhog570GueTKP2G
	M4UwTvNIbwbjIIRmIvgtAnKZBC9uID6ixVIVa615e6gKKCh9Nnb3IRABdXRy9dUmsqAtlEeE6lr
	0Jy/KGFCzhoYCkc73C57H4wOS2nAsGoxyhJHGMqmkU/I3VM7vHG7qRh0SJcvE+rWRV38h7qMG0i
	vNj7ALs8WhjsSIlcVQ9UdTSN//GhN6DaWJKAiGa7mv9KDW3rjegQVeAcHUSsTXpl1EZK//sdn27
	UZkS7DqDXmSMBPdDg4iDmfdz7RZBESvA7Qdt
X-Google-Smtp-Source: AGHT+IFE0VVNJOJlt2Gf4A845cRSe8thFkhp8epWmNKJhbRDSow/TTW3MEwZYPYNrcR5FkQl0u+L3w==
X-Received: by 2002:a67:f304:0:b0:4bd:379c:4037 with SMTP id ada2fe7eead31-4c31b718467mr3124720137.9.1741536314101;
        Sun, 09 Mar 2025 09:05:14 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d519139a7sm556002241.10.2025.03.09.09.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 09:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Mar 2025 11:05:09 -0500
Message-Id: <D8BV3JTOCPI1.3OY62UIJOLJQL@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Armin Wolf" <W_Armin@gmx.de>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
 <linux-hwmon@vger.kernel.org>, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 00/12] platform/x86: alienware-wmi-wmax: HWMON
 support + DebugFS + Improvements
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
 <a5a159ee-5623-454f-8b27-352603c5d1e8@roeck-us.net>
In-Reply-To: <a5a159ee-5623-454f-8b27-352603c5d1e8@roeck-us.net>

Hi Guenter,

On Sat Mar 8, 2025 at 4:23 PM -05, Guenter Roeck wrote:
> On 3/8/25 12:23, Kurt Borja wrote:
>> Hi all,
>>=20
>> This set mainly adds hwmon and manual fan control support (patches 7-8)
>> to the alienware-wmi driver, after some improvements.
>>=20
>> I have a question for anyone that may know how to solve it. In version 2
>> of these series the kernel test robot found a build error
>>=20
>> 	https://lore.kernel.org/platform-driver-x86/202503051819.bQ9P70Og-lkp@i=
ntel.com/
>>=20
>> I think this happened because
>>=20
>> 	CONFIG_ALIENWARE_WMI=3Dy
>>=20
>> while
>>=20
>> 	CONFIG_ACPI_PLATFORM_PROFILE=3Dm
>> 	CONFIG_HWMON=3Dm
>>=20
>> How should I Kconfig to avoid this?
>>=20
>
> If hwmon is considered to be mandatory, you'll need
> 	depends on HWMON=3Dy
>
> Alternative would be to use
> 	depends on HWMON=3Dy || HWMON=3Dn
>
> and use IS_ENABLED(). Something like
>
> 	if (IS_ENABLED(CONFIG_HWMON) && awcc->hwmon) {
> 		ret =3D awcc_hwmon_init(wdev);
> 		if (ret)
> 			return ret;
> 	}
>
> Using IS_REACHABLE() would be another option.

Oh - Now I understand why I saw this pattern in a few drivers. I'll
think about this option for the next revision.

>
> The CONFIG_ACPI_PLATFORM_PROFILE problem is probably similar. You can not
> have CONFIG_ALIENWARE_WMI as boolean depending on code which can be built
> as module.

Actually ALIENWARE_WMI is tristate, but the symbol that actually pulls
the dependency is ALIENWARE_WMI_WMAX, which is indeed bool.

Thank you, this gave me the clue to fix the issue!

--=20
 ~ Kurt

>
> Guenter


