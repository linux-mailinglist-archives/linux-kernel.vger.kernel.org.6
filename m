Return-Path: <linux-kernel+bounces-176949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D78C37C2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81899B20CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8E4D131;
	Sun, 12 May 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no3Kvyg1"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119536122;
	Sun, 12 May 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534511; cv=none; b=VX8932SKFSZu2joUT3GSYdkad+YEPGf8AUlKWaUKSfKZQuw5OU/oVJvwIRl16d3qoJKG+YMImPbrsVUP66S4TYDYKlYwAO2EjiLfzPU4pUDb5SBXqH529z1Dd1sUp/+9xrq6Oy4DKzVbOjgjXVmFVU6ZB7pD1vKMLOCI0Kz53fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534511; c=relaxed/simple;
	bh=AzTKSxgZVEnj54sywuMCGiBVCgI5nJS8dtdSqzzX/Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6GFxWMtK/n/OKumQ4RkyUSuPMWgeCDiWEaUteIinsKoHwsK2EJoN/rfTTET8Ztp2f6XC12PleTlDdo+SYCPpm6ZNHAxCuxcXlZU1PPAs7jG0IwFW2HX/PAdMTg5WBXv0jI4OVlxGiMKaeXg12yiJP1nCt0c6tswOQZPvAMto0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no3Kvyg1; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-deb99fa47b6so4166827276.0;
        Sun, 12 May 2024 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715534509; x=1716139309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzTKSxgZVEnj54sywuMCGiBVCgI5nJS8dtdSqzzX/Ic=;
        b=no3Kvyg1CQZhWZxrgSh6Ytndmc4XJIoJSW7Yp/TrX7J06OIWAkiQlRhkS9BPvhrSdK
         Ek8OqiCTBmmliNeS/RhrewjIQus/o4051Bbyox45mlZVms7D283QPzdV5MHSLWI2rH6m
         7rw30FUwH8Wh9UShHhHGHLUc59dBCbLCC0AVh1IB1RV9bjR6bQtF2swiA8VlhI8+yHMC
         hDhrPUXuel9V5K2fNmu76AM+YWOWIjVMS5EuTWJbNaXisRdyiPsb9Hwn7c+AwseU8vQ6
         fbeBPWPrjvCCk+mn+ZEJ3c9xXZItN60zXUI6IRKXXp35olKsKqyjvsBvRD42vymqsESw
         boHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715534509; x=1716139309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzTKSxgZVEnj54sywuMCGiBVCgI5nJS8dtdSqzzX/Ic=;
        b=WAWUEYLXbAgL6YddPWhLgRzhrzQWpmVEOCV9jUpn0p7UBTp8zZwJWCIkTjvVJAcOeB
         8qOO5wwqI7XRj/blRoRPIMxyL1qCPa11UTo1eCE5qakImOYD0cMeom13YEZbM4FrdHXO
         xX0dwkvDYOg/ScD3FOEeASplL05kYtKl/88/WCpikpj/gWD3l1mTeAPEFHxcrTbwkClb
         j+waVLnaS/3gEpG+NrVMEhcKYMyW7wk0KZJu+hoYpM7ZXWGmgrqm4jdcXXvyGXd76dtu
         5ByJTtp94TCpVWZTyaLLZyZW9SUOeQ0rbpuBMW3x2XT+bEyvYqGlfBWA280GFko6GB7z
         fU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2ei42BaeCukkAFeZHCEOfRW0eYyg58aadiKm5qWekoQEfJo+5Vevqb5sZt7h+xKjFcjtIWTTjfFC4TobnzkrllSbzWxc0CXveMO42Le+6Ous+qZQ5b3QFCJQt3TkESacY4iYDL9M5p32atYQolKNLcb7QCQLm5olcyT6RV32VX8yWhx/aaTKy/RdsvPGP
X-Gm-Message-State: AOJu0YzZQW8L9B/+ALGyqqvVByMl+Sa6Gwn93BHMEiqUSff53YL2964R
	HrsN3GMbtnTMCxlcKVsO8i3YkNcrfZIz7xog91RPoFr/kKGgxd1oPlmIsZr20rzRNXN2A9imyOx
	I1mxomM9V4aTr+7XM6EQ4W+is2io=
X-Google-Smtp-Source: AGHT+IE6H8iYCQF2oK1tjjJ8FOCWPzoLa8cSyA3zmCSivazmxF7tcQJ5Vfr3v/FJuQ9QClm62kvb8NcT/B+PQyThz0A=
X-Received: by 2002:a05:690c:112:b0:618:8390:341f with SMTP id
 00721157ae682-622aff42b9amr76381837b3.1.1715534508852; Sun, 12 May 2024
 10:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220206022023.376142-1-andrew.smirnov@gmail.com>
 <YgIu+Lrt0p85yog1@kroah.com> <CAHQ1cqE_iA0gKmqxS21JMAoFpz-ebhG+axVuUT9P62_JTB9kZQ@mail.gmail.com>
 <20240424084024.GC5670@craftyguy.net>
In-Reply-To: <20240424084024.GC5670@craftyguy.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sun, 12 May 2024 10:21:37 -0700
Message-ID: <CAHQ1cqEbc9kQOanHs=0Vir=yJpY_PnjUvAWV5LdeDoJn5XrXJQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
To: Clayton Craft <clayton@craftyguy.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, 
	gpiccoli@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:40=E2=80=AFAM Clayton Craft <clayton@craftyguy.ne=
t> wrote:
>
> On Sat, 12 Feb 2022 15:37:19 -0800 Andrey Smirnov <andrew.smirnov@gmail.c=
om> wrote:
> >
> > Yeah, my bad, will add in v2.
>
> Hi Andrey,
>
> I want to run the latest mainline kernels on the Steam Deck and came acro=
ss some
> newer patches of yours (and others) in Valve's steamOS kernel that may(?)
> replace the ones from this thread. They seem to be required for properly
> handling input, thermals, etc on this device.

Thermals yes, but I don't think any of _my_ patches would be needed
for anything input related.

> I rebased and used them
> successfully on 6.9-rc5[1], and was curious what the status is of upstrea=
ming
> these (e.g. as a V2 here)?

There's no particular timeline I can give you. I'll probably try to
push a new version of the driver in the next couple of months, but
that's as committal as I can be.

