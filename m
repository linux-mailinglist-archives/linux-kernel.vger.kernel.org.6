Return-Path: <linux-kernel+bounces-558196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C630EA5E2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1486C16DC72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04697250BFC;
	Wed, 12 Mar 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRmNDp6D"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77537250BF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800136; cv=none; b=tjElRB+xlj3E7Nx1YqiwMUp6gvZF+JOG3BYFZlD9ToZy+oQFE2btMCdyjASLY8apJrwKrm+31RvWsVz80qdDXt/Ty8Pix47JXUcYskV2JAl3+Xd4rl02wsQACARZB2GxBBal+7iQG99cO8eUQW971FmbOxBKZjjMEU67CWcNmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800136; c=relaxed/simple;
	bh=L6a4kSgVy3RSwlSMSOjk8/41yNjs6IAArlYr/5aa8CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOBo40u+Hlu3oN+76WH4wgiAocaikm4Y0QtN9iKQ1Fu0FesWI7s2HAt2R3nXEDWjRP0sFjLgDm5uIqq0edU7ugOgzdDPnLxVBQwbnz1vSXSyDdySSuV1lRUIOasBmb3nsAE4kjb9aqk/A6nJuCSgADlhRlmaCsf7eP1mWUDKGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XRmNDp6D; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39129fc51f8so91937f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741800133; x=1742404933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6JWf9s2rIuKyyKaAFeiZwziBKuCoBJFQKmV1DDqia4=;
        b=XRmNDp6D2M7hLPrvSmpKtourgRUXxrV88elnzuxZ2xkEG+ezcRvLTqXDvSsA20djGW
         HFGFiH6HMBIOJm5lZqNwCRihGh3qra867uRnhFEDDK2ybOhzUUGXvhqFZ8KvbVf+1xdx
         K281EwzhRtcgh8T8conh62OU2/mdwzUD5HBlia3iE4QBWWguftCMMQEnSnJ/Jo+67Af4
         Z2PdWf0nZ05zuqmWZR5bt/qAW7oZN90Vrm1o3ALBL9csOTGe0qhoe6nhT09IRDhVLNxF
         FChIqtV1svAVe9Q9Ncc9ZBtHBYtFkv877VlGJFJADTyYxLV3RYH8Q5W4zSlsrnaj9Uli
         dd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800133; x=1742404933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6JWf9s2rIuKyyKaAFeiZwziBKuCoBJFQKmV1DDqia4=;
        b=HBflZvPYAX5mB27LF9go45aUo+RGvPwNMwQ4dc8mCx2H5UPnW/t9Bp1sZWbTsXeWUb
         HuaLglEP5hdhkAZ2Fwfhh32Fo7SCEYSdwDIB3QXAC1W4U5TCahwxMLSy+yP+ZDAzsfxq
         oexEMRSNXIJCFFsz98LhWNljNwN7bbWoudC3dYX+K5wGcDOk7SLUmNZ43fQ2xrYm2zme
         J7+qKxZg8FP51T6eZiG8lnkI4bzpm1esHMiWliffDAMNgs7FVFb1D7rNNK6dLj2OaX92
         JpX0MDXc5/MAk1TjCeQp/MZqMJmRqHQuAUckMDz+Zw0o9rNUV4hvy0pAgMA9iynPXSzE
         JRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhWENfgPvzq7ZHmrVX086JRzW9/8aPL1lr8jf+ucN8v0sl44ddbGBLXtRIn1aER8HRxtN8itX++jb7pmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyknzQSgPEupEtHAc86a3jXWv9+AA2oVWftKJXpj4ODh67bVWy7
	mHcNlXW08qVoVr+gh1kGQpFIFGRGp1ZR9IVsUU2lGTJognEU5g/pQTvaY1f2Hw4=
X-Gm-Gg: ASbGncvp71CMFYrXH5xHpUGMHWOYW0bpaDnJHOiUkojiqH2PUSQZV07vmjcO0ewJA8G
	bsq1dtWkxAFzTXeZGN/Gf/YbMe5BE/JMCUzxVAafvBR2Ebxx9AOgekLsyhbZxh3EL3t9JPwE/zs
	7+Ek3V6l2VggwMhr999NRzuxgnfR2CdChS9xZRgsQ+Kt+mny3DENMiP9aic3xU/X6nNBbGjDoby
	Ixt5Nni2FNAjR0w7fQlt/G97oZXOSc6qLOtTMsxbqT88hgmpwQAV6fhukjd+6ldOPvdyWaR1BRu
	JfPgltdPgs1tuDnY6l1OPJQ9yBhVmpdM4UPhtBLaqBssvDR7l8IAHzyB9/bS9vGFaPFzr/iao46
	4em9kIHlq
X-Google-Smtp-Source: AGHT+IHmUyQA0rYHqvGLoQWTP10z9aEu3s308pBbuP5uQ4P4qcJBt5u4uWFj/L5XlO6T2InaT4bWOw==
X-Received: by 2002:a5d:6d8a:0:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-39132d2af8bmr18346729f8f.3.1741800132754;
        Wed, 12 Mar 2025 10:22:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f39sm21327715f8f.80.2025.03.12.10.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:22:12 -0700 (PDT)
Message-ID: <5ba39d01-f13c-4c4d-aebc-82929c6f3df2@linaro.org>
Date: Wed, 12 Mar 2025 18:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] thermal: core: Record PSCR before
 hw_protection_shutdown()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
 <20250306093900.2199442-8-o.rempel@pengutronix.de>
 <726c6ffc-a8d4-4328-a849-2d59f3a0a1c9@linaro.org>
 <Z9G7g5fr8DkJtcLI@pengutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Z9G7g5fr8DkJtcLI@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2025 17:51, Oleksij Rempel wrote:
> Hi Daniel,
> 
> On Wed, Mar 12, 2025 at 04:35:51PM +0100, Daniel Lezcano wrote:
>>> @@ -380,6 +381,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
>>>    	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
>>> +	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
>>> +
>>>    	if (shutdown)
>>>    		hw_protection_shutdown(msg, poweroff_delay_ms);
>>>    	else
>>
>> In the future could you add me as recipient to the series instead of this
>> one ? so I can get more context.
> 
> ack.
> 
>> Given there are no so much hw_protection_shutdown() users in the kernel, it
>> could be more interesting to change the function to receive a enum
>> pscr_reason and then in the hw_protection_shutdown() call
>> pscrr_reason_to_str().
>   
> Do you mean, make it work with CONFIG_PSCRR=n?

No I meant instead of doing:

+	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
+
  	if (shutdown)
  		hw_protection_shutdown(msg, poweroff_delay_ms);

Replace it by:

  	if (shutdown)
  		hw_protection_shutdown(PSCR_OVERTEMPERATURE, poweroff_delay_ms);


and in hw_protection_shutdown() use pscrr_reason_to_str() to display a msg.

That can work with CONFIG_PSCRR=n


> Beside, the latest version is v5:
> https://lore.kernel.org/all/20250310103732.423542-1-o.rempel@pengutronix.de/

Ah ok thanks for the pointer


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

