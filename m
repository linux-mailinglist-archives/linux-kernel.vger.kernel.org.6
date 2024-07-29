Return-Path: <linux-kernel+bounces-265246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDFD93EE66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E2B1F212D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E9C127E18;
	Mon, 29 Jul 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFsXWBme"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CE84E11
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238073; cv=none; b=tQH7P2NpB7Qq1r8x3U26PoWE3NBdhYa2vz4j3fwg4Q0OSuujFfZkazuRulGINQywvr72ncPrlA7m++JSWLbsMjsK7Uj3/C30wPensXpzq7NUG38cA7mTJb+ks0pKggmtsnkJlnvMkg59Y/gPRDcElxHTNvyZeG9lqGqaO1xFjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238073; c=relaxed/simple;
	bh=g1Bfdx1NZahC3TeP1Q0uSYngscxSAC9NK7v3LPtb4g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdxiHfDz0NAaG89If/30l6MSPTPFUbkmYhlYhOuRHrjMXO8DGnvYGFeLPAmRMGyD3DVR0Ovsuva7CtqBH5VD5Viiqvid+tdpwM3v++tpIpLKNuF7F0tSkVQVLkI3W5TMqcj6aLxMQ4H4wnMoY0MSgUcDnRQ/2H7OL9IzkjZdMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eFsXWBme; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efcbfacb9so249887e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722238069; x=1722842869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzbU8q+FWgrm3i/pjC78LeEzfxb8uIRGDB17iTu2b90=;
        b=eFsXWBme8AAe5Tgpl7oj6KJNizsd4sLixRGTDUZZsR5/tPdcxJ5Srt3+NV6lghW2wG
         3zgVFM/3S0K+BZvu8bhTbPT3V3OyULCCRy6MOs16DQI53OHDm8hri7gEU9h5emb41PyP
         UfCxoCxYqAH3clmnz8YsBLjWppmOZ1vBn4MsU4JAzmhINnIORn/yAHT+Lul9v7B23qpn
         qn6vupRObr0pLT7p08GWyoeAJkz+OmG4a6S0s8JCr5r9rbUTyt/I+SACugOwfQxG/Rpl
         kMHuCfhZStI/HMn7teEjen87OHljLMLg8uhMFm8pQwQrZGqLCgRqeLimK1yHYr34x8e3
         9dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238069; x=1722842869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzbU8q+FWgrm3i/pjC78LeEzfxb8uIRGDB17iTu2b90=;
        b=o2XPQEjvU+peaAj0f+pzZE4ycUurHWJ1w743yZrdBYPB2+ddOj5cn6ZVjE5C+mikEh
         JXn/qiGzGmZV/cjbWJe1ty1AnV2hPn7h1TwnSDMnZD5q6h9nfyEuLo2jmLjyCWtrOffl
         A4bwsgDvi7LuXHIfGVEGxQDMdMWciqUcIDgCq7CH/5LqwbQhM7/PXv642LjPpTAHHrAt
         lgmEGF4267RGchRkoT0tfbkC28NlFjp0kXqIC5ntU2cFUP/wtd49/JtEAMjtUfp5y24b
         4qs/JfHOx7+k8uHVzY0yNCWkxGXQ4EUgvs6DiyLL53Z/7I70GxXCHa1B/OLDZfP7YRbJ
         W0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUoIXO9uEBFi/EZic9nY85hFSUPQWd5FO2mTTrAwhr02l9ekrlEaehxjvGQrLKJJ1Yl3DBqskf/3ciLcFZuZpQzw14fWGPt6xF0Mkfa
X-Gm-Message-State: AOJu0YzcWkYYTiXZFLJ+89K5S6HwODHji9jv8Rp8k+is9rSshgLdwKSC
	ayuLb6rsMO2GCH6jXDLvugG9cl01fXDiC/oUo5Bb+NjCRE4CZuOShyzE3hOZ1Kw=
X-Google-Smtp-Source: AGHT+IHGka7Vyt+PFTMS4CYDvtnk6UifRKtbJJ+Elb2ByPtE3I5NLETmc6bBkdbUhn4+QGJPOhZ1+g==
X-Received: by 2002:a05:6512:3b84:b0:52e:9beb:bc09 with SMTP id 2adb3069b0e04-52fd5275421mr4871735e87.3.1722238069148;
        Mon, 29 Jul 2024 00:27:49 -0700 (PDT)
Received: from [10.8.0.5] (mleia.com. [178.79.152.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd127csm1372806e87.89.2024.07.29.00.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 00:27:48 -0700 (PDT)
Message-ID: <d760dfb1-b86b-4d1b-a927-575416e780fd@linaro.org>
Date: Mon, 29 Jul 2024 10:27:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: clock: qcom: Remove required-opps from
 required list on SM8650
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>, kernel test robot <lkp@intel.com>
References: <20240720052818.26441-1-quic_jkona@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240720052818.26441-1-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jagadeesh,

On 7/20/24 08:28, Jagadeesh Kona wrote:
> On SM8650, the minimum voltage corner supported on MMCX from cmd-db is
> sufficient for clock controllers to operate and there is no need to specify
> the required-opps. Hence remove the required-opps property from the list of
> required properties for SM8650 camcc and videocc bindings.
> 
> This fixes:
> arch/arm64/boot/dts/qcom/sm8650-mtp.dtb: clock-controller@aaf0000:
> 'required-opps' is a required property
> 
> arch/arm64/boot/dts/qcom/sm8650-mtp.dtb: clock-controller@ade0000:
> 'required-opps' is a required property
> 
> Fixes: a6a61b9701d1 ("dt-bindings: clock: qcom: Add SM8650 video clock controller")
> Fixes: 1ae3f0578e0e ("dt-bindings: clock: qcom: Add SM8650 camera clock controller")
> Reported-by: kernel test robot <lkp@intel.com>

Well, I believe I reported about this problem way before the change has been merged
and the problem reported by the robot, however it was not taken into account in time:

https://lore.kernel.org/all/0f13ab6b-dff1-4b26-9707-704ae2e2b535@linaro.org/

> Closes: https://lore.kernel.org/oe-kbuild-all/202407070147.C9c3oTqS-lkp@intel.com/
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

--
Best wishes,
Vladimir


