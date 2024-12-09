Return-Path: <linux-kernel+bounces-438537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA819EA26B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A704718827A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAC142903;
	Mon,  9 Dec 2024 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1yhHPmS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDF19E97C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785666; cv=none; b=POezYxpfE3ZvCmrqUbyWo+R+OCWlv5rycSfwHetLJvYz95BTotNtumwsf0rmj/LOpoep3dI6WpcUdQwAXr60MLS4VnWiF3fTw9L1VMIw+X1fmYoZUPo6i4RB3hip3xil7EPWIPn80BEC6QUZ49Mio5dePwASBz46UOLY+zUYrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785666; c=relaxed/simple;
	bh=DPXFkfmC/HD4F7ixulc1QXQpjTWwM+SQQwdoxybkPHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlhcyO7jZlaqCDqV9nPYUPJ4v1blPw3GNby3mq6mKhABYadCLPR7nNXPEjLAVxRbeP8y7Qimr2yCmmy6nWFwKjUPehRQg0uWYYWc6yUSs+91b7WRoHwOBx88Fk4TWIIVwtVAZwRofErF0ZBXk7XBmwxclzHtM+asBnGaymbN8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1yhHPmS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df6322ea7so5726652e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733785662; x=1734390462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpfvxMNcE2evx4GUMkzffrViZXHtVJ3SlF17hKgOXT8=;
        b=M1yhHPmSz3uro9BTKYJOyOorbBHbXVKo1KmeiwqBo20yjqGjlLnobnHDDTW0VShZcF
         DXlsDTdl99W1I2wSQROJKgLWsj7OohfRHXJAizawwEsEKYoi7KPu15lMRxWhsw6HJzLf
         /Xf78vM1GeEikomZuqha0c76tIBc+SGdzKXygZsH6LG7Lgx9WEwEcWULHICcwcDTLLab
         8bpl8wR26G2n69dGCuhYBsZ3xpxZAenH7EVP3x6zQZAzb3iQDUX6u3Dd92sFDiIOmWpb
         D/mEJVo6unieguD61rOa9BtrPFjFal/+P763tH798mx92PGwNvy1iRJaV8QEIoI5Ycty
         LJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785662; x=1734390462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpfvxMNcE2evx4GUMkzffrViZXHtVJ3SlF17hKgOXT8=;
        b=CSRZW2+2cvQDfFeXPwMhDwB3G9R57NKnV3CNn47e7JHWwV19CoTlEjZOEl74rTz3+w
         r3evvdsqXYsO1wYa3EEpaRon36tzSMCh2iUdzjt2D4Iw9jrIahNr+xlsAgIgYWbxWycL
         HgBHHo/NdtJy7Ppjb6u1MA8WirSZ2tvNCCGPgiIMAQS+RiHaSDVx9kiEZmaGIsyt61ag
         yxafQ38k7KrPQKZK4T5icWerhuZlTeQeGQAzWA7tC5pM5u67NOF0oWiqdIBtlBoLkQW/
         5h7/4IzeZmaRxgTerg+8Hei5SzZzM9irCvWdZrpV3NrM9KqXL1PQemX58OfWhhzd8FOP
         auRA==
X-Forwarded-Encrypted: i=1; AJvYcCVZs4VqJz13oWDzYYp3cekZzFIiIT3jiQG1FWFn4BGOBnJzmhM7CRw8/iRPttJQgaAoo8w7wNRN57bLBQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOB2ZyZSi9GPzfycgp2JDonOmPghvOn0N8Yd0ic6E9ipHf8s1
	SLLnrlZ1Ar8Q8q8PaFrQmcYZ9WE/WOa9h+pvEY6ONvAW8lTbtlPly+z7EJXppTo=
X-Gm-Gg: ASbGncvfHcKTHl1A+6iu9F7WIUDwgcd4MNAFK34tv8kxawxtI0WGW3yqiNLW94rd8HM
	fCe5kBpAx3iv/TtKt+QAuWtjWJta/xK0YFK6+oWPDB9sVxQLdCDcPt0KXMg2nGtdpqAkJf9GtAA
	9p6jKCzLAQHPAWxUteXIYdiVF3GWaBOR7zvkxIHhQPcBjdrrFoot0PIKX/7FCXxkWTzq/cUcCXL
	CzO471N0t2liQMys0YtpPuKDVfrmgFF+LvT1N7+kt1b8CKqM4x3AZmxZYWldbmw289sOGsIXkxO
	BdzDZEuR+18FGXGsFz8Rv05mkopFH+CEzQ==
X-Google-Smtp-Source: AGHT+IH/GhAQu8ZUGtenaW6SKJAm4VqyvLWgGVL9JvGyxgiMhFhjNXvESpDyxAefkm3AWRhsFA+KBw==
X-Received: by 2002:a05:6512:4024:b0:540:1ba5:75d with SMTP id 2adb3069b0e04-540240bd1afmr870079e87.20.1733785662363;
        Mon, 09 Dec 2024 15:07:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e378c4264sm1081287e87.239.2024.12.09.15.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:07:40 -0800 (PST)
Date: Tue, 10 Dec 2024 01:07:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Julius Werner <jwerner@chromium.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: errata: Add QCOM_KRYO_5XX_GOLD to the
 spectre_bhb_k24_list
Message-ID: <l5rqbbxn6hktlcxooolkvi5n3arkht6zzhrvdjf6kis322nsup@5hsrak4cgteq>
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.5.I41e227ed809ea607114027209b57d02dc0e98384@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209094310.5.I41e227ed809ea607114027209b57d02dc0e98384@changeid>

On Mon, Dec 09, 2024 at 09:43:15AM -0800, Douglas Anderson wrote:
> Qualcomm Kryo 500-series Gold cores appear to have a derivative of an
> ARM Cortex A77 in them. Since A77 needs Spectre mitigation then the
> Kyro 500-series Gold cores also should need Spectre mitigation.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Yes. I know. This patch DOESN'T COMPILE because
> MIDR_QCOM_KRYO_5XX_GOLD is not defined. That value needs to come from
> Qualcomm or from testing on hardware, which I don't have. Qualcomm
> needs to chime in to confirm that this Spectre mitigation is correct
> anyway, though. I'm including this patch so it's obvious that I think
> these cores also need the mitigation.

Kryo 5xx (SM8250) identify themselves as 0x41/0xd0d (Gold, Prime) and
0x51/0x805 (Silver)

> 
>  arch/arm64/kernel/proton-pack.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index b1881964e304..212481726f04 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -867,6 +867,7 @@ u8 spectre_bhb_loop_affected(int scope)
>  			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
>  			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>  			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
> +			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_5XX_GOLD),
>  			{},
>  		};
>  		static const struct midr_range spectre_bhb_k11_list[] = {
> -- 
> 2.47.0.338.g60cca15819-goog
> 

-- 
With best wishes
Dmitry

