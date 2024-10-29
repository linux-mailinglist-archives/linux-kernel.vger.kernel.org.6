Return-Path: <linux-kernel+bounces-387837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448C9B56BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED75A283E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405320B202;
	Tue, 29 Oct 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EE40vylv"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8120B1FD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244228; cv=none; b=W2MtzQ1jVKvpnXA5qROHharI3g49BqyggbeD9gLLMhZ2BR2+Y73sBd4ANI0bIxYm82yoePaG3ZZFipKwY1rJg4KLil6ZJ1emeL99xPofww5GyN5k8CT4z91n4diG6q81A2qkzX3cbD+gvYtAIMlXPhVJew4Gisk0JyIW+lFaomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244228; c=relaxed/simple;
	bh=Pm4GnU7xxA+eG7GdSdjp7YUMDc/0xIrLaoLzvPTyAFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwsGlfh61m/POl/rSuqYJTVz8zS71jM2HE6OroDVNDd/gMbYdeRhzqse0TnMLMq2OW/sKinNzTZoaLT/grCInWU/69p0f1P5uu2PogMuodBBMD8B0856/FzbhWzo58Z3RBGSVDSwEqlDXU/ktJXpj0gKKZT6XZs2P7twu+HP4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EE40vylv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso4281542b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730244225; x=1730849025; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eq2TIvU7l6qClPWET1EJnvUTYGhEKlxfTR2646JQmYQ=;
        b=EE40vylv6Yq39+ER3dgLD/sA237LE0D4eech4uuxDpWR+YaT862tYnvj1xRwwTCpiQ
         pooJCjmFp4y3/YTwMxnvpO9lhpl6Y8SRSjA6EhUSUUy+edbcqrQVcajvaKfC3RuP5h6k
         Qz5zUcxTCtR+xOrZmmWwYBjyzxCU7Rhj7SzM2buBjVttDNVl0sSc2z9P2mYR8UF5evTM
         cfcs3uCANoZRMdw6t1ozhjdsXvo9ZyoQWCaTLtT5ZIq29REVpM4MXAAnzyF7BnXUtHbY
         Qh9odMXBXjNlRwvxVXdsurTOzukTTD/eWHU+5H9SsrHTLvyLiZ4lfAhhRUCIj2wR0wmE
         WQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244225; x=1730849025;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq2TIvU7l6qClPWET1EJnvUTYGhEKlxfTR2646JQmYQ=;
        b=UvkYw0Uk16tHH0y5ClakjJLc0FLqKOdu9cQx9h+xUGsrEyPvHjcMPzxIO0QvOQ/l1Y
         Lp45S0LrwgpZG87cx7+mCfR4PBBau+L4Sg8UDDJr24Ey/KrZycKQLOjTAYnOnd87yPJ3
         LU5ht114gMT5wNrqPIif2KghTy497BwZwCxUW/1VfYaAHVohDxxfqv4lL260AZBETUOj
         brHNOHyaCCO8bC+w60mSm2BVohJy1Ukgox2QH4PIyjcPVuyQ6OWXcVIIYsYdaBIOf8BF
         1zaq6Z5SkCuXYcXnV04nl9PWLU43RQ/D8VkTHS9gHdX0Lotq2L3Hh1DpfhMXPWnopOAn
         avdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZVItqJhL7UETQCoEx+C8jMN0GObk/BcDw8oSH6H/YlacUy7IegknmraOjTszuv0ZT/++UQIyaeC4Q7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZWxVuJOVLzA32zTGFQBjgKrCJUXm03zT8Lo9pVQzEy8joHxi
	B6EJ7zxaIvIZhzsyCCxb0fIL/9u0sajlz3DVOVVIrl68/HMDUPqnXQA4t7XuPE91QR7VojNcFye
	WQKU=
X-Google-Smtp-Source: AGHT+IHW1Mblio0GktYhbv8x/PRao46V4MZh5e/NGipC5ow+04NPWNm7R51BXK9R3SQulhbCBsvRNA==
X-Received: by 2002:a05:6a21:1693:b0:1d9:2269:c3b8 with SMTP id adf61e73a8af0-1d9a850537fmr19866497637.42.1730244225509;
        Tue, 29 Oct 2024 16:23:45 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a3cd5esm8251088a12.84.2024.10.29.16.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:23:45 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Andreas Kemnade
 <andreas@kemnade.info>
Cc: aaro.koskinen@iki.fi, rogerq@kernel.org, linux-omap@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 tony@atomide.com
Subject: Re: [PATCH v2 0/4] ARM: dts: omap: omap4-epson-embt2ws: misc gpio
 definitions
In-Reply-To: <172857036157.1533290.9663617637580743712.robh@kernel.org>
References: <20241010122957.85164-1-andreas@kemnade.info>
 <172857036157.1533290.9663617637580743712.robh@kernel.org>
Date: Tue, 29 Oct 2024 16:23:44 -0700
Message-ID: <7h4j4usdbz.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring (Arm)" <robh@kernel.org> writes:

> On Thu, 10 Oct 2024 14:29:53 +0200, Andreas Kemnade wrote:
>> Bring the system into a more defined state and do not rely
>> on things being initialized by bootloader.
>> 
>> Changes in V2:
>> - better comment strange GPIOs
>> - proper names for regulator nodes
>> 
>> Andreas Kemnade (4):
>>   ARM: dts: omap: omap4-epson-embt2ws: define GPIO regulators
>>   ARM: dts: omap: omap4-epson-embt2ws: wire up regulators
>>   ARM: dts: omap: omap4-epson-embt2ws: add unknown gpio outputs
>>   ARM: dts: omap: omap4-epson-embt2ws: add GPIO expander
>> 
>>  .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  | 183 +++++++++++++++++-
>>  1 file changed, 179 insertions(+), 4 deletions(-)
>> 
>> --
>> 2.39.5
>> 
>> 
>> 
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.

This seems like not a new warning, but instead a reoccurance of an
existing warning due to a phandle rename, so I'm planning to pull this
as is.

Kevin

