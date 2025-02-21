Return-Path: <linux-kernel+bounces-526499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA53A3FF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6403A54E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5451F12EC;
	Fri, 21 Feb 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhlp4fF7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673511FBEAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165395; cv=none; b=hQyXRoi8F/9puVAWwWcecYMhNOdjmSyaY5kxP8HuoIaS21qhIg/ENuK8CQVjgaGqsrP76RiVbWUEZ5cvfByyo54BKAPMRZ38pdAxAQabdOpBm1975KVrI5B3bVCRmip1t+wn91xYccMlhB60GCKl8tHHKzjXwWy16GDajK3+DoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165395; c=relaxed/simple;
	bh=5fvG/DVaGj5l8z8BF8vLq3u/qF14rEVt1HH0vUnX6qw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B3PcoBHyTtuAJIrAcG4cIBijqg7KIvC7dYAezuDceMTsIwYUv+OyD31xWf5Z0igL9j69vhMmIepvRe8CW3XttMDclggR0Yr/YfRWnUP6Zmoz+0ZPSBx7WeQ83LYVO1++QdNcBEQwx2McQ1GateMqFgL7jvOSLooMka5Ema5UEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhlp4fF7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439a331d981so21610825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740165392; x=1740770192; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVZmPLX9SKE4OV/m5m7MNKgR1nn72J93NrOuCk0UxAI=;
        b=jhlp4fF79+aaHu5NjiIxAjtLP2Arb58VoghKjVLT1o4339vf//wkkIEljuU9SihVuj
         q9xODfuPoHFB6INogOBb5XbRhclmOtk86+Ly31KcxBkrL3kUirZgKSbvrqCpJe5Ygj7D
         f18KmG/KYZxkumNjvAWS7sjF5W78j6y75IXZKG46wR7swOoeYfxxUOzCyfSt2VWJ/swJ
         RNu22fdKpcXD7q7Ze3RgP3rJrJqx1w3FUuRsHbjhPIBuTijKJr5N5JXmTbQK9s3KvBVC
         E72scLqVnKBqmfUTL1K+K8GDK6TSz6UVPG/mjeHPtHin02H9nrnDet7AHC1HEdeQAjtt
         GJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165392; x=1740770192;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVZmPLX9SKE4OV/m5m7MNKgR1nn72J93NrOuCk0UxAI=;
        b=B1DchwaIDJxZzznyoXRhhp8AHvin/JJaVgNDepwrAXYVZMs/G7L16fwS15EhgCcWrH
         +hgDQcvX09WBNQx+iucZ2UOULWC4K0kx8vvyT9OccLHt0ZYOSib1cw7/PYS+rXK9GTM5
         PeSzo9+79u78ic46wfHiWblieihHcFGM7aMZ968Q4x7ILuF9G5LZlqZtKU7XyQeou1DC
         DYvEL/NefWJysMUTvTgd2jubw+iccqh7QtEFW21gwR5RPD91X7IA46cfG4PWOAQhmD0g
         X8+zzVMUfcnhopagvI8ZAJ+GBQ6KbGN7PSqZ2YMOE4VV9Y6qMkRS0zHZpTxfC6wtM5Bx
         4C2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8jL6BsXRbOPkaIBrJONdyKionBxEGuxTNWPiaUZqyCa0RiTTn8/deAyEsmNT2+AKz0koLM6aSv3R3uVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSdIxtUnkkcUpcRsGPWjo7/PZs27mIrMkBS5kRDPBkbsI2Jce
	djSpHYfMMjxFPYIyj/EWBE/VEjiBCqrIbWVaQbKv6lTrvi2xcjLYf0AEacRe/8o=
X-Gm-Gg: ASbGncu8HenvsU2unXA1/Ktbfn80dkBamb+8+hEIb1WRTOp4DcvCbzlfpiCNzQH9EaK
	CgtMb4XXXLq+kA0xd3X0yE65b4jDIhaY3sCCDCdGIxCTU+3CEZlW82NForV6ZXa61f81sbCsMux
	Wl0TFbvASkAD+YRMtNYh/mnF9BknjgwJPhWuB/8bbMRmDR0aYdgB5E4MrbvKfFhBP1u0EM7wTDq
	GfB0fWsnwV2u4CjUAlzaQf+eVZ6FXeLPh+2wSce0s9nQ7VO/+cknou42aabZtYl1nxNIvK6x/Pn
	99YVVHtlYZfcmyJg2GqtHnpYwFB2
X-Google-Smtp-Source: AGHT+IEZIpW2AjGEyy2pSB737lSPq5c0PLgcm0gC9yalYRLXf6Zt62YGC6R9bY4VkJI99cTLRTXYvw==
X-Received: by 2002:a05:600c:4ed1:b0:439:8ada:e3b0 with SMTP id 5b1f17b1804b1-439ae21636emr38684615e9.19.1740165391631;
        Fri, 21 Feb 2025 11:16:31 -0800 (PST)
Received: from localhost ([2.124.154.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm25934415e9.17.2025.02.21.11.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Feb 2025 19:16:29 +0000
Message-Id: <D7YD5C0HCSZ1.2DOE3TAA7024Y@linaro.org>
Cc: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
 <quic_anubhavg@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/1] arm64: dts: qcom: qcs6490-rb3gen: add and
 enable BT node
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Janaki Ramaiah Thota" <quic_janathot@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250221171014.120946-1-quic_janathot@quicinc.com>
 <20250221171014.120946-2-quic_janathot@quicinc.com>
In-Reply-To: <20250221171014.120946-2-quic_janathot@quicinc.com>

On Fri Feb 21, 2025 at 5:10 PM GMT, Janaki Ramaiah Thota wrote:
> Add the PMU node for WCN6750 present on the qcs6490-rb3gen

Is it rb3gen or rb3gen2? Also in the subject.

The file that you patch seems to be "rb3gen2".

> board and assign its power outputs to the Bluetooth module.
>
> In WCN6750 module sw_ctrl and wifi-enable pins are handled
> in the wifi controller firmware. Therefore, it is not required
> to have those pins' entries in the PMU node.
>
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 171 ++++++++++++++++++-
>  1 file changed, 170 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec..de03770e0b90 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts

[..]

Best regards,
Alexey

