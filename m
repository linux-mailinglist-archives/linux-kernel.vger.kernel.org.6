Return-Path: <linux-kernel+bounces-389024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F49B67AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF386283268
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43870217452;
	Wed, 30 Oct 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT5lq9Bw"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83091FCF40;
	Wed, 30 Oct 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301532; cv=none; b=RnnxEleiBT5PgqgnSIQr84P+n+c+pwScx1RP6/Q2aCPKDZOM03x2P433JlSqOe/XIR24y7igs1XkelLJnx+JFimKg803VL+E6SeOX2SggeR9N0Mnmuu4kelgzmBz3mft1pZ0lEedMrQ14ZrzY9kM8Kh6qA9dU7AzS1uP2Tqpe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301532; c=relaxed/simple;
	bh=EU9a5+lpv1u/NUwDeoQWCZwoLEMNc1DZMBiqWuC09jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZjGqvXRdR+i8mJzk4mNNugrTmaEOa8SWHRSm2X8gx5FUyNhnWWVjdggcaNAabTPvCMw5WVkqzNCNo1mjFiwnfZeNmh17tjrF53NEpAy126gq7ffhDu/q03qUX0P3YHygt4nysoT1y0ovHNX1LcvBIcOcRmUskVE3sgB5oZDSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT5lq9Bw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b152a23e9aso507775785a.0;
        Wed, 30 Oct 2024 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301529; x=1730906329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4vW05LPK5Jdzs16niC5H9RxKIopKLCE3f8/tsQi/E4=;
        b=MT5lq9Bw1FnjwOJUVqoZsauZogvTMWNF6nl4aZAKPu32ObrIl8/WVmeBZBPO36NiNy
         BqDKMmcX/UX6j9CosAimqEsgX+RA8K53fOKV+A1//zW5N4RNowR/+ik1V+cpFCneMl2s
         Acbru4qP4TlZ8nR5kKRuO9RNvs4uIYWgq7wEzLJMdQx7jqzdGIWzPncR3db4IQ3hwHk0
         xzYiXemP6Oqwbv2kn9UPdlmJrKoOaCYRZZ2NdiEGQlSEz3HlkTKIwELjIcGqiEEp6AQ3
         wT6MgkedEM2gOrCc6nWlRLSsqv4iDuRnMC7rwudMBvsGQ79j5UzXtIUoyO+s8B+qIB9Y
         DTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301529; x=1730906329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4vW05LPK5Jdzs16niC5H9RxKIopKLCE3f8/tsQi/E4=;
        b=nnvXAZBxXcI1q1DNOBi15UjPQjaGg6XVS62j+AqKOhkYGWNNE3/WC2FJjn+r9n9gQb
         yaI36D1gjY73FmzgszxQHzyEODWGPV4UQrIxoBxCSwTnrwHxANwHe5TFOIKLwXlp6rei
         FFThO2KKXdeUZ6tvYho/8amuhplNGhHOI/AFpf/E6hu2mNxJ/yF8mYCf424jWuv6sa1e
         FZD69Rf1NbbNskgJukZtN9Jow5irMFXYRCFn2CL6kVLLd365D4gX4u6TcwGXq2B6i+Fx
         U72/PwgsWAtvs4EJQ3ZjgRsQwn0oL7VvW0YuqiAp/VJ7VChvAf8KtLIiiGBu60uISIp5
         lkKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2j4uA83NpEKDoq5NOtHJ0D2umLN0zLEE7Mlo8D8DsWi+LlBKqaVMSmrhdqfm+Xr5Wxqw+GR9PXiF4@vger.kernel.org, AJvYcCUBZZTXRESHOIjJe83pzpWGDtvWq1Sm2UvtFJ70tNt0HnYLz5IajMdHWhsVmjMEH5Kfoo/A3xivFgs2tK3R@vger.kernel.org, AJvYcCW9Pr+7o/ch6opiaUOzo87u+oFG4VKOd3Sq9zDpzrYX8cQt9rsPDBQaPeM46sVxxyw4yEraEG4GD/rEf7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjvS/4j/zBiicfi0EuB1DO9bkuuld+7pdf6J/Ue0+kgt9jcdt
	EcelvYxFthkCGneOLLa4U9fCHNrI6QpRS4VLLzxiuw9ZDqq7GJmMouN0F7lavUdBY2jzremoty0
	mh1sjUlUCBvlBd0pXKh05ixAH494=
X-Google-Smtp-Source: AGHT+IHgB0ZvVh2JOtTXS9aUbj3L/HTf6YfkkrCrEnbT02EXykJsxhN49UexhdmG27W3riAgOIVd+mI04W6mWtJQhco=
X-Received: by 2002:a05:6214:33c2:b0:6d1:833e:c2ec with SMTP id
 6a1803df08f44-6d18568dce3mr250185126d6.12.1730301529417; Wed, 30 Oct 2024
 08:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-2-akinobu.mita@gmail.com> <OSQPR06MB72524578F1E5BA93772A12728B4B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <CAC5umyjtCaYPjtgDnJ69c87w825MFSHgm92JA1kWORwP4Hdjww@mail.gmail.com> <8a68babc-b4f5-42f2-bc93-ce8f1b7a14e1@roeck-us.net>
In-Reply-To: <8a68babc-b4f5-42f2-bc93-ce8f1b7a14e1@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 31 Oct 2024 00:18:37 +0900
Message-ID: <CAC5umyjtyuf8ECxhX+QeqQKb9+8emPU4omxw6V5JizAQMaGhCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on shutdown
To: Guenter Roeck <linux@roeck-us.net>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8831=E6=97=A5(=E6=9C=A8) 0:02 Guenter Roeck <linux@ro=
eck-us.net>:
>
> On 10/30/24 07:55, Akinobu Mita wrote:
> > 2024=E5=B9=B410=E6=9C=8829=E6=97=A5(=E7=81=AB) 11:35 Billy Tsai <billy_=
tsai@aspeedtech.com>:
> >>
> >>> This adds an optional property "retain-state-shutdown" as requested b=
y
> >>> Billy Tsai.
> >>
> >>> Billy said:
> >>>   "Our platform is BMC that will use a PWM-FAN driver to control the =
fan
> >>>   on the managed host. In our case, we do not want to stop the fan wh=
en
> >>>   the BMC is reboot, which may cause the temperature of the managed h=
ost
> >>>   not to be lowered."
> >>
> >> I confirmed that it works properly.
> >>
> >> Reviewed-by: Billy Tsai <billy_tsai@aspeedtech.com>
> >> Tested-by: Billy Tsai <billy_tsai@aspeedtech.com>
> >
> > Thank you very much for testing.
> > However, I plan to change this option to device attribute
> > (/sys/class/hwmon/hwmonX/retain-state-shutdown) instead of the device t=
ree.
>
>
> No, I won't acccept that.

Oops, I mean /sys/device/platform/pwm-fan.X/retain-state-shutdown
not /sys/class/hwmon/hwmonX/retain-state-shutdown.

