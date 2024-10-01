Return-Path: <linux-kernel+bounces-345568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF5498B793
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050EA1F25AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6419D096;
	Tue,  1 Oct 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2tOZD6/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC619D089
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772673; cv=none; b=I9sfFY/tphxTKu8vO5PAa1zwPJDPpgkno6oopHMDIfxNLOzWyrk4r5ICuDA7t+yqiZNd4NqxblGmKSAATuusol02l/Mexx70oBGVpGQxBL+BOmp4p45imPMNyNdF5hEEsTzJSu4/dmPjWIhERPVlHfNV54Mswk6GHSMS45q4cF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772673; c=relaxed/simple;
	bh=rvq0jjtSeXp6memC+hL47Wgc3u62FSCpJtOGWn6ptDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSRRDHKXLYltc3Ccr7R4OONqQzLY/sFjg+7FKpVXxkD69exndBoRqIGQijvSYqtJbhV4XbwuG/NtgzNJT2cPMVYFcTGze7DTal7wip4heW3V4E5yub4Pgr/v0jpZmgQ3NIgZPTHGrc7P7qUwMfZDO1ud5VCaf5a/IucIrdH6p8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2tOZD6/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7179069d029so3784999b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727772671; x=1728377471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T33uUeB7DNOOLKHqcQQSNjPbvyI7kdL3R1vLdSkp1S0=;
        b=J2tOZD6/NHWwqbYxZ0MzAzhGv/flSDro1qgJEvJbkRtSfZ/jn99bOV805biPCD1iY+
         joqoI21pEVMDOuBGBi8H3V0FrGx2ptbTXIgSu0GaBeUgM8q3tMynmDZA46xUsldc6N8L
         abKDRCLTmzlUlIMxXPMeuR/HXBKIEXmJrHGRQT6I/d9rd1CD2Ce//IxCLG6dBBslV4yB
         2RlezwkTMuE08BYsOr2T/PE1NBP1avA80dWpUOkpskshlkk69vGYmnl949+zZOjeGbFh
         IEzt+kc14F8aRAX9LcTfy9aaenGrycjRwnOrkf/6gjCNlv8XGl1YdWhO7ByJpOPvXyRd
         OXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772671; x=1728377471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T33uUeB7DNOOLKHqcQQSNjPbvyI7kdL3R1vLdSkp1S0=;
        b=pYVzmXsZTrRm0Gn14N0a7ChaEw85oJXErEEohkr6n1Kb716r4kWbANEhI3FdT5y6Sm
         wcJ3DP/GwI83/7Z6WtwrtTpMi3ldf4n2MiorHLn+DtPqYr96zAgWPoQnrIP7IJKNC3lV
         ZA7tVtv8rEsyGXFPrYl/b8qDmGPkX6en7Kqwpd/95kPoAH/JBqP7ej9Sjnw3LboMPGYP
         1qPJ9KkTjqSVWRXFWYe8IEC7d1vITqUQRTeceY8ipV7PfXiHPqOSHCyDa3kdCGfgQN7i
         mAj9XdEFv+NKtWGS+zf7/wGIDAAT4UIE0CT6bsS65apba9DGuy7fgI1AZdw7riLjUe3K
         5z2w==
X-Forwarded-Encrypted: i=1; AJvYcCWgmZ0k3Fis8Z4zyqGvkn1fJqxKWl6o4PZxuGTirVvVfJsT84izoDnw7JIdCVCV0nNmaNW9FMO6A6zWkdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIcRcsuQtuWVEhs5wLaN3ZTGm2WyP5HqbJg/izWToFax0c63c
	1GPSZMj1Ls0CZp/tMGYcR93AzfHe+T8zF+ln4vXzPHA/iwhyK/csLJU+ROn+3Q==
X-Google-Smtp-Source: AGHT+IHmuCbCebubZdr7M8xU2lElWO48YfR8hemV4Nj08qcFiBJIN9/yuxY2PqUtwZjWMj9SXKl//g==
X-Received: by 2002:a05:6a00:b50:b0:714:160e:8f5f with SMTP id d2e1a72fcca58-71b25f39a66mr21477216b3a.11.1727772670928;
        Tue, 01 Oct 2024 01:51:10 -0700 (PDT)
Received: from thinkpad ([36.255.17.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264ba53esm7551388b3a.56.2024.10.01.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:51:10 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:21:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>, konradybcio@kernel.org,
	krzk+dt@kernel.org, robh+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	abel.vesa@linaro.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for
 Windows
Message-ID: <20241001085105.iglzp3art5ysli2d@thinkpad>
References: <20240911073337.90577-1-quic_sibis@quicinc.com>
 <20240911073337.90577-3-quic_sibis@quicinc.com>
 <pt4wtycddqhcvw2iblaojmzsdggmlafft4vu6lg5j2vstbhbqj@acenyi5k3yeq>
 <eqy4yicgeqlgaytgzybnitvbrdr7jmjjk5k2swmadad6scwk77@ubaf7a2kgmdm>
 <1BBC34CC-92D9-4F6E-8DFA-1F2DA36D545A@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1BBC34CC-92D9-4F6E-8DFA-1F2DA36D545A@linaro.org>

On Tue, Oct 01, 2024 at 09:56:30AM +0300, Dmitry Baryshkov wrote:
> On October 1, 2024 5:42:35 AM GMT+03:00, Bjorn Andersson <andersson@kernel.org> wrote:
> >On Wed, Sep 11, 2024 at 10:55:05AM GMT, Dmitry Baryshkov wrote:
> >> On Wed, Sep 11, 2024 at 01:03:37PM GMT, Sibi Sankar wrote:
> >[..]
> >> > diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> >[..]
> >> > +
> >> > +&pcie5 {
> >> > +	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> >> > +	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> >> > +
> >> > +	vddpe-3v3-supply = <&vreg_wwan>;
> >> 
> >> Please use pwrseq instead.
> >> 
> >
> >What benefit is there to wrap a single 3.3V regulator in pwrseq driver?
> 
> First of all, is it really just a 3.3V? Second, is it actually powering up the host controller (as expressed in the device tree? Is it a power supply to the slot (in this case, I think, it should be expressed differently)? Or is it a power supply to the card itself?
> 

Yeah, we should get into the details here. We were not paying attention till
now, but with the advent of pwrseq, we should describe the power supply properly
in DT.

Here I believe the supply is to the PCIe Mini Card connector where a modem is
connected. In that case, 3.3v supply should be connected to 3.3Vaux of the
connector and we should have a generic pwrseq driver for the mini cards.

Sibi, please verify the above in schematics.

- Mani
-- 
மணிவண்ணன் சதாசிவம்

