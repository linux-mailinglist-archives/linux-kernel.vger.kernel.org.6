Return-Path: <linux-kernel+bounces-539579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A23A4A601
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C7817864A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2561DED46;
	Fri, 28 Feb 2025 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P9EXVml5"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067E1DE3C2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782198; cv=none; b=Y4e7ynzAwZTeGQuKoHMWwzYDoD82G2b7gX5T0NNZGOaONQrr2iCbJxXt1eIUUvfuFczIEsBJzTnZbdNlZLQV01HWUn6ysVqXMeTh7oLTxB/SbqMvbQFVWBGcqMLhmRSN/dyqfknoDk0AQZx9qIul5iUwRAjuTBZHwYsdVl2wsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782198; c=relaxed/simple;
	bh=dj9aUqKq7K6s4IS0PgCRGxyEXLKogXQQAAAwNjRJNiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foc31b1Y+AwgHgogFg6l9yL4yZ84qivok8mqUpPqymk2DuSJb9mQTxNqyn93xe/xqBLaAj/9IY3YCwVLQr4UZAzh1dr54S/83ehip+kIR+bYDzoFZGqMM3iNBII4Bxtvyt2sPZopQVRWLbPofojRh8d7tAHYNwjB+tW4+7wJXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P9EXVml5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso1634189fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740782195; x=1741386995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxgtYWhq4VVZT74cQGrqn2Xp9MqE7TZL5iblYOskVVA=;
        b=P9EXVml5rY8bLRRb/M8X7ARx055Ghot55OhMINyh4qlZscyfQhYLJyZxDxv4eW6eu2
         q0MykSLQ/7Rey1gcHCPGWIXqGQVhjc8pl0ZEY+ORWGAdWsIPCFFl4JJWvUBt4d8esvMH
         KfGNe4zrFa3YMb1icOyyVsTBhhMGANQ2JbVJSTy7D9q7bPGGkSQDW82D7DaWF7fqf1bI
         I5OqEgV4yHzx2FPMYU/uUPP+4De9DnZv1kY573N2AZ+t0uZdiF5me6lSKOexsgFntIOd
         4ogCxsJm8fGeJe5oi4vUy4u4l9JPJkHpaLhBEU0FAYja51dylDhd2R7VJHJ1/KuSJTLz
         ISDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782195; x=1741386995;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxgtYWhq4VVZT74cQGrqn2Xp9MqE7TZL5iblYOskVVA=;
        b=KMz1nlNPTB1/YZi9WaK8wcd15V7fjCj+PsaZKbBxjZ0V4IAAVl578tM6+r3XkD9HPe
         GOomSztFow2sE5vtHFuAnPoFWMKW5FcEWCvgDGy+fqLb5rO1b1d6NvGAKRNdScaYQLCF
         d0Un8nGFc2v2KlVj4Sf0XvS7CMFdEzim9viMjpxFfIE4fbApJXlfk2t3d8GziH77Zdwl
         PF9eu436mxntFnKj+2Tlp8UQa/E620iLPRI9JZQO3qEqkXQuRJ0aJL5OKM2BHZTXBTpn
         /vrxkieFdITbNyCzt5LeplPsW4vRzA869GD5B5WEtIt8/6dAwAQ1COUI4DzcFXg8bWHL
         taPA==
X-Forwarded-Encrypted: i=1; AJvYcCVobyjLFRLAI5xGx/SPgE+pLWca0dkX9rnEm2KDctTYbV2t+8+yxWZ/M2rYcC+vDX1J23kJUV9KtGBm+Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCT6q9ky0nNLfadLq1D4ufi/tlDrRJmTHk1I7TWdAKQaRJNe+f
	vZgu9sXqQ/LVWKWUBBVA7LVb0e1ci3RKpVXZsq47xpe527VuPr/IMJvpeFqxiKw=
X-Gm-Gg: ASbGncshLy5nykWcWawzH3yXkPU98i9Vw6GH+WCklnGi2GuIPSFDBSYpCC2OZ5SYYgc
	LIEsdTrh6VTHv1B06OvoR6T579Bi33v/mCtj5QwN21or5h5IIULNlAkkC/at4A5L1g9A6NQoHGO
	aK23E0azkgLQbKAPGKdOHb1aTTYbg1D2VYYNFw86CV918KMdNuahsqM3eGZ9svcxD3shU1YQ/7V
	fD+izGK+AwgLPaHO4bHgEhtMv7NoNn4MxIdHQpmkFdzHPTtBWOKyHcrGUtfv42m3FQa20NQlNT1
	lqlvsmC7FaHxF3tY8h/LKTzt2UMMgkZLrJl4BrwTfAIqZ3QYkn2bxNdrgF/ickC7zXbZiXm/X1j
	PLs6xwA==
