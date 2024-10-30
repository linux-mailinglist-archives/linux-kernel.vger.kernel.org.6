Return-Path: <linux-kernel+bounces-389054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE09B67F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B431F221C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE02C213147;
	Wed, 30 Oct 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN8R9VwB"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AACB672;
	Wed, 30 Oct 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302456; cv=none; b=axh4fpG65jKQEBEr94lcxY6St6o/jRhCS1W1KZnBAhoNQLDEG8ib9tEkZIIJuyRWVyf18JVxvRzc6WEJBdRU/9UhW/nHVGS8Hx8u1U8cRFbVvd92k40iokeOMRx3SEHuU6mPPfYinNMAW2WMMagX8/O4umzpsUBCxaMSPNa6RdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302456; c=relaxed/simple;
	bh=vMjjsd/Xuzoj5kq9WRECUQGsxjzpcUg17A7b2x4rqnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbxeHrmsuzvxsUhg2YHqKjPDcmOLGC2qfLGg7vhL7OvmuSHYneUD1RwP375/cckBI0ERdY9uZzRgV1Yh9qGN4CGzR8mpkaREFblXS/krsStf9JqVbqt+F/wyfJZK8mTCq0ZbrZC96+s7t8BFA3QSFameRsPRb5yTPrPAgIqq8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN8R9VwB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so9701966d6.0;
        Wed, 30 Oct 2024 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302453; x=1730907253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HsO/rND4GDvVu41dLnUKGBz8GF67TRaGpWDgwnI7lM=;
        b=EN8R9VwBntCTMAX4woFo/sqJ/mj9qHzlAhDov9uludkPDm8KXhiYrv+Yt+oWLN9YKb
         /I8Q0+7B4FCEXgPw0XRpsr/tsTRn9mCtVHMcVcu1umAAChux2AzHnJKSaJ7fvY0WOAI7
         x/Pm4EQFsuhjuQLpXgjIiVg1FlHk+JM1dKA8XyASczmE2wXo+hzdV1l3KItqHUD1YnWu
         A1yXDWfH6zd++pWTZEVexij1nqgLQvQKqsjuNgV0NzK1B38Ky6ZMzMjYusw9/8yB8OgI
         eYNjX1K44PBV+3N3uTm4IJYsYFwNza/Dz2uFMYG+yR4uJ5bwBoufqXX6HBqlhZ4yiMJm
         xbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302453; x=1730907253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HsO/rND4GDvVu41dLnUKGBz8GF67TRaGpWDgwnI7lM=;
        b=e7p+c50TM6Z88eyOF8SCy/Lclo/+8YZXR4JdEBGwWrK5bpvd5wNmij2eUNgxHxRZHv
         QIuPqIZkjwDUnmEyAgiGYjCRuTu7vJqn1od5ZJp/iaDqOxBehaPae6oPM8uxxjP42v0Y
         Yt+d6HdklKMusu604ATC1Er6aLa5Y9JtaCCRPt2TMvGelIxU7NpL2ckiMG1sZNOm9Ocd
         wRoQh1mlTG4SvI4a0eBjE7lc/6T/xzpY7ri1Nswk92x1Y01Z0c4ETJJA83fPR3/FDNSz
         yMTFlUX5Hi+x9Yh+5v9XOubgL7c0kqRCUQUB/mw3rBU0yJJ+2dWOFmqAy5DayxZSEzaf
         0kow==
X-Forwarded-Encrypted: i=1; AJvYcCW8/Rg0V6XxTfLMaDXmCGifTVxDPbaWK13453wYfXA2Re9YqMLKhYWoxE4ZEwFjTi11lKbFcvwAZZ6QpI4=@vger.kernel.org, AJvYcCWp+xlf73xvHAw54enCWMsReOAd32E8Xg27lns6VkZ2vxfxuyBIfNrxkNlwuoQCorkWg7w/rslI04Vw@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJ22Dt7lggDpX0vALd5TMg/pW8knDY05vr6hcQjiq1craWjVF
	Vcl0Y6GjX32SN/OXQOK3rxq42wIfRTfuNYZ40F5lo0dFDuA/C4yqxSNatJ9FNpMLdFsFybQLmRQ
	p49pgCXQaQ3QOLzucgsIVPINqRnLibEld
X-Google-Smtp-Source: AGHT+IGqwVpgGBmnDo2J6rVE4cgq6yKqDtypjpudcXXrLwTuLF3wFm0ONT6UYpuujeYmA95coXDlTmcRhbLIp4OsiTI=
X-Received: by 2002:a05:6214:5002:b0:6cb:c892:8c17 with SMTP id
 6a1803df08f44-6d34852cd13mr51324306d6.22.1730302453178; Wed, 30 Oct 2024
 08:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com> <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
 <CAC5umyitFp7oGR-eYXMVaS8bY1AGe3QwEuSPoEz3DxWwH=dUsA@mail.gmail.com>
 <e29e2c9e-60c1-4f32-ab71-e74f331e1921@kernel.org> <CAC5umyhCw+62Y+h3Jvh3=0Ocs8XJsSu_vaiPpO_g=65Jo4vUFg@mail.gmail.com>
 <e4985609-0642-4ff4-b074-8c5a34f88a24@kernel.org>
In-Reply-To: <e4985609-0642-4ff4-b074-8c5a34f88a24@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 31 Oct 2024 00:34:02 +0900
Message-ID: <CAC5umyhrNCA4BHqC_k_tSaSOANcvP_vt485650xtFTPwJ+6snQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8831=E6=97=A5(=E6=9C=A8) 0:18 Krzysztof Kozlowski <kr=
zk@kernel.org>:
>
> On 28/10/2024 15:57, Akinobu Mita wrote:
> >>>>
> >>>> You described the desired Linux feature or behavior, not the actual
> >>>> hardware. The bindings are about the latter, so instead you need to
> >>>> rephrase the property and its description to match actual hardware
> >>>> capabilities/features/configuration etc.
> >>>
> >>> Is this description okay?
> >>> (Reused the description of retain-state-shutdown in leds-gpio.yaml)
> >>>
> >>> description:
> >>>   Retain the state of the PWM on shutdown. Useful in BMC systems, for
> >>>   example, when the BMC is rebooted while the host remains up, the fa=
n
> >>>   will not stop.
> >>
> >> Nothing improved in the property. You still say what the system should
> >> do. This is user-space choice, not DT.
> >
> > It seems better to implement it as a device attribute.
>
> I don't know about that. To repeat: if you say what system is supposed
> to be doing, it is a policy. Describe the hardware and its configuration
> and maybe this would be suitable for DT.

Billy, could you please write a proper description for this property?
I'm not the right person for this.

