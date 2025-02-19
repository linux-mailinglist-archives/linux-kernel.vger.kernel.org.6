Return-Path: <linux-kernel+bounces-522085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223CCA3C5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C5177E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03484214216;
	Wed, 19 Feb 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+8Q81fa"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B8213E8E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984905; cv=none; b=Aw4lQCssE01V+sAXJkkC30caJ74W43NKXbCTUtMBWuANwZLaR74hyY9xtF1Zx51zqF+52cjj6m92gQ9f3XpnU3B5A5XaWLLC6pZ7i68zfvLio1gEbiRLfKT6BwUiM9qr8WL6sW0/3qtdbE3xMStzzt8wqpVay2sU12nNVf6dTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984905; c=relaxed/simple;
	bh=sOZKv/GYH/zrpTdWa6jU7obP6mXkamoFJmgPvi8CMoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4atxQ3S6i/mKI85NsHzmtdy8N8ULJuSS1XO6vtSHqwBUUe4S6h90alFEuWPXp39d9/7ZOATfmZ2qMkPrD8f00YcUmB4Wk7FguE9ETRVq3YcgP26pj2JVZ6uFTRAALKXude/WdDTfduwvvTvcKSIM+6uFMOyksxL1ok6DvrKExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c+8Q81fa; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a04so73903031fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739984902; x=1740589702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkbkUwNAuEhe/BbhZNs3/ygs+aQHipW7xTCFebXTARI=;
        b=c+8Q81faprSiRkyHSG6AVEc5QlcLcljPpbve79OsHuxKkdWqh2nRiAmUAVm9FyF1kO
         bLpbzSdFBctuuUurD6K15ITZmPIaoc9gvAO0OlriHjIFsxC5/0obU1RXINVylt2ddZje
         RGXTOicNcXZhRhv7ehMLd/acC4q8vcxgw6C4frtX/saDCIiXqSRbzOKIGcMx2K+Ycgf/
         TTbj0NEKd3qJhTdas0V3AaUFqxqkVKiKkprxsFijGDVvvHN78bJQU6h3tp8V3Dy1SDCM
         Q5kh+RERTvT5bCdZu/IQxKxV+n+EGh83/JnSnmRgds/GkAgHimL9a0q4sAPItlHM5rW9
         63sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739984902; x=1740589702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkbkUwNAuEhe/BbhZNs3/ygs+aQHipW7xTCFebXTARI=;
        b=Jz1v5ioyE4IuDMPe8SiDCaPvcwPioU78C2+ZK7o3hGercIytmRVfG4MLG5N4v+/P0s
         dPGg0Au1ITa2/6557q4OMt3ahjTYGxFDV3nBhnUeLlEsIzWNCk3vuApk/FX1Y4oqED52
         T46EjqwcHufm/TriRwb8zy0UZny79Af8gosDonyIJEUshF89JZxDHo7wk0Kx/W6azDwY
         nlB4O5EAT3rFh1HHuAfinAQJSe04aJaROxUb/A8ffPYbP+CFvM/BDbG+zLYn7jiUvpj3
         wBEH00mYiUrSbjgO74sNQ+lqBvIuwVc9luezimxtilZpGoZpxuU9g8vJIPQbGW44lUxT
         ceQA==
X-Forwarded-Encrypted: i=1; AJvYcCWOkyY91et9HD8LgmZKqO5HGK68JazCpmqSwqtkmA2Fy+lz0pVUkJjSUqT654r726+1xjUNiyRen/LroBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzvVUCO0HZ5FLIZ4PFrwhLED4hhtZwVlVm+vJmRB3YM6OAMn+/
	MUpbwck3TZLWC1G7W8rKExd7exNwkw4gTuoxvoQHRBRLvUsl6eN8EHUETcFBh2eRytITYHiOvbp
	2
X-Gm-Gg: ASbGnctEMay/1Ykhm30jylSxooc0F9Mh2/pIJPgLcAVkmezpBErGG9a0gtFKajl7s1e
	rW6fuKT2j2L+kGxqTvFPMNvl3RxqD/BU41jmvnKnN8wbLcQ46WSfP0J0BfjI/+jx1+GQ6TUv0VC
	nl8Bs9vWOU996EJJvYWg5vwsRF0kKME2Qv1owfnnd9zqbLs+r94HflZIuTDlhkjdaIFGUI/hEFj
	IpIEg52HxKTE3GYpDbeWsGAmg+TcPK7UBoI9EVNRvZHTc4XmNhQo50e/UbTp+TjSbcbhlJenCE9
	W3d7AICHL4A4rKg8hIPMsYbQKhG9d1nxfdPnyYhYIDh8z89l+CoxFM5r7ZvJuxl+3pRPqrg=
X-Google-Smtp-Source: AGHT+IHte1Sutlq3pq+Edaji2NXEVszWbf8srrzfEIZM35OvWAtnBNuKusfR7DVo+dFSq5pnZtpuNg==
X-Received: by 2002:a2e:9dc9:0:b0:308:eabd:299b with SMTP id 38308e7fff4ca-30927a2e076mr43465961fa.7.1739984901701;
        Wed, 19 Feb 2025 09:08:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309216aa863sm19127271fa.98.2025.02.19.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:08:21 -0800 (PST)
Date: Wed, 19 Feb 2025 19:08:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 05/16] dt-bindings: display/msm: dp-controller: Add
 SM8750
Message-ID: <h2shpen65r7v4in54avsez7qtlwojbt2cthyomqrsgs5ewprwb@bn53suqrzkac>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-5-d201dcdda6a4@linaro.org>
 <aqpuik4zitdfuk4pahn4wyzxdvxldy4dcqjs3mhr6fqtxpoxhf@ssfzzbfce2nu>
 <2dfe466c-ad94-4683-a2e9-a49e77a61f4f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dfe466c-ad94-4683-a2e9-a49e77a61f4f@linaro.org>

On Wed, Feb 19, 2025 at 06:02:20PM +0100, Krzysztof Kozlowski wrote:
> On 17/02/2025 19:58, Dmitry Baryshkov wrote:
> > On Mon, Feb 17, 2025 at 05:41:26PM +0100, Krzysztof Kozlowski wrote:
> >> Add DisplayPort controller for Qualcomm SM8750 SoC which so far looks
> >> fully compatible with earlier SM8650 variant.
> > 
> > As that became a question for QCS8300, does SM8750 also support exactly
> > two MST streams?
> 
> v1.5 of DP (starting from SA8775p , then SM8650 and SM8750) support 4x
> MST for DPTX0 and 2x MST for DPTX1.
> 
> The DP in SM8650 and SM8750 are identical, according to datasheet (v1.5.1).

Hmm. This also means that QCS8300 is compatible with SM8650. I'll let
Abhinav comment here.

-- 
With best wishes
Dmitry

