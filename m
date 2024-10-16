Return-Path: <linux-kernel+bounces-367837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D489A0766
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3D82896D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEB20695C;
	Wed, 16 Oct 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAoTA0G9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2E2071EF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074514; cv=none; b=Kn17XJAFac34KOULXTsgezsYnVUXDvjXP8b16Ph4vzOD07UE9l3CFX2DxnU2iLqPP7Q8eoD0Hv2H3xsscq6pZATxzqDFoD7//iE3MN5D/QaSnLyUAgMxYl9sdwRTR5Hi5D/8nMIrHBVsMkCVjDJUYGTKPdQ+73GhlKd9jk1jyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074514; c=relaxed/simple;
	bh=cPLPMI+yIzV0Ysp2WcB/FUdAA4R7BLdsnV3NMnx7rBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4sPd6ZD48JW4XFAn9GNDU8sWoekLwEKZ0HV4+5RFmfsxWhtNrK6o3HenKcn5QFI1GceY6/r0+p+6BQhNBM8TEBYogadQ79jdG6Nr0p8Grhwj0AJb0HcY7vmoysSYn130eqPOQyUmDJg4w9t0uixZUr/whowWFgbAdwTXQAPCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GAoTA0G9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so38270781fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729074510; x=1729679310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAXpBaMtfWO8UJVVjb65PyHD/dGQ0kmBoOJFKkFJy0M=;
        b=GAoTA0G9+N+nJiN1IEcM93LkU/f1vLY3uQlt04OF6pmhzIUseLmg8xCQeMvweBcl5S
         9VozJBRHF2UGPzbRlGzP6kP1pdX8RhfTDX3xDWma3lWqs8qPJLsZXThx7oD6way2+VYe
         CUbLMnj8oc0kqhc8l9+A1fLI4Urrx5GgtcSPxoNezqF79kUi2ezZstpQN7sJQtoB9sMn
         c5neCtFHl/mu2RyfEqCFVxiVQ9gAiGpjy6gjVsWdfGqMB8+emeb+loNR4M1KIbAgVY8U
         iyea+YZallaOu9SgRvSQf7XYml1LubKe/14VDteIFnvWIhcubZiDm3VZsNV9DmK2KFux
         BMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074511; x=1729679311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAXpBaMtfWO8UJVVjb65PyHD/dGQ0kmBoOJFKkFJy0M=;
        b=L0dqvy6NcpDIoggjYytGHxAFlrxSGkN84hUPHV21sfSxF55yOGrQzCDAPb0FBeY45l
         QO2AkEeRb9tfrmSqtuy7A6GZl68yLSL+Nd71wrRe9l+EJ658+XWRza9oqWPsRu4QC1q7
         eqX1YibpYFa/ETWIreQ6ZfF0SzDVVfbu3TBvEqeQNtVXtCpPmx55HmytD653fJGIP1be
         aIzQhMSLcm+fO/Z47YK24heE+J1nQO3zSifuj3p6k4EQz5U5pE9Hbfi0DVJdUhQ5ztMp
         v6OZaG5lWPHjfZWaBkUKmZcfSwcaHurEG0jEd2Mp80VCzaNz0EtilpcWBEojDNyiY7r2
         ONBg==
X-Forwarded-Encrypted: i=1; AJvYcCXumCCBO/cR1NjmvK0C03sNUxmzvq/0gyjN4oaLHFU+2Xcr8mqQ3mg9d+i/+26LbDCaNeE/FpDngk8XWTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiZDJs1siiTv/O3MdGsKP1IvWPR1Ga+4JKIt50gIxafGItSXa
	P9p8extx7gaihS17+P9h1WNwrX3mNN9Hu472GZPNAL1NsAkOLgGL/SjOTE/Y6F8=
X-Google-Smtp-Source: AGHT+IGtiqjFOVGlArjjfVOfTBmXeHODhday3PR0qenIrPwNidjJwD23eHbV+vCHzblqwLmnxlmcVQ==
X-Received: by 2002:a05:6512:3c91:b0:539:f807:ada1 with SMTP id 2adb3069b0e04-53a03f97686mr2367940e87.58.1729074510575;
        Wed, 16 Oct 2024 03:28:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a0000677fsm402183e87.194.2024.10.16.03.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:28:30 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:28:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 01/22] dt-bindings: net: wireless: describe the ath12k
 AHB module
Message-ID: <qzjgpwemwaknwbs3dwils6kaa5c3inabfvkaryvc32kblzfhy3@6yduooj4dk63>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-2-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015182637.955753-2-quic_rajkbhag@quicinc.com>

On Tue, Oct 15, 2024 at 11:56:16PM +0530, Raj Kumar Bhagat wrote:
> Add device-tree bindings for the ATH12K module found in the IPQ5332
> device.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  .../net/wireless/qcom,ath12k-ahb.yaml         | 293 ++++++++++++++++++
>  1 file changed, 293 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml

Generic comment, please add qcom,ath12k-calibration-variant

-- 
With best wishes
Dmitry

