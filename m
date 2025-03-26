Return-Path: <linux-kernel+bounces-576711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC358A71369
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E733B724C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6D1AC458;
	Wed, 26 Mar 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECOOSvfo"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C081AAE28
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980559; cv=none; b=niLVzM1w3VvHUH970BoWcbxpBTORVATem3cmcS3H7OxLdZ7g4zU4tjVzvBjmCjo7NqxfwjN9pZXD6eB3Mo2kQe3VNBvrTLZ75KT3JOIAbPR+cnk0O4gspJfT893TYMrkYnOM0mEPHF4MTUKhjihpYtH7t7CscN1i3mbjoo2pw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980559; c=relaxed/simple;
	bh=GCIY2no7DhEyS/En3sT102mrkSnOI0nEyW7oK9Gl+sQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIx1PqKNfwpnbvcglxSCfvv9nLNqnGc/m0twdvmA4yHshctKIZNNR8LPiRFKV60G8iSrOiyUtvr0YRKCbmSM7PUYIj9L1zRT07c585l6Yg9hJBY4AfN4G5BSUdYq7IncsBgImBT3lU83uQqDDpDWjcHABcouXBNDSD2naglaZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ECOOSvfo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so48335865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742980556; x=1743585356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GCIY2no7DhEyS/En3sT102mrkSnOI0nEyW7oK9Gl+sQ=;
        b=ECOOSvfoEEF8pkqswQ5Mc4QmCM2WPl+0IPR4WP4vGZJsPFKXp1asAqFJ//yE1Y9rav
         tmjZHluE0Iy2Z0e+UMmEhZQEH5UY0ocfuEqFgf6niTGjcfi7g9ynFAUvNFbMUhFcUu2r
         qQyO2kmhm/eQRRY/7VhU4yl8GttPku6CkGQ5b4DlTwzl7pstjSYFThVr6iaWYs1S2lT5
         29zxspyUpwMh5xfwcTHw7U9+tZhoo9RFRQ2LBlWjl3Sm1VXED2XNF8Ra7tiEb3DIDlrc
         ceAz4MxqRJN4FXWEO3osJdHD03dOznbJbPW78wHBTYIGFThIcIYNeRtOlBHGWwFihkXE
         Yf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742980556; x=1743585356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCIY2no7DhEyS/En3sT102mrkSnOI0nEyW7oK9Gl+sQ=;
        b=jUe+YZOIsxJIiljgK2YKjXhlIq1THuWHSnX2GBZSmaHdpfq2Oq/sWInqRlg8NlwsT8
         N8eguRRQnkapU8l5v0WZY7zeaD5cHThV17s7lHhvhUSHFthXX0gl7fEW6qaAzJHFWxJi
         JJT6S29KqMEl8NTz9Xi/rTcF1+nyhmkgZkufcb/VtjZypRj3VEx1PepsNolY6xxSYemd
         SSPjGtzWhmHhmjmj7BsOmHxHrbVf+3WPcMT5Xrt3B9F/YP5hKIovXXqJbJGGya4ocpmF
         ZjZ21hKjstPA7nRqKIMdlSJlFLnpLDvJ3UgEtDk0w8XYxjINVpVcT7EC85zeCiWOTfr+
         PN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3fUuNOGkAtRbB4YRqQYV7fW7bb5+aNOj/kzSdaHyRD+VtOxu90Wemac4aSWHVh8iQtDpFrBuqNPqHJB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDuZnsmX5kjrRjusJ51IQ09kRw85xoL+DTXnhb1J8iW6KAQft
	bmeiyTXGaC1bNxJL9WLPnNTlvhnSlbOgvmOp4mcLTyO/suACZgSIpsfflyJf0mw=
