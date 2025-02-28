Return-Path: <linux-kernel+bounces-539580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA718A4A605
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F68178668
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4B1DED69;
	Fri, 28 Feb 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="alilDZPJ"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD031DE88B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782207; cv=none; b=G8Wfeo1tuQwHax1JX6exSHLd1J41GoGm4bomaGC82sVRN77I2ud12T30ShEUH15tn770uVSIvawCqL82nsBvGblYBcr4kNpJTaJ8zEtyLj/1kUKgQ0YbJsRywUqSvPJoXFrbZHXMYxutFmjdUyp4YDtDTDB/NMHifqGfn/RoprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782207; c=relaxed/simple;
	bh=WjShl4asHGGb+9sZPLLkfQ2fhMhhM9eCifpjK1TQcfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWLuZ/kPhzGsRxpx+KsosoyY9fAuJDnhOHzFx1uFRDNDYzjUAsl1Psdf8p12CSx4EIiyTbzAHtKYt7hZP6QQJG23eqP+FWK5AdmhRBWCDMAHCaK1qEslSjfk5CpqEztC4nVQ1K12WNl6Ss45xUpfMZ7U31dLUakC5JSlNbgvzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=alilDZPJ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3f8906c45so1540235b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740782205; x=1741387005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zhpx158jJJx5wQGS8QxSe2zVZf1/q36dI/wVrjVqjc0=;
        b=alilDZPJogpT7vC2HBtz18bYmoHQ1HUTZjCSB90ELejPijhoG2cDQNE14jiHGQkFIg
         vVKBbC88m64LDuVyEzbREjS8BeuTvA6XVl630THB+K0NH3A4DfJGCF/0scdjREXwnbke
         Uq23QnVfK6y4EGWVXFYI9X9TKqPCnPEMqTLk7J2CjSKcYKIe4hc9o7DOnppSSXiKJGRJ
         hvUMJdlGTr7ESlDUlwQdVXKzY3dLj4GyreW9tu4pirPG06Yb/0VLgxLMtEiGFjRDuMjc
         cbx16S1KPkYqgDr8Ufrwz3JRTH/1z5QsvWjn3ijald0KwXIggd9xt1gkiPOvuOF63juI
         tZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782205; x=1741387005;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhpx158jJJx5wQGS8QxSe2zVZf1/q36dI/wVrjVqjc0=;
        b=sKYBSDnUgUWEkxY4XPF8NfyhM/DUdNuqQ76ka+YwewjTMKhKAc4HsVyCUBkhR87jA/
         f7nKfICScMB/738vZ1vgZYYUF4MOoZc3tGIN/yYBgL43yPRF9JBvs45jHWuHbMYvVBXT
         RKMZc8jKcyPl3hVCfVraBABZtNqsPClTT5P1Dm9YSyxo6UrmMqujgUYYidh9opvZGqeo
         HcIZZ8W83qjcOUz6AeJ8auJ4RHSQHnq1miYyoMjxMYB+EaQMkeyZ7vEwVWAX02EVevXB
         SgGBPkqbe9b1mA83BUEWCopuc7D7l8RzXH0fgHSgAkIcrulNEaGi5eroIAVWG39XkrhQ
         XRfA==
X-Forwarded-Encrypted: i=1; AJvYcCWhlbJOu1YRZ0MWaGKRSdUykBRgtvp7LiY3C+5ecmOVHA2cpCWEWlo0YGBNyUeeb08q138BPecsk5agdq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5MqIcO/kjk3P8ZghnfoYqYnsWMBYfRM2621vuz98gFZ41RLY
	fK+YLETQ3cXpOPKag9BpMM70ilUS8w78MpxZsbCQemELUZ7jP5FfhzejKPhF/Wk=
X-Gm-Gg: ASbGncuO78USNmP+HzwpDZc8uQe4PLbunMSUdV8iMhbz/PTBd8X1P31JXe7Fo70sOjD
	o0Vg4645T15xul1BAnUe2mGDq078bmrZA3kfFdJGhH6SxieNkC+246LetZf5GY/rsodH084lr1L
	IxdZUZEN4FDHU+mB8S29FYyFiQwA4ChaKsRlDuTW5SbNwZ8LTJKoNMOYqFacdcN4Eo+8doa+INQ
	sHZMfXhL2e1WPlGwQNtoPTtndEr2IhXi7xiyusaDCe67PhUBYsrFLWRtHwwk3BfbLkgZcfjN9CD
	eGBwVToHrej9jH2oJaM2604bFW21KwBUEIhtFK8BgfeSP38K2Szm6a46cH7uNLxIvFp8CHne6TW
	2ozL+OQ==
