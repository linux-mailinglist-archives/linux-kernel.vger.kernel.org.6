Return-Path: <linux-kernel+bounces-209553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218079037A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E967B29EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645A176AD4;
	Tue, 11 Jun 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILY4VEQl"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC017624A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097263; cv=none; b=mjogV+1yp5xMhj6kV317eB4obviEz7PX6EPA3TbHCrdqtWHpFCUYmIl3dLX+id8y9zOnsqQPSY5Emuhqo5lOx6O/Suyxne8bbTc2OLQ3NgPnjD4gDaogUwxX3C9cwqrPV2tu7RchJpmthR9EtTTa+eBDES1QRuy0aVWX4zt271o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097263; c=relaxed/simple;
	bh=p3x3s+/tNrym5mIRofuIo7OsTZNSLkXI8ke4t4M7k2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srH+jkAgnAZHQRjp4KPxOBaFAqy0J7EofYdcuLIyatKLB1GngNArPstsmoN5A1OoCBvVZSBeDE8GwU2n1n1Gz7zaGYno9E8CFVSlfUu/l+PnwH+MyR0v8MpWrCk+rq3CMKyV8Wvv12sVPSrKEuVji9C59OlV3iEUO7iwCeqWudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ILY4VEQl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso4124789e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718097260; x=1718702060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/TXwtuKTEZj6Au0WA9Vu6/LZbbPfCoRx0dnIuFjmYP8=;
        b=ILY4VEQlkihGnyETYtxlQs2GhP/ZIawhy6tNIfLpBOhuIDPlhijiUwBdcjhvMRXp0i
         UdZJNRNO38SwHs8CCy7256XAoERI4/G/zKcrTdS7zPNMwDUqyZi7zxc3fQJOFfVe6kn1
         Zii3GfxMkDgWeaA/lF2Wm4+ldJO11zrtZ+cZEHHc6YVQ6d8hGuG+XTGxOC0zvhbQ830Y
         T71wzXW6YKaeW29lwQ+c4WxUWq1MVAHmMGdTiQ96JP61jzLEuA81xql94HhLy0wbOpew
         Shu7gPmcA1xqe37rsOTE3NzvLLfjE6I4bMDZjFgMsXdfQlRCxjNpNPLHx3iMKfBAiRIu
         YBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097260; x=1718702060;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TXwtuKTEZj6Au0WA9Vu6/LZbbPfCoRx0dnIuFjmYP8=;
        b=bvTOY88ZYi/TTO08lC3I1jDXwYp6AG3x5gQzCOjVLopVCANd1VFZWpEgkjtG4Ec4xz
         yuPPIceGaZPVUpteq5+6ocJBlrx8N1MYYjkydywmSsLLgYkSz/etc8DQZNpAC7UmrIuK
         e089+4I0zOA9vXqbtwBkBd2TMSvArzsgTdCHVIsbr30APLuLjz60sj+3hnX7KyYVMtEP
         sFXizvFBwHes4CvlzDHfiR0ZzP6CT+rlVtvN52vTzj5jdgKnfNajOsV5ukyqhwziOQy0
         BjyQTAf50BNao36lgSl8IciUCwzcxHD/mLdx4trKD04mm+/nZCHDw7+c4xedm/TU2Q7j
         Fd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0ln+PTCizEn/rhRQoYnqM5rGHnbbYAXjHe8RVis/T3ObRijhBczTX4MztKJk3KBtU33fsudOizfxRNJMhlsnqSYKvkZ9vCbRJrwvW
X-Gm-Message-State: AOJu0Yy5s3q145Cwk8mSnOnqGKlOAKolEX/VBL2UtQ5PAJToc7Vs4lA9
	XnKFetRg0FfaZKDSKL0OXDqGSAd/fPx+jV7lXLIZcuIvFUPyJUE+rypQe4RWSwg=
X-Google-Smtp-Source: AGHT+IEtTVGukRTZfWCidMon/sDVDeg4VJKJjpcsHo2ctc7b2+XZN6hz836P6S+mfu7mdIMK9tQk/w==
X-Received: by 2002:a05:6512:3d0b:b0:52c:836a:3db8 with SMTP id 2adb3069b0e04-52c836a3e68mr5771381e87.15.1718097260124;
        Tue, 11 Jun 2024 02:14:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2024b1c8sm6114658f8f.39.2024.06.11.02.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 02:14:19 -0700 (PDT)
Message-ID: <170c14c9-e1c7-4252-a550-4f9a8cef3a27@linaro.org>
Date: Tue, 11 Jun 2024 11:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] leds: Add a driver for MP3326
To: Yuxi Wang <Yuxi.Wang@monolithicpower.com>, pavel@ucw.cz, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 wyx137120466@gmail.com
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240611083236.1609-1-Yuxi.Wang@monolithicpower.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240611083236.1609-1-Yuxi.Wang@monolithicpower.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 10:32, Yuxi Wang wrote:
> Add the binding description and the corresponding driver for
> the MPS MP3326.
> 
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> 
> Changes in V2:
>   - Fix patch format error

Only this? So all other feedback - like 10 comments - were ignored?

Sorry, please go to previous discussion and implement entire feedback.
Then document in changelog what did you do.

Best regards,
Krzysztof


