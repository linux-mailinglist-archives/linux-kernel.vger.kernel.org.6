Return-Path: <linux-kernel+bounces-200494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84EB8FB0CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB2B28334C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951B1459E8;
	Tue,  4 Jun 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pck8xz7a"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4714532B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499653; cv=none; b=FFgrVvDMSrNGM8B3ZqLocwrSRBFUG6vcIlAsrpUN3SD7yFwxvk+kH2x/Wav9FRs4BtaVKQvoGv3MRwpvy5uY4DMoJK0m0gz3DDhIsZqLqd/rcTuW2tPxWVDc6X2TFodyWpf6HK8G2BAQ7wfaaEQaKeL7f34ZTdiqC6xJDxrez24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499653; c=relaxed/simple;
	bh=gkoEaXTyzcTGwsF2z95ESHnjbvRX6cwJPCJEJHD0kz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5TnaIZebONdgw6ZifhxHTx+W7IxmU5cHlEtvXHPdf1/teRpVtKQj52/LFmO0ZF52JwtE7xMp6eBZbBwl6ixRDn+menrWJ4FWpKgpvOu80EwqIWZRBVtNVG5V1kNcjqq2KOAg0djEOmWl5jHlwRQMFv+017RewHkOY0FTGN7elE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pck8xz7a; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso5447941276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499650; x=1718104450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4BJtPQ73qcfI2sO7ETwV4VEq/ZHWblB62uvfMkAtXA=;
        b=pck8xz7aEQCZrXxZBnTqIUQJ/hy5CAtsO/YnI4+QTIMDaLZ/iomeFmDWIMuiuEOv2H
         cmI95gO6IS3BM1C3jdbsOzHg2NAmdNpWtKvP4DboE4PEWT2gHw3cRN2xAQ0zW3UId6HG
         qIO3XkzCY38Tqn1nzNDZ0bdyChnOHNXZCqPZqZ1pJkKBbxCtoL4LS2Z5ifWOEboVVBMG
         onQtMeGJXMeS7JF30GvwDra7+5K4S0xx3pnfd+liP8/0mZdgZTdNnX0dCNewHoi5UP0w
         SKY8xL5FCSOcmf734LZfR0qop/RzoYIA4TFibRAQm02HqW5U6hJQBFkMNobVG1rMjL31
         s91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499650; x=1718104450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4BJtPQ73qcfI2sO7ETwV4VEq/ZHWblB62uvfMkAtXA=;
        b=sPaB4SBQHrwqXSE4hqZVhy9RKxFzIYDMQqYbauKP4k4yB4m8cczFoSGDasOO0OFH+E
         oxKRFyVwx3DzPb3UT7XNyNRPYKOCdyOV+mD+1DQQMUiGA9c9fx7bsblaMIAFltren+JI
         7LnwLIoASSaQXMutRyjmDxj1doUgoGo61apACQbr8ClPVP2bplxaCY3yzkvPIWH4Qtsc
         70Dup1e0/13VCoxkB/dGJjtA5opNROrBwadOcucd0sZD/IyaWgcQMsH1o82CfxVgKud8
         AYmU1N70j5Xm2yPi+ISFSip2G64Q+nhlST4KLZCtL4aYlGw/ROGBXYSSuvxPnC0hsiQN
         wR6A==
X-Forwarded-Encrypted: i=1; AJvYcCUKCW20EWzHvWFgWdwI1QKLBpDviRIZmefsYJZNT+aoCV0U5CoI5e7mULUmQy0je7pjJYvxWdqErKGfhKIe6H+061w2fl22Qe4h0z12
X-Gm-Message-State: AOJu0Yw9ZDsStskgpzuC6Jounc6SMs5TqFSL2XU7f9eH78Ll2K/hGu/a
	/gpeFa+n8HkuLZjVxYhpdNsOJ637wk2uZuTQZqmdRdh55AalIIveJpeC4FPHg6QoIVdXm8k2sWU
	cas/yAJ28T2B3ams7PFT94NitQkPBlt+kvch7yg==
X-Google-Smtp-Source: AGHT+IGbblsFi//5mNdWKH76B/L88CqYx2joBG7nqbVMyDK7axGNMhKFIZaU+2AbW4M8ccMJuHxy87Azife0n7bvlpg=
X-Received: by 2002:a25:acdc:0:b0:dee:998b:1459 with SMTP id
 3f1490d57ef6-dfa73c3dbc1mr11889385276.39.1717499650330; Tue, 04 Jun 2024
 04:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523120337.9530-1-quic_nainmeht@quicinc.com> <20240523120337.9530-2-quic_nainmeht@quicinc.com>
In-Reply-To: <20240523120337.9530-2-quic_nainmeht@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:34 +0200
Message-ID: <CAPDyKFpAtvQyfKJ6-xWEZhv259eAzuS+nmA9tcFDf_h728s1Qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Document the SDX75 compatible
To: Naina Mehta <quic_nainmeht@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, bhupesh.sharma@linaro.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 14:04, Naina Mehta <quic_nainmeht@quicinc.com> wrote:
>
> Document the compatible for SDHCI on SDX75 SoC.
>
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index c24c537f62b1..11979b026d21 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -51,6 +51,7 @@ properties:
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
>                - qcom,sdx65-sdhci
> +              - qcom,sdx75-sdhci
>                - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
> --
> 2.17.1
>

