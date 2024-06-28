Return-Path: <linux-kernel+bounces-233601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF191BA15
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2AB1C2266B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B2314C58C;
	Fri, 28 Jun 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="el0C4bR3"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD21494A6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563589; cv=none; b=FO9+XzRTJmC3cZhivu7r7Yg8shFYkTSzjwLnh8UJXNo3EXNIzN2V2RzMx57W0lIsFuqLHgOHe0fsfCoYOSZrdm0jCfWzVlh9QN6Xr1Piwdl619vJzx3S4Hu4ig3ACMdNkAmxl5FA4gGslr+ICbRTwvUt0rg/a//q3LI0P86Qn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563589; c=relaxed/simple;
	bh=5mm20Y/D18e3rhH9q0DzVBFAuRhcMRyS+8NV59qBtfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKBUv1d+jdu2OJhmGKveiC4u1i/VnpYkMVJBSF6+XZ5uJv2jGXGS3qpsAfh9N0e9WJtcQuTCrSPJNBsUiXH2Ph/fFvtJAs6F3wiSdwxFFzUWlLDmFoMIUhj8IoHRpi+03GG9BX0n/gIZUdzoWicw7t9IJR5qNq5FYHY591zam7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=el0C4bR3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso3109021fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719563585; x=1720168385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks4ZsEAD+yVsd8GiSq5R6Kq/PRusoPcTcDCgKL0huZk=;
        b=el0C4bR3/CEJpJ1LED3ows3RlFnrtt6t0W+S6WbSj6RZtcekCQd79nqwML9U0UQv8R
         RuxTIBTYS/HL5hfnfhKkZhDVukGcPY/5x3yx+5Qwyj5U8TJQRaErg6KDe8UNMEBFur3G
         USMmeXYPKDLl0l/YcYCnT9JfPrTemWH8DHvtKTGjghnwd+vAwC7wDTyuScJOZdk8N8uH
         zWHqQQYtmheyRsw3mU6m6+2Juy/oRPAYJyqly0uEL6OkgdAQRp2i1G2oLtsDXCjRgbRB
         gOyxtPyp4ZIc0R45tt2xjZ6vkBnPNKpswIK87SjSX8yHdnnB90yvT1inyWfuwufB4CxC
         QpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563585; x=1720168385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks4ZsEAD+yVsd8GiSq5R6Kq/PRusoPcTcDCgKL0huZk=;
        b=ONaj1AWVvfOSNmOsUFdX5imRH3vCi66xL1kyGa+/SfEZ3TKRPmmE/MfldWw2k6bub+
         mE5RQepIuyZNS1nolTLafeujFQKpswc8hBEhJ6pDJGnQ2cq7yHLzOdK+IHh4fMTTQQj5
         FdmtLNGsS6z2s1eWycwrMaeDeKE+NCfO6wRSBGXKjaWdEkPP6wTamy8FBy6oNYZKYbuj
         UlFl6y0bShf1xPExmSzFFvAT29FOX11pzr4DXtHWi4f25PGTjDkIbMUT3KLi4iRTYNjq
         +07DhjIyDjnoSoCpdZ29SZxsQoV97vjnkOxXZLfDPqy0C6Nrp1HuYO8rxl9yTxdrZ8nO
         Zv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlTZ43dE8YB+9egHWtKOBZyqI97b05A42NEOL4xplDKvwwLRXTfAIt43tufmgkZWzWzuwchCjyyWmd8CXiRumOc8oyylqlZKxsHcEM
X-Gm-Message-State: AOJu0YwZDpk+LU76R4HERu1i47jgzlymeKkEsH2Lc6S0Eckgoz/6z4Wp
	UBts44qcano9tKrk0u+69pOwr3ivGv0XsknNAATA4nCD4+dQ+7tsXx9PFkZ3Gus=
X-Google-Smtp-Source: AGHT+IGeWkgVfKjAulIjwjOJ7JAplKw19Fhr4yFgcepcShFgKVVaoXv9nId96W32Ts8FIc7Tk2NB2g==
X-Received: by 2002:a2e:780a:0:b0:2eb:df39:232b with SMTP id 38308e7fff4ca-2ec5b27ed94mr97569761fa.20.1719563585517;
        Fri, 28 Jun 2024 01:33:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5168c70bsm2063861fa.104.2024.06.28.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:33:05 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:33:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm7225-fairphone-fp4: Name the
 regulators
Message-ID: <jzwiyrswop6yy3rprndxcyalikgww3i6v34wb3g73xj2kyl2pm@7coycikxmyud>
References: <20240627-fp4-regulator-name-v1-1-66931111a006@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-fp4-regulator-name-v1-1-66931111a006@fairphone.com>

On Thu, Jun 27, 2024 at 03:15:54PM GMT, Luca Weiss wrote:
> Without explicitly specifying names for the regulators they are named
> based on the DeviceTree node name. This results in multiple regulators
> with the same name, making debug prints and regulator_summary impossible
> to reason about.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 34 +++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

