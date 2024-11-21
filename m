Return-Path: <linux-kernel+bounces-417257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD89D5181
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411DD1F21EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD715689A;
	Thu, 21 Nov 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="ENWjK1wT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F851537C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209582; cv=none; b=DUJyd/pfVsub4GdyW/tyB898Zb7PMMd8VhVZ/yjRjyPzt1UglZfvbx6vJBB67s2lVzoe25VhiJ//krS0LbLqZd2+z8rlTc0Pw5EYTFusjrfZ6RKhOt1gIATLVlV0+BFerzeuMWgLAyrp2cGLNL0mkh1ckD/zWlhLf/3JbYRnCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209582; c=relaxed/simple;
	bh=n8Wo1iQ52Aw1E64TSb6ntmmEig/Iw/KhYEDmtwYBRLA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVTG5xXukdT6VGSF3L9wLjE5RakoRkYUy0omhlFJI40Tauaayg1BxKFhDB8T6tEE6lzy1CiaqF2XjdRMQ4x4gBg6Q7byQGkHeX/5iMUTatuzSd6eULM+jtT5ZBvW9jjeqLemmIvgOh78fitscl3Xu/mwJSY3N8nTaqISyjyyZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=ENWjK1wT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec86a67feso214244366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1732209579; x=1732814379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fik5fg6pZ4xpZXDrf0q8ORna4/F0UwRhMO+ozPaBmr8=;
        b=ENWjK1wT3eUfJkxbfMf4px8lL6ij0/oLqYz5HRxPXiVu5yhjRcWni2nH3GEQDUZBiT
         z+VZ322C0k3eoZWvVDNXsiTI8TH7wOmT1Fygk5haGl8ISL7EgR8oDEwa8Rv0VVg9M3y/
         DzRa6dtdTO5r6MH6KhVkU9KnJhtgTEhsx4u+gngQ6B8rVn28mGGH4r+Pe7NHUY3zldzy
         xSaAgBX0uPNWW1PVPqZDEsCNyZEjHQGGBYTe/FhT7k5PAJz0PwbKsjUxJVkB0AO5oApF
         TVZkPm04GhT2lyLuO8jBxXH9F35tiggUihGUIr/elSkokSn1hlDsXNUmqQbbRmuPQyou
         9Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732209579; x=1732814379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fik5fg6pZ4xpZXDrf0q8ORna4/F0UwRhMO+ozPaBmr8=;
        b=HeojDpfYg1F1cZ4k1bqcO1K4pnYs7W8bPMyXvN8s4wxxS5grDerBTlPXSTZIUIkRJW
         +/Fgvvyc8fEEmnEVKztQbTifR4BBXlNQf0adOwXpEKzG4FjW4W6XUQI+eXDh1j0bLNcZ
         jyflTOa9etM6lQKndsdaiBBmFiU8mKZ4W5CLMJXhRNYqpn+DExXHFC04FdhegoJiMzY0
         pqHI9AqWFqaDqX0Q/Y42GuE9i5H3Q839H/Yrj46TJ3HFv/GNvB4pYClC8klEnflJEWgx
         lWGTrtrkWUexk2JGBplQbNGoy6ZlQxkqg1q3BMCkzhO1wtywAN6mbTC2rEArU30OG5G/
         xiqw==
X-Forwarded-Encrypted: i=1; AJvYcCV6HakS/OLSPKaAkpudBCHHK9kaQ49+KaUrtgFVjJceRfCxM18nZC4cZL3hEoAB9QBL99XUx/GesklpKhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGo2MTWJ+4LqHYtH3Z1Fh00VBzLs7f4PDFUsgsY1axwfcsUrgL
	3lg2dSv7ba70KUih1sny5agZWtSCbLTGAPfV4mV9BSzr/LL/tEHaK8mUzbFYRy+iS20X1V98XdY
	Iq+IJKm3+69gS879WzdIJOUuuIZPArHGWwwRjg6t3eVTZzhbt1G+4IXrq6p55ALtQQROoGu06rC
	lnOJmRDxCvHPfeADeTil0yhr2FORo=
