Return-Path: <linux-kernel+bounces-424301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05A9DB2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B602828FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8633E145B1D;
	Thu, 28 Nov 2024 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5M0wFn8"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123201422B8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775139; cv=none; b=oku5mtB7pXl1CWHxu19BcLdeHquOc1R9hnQCEZiBLOqWZ9kPuDeei/m5rcuUPfFp0/SL6ZLFP1fPETH5QtTObhL4dRkwfE5jbmpRxTwxhr00cNP7V9f54GEnyZee1upwjV3tBQpbz0aSKd96ZwTw9GSuGB0dIcM/eU3oEzNn+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775139; c=relaxed/simple;
	bh=dYPE4ZNCJFy6FX0sE9ClVhGv4Cf/dafDkKNJVsMswuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGwBtmUxdEX7Y601QdiJXD+dSR+G7H0AfyW3HSlTndgsRCmWb912iHutPBiMMoT4zUELAYFowXV8LbCoy7qNI/myzEAQMHNgG8mYiCuE4XW1tlGhxsju9JW7KXUSJSfG0tE6+/jtj+RO9TB0XqpLZZT9oQvBb7qTYTk1raNg+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5M0wFn8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so2714545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732775135; x=1733379935; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYPE4ZNCJFy6FX0sE9ClVhGv4Cf/dafDkKNJVsMswuI=;
        b=j5M0wFn8FQX5MLBPE849ILdmuPXyPoVemuRHMOZ3n4QEfPzN5ez6eOcfptytx16cmX
         DxDMnWsrqPNqPX7iiwCxCdjmjb6TggNrGt7fyzKuGcvCaJzmyFGmb0q27xJeF4fzD4/9
         N1hvfSa8SMAj19GPx6jDfznXDsfKnqX9sNgJQAvelawOmacTywHT9m9u0NMQ5g3hpJaM
         b800NrCOy11VTC+B/kN8ODMwpkF9ZzugVfgPJsv12poEqoQ+AXU4UiRVMQOtVUXw2JK1
         9k7w/IqQM6FPtRTl3qU4EzeoYo4FbBG8OHaw0dKXp3t5TalEt43/YBAZWsLPoaZme5pn
         98jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732775135; x=1733379935;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYPE4ZNCJFy6FX0sE9ClVhGv4Cf/dafDkKNJVsMswuI=;
        b=E4RSCOu/VoW7bADXLIs/qRHsHpB1X96OoWtNal7PSat9JEuJon4tEtTzlYyNa2yTBC
         m3DAj49wl7ASM8JIe1yc2UIdIFUUJCBxnsZDRN85HtWtfoS7hOtw9UGgD2s3sVui1RPi
         g2Y1epIbkr+g8qBEkQwrrKPYe9GqVat6NUaEk/9KYSNH1/PVNESH+9SCwOPll/CJ7HL+
         OE2yUVVgEF2IvGZsJbUCn3kmhFshhxERp6LKxgjaZMl6AIMubZ0Yunlt9NNBVzZuryhI
         QH1v5xKaMn8QNg2P13L7OmHjGcXZRuKqLHJHzXSiphal/JU8Tsj14FBhcgCOPgY9+LxL
         IZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXnOwPG4033vHx+H9HjgTfzvFLUTPeyvzu0JeDZXfjYbSarGMRyAqOhsmMspOYVylXbKYnI0D+RK7FZ+88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGx9twpPCg9zGZ4YkQrDZbrTHOO1TEqqd0QRss1suLNNeNJA6
	IPwjAntQqx7Eu7ccpbf6CiRlSwths2ePJ4CBkcL4kznA0b6PompWT9yCe9L67O4=
X-Gm-Gg: ASbGncvRCigmu8u49WVWOyiY9Og5oqWE7jvCXw/aCQTFRYNoPGP6gD1e2jdhVM0JVcN
	lYS74BdU2JEGYh6yxCjet82fE8gF6t2Bj1xWTsJl8H6nWitTz7CJbdpcjxS/jLiy05ccjvqvIp+
	t92Cz0oZgL5OO1KzPpiel3HfrVq6c5C7Bo8NWs9Bb/gLsWmzUpl2AG/e+Rn04GuWiu9Qidxu5rS
	Ijp0aMq2VkXrDeBkTeOZ3mhYqkm8x0rhrQ+IN9zOxfW/gfbo8S+2wQ=
X-Google-Smtp-Source: AGHT+IH6Ml7J+veNZgcHRluAVpujI8NQLzYAgYOdmWcaTC51mp1SAFlDYpCulVDkM5fF9/EPeYf0EA==
X-Received: by 2002:a05:600c:1c0a:b0:434:9fca:d6c3 with SMTP id 5b1f17b1804b1-434afb9efa7mr14137785e9.9.1732775135356;
        Wed, 27 Nov 2024 22:25:35 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db0bsm775126f8f.2.2024.11.27.22.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 22:25:34 -0800 (PST)
Message-ID: <8e11e1c92d81fa39a2881086dc58f6262dd719e0.camel@linaro.org>
Subject: Re: [PATCH 6/9] phy: exynos5-usbdrd: gs101: ensure power is gated
 to SS phy in phy_exit()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I
	 <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Szyprowski
	 <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org
Date: Thu, 28 Nov 2024 06:25:33 +0000
In-Reply-To: <82f94ea4-2533-4ebd-a9e5-96ed64bfbc05@kernel.org>
References: 
	<20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-phy-v1-6-1b7fce24960b@linaro.org>
	 <82f94ea4-2533-4ebd-a9e5-96ed64bfbc05@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Wed, 2024-11-27 at 20:42 +0100, Krzysztof Kozlowski wrote:
> On 27/11/2024 11:58, Andr=C3=A9 Draszik wrote:
> > We currently don't gate the power to the SS phy in phy_exit().
> >=20
> > Shuffle the code slightly to ensure the power is gated to the SS phy as
> > well.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
>=20
>=20
> I think this should be actually a fix with cc-stable.

Will do in v2.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for the review!

Cheers,
Andre'


