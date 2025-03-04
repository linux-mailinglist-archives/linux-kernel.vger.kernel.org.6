Return-Path: <linux-kernel+bounces-545755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92025A4F103
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AED177BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813227817D;
	Tue,  4 Mar 2025 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFWIkAJ8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2160261586
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129135; cv=none; b=gtu36Mbg1fDCzSIcxKlu3tSDbw2PVSbjRn+lyak92VSD3zd8FqgNhzBHFFfqGaZNvLZTx3c6delTeOLtoM8eYvz1TrhkWkcZ/NVi11A+hQsHBVEVGWdxeCQ50k2+LgJjTxNLruuTxQU56k0Kqwc4/csDeK/Gwh0NV4qzxbJf/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129135; c=relaxed/simple;
	bh=UQUvyGDPdTFPyPH9MsvwvLhlQDmkv4oUAlzRyvh03mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDp7cUGl5uiLCWMudqo6qUBUjfwBMglRF0qNx8rUv7X/BAC75YizvQ2Mc7PKq3mgMH8r3cBTnr4sU/RMLDhwPamsf2maHee2BRdYVenWgc9xf5W0OoPcCNrRYXHqGyN7ewUD3bEJZOD17NvC8Pr4FM+T70mnQlfd68HIUAg+J9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFWIkAJ8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so55270495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 14:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741129132; x=1741733932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euJMffvlvKCZA7VwIhx2ASa4VsvPUMdrYRd7gnRpu9k=;
        b=FFWIkAJ8YRFHgUZovHv1eLHL40mf3ziuL8HWamjCH2aUAIM6j91RlHMONPMc7WTpfz
         2E8PeiCIA/TqFTC84hIzpFwWkmbEiEhWJjAfYT/EqSQ1dzuDzt2rjHrJ5eKi73uWwVsC
         hJucr434yYguO7g/nKgSGMXj+wnhlw2y0NsyocQfipN26DAlMxLTJCwp0uMcOYMGdPUK
         eqglpro8QbExxTqpLOifcOqml1PnRC69nALJrlh7r5vvBWrnnPCL/Crm9cE93jOQFhKE
         arsYpgqLqa2VPj5pIKyL4geCf4qgIfBDdNmW5/TlHXw3jjfxM93k+qquqzE3klgIH7vZ
         aEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741129132; x=1741733932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euJMffvlvKCZA7VwIhx2ASa4VsvPUMdrYRd7gnRpu9k=;
        b=BVW8D0MbMq7ExuGMcgIfOOymbIj7R+3wL+PQnaVsW0F+j92bWm5iXHtp1nPpgYqhfO
         Gc6GuPNF+XH+Ay+o0RKv/6u0Y5NA7DUCYQNSEBtlLuzIyPrFz9uFFRuQoFUforDykF84
         8xW7D7knLzeCUXc9yY0QddGf2K9nO4TOiVRDOoJlhhcTvXdU9jEd8hToZgOJgvkrvd4+
         4Q4nqKDb2PmcdM1/HevPO8Y//qMKvrDoVBP6OY/nLwKzEbNKXuXy0zkYjw5fWvUefIAC
         szlNrr2y2gwAFmuN6UyH2eQGRLeLRqgPjY3lPmdv+0PMG6siRuFCw6hp9kpEtCWUi+TS
         1sDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5KqYraTj0m/npmMYvviPpYw9TeR5k5RIkP6zp07/DXMQ2TQ9BW/+mzHqta5TNUHCl6d5njfOz2PPDMlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5So2qfdbAUirkT5/5JvlFO8MhQ27jKc2nYg6AlF6tAxWJQP4y
	0dXyFJgk+x40jbhdb7EhzvGpxKTxGTKK3KtlcxIp+LHLndN7C5cf
