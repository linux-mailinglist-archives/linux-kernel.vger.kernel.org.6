Return-Path: <linux-kernel+bounces-300131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9A95DF26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E481A1F21CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293047A66;
	Sat, 24 Aug 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbgGzLCU"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B49364BA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724519130; cv=none; b=Lr/VfNeSlSC/kXcqxcAyMZ8ow+wJhehXv7s1l53Fqzyfg4YKsTgC1ZlavncaqaY8SZDAJ2iHp088nTeUY8jHTv0D5rWsBuhQr1znAG6NKi/NFBsyGbg7TVot+tEapxAjtZ4pI1+cQZmQTY5tc3k0ig5ryCMYEuNo2UeffPRh6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724519130; c=relaxed/simple;
	bh=YZb3KQcDwKbRfBpA1jL8YOTnhsu2wLksJptIPtsdgs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQbd1dTegle2kA66coIpOErmeo4qN87F04+rFRLrNfwGmuLDXbi7wmmh6wJ1IAVBIGkpw/NOAkTm+gNFKwjgt5CTUKZ6A9p8jTs7xwI3Sy06cRULQRbXVBVNc8XMjf8fFmi5jEJ3U82hxpry9rUCX5xknyu2aquutan48vsHiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZbgGzLCU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so3703829a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724519127; x=1725123927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1wqIXwilhWQe12ivt8ypdTnldhiR6eZgAaKOzl3oFk=;
        b=ZbgGzLCU8NeN1kyPzEfZytA/xl6HaCYC6XtXQdS89SSfavtANmLmWN9q/H8Q1s+xyj
         ZNOTBZZknjRbAjkX3XROvIuzLxxUaXaCZ1tpBQldyjM4vA1Dm1+k2xvwkiiG3h1V9VTQ
         8puTMyY1YDu7Lpw5HE7PZHdLesG55ApEmHWTCb8HSAfEOtv0MpQ3Q5TMgJ0+KA0lAXrL
         k2FfYM+S1pa5cVeZyZZ4T9YKLXpLE49thy/d9eMQdDts7KGJE2h/g2rna75gVzut8v5M
         7ylGX4TUhp7xt9BP4by0Zn7hfo4e2gontjVu143Ex/JR/XgReUBT4tdVVsrPITnZr0ek
         dS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724519127; x=1725123927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1wqIXwilhWQe12ivt8ypdTnldhiR6eZgAaKOzl3oFk=;
        b=cU8B6MqOEsOnCVlkv3NtKY5jHFfbAKcI0wl7is1TlSeS3jAGTWC2j0tba8bm8N29u8
         9LoZCgVBuI7Nk+QVDZlR8hhH3DSntYLOhM7Mpg+HCPjMAku1MV3rBXToI39pBMVfM1lh
         l5h8PF+Nk3sRLRxH2jN7WLS1cFg6nLdi5QvlhrAAUrOZ9wbfupFbqqehfd0dAcuScV3s
         6Q7tSyDFFTPXMP0xbREyXFiNOqdXe7kVT8UOu+LZ77zPXsESsWPqzRzL2YQ0yDv3YVgE
         DHRuejk/4ZUCd1mCjEC1KW5QQoeWnSl8X1GdgiSyUsMKEjvPOaBrcMZ/wEdGKPC8PScp
         W9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXz9ElcygMrmX2oo3Taw5dn/AcZA8d+bj05xRZzdI2KTwPFfkJNbd0QoASp8OF2Ffe33qo80DXp4HswUfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRk5MDZuwzaj79oi4NxlKHAffkTc7biwuNB1NF1oQquJWEnB2p
	J1uRGo070lgwY1YMaq4wAXdPUoDXd1bD1HX9LSxi3gp/N1ijA/bFZVA6KlDceIg=
X-Google-Smtp-Source: AGHT+IHt3Su7ap3ryr5NK4u0osd07i4VrChxnechoJXjiVeQ4wUl6du3KIaeBLPXMzicWs8zA0kISA==
X-Received: by 2002:a17:907:d15:b0:a77:cb8b:7a2d with SMTP id a640c23a62f3a-a86a54d1920mr377553966b.49.1724519126872;
        Sat, 24 Aug 2024 10:05:26 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43661dsm423115966b.100.2024.08.24.10.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 10:05:26 -0700 (PDT)
Message-ID: <26b7fd84-34cc-485e-83eb-21daf99020ee@linaro.org>
Date: Sat, 24 Aug 2024 18:05:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/13] media: qcom: camss: Add sm8550 support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240709160656.31146-1-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>    media: qcom: camss: Add CSID Gen3 support for SM8550
>    media: qcom: camss: Add support for VFE hardware version Titan 780

Before your post your next version of this series, please make the patch 
submission titles consistent.

e.g.

Add CSID 780 support
Add VFE 780 support

Mixing SoC versions "sm8550" and/or including "Titan" - what's that a 
reader might ask - should be avoided.

No harm in including "Titan" but if you do, include it in both patches 
and explain that Titan is the codename of the camera block in your SoC.

---
bod


