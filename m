Return-Path: <linux-kernel+bounces-432905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B869E51CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DE218824C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876D1DF75D;
	Thu,  5 Dec 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yd1WbUu3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAA1DF24F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392401; cv=none; b=kdUibieD4oKxsAzisFEMvdeyGRV4ST8bjm+AhpRx77uEmIM5D5vWc2Rn9iCssVda0mu+VbNKAC4MjGyYQVWuBwcH8af1Ndbx809168QTccFhp1+wc+5Y7TEi7radvDSW5zi/PPNe2fnTAXSbg3clRaz3upzdFm0KJTepQ0NcIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392401; c=relaxed/simple;
	bh=fcUD1G+KSAjumj93FjMt++z+am/RSCtRwF7W26pQ08g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciMT9lLRTtoM6EE0BArZEMf6lPpZNPEfeXkQkUHKP4cy2bau1INj58uECkvI1fv8YOm1RCimxCqvbfYXtMQWsHthOxrgiiCxHW3b6SCF1y6tdwbUCZdgWG8thRa8C+j9Mcohe7DsSL+7sMnkfdyQR8rFpGz1eQIlTQoleNfqXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yd1WbUu3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e1f12c82so504677f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733392397; x=1733997197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8UuJPAg4uzKsmRkl80xAfQvVQX+ZS1np+zrvtyOjdU=;
        b=yd1WbUu3Zb/E8mN5vYA9A3FoobZHzLvOc1usZV+ZQ6SlgHg7HQYK7lgifqpRTh7QOu
         FGoxfxFkIRnbxZrOzsVdRYBS9aJZdpCgsQUjYW2NfnZYQmCH30zj1qX+bTgc5aZIwn8T
         rnTPAL4AiVpXRfDDF+RgEzq0wiopc7MVq+1jb3QIzVnJr7Q+C56XGBtGAR496oSRz9Wi
         VYhZzvNiZXbKFcsFlyqv0Xy5PG5hyPTdgAomRvCh7ndZbQK/EmKczTlyga59iBCZmH5H
         AFW28ApPo+n7Bsje/daRcCuFNSxMkdbEsyhpJQdTto3OM4iNOaScCpNErLGINb43DFrL
         ZO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392397; x=1733997197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8UuJPAg4uzKsmRkl80xAfQvVQX+ZS1np+zrvtyOjdU=;
        b=hg9oiJBkTneH37VGktXlDdiuMUPksKvwgOpXhZ5JEgx6kT4JmZ1Mn4Cnv+tbcRZup6
         yKR3sARpRApv/kkMSEpgNyS4/bKbM/cZAKFpqvEq0XmgLX1v/o8Hz1/OKJqdcTBpR+w+
         AHOidGkEK3DN3vOWJP1hCjkaiCfFtsAAjZKyL+CTKoT8iFhhsfSnItKJ9qC0X2CpNd5o
         +eO8p/ZtM3HSehiE4GCGMugKp9j6zYAzcs1trGnlHCCXhqS3eexVJlfzwd//XLJN5c9V
         9B4zaO/3BMDwvYR+pxQH1Iys25s1cLMTlg2KblhTbhFDBe7mQ+qbyxGA422KeU6lpDPr
         /NDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxg29t549rP/E1ntBxZ+DC+u0JQI5qyK4RQ3tOE1MHd/e9hW4O6Wke+A1i9WRT0P8bLHF50xeoLjrEUAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykr6lAC/wTxxmqYKdvNktRaBlUJIY4OH8xnRIVChHFBe81z5G3
	ClZAZH8M1T/AJvQ9hVuJa4/znELN9WH2Zh+e4zPein9XkAhygSXRREIWhT/yL7A=
X-Gm-Gg: ASbGncta+vUyW1o0ALC9mmvEdDkdpc8QReD60bkDiZcNuzN4OJ8kYk1VrCxtiyLFFL6
	2hktan27d2FbrqMJueSqC9zFRg+EtXei7osYh2RZ+jM/QTBjRdIGs7f1Dg7rzr4Yd5abOrTyRjh
	5iQ0acvMHqHAUeysnfJFytwH+7TdUXnR5wbEUJ830yRDqR20rMNbd4CyP6k0nBU3gCxOsSE414V
	sgM+2tARRqM+A3UDsvVvNn2b3QvYOKGbcirlrQXM/ss0WYgym453g2+poJyU7A=
X-Google-Smtp-Source: AGHT+IEVsK2hb41ndk08DsAN+R8x9yzNiSD3Xnxn/d42LtoWyp9X9Q3Lvp8+NitADR+4PPEFGgGGsA==
X-Received: by 2002:a05:6000:4009:b0:385:f909:eb2c with SMTP id ffacd0b85a97d-385fd43556bmr9734740f8f.38.1733392397068;
        Thu, 05 Dec 2024 01:53:17 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4087sm1529194f8f.5.2024.12.05.01.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:53:16 -0800 (PST)
Message-ID: <02a2660f-b577-42b5-9c3d-4fb0429d8c67@linaro.org>
Date: Thu, 5 Dec 2024 09:53:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] media: dt-bindings: Add qcom,sc7280-camss
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, akapatra@quicinc.com,
 hariramp@quicinc.com, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, cros-qcom-dts-watchers@chromium.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241204100003.300123-1-quic_vikramsa@quicinc.com>
 <20241204100003.300123-2-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241204100003.300123-2-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2024 09:59, Vikram Sharma wrote:
> Add bindings for qcom,sc7280-camss to support the camera subsystem
> on the SC7280 platform.
> 
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