X-Gm-Gg: ASbGncsgqfppPxFA9EASqzGa+9XZm9voShMZK58pt5AGA4bpVItaSqV2lH3cVq8FzfX
	L/NY6F98vLC+fdCG2RBuAlAMkaQPxXuH2ONGk2Su0JTJHzcWSI+U162y5DtkVlrm+o5R+DqdYvr
	yOarCpeq8n7HPJGQeE4NOcOO7NIrPnOTjw6MaTNYsZArvunkYWVKkkHBAmX/fZQueQR0tPIGA7/
	edbtKHqYf8Q654uuIpKIFcolx7eRm5iXbZuhu/gBKdMUzIZuOGAdOKhiEDqrTvqh+xOv3sGxjvI
	9IpIbmoXVgeMA3tL18TDWB56LnOw/CLeE1f39ycaHa1OulRO6pgsnYvxFrncAd1wQmG1b4u4sA=
	=
X-Google-Smtp-Source: AGHT+IEnZTNGMRVDZWEmNMh2Ly2iO00Yysf+lVJrqtBsE5l6FSnrdxxlk5xiRwD/bXG0pp141DVtRQ==
X-Received: by 2002:a05:600c:a409:b0:43b:c2d7:44d with SMTP id 5b1f17b1804b1-43bd2adb09dmr3443515e9.21.1741129131631;
        Tue, 04 Mar 2025 14:58:51 -0800 (PST)
Received: from [192.168.1.132] ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ddesm18952075f8f.41.2025.03.04.14.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 14:58:50 -0800 (PST)
Message-ID: <541539db-0015-41de-837f-aabbea68486a@gmail.com>
Date: Wed, 5 Mar 2025 00:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] imx8mp: add support for the IMX AIPSTZ bridge
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
 <20250226212219.lthoofw7nrs3gtg6@pengutronix.de>
 <20250227112856.aylsurbt3uqm4ivw@pengutronix.de>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250227112856.aylsurbt3uqm4ivw@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/27/2025 1:28 PM, Marco Felsch wrote:
> Hi Laurentiu,
>
> On 25-02-26, Marco Felsch wrote:
>> Hi,
>>
>> On 25-02-26, Laurentiu Mihalcea wrote:
>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>
>>> The AIPSTZ bridge offers some security-related configurations which can
>>> be used to restrict master access to certain peripherals on the bridge.
>>>
>>> Normally, this could be done from a secure environment such as ATF before
>>> Linux boots but the configuration of AIPSTZ5 is lost each time the power
>>> domain is powered off and then powered on. Because of this, it has to be
>>> configured each time the power domain is turned on and before any master
>>> tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).
>> My question still stands:
>>
>> Setting these bits requires very often that the core is running at EL3
>> (e.g. secure-monitor) which is not the case for Linux. Can you please
>> provide more information how Linux can set these bits?
> Sorry I didn't noticed your response:
>
> https://lore.kernel.org/all/a62ab860-5e0e-4ebc-af1f-6fb7ac621e2b@gmail.com/
>
> If EL1 is allowed to set the security access configuration of the IP
> cores doesn't this mean that a backdoor can be opened? E.g. your
> secure-boot system configures one I2C IP core to be accessible only from
> secure-world S-EL1 (OP-TEE) and after the power-domain was power-cycled
> it's accessible from EL1 again. This doesn't seem right. Why should a
> user be able to limit the access permissions to an IP core to only be
> accessible from secure-world if the IP core is accessible from
> normal-world after the power-domain was power-cycled.
>
> Regards,
>   Marco

I'm no security expert so please feel free to correct me if I get something wrong.

This isn't about S/NS world. The bridge AC doesn't offer any configurations for
denying access to peripherals based on S/NS world. AFAIK that's the job of the CSU
(central security unit), which is a different IP.

Perhaps I shouldn't have used the term "trusted" as it might have ended up creating
more confusion? If so, please do let me know so I can maybe add a comment about
it in one of the commit messages. In this context, "master X is trusted for read/writes"
means "master X is allowed to perform read/write transactions".

Even if the bridge is configured to allow read/write transactions from a master
(i.e: master is marked as trusted for read/writes) that wouldn't be very helpful.
You'd still have to bypass the CSU configuration which as far as I understand is also
used by the bridge to deny access to peripherals (e.g: if transaction is secure+privileged
then forward to peripheral, otherwise abort it). See the "4.7.6.1 Security Block"
and "4.7.4  Access Protections" chapters from the IMX8MP RM.

Given all of this, I think the purpose of this IP's AC is to add some extra,
light, security features on top of the CSU.

