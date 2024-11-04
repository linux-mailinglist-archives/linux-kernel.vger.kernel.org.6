Return-Path: <linux-kernel+bounces-394704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09519BB307
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E44B1F22319
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447581C57A5;
	Mon,  4 Nov 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmHYaZxC"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAA1D432D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718702; cv=none; b=L8eBXMe1LLUZ20d3LuSYhlOEiHGiY9FKS15jLJt4vVkiDOAo/oeTQkMWhsH8dq91p7lcpywfQdltNOG8N7pVUBfU+TiEvyoSRrQwPeIihuKkbdR0D078Yuj8hWeNsVFkp0wx/YnXtI9Q346ra2iurvAwJooXOGLSdfnyfWSY/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718702; c=relaxed/simple;
	bh=aS1RV5IccN4VjdNkh+IjN+mznBIRUHS1uP6nDzF8Z60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBU8N0Ph2EtK4J5ElV6AhYFzYiUlKyPoVw1AVp8njdEMFQYqhfuQGcosejTUrFO5O/ptIL+ZIOOoyuKG0kN/0B6TEUUtB7ED8UCY/TGfF+7Ym6vf5LjGJfkkM0jkAJVPgcmZ6Fg0XyBv+ALONy1/80a0/plOh6p5R4Z4Py4WqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FmHYaZxC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e4b7409fso3897348e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730718699; x=1731323499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXfPeWafmveGhp9XKGGoB6z88NY3VZN6ji8tXCrwgCk=;
        b=FmHYaZxC19GwamqDkdYl5Pk5ZWKkIpm13Vz7E6hmyxWHycoIKiSJ2w6XDpiBIvS2RJ
         TbfepxSXl1KnHYaRX1n57nIjeRYfnJj5jrK2DAj83lghB/Ex546vmWz5N3zIfh3C7Q7M
         JgGBUmiRqEUF4zHevu/zn4JCFab3sVvKu+WGv+q9zYzxAvTAsNq2Dy0PauUCIbCo8tIe
         sOhuhBaTkR3ygYj14RoNMLloOcWLZWqRwmvaACmViA2BFmLFApeSTlcG7XPGsJIePSCr
         sd4dIP+dQ0wy0ehXeqQl741w/KrUg5tIWYym3VozMg6fmwiJwP/3PU+RU3uOt0fJw8yN
         J7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718699; x=1731323499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXfPeWafmveGhp9XKGGoB6z88NY3VZN6ji8tXCrwgCk=;
        b=R+lIxPbPuGp2pQD2gkaQSOwTuHGglx9jsvsAp06WMt8ozIFXeXHiHaPjL4mT7tqEKB
         OOhbZr3IUqkbCHB3Vd0BR2oAdji1Wj7ve4AYIPIXz/CcZ8EshdFXCIFJr7F7aRAJ7odi
         WCcwt9hLbR320VCEXhrLLZ7NE5soWMWkrgKAYraQ9PbpcOjNsdHZHN7aLaQnE+QjTDid
         +D3kPB91dYY2KsaUkHBLwtPJlZBo65ZZA8PZWUh6ZsInhBuQgpovOOicPAEM97RAaIcL
         M396TMfFDtH1+vOl56mGN0KymL0Xs+93fBCbMV9L/zkBJSs+HxPQJS/oOx8CADG6t38f
         Ms8A==
X-Forwarded-Encrypted: i=1; AJvYcCVI7Mz+eKAGjBnQ3YULUukxfMADDMQW6Wesm8VP6rdqGRrcBPlq7YbyWdwwQfY3UgLofOF/3FYdqT+2aAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqB9LuC8p+bzlqLxIuse8qVJSLxPB6gkonUerhiKkbKrXC91O
	sNM7Nvg36PX4NUEu0q3mWpQT0m0+z5UgyxFh6q3Ql9NIXaJvSm+MKVDvOK3uXuo=
X-Google-Smtp-Source: AGHT+IGqEF0e+IXoOCiPA1wD1EErF4DZpjMchrltLY3F4aIzKOLMtZB0smShDHkNlyYp+oQw+xv7+A==
X-Received: by 2002:a05:6512:20ca:b0:539:e263:331c with SMTP id 2adb3069b0e04-53c7bbee92dmr4530622e87.17.1730718698968;
        Mon, 04 Nov 2024 03:11:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde091csm1646261e87.251.2024.11.04.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:11:37 -0800 (PST)
Date: Mon, 4 Nov 2024 13:11:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lijuan Gao <quic_lijuang@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 5/5] arm64: defconfig: enable clock controller,
 interconnect and pinctrl for QCS615
Message-ID: <ovzq44ymgqwnretjmifaygqbjaxewxyx3ritjwcvb2d7hio26v@3i3xw5x3icym>
References: <20241104-add_initial_support_for_qcs615-v5-0-9dde8d7b80b0@quicinc.com>
 <20241104-add_initial_support_for_qcs615-v5-5-9dde8d7b80b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-add_initial_support_for_qcs615-v5-5-9dde8d7b80b0@quicinc.com>

On Mon, Nov 04, 2024 at 05:10:12PM +0800, Lijuan Gao wrote:
> Enable clock controller, interconnect and pinctrl for Qualcomm QCS615
> platform to boot to UART console.
> 
> The serial engine depends on GCC, interconnect, and pinctrl. It is
> necessary to build them as built-in modules because the debug console
> must be registered before userspace is launched. The primary reason for
> this is that, for example, systemd opens /dev/console at launch (i.e.,
> when the init process starts). Therefore, if we register the console after
> this, we will not receive console output from systemd.
> 
> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

