Return-Path: <linux-kernel+bounces-574872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783EA6EAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA8C1891889
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9121480B;
	Tue, 25 Mar 2025 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbxjZ5GH"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963019F13B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889719; cv=none; b=NfgUjCh3IL0L4rCrfegXUyDHZDluFJ6fa8W0aYx1aWJEOndIoXl4gVs6ZyvkXuwY5pxC5ZaCmmQF4hmqz8j4pWBCDk8fitPpWH2IunCtQKhB+kHOFCoU0XxEAGGp2PGEzjESQgesn9NDp82JSa5R2Tsv7rwKHNITQKsJb+bDdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889719; c=relaxed/simple;
	bh=D4/deZUrRvEFZ94m8Q9D3QeADW4HDx7z0RXbyw/bQXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubXXSrkUIeP+L0xXvoojUjBmmElwywpk4jNmSAFDKpvBbmw57oJAlGDwhhyCPI6kP6F0ppViTo7I09lFbt6+QLgcQgeGw8OhRdoOF7TTOKYyF6HikpFYmQt7zTLmlBjYIxMPdWP8qxOxdG4qNwtPfzMIVW0HaXdb+/XmlF4iJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbxjZ5GH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39127512371so3455736f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742889716; x=1743494516; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pw9b1PNCrvCj4pipFtdGJnivRzpncTcPSw1C2hnQDIE=;
        b=GbxjZ5GHVrGPlrYG271WjOTid+0g9iCvl8JOwJJIbUDkpmIhpPrxsuF2/EdDO/dLJL
         zWhkPNmZG1eAL2Bd/S2lrpGXAXpZrdmirHRs/shLz/X8rUHuXJ1WtzwHNInZHHm0MS7p
         tbuV5nbFpH628EepIEopyZnT5iwUJ4f5kWaI0S1rKYuKRS6jvSndlw/OXdxYTX5viU3z
         mclJilgWwEYdENsc2k4XOv+54mFoVHA/FsXkG30r3D3mCwvZfm0UNuMvlD4jd2B7EcUw
         57SssvJ87Xls+23gP6MrV2GxyZCV/I+JTf+HOfpFLoJblzBv4s2Fmr8iVuZnojlbzVIv
         U1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889716; x=1743494516;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pw9b1PNCrvCj4pipFtdGJnivRzpncTcPSw1C2hnQDIE=;
        b=opyTtegQQpIOkHLDO18468Gjrdh8TKcNGLmfxrc8YGh0h0Yt997FgiJYqCDwm3Y44J
         Hs0ke97GrKztQ4sHhiY62VR7Pky0LpGRkim4INcBoxT307CdjGbulWrDOz/6zM3w8oNI
         I7M16ZNdGJI/y9TSuxKjbTOoHk05GbGN0ngeEgop4qX8Z29mS7tKJtOFgU9EIZifq1bU
         9LX7Y/cIO3MPJ98Cmypx3ZsYEgYPAkbJS2Y3G4kHItACc/BqDQ+kcW8763cgndXa43EK
         vDqkdXmVWbfBVDJF2wQAdSmDDetKl+daa0cWx5UJ9VKZ09rDf2K264z0/9Uw0SM+ZALJ
         jVEw==
X-Forwarded-Encrypted: i=1; AJvYcCUUxMBROy+vVtbBc9VjCIpYf9eXCCaNavh/My8ULTLIXLVsmeFEgG3CfC2FwlDgbfJs8W/fYF/epy4Ikss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmKgJGY/QM14vbfTRFltIjmJfNMH2G5e8A1BX8qP3pWgzEUHG
	QTsD+NOaqHHCXlj4QHGov8MGWq5OU2QOrOc6bwIIcNixcFYtpBVPvQYmX4d0mp0=
X-Gm-Gg: ASbGncuKg+lapYiarqpAnBiXzQcyGMcGfsPL7tqo16vr7NCoJA9VnE7B5+Mz0rVDmEi
	RZsuL9kxMHpbTjFbBjUP+JSq3JRO1Jr+IijL+DkGChvU6mDWyJZIvjMSe3HKC9uXMsqvqXNQpPj
	StJ8cFFjgysg6AQACe76nSL9qFhNytX1VvPlRFwP7jyROio/IP6hALmtNEw+xPicJSS6yFIvL00
	OD1ZHNjWvtiXFq6aQ7LuO+NrOUqAcJfc0ONMIoRXvgK80R8/vuYrpYCoTciZq3ev+fkkq3A9/aE
	zje4rtAi4xkYwzo7x0mNyGIzmN+Ue8lv1DTfN6y0maEcIi6gcA==
X-Google-Smtp-Source: AGHT+IEdKMh5Vkn8qIQcdV6MaRJha1LCACg2NhchPePa1fLHxwn1+onjPFo7rIPkaF3e2QGOEbXqGQ==
X-Received: by 2002:a5d:6daa:0:b0:399:6af3:7a77 with SMTP id ffacd0b85a97d-3997f8fe892mr15837727f8f.19.1742889715763;
        Tue, 25 Mar 2025 01:01:55 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5939sm13303207f8f.60.2025.03.25.01.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:01:55 -0700 (PDT)
Message-ID: <974ddabee5a2a43b9d32f382ec4b13afab066f1a.camel@linaro.org>
Subject: Re: [PATCH v2 2/2] firmware: exynos-acpm: allow use during system
 shutdown
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Tue, 25 Mar 2025 08:01:54 +0000
In-Reply-To: <be580155-372f-445b-b9d1-2dc4fbf1c3a1@kernel.org>
References: <20250324-acpm-atomic-v2-0-7d87746e1765@linaro.org>
	 <20250324-acpm-atomic-v2-2-7d87746e1765@linaro.org>
	 <be580155-372f-445b-b9d1-2dc4fbf1c3a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Tue, 2025-03-25 at 08:57 +0100, Krzysztof Kozlowski wrote:
> On 24/03/2025 16:34, Andr=C3=A9 Draszik wrote:
> > +static bool acpm_may_sleep(void)
> > +{
> > +	return system_state <=3D SYSTEM_RUNNING ||
> > +		(IS_ENABLED(CONFIG_PREEMPT_COUNT) ? preemptible() : !irqs_disabled()=
);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * acpm_dequeue_by_polling() - RX dequeue by polling.
> > =C2=A0 * @achan:	ACPM channel info.
> > @@ -300,7 +314,10 @@ static int acpm_dequeue_by_polling(struct acpm_cha=
n *achan,
> > =C2=A0			return 0;
> > =C2=A0
> > =C2=A0		/* Determined experimentally. */
> > -		usleep_range(20, 30);
> > +		if (!acpm_may_sleep())
> > +			udelay(10);
> > +		else
>=20
> ... and what do you do if IRQs get disabled exactly in this moment? This
> is just racy. You cannot check for a condition and assume it will be
> valid for whatever time you want it to be valid.
>=20
> What happens if system_state is changed to shutdown in this particular
> moment? How did you prevent this from happening?

Yes, and that's also what the I2C subsystem is doing, AFAICS, see
i2c_in_atomic_xfer_mode() and its use. This is to make a very
specific corner case work, similar to I2C which has to deal with
the same issue during shutdown.

Would you have a better suggestion?


Cheers,
Andre'


