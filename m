Return-Path: <linux-kernel+bounces-417327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537B9D5294
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C016328108D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BE7F477;
	Thu, 21 Nov 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtAvh/zq"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C526F06B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213941; cv=none; b=O4jl8t0kLav5jUH07l+SxYgAlq/ZVAOnlst4YIXqTLJNY/p61E1SHKBkYOu/aSbZ1M3arvyt5828IGhpC4tXecOfpQlj/tdbWVrnFigzxghOMBGXgnQd0phNoWBMUvmHo/ES9dKQZG6tbxW76nCw1G6csy06ut7wbrQVVvqmssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213941; c=relaxed/simple;
	bh=NxoNhqN7/s5UCLJhRwnlQc5AL67LK0A9EbK6QoZWtGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDZ6hBp0YRzEy61SzMiCWxGv5Sb2qsASlmaztBZESLyX6puZlc15rwmD0T/+LNwLVvSX1iqZteu4pJ2zksvC1/wrFLLwya+UYnf1dXR9ODWv5kOUaLY2zlMNPnIn4sq7q/xCEy4in1WbYXI5BvZWZjTOj0/M1xRBLhQQ+UBqVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtAvh/zq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb518014b9so11576671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732213938; x=1732818738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YR6bunkgbvINXjPaA3POQemx6H3ADSr2/yDH9XACR0=;
        b=MtAvh/zqiMK9xbyH573mWvVr4JTnprBhRRFLeSnzBAB82CQgGtIdzrjI5ayDtXKH0K
         y3x6+vWsUph2H/+dbfdWwalioy4JSAdEFvcaBMTOTf591i2c2fod7BWS0YqlQgPiIm3S
         qDZquELaAtlCad+vpEFBETVFieWKxJPnBIydDB5POk3ByMm0bO70pomPXe3lp2f0dDxV
         Z0iW+vi1wHoZ2+RQHIrdeHhf66/aKHst1qPtC4t3o1ahmv6efaAvP7KKBCnKQkKpgEsx
         d886u8vrFI+zM7BsNN1PIZKBZYyxvLlbH/mZyX2psissjP6eVWQm/DzKvcD8Ex9U/72l
         SFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732213938; x=1732818738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YR6bunkgbvINXjPaA3POQemx6H3ADSr2/yDH9XACR0=;
        b=MUiNx7DSLOdeq7Z4NqC3Rmf/0LxxOXU6jaGNDwbM2FYEq2WKA5gdI3qJFQVE8QicK1
         TPoJvMekgPQtOJyTwXa0Mpofv13/m3F5JfTUPCeDn5sWJb8YpzejnOpj3HZUhTD5aQJV
         E/WAcozPVTSd6exbFKsXchRxodZ1dCUq7hD70qbqj/FOX5It4UwJ50vo3sM7EzBlyKKP
         yxwxAUlLehWrocWObjGo5vv8i3+Za5W2/z82UkMDqzjmALKi0xO4t5EVyStFpp7BjM7d
         xRtCJru+h3QEyjVJxcqBc396mgRuQ90+uzVFbuAnLfJh08rpGmQubkSlTs2rvbAXpDCb
         J8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdy5LUwvb87VHRvx2+5f5yaGzT8Dba/SDt8gNyJzFQ3Et3vfapu3UWYomX3BzOYe9dCF0i822qrfEvKNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZJbD5VX4aRrkKB8ivGGndQKgUjiVGEgWSbbyfIdy3Gsan0dq
	onyelDaRRe6mRSFg3LYmMU87/TrmLucCTZRFN8K+X1zqBC2Re+T4fhPKBnbjUfc=
X-Gm-Gg: ASbGnctqO72IIcaASykq1vf6//6RE0oDkOrfKd0QV9y39shQouArF5mKMkrXDtOON3V
	JSCTe2hdBjQgBL6z35tF/+zWNzy69iNZpnIpN4usBf9msX7rVBQlRokTitYsShsfoTkOQtWbdWh
	BcmH6x1E3UQ0yDn7fPfXDVZHfX8oifl2mwgaKUhcNnXgeMwiqLz/3acDrwNdGJG8wOs2rAg2p91
	IcqDrQz9I7P9csJICkqe7XLIPZLfwSCmBJdMLXozuIM33AiJqXMlYkG9nEaWn23GjIdaokNY5Tf
	QZ0QmVEBhvd3NTF0nUjJLvWMfLmk7g==
X-Google-Smtp-Source: AGHT+IFCTWJ72tvI1EYO6Sxeh0nyQQvqWPBwgJgPQ0V5L1GVWbKh7Z5LWaJvnlK5PXvdh7Kz0Y69uA==
X-Received: by 2002:a05:651c:547:b0:2ff:a3c0:a878 with SMTP id 38308e7fff4ca-2ffa3c0aa4emr6655951fa.4.1732213938371;
        Thu, 21 Nov 2024 10:32:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d57be7sm143411fa.62.2024.11.21.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:32:17 -0800 (PST)
Date: Thu, 21 Nov 2024 20:32:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, conor@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] soc: qcom: llcc: Update configuration data for
 IPQ5424
Message-ID: <y52pqmnj2bftfkoz5txmsl7wzjpfv3t7x5mtvrucupdubioxdl@dcflltnxnpdm>
References: <20241121051935.1055222-1-quic_varada@quicinc.com>
 <20241121051935.1055222-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121051935.1055222-3-quic_varada@quicinc.com>

On Thu, Nov 21, 2024 at 10:49:34AM +0530, Varadarajan Narayanan wrote:
> The 'broadcast' register space is present only in chipsets that
> have multiple instances of LLCC IP. Since IPQ5424 has only one
> instance, both the LLCC and LLCC_BROADCAST points to the same
> register space.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Fix ipq5424-llcc placement according to the sort order
> 
> v3: Rebase to ToT
>     Remove 'need_llcc_cfg = true'
> 
> v2: Use 'true/false' instead of '1/0' for boolean variables.
>     Add 'no_broadcast_register' to qcom_llcc_config structure
>     to identify SoC without LLCC_BROADCAST register space instead
>     of using 'num_banks'.
> ---
>  drivers/soc/qcom/llcc-qcom.c | 57 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

