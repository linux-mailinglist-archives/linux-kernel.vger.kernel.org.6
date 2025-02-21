Return-Path: <linux-kernel+bounces-525012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E168EA3E9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC40178787
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1145009;
	Fri, 21 Feb 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4WgK+S2"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31C1A270;
	Fri, 21 Feb 2025 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100819; cv=none; b=Xwx9Cc6OgCNMhiIQG+hzs4FodO0g33brYgl6hViAGCpMVZ3HRk28pH/z5oIpBjLtHLhBm91QIVH7rKKq+Cf0kXaqqpWMMQVTcXXm5xpb0/MLhJL7M15e8yDzkGr/ZKToqG5YUn+ko0HyECyTre+VtI60AiryxLOh/2m7EM/2jDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100819; c=relaxed/simple;
	bh=dP1BWXU5HhYmfLM76OH2hghfVB9l+IVQ6Ldu8qmUq4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENqCQRnSgxTWmGvcpDUoAskJOw+d70TGwrcLUK6UYt0oIZNlz5xqfU55gjn0PfdSfM7VhAVzP0H0zhYItL3UQ+Se9IwlqP0XEsqaEInTNA42ZAP2lvrllq5DJ14GLZxPyNYK1pcLIm8MV8Oy34Vtwt6Tj09NUt/bpF/PGHmp0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4WgK+S2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab744d5e567so278609266b.1;
        Thu, 20 Feb 2025 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100814; x=1740705614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLdWDE99RnF8L+T7bBwrOWdjhYLCj2lWLdBJFG4CamA=;
        b=E4WgK+S2yDCKhV3HHFSX/v5yCPH8vo6Votu6WvBJFizcxidNg/yUAQIDcsSjpdIoqy
         qKlOqvXPzx8s4CjzfpJ2+CJQdUoUnL2Iiz7dC7PWSufSvLNXMGt5dCNQPtBlkozShVxU
         un+nDcCbiOhi3jILmVi7UWA0H5MzaWES+tN1dKzE2YYiJbOYvRZOiaMFR20qXcoR5pwW
         hMM/YKRIGNHpfhEh+MF5wnxX7RipMoO532o7Q0MMhoyhshrkbAqQMRqJy0mIYvacHGAw
         24V4A72WbiycCTnOu51HefCdowlHIhLM8Qw9ZHS6DSXmVLzDn7DkjATVMTHjf/dPZFLH
         I/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100814; x=1740705614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLdWDE99RnF8L+T7bBwrOWdjhYLCj2lWLdBJFG4CamA=;
        b=AQULwlhfuxNY7EmcSndOAOtEQmfkAHUFLU2DnIpNOOAujoNNYyfBcG3qJlBxQWczPz
         DdLzVWjXplbIAdRkxOQFDj+bOgb63yJDTIWBcMVKs4EKjpNKFmudwVV2LUEV5BxKSM05
         V+1BGxFprYAQ9Rl63KJSwHOaFRDPh8oYT5Ab3ixX1Qrb9e7OnzngRSfUQtxea1cSPN5U
         i8lRt81c7GsQ+lPEigflsAzQ1Es3EED1yObuQjupLfXtX3z3FN6HnT8E0+/bT8DpFU3D
         aolvEI3wDpLLy32IUwQRoneh9OsJxQ3ADGLnPRS4t8E+QNJTA/z2VTZnad9fAOyJVl7Z
         t6ow==
X-Forwarded-Encrypted: i=1; AJvYcCV7dCG7fseclW5ynz4jJXImCCEvAD9ZaQckHrYqxo3aVFD7A9eBlV+3uH6fdfB5Y9bYqSvPHGfSZY6OP+00@vger.kernel.org, AJvYcCX8pguFlHa6oR6AWVmSjCOR+wVxrdDGPD4uguCvmLmlADyB0SVUnq2Q/ySrX6NPOt4R2IzwXbBCLibs@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwMjdJLq4c9IrOjmG9q6HkXW6LpQxHoefPgHaykauSGxyAfGW
	1DKCLXhSp8Ns4FFBp6Q/Uy1Jxe9RrKAt7l9qwKdKK6pEa8NPKSK8
