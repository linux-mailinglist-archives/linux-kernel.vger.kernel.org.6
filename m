Return-Path: <linux-kernel+bounces-339120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2879598608B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22121F25D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7E1AC451;
	Wed, 25 Sep 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGr41tm3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AC41AC433
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269735; cv=none; b=tMnERluUJSRj76W4ST+U2px3+jecq2Zd7IYd/NRZVlR0tDCFlTioUOD4hY4F6d0BXmy6L7iElv24aq7GKfjLxzSBavFbDE6kM8wAxNq2k7UixU7fcAkPnoQkbj86D/crqQn5FZfRdRRpDeLHJITfJkPBtrl/uYF4NWDXMfHnxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269735; c=relaxed/simple;
	bh=WR5AnzJF93Qx9LVa6e4GL1bUJ/gZyTq7uc9OMyhdOFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPWqTMoSRbKsbqIqJrUTD5VmaX5g7oc4ZdEPF0ILq0ZD8j+1T+ophSbRbOzWGa/CLuTudFo8cFR3nJSNJ4VvRzNhmm2sHZrM3Nslt+qXnr0KxmPDXrJI0BV1vbDYeej++A9UX0KqFF9rGfK2zgsU57ROlR79CY8j0Hu4oNs/jhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGr41tm3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365c512b00so1525591e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727269732; x=1727874532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfIe+0A9/iwZ9+ASBT3gHE6aur04dE6S65bt24Jbj2A=;
        b=QGr41tm36dzqyVeTbv90aKDJ+Vv+51ygVKoY5PPZNEKFrEelKv2w9e67Bu7Z83diPI
         1B9xYoJaHzSSmnfDr6nGMgQadeog+YKlS2rXeV+OpCkpAwTUP6eZJPOrIzi/ZC4bH5lh
         q3uBzQ8eMBLLd+ohjNIqTrpRP3HYyZ2xCagTQrfmmnOfE7KmVRInuycVHL/cdYrJe4Ov
         eQkx+lcZF41ZJBpR3QBLUIRE9xcVYzZ52MfkM4BzMHcqFQTPFLgSxpC8y7jZ6kGfksu9
         JhEe3r7yKYNTxEoQTKEaU4SF+iPNNZQZU2RfXuy94gVbQNUka2C9utTuCfImtWPDs0JK
         97Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269732; x=1727874532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfIe+0A9/iwZ9+ASBT3gHE6aur04dE6S65bt24Jbj2A=;
        b=UokuGMYNKUKfImQQGl4BOUxP9nZmEf5hponWDPZDpKbnf1VjFqdE5hyIPKgDvgwktU
         bVeRfSfCsoqfyafIfZFnZyHV1Ryt/PLIiq9MVipiqW1GRT6PJr+uv3LXT+MHRvRcC0WN
         WlwD34qowSAfbV5HK2CIzlfTBHyBSjqrVIPp21gDZQmk+yYqYDJXzvtTcWLyYht/YPUc
         9voD4Jl5xjzGOesBjv5K90cZohuFMtwxkiEk37WN15vMiT/awwerM/Ml9vpjrVH+MpWU
         LeeZJHSrz9vk4jGpOVaNWYEeDgmwOU3wit6qny08ZUC2YFCwq4IOH4K/KBqTqTURt2st
         90cA==
X-Forwarded-Encrypted: i=1; AJvYcCVvp5fEzQbhvm9CgARVaxhkVJ7SpdOVelBJ65yyJ9xICpmgVfLjx2e+eLPpEAyE7l7qJ5MLrahY9hAs9H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCLyvTGaDFU6bJ4iKkMLq1UjdKWloAsidXXkogMShITfaTcMn
	PIAE9bUhOOD2QOfItr203I4XGY1ms8nydYRBVItsvGRAIoMgDGL7QoxNQEK733Y=
X-Google-Smtp-Source: AGHT+IGDlc38qNmQApA7G1CZmAUwKPhj6Dzr+UVWgNKV7XNIVs+fN9df6yglg61dDNAhSR3WZLlEBw==
X-Received: by 2002:a05:6512:1313:b0:536:568f:c5ed with SMTP id 2adb3069b0e04-53873455efemr1670045e87.1.1727269731620;
        Wed, 25 Sep 2024 06:08:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8640abasm519642e87.177.2024.09.25.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:08:50 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:08:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Enable wifi for
 qcs6490-rb3gen2 boards
Message-ID: <v2bgxmp6khrrxnpzgwcow6dymwzdil7yfjt7xwnq5xmgda4gor@vt3cj4jgwylu>
References: <20240925090650.26314-1-quic_bpothuno@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925090650.26314-1-quic_bpothuno@quicinc.com>

On Wed, Sep 25, 2024 at 02:36:50PM GMT, Balaji Pothunoori wrote:
> Enable the 'wifi' node for qcs6490-rb3gen2 boards.
> 
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 1 +
>  1 file changed, 1 insertion(+)


Please take a look at the mailing list ([1]) before posting.

[1] https://lore.kernel.org/linux-arm-msm/20240907-rb3g2-fixes-v1-4-eb9da98e9f80@linaro.org/

> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0d45662b8028..21bcfcdb5e46 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -792,6 +792,7 @@
>  
>  &wifi {
>  	memory-region = <&wlan_fw_mem>;
> +	status = "okay";
>  };
>  
>  /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

