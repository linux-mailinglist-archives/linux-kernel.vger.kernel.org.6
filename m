Return-Path: <linux-kernel+bounces-177377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF188C3DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A081C214EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17A1487C5;
	Mon, 13 May 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vi9+5xlY"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5771147C88
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591161; cv=none; b=bBKj26uZu4c/W7MKD9puj/Fxpgz+j1pOfyw5yKPOQ9aPttQoHOuqKRR/kssCQOpR3o1Odzh/BJ8qbM3OaJicH5Puth9TBIQsNCA6BtP27IG0locirnxLK+M0qJmy1Eu88Q3pUH7rRD/ww8kYaw9+I3rYBWFpXQOoSYGTLeGZWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591161; c=relaxed/simple;
	bh=kmoyKfLRf0lLPLChJFcw4nUh519Faw2jYhkUU+jqLig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kX3OiRFIw7IEeH6/0BcPGrt3ND8If0XAWsHApRVvgkEyIR/uVAd1uHynQRKM0tV9YSCLH8f+FN4vhJhDq7NWqbJ3GLtJebBb7JzR2tnpCAC8vt29/kmCpEKgmLzykhGocV+BVVPWQngepUQAKvof1+etCD/G4j7oywswvKLPbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vi9+5xlY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34dc129accaso3091737f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715591158; x=1716195958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBzaaIEgHGuGeJGPiYUXItWhfV56AKE1pxOKn1aV1Sc=;
        b=Vi9+5xlYLAuhBWIlZQm67rxDn5tArKU7L1N5FLROuD5viFEGalWOTYtq5cSqQ8FJYo
         a3SXE7iMNW6jlZTDGXOw8Tj2GLTitn+Y0I91I3vbEom53zbHQr5sgmM/sxZ0n/tjJYoj
         kg8Ol6E8QTB9joAlF2WLYVE4BnNSjwd/vCMScpE6FF3czGE11esXbVpvzTiMHwDEjJUi
         owUgyjWkTXA9DjYvCKyPkZ/VNf6X3Y94ahfaqqs/WiXsuir533Gqn5VKvbB0EMWF8E5S
         YSzFiHy/ThGt49kZ3nOzvQB0GhcICLRGQb6ijhuV4nvQtc3LMkWiB5xZeHri0DD8WpDK
         m7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715591158; x=1716195958;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBzaaIEgHGuGeJGPiYUXItWhfV56AKE1pxOKn1aV1Sc=;
        b=G7JQcf6W67wLj4pzpiWnhsiCv0STJ36zeUZEtbXmJhhVey411+SL8PnYvr1PWKzwrt
         tB67dqBPTi22f60x+tHSm3auRCaQFg2osmQuL5WTM+gUxWRtkHVcXgiUiXF84QcgtfUD
         tqFzMMhOYTOPnc7P9pfbR4fgGeqQ/5wWjHzC1Y8iu4FEYS0XoMD0oInEjv8QhPRY/0Pi
         ivWLfxXUKaoWNcoONoVkoqOSL10OyZTBKcZK9NsIAYEhD5JSIjDfIo/oWH+FEZcXF8fq
         hm15Pl/2B5jrX2K9DnJTj2ycx5TPv5ceb8gkWSg5BqFebBJmIuSLjKO2zI7/qwwKMhs+
         KvYg==
X-Forwarded-Encrypted: i=1; AJvYcCWKi0BhMcwdted3pl4QmZcGt8B6tO7M4S1eS/e66Y+hAzq9TPXNvUukuPUKUr5d7dRkwLf2Yvba9Mdp1dG1H50/KDeHpo5nhpJgYrcO
X-Gm-Message-State: AOJu0Yx9WaCTMlcwYe50qoHZBmrhHeIolm3rwRR1jMKO4F3ao8NaJNA1
	KxGGHzCWmn+J3uhJRRq0x2XhimxNqU7YiJXDN5QZ8oxiyB6zMDiaWDbUqdSZE94=
X-Google-Smtp-Source: AGHT+IFWiNTtriwb0hOXOiFQhJA1JdMGMjCgGFLHrgH5ikEuPjXoDfYzRJf2hyA8Uth98uW6zujTnQ==
X-Received: by 2002:adf:fe88:0:b0:34d:a75:3a44 with SMTP id ffacd0b85a97d-3504a96a3e3mr7408130f8f.54.1715591158188;
        Mon, 13 May 2024 02:05:58 -0700 (PDT)
Received: from [10.91.0.75] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc6csm10565446f8f.21.2024.05.13.02.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:05:57 -0700 (PDT)
Message-ID: <d5b179c0-67fb-4452-8e22-b3d5d713942d@linaro.org>
Date: Mon, 13 May 2024 11:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, kernel@sberdevices.ru,
 Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
 <20240507230903.3399594-2-avkrasnov@salutedevices.com>
 <171517732606.1572649.16193191353725811830.robh@kernel.org>
 <CAP_G_RUdN+6OcsQZUkqWQMYoH-ZvmPnskT3yONK_YssqUYhm9Q@mail.gmail.com>
 <418e29c7-9baf-ee4c-7a24-49c196ac89b2@salutedevices.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <418e29c7-9baf-ee4c-7a24-49c196ac89b2@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/05/2024 19:26, Arseniy Krasnov wrote:
> Sorry, sending from proper mail client again (not sure it was delivered sent from gmail client on 08.05) :)
> 
> R-b was removed, because this patch was updated

Then, as Rob requested, explain what changed and why the tag was
removed. There was nothing in this patch's changelog.


Best regards,
Krzysztof


