Return-Path: <linux-kernel+bounces-238010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D663792421A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068821C24053
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88461BBBCF;
	Tue,  2 Jul 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWCQ/tZ1"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1EB1BB68D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933336; cv=none; b=CxmYB7asI6z2UVNJl4daQIREt4ri58F+YAW2EiLERiGEbo2X5PGljaWlBXyLYQFr67GS9mCxWJJmrGtiQ+6PMvzCV3biqyWr+kFttWD8GcHWMjwln06A1QcUcRron2XIK8b/ZCF1ATTcv/yNvuIm3dniyoFDGfThiFdsWC9wINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933336; c=relaxed/simple;
	bh=VUB5FRJ4Uq/3PZZLSDhuMxkEozsvjTqKlt2bLRPKgLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUaiSX8gTl8g8Mt3i0vmNFFcSBW5F4mLbib/HV4U0NA8ysTNhiLpZhuQgv/UhG5hxyd9qCoKwcHF+3iVRu0QCm+Gu8yGUWthr0NPWEDm7spVY6vdQJ9gJjbmpSon6PaPkq+bkLBmo4BdfjzzMFFIPkyqEK4kPWZU4oTbF9a0RLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWCQ/tZ1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso26703695e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719933333; x=1720538133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MBDK8Tj0NojLxfytrdUL6aPIxR2kgJ6xUKO8e2JLoqg=;
        b=IWCQ/tZ1Bo2GpSDK0aqiJ045W0B0q5ZgVO+JMlHQlG11o8vbIYzXKY3UiZvqnY5GPa
         InlTFiw0oROLjV6UoelpuUd/Cu1XTFfveW8qFtmfAEVv42cHsn3jf/nykWS99FBmqIY2
         wWDL/9ikf0wkMOGHEfAMw6rsn9aesCpM9YgTdoEDrNJgdKbdV+S2KeYkI0j7jlfJ/4D1
         tENa1CJHxUgnerwkKjrctseFUmUskNoB0q9fxMlkN6SQTSbZD9o9n+LFMsd3y0Bu4GwG
         xuGmrTF3BxFoSe3kxNlc/1vMuejGiUAn+f6kAceXpZzIJaDkBVJ+mRF6xscfosqisAHW
         shCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933333; x=1720538133;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBDK8Tj0NojLxfytrdUL6aPIxR2kgJ6xUKO8e2JLoqg=;
        b=OCVAnnHlnupyYWg3Oo8fW2vVqQOLvetRH6GFgeZLanLcWOSNQKDHdtCFpjMR4jZc4i
         zR3oyKEEkRLzi+7LUJ8tLugArfJ8iVsARxwqxvZCLOy6sW13DFin1BXh6vxCTHx3EdoD
         k3DW6JUdrbdFSX6NRyIAFDPJSfhFN3NdWfL7SB8C4A9y9/8o46g8BNwFsq1EwnlODFJE
         AeZ8Sj5eTUKRjZdNcOlBKIU/gm2fcjFWTSr5u9T6sN+SfBOIamsjvQ04VLzVeCj4iqoF
         VzWsvg0VHegdGIgUyxN43MVG76K9jEDmWvGN/4yZPsVvfmUZYanH7YeJ0b8OD3jUZXmf
         c8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUPI/9gy/dK8WNTF/Y+sW5WTuHBkcmPwacP08CDC7E1ARXTlUnbG4LS+wG5jXez/hiDoEfY9ItrSP4IxBnZf5xRvZFXJ0TVPbwPNHfp
X-Gm-Message-State: AOJu0YzUzsC48WM3FDFREYHCY0KOG66C6RFRgGadkXwWFoYHGQXNT5Gg
	zDgmyAGzTATA4O6XFI9OaZAhLNQjl6/ne9P2+cZsXPCyFrJtfaGI1s6wBxG4hQB4UWidEk4Pdxu
	2
X-Google-Smtp-Source: AGHT+IEzCSjvv+Yt9na2G4tG1jjpkC6Gnsnb78dU16Xyt2TksOJQZ63nU+nimGx33uPUoJT2VY7bUQ==
X-Received: by 2002:a05:600c:3546:b0:425:7a0e:f61 with SMTP id 5b1f17b1804b1-4257a0e11afmr55952195e9.4.1719933333519;
        Tue, 02 Jul 2024 08:15:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a2bcsm200109795e9.36.2024.07.02.08.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:15:33 -0700 (PDT)
Message-ID: <5cfb4e36-545f-4d17-9b06-c18cdae9f0c0@linaro.org>
Date: Tue, 2 Jul 2024 17:15:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add Sensirion SDP500
To: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-3-0902047b3eee@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240702-mainline_sdp500-v3-3-0902047b3eee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Add myself as a maintainer for Sensirion SDP500 pressure sensor driver
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40c754b4c39c..65f9479ac343 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19533,6 +19533,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>  F:	drivers/iio/chemical/scd4x.c
>  
> +SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
> +M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/sdp500.yaml

There is no such file.

Best regards,
Krzysztof