X-Gm-Gg: ASbGnct+Uzxo6TZa9H0XGDBonVFzZXVk4T0XmFy+WIlbrbKDROw1n3iJj+zfJ+Vuio6
	Wlwyo7HLgCkgJfXURfKzrgK4wk+JwMJuSlCGat4N6c876PyPpgA5BfwSn8cD7uNWfI7cxvcCNL9
	StxZ08/PgQgs51xqDJUK3FHkZOOuHwG7XZ7iKHB/iLBO7c2MiPgN8kjQrnb3z0CfpX7rrguby/8
	2ESeQzmNgPYmqAUc3Tf5a7hvHnvXqLEvKLT4LjFcnt/3lY1tsXCGgobR4YL5M8OF0Kqa5VwVryu
	cN4MMj1Vi2IUjvmXUs2+hbQANXdUGja8RI7Ymu1HgDe/cASENw==
X-Google-Smtp-Source: AGHT+IGx7e5C+Sh+HHT4ZLhJxYeCSMGqOs/VS4VI7TohJ8fgltfofFctJegQ4k3N2nPlKvOkPunClA==
X-Received: by 2002:a05:600c:3ba3:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43d6ce18becmr59665045e9.3.1742980555577;
        Wed, 26 Mar 2025 02:15:55 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e960sm175393475e9.29.2025.03.26.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:15:55 -0700 (PDT)
Message-ID: <a4928b0f7b54fc6e3e80f7130b466d5d493b0aa2.camel@linaro.org>
Subject: Re: [PATCH v2 2/2] firmware: exynos-acpm: allow use during system
 shutdown
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Wed, 26 Mar 2025 09:15:54 +0000
In-Reply-To: <4f2252fb-841e-46e0-942a-5db9767db89f@kernel.org>
References: <20250324-acpm-atomic-v2-0-7d87746e1765@linaro.org>
	 <20250324-acpm-atomic-v2-2-7d87746e1765@linaro.org>
	 <be580155-372f-445b-b9d1-2dc4fbf1c3a1@kernel.org>
	 <974ddabee5a2a43b9d32f382ec4b13afab066f1a.camel@linaro.org>
	 <60732c52-7774-48c6-8ec8-44ae82d86267@kernel.org>
	 <42905f72-100b-432a-becb-7e1f835e518e@linaro.org>
	 <4f2252fb-841e-46e0-942a-5db9767db89f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-26 at 08:36 +0100, Krzysztof Kozlowski wrote:
> On 26/03/2025 08:24, Tudor Ambarus wrote:
> > > > >=20
> > > > > What happens if system_state is changed to shutdown in this parti=
cular
> > > > > moment? How did you prevent this from happening?
> > > >=20
> > > > Yes, and that's also what the I2C subsystem is doing, AFAICS, see
> > > > i2c_in_atomic_xfer_mode() and its use. This is to make a very
> > > > specific corner case work, similar to I2C which has to deal with
> > > > the same issue during shutdown.
> > >=20
> > > But they don't have a choice so they try to do the best to avoid
> > > sleeping. And it is a subsystem, not a driver, which means their
> > > patterns are sometimes special. Drivers should not replicate subsyste=
m
> > > workarounds.
> > >=20
> > > >=20
> > > > Would you have a better suggestion?
> > >=20
> > > Yes, you have a choice, you can always use udelay. Driver code is
> > > supposed to be always correct.
> >=20
> > Using udelay() is good enough for now. I see that downstream uses a
> > usleep_range(50, 100) and I'm concerned that we're going to waste lots
> > of cpu cyles once more and more clients get added.
>=20
>=20
> If this is going to be the case, then we can revisit it with some
> numbers. Especially if this ACPM turns out to be a bus driver.
>=20
> >=20
> > If there's no concurrency on the ACPM queue mutexes at late system
> > shutdown, would it work to pass the don't sleep requirement from the
> > client to ACPM and use udelay only then?
>=20
>=20
> You mean the client will choose what sort of delay it expects (sleeping
> or not)? That would work, but can you actually control it from the
> client side?

I can know this requirement from the RTC driver indeed
https://lore.kernel.org/all/20250323-s2mpg10-v1-29-d08943702707@linaro.org/
but a) I'm not sure how to do that with regmap, I'll have to have a look an=
d
b) if the concern is that system_state is changed to shutdown while one
of the (other) drivers is using the ACPM (as per your earlier email), then
having a different API wouldn't help I believe.

Cheers,
Andre'

