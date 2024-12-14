Return-Path: <linux-kernel+bounces-445778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA809F1B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD65163120
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04810DF60;
	Sat, 14 Dec 2024 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRnV8jwO"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752C7489
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137398; cv=none; b=Et76Somqj6vnOsmw+8nXLaBt+o70dtzfZG9wQZatQt7nE81RLMTpLdxg7KrJ72/X+E+k79GH9ebR8Wyi1CGbaWJ86iLuWAm1JJuGYDLoG7fNPqNCiQ0UePCMmSSWu0LlyJ+/hI4LbUrQgQOZsOEtsGip3YyO7BqlHfsyg50UqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137398; c=relaxed/simple;
	bh=LF9f2q7wQ5vyQD4uKD7ZO6qHf8a3O2obFR51imVhytg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9G8JKi03C97o9DhuID1+Un8MgCFo+X35YSF1Mgx1Fyg0FKJz4fKn5fZyRECA9oz8BvfzKZRfbFZrl+lZHEoweQ23Z+8ik/n8K9Epclr5QgLQZuYioUyskx6/l6/nkAXpDs8KPSkK96oxv6NSwMVznGvxeVjbMpIREVkrUrS7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LRnV8jwO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso2520881f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734137395; x=1734742195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZHQT3+1AXOHwySh7rmIQ56owPwbOS+jVtet/I/oewQ=;
        b=LRnV8jwOV0SG5IWaihuzl1//P4nNulgNrK6O9E3pUa6+cJN/VVgaE2c9QgnFMe4+mC
         /Fhk1SKuSyOX28ryvEPjT+bq1zM9YOWYznKUlObqG/fa9HC02KW/rnD49jQ7XR4rTPEI
         o2TljLwj7MGTe5fCz4EgFG7PVU2OjNVqLfJJEZ8HaReM0dHFlUehhvdLtxl8CzW/qBdS
         x4ANxNQZ6ipRfet0D8fGjMDsQ1jBabuaCbAj5rGjq6w3IzO7RoDfRrAiazHbKWq4KV2N
         jnIpkkM+dwJz3GSB1KOhZ19RBk+OjprgptwoWngOBb3CbRJJKyzdiY6LH3X0MsEt0/7T
         necg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137395; x=1734742195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZHQT3+1AXOHwySh7rmIQ56owPwbOS+jVtet/I/oewQ=;
        b=h/JmayW+Rw1TQQ3aRwzfMofMZEblTer+hBxyrQbYNTMMzDC9JelDDE/CUShYlTmbQQ
         JLK+IFFRgBO0qa1wEnClzA9DMALNSzQPaz2rBCA+bbmTlIhXEx1agsffsxTRQZIAmhka
         G1kxWemrYLxz1j7PcMo1+Ju6rfQpg9eWCt6HABAlx+SVLgxFNgmS0o3us9txgbvYd7zT
         v4xV21oUK6FBp3PoPIoCPuZMo7YVkcK7aM8SgiH3/GdjgKMqn9fLvfcwtSIk97vyGcP8
         6omWCkaqZXlZFRPbPk3sqOL3kDLgri4QTRiW2rMWmn79JQDU0rpqFJrUfyuAbKNBtpJy
         2I8g==
X-Forwarded-Encrypted: i=1; AJvYcCUaZgkCONaPWF8lr2hwZAyLgornd7jEXw0OmCDTQEX1WPTZU9GNskzwNMB8k6sdqdp0az5udGYXpVhsHmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG99UIWyznGJyMOtmkNwvt73udh7Wx521c5IcRjBtXsGWzraiB
	SAGAnbOcJPtskP2KYsVhk159crI5xYvjJTF7OmGMFPqskb2ytcjhS6xJxBEx8fw=
X-Gm-Gg: ASbGnctNxm0jHhEjbJ91q3oaZvKbV+cXNU2BXIo9bFUw+BwBq6IUNRo5saYuhzPW9Mf
	fj7ffOIiX3aVsf6Bpksq5XKTpYStjXJbmJ9Yypird/HHSckVfN9da/qNX2kYPvCtxZv51H9t3nD
	nUbp8KBkmJ3YHh631scOs72iG00Tj5e5mBcE36UtZo0dafsSMtAJAi0Jz+3+yhqor07eZeZ0195
	CxLXG1+Sbxu/fs50D8Bv7DAS5xQPO2yjtxEkNzm1IIgW9XHqhwp/lbpq4NPEtAiRa9uog==
X-Google-Smtp-Source: AGHT+IHGByL+SnFZLh6TJ7bPmNjCMhZaO4qaTKsbRPxcaxQjrB96T87kcly1ELijtAI4mJfcF9Gh8g==
X-Received: by 2002:a5d:5985:0:b0:385:df73:2f42 with SMTP id ffacd0b85a97d-38880ae14c3mr3370858f8f.32.1734137395326;
        Fri, 13 Dec 2024 16:49:55 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80165c5sm995925f8f.25.2024.12.13.16.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 16:49:54 -0800 (PST)
Message-ID: <08241f60-a6a1-4b69-bdb9-c9b83ec504f3@linaro.org>
Date: Sat, 14 Dec 2024 00:49:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] media: qcom: camss: Add sc7280 support
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, akapatra@quicinc.com,
 hariramp@quicinc.com, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, cros-qcom-dts-watchers@chromium.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20241206191900.2545069-1-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241206191900.2545069-1-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2024 19:18, Vikram Sharma wrote:
> SC7280 is a Qualcomm SoC. This series adds support to bring up the CSIPHY,
> CSID, VFE/RDI interfaces in SC7280.
> 
> SC7280 provides
> 
> - 3 x VFE, 3 RDI per VFE
> - 2 x VFE Lite, 4 RDI per VFE
> - 3 x CSID
> - 2 x CSID Lite
> - 5 x CSI PHY
> 
> We have tested this on qcs6490-rb3gen2-vision-mezzanine board having IMX577
> sensor. Verified both TPG and IMX577 sensor.
> 
> Used following tools for the sanity check of these changes.
You should state in your cover-letter that you depend on a prior series.

Unfortunately I found a bug in your depends series:

https://lore.kernel.org/linux-arm-msm/1a570c17-c501-4a29-a4f7-020f41563f3d@linaro.org

v9 will have to be gated on that series being fixed.

---
bod

