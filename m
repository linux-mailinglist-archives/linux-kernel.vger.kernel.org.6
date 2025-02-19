Return-Path: <linux-kernel+bounces-522012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF7A3C4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C994718961DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8E1FECB0;
	Wed, 19 Feb 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHwMpgY8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D21FE45E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982174; cv=none; b=UWyoZkyMEW/SM967D64QgZLDxEMWGsi7dJUwS0TRpROdbpJR75UBpx+IbR0uGTa3uoP4977eW/E+uLMWY4qi2vqhcQuWOVPjMYQOnqon9t96SdUhKUxuISbwME4+JiJB7Mg+aORtJn0G4DTz4sJyOS1wIGZHRzqVOqI0x321bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982174; c=relaxed/simple;
	bh=BfUU3tj0y61ulsrpxN8DkNxpVjymHHmrTW8yGNh/Ipo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuD5LzozMS5z3UqWxN45pQBk6DE8G3gm/EBRFgF1pYyTW3s5KTzquwplatMu8kyB320ZuWY05mHMiik23fDJIciqzo5mH2GrNPqo7Pqavni/zczl5ejNyFEQkE9qHwxN8qSwNR0FfSxAtWSH5mj9qZVJuTw80ZnOFIv43OMIKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHwMpgY8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso76648225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739982169; x=1740586969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xZxkylCpxcKqeTMhEvFKzvh12lirSDj2kbldlCMXfnk=;
        b=bHwMpgY8CYkFr/NxvgVROGYx68K5HXtW/2KMZxqpIYrFdvvAKjkOg3z1Qlk2MvRvBQ
         S7bgRAZhmPXvR6gmU/0WoeHnFEb/MAdUnkEIjOenpsMHKz6TtkvTBk/9Ar8TzNz9BKHr
         iIa9FIo+8xNMC5ur0Jdn9Uv2pFqRc9Dj9QH35F7K4cy8NKKsIWvt/hu9Q1ScZus2pEvx
         CGm5m4zJTPOq0ppUdaobZ1402Q/VmJkfF/e1FMc6oNQvI1N7UhtIJes6CtWWEpkaybMp
         kmocCzr+aQneHOhcsclbahfYzv6hT/K9TCrE6EeO7KQNg1UXLF7hp4pT/YN4gc5t72lI
         lMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982169; x=1740586969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZxkylCpxcKqeTMhEvFKzvh12lirSDj2kbldlCMXfnk=;
        b=uPL2kJjQNixTKySFmEB4VcZ89cZI860Sm9Oxrynh3vowhRyhHF23+4S8fijMkp8Re4
         wfwDFdkziJYvZWd2q4HTV+aKAjjx6AI+AD4g8lAwdNDSdUv7eyaYFRyJAA6xtVlVCxte
         hXB+KKbTksALuQspCL6zNgsbX4aoHuK4dyHGO3DpdRfEtQ525Ps0RiIutOAhfsLgEJom
         EHGZ2IUrU+6D4FjESghiNssKHIiWIfvxQB275AJUDAYeog4vf/18A4hTdwX34MNtIIgf
         IZ/pC3TCtLaw5EenBVIV9qtZp6MuukSgcsAFF2XIWW/XPcVZY0nAT1PazusOGu7T/jl8
         sJOw==
X-Forwarded-Encrypted: i=1; AJvYcCVdy2fRwxEp7N5BzHwGTPHou2lYFFl4G1dktMH86Ne9hBS4IMaKXO3HlYF11ei7XcTy19994P/cdPZD2Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxdsC2YrEUyU1agD220FbnhQX6FOxfVsYH/GB4sFbUWNbipDal
	ZvMaJV0lllzMsc7w5Qbkqv3drgal/4g3X1YPBcINlK8wjs2NLlGEWkWAba92xTM=
X-Gm-Gg: ASbGncsi12sW76L9Zwgd9aFVN+/n8wXCTo/RqCNsB6w7E2SJvdo4jurK8srGfcHfSSZ
	vPIOYzeOy+rrJi3ATiEAenFVg6O1U+PF7kzCe0dVqXP4fQ9yphTVtMM06yjLinRe2Ijo7FWmrVk
	d09u6vtxoh93Q71q639197K6K6vPtrA7t0MzCVHFR6rkQctMKnmbe/PlPz5oyQKExmOEL/0qag2
	yBr9SbjaMzIk8G1fk/gJlYV+un+kByghHirOvXs7o3sCqwqDMIz4Ypjmsw+atBxjnPkN1aGfnX5
	Q5jyS5HWMIWuPRBSxZxTerixyoA=
X-Google-Smtp-Source: AGHT+IFrg3yf4JcqaRp6NZLS1mkHW305I0jkYCCmmdyg3hiS2qC7EOcbCl06hDkIssNpoO94V+nypg==
X-Received: by 2002:a05:600c:4e87:b0:439:9274:81cd with SMTP id 5b1f17b1804b1-439927484b2mr86162505e9.4.1739982169458;
        Wed, 19 Feb 2025 08:22:49 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:c59a:9aec:ce42:c01f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8dd6sm18476087f8f.62.2025.02.19.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:22:49 -0800 (PST)
Date: Wed, 19 Feb 2025 17:22:45 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: x1e80100: Fix video thermal zone
Message-ID: <Z7YFVZ5usWjrjabg@linaro.org>
References: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
 <20250219-x1e80100-thermal-fixes-v1-1-d110e44ac3f9@linaro.org>
 <Z7X4niv6g89LyBP1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7X4niv6g89LyBP1@hovoldconsulting.com>

On Wed, Feb 19, 2025 at 04:28:30PM +0100, Johan Hovold wrote:
> On Wed, Feb 19, 2025 at 12:36:18PM +0100, Stephan Gerhold wrote:
> > A passive trip point at 125°C is pretty high, this is usually the
> > temperature for the critical shutdown trip point. Also, we don't have any
> > passive cooling devices attached to the video thermal zone.
> > 
> > Change this to be a critical trip point, and add a "hot" trip point at
> > 90°C for consistency with the other thermal zones.
> > 
> > Cc: stable@vger.kernel.org
> 
> Perhaps not needed since we don't have a video driver enabled yet.
> 

It will be needed to backport the next patch (and reordering the patches
wouldn't have made sense).

> > Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> 
> Looks to good to me either way:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 

Thanks!
Stephan

