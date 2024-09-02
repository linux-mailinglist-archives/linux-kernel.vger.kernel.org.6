Return-Path: <linux-kernel+bounces-310953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2419968337
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D4A28215D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4891C3300;
	Mon,  2 Sep 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffRdUWLF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89751C2DCC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269393; cv=none; b=mAJY+NQE9WzXhONJxgCZaicdwVfAiVgfPrBFTncL5pVnawDtgOLlB9/+em9kLy1kkv9niWhVRtpdWyvx7NBUq+VzZelUlDcFpEurrS/3wdJEQMgElHb9nGB84SQmrfBmTgAngN/u8G/drLxCRdhp9At4Woc0+b8O+ZL4XuHIgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269393; c=relaxed/simple;
	bh=tkU6Up04ywW/1rRD39iCyC9XOTeC8+OqS8BWB+CpvwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j+lYlsERE4AH+QUxndy8YAJyM+DYMHPy95N63Vqr8r6LtubaDVmcFDPzLQ3v4D0hPDKfqj6x9CQTxyaTv3+jhqbW4y5+a6nORUvFEpQwFTBp49IV6L8YXegM6KoF5RpxQeA5xSmBAyYcAOavmWgLomUxSSUm7y29u4COf1AfNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffRdUWLF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a866cea40c4so457501766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725269390; x=1725874190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EPsLVJHNf9AL2cGNm+/rVQrKrbYuFpSLncZ9xh4T+lU=;
        b=ffRdUWLFyDtTUx+oIUjLY1FTdmigqumHylLPPbVQlFYElBhBGBV309T/seueBpWL+w
         Pti9hM2HwoajvklNlbdrXyKHechQqOf6JdzW1iFpWQ7NL3q0N/TaMuRw4rHGOHbFXByA
         bRBzN41gDUzXhduVFNSkzbOp/TxievS4Mt6eI/TRXBveCSR5S8DG2nigxyMaSkiGLAeP
         veNy2qaCcYqkPMsjhm6Ce00Bx0iUKO8XvlAfkMYvQwtpG2w6GtgvtcxklRBrZZRwl5fi
         daq2+r1wvMEBaRpndEdssS55o9LHeyCwIAUb13s1nwEMNTVDAuh1cXR1hLvjOjV0udjM
         oWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269390; x=1725874190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPsLVJHNf9AL2cGNm+/rVQrKrbYuFpSLncZ9xh4T+lU=;
        b=G3Kr6PTLcib0/LrtrUSLLnbVKRXzS0vI6ARYyX81eHLypIeunh/7/XvWRntkTBbZA0
         WTC5D6lys08bvDjNy0n5EVAygjxobzjeXa5hliZCDLZsVmE36PCRUACgGbRk+2y+tYn7
         YrJMi+yFA+bEJj1VzDnBwQG5woRbqO6t0xUplpZYtFiRllJmeGu0iE73o9UpKIp4gnGI
         oY7jMDvZYPTOxpn8q2taLwd0gehzIgwlmOgwGd1dHPCxeoBgx4Bhaofv4j87kzT+0kaZ
         x9zH70KYzsxFauliI/b5jCGG1nWpYv5jUccV7fpOnaP5yKiSIkytAgzh8WZBk6E9hqPm
         IOzg==
X-Forwarded-Encrypted: i=1; AJvYcCVD1qWM27w3dMonTYlObeme0ahyTtTG0fofmZcWPBnzRY+S1YAu3dFfBQt9wrNQc7gCtzdN0PbC6Ep3Cwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnGU9i+lwOw67/MDvgyYIwZMNPKMrVorWBqK998eBjMm+gKt7
	ohFK7XRK+/0TLsnmWUbvl7LT+R8wf4BmfOI1B0jEE3+sHMyQYfY6vd4ka+AdGV0=
X-Google-Smtp-Source: AGHT+IHyxYPGT71yvNGl55/joi025MgwKVNHS5yHfr4kLEH+kbbmq1SIbL5dyYz9GztD9lJk9RVwnw==
X-Received: by 2002:a17:907:6d14:b0:a80:f358:5d55 with SMTP id a640c23a62f3a-a897f91fae3mr1073287766b.33.1725269389610;
        Mon, 02 Sep 2024 02:29:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8988feb61fsm543434766b.10.2024.09.02.02.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:29:49 -0700 (PDT)
Message-ID: <66b8c478-44c4-46b2-a029-bbf847429e2b@linaro.org>
Date: Mon, 2 Sep 2024 11:29:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta
 exceeds INT_MAX
To: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240725193355.1436005-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/07/2024 21:33, Frank Li wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
> is larger than INT_MAX.
> 
> For example:
> 
> tpm_set_next_event(delta = 0xffff_fffe)
> {
>          ...
>          next = tpm_read_counter(); // assume next is 0x10
>          next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
>          now = tpm_read_counter();  // now is 0x10
>          ...
> 
>          return (int)(next - now) <= 0 ? -ETIME : 0;
>                       ^^^^^^^^^^
>                       0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
>                       cast to int. So return -ETIME.
> }
> 
> To fix this, introduce a 'prev' variable and check if 'now - prev' is
> larger than delta.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

