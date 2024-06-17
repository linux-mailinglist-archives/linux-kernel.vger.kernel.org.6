Return-Path: <linux-kernel+bounces-217295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FB90ADE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C2A1F21D53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649919580F;
	Mon, 17 Jun 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfyKCoDs"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0B190052
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627171; cv=none; b=Bp1ED2UFjgwq1d1RGFDY2fnYHt6sm66vx5GG7yLyfRLwKCnhqISS6kFE/SizYSLfn9PzJ/QZtu/tHEmUUrEkf0nl+XoVoAp2G6g5haqaZBhPOgcznmTJV2yhnRNrKR7Ufy/usSjxmbbAPuQ8RuQi+UE5YQHhqrL6Y84uF8l1J7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627171; c=relaxed/simple;
	bh=0yH54hdRmJm1LYRknv1AkPHR6e6a/3XtHrSym3izFec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKsD8BVj3EbOpc3vQ2TO6YhUuWo6jX/dajEc4ugNhUubmUr5P5MRtj6jHs0cioh9JzOFvzciV7dc1aj12ykzv8GOlCN5uee7aOmbdsjD7PthNo5R9kjT8pzjXUgvM0dI8hJJKb5nhYRRDRcfreIv+20giQaUJjVwHNJb6RSKlNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfyKCoDs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so63261666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718627168; x=1719231968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1W3TjI82LPT0GMJMb8ibh1Cs/OuD6DN8HxB363KGxc=;
        b=hfyKCoDsUcQszhVObhh9tMsayDT9m5YjtYx3r2w2Nj9DIbT7myT6uipcVWeoqk8tkZ
         cngGAMNsOhpCUV4O3/kOV85q4I61soHkIJMYCeWt+OYME3agtBmgRjraMxuxDo2npgkZ
         TpYs76yLvU7ogSHVIvGLl5RsWisJ8/UvoNz93disRFk20+3XzPcXjRTrvbcXNQPecvFB
         osSNAtA0PsGyU+e0PNOkhiApEuHHzwYhoQkvNcfMbv3/8EsOOjWsYsDWY8WDnR+5Y/ru
         nFKtofKkIXEGNU5sL6k3GNyDTqCVjjZiuH5mTP615MuQer4/3TsGBYCQkFrwavwMX/Jn
         pikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627168; x=1719231968;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1W3TjI82LPT0GMJMb8ibh1Cs/OuD6DN8HxB363KGxc=;
        b=uDZ1sq19KKhGjYdvXBrFmcn/FAan/oJWKZTgK96DTSix791UWGVyxT5CDoSohx/9Wm
         u7XLXgTVSh0mOO/HC1QVf2ysLcbdoImQYQ4HpQqjWtwYYyK9urXnMtRzZWMzqmGNkIRy
         /nlYNjwMPQ169xyDoHOKE8lTSxteV5bLPq/EyU+2aCyFTX9H017Nnzwvyaadc6YVuYpW
         rdiPJrEqWJTNAftmeFkWtVAgWL7voOh9NpYdSFa1G56DbfDxcT1D6VS49Z7EQqNno47q
         z60qxn4bGpW5JT07zeZ5dcBOzPESI9H2tOozLa2qxUs2Gx75Byi/Of02lCvhm3DHZQEK
         wRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6XOkFg1nQ2Wie1EzTZCD8/PaCAdSAOvX9/rmS7FFWojofVzsLaMOGXf/8JAxwSWecUZCHERDXAoLTQ1HQbkQFXw8EDWpXbIHGxMFN
X-Gm-Message-State: AOJu0YyTc8xdWrmVT5n6k6/Iix4ZD3rjDZFhktHzzio5w4lt++14H6B2
	nq/iol1TJRZBG19NbS28ZfwQIDKZ7S61MVWewoWy9GLJltRAT3lbwH+E7DcnUU8=
X-Google-Smtp-Source: AGHT+IGfNYZp4goCNHzgFZHaZHzhHrawdVbekNhioTdJBl+uUoNamZcee565J1kZhGwnpwUKwgH3Ng==
X-Received: by 2002:a17:906:414e:b0:a6f:92d2:24b2 with SMTP id a640c23a62f3a-a6f92d22574mr643266b.25.1718627168158;
        Mon, 17 Jun 2024 05:26:08 -0700 (PDT)
Received: from [192.168.0.18] ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da336fsm505971466b.41.2024.06.17.05.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:26:07 -0700 (PDT)
Message-ID: <a2d25f72-84bb-4ef6-8254-1df8da0bf808@linaro.org>
Date: Mon, 17 Jun 2024 14:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: Constify DAI ops auto_selectable_formats
To: Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
 <20240617092152.244981-2-krzysztof.kozlowski@linaro.org>
 <20240617132436.640e5310@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240617132436.640e5310@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2024 13:24, Herve Codina wrote:
> Hi Krzysztof,
> 
> On Mon, 17 Jun 2024 11:21:52 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The static arrays passed as 'auto_selectable_formats' are not modified
>> by the drivers nor by the core code, so make it const for code safety.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  sound/soc/codecs/ak4613.c          | 2 +-
>>  sound/soc/codecs/da7213.c          | 2 +-
>>  sound/soc/codecs/hdmi-codec.c      | 2 +-
>>  sound/soc/codecs/idt821034.c       | 2 +-
>>  sound/soc/codecs/pcm3168a.c        | 2 +-
>>  sound/soc/codecs/peb2466.c         | 2 +-
>>  sound/soc/generic/test-component.c | 2 +-
>>  sound/soc/sh/fsi.c                 | 2 +-
>>  sound/soc/sh/rcar/core.c           | 2 +-
>>  sound/soc/soc-utils.c              | 2 +-
>>  10 files changed, 10 insertions(+), 10 deletions(-)
>>
> 
> I think you miss sound/soc/codecs/framer-codec.c

Yes, indeed, thanks!

Best regards,
Krzysztof


