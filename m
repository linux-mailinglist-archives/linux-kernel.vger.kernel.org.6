Return-Path: <linux-kernel+bounces-535542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DFFA4744C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955E1188244E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D81917FB;
	Thu, 27 Feb 2025 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2GY7uxD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0E188006
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630039; cv=none; b=RQ6ZWwsem487uh+ZjlYN23sA/iPRRK2CjuodkmgV7X0dbmRrGJC/LJUVrGdVqVDk0JsNPyg79CbQ0Q9bZEYzP3mIaVDvfCwSfGgkNReubjZBem7UrjuIrL4eLbKg1j2xrKy3reb1r/wOB3RhZHdMsKQ5O9Nk+vtAEw4kx9Som8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630039; c=relaxed/simple;
	bh=D1qPXpKSXGu0P/skKJ8CN57rt1WpnhY+LrH45X3vgoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJjV78saVBm9h3+eos1o0U7mSTC+GtZO6+U9pr8//skskjyysMXqdlCXyj6oMZzczT8sQJnkPNi167+ss2i7q8iVuYy19wSv+yzYu6b9WdQUuEWFogNEl4HmWg16Gf6q1zNcvCNNV88Cy5+iEsDUSMhhvvkquNt1dACfcMfO33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2GY7uxD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso520385e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740630036; x=1741234836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8u23IlmQo/koZdDGMXILeSJTNSguPrHqDNPpEEp+yE=;
        b=l2GY7uxDTYGSdPLCjCZocnRFmMU5D291UyK1PEYdb1r3bWiR0WQ7NpljWZqGMYOnx+
         Ndz+MM7EoeU4CX5kCI7DxLBfITHtZIWYS3AK37bPW6DTObnYr3zhqsOOosAV9bgite2K
         0JFF33A7YhiSo3KNNgnSYSkikk5MlN/nFjQBFzTP3z92HzYXTrQpDaddTtOyvrixT8Re
         HVTCaszn5gmIaXWjf0JhJodgz2zyfm+3h5LYTWToFHzk/ljHRLbF4UJrxy4cdHYPUn4M
         bF2WxDeZlzkQ8QDJuhkKba3kJ8tPMcqkLIDHuT2rXK9J7uTgkkWLN/tlrKh1HYsHJIFc
         9I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740630036; x=1741234836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8u23IlmQo/koZdDGMXILeSJTNSguPrHqDNPpEEp+yE=;
        b=HSCgv6PN3SFTV6b6/9EJUg2r88vBWvx2fzWgg8/thfsGh1AC3yYNL+5yKAfyPJnaAW
         n9pifD8gd4Zrr5i5EEHhjW/xi0wjqoOs7DGfkmertYALo7ZBI7qr16ghRmuzj13h64wR
         GGXI+pFdOusXM3HJ2oV120eBWTvBwoHd52qoSFagX6m6UeUlsB6kqlsLUURq6EbujYXc
         /KyGrw6M3HojQMtNH0fCE8xgjzE5mK2uivlCjgPmw1DbEcrlA27HJl66H0slBZuWz4JA
         gRPPlRivxdL4iuDNeqggdn2eg+8l6sxdRFim3kNCzEWmf0u/27+aeTQwXp3Qko/nRvlK
         g+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWQRoCLOeXYUS4HV0bOMue59QHdBeyRfr6PPoa0+eOJug32BU757ZwtmfZWxFdrpuAWb2pH0Ub96ZiCY9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNsc70JVylfBg1RPCxzFK46f0y8ZKr6WS48Imd6wDYY45F8BA
	Thz8mGqA7hLX6YwidrVFqW3UObUimdVlZhiOBNX5uPC9Vh7ZIJ+hSk8CrLzTMT8=
X-Gm-Gg: ASbGncsutXw84WjoLPq5ZT50lASYcRNOtfM0N8Bo2iPA0Ea8sQHkVPfZhmmFkGEFptq
	1bgYj4uWi0LA4RLLOHIZ4mOtYHO2JtzQd5kbpHKjQpjS+fdPMBf36AGpT5vRZNx0l0S/x0ZIj4j
	F6lATVIlxEZ3OgaEbCFXYf8PYV29X5jqKWrwmRuQvlsKKm1IAEAdolLX31vubTUmGtCjdyV2+ZQ
	s/8w45YtWo4B7bT/3slolEKi1t2K/4FVtKcuRvnKvOS/AugfErwpkzGzdsddFgp27aDs/mSM1Hr
	D7K0cHEeZoUpLjOwdASIBO1YLZMeZaNaGdPDxgJunwyeXiqMvbiH+oABdaxTZFzASyE6FhSgVMR
	sa6GvAA==
X-Google-Smtp-Source: AGHT+IGmU3ylt4nfxdW8+V50WKqSc6Rh6GtYKcalxG8gKf1aJ0RkCuq7iwjbHF3whqn1Nc8rCjt6iw==
X-Received: by 2002:a05:6512:234b:b0:545:27b1:156 with SMTP id 2adb3069b0e04-54838ee91b3mr11320521e87.22.1740630035977;
        Wed, 26 Feb 2025 20:20:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cc9d3sm61249e87.224.2025.02.26.20.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:20:34 -0800 (PST)
Date: Thu, 27 Feb 2025 06:20:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Update protected clocks
 list
Message-ID: <o53nnmt5ypuoms3b37lehtmpwloudusr7647alehvnwsiltsyo@grd6ua7mh4o2>
References: <20250206-protected_clock_qcm6490-v1-1-5923e8c47ab5@quicinc.com>
 <j43f4wu6wgoho2tl4crckemnngyvek5mma6ghkdyqcivk65dcf@gfsimovfuqy5>
 <72cc2c52-1d0d-4a60-93da-14acd5947f1f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cc2c52-1d0d-4a60-93da-14acd5947f1f@quicinc.com>

On Thu, Feb 27, 2025 at 09:42:39AM +0530, Taniya Das wrote:
> 
> 
> On 2/26/2025 10:12 AM, Bjorn Andersson wrote:
> > On Thu, Feb 06, 2025 at 03:43:21PM +0530, Taniya Das wrote:
> >> Certain clocks are not accessible on QCM6490-IDP board,
> >> thus mark them as protected.
> >>
> >> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> >> ---
> >> Mark few clocks as protected on IDP of QCM6490.
> >>
> >> This patchset is separated out from the series[1] to remove dependency from
> >> the LPASS reset.
> >> [1]: https://lore.kernel.org/all/20240816-qcm6490-lpass-reset-v1-0-a11f33cad3c5@quicinc.com/
> >> ---
> >>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 21 +++++++++++++++++++++
> > 
> > I merged the patch adding this board in November 2023, are you saying
> > that for the last 15 months no one has actually booted it!?
> > 
> 
> I am not sure, I had got request to help boot the board which was not
> due to these clocks.

So, was the original submission in November 2023 broken or was it broken
by a later firmware upgrade which started to protect those clocks?

-- 
With best wishes
Dmitry

