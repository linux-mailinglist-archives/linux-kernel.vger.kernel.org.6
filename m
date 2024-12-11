Return-Path: <linux-kernel+bounces-441084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5C9EC933
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6099188ADBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0821A83E1;
	Wed, 11 Dec 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haC/g3zt"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347D8634E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909695; cv=none; b=Yez9Qx8ad+d+tVlYChH9HZ9MjGOOvyjd/hFf1lc0gjpCDyB5/cK8PIZIZwkukkrnTBRjt4RGCK/6PFLjo0W1sVGbNL9py7k5ROS+Z6+t0lx0uV0DYa18bFmwcn9GZ7GbpDsMBSAvoxHdaqAR7B2aGrMobO//3NMH4+ZIucBr2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909695; c=relaxed/simple;
	bh=H5mXvbU0KXgZqtkfo2Z05aVUMmoMZboGKCvt69cfWdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqsXI5dqnkW8qtNLPYkPUmyrypfVsWC9MvXKoZihf2RTgNpHsP7iFqwshsy1zZnNnLs9uqQGf5ql9N9ExdyvlCgTA+Qe4KU3EyEjbuGjjtjv8I0ajb5F0Y3j6cKczwZnK2yyMLXgRzIH3/aUPfB0cnZGHZCNYjRj8B/5HLYL13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haC/g3zt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724d23df764so5918966b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733909693; x=1734514493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cgqV/JO6oR6aFw7Aik89l/GQyuFFq78Hr5VL5rEr7CM=;
        b=haC/g3ztJM7g9KcDgNrzfFHoObTbDiYNu73sOtQXB84/2JOh2N853NmVnwD8k5fKQU
         5+8zUKwinmB2VQMtg9MndlpKpasPiuSzNalWF2xBXocQC3m8nMbTHNvT/AstxYIbA4Av
         CiKYa8ypVIzel1WCpvBHohPzITRNJpBRPjHgeXvlS/1WnLmSQ/HjoISvFhRIonKmvHMZ
         l8r1lqYJOB3qnTuUjIVybssfbGJ4TqbJ3NuUGEOoxiSZA3CP9KW2zC/TK1PEGL3/jMjS
         QxMFkDYHPPZFzyfn/7hMLWQNERkkrOL7f8KAlbIyq5UGOvPusLVF5ZndetlPIrx904Hz
         u6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733909693; x=1734514493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgqV/JO6oR6aFw7Aik89l/GQyuFFq78Hr5VL5rEr7CM=;
        b=ul1w77u7WCd5vw9D3Q1fPT1JKsKnBDAVehIhcUne2hgm+HVocBZPHQKydwkscjuizj
         +mBxnyC4FAPS84CZyoF7gDIKojxCZja57GTdTzxDOga96Z/uH4s+RybVyn8ruX3BQIjm
         deyLPDgyUn1vxrsi/82PbxsQo1N6dBPV0Q/QyWQpyiRMagYC20hGmFzDA20et7On+HuI
         cJRDa25vaT0cl+w5ksT3C2MdCrDAsZhHV+hwNko9OpnN6+qd632ATfq9kvjBjJG+W9ya
         HCfDVQ3quzTMpiEg/nkkWvCtfSZ/t+UG3vxxARtDP5PrZCqpyxfhjH4xdeRNGM2fBLwd
         /edA==
X-Forwarded-Encrypted: i=1; AJvYcCWr4UK73ZzMILaR6pYAi08WLssoD+eV/Ljaw5DnG2DEH8Hx0vZqQjGAF5s3nNfCUEwYrPsnlY1Ile29qZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbB61rHDG9Xi8KMuZjuVdNn2GctjbIqUSrFYUd1kBv0yUa6cr2
	rkXvpcj30HIQWazcYP/HApKZ/PHVFZqgWfGdgRtddAssdGIGoAc1xeZV4YUY6g==
X-Gm-Gg: ASbGncs0g7BEUrAD7udhgfvkjcP2ayTafsYO4PBdTM+Aer8UK8V1mSKaat/cYwaCuXj
	oxRhKrDrBTeffMDSSZIhV2KyFFpeIGIWL/SjnyUGJhGh9uVNw6Sys15bM4SHHH3mhbK2sv5jkMG
	XkFQE/Is9BoAI0LO69DyC/AJQUhqajQq6FkgXVmxKRUaNuvQijDzHyj1y1jrLfAj8letL7ZvMM7
	E6NEHpsCakqF+qL9lZJyyTYEIAZMEjNjdxgRu8Ja87C1z69i6pv7YiTpVStXnU=
X-Google-Smtp-Source: AGHT+IH07+qa/4yb9DxmiZHmFWco0nSmlHI3Wipl6jd6BWnIU+MGk8r8cehLwq5q837AcEZzgzZO4A==
X-Received: by 2002:a05:6a20:cf83:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e1c12df490mr3814479637.21.1733909692958;
        Wed, 11 Dec 2024 01:34:52 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fdde228459sm2593605a12.40.2024.12.11.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:34:52 -0800 (PST)
Date: Wed, 11 Dec 2024 15:04:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v2 4/6] pci: qcom: Add support for IPQ5332
Message-ID: <20241211093445.ykmr23zameie7si5@thinkpad>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204113329.3195627-5-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:27PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> The Qualcomm IPQ5332 PCIe controller instances are based on
> SNPS core 5.90a with Gen3 Single-lane and Dual-lane support.
> The Qualcomm IP can be handled by the 2.9.0 ops, hence using
> that for IPQ5332.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

As Krzysztof mentioned in bindings patch, you can use fallbacks to avoid driver
changes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

