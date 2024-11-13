Return-Path: <linux-kernel+bounces-407880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5E9C78F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A41B3B6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C715C14F;
	Wed, 13 Nov 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwblCQ0f"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943F155A24
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511434; cv=none; b=UHAIMzWtdmFqlOWZUYMFYfwRTOTJDyQuSYapBuMpJwy29iLV5UciwauOmDOQIog5WCBnlxLvICuo2MMl/nSuUpjINbq5OnmM3+tC1wcB+n3Jk4WaHN7oFtO5yUhyouEQotGlFjJGvBuvgkGPM01BSVdlPFnG1UsPqgrMJZhD0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511434; c=relaxed/simple;
	bh=mkf92YvqqmYTWrtFZhtkksrDlENB5dZpTVzytU/uDC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnppUqOKwFJ5OQr6XV/RjquRznv78qLRISLfiR4EpyBwCgmNK5seY/VXTQ5NwE6HnttoA4izWoiBD+u4FFaXI3dK3zsMfT8hNPMDR+Vsqv2PcLcls6JjIXzoxUtIRWkpzF4av5GY6OaffoiWLYVZnzbYWfuLIk1CVNJ6iRUkpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uwblCQ0f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43155afca99so5436705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731511431; x=1732116231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOdKga0laMcAvUIFJVgngqKV8g3vjQo5W0ePdHvo9Xs=;
        b=uwblCQ0f5j51wt6e4u/1wmSa9cQsZkHN6pdZK/auH2Ctt1I5gY2wFj28ic6uKMHML1
         JwNEpWhqbt48in3sRFg69dOjs+BhMplk9nkxzmQUV7k70CuPZF0oUqVRwC1aOD8CT9h5
         zv7lxPwj1SKrs7255Q64/8uMG1OfE72sS6MxGoyDXnJWCxDKmyj6B2bk7BJT4+ej3NOF
         jTRGhZ9xYdth9VpAJ6xErOcJuNapqZ5Vwbep1GuaMqtkkIkckWOJ9XxkR/wpYXs7gGr/
         ClwkQJRbFFesMUPXGw2rlVJgSePgc37/FUFx79ICT4AlBTgx2jAG/hF2TrJT+j1DDlmi
         bohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511431; x=1732116231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOdKga0laMcAvUIFJVgngqKV8g3vjQo5W0ePdHvo9Xs=;
        b=E5Gxl8hBn6CkDQ/aHv5MhyBSy1I7HMGmRTKVVYfq60W3uaGeoswoEvZsWrvhS2A80L
         ITY0nfPwgBsZvyto6LuCSjwywou2/19EGd0lKO2jeJLW3GaJ3SrzODiesmikacubJHdD
         5TNsUYkkjj/F2bSOBLnHIApPhcBMm/+xhAW6mH3gBuv3NN3so6GNlATi0H+GVOELgCht
         /47oZIS/EqnUsyeh+8jKsV32nL7He7tYPkss6MaYtVdtQTGMc2rqUO3zYNn9qu/eGvwi
         TBaj0M5H7GKnIVfCUImrrnxbL33mLgA4qW31dEIsFO0daz4LnYThx/SI6LREFq/sGayl
         NcFg==
X-Forwarded-Encrypted: i=1; AJvYcCU3YAWBv1NmSWsQhccijCYRWk16PL1jsk9dUJdC++E91XOKeRLvLcdIfeGG6mPXTdues8nwk1SLRpIrYJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KdtdhZBZo4usqFaSFRobvRvVozKrOjSVw199p7KYTmqkQeoi
	lIp0reaXkNFnSPiaqGNuPLKtv4HrPi+3fjCzuoS2hZf2yXqZplwxiTZLrRlJV0s=
X-Google-Smtp-Source: AGHT+IH/gfM9PGoYpJNGrFD5lZJnTGB4qUBvPUOWaiS4UbefcHZd3yGHfeCZ3TMkYSv3w6AbbLOVYA==
X-Received: by 2002:a5d:588a:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-381f0f7f1abmr19457022f8f.19.1731511431496;
        Wed, 13 Nov 2024 07:23:51 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2e19sm28014685e9.3.2024.11.13.07.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:23:51 -0800 (PST)
Message-ID: <eda3d0ae-50eb-43b2-a234-93b209fbcdeb@linaro.org>
Date: Wed, 13 Nov 2024 15:23:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: qcom: camss: Add MSM8953 resources
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 barnabas.czeman@mainlining.org
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20241103-camss-msm8953-v4-0-48d0ec75958d@mainlining.org>
 <20241103-camss-msm8953-v4-3-48d0ec75958d@mainlining.org>
 <6833ebc6-9210-471a-8ca6-5f3605155f33@linaro.org>
 <412b3252f1ca795fbcfaf5e466e94642@mainlining.org>
 <67d014f1-9424-4b88-b031-096a5596c5c8@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <67d014f1-9424-4b88-b031-096a5596c5c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 13:28, Vladimir Zapolskiy wrote:
> So, we have to rely on the documentation here. Bryan, can you please
> check, if VDDA_MIPI_CSI pad on MSM8916 and/or MSM8953 is related to
> CSIPHY or CSID power supply? Thank you in advance.

No there's really no indication in the documents I have how the input 
gets routed internally, CSID, CSIPHY, both.. not clear.

I think Barnabás is right, the best source of information we have for 
this one is the downstream dtsi => CSID.

---
bod

