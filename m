Return-Path: <linux-kernel+bounces-437938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562319E9ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAF91887B00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BF1C5CD2;
	Mon,  9 Dec 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iS36c+PJ"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17F21B423A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758866; cv=none; b=VTxoDNZjEgvXjFT/pgWkqmsGp4kh9CsZ+Pmm9CHKPItE95hXjuWCJwsNPK2U/biRkWri1lnExMfN5Fp1Ty6o3IzlAKbWYNFdQswgzVhHLIhX4OFCfr3qt0E8ET3XyIKN3EYPAmKBaFn4cpQi+K2uuKjoGJZDj837F6cVPvGYNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758866; c=relaxed/simple;
	bh=h123t4B81fCdABiHhAZWInvx+2INgZ3KeyjlXW2iePE=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWO3tpNpFcaKjO+/e+z0DSXWAwi3ajaOjoh1wLkxMX6eFaX8fmmKAuLfctNl2sgpzMZiPSTFJCiZwi/jqTDjVaTheHsX7UIxCiU8rRsqBas1oTooC9ZZA1/o5fK7EDZDmZoEAuZvWLWdhNnclcAqE9Gn2c9o++KBp+X3qWt30lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iS36c+PJ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2ba68b40aso441370eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733758861; x=1734363661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h123t4B81fCdABiHhAZWInvx+2INgZ3KeyjlXW2iePE=;
        b=iS36c+PJ3rVk39g3l7NMs3WSTInSmhBqzq2Vr52qVvG+YWBEKFfIxLHYoUxc1lKdrh
         rGREU7eIynSRHgxi9v/R7vuQflNxemZAM5tr2LxJRM99EDnA8+Y60u8bvfg539rCxk6v
         eVPrii/JzdS3bdXuZjmgWwcUI2f2Qb+P769WPJsfxfSbexq8zDNzWp12iA+08IDwfnmg
         rtIRv5TBmSajDQtb61lOMFUQ+v3J1DRpVH+vW5eXToGe4XGK3EcaZCvIUIb7sF7qHg25
         N+P0/niSHoJ0faB6gT/wW+4o4IZn6x7EHhSk/Wh8Igy1OpsQkNa4oFHtqy6QGzGkFEbo
         /a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758861; x=1734363661;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h123t4B81fCdABiHhAZWInvx+2INgZ3KeyjlXW2iePE=;
        b=Ii5cQbs/xHpGD7h7KeWCr8gJ/zLG8BBX+qbvT9oCBRlgtG2+Kf41VtbezdPqRoyY6B
         LZyaD9HaUnlxN/QF3umRxvbLVBCXixjBVNXEEybH1eyEoKO4lVzzbrXtV9m9srVeP5xX
         6vZ+Sc55VHIZnoKOEowYysDbr4DpSWfOmgpICD0XdyGOEuMnxBhli2DwtdOEHCdbXiFs
         rMQ2DzVa/eidiZMKbg0wGp/QfI5NgQy5lBr51R5tlVjpLmiWOVidjSkAT8WR0ig5j2I2
         OQVDC0jcD2xg4rbg4N7FJhPR1nZPrAAzLTR3btG96M7fZ3oofVin9wHC+un4r0fJHTsH
         7MBA==
X-Forwarded-Encrypted: i=1; AJvYcCVhbDUbeNakxxNC+Tng9dudTr1I4amv7oCgSn/5HDJjOYt6wg8kOmpYB/RFH4fQEJ5oRJaB3ebgq7kuwEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdU/rL6fowl0oJQrDOxgNKb9DOyBCDyfvRI9hiSfz4g/1j+zeR
	QT+t5ZdAi7Sm2uU7uJV/2M67Ux6xdfalVnodZRmQuvERi2C87H2JWSHh4lHXAZw3XyTGcK1jJJW
	UsX0zUoo2f9DRtlHHTM9S+LgDdU3auomJuINbsg==
