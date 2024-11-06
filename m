Return-Path: <linux-kernel+bounces-398380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1E9BF097
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9F61C22330
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899C1DC07B;
	Wed,  6 Nov 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3hrg6Hd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53999200CAC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904356; cv=none; b=JfcZ490cxjb/Xu1ZoG2LfZSrWRD/PfUDZxQyzV2ZMCtWdwktfEpZuKzt+c+XIMam5+hUy+Sugr3IgyU3BtqBBj3ulFLV44q68LUbbXr/R8pkl1zq91wnEah+lYXtszZFXdvOeApVSD/9BlRAjDvj/uB/krkmZbcmm+hMivIPq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904356; c=relaxed/simple;
	bh=NIwwnOJ7VDJzCoeJ7q/5kkeOpNPHKX7H97WF8KuhyzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIAPwTL8J/x691CfDH7YESQr21KfbO3AR/mfVKICqDJAHt+tWvqAcpnl/N2zdctQuAlIrB01MzaYjcioposO0AkYU4XOfxhtMxppwfr+FLKmVNAM7yL9VGRqfTiZcxB35P1RgUYBMQ0fzgMn62Li06/A9c38hP2undV8f3SOg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3hrg6Hd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso5978015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730904352; x=1731509152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8QE+J/MUl90fr1k+pjzuWCIKEdYrTZK5ku+2+au8m6g=;
        b=A3hrg6HdHPTFWWkDmzgE/uABjUsLYjAfk2skqwHr6htGrVH6LAPPc5pwuCkpcRvT6Y
         +4EAhJlFek85Chk0qbJfwkFMGHBg96lt3XQDNANPzwf+OtuhkTflUO0a1YJfBFmuqBY8
         eWCpXvdJ8bvPgkTL/hRl1BVnW11brtWffxhXtBHluyKH0oayV2O7T/B9YjGHs73/u8dI
         Uj5LsT5BpOvYvbGBEJarBs8ZiDHIQYwbBInpou37PwNHvl7m8jhSnKVW8felEq7RZpLj
         4g9ZhY6a54l3xDA4uGZ1OxE8DyrU4c4D+9AmxaCSmgGyK37OR0XZa0cyQ/QqStOv6CR7
         kGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904352; x=1731509152;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QE+J/MUl90fr1k+pjzuWCIKEdYrTZK5ku+2+au8m6g=;
        b=AJLhUEYQcgUZ9cugpXF17Jh8Rwk2UkS196jiOOqmQvFsVJzb2AMdMEf6vJqfylLz8L
         Z3upUkpGO4LBtmnvy1qAg76Pr8GVWdF8jRI9m6+EHGOxOI6A25uFsKMpry5M8vJBlhqK
         9gsVObxZLCHX1W5Nq31+BGVtNUosNjO9SWCbE3LFxQQ8HSTWw44QOmqhxok06Mho3CD6
         kOkKfsIzqgBSBX/OsiZKZJP2Di/MG47VCFezlOK7fEdZJzglCA16LCTZGB1X1yzjPV2I
         HGqHjJBlM4BDzMVgpUYWafqV16/ygmR8Kls14ffuDrczeO1QOBHoRMOtmz85q3mnTn4p
         xu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgA+eweSzFiuYpphXr9mcs+4xy6J3W4Hp3g7lTN8S+ik/WTzZ+QmdWenzc/sTxJK4jmkrvpgl2LJfg6l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7TZr1cbdg2xNbmGqUWa9Kli9k6+MxvzsfX2WveaKrsLtaGJU
	o0LQ8S5TU8QwH1djzluShGlu20flvtNk4ObElUAGmaE8bK/eMEf3pnMPJfUBl9k=
X-Google-Smtp-Source: AGHT+IHTC8YB+104SGMNaJvSSsUBF7Jns183stPdUQjc+afzc+5XBHOdKHfqwF26pT+CVg4/tI45ng==
X-Received: by 2002:a05:600c:468d:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-4319ad74341mr158179235e9.9.1730904352565;
        Wed, 06 Nov 2024 06:45:52 -0800 (PST)
Received: from [172.16.24.83] ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b2a3bsm25743395e9.11.2024.11.06.06.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 06:45:52 -0800 (PST)
Message-ID: <52f9bfc5-b2c5-47d0-b790-913dc8a8631e@linaro.org>
Date: Wed, 6 Nov 2024 15:45:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add dt overlay to disable
 icssg for Linux
To: MD Danish Anwar <danishanwar@ti.com>, vigneshr@ti.com, nm@ti.com
Cc: conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kristo@kernel.org, srk@ti.com, Roger Quadros <rogerq@kernel.org>
References: <20241030114458.1358800-1-danishanwar@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241030114458.1358800-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 12:44, MD Danish Anwar wrote:
> Add k3-am642-evm-icssg1-disable.dtso overlay file that disables
> icssg1-eth from Linux so that icssg peripherals can be used by
> RTOS or some other OS running on R5 core.
> 

I first approach privately but you deny, so let's make it public: this
is based on some old kernel. Please don't. You need to rebase and work
on recent kernel.

Best regards,
Krzysztof


