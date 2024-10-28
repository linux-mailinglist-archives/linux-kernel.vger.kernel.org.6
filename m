Return-Path: <linux-kernel+bounces-385382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B538B9B3680
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E629B1C21D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC9188CCA;
	Mon, 28 Oct 2024 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ll3CCupL"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7481DED45
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133086; cv=none; b=DSf4r/3yQyIw+xUm5k2I1AKVlYxZ5i6o0qjWQmU5rWnMVMix2TP1PuDOF5DJt8Kj6IHPdGoRk2y51zYqbN7te82TJUgWfDOwFPKBI+34rp+3kWeN1/mWk3vAHNeno42hGBwQNjxWDPiuPoYrfPYBDE9bnBUe2qZLULur1MPihe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133086; c=relaxed/simple;
	bh=Tz7kDWBqLGn3EI7GboyFCyclXYJJe6cDaVmgH6AThtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+98/xKpvhqL0YIDbgEXQ8Z509sowfMeEtTpaIVSXpJk/kleXRTbIb4wzzf5EU71+Zv03iYouiXUDW1Q9eeSRxKRUnv9fIUVLwNwoJ8horqAocBiiK40CLZhGuzMLRVimgvzf3YKS/9MR8h8u0QLZC5js6NkKzRAzZlkdFTDmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ll3CCupL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so3397507f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730133083; x=1730737883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3SVkuXBfKZlywsVlwzLEUNrxoa2VRV3XvycDM5U1cA=;
        b=ll3CCupLTXC8Ovh/e3fKsPSxc05J9yvCmHTlCAUIMOsOLrhzL2Yskywihe/GjoGMXp
         oDldKGMc/+cpIqYKQ7mXxMdOnpFgRsUsoup7SnTjD/E3vm4yFjB/78OZrUAdzIYFyfli
         5ZZruEeujHpLcZ794hqpP6OpEKUJaysZnoxw07LjjjU1n15Uz3XoLwJ2hawTPSTFYggw
         rT2UJjlJb44vJDSh75yEbeTMql7oPyFHVisq1gJ1rMdbcr39mHO861xvXOZh8UMbsjUj
         XPQirf0MAwY8D4RVXymNYhTwGsZKMPoGpEnFLyIoXL2XJ4M0c407dbmZ2MdXLR6kMdUY
         6afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133083; x=1730737883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3SVkuXBfKZlywsVlwzLEUNrxoa2VRV3XvycDM5U1cA=;
        b=vnRikKJxcRRlNl4jrUxKPTrzTZC9V4WEZqwZKukr1KVzoJZFkxNppj6UyCrEHqAzwS
         XkR8WCqu+5m8FXi3yKDNTG5qCkmJMiRkFuY7qc+kiqjc/d26EJ9GzZ6eB573MCLarXaG
         cxUb5xO3Nq/E+Fq8g2/3LvFV3Rs4DudR1UlQurmwVavVRgylyHRTdnwAF952GnaHwEYP
         XplZVzpuCttH45eU/SEI3OII5vL0EVKYSZYnLndoayrUEYH7eiEq3xr+ix3jmJBCw38P
         1UKVW6FKRxRp52hKZzKOHfVlq7t8dteSuorLCtsRG2RIEt4PicB5htb66tpWF3TCbs/Z
         AL7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxdAqtvxe/qB2cpcx3Ozh5JO8Uhpfd5QJIcOnVLhg+pEsnue3M7Oc/Y3iwMkRSkvYdmzIYDYMriIslHHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUya61SABnTFVdW2FsVrxx9bK3DP4z+O8oBlm51CEn149ORPd
	fg8BTcCOSL+j0jsf78mVeMgsMYUE+9h1hhqDOXaYBBbKXMnyN+NXHa6nhsj6hws=
X-Google-Smtp-Source: AGHT+IHUE0fR5YoL/rIP/oL6jvyJFRvDbRSlURM7kaLGL3QFwVi+FhPBNee8pMr2ON/PeXPlAUo5dg==
X-Received: by 2002:a5d:4d43:0:b0:37d:2d45:b3d4 with SMTP id ffacd0b85a97d-38061222606mr6893628f8f.52.1730133082753;
        Mon, 28 Oct 2024 09:31:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b1c65dsm10023109f8f.8.2024.10.28.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:31:22 -0700 (PDT)
Message-ID: <bb09a51f-dd92-4f03-8523-f39c2b94f686@linaro.org>
Date: Mon, 28 Oct 2024 17:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: add SAR2130P compatible
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241027-sar2130p-tsens-v1-1-8dee27fc02ae@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241027-sar2130p-tsens-v1-1-8dee27fc02ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2024 00:06, Dmitry Baryshkov wrote:
> Document compatible for thermal sensors on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

