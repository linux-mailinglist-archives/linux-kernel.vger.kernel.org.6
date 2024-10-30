Return-Path: <linux-kernel+bounces-388957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA199B6695
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930662819C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD691F4738;
	Wed, 30 Oct 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y57Bfle1"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68043173;
	Wed, 30 Oct 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300122; cv=none; b=tH0sdud0rcGgR2Q+RqqFKVubPGRHB2vuSBQqTSkQZkoXUeT0oQdrtft1IIO40jDC2S2OKzvXqTOQ1feF838OqmNzvY+pmJiXA8gaufyu5jpxd5Mi5Hc/KwzxxI5aV80fG68H9F26WhtZlVoeWgOx7Avimej4ZZ2ybzfeZ343Rkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300122; c=relaxed/simple;
	bh=+rCWZ55g6lEO9DEzgUrUV6wM9NGbz+RzKyLC4yixhkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bimpdod32E+tLx9b43/RrKxM0U+AX1KmpisfNZUS9Uxgp+qtA2EkKqJKsSOqoqTiltgRjoRQgEofFx3PZcHVYqgb8WANkDfBnVn91/wEbbV9eOTSet0sg0GBcj+u9QL93lwGAcNTJXyBp9alKmImesEYMN7HZ5gCwqc6lFqALAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y57Bfle1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbf340fccaso8542266d6.1;
        Wed, 30 Oct 2024 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300119; x=1730904919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S26NapLVOsHBop+Zv7sCn9r3u8VbS5I1a8U6RuCxeHQ=;
        b=Y57Bfle1oDBFK4NTgNviPxQ1DswEJL/2n8PVW+YnjO01Ti9ogikW+6ed0177Pz0jW5
         /zz9sl9BQAKTbN0ca/xJN2C25HfnWpYc2IQhWq2GZF8jsnyaUqa5EeCBmdvlIPEglE+s
         wGBFeyulZhriJf5mBNfcsa11TQoOfCdJcW/rw5EP2A+aUWajfdjZ8cBNWA7NEVnMle1T
         xigIQ7jyJdJfVzC3PYwrJmuDZ3t9dZhulCnnNt6TtJUcExfZ0/nfNOpNwTBLd4bxzFcD
         1L+ag+fJ4r8/w/eYKJEdk0GFA1UpSRt3GOeKoaN9HA8U20Ta0fiw4moPKAQ5/WXsoPWl
         +5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300119; x=1730904919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S26NapLVOsHBop+Zv7sCn9r3u8VbS5I1a8U6RuCxeHQ=;
        b=WOtXN4KBUz4CSM6hnM8+2Qll5s5QK2/dK2WvuhSizwgS+Xy/vSFJx8Nao+rHX2Y9uD
         Arbh9JKbAj1GoYkn369ae7jFwofJyj7PrC2Xifb/OZFE+H9t+034G9E1ryBGzgp1UPwe
         ow6dmk8oUGK8OBNJ9bRElVMMk0LAFYXEGcSLsL4CyZg/Rl+qIs/8Sn78mIwCRW3Plksm
         OnPHalav3+hVfkF43/2RzZoFmXNQ1gf03gYGOe+/30XzBSUDQ5V7fBA6+Ro1u68C8zdn
         ph2ww9N/rfVe33Ja7NfdKjjFHe/epk4Dy8oF09U7wj5MAVv7LMXSY84Q5tNTnx7buCXl
         fApg==
X-Forwarded-Encrypted: i=1; AJvYcCWq2+NqS99y44j5PI5fqJ9uIjDpzWelUnfB1ZeseKbRIAcvyirkA7/zeyQTQg1U/bkjPxNablZaFdxB6/w=@vger.kernel.org, AJvYcCXD5DLWs2ZS47c4NJ2Kr1eyxb7i0fjRlTewPJdjP49DFjKqsRHs/7ieURqXNpeTdd6Xr3GoIk6lWpE6@vger.kernel.org
X-Gm-Message-State: AOJu0YypQVW2HJW//adzjyaUdIhB/uEKx6fU3QOdAL7q/j7tBizYOijN
	yUA57WRRr4P7Ur7J6fnpZidzFj2Fn88EQJnt3p2hPkRs3jr1Y3u+xYmCbU4w70w4Ln9HXODinJs
	Mu41ttk0DCRyFG8Csganag+HKeSU=
X-Google-Smtp-Source: AGHT+IGQSEIiHVhnvfX6tnD/WSIxLI4s5a65e/sH1b80CfA4RZVB1nl/zI7uDJ/g6XFe4jN6q6h/OVKOAV93dso9Mfk=
X-Received: by 2002:a05:6214:b6e:b0:6cb:5ef6:93e9 with SMTP id
 6a1803df08f44-6d348486daamr44883466d6.9.1730300118909; Wed, 30 Oct 2024
 07:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-2-akinobu.mita@gmail.com> <OSQPR06MB72524578F1E5BA93772A12728B4B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
In-Reply-To: <OSQPR06MB72524578F1E5BA93772A12728B4B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 30 Oct 2024 23:55:07 +0900
Message-ID: <CAC5umyjtCaYPjtgDnJ69c87w825MFSHgm92JA1kWORwP4Hdjww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on shutdown
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8829=E6=97=A5(=E7=81=AB) 11:35 Billy Tsai <billy_tsai=
@aspeedtech.com>:
>
> > This adds an optional property "retain-state-shutdown" as requested by
> > Billy Tsai.
>
> > Billy said:
> >  "Our platform is BMC that will use a PWM-FAN driver to control the fan
> >  on the managed host. In our case, we do not want to stop the fan when
> >  the BMC is reboot, which may cause the temperature of the managed host
> >  not to be lowered."
>
> I confirmed that it works properly.
>
> Reviewed-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Tested-by: Billy Tsai <billy_tsai@aspeedtech.com>

Thank you very much for testing.
However, I plan to change this option to device attribute
(/sys/class/hwmon/hwmonX/retain-state-shutdown) instead of the device tree.

