Return-Path: <linux-kernel+bounces-441532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4E9ECFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11888188A919
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2F11D2B1C;
	Wed, 11 Dec 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5SCX4mq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40A1A76D4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931384; cv=none; b=uDFGxes915b+7p29f1hF7fLT9bOzn4dUdU7bb7jd6ZL/oQIfopUljVb3y4KYRRSGkLXZri5UQ/edjDW8IbBcZjlT7fazGMB/ViJTG1gFFrPePJaFWATe5T2C0bJSCmZdOnniAXRC4Wl7Ro2XbbrLXDBDeC3LHNotgWi7RL7Ljrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931384; c=relaxed/simple;
	bh=T2LCy7TaoiKqJOZvO21IBs0qwYbo5Fc1sIddbn+N978=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4AJaPLhM4nh5K86MwRJ3uoN0fPUT/ZA8IfGAA+jCgbma5tDa/p93GdCjcvfa8MbztsHbN2ON1UVfbU48LQ5vRpPcX6kBrpmo9PbygVEFhz9p6ya9HymKU0hKKcGFftDumBIug1wDZ/73t+N3YQsmV6+mT8BmOhpTIxdsdobLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5SCX4mq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so8336117a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733931381; x=1734536181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5P83OAh9oowkPZhX/FCrb2KmUC/mQW6tgdnMEWWNNc=;
        b=u5SCX4mqf2ye/bldAr3V2KYo59Ced9hXW+xwbHJd3SpnI0q5xqmD79GnqVkribQuc1
         RG2l+JFCJLRSfnMtFQqO6rD91tRxAujYJTENy8q3E21ScM62vokgSCo/a18oivJZLMHq
         v9m80on1w/le9hf+lpKzDx0CPag9KgwmwHD8y3sq4jvc/6XAo3yjGba6qAWOHlIkU8ML
         p5lqMAjJF30x3NJpKcLdTAL84VUu1gn5Wj0UEsdiR9FOJR/r81e+4rzaZcvEQ11uciIR
         2Gal/ZRTwI6emWcbcqpowz6NPf6ur3Ip0gse1n2u9ljAe5z5gojxpOe5Tuv7tCyXYWkN
         yJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931381; x=1734536181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5P83OAh9oowkPZhX/FCrb2KmUC/mQW6tgdnMEWWNNc=;
        b=Qi+atRVKNPJUsojTmc99dMwP4JPl6YaAdpQfZdMi2O5gVlKBFBM7y1WuLOX32RxgnX
         ohKi/lA+IMOcKIjJUdH8IOGIZwN/VOWJZb8RZ1dCxXpo1CD2vKuHlzEQQQf9E06fuYOT
         HH2RTFLrXRjUkL3br9Q8XlBbUyR3QAvG5+nPsKh/7hKj017WW7DX3ItmZetzypo6VsL2
         Z8vnNsP4KZ8nY+jzmPMvs4bLKOiDSOi9Ve7U7c6p8z2lJ07wvwONzMBnxFka6tBIDl+D
         CafnU8gCPQF8vwKz7qbCLWMgiuZBjq+AETXCprbAgb8THrhbtJbXov3ll7wRy6aLHGTG
         wDkA==
X-Forwarded-Encrypted: i=1; AJvYcCWXWLYqgnwUYnQJOL/IV8pJa+haE48sxjpBZkmbufYvreEnLA8WxLmHgU9/0Txpzxjf9HBXB3CcP2E/tMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvycBJNlPYEUNIasPDepGDFdAVp4HS5V3rhO+KFzPNTSKsGTK
	ANwfv5lYgYh9tGwc1NQatCCyNHJ23rSgy1fz5m9yLv7U82IgZuwlv8f9+TvLDhs=
X-Gm-Gg: ASbGnctGW8SV0i1eu8C6EOxvux+FK6ynCbtrg/59KpCV+RLySP3SkjRQMrd2qOpiCtU
	nHJqK/EIsSY6dJDvcnjzHyC+ngw/MGwqhwYdPFV1VLcb5ibCQp8PV6HQtKhS+JrcI3RXw3y1WWm
	8UiAUkVIms0ffX6TbDiLZR1y9wNUqwWOkb5fmdbbTTYFVXiv5qAo/h7BqIHigRoNRYKf/L0h14y
	qhrx5hCC4OnYcBdfg02zxkTghV+6ZjFzKyauQNwS64kW2imMv8u3TCKtDWH7E7dl9E=
X-Google-Smtp-Source: AGHT+IHatiBoQj6Xuonudb8Upnrf8L1LWgUj0MXYi4G2nUPAC3KEoRXoMBGg29UMXHdRgWC0yX9McA==
X-Received: by 2002:a05:6402:5386:b0:5d0:c67e:e26a with SMTP id 4fb4d7f45d1cf-5d445b0cf92mr37496a12.1.1733931381459;
        Wed, 11 Dec 2024 07:36:21 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ef026a41sm5541772a12.15.2024.12.11.07.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:36:21 -0800 (PST)
Message-ID: <12704563-f2d5-4e2b-a6ad-53b8ab5c5df8@linaro.org>
Date: Wed, 11 Dec 2024 15:36:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] media: qcom: camss: Add sm8550 support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-1-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

@Depeng.

Some of the patches at the top of the stack here - won't apply once 
Vikram's 7280 patches are applied.

Could you please rebase your series with Vikram's patches applied and in 
v7 send a link in your cover-letter to highlight the dependency.

You can get fixed up shared patches from my x1e tree here:

https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/arm-laptop/wip/x1e80100-6.13-rc1+camss?ref_type=heads

---
bod

