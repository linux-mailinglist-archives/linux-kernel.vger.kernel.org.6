Return-Path: <linux-kernel+bounces-442181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21639ED914
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEA91882D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE61D31B5;
	Wed, 11 Dec 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTYsyoXA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F31C304A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953888; cv=none; b=TymV/bnyzRtVHYSW+5bltz2Fu68CHYsIJDgdV7DWxkbl9EOhJqX01dZnuem8l5tJnudPMWuWhKgpjPXGfglO+zau6abzqgMJhEoBJC9OlM+Y6NtylxHNNaEWxWy6Id/7Addnl3K5aklHdE9iXwQD56VRAyYb+xkipdrbtEMtOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953888; c=relaxed/simple;
	bh=+yXy6BdoGXWelmBPHZc9qjX32NLjGhezQ6I9xpgzboQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSuKV1Ill+RhDbenw4hVEz9uogbRirhNLZ1WDSlRSmmiO12kncmne/T4QGhMSa+SZ1zq3XWRxeYLwKWgrHjZwQRYXclmNhv3UfF1KIpm6fPJdOGGlL/L4A7ez77so7G/WK1rTod2jNLkT0EqpkntpzXxXdQ4urLS7TbZa930tA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTYsyoXA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a766b475so69050365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733953884; x=1734558684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYzZ2PTeVoUiFSlhq2/NIk9JdJyxHxV5vtC1J1yNmdA=;
        b=jTYsyoXAwzydUppFwqJbLYePw3LsROjGZ2CpwhZDd+Y96kIdriPcF3eJL1Ni0i5eE3
         zl83iTGfma+BvaQkdp1i/vnziGhYoJtoG4MoCqwxOjOMbJTmeYcWXBKmg1IcGEgR994i
         Pl7sYVexMxOOK/lBUb582Bm/O1Oy48dIIbPZmlAUvYDIe4Yeu8Q3Fq3FFH4nuEQpHn4u
         HkgYkvCiRkoh4GJj57MEwqZyVYLBxFjtCSxNa5CA5GwxF4kgepWBEvTnA7wMiqmywBVg
         xAhlRAEMhMIUgSIMS5dGCjyo/7t5BeG/WRV9gKABMdd7ZOOwr3o3laEZnqxsnOFd5bi1
         vLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733953884; x=1734558684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYzZ2PTeVoUiFSlhq2/NIk9JdJyxHxV5vtC1J1yNmdA=;
        b=QRB7j3k/wkANjwimd0RXRA/lWiax/akOuRA09p1wO5AhZ/FsV/qBw/FY4oF61EHao+
         jB3aQh/9pUQ25R8cQnx3ZQBbpHTSK5Fxz0p6Hz0f+PDCdGMzNBkqsbg+rJFpMFyhQHmW
         dcs0u/dSG5f/6XcnbkziRiy8w/WfYsxs+KBrLiLJY9Z5ISmEIPkYjxc8HZZK21TNAa4d
         CkW211gR1PGYDmjKFL86QENyMrZ6xl36/6q1dgHHxO6YZ4WQwSQSO7Yv1exwX2gVTdMI
         KRBBzq8Gn0/k1fCAlNi21D54Nz8JV7mlbPLUGsQ5yLLOmZN74pqpDSrs+5BEyz4E2tC1
         JP/w==
X-Forwarded-Encrypted: i=1; AJvYcCWo6r5anZ0pKEyWOZWpyIQZ7rc3LHzaKRxNvXQaIXdN+xcu5VJAM+xgKcHW84VD0R/omAEtm0jOB0L6rew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy860zdqff/lCHBEAa0C2HStgpEM8IyvQ7/sLHxjMGWyi6weMX9
	45JK73d9kswP/VPC8NuowmrOfq118qWXtv7ncSOjHhbe/PONR9/gZT0tFU+UNH8=
X-Gm-Gg: ASbGncsPUZVWkhU5lU/Rhu9nZdcQ/NMOa5jQowsvkiOjrKMe+jwgqcP17CqJZg8n9Me
	BFaEDIs6yjvgH2tTZephnxiHgZpnPui74ALdHY3FBX1SLzPl3CNhwy7hfDEwGe1Hidya+bBkPO+
	+90w7uCcrA8Nupnc9M/x369zGTELhsMk/UMKrATix44lh0W0k3yOxHj51LXn/pQ3SVIeYuImsws
	TUi8ogXcR15rtE0ucLl98gb53v+Wg5fCTlp266kqBwcNWFj9Y/d5gyc4q22x7Mg6tw=
X-Google-Smtp-Source: AGHT+IERXM+Ul/wVHE5MSVkvGGBpzhvPZr2RXymggc+966GoIeTF4nY9lep+HP04CYzBcnnukQoIDA==
X-Received: by 2002:a05:6000:4609:b0:385:df73:2f18 with SMTP id ffacd0b85a97d-3864cecfe06mr3576948f8f.51.1733953884252;
        Wed, 11 Dec 2024 13:51:24 -0800 (PST)
Received: from [192.168.0.27] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119abbsm240218815e9.43.2024.12.11.13.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:51:23 -0800 (PST)
Message-ID: <3108fcd7-7b6e-4205-bf15-529c850e2b5f@linaro.org>
Date: Wed, 11 Dec 2024 21:51:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] media: qcom: camss: csiphy-3ph: Add Gen2 v2.1.2
 two-phase MIPI CSI-2 DPHY support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-15-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-15-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 14:07, Depeng Shao wrote:
> Add a PHY configuration sequence and PHY resource for the sm8550 which
> uses a Qualcomm Gen 2 version 2.1.2 CSI-2 PHY.
> 
> The PHY can be configured as two phase or three phase in C-PHY or D-PHY
> mode. This configuration supports two-phase D-PHY mode.
> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

