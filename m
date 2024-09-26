Return-Path: <linux-kernel+bounces-340536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F79874E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C0AB281D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6000D13632B;
	Thu, 26 Sep 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqMpyqpQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AD12AAE2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358951; cv=none; b=A+EIS3Cw3BWcYsVoJUzCL6DASz7Q2hdfLsh/R5wkKGwOFhvaK5nlH9etDqLfzE1mnE+Dlf5FuYWip7FerRsNDJwdURTZFjQGkA+QzyGFAfYwgT9uocXPmDKTKaMsGuXCoAr/kXXdmrKxRbovSaoKfkKxQmPTsZsD4Km2EyzR0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358951; c=relaxed/simple;
	bh=qtBKc0d5Vu9sjyJN5Iv0E99Ts7R2xOluyiGfqEAdPsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmchW3TsfofsHFgINY1gJoEo9crq2IHuDeo4ig2Yy/whZy1BVz3UBm1G2f3KfwTP2LLJ6X0srwRIfJhsOqIYjosBC9hWXXREOIPCEeyIa2Db4SAKJBUlCur2nmTlGuF2cBb5gk7CuAJwYJr4fVuikKxTv48tO3XE5Ej0IhGZ68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FqMpyqpQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a87c7c68dso12754666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727358948; x=1727963748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZTK4WPOwRAcvteaealnIf2YQaJ9HKA9BeCAFHB9LL8=;
        b=FqMpyqpQ+2fp2RRiyP9iQihtYx16rv/UIo91acG1FGgRG7FskyNrfSOhdaX95Y8Jcb
         LmwYKx+JVQZqh77ZFZQEMGjKFtclqatMIkRmyjMymDEV2FB306oU1tT/iw5W1Uq+LWY+
         dRBmyVt1pjmYBqrNGMJpSUvuByMmXhRDqn/nnW8/R+tb/UubD8yDSRm6aZi0nRmeqrMA
         sc21T83+QTBXc09ARLsTZg8jfP2s4E9Pzey/HBCgAEsbsCj/Wt9rzTEOqX4I17EjhKU0
         D05SvkrE/J1YuH2gIxyjTeqN7zPqyVfzxV7wfv10LLyHXVTXhSp+PERyezzU5+QOcBr4
         521g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727358948; x=1727963748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZTK4WPOwRAcvteaealnIf2YQaJ9HKA9BeCAFHB9LL8=;
        b=ROqAe/7XhiV0w/S5vgA/dd1nTwNo89kbusO6Z03uGZ6eRB7U6UuQ/vVDOJtRkEoeHC
         Ll0RcRjESechT/4yLMFjyn313UNoRqDdiJkjAn5UpkZnuwqILrwTomig77KXdK3jXHV2
         b21Q7cxTtEh0gLiNmzrbx53FKBDHyj8JsW4MpZrv9m+J5dgjtXLb2qovX/u7w+DUXSjO
         6l3F0JcXV92XOBoHzEtJwc3MaB77Tg/ZSFhGpAzMFnBc9QrHV/fGKGXljkqJlYL3Dey2
         rdrnHGsVoSRuGRV5IfFHCZdot4PvYJ/Z/bN8qWFIu4ORLGH8OLujzL/azUgRtZtDunQi
         rbrA==
X-Forwarded-Encrypted: i=1; AJvYcCX51/U3JuJWZIxTzrbTbW/9pbtFaj1156ESzUse5ilUk3vQdXUoGRuugNts7a03laUbZ2M3ZS7UH7NweLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYq5jBilSiQFpksGpyQdws5TlUj42o6WEF5J6nn1WmhcIwJtA
	a+bKVOx/99PBm50ca2UL/63+8hrAvZaYZsjB7I0tQl3UCUHhCb+Q5lpTcU0/O2s=
X-Google-Smtp-Source: AGHT+IGm+s3w1IjhrvOsXsfUW+lh+psrMFXfSyDuCEg6X2+ifqF9G5vEA3XV1OssJLLwIensHmbsLg==
X-Received: by 2002:a17:906:da8d:b0:a8d:2623:cd49 with SMTP id a640c23a62f3a-a93a061db9amr316144566b.11.1727358948217;
        Thu, 26 Sep 2024 06:55:48 -0700 (PDT)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2776d83sm871766b.43.2024.09.26.06.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 06:55:47 -0700 (PDT)
Message-ID: <055da806-ff0c-4631-b007-9aceb2369226@linaro.org>
Date: Thu, 26 Sep 2024 15:55:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable DMABUF heaps support
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: quic_bjorande@quicinc.com, geert+renesas@glider.be,
 dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
 johan+linaro@kernel.org, arnd@arndb.de, nfraprado@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240926130703.7817-1-quic_pbrahma@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240926130703.7817-1-quic_pbrahma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/09/2024 15:07, Pratyush Brahma wrote:
> Enable the DMABUF heaps, system heap and default cma heap,
> required on Qualcomm SoCs (e.g. qcm6490) for sharing buffers
> across different subsystems.

Which drivers are requiring this? Or explain how exactly the hardware
requires DMABUF?

> 
> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>

Best regards,
Krzysztof


