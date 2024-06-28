Return-Path: <linux-kernel+bounces-233418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8191B6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76FE282F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4584D8B5;
	Fri, 28 Jun 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdWNe68M"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE94B5A6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555278; cv=none; b=d7J52qf9b3QgwlNsE+vVkQE7vGdvS3mX/8xaoqbxRCG8+sTiTuNY7hwYjyT9LqJaHgsF7H33NyN6FnEJVB/DP0o4Qth9uh/ZSR9JQ8r5/LOcoIIawXLpnyXGfCUdurHE5RqCwauHxpZEy/tHS2/8w6JHLi2xlA08uvCXCTIqOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555278; c=relaxed/simple;
	bh=5bIe718VpZh3GKm0UVXuS2qivn/Z/jcFq7vPZzH1ZSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddYDZhncXsXwLJ0IyvaulX9YtrIGtcgEtnMBeQ5iK1hfMs/4HJzeeBjriXfIiLsHn72IQeycozFNJnwSA9qHnSCebBJ3UhSRTjVmwWzq3BbHKYvf5C2aywVBd32F/WS1nZ2K+nOzX93uYlaYxO3Bq/nd4FGmonMECAByJzSomPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdWNe68M; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so2677681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719555275; x=1720160075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5bIe718VpZh3GKm0UVXuS2qivn/Z/jcFq7vPZzH1ZSc=;
        b=LdWNe68Mt6QIFc3viT2xWlHRD6N9AcgJ2hLREMuO85rAGdt6ViDsvedNzrZ6SOjYHg
         cUmrNi61RdEbhDu7sQt7jXLThluf+PeTMJT22sKO8ntBYlkUU3ZZXorYM+gG+Wt/AAzu
         T8VRemvzuv7nevrxfD4qDva7IyUf1knJwuISSJh5ws+VqzLH3MF/G0VLWRGlhPRCvlyy
         nJqepPy7k9eNVUgt3xvkShkJ8tqslAEGF9SU7+GAECN03jmluc8SfKEiZ66LxxhGxG0v
         H74M/lDiHxrEef1L2QCqSc2rJGs2aMJaIIjsAdgGHRSL105UBsYctqUjFcxgSKgrGSi+
         Cs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719555275; x=1720160075;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bIe718VpZh3GKm0UVXuS2qivn/Z/jcFq7vPZzH1ZSc=;
        b=AMgMH0+kdkXIXGzwEEaGaXTMemE7Xwa6Uk5vXN3rR5pvqjNxrDvLCvROqzIR6ZvATG
         NA2MJL2L1zZgh/oF/+ummw9rE/Dtu3Kr3kpOu5CoXGBmAWHekXoMRBEPFuUjZZnQLb9T
         F8GljjG1nbcUEzspZQBR2hteAlwXrMmZmhKvLn9V5rxpXJswq/RZg9i9J39bEcmYSLUM
         aEziKU14Vm1iHxAOGx3lPGkl2ZNgwWEOkpnmyssRy+c3K9MFCjwXMcNHUVm4FIWzxZjZ
         gCDL+C5LTRnI8lO41111loZ/5xrrO0JKGefQLv4jCWVQwlDUn4ImkjLAfOcbi9PkhEdP
         xXpg==
X-Forwarded-Encrypted: i=1; AJvYcCU4QlsRu3x0QPeneD/46fP+Mll9ECEm15ElCfD1LO1dboPWdzi8BeGkHqPLUqO3vL6cX/iNyvTTLRa9wgRVmWO5SJydZURRYzPUJGQp
X-Gm-Message-State: AOJu0Yw/1FSdx6l+kXbifUeSG/1o6Fq/1v4i5Y9qU3OkASpOQTAv3r8C
	6WpsztMaR8Zk22iwSlb1sWoaTTw8Qztgl8R5Q4KyEBBHqTgirbdhW5geZ4EcHxk=
X-Google-Smtp-Source: AGHT+IGDLTD9FNmjRSqFm/kuw7LfWcrMal61hzXVx0iHByfoWZ56E6uu95w/0M4gAQFsIetpmN6hAQ==
X-Received: by 2002:a05:651c:4cd:b0:2ec:6756:e3e7 with SMTP id 38308e7fff4ca-2ec6756e51bmr109476031fa.40.1719555274658;
        Thu, 27 Jun 2024 23:14:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e12fcsm1216457f8f.48.2024.06.27.23.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 23:14:34 -0700 (PDT)
Message-ID: <dbfd4ab8-d413-4a21-b27d-c6bac0eb0ecd@linaro.org>
Date: Fri, 28 Jun 2024 08:14:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm6115: add description of lpi_i2s2
 pins
To: Alexey Klimov <alexey.klimov@linaro.org>, linux-sound@vger.kernel.org,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, lgirdwood@gmail.com,
 broonie@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, perex@perex.cz,
 tiwai@suse.com, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, elder@linaro.org, dmitry.baryshkov@linaro.org,
 caleb.connolly@linaro.org, linux-kernel@vger.kernel.org
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
 <20240628010715.438471-7-alexey.klimov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240628010715.438471-7-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 03:07, Alexey Klimov wrote:
> This is required to enable to HDMI audio playback on
> QRB4210 RB2 board.

This should be squashed with previous patch. You add one node of pinctrl
with all of the default pins. You also miss soundwire and dmic pins.



Best regards,
Krzysztof