X-Google-Smtp-Source: AGHT+IFN3MmzDNTbHTqpXUZabE7IypJM3ecDdx2I6x2htebjZZEnVw9OC67bBNq8u5CxMLqcH71Vcg==
X-Received: by 2002:a05:6808:640f:b0:3f3:dd2f:6a9b with SMTP id 5614622812f47-3f5585f4d02mr3364363b6e.30.1740782204813;
        Fri, 28 Feb 2025 14:36:44 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f5507c3fb7sm822158b6e.46.2025.02.28.14.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:36:43 -0800 (PST)
Message-ID: <7fb93572-3ef4-47f2-b505-669af742dee5@baylibre.com>
Date: Fri, 28 Feb 2025 16:36:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-2-david@protonic.nl>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250227162823.3585810-2-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:28 AM, David Jander wrote:
> The Linux Motion Control subsystem (LMC) is a new driver subsystem for
> peripheral devices that control mechanical motion in some form or another.
> This could be different kinds of motors (stepper, DC, AC, SRM, BLDC...)
> or even linear actuators.
> The subsystem presents a unified UAPI for those devices, based on char
> devices with ioctl's.
> It can make use of regular gpio's to function as trigger inputs, like
> end-stops, fixed position- or motion start triggers and also generate
> events not only to user-space but also to the IIO subsystem in the form of
> IIO triggers.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  MAINTAINERS                     |   8 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   2 +
>  drivers/motion/Kconfig          |  19 +
>  drivers/motion/Makefile         |   3 +
>  drivers/motion/motion-core.c    | 823 ++++++++++++++++++++++++++++++++
>  drivers/motion/motion-core.h    | 172 +++++++
>  drivers/motion/motion-helpers.c | 590 +++++++++++++++++++++++
>  drivers/motion/motion-helpers.h |  23 +
>  include/uapi/linux/motion.h     | 229 +++++++++
>  10 files changed, 1871 insertions(+)

Ooof, this is really a lot for one patch. Makes it hard to review. 500 lines in
a patch is much easier to digest.

But before commenting on the details of the code I have some more high-level
comments. As I mentioned in my reply to the cover letter, I've gone through the
exercise of writing some motor control divers in the Linux kernel that have been
used by 1000s of people that used them to build everything imaginable using LEGO
robotics over the last 10+ years.

From what I see here (I didn't have time to really get into the details of it
yet, so maybe missed some important details), it looks like you are trying to
do motor control stuff in the kernel so that the interface for a basic H-bridge
will be close to the same as a fancy stepper motor controller. We tried doing
something very similar because it sounds like a really nice thing to do. The
kernel does everything and makes it really easy for the users. But what we
actually found is that it is not possible to make a solution in the kernel that
can handle every possible use case. In the end, we wished that we had a much
more low-level interface to the motor controllers to give us more flexibility
for the many different types of applications this ended up getting used for.
Having to modify the kernel for your use case is too high of a bar for most
users and not practical even if you are a kernel hacker.

When writing kernel drivers for this sort of thing, I think the rule of thumb
should be to keep the driver as "thin" as possible. If the hardware doesn't
provide a feature, the kernel should not be trying to emulate it. So for an
H-bridge I would want something that just provides a way to tell it I want
fast-decay mode with some normalized duty cycle between -1 and 1 (obviously we
will have to multiply this by some factor since the kernel doesn't do floating
point). A duty cycle of 0 will "brake" the motor. And then we would need one
more control parameter to tell it to remove power completely to "coast" the
motor. I guess this is what the "basic_run" and "basic_stop" are other than
the run seems to have speed instead of duty cycle? The kernel shouldn't be
trying to convert this duty cycle to speed or have a background task that tries
to provide an acceleration profile or turn off the power after some time. Just
let the kernel provide direct, low-level access to the hardware and let
userspace handle all of the rest in a way that makes the most sense for the
specific application. Sometimes they might not even be connected to a motor!
With the LEGO MINDSTORMS and BeableBone Blue, the H-bridge outputs are
hot-pluggable, so they can even be connected to things like LEDs or used as a
general power supply. (A reason to call this subsystem "actuation" rather than
"motion".)

Another way of putting this is that it was very tempting to model the actual
motor in the kernel. But that didn't work well because there are so many
different kinds of motors and related mechanical systems that you can connect
to the same motor driver chip. So the driver really should just be for the
H-bridge chip itself and not care about the motor. And the rest can be put in
a libmotion userspace library and have that be the convenient API for users
that want to get something up and running quickly.


