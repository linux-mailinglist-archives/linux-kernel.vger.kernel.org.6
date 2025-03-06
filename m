Return-Path: <linux-kernel+bounces-548716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1D9A5488D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C457A5770
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBEF20551E;
	Thu,  6 Mar 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sybzewpp"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D47202984
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258663; cv=none; b=P19VyQwBKPSbjbNqG+7XoBUlLOxdQYw+d0lzN+Wvh2M4UF870/rt1ppYYgNx8P5nHyaF9XPSmBkG+6NBlRF1mjkM13A3z9BBLL/+6QzNg4TCRocToOH002yx3/nGLPaFd0jgf+Tl1kjwOWYJHdB9dcSJiTeyxVzVUpaWQnHyoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258663; c=relaxed/simple;
	bh=HUzA5Pu2VpXIYuAhDxgWPL7oFqKDgn6WYCQ3x4sKcJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmIDRxCzicclP7JO091CuQyCFWV0LKP9CJtpawMqABQn8GfFArwBW3PM1lZdEXzziiB64Mpyno21oazNkAP6crZyt18DeGhy1dTvXrSUp9T7OUAPcjri3UwC4WMYjlBhHUaSYopgOD3V6fQMTusYg8aJab3095bDsQnIdrEPR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sybzewpp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf42913e95so75604366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258660; x=1741863460; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HUzA5Pu2VpXIYuAhDxgWPL7oFqKDgn6WYCQ3x4sKcJs=;
        b=SybzewppP+syPgdAproUY/UYNOHa+oKAKVn58hK1cGBbPtCe+Rdnv56fNJfPZObh8H
         25tA6MnxUhQ+Ajl/IFb7RyAsnZFsbzk31W0Vzlz27KPqB7KFpWFClaXIpMwl/OTT21o7
         MuMX1W73iBU5mJ21jnzY1vRSPvhTr2k22UfyrbQq69u4aS0No3lGILoAncFxEv/AcNxD
         C743Y4C6maxL8PHBpei3VYtAkxQ+RQwh0zleuUVQ7Q7o0exIupNv0VYRyNmusr6HeSJf
         WRhryFA1na4qUZtBGYMPFA67Z1ICgRfDnoY6pijJWdcLtQcP032BohQwbEwiiBq5Z5OR
         7Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258660; x=1741863460;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUzA5Pu2VpXIYuAhDxgWPL7oFqKDgn6WYCQ3x4sKcJs=;
        b=V/KPwvWYwAmzzxfg03/AS9Lpj0O/49moUhOYU1gaVH4BCEUwsgYmrWb6pc1wNctRXK
         ZmjR9LwiQ7KInlM2XmQPgZJCteCMKrFB4Z78cc87+lix7/S9nHSTIpzU0tK9g1Vey66B
         5w7XNyO9t0VfjuyzkMerFgFD0jMaBZDH0zrgf5kMR6Yb+zbniotKpwmN3nbEhPJ+zq1O
         WBzWGBVLMVGD+H1uHnBZmBIpGbrjXAifHMXsQYH14LJQikRW0fZFFsp76rrcK6TCroxZ
         fQ6nxB9PjKWHLPF049/CtGC/m9Zw0jMcsfKgUe4wRuhngxGEBY9LUCfzrQzKLSTH1ap+
         Dukg==
X-Forwarded-Encrypted: i=1; AJvYcCVzmzVgfxvJ4k5YG5LTBObck+9n3h0UlRX6L933Tzi2Yj9wknxbpPeBi7mSCvyuzYbhelCesoZXlBlCZGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPHRbfZN5PEhMSw3EFIO+aMkMD5PxE+KG9rBtcginRKjOxE3E
	pnuCrsqP6mSDhxDsfkAcvq1trCPZjh4ZgauLg3QfSaMQC/kmpnsyw+e46nq0y/M=
X-Gm-Gg: ASbGnct5YV+2K1ONzi9U6u07WN12eHtV1514Fqnu+Vr606iZaqdY4uWunFkffosYAsC
	3wesIk9hT0exqryKTrGUN/M23ryVZLZ438UBYthx9OQR4W0z3xyJHFLh42oN086yTvyVj18AMP3
	KrNu/NyaEcUf3MRwaY7vnIoEeLcJekSkoly+jmXgJuw4R0T68xiycFiaZYPwkJV11OBIq91Z3Tx
	+Bc9TdjcW3SLD1wEAZ8WrWkqrJM1oF8pBHPY5iq0gbKYOqw2XNlnTXNmgoolDw5j+2GZEoY1K1O
	oIK52k2M/1tgj8aBdxLwPTA49/OriK/DEAa35+IX8aCyiBKM
X-Google-Smtp-Source: AGHT+IGeZOiaY1aJKJjqtYueXhMP1BS31yX+hr4PezJXUBtQPVrMxRBsSKLnYFZO+vtwvwtDRkBuEA==
X-Received: by 2002:a17:906:29c4:b0:ac2:29b8:1f21 with SMTP id a640c23a62f3a-ac229b8202cmr306641066b.49.1741258659698;
        Thu, 06 Mar 2025 02:57:39 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d47b5sm74174966b.168.2025.03.06.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:57:39 -0800 (PST)
Message-ID: <b70f17589b91730ecf6080c626492368283ce7a1.camel@linaro.org>
Subject: Re: [PATCH 0/3] gs101 max77759 enablement (DT)
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 06 Mar 2025 10:57:38 +0000
In-Reply-To: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
References: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 10:14 +0000, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> This series enables the recently submitted Maxim max77759 driver and
> updates the DT for the Google Pixel 6 / Pro (oriole / raven) boards
> accordingly.
>=20
> !!! Dependency note !!!
>=20
> This series depends on the corresponding driver and DT bindings
> proposed in
> https://lore.kernel.org/r/20250228-max77759-mfd-v3-0-0c3627d42526@linaro.=
org
>=20
> Note that in that series bindings and gpio driver are accepted, but mfd
> and nvmem drivers are still waiting for review comments.

To avoid ambiguity... with 'accepted' I meant reviewed, but not merged!

A.