X-Gm-Gg: ASbGncsINqFeiAtd7v9pA18yx3XrxE+rmO2PC+EShyZJhjZbrDCTD1x5jACwlNirrmc
	xn0+RO8xf8gkJp7I6z5M3c4S3wtEfvBvzCa+v2hz8+1E/EN2IcxMdJrKXJ60kEeQIBdOCow8qI4
	L6hT8UJNaC0LZc/nvsjr7e91GJA8wsCLx5RI+trk0eeN+6EIBnpAM/Hte0yx7FdScdnYNMmq1Vm
	JMOJZNYV1SzvWhZFfiJjT/BLbzu8vCavn3z/8+dERrDkVFpv1bWZg0e/3Zwjs4eNb4Vrm+JN0qu
	JMfujgZuGsb/j9qaaw==
X-Google-Smtp-Source: AGHT+IEgydldMZZK3DL67PowCK6G04XlplMKaFxYYjgxXS8/yAqD7Uv47pTRRe/rOwuReXnCnuRW8w==
X-Received: by 2002:a17:907:97c9:b0:a9a:e0b8:5b7c with SMTP id a640c23a62f3a-aa4dd52c717mr743373966b.7.1732209578751;
        Thu, 21 Nov 2024 09:19:38 -0800 (PST)
Received: from admins-Air ([2a02:810d:aec0:2a54:6de0:d3b6:653b:5260])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d48dfsm102526666b.106.2024.11.21.09.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:19:38 -0800 (PST)
Date: Thu, 21 Nov 2024 18:19:36 +0100
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 3/3] leds: Add LED1202 I2C driver
Message-ID: <Zz9rqJ4CXENy7wZm@admins-Air>
References: <20241118145449.7370-1-vicentiu.galanopulo@remote-tech.co.uk>
 <20241118145449.7370-4-vicentiu.galanopulo@remote-tech.co.uk>
 <f6620b99-aabe-4b76-8a60-deae0a9042ae@wanadoo.fr>
 <Zz9pZsQEM29dLu7k@admins-Air>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz9pZsQEM29dLu7k@admins-Air>

On Thu, Nov 21, 2024 at 06:10:00PM +0100, Vicentiu Galanopulo wrote:
> On Mon, Nov 18, 2024 at 09:13:32PM +0100, Christophe JAILLET wrote:
> > Le 18/11/2024 à 15:54, Vicentiu Galanopulo a écrit :
> > > The output current can be adjusted separately for each channel by 8-bit
> > > analog (current sink input) and 12-bit digital (PWM) dimming control. The
> > > LED1202 implements 12 low-side current generators with independent dimming
> > > control.
> > > Internal volatile memory allows the user to store up to 8 different patterns,
> > > each pattern is a particular output configuration in terms of PWM
> > > duty-cycle (on 4096 steps). Analog dimming (on 256 steps) is per channel but
> > > common to all patterns. Each device tree LED node will have a corresponding
> > > entry in /sys/class/leds with the label name. The brightness property
> > > corresponds to the per channel analog dimming, while the patterns[1-8] to the
> > > PWM dimming control.
> > > 
> > > Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
> > ...

Sorry for resending this, I pasted wrong in the previous one and didn't notice


> > > +{
> > > +	return value/ST1202_MILLIS_PATTERN_DUR_MIN - 1;
> > 
> > Can value be 0?
> > If yes, should the return value be clamped?
> 
 No, it's called in st1202_duration_pattern_write, which is mostly a wrapper,
 called in 2 places:
 line 225: ret = st1202_duration_pattern_write(chip, patt, ST1202_MILLIS_PATTERN_DUR_MIN);
 line 258: ret = st1202_duration_pattern_write(chip, patt, pattern[patt].delta_t); 
 
 for line 258, I make sure in line 250:
                          if (pattern[patt].delta_t < ST1202_MILLIS_PATTERN_DUR_MIN ||
 				pattern[patt].delta_t > ST1202_MILLIS_PATTERN_DUR_MAX)
 			           return -EINVAL;
 that it respects the range provided by the datasheet and supported by the chip.
 
>  
> > 
> > Is it needed?
> > (There is no i2c_get_clientdata())
> 
 Indeed, not needed so removed.
> 
>  
> > > +
> > 
> > CJ
> 
 Thank you very much for thanking the time to review!
 
 Kindest regards,
 Vicentiu

