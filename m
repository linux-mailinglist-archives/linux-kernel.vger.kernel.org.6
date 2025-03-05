Return-Path: <linux-kernel+bounces-545980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367DA4F4C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4434616FE2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9E15CD4A;
	Wed,  5 Mar 2025 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlHfb1P2"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B515854F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142342; cv=none; b=Q7ejADiFebgtfPm5VbgUMq1d4+HjLi3jxSIF6hZw6LeaDdbA1hsput0QAc/YY9AjcW248GpnvbpsQ4Da+dAS7POXVveZ7pDZn58g3kgf8daKIzwLKMdeH646fYZq+vdzO5rJL09mZJWGq1um8qpxJrl/TDfyIbekIQt4ZPKk0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142342; c=relaxed/simple;
	bh=SQ76C5rbHLEvyAuhYgb5Co9/owZstZm6x8yOx43jG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv4bSAfU6J8VDzZj8EHclh8QNZBQP36YlAx75GftmrOFi6xWUJktYH+1WJFCpiCJk032VQ2w8XKZnefSAI1JvbdSuiR3xasaETpec6BkJXvge9c2f2hZbGjdWwA0641CbGSzSDrHmJ3GAaY7gcP4rj4U33dDUkSXIMWE4oNUvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlHfb1P2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bb64a4060so25262091fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741142339; x=1741747139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLGnKKW2QVH83jr7sLdLSDsyrmFRn2bnko/hsD8r/Pg=;
        b=SlHfb1P2pCA7U6vK37ufNaTFRopWHxWdF1P00AQ6/MbSz+Szm4jtA5qrnWmqw5PmM7
         0V+BNr2GDF7UM3JUeyDn180pppEeohFPpu3co9NQZx8IHKZNY334KFjwSbB6fPdUrQ8P
         t3Kcid+zofCRqp7E44UTQM5hZdJsmEzjoVamE8rrZdVU6/3bJNm1/Wur9LoscYJuDF6D
         gG4b6ZEaly0lv1QlpXO8KHlpHu6YbD/ccxdGRFIhx+kcD7LDgiAQWcJuHiwQKjIL+rDT
         QUFTILOoy0/3ziCasly9sx1TUOYp2yQbQKkeeXzI/Wm00p63939oRaw45zGyeEpsge0r
         V8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741142339; x=1741747139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLGnKKW2QVH83jr7sLdLSDsyrmFRn2bnko/hsD8r/Pg=;
        b=KkGrCeAtxUbZR8FbdB1T4/VzDziCr7oY3P2gk8UIYOQc/JaF0f4eFJqmQ+B1xth+CF
         9arwcdJqwikEfK8xSxv8qGMbfXvYDCwbA0GVp5f45GS3Yn2AKBmiYxi0VIh6itPnRrhL
         Tiu4qn4bwmC0j6vbNvvQm29SXt5y5Kll7pbUjCES4pSIsg9SZPymP4eaM+xdCnnESPo/
         vRXw4J3OawrVegOdxjEnTg/9xs7DWurCrNsNVt1kMMPLlKzr1o2tt6CDOPh1GPD6FACx
         o3RkDjFxxi4xIYgrdlwlNM7jDe3kUrArS6mkL+BeMUcnGDU3B25dUoMHEaMRJYkseayK
         w4+w==
X-Forwarded-Encrypted: i=1; AJvYcCUzNGrOZG8jUTvV2nuun1yWW4bMHPIBA+DRrA3yrAHrFkSYVlSzHT2oVaE+p83efdiVCK1rIqOePCYIX8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalWj4JWdjqtsEVIezKTZgLwrHiXW5+oQHVQARXsOSrUXvg++q
	VVYkrMUW9yCiSmdMkgqKiMgLM7p9RmIigF8bbbWS9RE+Vh9BFctmKE7lkKXKKqw=
X-Gm-Gg: ASbGnctLmKF/3ftl9zVcds/n6g0UBhZPnUjKSoCayhD+N7RAHsHBVgcr6JbxVj4RYfr
	NHKXNw30mVMLuzRTucxlq9D680QWoNkL3deUsaU/9kIJLPA4Y1GTwQeB3A/IjcJTieeZCzWhZ+4
	kEGdMd9R+FqO2S2Ngqgr64WNlPPPHSGvgSwClDpsYnuXdfCTvyAO3lJOT0+sGJ1+GStN2dKrhWs
	O7X37Dus2VervtFKBVNAJqNjYUK3IFTR/DABGyuDG8fW5TLlGP6csfEYYU7Qnzwi6MXZiYpXyMk
	vG7v91X1rCfyp5p54MGBETFk+VZSvGg2JRRMWVNW/s0zeChmPal5Avedk615xEbq6qUwWxYpzeE
	MjEO0Cmh0pwofRSIN5FwUAs1o
X-Google-Smtp-Source: AGHT+IFcXeQaKKWQj1dnu4UH8WH8BgBFKYFWB8PfbtIdp7r23eOpCjIksDm9zsbkHWStqwV0YfIVwg==
X-Received: by 2002:a2e:be10:0:b0:308:e5e8:9d4c with SMTP id 38308e7fff4ca-30bd7af5da7mr4043671fa.28.1741142339042;
        Tue, 04 Mar 2025 18:38:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bc7264141sm5553261fa.13.2025.03.04.18.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:38:57 -0800 (PST)
Date: Wed, 5 Mar 2025 04:38:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/9] phy: qcom: Update description for QCOM based
 eUSB2 repeater
Message-ID: <6e742b2dke3pcqq3v6nzs3gfvwau4sk4gtadzgca2zk5merzvi@ubc6l3hsafok>
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-5-a698a2e68e06@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-sm8750_usb_master-v2-5-a698a2e68e06@quicinc.com>

On Tue, Mar 04, 2025 at 01:56:38PM -0800, Melody Olvera wrote:
> From: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> The eUSB2 repeater that exists in the QCOM PMICs are utilized for several
> different eUSB2 PHY vendors, such as M31 or Synopsys.  Hence, the wording
> needs to be updated to remove associations to a specific vendor.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/phy/qualcomm/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

