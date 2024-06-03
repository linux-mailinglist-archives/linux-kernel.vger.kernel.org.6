Return-Path: <linux-kernel+bounces-199671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E755B8D8AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662B01C23B34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9113B28D;
	Mon,  3 Jun 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F2Ds8tku"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023A13A878
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444775; cv=none; b=YS3KoBnixC/B+rkXkLEOmSPu6mfOw6Drx6as12sfo3ox0+SHdoFCvK9DZNh+7lZ9jVXOJS68XmLuUc/f6fVnwCXVF19fTdQsN/islhq5ePnorVcSWz6ZzW7K7gWwVSBw+ELOoeMhz4D+oVOVKVA4nwRnEarX08jIwV+iod1yeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444775; c=relaxed/simple;
	bh=8ObTtzJzwdgrV6cQN4g+ncxZ7TC6Y/uH8CVk4H+ab+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2w0PEs9UeT1Jyzwtv0C4Q0eGmHyvV7DVqf0UDlXErtsrZn8zJXAyebWyj3pp0mxO9V2pEBdO4t3g2TTW/6fVdbwmFrbWzShOkaUK3chjkCbAHgPSOatiB+RUl1c3wHZQX5GXz0EXciKPySS6kmng0XnGo2f/wImdU8ACOsK3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F2Ds8tku; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-250bbae0ff6so782226fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717444772; x=1718049572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRFpfKOMP0yGFtHmUjNHpNMCBPomaUfAjcDTvSN7F+w=;
        b=F2Ds8tkuAOa+4QWwtaaWf67McvRmml9TlwFgfNrwkB4KFRj7z7aEP+kTqLJlqUzta9
         3/IPhMQ2IhqPTVc17gyjE8TxTr60E7xz1iUP7vI0wiq135de2O420G8ZZZqICHaRWPWr
         eakUlyjJzGhdb16ZeasX8sJ0oZTWooFBPVhmq+GNY5RvIvNEWiUNDA37BH2Zg3wVJOZe
         HVvaAqgSSlP4KxGcPKT4hGRQ/Fx1c9vSXa4bqR3A4q26uKQOwItbjzSQFP0YuEFy8JlK
         bX3qoPzomKsMPK/27UZfBvs7tyxVKSAlWsbDvuZvOQgmtvdoE1HVvVtHiLKciIgk79Ed
         8EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717444772; x=1718049572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRFpfKOMP0yGFtHmUjNHpNMCBPomaUfAjcDTvSN7F+w=;
        b=ljybi23tffNyj54Uw2ArbZC7942yvplzGyp0YrZdOtnKvwIy1R3PMFHLMfxGTOu/7K
         KMXrDBI7ZfV2jrM0k1wmSIPtsuskL/CaB9BmpcgscTJJ+mCNAiFODve4DeZeMj6qd9o2
         9XOAYeyeR82/HCk/Sp3BLICMF77OnmG3TKbYTGiG0z4EafB37PogSeoywuoCPXfwp1Oa
         3XLwVTe+EVUbdzZdSTtwfTv7zOxuv+4bTBAu/HB+EN6VFu3WDKAI2Nq0ZpwWLhmogT8j
         ylUHtZEbHILSiAEfB9fqqtXDzEZarAYMHQ44/NKL8LanE3SVcRf/wDMhHRsZsNsFKWqp
         Cxfg==
X-Forwarded-Encrypted: i=1; AJvYcCV1G6ax2FH/yfAepRgjxd6/hEjb2eZSU3ALHjWgfnFLI2Zias4NZfzb+qvytcyNCBDDOWXwtgxbAI1ikgZTh/Z3DG9s452PA2AtlmuP
X-Gm-Message-State: AOJu0YxmNHJhejQQHfDglaJ30/UtwtGKXyjvcH/vvI+ESUvCUFTu3XNY
	zL2gXidZJxIPr9krbHs/5bggLY1eMtolnruxsG+vecq5C03zanhMSP+BOTTojI0=
X-Google-Smtp-Source: AGHT+IFeHA+985ubS7larOgU0Ytw2VgLpfpcgg0FNQ0XvzTTpJVj13VKEHuPTBVru3so0HW9l3Au8Q==
X-Received: by 2002:a05:6870:1654:b0:24f:c0da:3d4e with SMTP id 586e51a60fabf-250ffa8574emr308963fac.2.1717444772157;
        Mon, 03 Jun 2024 12:59:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-250853e5f19sm2663534fac.58.2024.06.03.12.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 12:59:31 -0700 (PDT)
Message-ID: <2942a938-19b9-4642-8ed0-8e17e4825bc5@baylibre.com>
Date: Mon, 3 Jun 2024 14:59:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
 <20240603012200.16589-5-kimseer.paller@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240603012200.16589-5-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 8:21 PM, Kim Seer Paller wrote:
> Add documentation for ltc2672.
> 
> Reported-by: Rob Herring (Arm) <robh@kernel.org>
> Closes: https://lore.kernel.org/all/171643825573.1037396.2749703571529285460.robh@kernel.org/
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2672.yaml         | 158 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> new file mode 100644
> index 000000000000..d143a9db7010
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2672.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2672 DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2672

The linked datasheet describes 12-bit and 16-bit versions, so should we have
two compatibles here? adi,ltc2672-12, adi,ltc2672-16

I don't see any ID registers where this could be read from the chip at
runtime, so seems like something that needs to be in the devicetree.

