Return-Path: <linux-kernel+bounces-439111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27F9EAAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061B3283BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69C2309B5;
	Tue, 10 Dec 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgvBjpf5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECA22D4CF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820310; cv=none; b=Ap+NH4TI38MfSYEJv9AgnoBwf5QYBfj2vdZo4Ub7OYT5N2uguPUQk/JLjG8CW/8oEHQedlL95yM8zMNPfGC5hN9Syqaa+GwT9tM0X15cbYRjCcRWg2YarfxSbpfZdlO6x8L8fjF7UOLnwQ4VB7MtTktzybE4zqzq6CzyuvldUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820310; c=relaxed/simple;
	bh=+x1Mft7oUP79FmKr4fBecXE4fgVs+62YnJHX8KLkmQc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XnuOGBYzMtPXPNLLCP0LSb2GKrj7/Xt+uAA2PSvdl66l3BdraFFwC4FS7rKjdNydPeaI2MzPCIJ7O33TzL+R6JnB7tZwc4bYsGaZi+AT2bA2o37ue2L+9+1dL1q99WkIP9DhMb2YXvRcR1e4PxRlIM5EpOuAZEVvTGfF31lLw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JgvBjpf5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434f239bcd6so2005965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733820307; x=1734425107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EGPzafJOEdoHb7yCUcUHHdTxZLNCJp4WwMrLYstSYKE=;
        b=JgvBjpf5l2UtQsOsfkXWGV+beLKiUPAycrVMqVUPGwSgPojhHdWDDbZI2HY19WTLfV
         6ZYCWw13AyNqKaMYeqhHw+Fs4t2c3Ux8XO3RO8Px6pby9kz/1IISBUqwnc5uVw9OV7wB
         hozyD4meDqMP9fXNTlVh49vXmrjOvd0+r2NTYaVrtHnjuZsUlmxcHexkjUW+I2X8nKTS
         H7ilfv+cDt68wVA5dIKaiDnNBNcxXQlTIL8EajqAeCgTPnA2r78W6lj7XyrcBfrbtqTT
         0JmrIyxEhG4f9NOSV0W/8t+YTxS/UHpeZHC7SMZOi+6nOo9J5uNIbxOqHsO7yU+Im4Tt
         pGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820307; x=1734425107;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGPzafJOEdoHb7yCUcUHHdTxZLNCJp4WwMrLYstSYKE=;
        b=OO0kRMxN4wWMb9OtL6KfGw53eM+n0qD0G0NjHZ8J/arBItNwoU+8yd0XumYpF4TL1q
         D//QKsVne769sAWqcO+p9fcxWcTbK91T74tmV+6tWqnnxKCjx2pkbM/mt2UvhNDomwlj
         GFRsI7u9nw6BFjTiey3CjJpoSoDh1mrZ9YPqKZv6c3gptsP29qp9Qexg9i5It6sgcjaE
         05BJEIHHHFsKrVEt1f9lkhXQsGa/tcR3Xpu0KsPtot6GfPGbSubGW3kHAyT/MSzTO12C
         5VCOIRJ313uqI5fW/MjtB9FQsk3sMBBlh4ZyrJjfTZgPxVBr+BNwL9WAyc01f8xwUVxZ
         4Olw==
X-Forwarded-Encrypted: i=1; AJvYcCVUFxSbXodjTu4xGn8ckBSPB/lf2Aji9TXO59BY/G2L9nuxARN5hZyI2YHmq3B8VJ2B1NqTL258o/wMjgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwqGZLkRa+/T4NaDloykOtRPtQNSwx2iSYn5q3Hvw/N5EuxPr
	BO21VJI3gdrg52KrnL1o3Zr9lyLRM0ZH1QnmE/fdELX6WlCs7EUbtg708JE08C8=
X-Gm-Gg: ASbGncu6BClrkPWZj2Prt6e2Mjkk408Fdz170IXwVnK1pgN37lf751OuQ5yil8PRsmz
	0+QIA4ugT3lG09ExltI314/jmBOWMPTUx7UTEpr7geRw3Jns4l+ynUIinHC/CoVzhgFeS5NwUkO
	DNl3skhiYw9em3moTKlE6985X9LFcb4yIBrhRpTz4W77gG54SZcB+wdHXYvHiYZ40XNBB3FzOkJ
	tnP92vDloxHk0yKLbFGKB+Ze5sPMhx3aLOjxBUNvE0PXGW4wtI3Z5vJ70RJlpSCD4Ixu6EKTg==
X-Google-Smtp-Source: AGHT+IGIbVpoRmpF/fMTJFNEwzOHMG59iwFgI6N67U5I2zZMBPgokITH6VMHyBfnG2hgq55rbdMOGg==
X-Received: by 2002:a05:600c:1c28:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-435019a81abmr8545715e9.4.1733820306820;
        Tue, 10 Dec 2024 00:45:06 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d26b0sm188531705e9.9.2024.12.10.00.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 00:45:06 -0800 (PST)
Message-ID: <b8c1c4d9-3234-4184-b57c-8cd5cb18f815@linaro.org>
Date: Tue, 10 Dec 2024 09:45:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?B?S2FybCBMaSAo5p2O5pm65ZiJKQ==?= <Karl.Li@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?Q2h1bmd5aW5nIEx1ICjlkYLlv6DnqY4p?= <Chungying.Lu@mediatek.com>,
 =?UTF-8?B?QW5keSBUZW5nICjphKflpoLlro8p?= <Andy.Teng@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?Q2hpZW4tQ2hpaCBUc2VuZyAo5pu+5bu65pm6KQ==?=
 <Chien-Chih.Tseng@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-4-karl.li@mediatek.com>
 <083c8f7b-0969-4ca3-8a91-35f5767c5f32@collabora.com>
 <CAGXv+5Fw+qZhTTgJq0QdiQHgiQP2ByR1tgae2+k4erx+0fp61g@mail.gmail.com>
 <a3c3280478bf86eb97a422782ce60ec4eaa35224.camel@mediatek.com>
 <0f98405c40530d81c342af06dea593e7babedeac.camel@mediatek.com>
 <cf75f3c3932ddc50f5697bc4f394bd77fc16cd39.camel@mediatek.com>
 <0d23ccf9-3420-45bf-aac7-5c1a075e031f@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0d23ccf9-3420-45bf-aac7-5c1a075e031f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/2024 09:44, Krzysztof Kozlowski wrote:
> On 05/12/2024 08:32, Karl Li (李智嘉) wrote:
>> On Thu, 2024-12-05 at 07:05 +0000, Karl Li (李智嘉) wrote:
>>> Dead maintainers,
>> "Dear" maintainers. Really sorry for the typo...
>>>
>>> I hope you're doing well. Just a warm reminder that we're following
>>> up
>>> on these patch and really appreciate any feedback you might have.
>>>
> 
> You received like 6 or 7 reviews/replies for your patchset. What are you
> implying here if feedback was not enough?
> 
> Respond and implement the feedback instead ignoring it.
> 

Ah - and obvious static check warnings as well!

Please run standard kernel tools for static analysis, like coccinelle,
smatch and sparse, and fix reported warnings. Also please check for
warnings when building with W=1. Most of these commands (checks or W=1
build) can build specific targets, like some directory, to narrow the
scope to only your code. The code here looks like it needs a fix. Feel
free to get in touch if the warning is not clear.

Best regards,
Krzysztof


