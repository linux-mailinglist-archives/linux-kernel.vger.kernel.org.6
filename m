Return-Path: <linux-kernel+bounces-227003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57759914708
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8313B24D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3428139D16;
	Mon, 24 Jun 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXgtj2TO"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86213959B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223543; cv=none; b=bJfivbemX0dJ4nXZNBE/UgNRbvF2voKRrBpvLWcCbK7BWhWUfGAhxnkbf6l86h3EOBe6hekjarGygrgJutXAmm4K6mvg/wnYAGaJhpPmicHcvd9RmFYJw6i4C4G7bsoSLPq2mURVIT6c4KyOQm05ZuYFCHtdmAMu1aGSLb5zDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223543; c=relaxed/simple;
	bh=59Ceek29WST1fDSGduPHZlc7f0kSkPsfJjKjs8wR6EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Liae3f23Rcmp6HaJwJq9tmFZQ1Kq1wzH1sFTRRFoKGJDRA54/wCr5mrAohfHnYnDJQwZgL0nmuBOSvxpl4TEFv8DD7Lf8giYjxUlZFhHHfwpss7y5WITUUWFTKkvKBQYG/y0xWykK5bzok+D3HPTv5XBOJ0zyNeHR4jFUVU6H/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXgtj2TO; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-36279cf6414so3227044f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719223540; x=1719828340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YwHsXJujiD0iPTiagCaZU8j7Hkxo5Qj/O9XI+sxjQo=;
        b=iXgtj2TOzWzi82xnt+sZcTBp7HP5FKXdvqcaKJiBeFOIHaunrZmotqyS1KJgtOSXZi
         0WHJUxkn/s9GxL+BpaaBXUm++NCsETHDTbmr7ky+FznGxbpmEryL/cbEy1N+aQcfmSP2
         ZW1vEKVcsFyec2TwWFYhydTqmBOKsQltg9Ghv1G7bv5bU2Wc3a3dpqs5BFjblv6sKQRP
         RO4vF/CV5JEogLH5ICNC8G0zpbOLI/wc20WcQ+mWse2IinNY+QY8v73IcUlbB739aL78
         ejr2Uj7fCx234paa9TZRBv8DME5GCL5oTxjUfF3AzpYanEfVZHrGYb662Uzd6B688BRW
         XjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223540; x=1719828340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YwHsXJujiD0iPTiagCaZU8j7Hkxo5Qj/O9XI+sxjQo=;
        b=P4U0jWHQ/ZPQptDL+poJimCin8OT+s0l5kBQCOMZx3E94MiBpXPbAO1RjaJLWgOOdJ
         z7c0tHmL9QF8dITa7AWHwa5CSksNuUNjJ9pgrtQOReFaKYtZhse1iFk0OejimgVmflqK
         jX/OJLybqF9snqSjIzhna7jV9bn5JZ8j5FSvhrfZxwJNO/d4P9RsCq/1zTzSIKIKQS5T
         zeoVxvfpF00V/TjPqO1wVJIzR8VGhypI0P7ELL6QxkzTkot4/DkhjubjQtYBlEqwFux4
         83Sze8jvbiKL7xWIfc6wRpFXhnPoZF+vgzDt/zytl3LdhxbZbR4S1k2g95qA/Cjjmakd
         Rk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9BFgcRlvcK/u2s9lvJRzK/YYa0A0x2VopPzGf/J5jCDhbBHT2ZkcPUBpSInWU5Uxsl+DSTA8bS8vYOz4SalASDwPq1nNfOBy3QEPx
X-Gm-Message-State: AOJu0Yx65sECxCIN/xlGFYBeP0zzKzt5fjlyj92Ctq/0MC4Sp3I4dDIZ
	7RBDSuabttYKbMel2yQlhxudilb3Ep5zqdS22AUxJmIUA9n3pY+AytL3Uhcx3kc=
X-Google-Smtp-Source: AGHT+IHQdmqz6uyjlSKsVponwiqLHfGjG3Nl2X4/xaxGmb+o+kzPfdjcq6JNP8vVbhGQSwbSFBWQdA==
X-Received: by 2002:a05:6000:184f:b0:366:eb61:b47 with SMTP id ffacd0b85a97d-366eb610bafmr3041300f8f.8.1719223539762;
        Mon, 24 Jun 2024 03:05:39 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f65bcsm9529360f8f.13.2024.06.24.03.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:05:39 -0700 (PDT)
Message-ID: <c3240caf-a291-4f6b-a467-a424f1b3babb@linaro.org>
Date: Mon, 24 Jun 2024 11:05:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add sc7180 camss subsys support
To: gchan9527@gmail.com, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-b4-sc7180-camss-v2-0-0dfecdc50073@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240624-b4-sc7180-camss-v2-0-0dfecdc50073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 00:22, George Chan via B4 Relay wrote:
> SM7125 is the SoC found in the Xiaomi Redmi Note 9 Pro(joyeuse) cellphone.
> This series adds support to bring up the CSIPHY, CSID, VFE/RDI interfaces.
> 
> Since SM7125 is a low-speed variant of SC7180, SC7180 testers please
> take a look and have a test as well.
> 
> sc7180 provides
> 
> - 2 x VFE
> - 1 x VFE Lite
> - 2 x CSID
> - 1 x CSID Lite
> - 4 x CSI PHY
> 
> The sc7180-camss binding should be comaptible with sdm845 yaml.
> I've copied a new yaml from sdm845-camss.yaml, strip all _src clk and
> put new maintainer information. If this is not desirable then i can add binding to
> existing sdm845 yaml instead.
> 
> In addition, a bootable tree of sm7125/joyeuse is availble at:
> https://github.com/99degree/linux/tree/camss
>    
> 
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---

Could you please rebase your series with

https://lore.kernel.org/linux-arm-msm/20240522154659.510-1-quic_grosikop@quicinc.com/

taken in ?

I think your patchset ends up with less churn in it as a result.

---
bod


