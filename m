Return-Path: <linux-kernel+bounces-179216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A78C5D86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E81F224A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFD181D0C;
	Tue, 14 May 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZdVlN7M"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74117181CE9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724851; cv=none; b=rOaAZwtNuVEZn6IiRIc3MdeyxL/Vskrl+l67roJqaDeeRKYUqy4zbUgpFcq066IJ+FZIRDmcUBd6LGdyIPsn2e9uIfcOcM1vkGMWVC4feVsYJlQxsj/tZRVyS5vSRpskTphT18z61zp7/RUaHdBaYtiopxtAqSXlA/N/YWQ75EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724851; c=relaxed/simple;
	bh=lzBPunHqv+o+xTxtSNAE8nU1RNUODhqWO5eQAE9ZN5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ2yLpjiZDWBqfvJ07m3Iee/zMjJ7jz8PUp18AIw8KOGgmD05lR+wZHgF0UJK3eSSB+tMjtEDJ8vQIiJKkyPgHCSJOt2BR3jv0phnF3k1yXeWmjj2Ix0L/z01VVjr6f1v0+JPckKXi88q8pyVd+kiHiO20aqtg4RNAvlTRBsmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZdVlN7M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41fc5645bb1so44873365e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715724848; x=1716329648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47eSe1ifqIz6O47Mgn/jUdV6aglJ10TXGnxAmO1D8Uw=;
        b=PZdVlN7MH+/3CkSpd8eZdQLNn887XcoIMJOmrT89D8Syv7RjKHmX+7fxb8FkMFAIpD
         /AxKkhFxEBLU7gAXQZ1apAYY6Iyz7cgtd9foQA938vKXcgQUhCn+yuqea+jC5fS3cDpT
         5AtbyJeQtbTpNAxZ29PJh8qISTJORMUu6LcnJZnzrYpuj2riI/vzNVwGLPNdoQ1dmp0J
         u3Er4a1kspOKKlys2NUqJqNmds2WhYyNLpxVnP01EwZ2eciR1rZRJO8v7sTQ/HeRD7tg
         NIfKhrnO/n41E9mONum+y8kWMyqcS3/izymmvRVNZJxkbZBvh2yWZBmwApbpjvP0pDsE
         OAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724848; x=1716329648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47eSe1ifqIz6O47Mgn/jUdV6aglJ10TXGnxAmO1D8Uw=;
        b=FvxZMHeEz8m/CRZMo9teoqNU5JyLfiHaMar8Kyl4O+VqItnxxt8MY1H8oH/pPMFFV0
         jMHmNPEAlc/kzfIsqQlT91eN9sQq97XwMnpBHdf5WtHT36v+1SyXzIolbEQFZ3EFiyyN
         SW7lNfJB7mcASBAuH9YUv8FDTKeOrzQ0PTWjz5mCKkhOeKErR84T2YMbjq8FL9FxKFKG
         tJHbDT7Xpu2qGnaa8QkezXx0wZlb0J5wpFGpbTzjLAwjcTmXFzsF8z2U4QIYY53OAyfB
         ofUQ3TZejhWNwO5vqsUo/ZpFBmboV7icHTsqvokIvRnZdls5re05ZrAMzWprtpoOjb39
         9H1A==
X-Forwarded-Encrypted: i=1; AJvYcCXL7vpDiSB7hCctsHUd+dhTmLF73VK4pqbyla8dq3J2pFFoMs2fqp4Mc5HWtE92IyQJ2MF+d3dCj0xLjzeCh9sBTgYSoERc/hGsHiV+
X-Gm-Message-State: AOJu0Yy5SQPWS+r0SdPC8FAQnLv8gKPmGy08qgNjYBmVLmvIh+3N6Nj4
	G3gxX5BpxNXMpaQbTEff7+t94MhKoCxwZy5sCLJhhnVPM04MMfwC+nlJkgg9U3Q=
X-Google-Smtp-Source: AGHT+IE9Exumr8cSW9rXqiQSZiKueBgNhIQL6ZpN/BQTxO5vOYlNwuHSv+P0bAk7D61Uvo3cGbQVjg==
X-Received: by 2002:a05:600c:19c8:b0:41f:e720:eec9 with SMTP id 5b1f17b1804b1-41feac59c27mr103801265e9.25.1715724847761;
        Tue, 14 May 2024 15:14:07 -0700 (PDT)
Received: from [10.1.2.16] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm243327695e9.25.2024.05.14.15.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:14:07 -0700 (PDT)
Message-ID: <c8ec69e4-a411-448d-8ebb-c896a2c754c7@linaro.org>
Date: Wed, 15 May 2024 00:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] regulator: add pm8008 pmic regulator driver
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, johan@kernel.org
Cc: andersson@kernel.org, andy.shevchenko@gmail.com, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, johan+linaro@kernel.org,
 krzk+dt@kernel.org, lee@kernel.org, lgirdwood@gmail.com,
 linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_c_skakit@quicinc.com, quic_gurus@quicinc.com, robh@kernel.org,
 swboyd@chromium.org
References: <ZjpMeVk_HiixZUEu@hovoldconsulting.com>
 <20240514134317.691887-1-quic_skakitap@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240514134317.691887-1-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/14/24 15:43, Satya Priya Kakitapalli wrote:
>> On Tue, May 07, 2024 at 01:48:30PM +0200, Konrad Dybcio wrote:
>>> On 5/6/24 17:08, Johan Hovold wrote:
>>>> From: Satya Priya <quic_c_skakit@quicinc.com>
>>>>
>>>> Qualcomm Technologies, Inc. PM8008 is an I2C-controlled PMIC containing
>>>> seven LDO regulators. Add a PM8008 regulator driver to support PMIC
>>>> regulator management via the regulator framework.
>>>>
>>>> Note that this driver, originally submitted by Satya Priya [1], has been
>>>> reworked to match the new devicetree binding which no longer describes
>>>> each regulator as a separate device.
>>>>
>>>> This avoids describing internal details like register offsets in the
>>>> devicetree and allows for extending the implementation with features
>>>> like over-current protection without having to update the binding.
>>>>
>>>> Specifically note that the regulator interrupts are shared between all
>>>> regulators.
>>>>
>>>> Note that the secondary regmap is looked up by name and that if the
>>>> driver ever needs to be generalised to support regulators provided by
>>>> the primary regmap (I2C address) such information could be added to a
>>>> driver lookup table matching on the parent compatible.
>>>>
>>>> This also fixes the original implementation, which looked up regulators
>>>> by 'regulator-name' property rather than devicetree node name and which
>>>> prevented the regulators from being named to match board schematics.
>>>>
>>>> [1] https://lore.kernel.org/r/1655200111-18357-8-git-send-email-quic_c_skakit@quicinc.com
>>>>
>>>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> 
> This is my old email which is discontinued, please use <quic_skakitap@quicinc.com>

Please submit an entry to the .mailmap file

Konrad

