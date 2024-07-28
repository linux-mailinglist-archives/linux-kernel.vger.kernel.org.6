Return-Path: <linux-kernel+bounces-264504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE793E43F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA851C20F47
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D861A28D;
	Sun, 28 Jul 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrR4xWWH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960B8F62
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722157971; cv=none; b=pzmmfzS3a8J85HIZiJmpZc1KQzeDSufkVeJdvKh8a7ahSL4M8TaqZyWmF4CaXwWr/Q9F5QQKLss6aPBeYLluf5l6CbIBqoNLhg75W0mp3YdF9+55JwhzL1MotC4xhttcXEQf170lp847tl4sadxTbiOsOkTuTop0k5XFzLucdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722157971; c=relaxed/simple;
	bh=/GrOv+ZFu+oj7Vmr+AbTZmMP18uAO32U89RBktZbUjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr4KzvVN2WqM1vzc+UqxQ34k68AhiWZtao9cmdHq5q1jZU/wJUayw8o5Vh5VdYyKycNqTtg4iufB+990JU0+e9XwN2RLeYuDtN84zKLz3k66bxHk48iNysTy2FwYYg6HL0aGg9Cbkb8XEhOW0jLsUDTfyrecJUd2t+yeD8mh5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yrR4xWWH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367990aaef3so790509f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722157968; x=1722762768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8sNLvowTMgGkF86EscYrRJVSXEtjbqqnoumJ+2YQ72k=;
        b=yrR4xWWHPTs9hcfXkPGuqDXp3z9ufJCuPIqv7yWR1JJt9vZsAuUze9zKo9e179FV6P
         FDzCMVJfgJJyehLCRyinMVCQA9dWVLrEQJYeudR5+AwC1j/avWHjq4VHJvm+nru9WHgx
         kAVHmAgmx0R37tUrl+PYV2u5XHcugj9hug9ekvsTOozmPjbHNyH7NZcpUa1OGRyqNZVp
         IV2w82sUQj9QTzrf11yh/7BLlnBwbwGAMyr28+O40U1lQ4c99AkCE1PKFUBUvRnmSThX
         w1Vven1g3IkNH4P0DK5ZtKUgF3xckLFA+rUXk45zp+8aDI0UWX/Utw3QhQK9G4VGLBgv
         KUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722157968; x=1722762768;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sNLvowTMgGkF86EscYrRJVSXEtjbqqnoumJ+2YQ72k=;
        b=muLzsY82zrkRgWClI3F4WkJI5s9B2zh8PUXlOevc4mrFNXCnvCr04CQqeOUH3Orryk
         7tVnJ1tNZdNHvhuqS/2xGlnal/pgmkpB+4vTHtPKjGpqBoO3A6ZCSw5G4pVhFtLsQhq4
         VCS8jWPrp5edAUG7K5aiS9ExDJ8iXTFoaNvJAJl0N88Nh28mO101VJp451cNcdve4u/T
         nhotUcrk03WF4DucmsPXoGO8FNv4DUGX0atQZM9Zg2DgO6Vr0IY6dy0jEiTIA1pHnJCA
         w44sCfIXVGKhWzb+hDtRv7oXbuL6RX9leBi+FjIwJemkBmgUK/XTFTyJ2TzYvx/aA2Su
         aVuw==
X-Forwarded-Encrypted: i=1; AJvYcCXRY5mUTT7gR9XnpKRCQtNK6Dm5yrHfgKOACxA8AodO/uY1QNr7gnnYpJobcRjmKy6p6fSMTcrUzEQY6k6xdiASbKgsXCC2+PoOOgrw
X-Gm-Message-State: AOJu0YzpNErhsPsqosftKisT9L3F8B+y8PWQbjMs5I8K+7TytKz/DE/5
	gEz/OQYRpx5S58JH0nRrxW2y5pDDbqn5JhbEOgBPArsslgf53PtcCHkXrW4vtx0=
X-Google-Smtp-Source: AGHT+IFnH46iePXOd/yG/nd4uSZJPo95bdDNI4QTUeubmn9tThDXPaR8WG0juWEyYkxWfaaWPOSMcQ==
X-Received: by 2002:a5d:5888:0:b0:367:916e:4206 with SMTP id ffacd0b85a97d-36b5d0ae8f3mr3673037f8f.46.1722157967749;
        Sun, 28 Jul 2024 02:12:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280bea7af9sm86555335e9.15.2024.07.28.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 02:12:47 -0700 (PDT)
Message-ID: <f3772311-baf6-4d45-8678-83ff248dcbf0@linaro.org>
Date: Sun, 28 Jul 2024 11:12:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: pressure: Add driver for Sensirion SDP500
To: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
 <20240725-mainline_sdp500-v4-2-ea2f5b189958@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240725-mainline_sdp500-v4-2-ea2f5b189958@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2024 17:37, Petar Stoykov via B4 Relay wrote:
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> ---

> +
> +static const struct i2c_device_id sdp500_id[] = {
> +	{ "sdp500" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> +
> +static const struct of_device_id sdp500_of_match[] = {
> +	{ .compatible = "sensirion,sdp500" },
> +	{ .compatible = "sensirion,sdp510" },

Drop, why do you need it? I asked about this last time. Also, your OF
table is not in sync with I2C table, so this should raise questions.

Best regards,
Krzysztof