X-Gm-Gg: ASbGncvzpAg0SF8IObfe03EJVH5pJL8lLr9TAzPAbgs0fpr4TtnEt/86eFmu2BkAuo3
	t0ib+6QyQm1iWnUEWDwAUowWK9qNXpvIYd6L/efuGQYa3PrkOvXxSmnyr7grcdhL5F/dPoRWasj
	O9tMDuycMrEe/5Z4uQnxkL7kv0gTw0XL58pAFuf0tpNQ78g5PqF4LvbFKbfd357om1BlgLaMa2G
	pcLYxz8CY7phc1APmUPJn+fvhI3oJq4Jcs1gMuUu0po2w6r4d0dNnjbknS74UJVaQWWYG8lretw
	/8LLTtJJ0wKiDgLF9+dH+xAc3qslSyaS7X5z/NUNq08a
X-Google-Smtp-Source: AGHT+IGvRDTlkH1zTKRe+mAKqwe3ESbEQp8XsF/35YcwuDu9Yhfk7y+ptfPIYtK+S0ZC3xZG+Qnjqg==
X-Received: by 2002:a17:907:8b96:b0:abb:ebf8:72d9 with SMTP id a640c23a62f3a-abbeddc91a6mr586592266b.15.1740100813535;
        Thu, 20 Feb 2025 17:20:13 -0800 (PST)
Received: from [192.168.1.130] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8ad6720esm998432766b.88.2025.02.20.17.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 17:20:13 -0800 (PST)
Message-ID: <9028f7a8-7cf7-4ebf-86a6-0d894c66edb1@gmail.com>
Date: Fri, 21 Feb 2025 03:20:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] imx_dsp_rproc: Use reset controller API to control
 the DSP
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org, shawnguo@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 shengjiu.wang@nxp.com, Frank.Li@nxp.com, peng.fan@nxp.com,
 laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-9-daniel.baluta@nxp.com>
 <c52e6c5c-f49e-4727-b669-086ae7cb0e1e@gmail.com>
 <6e03b0c09c4e6d222670025c6540f73a0a0a819d.camel@pengutronix.de>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <6e03b0c09c4e6d222670025c6540f73a0a0a819d.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/2025 5:45 PM, Philipp Zabel wrote:
> On Do, 2025-02-20 at 00:22 +0200, Laurentiu Mihalcea wrote:
>> On 2/19/2025 9:21 PM, Daniel Baluta wrote:
>>> Use the reset controller API to control the DSP on i.MX8MP. This way
>>> we can have a better control of the resources and avoid using a syscon
>>> to access the audiomix bits.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
>>>  drivers/remoteproc/imx_rproc.h     |  2 ++
>>>  2 files changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>>> index ea5024919c2f..631563e4f86d 100644
>>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/regmap.h>
>>>  #include <linux/remoteproc.h>
>>> +#include <linux/reset.h>
>>>  #include <linux/slab.h>
>>>  
>>>  #include "imx_rproc.h"
>>> @@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
>>>   */
>>>  struct imx_dsp_rproc {
>>>  	struct regmap				*regmap;
>>> +	struct reset_control			*reset;
>> Maybe rename this to "stall"? There's also the DAP stuff that's actually used
>> to reset the core so this might be a bit confusing?
> So Run/Stall does not actually reset anything? Maybe then it should not
> be modeled as a reset control. It looks to me like the
> DAP_PWRCTL[CORERESET] bit in the Audio Processor Debug region would be
> a much better fit.

Yep, it does not as far as I'm aware. This bit is used to insert stall cycles
into the accelerator's pipeline. As for the DAP bit: agreed.

(Daniel pls feel free to correct me if I got something wrong here)

For a bit of context here:

Previous approach used a syscon to manage the Run/Stall bit (see [1], "fsl,dsp-ctrl"
property). The main issue with that is that syscon doesn't enforce any device dependency
(e.g: PM) and you do need the AUDIOMIX power domain to be powered on before accessing
the registers from said syscon.

Now, AUDIO_BLK_CTRL offers multiple DSP-related configuration bits (Run/Stall bit included).
If we ever decide we want to access those bits we can't model them as reset controllers as it
makes no sense whatsoever. As such, I think that modelling Run/Stall as a reset controller is
just an arguably unneeded and inaccurate (assuming reset controllers are supposed
to model only actual reset signals) solution.

IMO, unless someone can think of a scenario in which this would break, we should just cut our
losses and go back to the syscon-based approach. The DSP is already attached to the AUDIOMIX
power domain so it should be on when attempting to access its registers. Also, the DSP
should be the only device wanting to configure the DSP-related AUDIO_BLK_CTRL bits anyways?

What are your thoughts on this?


[1]: https://lore.kernel.org/imx/20250212085222.107102-1-daniel.baluta@nxp.com/

Thanks,
Laurentiu

