Return-Path: <linux-kernel+bounces-442457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6DB9EDD18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4772B167E39
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8517C68;
	Thu, 12 Dec 2024 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRI3Lp0h"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74987DDDC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967159; cv=none; b=HJOtysSHmPCswUVvauyJ8nBZqnXOy1OrkjUkkeOH5ftrvA+6fEFP5sKwA8Vw1aMpfNiOiabiHhwU6hkhsXOLqfujbFsywfsavaStJ5kXxkd9OlB3pf8xrdyD+e3FtmkB3fJjnC56bwqLTx8MTXDeVCoHbOwsef3oJenQsF7I3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967159; c=relaxed/simple;
	bh=HNsMTxzSM4Os/Bbn1icb0Zpox/VU8oHA6Z7aOqs54no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHpuAaoNGOmGftQtuLE5e8sdR5Vrqni0kW5TamBtyj4Mb4HNzz+rEBouZIS9FBgoaf1/GQo4YCgx5GXvHrVRxFn80UIU3gXo7B/kD0q9L7lx6zEDzZauG9Wm/2caBMa6p7dHfrd1wGFCoMk14O43esAQXa7WHjttqUsQHDFmPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HRI3Lp0h; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so65892a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733967156; x=1734571956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYW6QD8x26BPCi6ZwMNcJa7MxOLVr8kbm9ZapF+r2Wo=;
        b=HRI3Lp0hPsAnEc/4OBPgDu8MBUHKiX6uEMt6q5Qby8B+AJ3mFw9/dKUwc1NIictyIT
         4ZJFIkSJA8O5upx32vnUPYFywRrLKkU1YgYAClTUPzmfIBfW3WZPZ1Kj81zoCqde6YaW
         P6TnxJLrZuQ9KSwhfbsXjSvatDhTMfoy/T59z126ufY046jKwYSoQXIkdbePs32+enbW
         JdwroaLiRtMV0Zn5ZCYLNkT/X98osNXGAiXnLgNNcqD/PhoZ/4DMTTpLmNA5QheUrgH2
         1LtRBQPb/xDLS5kqYESgJS/YX12r3vgSSQ778a54FBaOJdDce14+QkP6sCR407A2rNww
         TjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733967156; x=1734571956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYW6QD8x26BPCi6ZwMNcJa7MxOLVr8kbm9ZapF+r2Wo=;
        b=b71j4IHm5esiw+MsQk+V78VsC9gm3LnovifWPV714bqpPS+osyu8RE28Bia7hJXu7X
         b5JsQSrc0cGf2Iva3mG+sqMod/i1jQxq10GWpwWHizoqhdvVIOYaVCCwnMupRdQ8F4Ze
         a/tpAoDpXkYR54yycuOBVHFFcUV2W9ZICUWmGZeCDAxUbToRIBfJIbxGhr4k1SKyDAa8
         tq0gisr0Nc6IX2sLbhLceVXiSTnUrlWicUE0x5kl73W7bmNCvxwzkdbUOQC76zD2ShmL
         0IJEQIeQ3ArL22ygSAA1xeOboLvTcmzivuV5Vw/+/txr7WNgtBKfFHmQi0pdzM+Nn5Gu
         fcLw==
X-Forwarded-Encrypted: i=1; AJvYcCVx8JOPKESQDs7ve1lH2YFt5dof/BmOz0cAeSIFKjpVwnPcmMl70NBys2omEn00xiEdRtrQ0saDIHGhZj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRbF0lYITlC7c2t0pAlzxU+g6WNST6cKS+606o4quIr4bq9iY
	4nM0Fks57OI04MNYf5zYve6H/0El/vByBhjYs6UnXRUqRnB2meODauZFYDvYkmE=
X-Gm-Gg: ASbGnctv+wjEXjkSEKYcSKVideYBZPzOjGfMOkXV3T6+LS3vDkTJ+gt1vSPP/cugYOj
	QwlirdKbD9PkdQAch3ibgcUl0trxjfhbQP2OLtwZWXYgdFWj9aFihFN3JK2g12QCB9DqC9xMthm
	ruv7ihtO6mBPl8bQ9/7BkHyGKjHdJBCzZD6CoyGKocQy2Aq7e3bqS5PSeen11eCEfBSyXY+dXEp
	M24zK9d84Hpx1JZuFpOM92re+O5hA2kWWTZyH+jyin63iVHPMgen+1RTwmoAEXNuwH9Ug==
X-Google-Smtp-Source: AGHT+IFJm5iLCRBwQBVqR2Yt58rdNbOiyVcfcJ7aOqvYUnTj2HXgTRYd9DKsSYmetmJtlgYL0Grpfw==
X-Received: by 2002:a05:6402:40c3:b0:5d3:baa3:29f with SMTP id 4fb4d7f45d1cf-5d4330a3832mr4211933a12.9.1733967155853;
        Wed, 11 Dec 2024 17:32:35 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49e48sm9676811a12.30.2024.12.11.17.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 17:32:35 -0800 (PST)
Message-ID: <dcfaf9ef-87bf-4ec5-bf86-5c432380ae9a@linaro.org>
Date: Thu, 12 Dec 2024 01:32:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] media: qcom: camss: Add callback API for RUP update
 and buf done
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-10-quic_depengs@quicinc.com>
 <1ac23fa1-fc35-45fb-9338-d5f304c869ba@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1ac23fa1-fc35-45fb-9338-d5f304c869ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 01:09, Vladimir Zapolskiy wrote:
>>
>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> It's unexpected to see two your Signed-off-by: tags, either one is invalid
> or the authorship of the change shall be changed appropriately.

TBH I thought nothing of this at all.

@Depeng for the record you can add Co-developed-by with my SOB.

---
bod

