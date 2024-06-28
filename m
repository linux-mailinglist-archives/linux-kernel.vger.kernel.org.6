Return-Path: <linux-kernel+bounces-233848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE08791BE25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82638284BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82159158216;
	Fri, 28 Jun 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="cztDkjgk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657C155301
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576313; cv=none; b=LHUQSY+XtJ6HSzI+tR3FVsccCCM6MPkS/orljLVRAZSL5JFat7zNS9xdz3vPId7krMaW96p7z4mcoexRX5jpxddkf6KYXhc+/O3/ubWcT+kiIQB1gBZBIUl0nkvg3AvjikJoJlTuD5eBEyBUEe2kRAY9ElABDCzZ2NHrrSqY89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576313; c=relaxed/simple;
	bh=6i4aUgpJB19hkRElgd52K5ra5plZwsRkJ3JilhYwSLE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DS1BkmgNEKKttlKAex23WrDBcbkfs9X0g/kz2y+fsJ/lYSb+Mm95nqZHp5bPBqcET11JQkEUBCuqTWjtJKu93XEYM5jSh3G2MVoKbd2scB2TvDUlOBIyNWHwIoFByUvF2+NW5o8LVVUer0yxwMu3xXNMzBrLuXK2/qYQ7t+f5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=cztDkjgk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso739642a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1719576310; x=1720181110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dEZ93ppxxFybq5YXY7xXAqpIxffUxRuVYAlDgWNd9E=;
        b=cztDkjgkoB9McUUfmczKYr+FxYfXWJIRA9FpykoImOHdorbYFe6WDNsGFb4K8M9se6
         RtZssYs5S7QdUr6VkgU+GVzA87YNlnXiIbbmUpCfql2ohtiNTF/0O6jzsYYe9t4slPDq
         yBb08iGumoajGf3QoktrxQP4icOuD+p4Ra+cSSNDEOmpvh8WIp3aEOxy0BKFMnGlopyI
         zNxhFcrXrA+LTauIOUx6HXpS5PrsRAruiLuNTQlKGuyObdN1G+QXjS1qU3+GqX78YwSh
         ysdfWcRD+TBMIzTyOKGOESnZpLjk9+cCbWo7v8xVwCcP0V26EQ1IIpfJWtGokGKueXmd
         Io9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719576310; x=1720181110;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dEZ93ppxxFybq5YXY7xXAqpIxffUxRuVYAlDgWNd9E=;
        b=hZIPnmh7lqMHimFCQpmeJwQoLf75fNs5KQcEKYP8wjJcSYaEG8XTQfuDdDnYBP8/5a
         LX1QhO0SbCDv61sFL4n0gYbXOjtY3gzSeJHD0j3QlUErYZxeDcvfCCS6Apl+jSo7YfOy
         AtAM/gNY3+OXQ+xdjwM3hB4hTwStFDuYYHMEhm139KFtFKWx/cnkYjC3pmIdZInUdiaP
         8IPwLfazW6EerBd4j4XlTrcuLaxW27DVusn+/zE95QIyETTzT4S/RMoBemX4MKickhnk
         x+b6/UI3bU/fvonGE0SV2UgLY+0ZMshaSOV+sMY1EPW3Kv0xPC110o3s/4XCarEfzxM4
         IOJg==
X-Forwarded-Encrypted: i=1; AJvYcCWb1+vMY9boLoh6jCbd60ds4+WWk+g9h1rx37HjAdhFcNWBvnzivuV5Z3w8PQrcuGHey+244T1JCegi03La3JdG1ixPHuCe0mk9Xqzq
X-Gm-Message-State: AOJu0Yw7+t3YWXO9isyMMsW4VD33S/BGJiQKFf39v6Mcmt6dtZde4Mul
	GyAhx/dFBJnMGBIfjUsY1YQBaKvd0UmKVjcOSILIXgN3tvtaypUYRiSa6lxBdP0=
