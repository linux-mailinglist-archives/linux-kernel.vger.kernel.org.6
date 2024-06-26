Return-Path: <linux-kernel+bounces-229836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD07B9174E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EDA1F220A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B102017FABF;
	Tue, 25 Jun 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVJ1oPak"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB51DA58
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359366; cv=none; b=lBguse1gjJVYFedOEJrSu4zLyOKp76ZHiPZp+9V9HXXDNWqMBEFGDezA83OQg5EJUhh2XbLPCBuww1qrRGDF/nuG+i2/UHcQg+O+YLnuO5WrHqajye4K2S/h/4Aj9ly4uu1d3ytKv0h+b3xN/HmoQrobaSRE4zKf9KMZRR3HiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359366; c=relaxed/simple;
	bh=2ZFq/h/cdDU27DXX0AmZ/Rf/mFbsafxBM9Z04LggrFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7bZ0L4MnVgm38uMa1z/c/jr6WrMryzbHvuXgwwv6Pz/bDuBSnclqeRdY3+1zTnkWWn5USCOMxpc5Y5SIRwKeA4xC4/BWrikMoxRnyjwEHKEmdkfuQHW8Vp0VWij4IcI6F/osAdxB6fS3Oo2O4PQo0+wl7qG4K+eGzPYVtvmwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVJ1oPak; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-366edce6493so2240736f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719359363; x=1719964163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOxs9q/KRWV6ovXgAREtQ7mXRlDPaMH/Kc3byJkLH+o=;
        b=GVJ1oPakpgne40Ae/T+aVqhJx71YOugP6H2+3Nn17d8cN+rJee3TcmEfyn3cPNYLNU
         HCygAcdj2CnXu0ptY3b/a7xcBXylJOplqblrrIYWGc8p2boE6SUru8VZNwdDeu8nLjlU
         4W9r4CK8p7VxBI661+1CLFmmFVDRnvOGKDJD9xqq2WaTtHS49mKDmUvwbeEXqo0/R/GY
         a7TBFL/m5taAYU/aGQN3oXS4ULEZBSIdolrSOpaqCSaUKdaGs2ys4VWv2mqv3dazOlho
         WSaHVtN6in1ePDDNbw+OlWMaWb0F3lgVfXpKJetdPsM2zVoG4CHBWPMtGHnnaN6VTpqL
         fj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359363; x=1719964163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOxs9q/KRWV6ovXgAREtQ7mXRlDPaMH/Kc3byJkLH+o=;
        b=DpGgK5j+mEXmXorD8w1Y/7pvsbw8Z0sXzKGga3ni6BUdLNd/Bsru8QWXwQCgBI6i0D
         2iLWSDqR/BEtd36unHIAGtiT1FCeIKJLt+qaKMC+ZsoSkdCJE9gKeNKVOabnCLfTHCjE
         940JtCaa00fkU4x+g5YYKhUvpyaVGyGJiK5mBBpyScSmoI54/FI2HPRFt+P98yaAUD5S
         MuHPd7CnUiRb0b5UArXdrWFnnnYdEONJoXFt8AQU3zFiFS3FXRWPGqfeLujXtQw7sqEG
         UJ9Hd4zoL2FtsOtk1d30Dxgm7wqiG4jdDUUHRWkPeh1CUv8nKnifICPqfb0b2S6tBRSN
         eGSw==
X-Forwarded-Encrypted: i=1; AJvYcCX4NTz6VIaVwpyvrWjGDhuk9AGwzyYAxv5bwp7EzBHdsHCUvC0vSnVRz3TRTk0R0kRIT2RvwtiLg01Zq6QuBfuCpHryQ6LrONemVdK4
X-Gm-Message-State: AOJu0YwoH8GlQbjxKV7Y/n4sTFg7OlpaNyqyFWuVbkYLpJ8JQqq8+Uzv
	SAcGHk9wWaLtMzGzvkn3WLptS2mRG84PvyWVklWrmZeus2S/LRHjoVA2YuR5fMQ=
X-Google-Smtp-Source: AGHT+IE300h3oYgIh4+YcZq9y1SiitbL6hkufbwWeabZwmZQrEHKJL1469s/fCZ0jlsaVjC07ffmXw==
X-Received: by 2002:a5d:4a0f:0:b0:360:8e71:627f with SMTP id ffacd0b85a97d-366e962fb68mr5516528f8f.59.1719359362915;
        Tue, 25 Jun 2024 16:49:22 -0700 (PDT)
Received: from [192.168.0.16] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c789esm14227767f8f.91.2024.06.25.16.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:49:22 -0700 (PDT)
Message-ID: <47997e61-26e5-4643-ac69-17db09be9bb1@linaro.org>
Date: Wed, 26 Jun 2024 00:49:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 5/5] arm64: dts: qcom: sc7180: camss: Add CAMSS
 block definition
To: gchan9527@gmail.com, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-b4-sc7180-camss-v3-0-89ece6471431@gmail.com>
 <20240624-b4-sc7180-camss-v3-5-89ece6471431@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240624-b4-sc7180-camss-v3-5-89ece6471431@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 13:13, George Chan via B4 Relay wrote:
> From: George Chan<gchan9527@gmail.com>
> 
> Introduce camss subsys support to sc7180 family soc.
> 
> Signed-off-by: George Chan<gchan9527@gmail.com>

This looks fine to me.

Where is the CCI and sensor stuff - could you post a link to your 
working kernel tree in your next cover letter ?

i.e. I see the clean kernel tree

https://github.com/torvalds/linux/compare/master...99degree:linux:camss

but it'd be nice to see the tree with the sensor wired up too

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

