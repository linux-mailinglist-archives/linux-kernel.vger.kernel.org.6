Return-Path: <linux-kernel+bounces-435089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A89E6F78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE18D283B15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CF2066DE;
	Fri,  6 Dec 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzyEzSlZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC51714DF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492850; cv=none; b=VnGHNhNmK8kEeB1QGK0YZtK6Q1Z+1kWh2+lH+OuveFYjR4SnY0qc2qHBXOfIJtlmkRJNNPuanomm0wJZpqZxpvrt7fL0mO5HKaXNEfGCP9THlsP0bj/AJwa018bLPiBo7SVoW88sP0K2kHm2RKelHn4web2xMzDie53MqyFy4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492850; c=relaxed/simple;
	bh=eSB2dP57Lt2cDgjY30l+ZZVZbIDYSxCFILYWSdP1C5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw4k2vHIui3SUp6GM8r/oc4IwFUUV8I4kpKsp6fXTgdeRhBC425w3wInEFku+UL/uq+dnc7rPzsx+HvU89aWTQpx+XNGxV9hFSF6TFZAUdAGlczyap67t5xtoQvmR5anr6tWxnpDFQMeu0AviOT+7EEbbxQZbyRnDk1iby8F2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzyEzSlZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so2401258a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 05:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733492847; x=1734097647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB2GYj6h7NTYp3tz+N8E4YVHX5ZUGOngPw2xjBveqkY=;
        b=DzyEzSlZZqFNjyIq9K/+i3UxAPXyjr7iIuxUPzPiEu4hjy7xGM71/OPQg+ySw2X1LA
         6CjGQShB0bCMMetVokDI7p7ZwNhh2263EjJb0nvoPY5jweRr8K5N9Oeap4DZpFsnwPTP
         b7hDbRt8ytdaZK2UHsggftvJSnY6soc2Ire1P7a70MCWSbuw2VoYp1zIeiu1tW2+j9fz
         p24vHt0WVLJXJ9XMjj5MY+9mft15nTGCbM0SKYGKnVtDNERlxgC3mznSG/Wp7a8WACLV
         oKLMERUTeYuoEci2eE0Is/1uWnxE/Tdg8uxVM4BsT54uWL4Mk2qRgRgqaHoYPfZx00+n
         +qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733492847; x=1734097647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB2GYj6h7NTYp3tz+N8E4YVHX5ZUGOngPw2xjBveqkY=;
        b=IsrRWJXUJgL+4oiG17E2QJzynZpdoptUBm+sfIqGkpGVG75r8LtCS9/qHwMvqBv/Vm
         hLl5X4lni2oNNSHwAhHtgGIUJ2gJb85gKaSr4ZdDZu4ykqVjYZ5CUu/+ui+6zX0Zq3x5
         Zz3JKCdfbiDzuksc+rkOpktG6J1RQ6ny8WhC88XeimcHSg8D6CEgwkoAKlAUUZOMf77+
         HkjfzuVJyR027j5wJsOfKgX4j29ePWik9C4r+NCIyyGpukkLBUncYcLZkG8sJfStHUFA
         8CPPRTtcQAwClZcGLs/87ppOrxQNRgVdDVHpPcP1taMf2NJiwB1OBjhn3HmVbB2gR21H
         TBng==
X-Forwarded-Encrypted: i=1; AJvYcCWdF+JxmVLyZJhbonLMai0bmgruMCOd661OwEdMbeETvD2KHLcumqbbXXp1b+7vFC4hv6H4Vq+AmzrNjHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSl6lgq5yVIa+AGsQgQaKDppqQAhyXqSGMrtZkW86MJ1mIHIB
	adzMwIbcnvh5EzZ//eT5HgmodLNbnUd+3lIJzgeUUOviJ7f+aIkjPAlhReXO8h41SWuM11RtiSw
	IUGzRkdp9eU87jz1N79VCyxXQgrI=
X-Gm-Gg: ASbGnctW7DnMXPGFgPu/WpWJDo98jr/2unnspQwfHdTZYZAc29C0kg8Zx9vNFC9065t
	z6kGPXqDepkgHPmyIjeiJxLu0GvcKoMNp
X-Google-Smtp-Source: AGHT+IGg0aM7++Y4TB4B65EgJVZGYM7ZpTzbI5RsZdwW/tELAdoAmtg10jBQK9NEDGoxriVkcyNHApdTu4VWsEIFDlU=
X-Received: by 2002:a05:6402:254e:b0:5d0:d30b:d53e with SMTP id
 4fb4d7f45d1cf-5d3be697749mr2551925a12.19.1733492846758; Fri, 06 Dec 2024
 05:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206123751.981977-1-simons.philippe@gmail.com>
 <2ec677db-2db8-4a74-af76-d8ff1f4b2173@sirena.org.uk> <CADomA4-xTcPyFcX_qCYJwoi7y5vfYmzOfF9iO5MKgEzZdpbJCQ@mail.gmail.com>
 <50ecb2cc-7fd2-4a72-bd68-05d33269c01e@sirena.org.uk>
In-Reply-To: <50ecb2cc-7fd2-4a72-bd68-05d33269c01e@sirena.org.uk>
From: Philippe Simons <simons.philippe@gmail.com>
Date: Fri, 6 Dec 2024 14:47:16 +0100
Message-ID: <CADomA48sOgYor3XEfBWwmqifFdE1u5sOQGR1CzzkHOAOaT_JEA@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:44=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Fri, Dec 06, 2024 at 01:54:39PM +0100, Philippe Simons wrote:
> > On Fri, Dec 6, 2024 at 1:48=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > >  static const struct regulator_desc axp717_regulators[] =3D {
> > > > +     AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
> > > > +                     AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
>
> > > This doesn't seem to match with the above - ramp_delay is in units of
> > > uV/us?
>
> > 15.625 us / 10mV =3D 1.5625 us/mV =3D 0.0015625 us/uV
> > 0.0015625^-1 =3D 640 uV/us
>
> Ah, yes - sorry - I typed when I did the calculation.

No problem.
BTW: this patch is critical to at least Anbernic H700 based devices.
Without it, DVFS crashes very quickly.