X-Google-Smtp-Source: AGHT+IFdW/82aqcZvtgps4j2MKfNomyXyXNwYlkI7Z87PdGpUPDHEKeV3EFXgGRAKRgRdVCZOMwztw==
X-Received: by 2002:a50:d69d:0:b0:57d:768:cdfb with SMTP id 4fb4d7f45d1cf-57d4bd6a19emr10659691a12.6.1719576309850;
        Fri, 28 Jun 2024 05:05:09 -0700 (PDT)
Received: from [192.168.100.213] ([84.15.37.222])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-586132502ecsm955095a12.40.2024.06.28.05.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 05:05:09 -0700 (PDT)
Subject: Re: arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb:
 thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be
 fixed:
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>
References: <Zn4UNSxi0bAE+kEt@rli9-mobl>
From: Mantas Pucka <mantas@8devices.com>
Message-ID: <e784133e-a508-0ef3-d226-5d31237d7a9c@8devices.com>
Date: Fri, 28 Jun 2024 15:05:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zn4UNSxi0bAE+kEt@rli9-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-06-28 04:39, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6d6444ba82053c716fb5ac83346202659023044e
> commit: 0b17197055b528da22e9385200e61b847b499d48 arm64: dts: qcom: ipq6018: add tsens node
> date:   5 months ago
> :::::: branch date: 2 hours ago
> :::::: commit date: 5 months ago
> config: arm64-randconfig-051-20240627 (https://download.01.org/0day-ci/archive/20240628/202406280455.q9pFQTIe-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
> dtschema version: 2024.6.dev2+g3b69bad
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280455.q9pFQTIe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202406280455.q9pFQTIe-lkp@intel.com/
> 
> dtcheck warnings: (new ones prefixed by >>)
>     arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: qusb@59000: 'vdd-supply' is a required property
>     	from schema $id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
>     arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: qusb@59000: 'vdda-pll-supply' is a required property
>     	from schema $id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
>     arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: qusb@59000: 'vdda-phy-dpdm-supply' is a required property
>     	from schema $id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
>     	['qcom,ipq6018-tsens', 'qcom,ipq8074-tsens'] is too long
>     	'qcom,ipq6018-tsens' is not one of ['qcom,ipq8064-tsens', 'qcom,msm8960-tsens']
>     	'qcom,ipq6018-tsens' is not one of ['qcom,mdm9607-tsens', 'qcom,msm8226-tsens', 'qcom,msm8909-tsens', 'qcom,msm8916-tsens', 'qcom,msm8939-tsens', 'qcom,msm8974-tsens']
>     	'qcom,ipq6018-tsens' is not one of ['qcom,msm8956-tsens', 'qcom,msm8976-tsens', 'qcom,qcs404-tsens']
>     	'qcom,ipq6018-tsens' is not one of ['qcom,msm8953-tsens', 'qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,qcm2290-tsens', 'qcom,sa8775p-tsens', 'qcom,sc7180-tsens', 'qcom,sc7280-tsens', 'qcom,sc8180x-tsens', 'qcom,sc8280xp-tsens', 'qcom,sdm630-tsens', 'qcom,sdm845-tsens', 'qcom,sm6115-tsens', 'qcom,sm6350-tsens', 'qcom,sm6375-tsens', 'qcom,sm8150-tsens', 'qcom,sm8250-tsens', 'qcom,sm8350-tsens', 'qcom,sm8450-tsens', 'qcom,sm8550-tsens', 'qcom,sm8650-tsens']
>     	'qcom,ipq6018-tsens' is not one of ['qcom,ipq8074-tsens']
>     	'qcom,ipq6018-tsens' is not one of ['qcom,ipq9574-tsens']
>     	'qcom,tsens-v0_1' was expected
>     	'qcom,tsens-v1' was expected
>     	'qcom,tsens-v2' was expected
> 

Binding change[1] was sent together with DTS but apparently was not 
merged. Should I resend or can it get picked up as is?


[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1706173452-1017-2-git-send-email-mantas@8devices.com/

