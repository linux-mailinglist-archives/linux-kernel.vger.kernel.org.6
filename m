Return-Path: <linux-kernel+bounces-258815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EC938CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF3282A31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D3516D9A6;
	Mon, 22 Jul 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnL/LyQD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305F14F124
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642556; cv=none; b=QUvw12IffNUhssO7hDUuYEbbdtm97WrtNb9Nu8HkT3HWoNX1BUM7XIzUSUFKtMPH/6PViLJJ33xi0d4bOG6GRyahdZ/rOCvvZK1BAum8CGiPkSVPgOtwwPdm3dcMDL6ODXQn6RNzLssOLfyfizmibHm5g5ad6ZQOgd1wOsrSgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642556; c=relaxed/simple;
	bh=jYLTSjq/PXtDRDTWNKvKJOWO/iKI8ucXuLTYaHLnT7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLil2W/ayjacb9kPDrDRCntefaSAg9bKnp6k8ULW7AK3HzwsozTfPwzI5uPW1Kkx3vPNKsraXRNibq36PzelfVoY/CPXDAAtxXqgWFWeVglm7b30coG9oiZlJblUTwciIk1xzu5b6SOPbqDWuwwQ6plgZMxFOTSc6XIxW3T0Jf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnL/LyQD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77e85cb9b4so467994866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721642553; x=1722247353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iQOskfSoofdQ6YzsUPnPrCBHMPxzANvsMfhHDoqsPzI=;
        b=WnL/LyQD6E95kiQNZ1fqt/z89f6kb9JY+F0bUR9HR/H03ljoT3Qa+TWMIZHAJ+Ub23
         PlXwxpw5hBZM4Mr/3Qkj2QTPr6tr6qRfwyTRCZsUVRiuvoZyhB9fFPPbx2DLJfkq0ygA
         YJWOeu8HRRtArUB2FIRz+Ls4OgAZ/8SroELNNzY+k00vN3f/ZlUkljDKf39Y3SlKwJVD
         TaftnrDu36zXaNK+iHV/tM04NrUvqXCFwRz3xded+2UsiRdyCClDrzjRnw/Hb2Llaynj
         CkUt+EAWvNuQt99w8aA5xDar+TeARpf3onRAg2QLprb3MGHn2mrx3JstmAsQWZ7LMY4T
         hkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642553; x=1722247353;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQOskfSoofdQ6YzsUPnPrCBHMPxzANvsMfhHDoqsPzI=;
        b=WSuUGzHSAJj5MkNglO5OqGARsD6TdlYW6d+O4NFjTzoorOHjboPUbbbLV17dq/PDrH
         RXzj7C095TwSRm9B0F049Kc3ra4KcaSzj4VoBhVDIUj5cb5rhfcj+JiGcIOBIBbjoRa9
         +DX+FEOCeoS7bvZpKbvUHUQAtDfsO7DSPkt3xfBvdu3F3KFX73AxcXSmo7Ckur39XQbW
         7qCgr0TUmDfyHuAVBSLm5ouu78KU44CHkoIOT6YThY/z33y5mTdGT55xYsd+T+nZwoEj
         fwkJdQcw0o+Rxpygn4/0n69d6q3GbjUupCAYKG5G0LXBQao9EnMBc1gVhW2NO98jkSi4
         SjFg==
X-Forwarded-Encrypted: i=1; AJvYcCWnyc84QcQ/TOUOUgpXMTRbOsOxiK19sUGSdajFr3JvtAW9wRr/XO9bes9aqRBm0SAqLIMzn58GHf551mnUVt7sMRDN44Tr3jBS5UnB
X-Gm-Message-State: AOJu0Yz+ZTPxQcrAkP7S20H5WG/+2kdR6SWOmL6rONkMi8TEfwZe+WXQ
	PNjAjoCKb6z9jNlEIKiak+ea8hiXc1xeEyigYk+RdLdR3rsud36ujN03iKHcZz4=
X-Google-Smtp-Source: AGHT+IH27RzEVbqBSW9sN0SG6KbtlAtKVG3cnqwo/ndvJ6bfURVF0wzaQ44gCGv9l0yi+AF+0E9SQg==
X-Received: by 2002:a17:907:2d06:b0:a77:cf09:9c70 with SMTP id a640c23a62f3a-a7a4c1034ebmr404799866b.43.1721642553062;
        Mon, 22 Jul 2024 03:02:33 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922296sm410590166b.179.2024.07.22.03.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:02:32 -0700 (PDT)
Message-ID: <e95fe5b5-040a-4ff1-8df8-078f38c8eb34@linaro.org>
Date: Mon, 22 Jul 2024 12:02:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] arm64: dts: qcom: x1e80100-qcp: fix up PCIe6a
 pinctrl node
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Xilin Wu <wuxilin123@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722095459.27437-1-johan+linaro@kernel.org>
 <20240722095459.27437-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722095459.27437-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 11:54 AM, Johan Hovold wrote:
> The PCIe6a pinctrl node appears to have been copied from the sc8280xp
> CRD dts, which has the NVMe on pcie2a and uses some funny indentation.
> 
> Fix up the node name to match the x1e80100 use and label and use only
> tabs for indentation.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

