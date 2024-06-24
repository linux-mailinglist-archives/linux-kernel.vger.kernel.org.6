Return-Path: <linux-kernel+bounces-227473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CED9151C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A30D282833
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46319DF52;
	Mon, 24 Jun 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtfbcBnS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BB19D897
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241988; cv=none; b=QLjxDfxKIVy364uWG6qruySD37vdIikjSZyBU8WpG6xjKf2ixOSyFutMm/WXAkKyRAGBQ5A71U6I6IHGD7aRzpdeLUlWaPRXMhahTdb2lJ6lXJIMdcXj6+Zmmh5Dmn/dXWpyMFGwJTDk0ynwiQq5C/b2de8i0zs480Fp12Pvuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241988; c=relaxed/simple;
	bh=V/04kzPFi1fP+d9bWbGU6bycI5FqgRbGffltr5La+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MREl5aIBIrj5bvHTvXub0RztNk0spJ+HBeEabxiWAxZOVJAxSaUbSuzzcr3t1Dncb/MeNdvDjyGluHIxCD+vOV7KlY6M4TaKWy2l2taHYqHSyavRCCxguywGtntPXjT5W/PuN2ourn1idQYxhXASR7fm0Ag3SwBXFTDB1djS6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtfbcBnS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cc671f170so4708803e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719241985; x=1719846785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aa9CGWtyPEMf2n0NlgpWFkZxatDWsnV3NetNY1UfLKU=;
        b=WtfbcBnSgj15B8mYAXMLgFTbcq0/RgUu2lETaFhcw1qiN6yVMrWp43rB7EYhhecbVH
         DT+93nqQ7eoDG1U7ubYkuoE9Unc6ZaLTob6EPuiRQ5/wxmXSMNE8EAj2BnRExbiCPxRK
         mfooDP1H/15VGhE0WpDpzRsjPmIy3MKOfwJ93yBQOPiuI1EVei2fWfLKhjvpt9QV9OUg
         vU8S27F6sdB65dodG+uLBnCS03TMljAAnq9lGew//92XTBT6cl0jmvwqZnUcFQFZVbfq
         0PitfAIvl4aXDkFQEbmoUPXngvv9+d/fEDxiGb8IqXNvVwsGbgmCRGuozdzHYb/tcCmT
         4ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241985; x=1719846785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa9CGWtyPEMf2n0NlgpWFkZxatDWsnV3NetNY1UfLKU=;
        b=GlJevECbNJMlPPVAVeTVnvkIi9lDkkgqK/pmq6g4NRQay4GjxQgmqiQvurF8/oAYe1
         8Fn69uylbgoDG2feBQMN7o1f9TXDZ6T0LPJterhx/QjJk/ouxlEX6f6b2fGFvQ69Oedh
         5Qq9c2isNRKXGJXyaC/Lar4VCrAePoNXNaeqgjyHTkkkzet1/q8jdiAOxxEGbXMUX59N
         dD5UaFD4pPzGMk9lcbWeSIDqXz0BVrgO0OX6w5JLZhhXl+JC0gQUhKKb1fA9+3yaVgE1
         reoiFkp9w6HYI4B1+e6uqzNa3CkLHwa+Z4GxVY+YQoPNkAIb2OUU6HIc1vUHQjUqQOai
         sfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkHL6YduiwTHj+GiQevWvXWo/M8FVcGw7yMf/klz4OJdrRcqtiPV+XAd7X5Mj4HLVYLPSR5ovy3LkT2U/sZ6qwCZT6aIFV2VdvdBaM
X-Gm-Message-State: AOJu0YynYvKBvgeiD6ZzI1zvSygUYZVExYPnTnGH68dyOLe+ycrZ/I+w
	CvX/W4Ufm7YrIKwC1YrTjgNTqHFeLd3GEXDwWZPzhsHMKlcT/6xlcBBf9JqGMs4=
X-Google-Smtp-Source: AGHT+IFXLHxMYS+Mr7XUWKADI3In6X2GFA0kd96lhxIykKJO6jjnjmk+JT50Zk3RpsKGmfqjOZXfWQ==
X-Received: by 2002:a05:6512:358a:b0:52b:9223:be33 with SMTP id 2adb3069b0e04-52cdf00d27bmr1693816e87.16.1719241985247;
        Mon, 24 Jun 2024 08:13:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd76516f3sm963863e87.151.2024.06.24.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:13:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 18:13:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/msm/adreno: allow headless setup on SM8150 MTP
Message-ID: <vlgeachxzzmxttqqhbbs5kk4g2mtgp237jccbceo242fvhxucx@hliztpfh7c5j>
References: <20240623193420.333735-1-krzysztof.kozlowski@linaro.org>
 <ffdfa775-b84f-4c20-9852-b210d42dc8d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffdfa775-b84f-4c20-9852-b210d42dc8d4@linaro.org>

On Mon, Jun 24, 2024 at 04:06:24PM GMT, Konrad Dybcio wrote:
> 
> 
> On 6/23/24 21:34, Krzysztof Kozlowski wrote:
> > Commit f30ac26def18 ("arm64: dts: qcom: add sm8150 GPU nodes") re-used
> > amd,imageon compatible for the SM8150 just to enable headless mode due
> > to missing display controller nodes.  This work-around was later
> > narrowed to the SM8150 MTP board in commit 1642ab96efa4 ("arm64: dts:
> > qcom: sm8150: Don't start Adreno in headless mode").
> > 
> > This was not a correct solution, because the Qualcomm SM8150 SoC does
> > not have an AMD GPU and the SM8150 MTP board does not have magically
> > different GPU than SM8150 SoC.
> > 
> > Rely on board compatible to achieve the same in a Devicetree-correct
> > way.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> 
> Let's just forget this exists, this was a hack from the start and not
> a very necessary one given display bringup followed soon..
> 
> This should be handled by a module parameter if anything

We discussed having a modparam for separate KMS and GPU msm drivers, but
I've never implemented it.

-- 
With best wishes
Dmitry

