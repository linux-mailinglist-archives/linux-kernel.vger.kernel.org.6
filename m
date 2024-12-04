Return-Path: <linux-kernel+bounces-432215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB69E47BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB331880206
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7401C3BFC;
	Wed,  4 Dec 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmxe6/43"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E641C3C04
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350871; cv=none; b=r+OT2xwFMoYgFJNc3SnxsPkHuYsiuZ7ua2+iIkyKZ66zfw4JWMGofyF3emmaxytgazEt1jlXcO5mnA5x/yLPm95BCCmOLc8CzQcTAeFA95P+lYlIN5QEuoxXtRHVOmpzS7x03MtA1l+SGotqoGP/wIsBUpOhBgeHa4yUeZjUUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350871; c=relaxed/simple;
	bh=1XfksjHiUmLDBwfWEVhZRw6suaxhtKcDRmMSFnlRbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL29CWStRDyT25mJ5Q1uGQaDmINdChwdyVBjatJf3vcwci+2fhJP8tKyYbH/07g8U6NHgdDMJMMedCY/59jIqWKVn+TBivNfvNKP0OfIJaDbR95tEUPoJp+T4CsM9iejktIGIWtdK8OE0TEOJ+32yX+IK0pTYXrJhMXWmqKH4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dmxe6/43; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so2349251fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733350868; x=1733955668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OH4y0lMP3bH1lveKpeX+aBwZ95mtO7UpbBtdFwlO2l8=;
        b=dmxe6/43c5nCrEDsG3SuGqFFn2sZ5xxLPNi64hW6yfrIbDLs7Mmwrz+Qocjc1aNx+e
         zKfk5JCTscvALQor1UUfbV71YrNF0Dm3KTlpQrjtV2iAMX7KwuodapleVx0PDMbiSAmh
         WEw72zL+NiJ1AXsd5PSCyElTaN2JLQbhEv8TcmwE8GuixEK8c4b+bsYpCI2YB2A0snOx
         6u7ouy14GrUisYNRT5QGnVMFGdtL2DKWS3G+AFJTWlDDwRXFZcTVb+2PxIq/ID5pxsDx
         zPSmFXeG0E4XZa4bBZvkSiNRr+bJ/IOhBEPl8c2z/SFxAiDTmiIbBjt1MBq6XbNumeAe
         fBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350868; x=1733955668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH4y0lMP3bH1lveKpeX+aBwZ95mtO7UpbBtdFwlO2l8=;
        b=eG0fPpAC3FKsOQhRlGescaWLru0gSQXoENUTtXy/g1R9bwzcuYjeP5v8UIRNhmLEco
         zPMgm8bptz+bWz7X39qYHtHRwbAhDTYgWasQuVg6n+mI1grC9Ji0hnAfrxLmWsUDVLDR
         qgoriVqBGNBJs3XXvTPZI1RXORHCR48xi0LSZDcRiaZFH/YIdHNlaGUNCH83YRArzx8O
         n87/1uFQMelm4WGOJiqx1IoJxTpjsO/f3i2T4+tkLvu1aLkY/bF/8Fc2BLL5LMNe2Kdd
         jYbecNgCdIGufNakG0//ITng+RDyFbi+IEZSfKC1+twu20vjhc/MsLVRVQiHN1G+pWx1
         04Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXVA3iURRF1+idUGknKV4K+s69YSYm6gIUqfR4aiXp+RBqbcaqSkbBcKCbPj+u//RBL0Wh4IMROLgDbbnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/PPg7b4wagckalgj7mM2AvDyXLVze46dbC90Sb3ygcjOi31i
	9mwVlEBZ1/dYqs2LbduZ42/tMA9wVot3/Semcq3og/zEPHaqQg7dUlTFb1qYu2o=
X-Gm-Gg: ASbGncuLAXGj05AmipcG7d5HOhHjXCaX2xxhGHOWRzR/YV/iCJO8GOgzC+28G64gPbh
	VMrMYo3ElEDPzY/RCsvAe1mlYGPfc0ADcbOVjF7UPftAexVczKVbK4Kn5HR4JG7TvDKqXzznNo0
	ZKGZRKlT3gHrJe3aS+JHYYYb9jAFFJdcMEXvGToq3LwB5k4NYKSjy3QW0A7XuKYoMrXX4LL7Yzv
	fDwuPH+DP5c9wI+wJKYOG2iLRP1JIsQ+pRN648L9JM8uJ+AmiMrhjHxzSJ6E017lsHlhhxJJTZ4
	XP+hN1RrL93kVK9u/V0N8vR7RxM+Zg==
X-Google-Smtp-Source: AGHT+IFQNKupoOz5B2N+8vVrOXLHYn4xv4Wtyf/8DA/aT70hkUWOnF+im9j6wqbTorBqmEkgbKr9BA==
X-Received: by 2002:a2e:a904:0:b0:2fa:cac0:2a14 with SMTP id 38308e7fff4ca-30009c30156mr45544571fa.11.1733350868075;
        Wed, 04 Dec 2024 14:21:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e20aa9sm23431fa.80.2024.12.04.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:21:06 -0800 (PST)
Date: Thu, 5 Dec 2024 00:21:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
Message-ID: <snccv4rebzwolmqknc2jm6nkfxchi3hm2vauxnneefsisc3xwe@slfyaiss2vat>
References: <20241204-sm8750_master_interconnects-v3-0-3d9aad4200e9@quicinc.com>
 <20241204-sm8750_master_interconnects-v3-2-3d9aad4200e9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-sm8750_master_interconnects-v3-2-3d9aad4200e9@quicinc.com>

On Wed, Dec 04, 2024 at 01:26:06PM -0800, Melody Olvera wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> Introduce SM8750 interconnect provider driver using the interconnect
> framework.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm8750.c | 1705 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1716 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

