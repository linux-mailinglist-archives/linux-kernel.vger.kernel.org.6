Return-Path: <linux-kernel+bounces-449562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3C9F50BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8EF1888E56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993851FA16A;
	Tue, 17 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzKGxsaS"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271A1F76C0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451960; cv=none; b=KhbjjoXxKChO0O4oCSdYUeKvtPbzcSO0gaFgEsi/QfZdcRiMJuaTpFAondkXeNWxv/QR76xY3AwXHhVRl9zJ9O64wiMNbLZbxUZz+uPjlHKwt6CGUVUgxZvYzbGd0ISZVvMUubk2CYIFDpwGNRd+JENukAJxst4e7abGyt32EgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451960; c=relaxed/simple;
	bh=sqzKG9IUExlr9KeYwf2YH/lDQlNJlbVgJNgZtw7i//0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxuvCXv2H4ESTfI1HDvJ0v7LKMoSUVE+llbTDqNlZl5ujY8pDD1XNCpptK6+jUIkUw9OkqrNEaA4AAEqq8f1WVDDAQlSITS4A56d76g4s1bopRRYix/G0G1VwV44uulfBZ7XeFmkx6UN+7LBp+BnMqYFlcPpy/Q4ws/h8pNd1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QzKGxsaS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso5978585f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451956; x=1735056756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0MSBSw6+OhbTrh1m9W9JgXC4AYYLnaI//MfIF3U6z0=;
        b=QzKGxsaSswGje4kZD0R4Uajytp/h/lQAEKFim8aFhWa+n32/EK0wf+zYoI5ZlP+v24
         iauG68+ofWySIyrDnXySuesBjw+5F/MSuRIJy15QGcW1zK5Gj2FMibX5LZKD47B1YEgb
         HwDHHiQYySWYkwX6TgR3nwRsG0ilwNbjlhkuOyiW1Oc9c0FLqvCISzG/aFWEmWx4EhuV
         eZYm2VY+RffJDJfxGnivgX2MO+sZtGH83SzqjbreeeiQNZAskGKr/fl1XAinCY6K/sHl
         2xvdQL30cfOIriDH1E86opyq9eb/YcKs94Cz5bySpYt2ddN32lFoQW+NDtRN/CSKgTya
         eJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451956; x=1735056756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0MSBSw6+OhbTrh1m9W9JgXC4AYYLnaI//MfIF3U6z0=;
        b=edU/33W2Y05IGoBk7lzaj+J8Iy9D8oEOTT25paQkc8y8ZGA8ul6C+0h5AUGqBdVwk3
         sRJTrYeEhcIVLJGgT/n2GomoYnfwV48sruLGRmqoa1ClNSw1QTxayBuUp4oxBvTUfqjn
         CjNzEfekjZZzLXJaBU5WE4ey/0jaeJ5wtm6bB7f0tPdbiDr3puHyKvqGhOhbNVrlYZwM
         9fvkPAvVIcmFfWknzSGnmtecBAmhmHt4ogC9ZdFsGoaodwxDmvGW2+/9JxL1LidgJVVB
         vo/TXQwqqsKJSL+uA8vNEOBTt5xgpHVHR33kC4y5ZnzyHzzE1WA+S6jQsWaQ7TCd0ZN9
         ZS9g==
X-Forwarded-Encrypted: i=1; AJvYcCXlZ4Wt5FFiCNbWF+CoyMMqvYRirjpQy6Bp6T4G2y9MbYNBcAcSFYJZWGkd81R27wsF1XBZgRuKuj2wC1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrfq3fJYo+J2HXje/g+2yVFDri0MvJq3qjG86g27HMZ6kYAK+V
	fCHKc5C8q25P8mOZ4DYLAeX5UxWIYC7y7vfE90P7oAydATGbxkVMo7/6U982NX4=
X-Gm-Gg: ASbGnctw5LnXFs89XmDiydzZscf4WJDOnuF/thIammwrlY/l7/oO/LSAfKFTv1n98mR
	KOXnWYYpVEdKspE44kdBU4QIXG7VEji+ko3X+4vFQ56wQm4pZ0gEoHtNwJblefT5PpWw++H6bQz
	mqVwqsOo2X15rz2qdHo9AeiTyT2o2SLQCRfOk29JdYG/AIZvYe9UneK7As/28Y21xpGkrc3/4nq
	7rK8DJbwCFn2cMKdbokh4O6U7Ps3dmwGDmZ40nuEswHEHhR1RPGjZGxpZDUvjth7ZRgMA==
X-Google-Smtp-Source: AGHT+IGNQ7hhBEySJuTG7bF8w2ZzmrZV4ZxMbtUaczoA4N/EwDXYjOiMdMzulLRJCZ/qQh7rX7Zo2Q==
X-Received: by 2002:a05:6000:18c6:b0:385:fe66:9f32 with SMTP id ffacd0b85a97d-3888e0bfcc4mr12807413f8f.52.1734451956514;
        Tue, 17 Dec 2024 08:12:36 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046c05sm11739012f8f.73.2024.12.17.08.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:12:36 -0800 (PST)
Message-ID: <c14493b0-c9d3-4e1c-9f86-991b4cb25c98@linaro.org>
Date: Tue, 17 Dec 2024 16:12:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] media: dt-bindings: update clocks for
 sc7280-camss
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, akapatra@quicinc.com,
 hariramp@quicinc.com, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, cros-qcom-dts-watchers@chromium.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241217140656.965235-1-quic_vikramsa@quicinc.com>
 <20241217140656.965235-2-quic_vikramsa@quicinc.com>
 <02da691b-1f5d-41a6-847c-c7e9b8239919@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <02da691b-1f5d-41a6-847c-c7e9b8239919@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2024 14:10, Krzysztof Kozlowski wrote:
> On 17/12/2024 15:06, Vikram Sharma wrote:
>> This patch change clock names to make it consistent with
>> existing platforms as gcc_cam_hf_axi -> gcc_axi_hf.
>> This also adds gcc_axi_sf and remove gcc_camera_ahb.
> 
> Don't combine ABI changes with some less important things.
> 
> You miss here explanation why doing the ABI change in the first place.
> Without that explanation I find it rather churn. But anyway, reason for
> ABI break and impact should be documented in commit msg.
> 
>>
>> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
>> ---
> 
> Best regards,
> Krzysztof

This change should be fine since we haven't committed and upstream dtsi, 
so there's no ABI to break yet.

Agree the cover letter should have been explicit in explaining.

---
bod

