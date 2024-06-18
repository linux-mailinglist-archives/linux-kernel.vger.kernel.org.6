Return-Path: <linux-kernel+bounces-220366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A990E04A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C820F1C23017
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0678179956;
	Tue, 18 Jun 2024 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDkePBQJ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0551741DB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755091; cv=none; b=HNpxr17eN7UaD1ZQUC6wi4KPAtLKv2fdY1ndfbLOpIRk5FpTkprgsWILH/qmJf412GmDO2gr7oJf/FHKHyguu6NZhsSGpSCmKYf33EA7UFJo7XL8yVVINp4O49XdDptil9S2Pj0pTILjjRGhrY3HaLU+skxYChyjz9DwNfl72B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755091; c=relaxed/simple;
	bh=Av3TTsyP97Equ1dgYMgOqRCJJMpER4XsO+kGCyXEsLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nM+0ZtyfkKFjff92KfWXFzlldJHEA58L7uX5749kqkfJwAekuLqABogBVEA/RslAA3LyCdQGN4Zi0oaglTGwZlrnpNR+zaJRd9U+jVIbmgjQxJA19KbHlo/saZpq9joe5i8D7eb6ySWNRtcGViRAGiEwfM6K+3wQez6K1oayv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDkePBQJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so5414524f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718755089; x=1719359889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1xf5EqnHZTHgrB035+MoUK5o/+Iy37BFkV8U6lWAsI=;
        b=bDkePBQJb3YBj2V1K7quFxkU1gEXaBPeteG8Lpu5stsU3xvWx1OedEQCgMWfVTo2fR
         Yd3Xk3YJKIHeH+HS/I+m75RA9Te3SxOHjjksHXmGaTdJr/uL6fc4XrYDMbisXxWXHRlQ
         H3iKixNOGGJRQfPn/bxWNl+wnUpMZwG6hbnOi3d7gR4eA73VotTxjrx4b08mjyxYakCo
         Mzw5tftvREx1y6V3t+xoEXslCEqk3KZihexvr7iMKQ+YPjvAOfjjYroZ5MfWdvFD+0L4
         xPyQAvT3bNDGTHdgXovc02ULIzvBelWG4glsIDOlXLXDnf26D2+VcZT0+zko8ChyrEQZ
         PSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718755089; x=1719359889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1xf5EqnHZTHgrB035+MoUK5o/+Iy37BFkV8U6lWAsI=;
        b=KifQf6JpmEISh12Gerk2JdkkJ9oGeVNOhAAWag4JoTP0CcDgyeMa11M1gLWcW1exTi
         3gOEvCOZYp5qbVEjrDb8kejmj9hB0mXFPGyqXM7PqdKNx5wVbPgnojRF9tiY6/y7Bmd/
         q2McHFxlvLDnycu1f/LE1th9TRliu2uXe/2zdATEAChyAxvKhDJz86gBo+OfPMEV7NS+
         lfoonuroJ3C8TFHdxkUO0L1yCmUWPUbrJfdPUs8//Y4Ecd5x3JW/Th/lx4OI0xMNUhZs
         ie9ZfSQ7F1zH6DBy4BLh1xq3+inK7VPUeRs1XaGW7lD+7fPIN2Xmhdro67yNYGARaC4C
         b7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6RHDb5uswpCChKB3SDRnqhn94llh4qtoGVEZ+EBsUlhJ5jOq1xWbKuuLju6AjmTij3ntFGkCmeesMLdW6S59aoaFTjS+S5bPkmTV
X-Gm-Message-State: AOJu0YyINT8khPBVHy9C/Y71bdbmLThbFKqhuV7XWuJAWVXeqtC0Oe+W
	CvMepbBSRbTDtJg7LOlQS1Bs6re8SJMg12qvXOJT0Nb6mI4YSNity8vxyDthpPg=
X-Google-Smtp-Source: AGHT+IH3SthiBieRBagQGvya+fCbppYDWVdvuwD+iWbpivS/w5xvmwg3ky2tSRJqs4Shme1sR5VGBA==
X-Received: by 2002:adf:ef48:0:b0:362:172a:b156 with SMTP id ffacd0b85a97d-363177a1d38mr821091f8f.28.1718755088764;
        Tue, 18 Jun 2024 16:58:08 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:6f30:7340:4e06:bff7? ([2a00:f41:9028:9df3:6f30:7340:4e06:bff7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362e3e1abd5sm1438994f8f.47.2024.06.18.16.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:58:08 -0700 (PDT)
Message-ID: <106cd2a2-42de-41ec-8d2b-f4cd6ff9165c@linaro.org>
Date: Wed, 19 Jun 2024 01:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/9] Add support for Core Power Reduction v3, v4 and
 Hardened
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Robert Marko <robimarko@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <ZmlUElvlOPBdfn61@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZmlUElvlOPBdfn61@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/24 09:53, Varadarajan Narayanan wrote:
> Konrad,
> 
>> Changes in v14:
>> - Rebase
>> - Drop cpufreq probing block (merged)
>> - Pick up tags
>> - Drop quotes from CPR3 bindings $id:
>> - Drop useless description: under compatible:
>> - Link to v13: https://lore.kernel.org/r/20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org
> 
> This patch series is needed for IPQ9574 CPR support. Do you plan
> to post a new version or can I try to address the comments and
> post a new version?

I'll resubmit it soon

Konrad

