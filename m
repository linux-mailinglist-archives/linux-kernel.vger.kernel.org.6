Return-Path: <linux-kernel+bounces-540716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B86A4B425
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6906F3B0B84
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0372C1EB5FE;
	Sun,  2 Mar 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwxwC6j1"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3EE192B84;
	Sun,  2 Mar 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940909; cv=none; b=RAB2V4bwg7wacXf4hiq3+QpqfvHWgv/LE0OODutJI4yWLeeRfG66xubbZ46U/QAwwIXDSfMId5N2X5NG8reKI5pzOiB5HTgT2+B8X2DeOQpAYp+ZWwf3s6Cg0vtPVXTd8cOStS1AqG5oV53RC27MToSFbwrStQHTwxIjwjWHjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940909; c=relaxed/simple;
	bh=Abbwh+Z5xhlgNf2aQeAmhgLyl8Vao4lpBVn4LqriQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+pNGVlIZbVCM8sT55gUJ5igfWAYsN+708BMc5wChOPDsJYxUB9szSr6n3pq4jt0rN+pgXpIBe9lA0c5UQ51KwE4mlNNbWCSPg1h9plJ9TfVRHq9uyS22LYLO/maaeyz5AGc8fUEPi4CobPHvgYCnWP/XEeBspAxpWTpIEedoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwxwC6j1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso5491192a91.1;
        Sun, 02 Mar 2025 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740940907; x=1741545707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WQSVMiOMZEq/mCTCgIk0aL5AHS6jkSlau18UDaVyUs=;
        b=VwxwC6j1b5xLBLOvmuCFhwDtoHw4aDBXrIz0fSyhE6/IhKVJ0B6Xa1PSKFRU5vledv
         cXsMkMqfLYdhFWZpSXZFw6VSL1skAM7r28iOgCbkl+jpnKAsvonGMLKQkrXTrD1lTnDO
         SMbFmwzHCwgGuyBrVVso2N2odl4LxMVbbBYe74j1EdTZ+Jk02t2Ps82fp8K79lSIxGHM
         P9njbNJGENR0Omknix33z2b07Uv7ofaY7K5wggKBtA1ctdpXHiE/JajzlxJfC5m1Aejd
         6mdlb2oD3IVJ7EJ2QIuNPS7B5HCalrkKn0ClZxTXCQHKe4/tQ85DmEeWK/XBTjDqCNsg
         KXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940907; x=1741545707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WQSVMiOMZEq/mCTCgIk0aL5AHS6jkSlau18UDaVyUs=;
        b=ILy4WCH4Bx2Uh5Hke6J9ag8f6AMJpnizqig1miYUnN08B9Pwdva8VmHlx9wJniL+I6
         /2ZjX/cNSHNrqQJymwgfKb1t22d8XBTPCtA8Q0KyKQyxmAjPXWT9MliG4ZwPm7a9Ly5+
         yphBa0XYGUwO3ioVQW7mPJczzAGCpQqy8dYVadZS7ccF0nYJAOmX6yvVBYutVfKSzAGk
         /SQGIlsYqGpoPjLmg+28Cr2F8H71Ph6DtbhUv6GvuF3y4lFbWAuFmoyHTdEnkEWPSpdq
         0/SPWTh8Itt6Py8EdTixAs22jzBjv+37gwTfNVs1OKY2+HVzVA8f/ktP0Mlm9e54ys2q
         9W6A==
X-Forwarded-Encrypted: i=1; AJvYcCUaPM4l3DJ8Rv8EBg9RPrDyQ4TbiEexJsP9d6hsuofZWdaWlzLm4g7UUbihfIcgkoVmnwW12hxXPlahfGk=@vger.kernel.org, AJvYcCVXE1zAa/TB0TjjH/06MYJB6xQRLlj2zA6gpR18H3vueL0PY6LKA71jhYN4FJvvTmlFQZ60Fmo8o7s=@vger.kernel.org, AJvYcCVZq+zgu6v+37nwZ9l3WlmAWzSUGJHFky+fiJKrbT9zhYiQN9B+2DiRpbj2iH2DiPuLlnIQYc0eZhtH72kj@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDkp6KHU//2Ss3wKCXHiIelUaA5Y2XodpcfQFaNhpMcKAT4G0
	VkCsyN/jcpB7Jhvlv96CTzRlogQ2aRvugJ0ZifQji/nvQs7UKJVO
X-Gm-Gg: ASbGncve6O9XrdDosNBheYiDdhq/SpAQQyjMhZ79QKYOHCBtRHhy8Uq5krzT8HWRHmu
	mRXAQXc0xtiX86ORyPMqJpW6NDv+dzMf2CXe16SRIX9YCdyUARD+Zes2NR0MQzneVJrR5IZsdW4
	EZUu5s3psr1KkwiR3Ee4jo5LSKpSxIyWoHiEsc7U4HSeGBwREAsld9AE6knWcf2GTpjWq4d/He0
	yiiccydse9X0aN9ChI3hQ3+96F0PtphVh5GlghwKwyo9NjZx042VBMBN1PDhj2boumuNohxXheO
	Y2HmNop9hDWBZXiZ4P+3dclu7FShb1gGZ4iWeOPz9ykqGpS61kr4o+4FuQ==
X-Google-Smtp-Source: AGHT+IHuEFWEguTkr+Uzcr9o5sfTXZM/Tyo2Aj8Ai3HrgXVsI97W4NxgUU8dI0/ICKERBy/329zs+w==
X-Received: by 2002:a17:90b:4d04:b0:2fa:176e:9705 with SMTP id 98e67ed59e1d1-2feba7e66c2mr16501558a91.10.1740940907259;
        Sun, 02 Mar 2025 10:41:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea67a6fa4sm7320355a91.24.2025.03.02.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:41:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 10:41:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] hwmon: (max31827) add max31875 support
Message-ID: <a8fecfe9-6fd4-4dae-95e8-26e47e0424b2@roeck-us.net>
References: <20250108082531.15467-1-johnerasmusmari.geronimo@analog.com>
 <20250108082531.15467-4-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108082531.15467-4-johnerasmusmari.geronimo@analog.com>

On Wed, Jan 08, 2025 at 04:25:31PM +0800, John Erasmus Mari Geronimo wrote:
> Add support for max31875 which is similar to max31827 and other chips
> of the series.
> 
No, it isn't. It is yet another LM75 variant, similar to max31725
and max31726. Please add support for this chip to the lm75 driver.

Guenter

