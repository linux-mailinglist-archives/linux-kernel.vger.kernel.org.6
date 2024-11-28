Return-Path: <linux-kernel+bounces-424391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634379DB3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E5816417A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4614D456;
	Thu, 28 Nov 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVXIRcH/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510DC1863F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782861; cv=none; b=AyG0IUafof+mHKqQ/Zp5u4O91s+ZPZAx/SLehJo5OtWjbdVczVxOESiIPkJuJYPdnxarRfsH5WPhwP0v5utBzA7iosdwoUCxYOhCAWPZTJrbkIefZmxs7+jpFK1JWH2h6LBdy7klliJknmBxzLAmk8QRz9m5Jj0aQGZ3StO5Of8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782861; c=relaxed/simple;
	bh=BJydo/N0RCxorz7FjsZl8RX10xfc5cfOBgBZq7KiwDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Th/Oa6UrVrMaS1Xkggkf9xgP7fv2z5Ri3M2MKKABPWY+Xk/QgSSZJuWs0cQ5QP5c9JVZACU7NIy/4IKTCO12ClP5YDk40Zgx1P5tkDPuzqR/bYGny4Mn0WVJOSkXZvCx7DlU1EBNVNFnRHbqvd11VxCZjw0rvxYw1p/Z6pJzN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVXIRcH/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a736518eso5904975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732782858; x=1733387658; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJydo/N0RCxorz7FjsZl8RX10xfc5cfOBgBZq7KiwDw=;
        b=PVXIRcH/+3ZUp/Z8yZZcXRjEAUOnSfuuhoTLn7LF1xnEejuYnHsx4+GEaRe0+oVilJ
         um3rO0W/5nZ6b3jNy4um6O4u/0frb3q9gncDEz4SDVlbm7ukuc+37gGP47Df7trE5wkY
         7qPeFndcm2hPaNRwImj51/2xDKeUK4niF6gpLKMuEfUeT2xnzfesaW107NoWWByqAQyE
         vR5TX5xHjKHEMTzL/qKlbu6a+VF/17i7QbYDoVH9Ajmq3ETA/J0BYIooBgyvTb32kSVs
         OHpKlLSbw49nzi9v2HB8hUOUdPct8ykhC6gfv+ynND2nM/4DPF1tqZVnIxYa7024Q0Jw
         EdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732782858; x=1733387658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJydo/N0RCxorz7FjsZl8RX10xfc5cfOBgBZq7KiwDw=;
        b=snlXz0b9ajpKOTVlslcjZZWtgIHh3gvfD1YFWuLhosrNnDv15N8K0oSZ8zYL+WSehk
         Mhskg9lACKJlx0xo9eL6DYyVe/q+7xLuVLlHONsEhrptQkSbMrtny1Z0MIXfOmp2F/ql
         PhQG315r+rrvHqAgbyd7iZHY5AWfqkA0raxEb+6tX7Y7EfNPYsRTVHiwdW2nUPd1oU4f
         Z8tJ7W8wfGSJhF4uf62P8Q45jqTHScC4UmcN/a5WMKd63syzs/xZseNByobWDk5NQDBk
         tmYkj1dhYdVFHRyhu8QK1kUyKJBNOKUdN6C2ZecdUw2zvWhRv75CbP053rBxwwVzGnJC
         ciGg==
X-Forwarded-Encrypted: i=1; AJvYcCXDdTlvFpvsFS1GctjbfX+DznSMpgr0pOtw63QufzJRPqyAflEkYU3ODsRREjauqY8yEnZAr1G9Hvoitg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQzm7V0eChp56Wq4MGpL7mq/I7GhcqGzJvOXs9GwXRIt8VhXb
	wr0d65pOh4nn6yAF+CGUSh9UodNbXNoeVF/MTETwISrbe7Oh0kxgjTbu6aOFyHw=
X-Gm-Gg: ASbGncvQ1K+KF1bSRSgsLNhReKu0P9oxvTpSi9e41W85wfQArDCmMS8G/E9mCAwS/Mq
	9FBVTuMqaxFKku+CARAX7RC1Bxvmu02HKKGXQ14C0NnK2iuo4qKcXM2xlJA/8jW8RZUHu2vIh4O
	Ao5ns3ykEvgIQxs4IycgfHrI9PcT7OAyuQJlBNrVogu+cLiaty31UKu49K1VhNtYgHmipdX1cCV
	Tw228MfIn9Ut49vb3Ap8jLJ9ImqvncR/4dBk+KcMYRXg+7tfeDEdVc=
X-Google-Smtp-Source: AGHT+IEWNg3QdUei30keeYiiUfx5K39BlVHw7PFW62/wVTw22KyFYt43OlFY45o054oh1iBQoTX/4g==
X-Received: by 2002:a05:6000:1865:b0:382:46ea:113f with SMTP id ffacd0b85a97d-385c6ccaeebmr4797397f8f.10.1732782857620;
        Thu, 28 Nov 2024 00:34:17 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc11sm14705755e9.4.2024.11.28.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:34:17 -0800 (PST)
Message-ID: <4a5c27922a9852c06e1832dcc63b4a448e8955e5.camel@linaro.org>
Subject: Re: [PATCH 6/6] arm64: dts: exynos: gs101-oriole: add pd-disable
 and typec-power-opmode
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>,  Alim Akhtar
 <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-samsung-soc@vger.kernel.org
Date: Thu, 28 Nov 2024 08:34:16 +0000
In-Reply-To: <7c013e0f-bb8a-45db-a5b5-71afc0ddefda@kernel.org>
References: 
	<20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-dts-v1-6-5222d8508b71@linaro.org>
	 <7c013e0f-bb8a-45db-a5b5-71afc0ddefda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 09:21 +0100, Krzysztof Kozlowski wrote:
> On 27/11/2024 12:01, Andr=C3=A9 Draszik wrote:
> > When the serial console is enabled, we need to disable power delivery
> > since serial uses the SBU1/2 pins and appears to confuse the TCPCI,
> > resulting in endless interrupts.
> >=20
> > For now, change the DT such that the serial console continues working.
> >=20
> > Note1: We can not have both typec-power-opmode and
> > new-source-frs-typec-current active at the same time, as otherwise DT
> > binding checks complain.
> >=20
> > Note2: When using a downstream DT, the Pixel boot-loader will modify
> > the DT accordingly before boot, but for this upstream DT it doesn't
> > know where to find the TCPCI node. The intention is for this commit to
> > be reverted once an updated Pixel boot-loader becomes available.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> This should be squashed to the previous patch, including also combining
> commit messages.

I contemplated that, but I didn't in the end so that it's easy to just
revert this specific patch once the boot loader is updated.

I would prefer to keep them as separate patches for that reason, but will
squash if you still think that's better.

Cheers,
Andre'


