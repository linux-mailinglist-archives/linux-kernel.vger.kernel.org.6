Return-Path: <linux-kernel+bounces-346011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3A98BE49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EFCB23002
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12551C57B0;
	Tue,  1 Oct 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyXGDWZK"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16017FD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790468; cv=none; b=MLnndSQkZJs4ALZWpIsSTBkPCWRwlL4H7eUHXSp8zXwRPqIS35q/MGP31JLYrSkKz69Rs81Y+f1RCxSFcQi8Mq8/EXtMLYbvHV26Wce3EqYyWW4QEna7ZVnsoeZks7kIQ45upOIXUmo5sgIFsstdcN2/MXelD6t3a5yEtzQE/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790468; c=relaxed/simple;
	bh=7a8xwjon7m5Sc1PRKs5XA4FWMWfbFUdhBQa+8zL1vbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Icl75ozu9kcj1fxKjtKIogvI1tx1uVExGd0KGYTJ6fwW4f0+vdc+RFKZ7Bv3SHxgpLBX2cNzVYYbYvmbWog5ELJ4fzzsxPRnXHRuifL7V7ZvAZ4nYYw0WSxHa4E1VTHYvROG0R3sCeVsPd83I92pReB2iwV2c17FejYapX+DLOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iyXGDWZK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c8844f0ccaso5328549a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727790465; x=1728395265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hznvRVGa0+vAbTfd7hLLkz8ohJgvQx9/WOhiN6JASY=;
        b=iyXGDWZK/c+2ZE02yaHdBxy3ukZHf0qADj00RFI5roBWw7R/f3fltlB84QOEKtX0Ps
         wY/8BZ03aiAQeFq8Ob8N9dEZs0nBZPhSskwd+Z1Yk85x/p6t3nFMOZgMTV6Y/rdyPh3i
         UYYPXsLyGYRWxtdBZH2ImJ8LdOpgE6ACwisCkWQIwm/yp9nGUY6WEaJ964ON/jRrabn2
         4QI1jI17CtCi4rOuZmJ7A1irXj841Wg1IPpIvrG/CQkNquAWf1oGFuVOdyZwYdV7nq6N
         z/3YbMS6dMVALWw5O3dmrZE0GAS0+L86FPX/KuXUnDh5LEG/WAD2kCTG6EFWCK9xHT2u
         t7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790465; x=1728395265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hznvRVGa0+vAbTfd7hLLkz8ohJgvQx9/WOhiN6JASY=;
        b=YIKWksQbJuAxvPrmTKXvdeHuo0scbmy6vab2KSrnUos53osDr2CtY9NBYutlsfXDSB
         Xgn7eTQ6mbkIN7EqH+QM8b6+PT9oMqiGm4AG0weyQqYdIqlVGbr4++lXIc31j/zymVaw
         7ayOwQm6S8je6cAopCiHsep6PjqcBbl4o88rfreYygJxnuUHiMyRbeD0EvcUapXmzwKu
         0kzhcXM5dywWburfR++9Wu70s7aimiZIuwxn4+RJRMPfUB5K/eY7YdLA3f9hofxxhrvi
         FLEQ0Ux3oe2rj5QjCd4WxuYqVb7GNQ8FYfh3Rj8FN68/z8jepYmygmH/bZTb+qnCjj0O
         IC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtGTjNHweFcovLbliiuSPx+kcBfI+r3LG5yoEkK8wcXA9BW6X8QYD7a19a42wuDF+E/pk4q40D0bTc5o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4Y0D+g297I0grM6t2WmlYyfzO9JZRGTl+KBBoK9pAm4kpRlE
	Lj+EmmFhQwuVXgAWpfSR/7IlPT/WxsQMoK4540sCtsd7k9sWsqZGf9vdjOqy8To=
X-Google-Smtp-Source: AGHT+IEbloO9yBhCfPYYLDsu9/VylS1HFiqNsqgLhe5KNm1baA5fLjMzPkXL7SXJcHileo0F0AWScA==
X-Received: by 2002:a05:6402:50c9:b0:5c8:8bde:a1c1 with SMTP id 4fb4d7f45d1cf-5c88bdea2bamr6843576a12.9.1727790464738;
        Tue, 01 Oct 2024 06:47:44 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882c7d23asm6111494a12.32.2024.10.01.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:47:44 -0700 (PDT)
Message-ID: <95d7d695-89d2-4c1d-99f6-4f9a687f7d13@linaro.org>
Date: Tue, 1 Oct 2024 14:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: dt-bindings: Add OmniVision OV08X40
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jason Chen <jason.z.chen@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241001-b4-master-24-11-25-ov08x40-v2-0-e478976b20c1@linaro.org>
 <20241001-b4-master-24-11-25-ov08x40-v2-2-e478976b20c1@linaro.org>
 <Zvv3kM1wWDiRCCiA@kekkonen.localdomain>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Zvv3kM1wWDiRCCiA@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/10/2024 14:22, Sakari Ailus wrote:
>> +  assigned-clocks: true
>> +  assigned-clock-parents: true
>> +  assigned-clock-rates: true
> As much as I'd like to see these mandatory, there seem to be cases where
> they can't be used. Therefore I'd leave them in the example only.
> 
> If that turns out to be the only change to do, I can also handle that while
> applying.

So I took Documentation/devicetree/bindings/media/i2c/ovti,ov9282.yaml 
as the reference for this.

Without listing "assigned-clock*" in the required: field I believe the 
dts checkers will not require those.

So instead of saying
assigned-clocks:
     maxItems: 1

we write
assigned-clocks: true

omit from "required:" and get the desired effect.

For example this passes the checker for me.

&cci1_i2c1 {
         camera@36 {
                 compatible = "ovti,ov08x40";
                 reg = <0x36>;

                 reset-gpios = <&tlmm 237 GPIO_ACTIVE_LOW>;
                 pinctrl-names = "default";
                 pinctrl-0 = <&cam_rgb_default>;

                 clocks = <&camcc CAM_CC_MCLK4_CLK>;
                 assigned-clocks = <&camcc CAM_CC_MCLK4_CLK>;
                 assigned-clock-rates = <19200000>;

                 orientation = <0>; /* front facing */

                 avdd-supply = <&vreg_l7b_2p8>;
                 dvdd-supply = <&vreg_l7b_2p8>;
                 dovdd-supply = <&vreg_l3m_1p8>;

                 port {
                         ov08x40_ep: endpoint {
                                 clock-lanes = <0>;
                                 data-lanes = <1 2 3 4>;
                                 link-frequencies = /bits/ 64 <400000000>;
                                 remote-endpoint = <&csiphy4_ep>;
                         };
                 };
         };
};

Eh.. at least that's how I think this works.

Krzysztof/Rob ?

---
bod

