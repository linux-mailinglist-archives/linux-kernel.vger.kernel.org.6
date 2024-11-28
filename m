Return-Path: <linux-kernel+bounces-424180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A99DB153
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C98281035
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ADB45038;
	Thu, 28 Nov 2024 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE7ElJK0"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955C4C7C;
	Thu, 28 Nov 2024 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759422; cv=none; b=aFCKKL0qOnik3W7Hy1aVG6DGZQlC7xBR/+twtep2P5IqUPz49tu/kFgS793DbcH43L59k/8PtDwas0xdxlCFZRUCzBZk8mQZxuakaY1hzRm9az+mRklAv5eCbCGNjH8ocJYi54KbBlZESigvaYkTA7OBg41X4FoLmOt4dqr2O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759422; c=relaxed/simple;
	bh=CG+sYXXeg4pD6aHHnRJzupQHusyACQgFUG5QBuBaRoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHVPgJioTSQ+3/Z+O4HydDLKfWjIra8vq6wrUV+l3TUlhAWihr3q+IEzY6YI4gWdx6eU3DqEMubsycPooFzQ4KjhqLd5vx4Rf4j76s71p2UD0IWgIYxXx0D1enpNElcNcRbrni+TuU7XqF8rIqxtoiTdC6+JXQ3rbqvlHQv7RA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE7ElJK0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eebae6f013so4296337b3.0;
        Wed, 27 Nov 2024 18:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732759420; x=1733364220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uZjwFI5LvDzGrWnQjcbHpB2HrlAS1jF0iAzI5JyLDo=;
        b=RE7ElJK0jMOznDTYIqaKebX2eO42r/4O5kheOS5drQJA4sNhaA+H/hwFD6V3Lv7GYH
         KlcVRjS3NxN968usX2GfzWXEkEI8NbruPq4O4BgBUvrNvCS0WCHak8UTDWbLOy2i53rB
         OfybXP8CWIo5LzxU5Orlq/4vt2QXQ15CbNxercE6EA3+mjWPf0NR+nRHI8kcgAShq/6C
         9EwSx6zGOty9AVONXrooEtPmrHEvgSqaVBYfvyZc4NZ1cZfB3jdTUZrZVmgv3M2cdo+P
         L+2fJrrOSK8/ob0Ss/DkzLDwDjjFqnAz0+YGFICNWVTJEWwcqgQkgEeWh61+aLb/bUc+
         Untw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759420; x=1733364220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uZjwFI5LvDzGrWnQjcbHpB2HrlAS1jF0iAzI5JyLDo=;
        b=fCkjMIlVggXi3DGene3h6uzTvwfQbtjcKVNmd4kAz9aHy5vzwRYRBALOIGWsHvFJRM
         JXiU9EZJIzJGX8sH4O5/j1Pj2U2707DCK5V6dEXXK+aAVQ/Fyix6D8ywdc49r/7uzgvy
         mT3y41+tLbgJn/FaYtwEqnhDBjeRCGFsfYmyxtuYbn2yYOHz01sHrUEYBdV2sC5HIiZX
         uMz8q2FTPi1WoprcDZ20xfSMjTXUOejOX3Aroz/bQtzFKOE1M2objND+raUyMUa9cQbQ
         EUduy2OrLAtCrYtcFdsGRYmIwedqrG4zjXQdv2kThc743Hyym+/xnPoqsKGZsvP+4dJH
         3I4A==
X-Forwarded-Encrypted: i=1; AJvYcCW/yc/m52ezwpcsb3Ue7TRJh94ukZMAg1RmF3JEXxMAX8eyeb3Q4xYVkkxEQcOKpcoa1o0jvkpKqGnU@vger.kernel.org, AJvYcCW56PFAuj/npApEdVX4KDIxp2fT8g+VyxorKMFmnFCpJpUQSbGE4I9BE+NMtlwtlQp+KgVIzwaVR99MWGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ySBS2JCn8EgyiHBYIIgOvmBufxzTbdj264xTWcLIO9JvpT28
	Kl6tXT0ARYrJWfvvmz3ufrgRTCwsiMXO2kKKIy7u56ajb6ZWTsXOhmm5RSCrOR+ooWVjOK2Pq+Z
	BYKE3K63dEhQJpV8J2GVHtnAx/yiBQEMG
X-Gm-Gg: ASbGncumDVZX3TRiyMunJbcwA0iHmXDsOGFR/Rj4mYOP6WwcbgfvMFn474aB+hUyWA3
	+P5SyU4MIbc0gzy8HujzWhVyQ+El577fsaOgYFo7VZH82x1DI6Tl0r3yNiLvIbLo=
X-Google-Smtp-Source: AGHT+IEf4e/3aGSKEqsiC8y3uIj4rbapu0Kz+c7lTmZIdsXxFgrR6OHz4CNqf9Ki0WIgytglUJgGq20b/+ll7XrLXdA=
X-Received: by 2002:a05:690c:6d08:b0:6ee:66d2:e75a with SMTP id
 00721157ae682-6ef37282b96mr65431607b3.39.1732759419648; Wed, 27 Nov 2024
 18:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028080415.697793-1-wojackbb@gmail.com> <ZyDRIW0DIGn_FIsD@hovoldconsulting.com>
 <CAAQ7Y6ZGrQt+rPBK9PzwJRC5ErbFgbc239X=iwjRboY3HU6O8g@mail.gmail.com> <Zyt4I2YFx5lm0cLi@hovoldconsulting.com>
In-Reply-To: <Zyt4I2YFx5lm0cLi@hovoldconsulting.com>
From: =?UTF-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Date: Thu, 28 Nov 2024 10:03:28 +0800
Message-ID: <CAAQ7Y6b38C5Kg4d+YTgqa9BJeVGes=8qV0dCPGDFq+F6-DfVAg@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: option: add MediaTek T7XX compositions
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1. I will upload a new change and it will contain this description

2. Regarding NCTRL(), MTK tells us that it is the same as PID 0x7127

Johan Hovold <johan@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [ Please avoid top-posting. ]
>
> On Wed, Nov 06, 2024 at 07:09:22PM +0800, =E5=90=B3=E9=80=BC=E9=80=BC wro=
te:
> > I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB AP Log Port.
> >
> > I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB AP GNSS Port.
> >
> > I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB AP META Port.
> >
> > I:* If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driv=
er=3D(none)
> > E:  Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is ADB port.
> >
> > I:* If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB MD AT Port. User can use the port send AT command.
> >
> > I:* If#=3D 7 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D88(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D07(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB MD META Port.
> >
> > I:* If#=3D 8 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D89(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D08(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB NTZ Port. User can use the port send MIPC command.
> > MIPC is an instruction set designed by MTK, similar to QCT's QMI
> >
> > I:* If#=3D 9 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
> > E:  Ad=3D8a(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D09(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > It is USB Debug port.
>
> Thanks for this. Please include this in some form in the commit message
> (e.g. a table listing the functions).
>
> > Sorry, I don't understand "not accepting modem control".
> > Should I set the non-MD ports to true?
> > for example: USB AP Log Port.
>
> I meant that you should mark the interfaces that reject modem-control
> requests using the NCTRL() macro similar to what was done for the device
> with PID 0x7127.
>
> Johan