X-Gm-Gg: ASbGncuEtwl5G3AO9s4IVITIXSNd+DIBAiQNKj4TN6yq7PFBwMzr6wMeYt084dnGdmQ
	DBdNOH8+sLPpmL9vs1t/KHdtYn8ToGg==
X-Google-Smtp-Source: AGHT+IEjPouzolejMg67vAI0Ny9U0CEAwdepwhmwbtDevJp2AiUZlhc38RsXlu1EPdgdo/t8kiz/fVKM+gW1NKkmyeM=
X-Received: by 2002:a05:6870:1b0a:b0:29e:6814:19d with SMTP id
 586e51a60fabf-29f731a80f5mr10818509fac.9.1733758861695; Mon, 09 Dec 2024
 07:41:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Dec 2024 07:41:01 -0800
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.9
References: <20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com> <b296a23d-bc65-481c-a194-cb16535d8c24@baylibre.com>
In-Reply-To: <b296a23d-bc65-481c-a194-cb16535d8c24@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Dec 2024 07:41:01 -0800
Message-ID: <CABnWg9spateMzOnAGL42GmSbnhL5vwsMpwBm+rGVe4DAdyj6=A@mail.gmail.com>
Subject: Re: [PATCH RFC] iio: adc: ad7173: add openwire detection support for
 single conversions
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 21:48, David Lechner <dlechner@baylibre.com> wrote:
>On 11/15/24 4:34 AM, Guillaume Ranquet wrote:
>> Some chips of the ad7173 family supports open wire detection.
>>
>> Generate a threshold event whenever an external source is disconnected
>> from the system input on single conversions.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>> Hi.
>>
>> This patch adds the openwire detection support for the ad4111 chip.
>>
>> The openwire detection is done in software and relies on comparing the
>> results of two conversions on different channels.
>>
>> As presented here, the code sends a THRESH Rising event tied to the
>> in_voltageX_raw channel on which it happened.
>>
>> We think this is not correct but we can't seem to find an implementation
>> that would be elegant.
>>
>> The main idea would be to add a specific channel for openwire detection
>> but we still would need to have the openwire enablement and threshold
>> tied to the voltage channel.
>>
>> Any thought on this?
>>
>Just to spell this out in a bit more detail, my understanding is that
>the procedure works like this...
>
>To detect an open wire on a single-ended input, we measure the voltage
>on pin VIN0 using channel register 15, the we read the voltage on the
>same pin again using channel register 0. The datasheet isn't clear on
>the details, but on one or the other or both of these, the ADC chip is
>applying some kind of pull up or pull down on the input pin so that
>each measurement will be nearly the same if there is a wire attached
>with a 0-10V signal on it. Or if the wire is detached and the pins are
>left floating, the two measurements will be different (> 300 mV).
>
>So this threshold value (the 300 mV) is measured in terms of the
>difference between two voltage measurements, but of the same input pin.
>
>My suggestion is to create extra differential channels like
>in_voltage0-involtage100_* where 100 is an arbitrary number. These
>channels would be defined as the difference between the two measurements
>on the same pin. The event attributes would use these channels since they
>are triggered by exceeding the threshold value according to this difference
>measurement.
>
>To complicate matters, these chips can also be configured so that two
>input pins can be configured as a fully differential pair. And we can
>also do open wire detection on these differential pairs. In this case
>we would configure input pins VIN0 and VIN1 as a differential pair, then
>read the difference of those two pins using channel register 1, then
>read again using channel register 2. The we see if the difference of the
>two differences exceeds the threshold.
>
>In this case, we can't have in_(voltage0-voltage1)-(voltage100-voltage101)_*
>attributes. So I guess we would have to do something like
>in_voltage200-voltage300 to handle this case? (voltage200 would represent
>the first measurement of voltage0-voltage1 and voltage300 would represent
>the 2nd measurement of the same).

Hi Jonathan,

I was wondering if you had any opinions on this RFC?

Thx,
Guillaume.

