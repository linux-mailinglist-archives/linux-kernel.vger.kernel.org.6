Return-Path: <linux-kernel+bounces-311800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4249968DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A861C224C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF11C62D2;
	Mon,  2 Sep 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehoRiv3J"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BD1A3AAA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302607; cv=none; b=WzKxTB6Obi6qrhhY/NH9M3OOFSLzAzHM4hnf2oeD/yIX+eL8GyRTBBftXjwtLGLsM/2jBDowJAsu9qnh8I04b9ItV7y6R5fn/xFocCUOoEilvoKTCtSDAnVHC5jPDbDMGyt8i69QNzAiRpNKJJwV39hjOMnXdoiqFInm45wuv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302607; c=relaxed/simple;
	bh=XdOEyXO9L3nv85zdXcpB19Q1o7Pzj+23Oxcb5Kqq8lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG9tXAzpEB1ZoQp6prShrq6b2fKuIShZ78Xx6JVj4gM1Gk/wwzPPHPdjHQHm78ii89f8ROYdkZ0LmcJ42MS+BtaqOaG2RkjE1br5Npn+a633mwNQ2e8MI1LIOuEKHVkYDvH0jsPnr6xzcjwJXY1uRCm0GNcgbUt5cWUmJQyNON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehoRiv3J; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-534366c1aa2so4663633e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725302604; x=1725907404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWGSkHtICBBVaT2Flb/MI9EECebDHAY5AhF2lbTqaJM=;
        b=ehoRiv3J9XE4BpqPR0PJ4yYztoD1G9Om5Qx+nhkw5MOMxEmeez4DFAfJuZivTIy8Kn
         jcNYmTq/Fy/n5y2y7ORcCPRa+fOxudxGxxq1+IMUzlws9wIlDjU/HEgvnDVdM1ZZvqqv
         gIlSCAS4RLWBSgc3TULuOj+He6hrxrRU5ZIa1OUdI6HCRrtdkOQFOqqhFkVHNuMa+oy9
         rGtbhadskA6eDrraC6Bm06MqW1Rp+jeQzMwrl/PMq8jfTjDCpyae2m99YR/KCbr5XLd5
         rtstZVYkaDh6vmbCnWOaRv40ErXRfnr5//aAlKfsIM4d8f8cguud+J7bOgFdxJt9zMdf
         EDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302604; x=1725907404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWGSkHtICBBVaT2Flb/MI9EECebDHAY5AhF2lbTqaJM=;
        b=P4WviRiToD6bqbVc1TecFmXyG587KnpcsIurQs1NpmrPnHeN2Oazvq7UdzRSyHk0vq
         0uOoUZYc+fRsAB7NrkLUNKV+ltKKBHpxWo8NZVgaqmbhpuHAWovRFbxsEk+3GXXlFIVF
         B7QTFps0r1ai/d8cb9qarGlPuh6JTwGNdqFP8sSkzshzJ6sq/vTIuYRvz1Qw1/JFS6mI
         OVA0MOLNzohVvpPhph0kLfuzfaBEZtbq42RGbIsbYFiTLcGBXwYpLhoifvOY9g+5LvhH
         cxDE/YR2EUs7k2n5zk2AB/jZ8axDy5sc/bV33fSSACB/vuTcKInBtN9fOmDQm/qGF6zU
         BC8A==
X-Forwarded-Encrypted: i=1; AJvYcCWSXTpB7Qh9WUxZyHZevrsK0ptoTJhYjEe8j7/fp8fGT1G76jcSYcBvkFws3XhiYgS+DY8/RctZ3uM9oW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwimfhUYhjJWladCZE2Su8Und4RZxu22Bjpzmrxh0BNYIZlHiiL
	/YmF9j5GTEISmqqCCAxDsW8s5A9eyy+7+l8VrUSHlbnNArSivG0RfcGFO788ZMc=
X-Google-Smtp-Source: AGHT+IE2qKw14EU6gHkFeSjAPuG80J10mNoHz3m5AoJJRsY4KlPHTH+CHXQLJ+aUaD7+wDLYH4cKCA==
X-Received: by 2002:a05:6512:b90:b0:52d:6663:5cbe with SMTP id 2adb3069b0e04-53546af500dmr7988306e87.12.1725302603385;
        Mon, 02 Sep 2024 11:43:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841651sm1738506e87.206.2024.09.02.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:43:22 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:43:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <quic_kdybcio@quicinc.com>, 
	20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-romulus: Add lid switch
Message-ID: <qqlodix7wfcgipzdk5bmjonatmzgvjueadmmzdvkcboifwtkiy@oryqzxctboou>
References: <20240902-topic-sl7_updates-v1-0-3ee667e6652d@quicinc.com>
 <20240902-topic-sl7_updates-v1-1-3ee667e6652d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902-topic-sl7_updates-v1-1-3ee667e6652d@quicinc.com>

On Mon, Sep 02, 2024 at 04:50:33PM GMT, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> One of the best parts of having a laptop is being able to close the lid
> and go on with your day. Enable this feature by defining the lid switch.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
>  .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

