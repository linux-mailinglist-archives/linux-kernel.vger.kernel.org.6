Return-Path: <linux-kernel+bounces-424625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC389DB723
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81CC281D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766719ADBF;
	Thu, 28 Nov 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g95C0Zm5"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CB2CCC0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795756; cv=none; b=DNja4FD96UjsFcju8Z18MZWYofR7rW7KMQC2eJ0cq2ggHmAF1Oe5LjYArs6eYEhOSOg8jUs8ugrfbB5mn6X1boKGMw1yES3THrjmsrHDcduu+gXa4ShK37NyTFM1+Pc5JTt7uoc8aoxXbxrQcrfS4DG3eTfSiL6L61DzvrC9/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795756; c=relaxed/simple;
	bh=RW3VZirTHPIW66UyzCS45tHNq7eH8+C33ljA4Nll6ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7ujLjgMZkcvUKWJnXXTodQ2qw3r6neeOWBfwvE3bJ1xb2Fg874tHiKZ1Nn5s9Dpv+UylYYzAjl35L7dAI3Zl7GeQca4UUzXcSF82CnLCvpPEh1t7vcechaGbjnFDoM0EaPjTiT9MA8xkggXLGCtarT0XEeETJCkzt8WgSBQEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g95C0Zm5; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2ffc1009a9fso480261fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732795752; x=1733400552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwTWwA6azgLnozBWQBgEU2aEg7DOq4OXVVpm7/SKa7w=;
        b=g95C0Zm5icFPawGfuyhIa+KLv+MwhNzbFM1YSsW1F8Bf5DR5/yE3mNlX8xruokEXjc
         9gM6/92l2s6pjxAr8GuUOlCAS47vO7DPTFpwvZzeDzwv5Q3rUams2cp2Zny4M1Yq5dS2
         reuhGFhpyaa5e8ahzzmZgH8KTvQ642ViZCZEZwnX+bVtgURS4j2yW9GwVuSE1zBV0ffO
         fiImHbCqwPGkNZhxYiTGTJpBul0xWAlaVtLcrdRvjZvKCtEN20DpEEJAYoeI50YE1tXW
         YY2UDU9aT3V39nxaI1n5wx8ED/M9NdKK7++ucjdbmU7dtk+JFZAqrlpLwhpSciRtRkFx
         C0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795752; x=1733400552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwTWwA6azgLnozBWQBgEU2aEg7DOq4OXVVpm7/SKa7w=;
        b=BlQTS1TnqV6kFYIVR6qLgbdEBMBktgL1L7yhkj1wuRtW0uxfVSvUex7j5HptDxZwON
         a3LZR647FPlrwTAPBhkrxXZOidaQahnAc+YAwHpUnb4JzFTTSA0B4DyRvGVoHTjfosbH
         P8aEcsAPWI2W7fAG32GxlPmziwBci3y3wtW6Oa3NmNQoMpp/UYjnVoB5UM32sxvyKluH
         5CPS8DA0O5A0FenLmTyeePEw7zljWwXwi1arihxp9b+VKH5FUS0rCkKt+JYTuZfERRJp
         e9EEWmkPWCn+1QqUqCVgeMUUVgpfWouxnJmMOISaSEuRr4n12CntaRpmDZs1tKZKEcih
         X1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWvZFf8sNbNuNstXzKd/kD1n7xK9R9D3HNVYllev1SO8O1Tb2vtWudFw6v+Sn5c9YZRx3UmBMEZU0Pt3mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8QueQQcEC8jaEjd9R5f0t50i/aIFu0Mqjb0VipgS1Mw1Tw7D
	CtYJ0OJ8OpEX2p/wkQNnSI/xqSZh73PSWelTBCFTOSwhkVQD9VvdNnwR64CJvVs=
X-Gm-Gg: ASbGncvQ+6oGeA6NvGKeoGtmLcJLJkiCiRZ9IinYf7JUbkRN2Zywy4ueXPujdp5ufpB
	hWqc8RmZ2q6VhwitoosmMrRePmoDVu+cLQymliE2Ot6himVg6/453sIo9/Qpl5qgpAK+wWR1FnY
	VSYVIbhu7cW4bXJwERUdMMHUAcouFJdYrhB5bQa2Crfoc2cVGNCnNu2RIXqzBfQUdzVHDCp48Vm
	qMXl/1+FtSNal+idb572RaWhLEIT/8PZp+rKGhmnJ2giXDvqb88Ty0N3H5GXEMHR3tc/I7MXKWB
	J1fiQ4DG7P7uQ1dRS5ZcMxHWa4Hk
X-Google-Smtp-Source: AGHT+IGb+CquWGoLlCxlMN54dryp8DwwxL61NpjsPl9cVKA1OdiBA+RXxSDRUTTEFIMowEslwGRMSw==
X-Received: by 2002:a2e:a583:0:b0:2ff:a97d:98f4 with SMTP id 38308e7fff4ca-2ffd60ab680mr9240231fa.9.1732795751941;
        Thu, 28 Nov 2024 04:09:11 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc9bd7asm1726121fa.94.2024.11.28.04.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:09:10 -0800 (PST)
Message-ID: <a73a3b5a-cd83-4f87-876d-ea99ef8bbd70@linaro.org>
Date: Thu, 28 Nov 2024 14:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] clk: qcom: common: Add support for power-domain
 attachment
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
 <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-2-4348d40cb635@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-2-4348d40cb635@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 17:53, Bryan O'Donoghue wrote:
> Right now we support one power-domain per clock controller.
> These single power-domains are switched on by the driver platform logic.
> 
> However when we have multiple power-domains attached to a clock-controller
> that list of power-domains must be handled outside of driver platform
> logic.
> 
> Use devm_pm_domain_attach_list() to automatically hook the list of given
> power-domains in the dtsi for the clock-controller driver.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Please simplify this change, please do not ignore patch reviews, if you
find it possible.

https://lore.kernel.org/all/8a33c0ff-0c6d-4995-b239-023d2a2c2af5@linaro.org/

--
Best wishes,
Vladimir