X-Google-Smtp-Source: AGHT+IHqvEXueQVCTasX8QfXzE6WK79uLmJfT3y2kkxzOgtoyjC6KYNPZrv39VbgXM+hrCQRR8Y13A==
X-Received: by 2002:a05:6870:a686:b0:2b8:2a9d:5663 with SMTP id 586e51a60fabf-2c1783b22cbmr3269639fac.11.1740782195287;
        Fri, 28 Feb 2025 14:36:35 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c1aa1f2sm902532fac.27.2025.02.28.14.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:36:33 -0800 (PST)
Message-ID: <09afc3cc-a307-4662-bd70-0cf83f8f38e0@baylibre.com>
Date: Fri, 28 Feb 2025 16:36:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:28 AM, David Jander wrote:
> Request for comments on: adding the Linux Motion Control subsystem to the
> kernel.
> 
> The Linux Motion Control subsystem (LMC) is a new kernel subsystem and
> associated device drivers for hardware devices that control mechanical
> motion. Most often these are different types of motors, but can also be
> linear actuators for example.

This is something that I played around with when I first got into Linux
kernel hacking as a hobbyist. It's something I've always wanted to see get
upstreamed, so feel free to cc me on any future revisions of this series.
I'm very interested. :-)

We made drivers for basic DC motors driven by an H-bridge both with and without
position feedback and also a driver for hobby-type servo motors. For those
interested, there is code [1] and docs [2]. One thing we would do different
if doing it over again is use a character device instead of sysfs attributes
as the interface for starting/stopping/adjusting actuation.

[1]: https://github.com/ev3dev/lego-linux-drivers/tree/ev3dev-stretch/motors
[2]: http://docs.ev3dev.org/projects/lego-linux-drivers/en/ev3dev-stretch/motors.html

> 
> This subsystem defines a new UAPI for motion devices on the user-space
> side, as well as common functionality for hardware device drivers on the
> driver side.
> 
> The UAPI is based on a ioctl() interface on character devices representing
> a specific hardware device. The hardware device can control one or more
> actuators (motors), which are identified as channels in the UAPI. It is
> possible to execute motions on individual channels, or combined
> affecting several selected (or all) channels simutaneously. Examples of
> coordinated movements of several channels could be the individual axes
> of a 3D printer or CNC machine for example.
> 
> On the hardware side, this initial set of patches also includes two drivers
> for two different kinds of motors. One is a stepper motor controller
> device that containes a ramp generator capable of autonomously executing
> controlled motions following a multi-point acceleration profile
> (TMC5240), as well as a simple DC motor controller driver that can control
> DC motors via a half-bridge or full H-bridge driver such as the TI DRV8873
> for example.
> 
> Towards the IIO subsystem, LMC supports generating iio trigger events that
> fire at certain motion events, such as passing a pre-programmed position or
> when reaching the motion target position, depending on the capabilities of
> the hardware device. This enables for example triggering an ADC measurement
> at a certain position during a movement.

I would expect to be using the counter subsystem for position, at least in
cases where there is something like a quadrature encoder involved.

> 
> In the future, making use of PREEMPT_RT, even dumb STEP/DIR type stepper
> motor controller drivers may be implemented entirely in the kernel,
> depending on some characteristics of the hardware (latency jittter,
> interrupt latency and CPU speed mainly).
> 
> The existence of this subsystem may affect other projects, such as
> Linux-CNC and Klipper for example.
> 
> This code is already in use controlling machines with up to 16 stepper
> motors and up to 4 DC motors simutaneously. Up to this point the UAPI
> has shown to be adequate and sufficient. Careful thought has gone into
> the UAPI design to make sure it coveres as many use-cases as possible,
> while being versioned and extensible in the future, with backwards
> compatibility in mind.
> 
> David Jander (7):
>   drivers: Add motion control subsystem

Would it be too broad to call this an actuation subsystem instead where motion
is just one kind of actuation?

>   motion: Add ADI/Trinamic TMC5240 stepper motor controller
>   motion: Add simple-pwm.c PWM based DC motor controller driver
>   Documentation: Add Linux Motion Control documentation
>   dt-bindings: motion: Add common motion device properties
>   dt-bindings: motion: Add adi,tmc5240 bindings
>   dt-bindings: motion: Add motion-simple-pwm bindings
> 

