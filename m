Return-Path: <linux-kernel+bounces-258122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654D938412
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25863B20F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925BC2C8;
	Sun, 21 Jul 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObkI0JcH"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB60BE4A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721551932; cv=none; b=Km0rf/TBfUsRLduffm9IeZUs+atCAs5d4/wOdielwy/faW4QiNb+Wo+mPJvH9Dd1ysgIl4N15IuCTZqWDSRnZpxchR/i5lFRZgFVfiNEXkV+0dB0MaEhsqlYXvcvjL9FWpPnloIFqXEbLdYLGNceAJsxr6rQ8iOkzew25jj9tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721551932; c=relaxed/simple;
	bh=iCQdZOj68/akTNvWefpiYEBVhYawxW0/QS2Pv7LOC/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOWRlbe3gtxslw/jgSd/JTCz/Oako7E/O/uvDWsxvTtQnbN9hO11hwC/JEnsNNMvYAB0fPPkxhBkvixNrl4Fv10WO0XygO6RNfEd5BurI/QOeBKSHGWA7UZe4NHHS4Pe7+i5VsexENOZRcMkjS3jfyZOYPTRCNJWoGbuwSPVqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObkI0JcH; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7044c085338so1898857a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721551930; x=1722156730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X7ZS2uPOUje55mIE52CAqCCri08pD10wNTzXXCn3ihY=;
        b=ObkI0JcHS09zeI6Rl/r0Yi2B5ERCcSZMGN6lIFnN7BdP/rdLqeHRarBwiwNm+gw4lG
         30PgHdbxyLbey1iyGsT9JfGY4U+6WwcT/1ODCJ8e7P1hTG4ytd+8Z9p2j2Sv5oLjTvmI
         RZK0xN+WUv9lHKawRC21zM6rohnmsqGl0tOrKGo6dsKtK3ECYhnOr0CiUfeMywUpA5lT
         paP04jfG3RbzGnGeo506MyiKweja+vrkjLQ9L7JUGd12AFpa9i7X5cxIzFxmy5GAOgMk
         vtIQ9ZlugokyziJFteum2SMi9Sbxx+MlivJBTia9n8vewFUnC+sDKy6BYMlIcq2rIWMA
         v3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721551930; x=1722156730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7ZS2uPOUje55mIE52CAqCCri08pD10wNTzXXCn3ihY=;
        b=gjZKMDgoFI/WdSDZGWFTeAWw7AEaRQSG2ZFQwHEDQWeeZJyZ8pGE9id90Dw/UQRFyR
         abQt8R9hTsAID9igsSxVl56UtdmywT2QzpwNVOiwbFTzDylNPXYbubyFLlvdSImyl4EN
         MpVQ2U/kCVUKkyoZdigiR2H3Vg1VvkIp+q9c91fKKerKFH7EoEGjN70j2juBK3fjFAm0
         fYJaA7eUtoxPSo4d0gbIjeEn8VYa7Ra2Sa1zpUNT0ClNCiI4igOdAWaGn0r0la0YgXHw
         AjCi7RIKbQd+ei7k2tKXvXFJtyqbajyL2EB/lCx03mGSdnzSF0Gl5R0KrZm01Y+plLBm
         XelA==
X-Forwarded-Encrypted: i=1; AJvYcCWnjbl22u15x315kZAc7rIoiB2VHc2qXGJWGFLxVQHe13NT4ugtcoXM5/l/fVAIXyik5phUz4FOvtaHYtbTNrLdX2jybLmZ/O1D1pBO
X-Gm-Message-State: AOJu0YyhJzUXKWyp1S9UTdWadC7FHdvHJ24o1S25zcCEl8OWv0Q23vgK
	sYb+GiH+4vPz7hlaWxngYqfiPqS0WOuOGwk6qmRFXQ0dFLVH0Bu4S+320681AQ==
X-Google-Smtp-Source: AGHT+IEc7fqKlPNWS9Lge1u0WJuAaJVMRY75Y8sIwcx5LAC81F2MWI3JcVI2FJjY9FR1mPBL0NCVBg==
X-Received: by 2002:a05:6870:171e:b0:260:eb3a:1b2 with SMTP id 586e51a60fabf-26121303088mr4811129fac.7.1721551930158;
        Sun, 21 Jul 2024 01:52:10 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d24065a1esm415083b3a.120.2024.07.21.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:52:09 -0700 (PDT)
Date: Sun, 21 Jul 2024 14:22:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mailbox: qcom-ipcc: Document the QCS9100
 IPCC
Message-ID: <20240721085205.GM1908@thinkpad>
References: <20240709-document_qcs9100_ipcc_compatible-v2-1-0fd67000e6b1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709-document_qcs9100_ipcc_compatible-v2-1-0fd67000e6b1@quicinc.com>

On Tue, Jul 09, 2024 at 10:01:47PM +0800, Tengfei Fan wrote:
> Document the Inter-Processor Communication Controller on the QCS9100
> Platform.
> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-ipcc" to describe non-SCMI
> based IPCC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Introduce support for the QCS9100 SoC device tree (DTSI) and the
> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> While the QCS9100 platform is still in the early design stage, the
> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> mounts the QCS9100 SoC instead of the SA8775p SoC.
> 
> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
> all the compatible strings will be updated from "SA8775p" to "QCS9100".
> The QCS9100 device tree patches will be pushed after all the device tree
> bindings and device driver patches are reviewed.
> 
> The final dtsi will like:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
> 
> The detailed cover letter reference:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> ---
> Changes in v2:
>   - Split huge patch series into different patch series according to
>     subsytems
>   - Update patch commit message
> 
> prevous disscussion here:
> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index 05e4e1d51713..916c47fbc238 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - qcom,qcs9100-ipcc
>            - qcom,qdu1000-ipcc
>            - qcom,sa8775p-ipcc
>            - qcom,sc7280-ipcc
> 
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240709-document_qcs9100_ipcc_compatible-f5f933d24098
> 
> Best regards,
> -- 
> Tengfei Fan <quic_tengfan@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

