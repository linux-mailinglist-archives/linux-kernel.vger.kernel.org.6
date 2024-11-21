Return-Path: <linux-kernel+bounces-417191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA169D5036
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D771F232C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096919B3ED;
	Thu, 21 Nov 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6DqgMRs"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1079C4;
	Thu, 21 Nov 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204608; cv=none; b=HY4dFz1Kyzq86k/Y0muP7nv09yohOK1UR+j/Xir91fE8qKcJiwY9t6rP4zJhEPpkwAKiBoifOUiNTb+4qU8/QKar1/IZq6ImI1ox5RcPqc1yPPZqIWeLBpP1Z+3Z3KUZV988CyDiawN6O3/A00ASaC7uyif9T7YbjuM2tyaR9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204608; c=relaxed/simple;
	bh=JJ9Rr6ynLNHNFRFdYz46vVfER3rEooE5nCnrZwK4Z+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3O32kzvBuifNsfRKu2aXyjrNnodaJ4/UYZVM5Su03md3tcfZbESBnbY0t05UR5b1HB/cLbJsRCRQ1ZfFVsSp/0WF3zlzBGV2FI9hRtJIvvH9klbH6+5lOP19p0ujjsQozOHHav7CNW5TtDo1bhfjrEp7Jzns8lWodVGpYTl/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6DqgMRs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfadf851e2so1449760a12.2;
        Thu, 21 Nov 2024 07:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732204605; x=1732809405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEYUuV3fkXQb0Ykf6y3EmMa9d+j8wlHrcdZRdxggfI8=;
        b=k6DqgMRs6LjnG1V3A2SHELZ7VPOs/wOR0xECNDFvnIOtlbhW9prNQGLlxupm2/49FZ
         1A5uHV5wJGNsjzoGMWAbL8C/+vCimlASvIr3Hk4m73C4yyXfJlJLl9rDoXqo90OpUHMm
         DzoJRt2+cHJdMPkzFrpIPnb41uZw9iCDppwG3OFZT3+6af2qxLfuqrNwEbGA89oq/pzX
         Az9nbcQH6R5HLY523usWPD2gXHDpQMTctdqgsSOencmA4tnFhXurDvM6GBGhmpmgMZFv
         DlD8fuNs61eAOVqaUxvnhT8tj3PhZda/vPSlzoy8DxKvy2qdn7ubF1L9UrKdMArYJUiC
         sE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204605; x=1732809405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEYUuV3fkXQb0Ykf6y3EmMa9d+j8wlHrcdZRdxggfI8=;
        b=NrbNQL29JC3A/79YLMzduN6afOerw4GuiIWJjPkoKclzpclpvrAkC37bmZNw+j1qJm
         0msrqN5QDdZfQobrBM1H7wb2mjsrFCsfHVxk2SE/0GB/F4x7fVx6y8dSovpHOQQr8pgm
         Y7pscMikA93dFpTAWRVOD5masyfxuw/YhOVplUHhXtfJDqPj7i8sQQdoz8rGWkY4OeSv
         H6l2dU4RMXaELwgokXj7PnNgkl1r4cKuscLjiKc/1LlMf1tcu4GfupoLBT+bd/3mO1w4
         ykNMgNbv3qit5mN2Kfk1Y3qf7nJDr2gpVcyPJMakjfJilWntUphlcyMln+JDlX5Brv7d
         tT8w==
X-Forwarded-Encrypted: i=1; AJvYcCUhQqla1lmiA48ZmTwinOLzIrZq4N+nXTMyFlqGqepquFbzQhZFN3ega2QuI+B2UtMDBdxJMa2y7TCCqK8f@vger.kernel.org, AJvYcCWqrr9faUB3mjFT30PPasR3gfo+LqvYNUWz6SOULS5Ronx3a0x32dHflcj2gfQqbcDWD58/YCOiMyue@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1HNXvx8TU1VQ2zGl4OrMn8B2zffXKGhKmU8Tfp2S67aQ21Rz
	icIl9/lQI2P0v9Hs+53B+MEiDrDuVMy43oohEF+JXTD8q+pCGdRR
X-Gm-Gg: ASbGncuvaQSRAZf+3PubcrK0rbzytQMnBqki6a0sCNnigxHXo51kNdVjS/GeEQoJ3BT
	Mvfo8a+hOk5zPxKtbpQlJZ6iokBFpkv4IDVM463EtMrpVV5qJ2iEydCC8trpHurjwrPbU34wlrG
	p2Jrcrpj59SDef3QEFt3di6iHT3AtOIW/o3JN8G0orcQuG3AzUHhFZMmv88DQyK7ipKf0pjyKXa
	AFP8n7ibrUwTefX4BB3AJljjsPlr+N9VC0NiTSZDUFeGjfoRfKdw7FLa/trJXFRnsF27A==
X-Google-Smtp-Source: AGHT+IGGgP3FalMOP+1Zfuy6LUhtlw2Q+9R0E9/+CVYUAn9nZZfkEEMKoOkcYwA1Y6A6Y6zJDQA6wg==
X-Received: by 2002:a17:907:3e98:b0:a9e:471e:ce4a with SMTP id a640c23a62f3a-aa4dd53db26mr684405066b.11.1732204604605;
        Thu, 21 Nov 2024 07:56:44 -0800 (PST)
Received: from [192.168.221.195] ([81.19.10.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4319b8bsm94821466b.142.2024.11.21.07.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:56:44 -0800 (PST)
Message-ID: <ee013b8f-5526-4f32-bde3-aaebfb49e4d0@gmail.com>
Date: Thu, 21 Nov 2024 16:56:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
 <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
 <20241115-happy-garter-2cf65f4b1290@spud>
 <83c8487c-2c50-4315-8244-ff80632165e9@gmail.com>
 <9896a38f-4b68-46a9-83b8-bf76abea47ba@kernel.org>
 <f824fcb5-8c04-4a39-887c-64fed2439cef@gmail.com>
 <48f0b74f-561b-4a5b-8311-e2cfddb92e3b@kernel.org>
Content-Language: cs
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <48f0b74f-561b-4a5b-8311-e2cfddb92e3b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Dne 21.11.2024 v 8:43 Krzysztof Kozlowski napsal(a):
> On 20/11/2024 23:53, Kryštof Černý wrote:
>> Hello,
>>
>>> On 20/11/2024 09:34, Kryštof Černý wrote:
>>>> Hello,
>>>>
>>>>> On Fri, Nov 15, 2024 at 03:58:06PM +0100, Kryštof Černý via B4 Relay wrote:
>>>>>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>>>>>
>>>>>> Adds the newly added vcc-supply property to bindings.
>>>>>
>>>>> This commit message is a circular argument. You're adding it to the
>>>>> binding, which of course means it is newly added.
>>>>
>>>> You are right, I will replace with "Adds the vcc-supply property to
>>>> bindings." in the next version.
>>>
>>> No, please say why, e.g. because it was missing and device has it
>>> according to datasheet.
>>
>> Right, what about:
>>
>> Adds the optional vcc-supply property to bindings, informs if the device
>> needs a regulator to be turned on for its operation
> 
> It does not inform at all. All devices needs power, don't they? And what
> operation?

This is probably the best I can do:

	ds2482 has a VCC pin, accepting 2.9-5.5 V. Allow optionally specifying 
a voltage regulator to power the chip.

If you don't find this satisfactory, please provide a suggestion.

> Best regards,
> Krzysztof

Thank you for your patience,
Kryštof Černý

