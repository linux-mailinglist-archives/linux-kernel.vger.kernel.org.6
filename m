Return-Path: <linux-kernel+bounces-440816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F29EC4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A589A2850DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F91C3040;
	Wed, 11 Dec 2024 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2xr0OLS"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301042451DC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898062; cv=none; b=uqpv/kcUqYiNxIMqxOm49u2pqaJZI33GJxgNIMeE8Qk1tG0rGnU1BRiGSDSNd7pEWkS2pl9huvKs+CeffzbgsJ/TOtySmkeZBRyRojbYv67GIQt3SzhANQ6e3WAu8kZ30FnlZ8KEMB+HNM0P0GttoAEGgQaP0Jp28mH9UcMQPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898062; c=relaxed/simple;
	bh=xP/3mFAEUu5jGusceunPOkWKJ2FbuC2oApaFvMz9n7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWPaZK3HDOLGyt0HOGIoxojvtorsmu/zAnr8dZwYre44MFBDKny9ILJbQvjSBvVnSBte9HgKRTrjsv8tj8xrfhkmkrBCNtt0Q6qqJc7PkJe13PO5A3ct02PFlHl74kJ3peoCEgCzRJNrf1/tfyeX6ie1X7MjvZHLbXbklYrNu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2xr0OLS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725d9f57d90so2761032b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733898060; x=1734502860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0d5CzVXzJ7EqY/542DTDjPbVEeRALSf1iz2hJWMyrGs=;
        b=z2xr0OLSC0FDc3zS1dL4jVmtckR7p7MjYHnqbv9sGNTUE9cJGdNbxkTTCbrkGAa99U
         9OaDDRNXeWcUaGl0hEJ9XDTU1WwWNHZAF5rvYrNs9DnXAgSX1YAoUA3FBuac9c83vQfn
         ObMPRDE1go2eQTRy2qz2OrBX0EOgJ/YRSx6T9b2DzjOpVnw9X4z3WPsTtb08JaE2pQyw
         VZ1Qn6s5tRTkDszkAbw7FKog/tiqiFh9C8PGEWiHBArQIS0OyeuBQT1gWgyKHQSI3bbC
         Hw1IOWKbpZ/0rcVsL9eGxigOO9P6Lfn5LMvFWvWEWt2B4PhwII6F0BDa5iucy0cH6X4P
         ABww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898060; x=1734502860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0d5CzVXzJ7EqY/542DTDjPbVEeRALSf1iz2hJWMyrGs=;
        b=WEveYflQ48dbmKHC2SRC2zorYoAFmzOZkl+k50jCBSvZap2DxxJdqyizlJYeZEEAb/
         +dbOTpoWE21swgY8gUdCX36GOMQANlIixYl2QzbbK/iQ/GCU9pj3wd8ZoL6IK6sztT6f
         nlUT+tRbM4hOho2PUgDc0T5ab4WVxW95j/2+k+HvuWLKEcuhqVA3KhoM+WjW9tYK19PR
         QvMipoY5QsjFF+h1NC8Lglm0zRDQDKjMoFWLTc0av6C3w4t5A007kiCnsTpFnkoqQ8/u
         mQ9KvenWliKHUaeotajQHmuUjTcPHkP+ZQZtkiEmpCrcJ9Ti8DDZBMFcfKfw5K57MYQ1
         8kpg==
X-Forwarded-Encrypted: i=1; AJvYcCVADdPqMudszuzjI6JYdRgT6MtMPM9nwsTd1sRrmmmBNV5ScztEHKvU1a0rbGdJJdoBugXusZVKfUv7XOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHm23CFzrfumVwdFkzFL9eWqSODNuphnkpAIKF2+33wAXkjsl
	FRWbbMIBrYw0RpJiJtna+0gE1MwALrhgRIChYtWVmxhCOIJ0F+QlZMoJmb1IAg==
X-Gm-Gg: ASbGncuJ8NIJklsIy8XjP5XUtvcQAHRz0bsnnXgS5tn9QLDPEW3I+QLSw5joKn5VT6C
	zDioMk/dXySiuuk5RkP8nTUB/yOy0j4inuuDN5iSPeYqldKueP2AuBEzW+HRc2K+s6GS8NvQ24L
	nFrlJgxGwGTW7NoRjeGpQ07H5e/II+bOMrqVTmefQFWtqfklVk3MPywmI3V0vPHZbJIuDszF7LQ
	dcIxox56hgCJDOzZnC+Fe3ZFz9m2W+g4gB39yN9PlqWewbgd7cTrL9tXAp7y9U=
X-Google-Smtp-Source: AGHT+IFWvDNrqEB23z/oBgRJDSkzxDUqR7wA2A2btM/Mtu50Ib91aDIP/XMJYo9C7ZTzBqiKgwPjGA==
X-Received: by 2002:a05:6a20:244f:b0:1e1:bf3d:a190 with SMTP id adf61e73a8af0-1e1c13832f3mr2505278637.30.1733898060524;
        Tue, 10 Dec 2024 22:21:00 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273c7f3f1fsm3124018b3a.13.2024.12.10.22.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:20:59 -0800 (PST)
Date: Wed, 11 Dec 2024 11:50:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
	kishon@kernel.org, dmitry.baryshkov@linaro.org,
	abel.vesa@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp-pcie: add optional
 current load properties
Message-ID: <20241211062053.vxdpovlmetvyx3za@thinkpad>
References: <20241204105249.3544114-1-quic_ziyuzhan@quicinc.com>
 <20241204105249.3544114-2-quic_ziyuzhan@quicinc.com>
 <qvjtwilukxbeaxnbyzfkdsfkktm6p4yv3sgx3rbugpb6qkcbjy@rohvixslizhh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qvjtwilukxbeaxnbyzfkdsfkktm6p4yv3sgx3rbugpb6qkcbjy@rohvixslizhh>

On Thu, Dec 05, 2024 at 11:23:11AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 06:52:47PM +0800, Ziyue Zhang wrote:
> > On some platforms, the power supply for PCIe PHY is not able to provide
> > enough current when it works in LPM mode. Hence, PCIe PHY driver needs to
> > set current load to vote the regulator to HPM mode.
> > 
> > Document the current load as properties for each power supply PCIe PHY
> > required, namely vdda-phy-max-microamp, vdda-pll-max-microamp and
> > vdda-qref-max-microamp, respectively.PCIe PHY driver should parse them to
> > set appropriate current load during PHY power on.
> > 
> > This three properties are optional and not mandatory for those platforms
> > that PCIe PHY can still work with power supply.
> 
> 
> Uh uh, so the downstream comes finally!
> 
> No sorry guys, use existing regulator bindings for this.
> 

Maybe they got inspired by upstream UFS bindings?
Documentation/devicetree/bindings/ufs/ufs-common.yaml:

vcc-max-microamp
vccq-max-microamp
vccq2-max-microamp

Regulator binding only describes the min/max load for the regulators and not
consumers. What if the consumers need to set variable load per platform? Should
they hardcode the load in driver? (even so, the load should not vary for each
board).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

