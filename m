Return-Path: <linux-kernel+bounces-418008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABA9D5BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C082883DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B21DE2B7;
	Fri, 22 Nov 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3dRNlc2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35F1DDC32
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267031; cv=none; b=kNaNdS/J9kCrLQ6ZLPjfnhpjtfWlJWJ8pQq4Ip4EHUHTtlOhVpOBzyeSspQeo6pB7JgSwCwIDrOGTsoKvJpRifEnpxDFmHvTMQXfIdSnOZBi+hGNtifk61yJsAmQvQzBcoWV4KWQA+TGblU/50kNAqAxwJ1yzYm7hS3LTOsQ2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267031; c=relaxed/simple;
	bh=i0KZgfH+7J5E6yaLH88UVVa1emy1LqpM5ZO9CYxOrcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyptMWpDwpew5PK7q1rpRjTjX1Ri3WB4Urvyu+/bR1e137S+x3mEK5DERu7nMgHrGf0CfuZQbHq5P33km4IgvVqPA3p4b4yuj1RhWcBuckNM9nWBuQahbLNHP5ZFlnxY6S9VBthtzNqfVE/DWuwhAOPKpruLIHfdxyZUL4x3pwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3dRNlc2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso20066981fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732267028; x=1732871828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ksABjJAjGrK4WZJYFnwNA4rXTdpvjlAmljWrW/leao=;
        b=c3dRNlc2gaiyfYZqpVcwXiei0GQP+kk/iJDkF2zX+GrEpAwN9RTmcm2ZJxIYox1N/A
         KkapUKnrevfhxhmtTfsUpYuU3Ia29nNW+5NQbm5fnIqDn2Qk2kPVr/ceNZpEO4DNextQ
         UqOK5jDUn7TbyDEo/gkUmRWDHYc85e0qUK0sp5S5EtAPu0TSf39myQ7QcLcx3nvXTNPZ
         aIuG5SNTQTqmBzHTca04rHAUiPbv+jEwx9CpX7l+P6F1ipiLZX7NVvbxBfs7wLNZeZqs
         X6MA431z6gzFJSI6RDEYnqJ9FwlEBq8eUKuZHHMcZHqr0FpidCK/Va6xO2PNrq7MKC3b
         X6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267028; x=1732871828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ksABjJAjGrK4WZJYFnwNA4rXTdpvjlAmljWrW/leao=;
        b=RyXrzGZ7vHGMYISfIFnMbJsKn3blXZH80FbbkMpS3aa/h9F1KsmeAkGlUKsfvK2nyD
         eAQ44MJ/cpRXKQyVjfAYmphl6Dx23q/OG6SPWE3Zh1WJ2aQNLPFlhVWFmTbfiMwIcDmJ
         a4UuMRReVh4hsQi93m/kyu/Uz7G0p8ZTYlaBDiFycISp+XX4FMb5XIuNaAzIwPqTkn2k
         8BE0ORLMAXC+9pSATSC7z3dZyQ6QKzH34+7BGveWKNqgrczPjAU1P2MxAZI7Iu8Slmgz
         AODq9sm7/HEALWc+EZxSIFWLQTnLWywhjuWDNLljp9g2FZSB9iO5OE0TPY046hD0H26I
         cusw==
X-Forwarded-Encrypted: i=1; AJvYcCXlkRs9bL89qWFsKkEqBdHiLAdlEEXGfSyeH5KGhFyCDXEIn0uBZ5CLdEJMz0hRVygXoJwfN6koHaRf78E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKKjCa5PpARXGU6FUcj5NIfw4LKxJJMUYI6DUONOa1IOU2gUo
	PujEmPiisjOOQHbeChFlEwku8AMbZtkj/wt+qB/LggPszM1axCLXSgUC615GELw=
X-Gm-Gg: ASbGncuO3niKBB4rtpUZJn8cybwRC9mrtdkD5wLNTIbmJoZa/Je2OPwqEWvg8jl9H0F
	MLSNwcLCflxLCH/byMNeXqdoPdKekQweE2w2kr1v2n/MTK/ZtxxEkDq467f00PM/tJ6U7SOSD+m
	Pnl5easoQvBZzGL4L/7hYs9MBTtmX+p67yTW+DmyzHGkpbOO9njzyL8bosUkkyW1DwbOjzMkSbT
	gyea7ZAvoHzi0GG2JjbaTXlvLBSHSzyLArOPj+z+F5IdWV8RZF+ExhvdEnOm8IJ8k/BsOyDsq6O
	shhPaeoJA2SDc/NXxiIFPbBztJi+dA==
X-Google-Smtp-Source: AGHT+IHBSuiJjpzWzU3YdTTbSzmrCvJAhqrd+J4fXw6qs1ZwVFgAFerBo5+LIflY5eRi3hfZUicu7w==
X-Received: by 2002:a2e:8903:0:b0:2ff:a7c1:8c2c with SMTP id 38308e7fff4ca-2ffa7c18d53mr8486111fa.28.1732267027671;
        Fri, 22 Nov 2024 01:17:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538ecc5sm2728601fa.99.2024.11.22.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:17:06 -0800 (PST)
Date: Fri, 22 Nov 2024 11:17:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: add the GPU SMMU node
Message-ID: <pzfg7qu7tezw5bg7bo6zo4t7or54437kbhl4shd3ryautjxrpb@e3hlgrz5ya5t>
References: <20241122074922.28153-1-quic_qqzhou@quicinc.com>
 <20241122074922.28153-3-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074922.28153-3-quic_qqzhou@quicinc.com>

On Fri, Nov 22, 2024 at 01:19:22PM +0530, Qingqing Zhou wrote:
> Add the Adreno GPU SMMU node for QCS615 platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

