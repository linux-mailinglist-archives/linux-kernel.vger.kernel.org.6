Return-Path: <linux-kernel+bounces-430646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373D9E340B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96DEB24176
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DE18BC19;
	Wed,  4 Dec 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwQi7AGy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F0184
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296902; cv=none; b=PYhqMX9vm0eC/EpZTcg7gu0soZNV8c8zqGxwU2rAllxXikjTsc/RX50OzF1Pk5lrHt2jCopzhUPmAsGu212DOVtgyLTbnkYuaaxFrScLV4mPlAQrPJKLYayMLn+2Qb26JuLJ2lhgVga5ap6v3TzK9a/Va11N8rebLQlWsRkaQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296902; c=relaxed/simple;
	bh=KKSE9DBbWd74OZz7qAscih2d02vcu0RJ6LQNQ2JTXYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GICYsA3QmyL0Jzc3M1apVkpFh2doyARvAMtFQURWFxV6YgZmMxA3XtVEl0GxDRr8Y02ibvTlbDn3AXV8yi8Xnxe9fsTLbhV0deh1/QKI29mU763obqQ8m+tOptWQiLtdQmO29zV9/Gwadw5hhXUAEOubSzA9IYoA/g5r4pZCehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DwQi7AGy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a1095fe4so7575655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733296899; x=1733901699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1xLPBUzUotQ8W4dnkHC8pvofzpJw52qNUZu5+hvGuQ=;
        b=DwQi7AGy3qHQCW8Os7S1um34486gUxBGsUmEhKwty9+8bzFGNMqB7TPut0jF1rUw0C
         2TZo1I1OjIfbf68sxK/wnhA8dPdJ/eGCtWptSK5TZkpRFeIzyMRnn0oyQOASPukcgDxH
         BHvfv4LaKCf5Ox0bBrlSicSOI7BMH5KFn9pX2MMtpEt8Me7wyeux/UMvACIxJskbePNO
         9Eybyh8JRzviTqhpT93z0D0Z6wtVOrhHCL5iBCfDjNlAruQJ2WtJ/BidCWHoOgBZ/Nxs
         q91eghBt6qurn4s2qrFXFQFlb7u1CM3a06Ysf5B+DcrGQWTdi916TsIlwylAjTe66Nuc
         QZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296899; x=1733901699;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1xLPBUzUotQ8W4dnkHC8pvofzpJw52qNUZu5+hvGuQ=;
        b=R4BQATCWynXURCMEiF0srftYFELHz4qj/0TFGUQGfG7MC4MwAgS43tmlN9Q1TKN0oA
         kyd9ERqi2pLut4qw43MtWraalMe/IGX/n3QtNCqO7EVA4G8TV/ToC0dpCUFnZsROMZXC
         FSb2GjAJCze2KGJ/7qTWE8ohZi0wpRHuRLgWNgcS3NxrnO0D31crL3M+azx5j03B6iWP
         NxXrupd3YW8dNrwMjB2QfrqN09FFmfR+bUOR7MuIa+G+jT1g4+sdhkjkrgQDM1zuJzTG
         /HY6IO7TXT2VZeAttK+I9NtY6ysqDVUZaeLrAOp70lAfwot1Qlj0fXsIlTNX5WetCz9k
         B+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6SjEJveELEmswNVF7UWFOv6S6kwHM4UG3mxL/x9NzbMlS7tb5OxHJYxwgnwwTEpDZKDdtggQ/pKRnuvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHAZn+dCWhl1iJR+eHyzlvU4wg0EpJCVZaRLvmR7GGTkRYnPK
	U4pmaraFA9QaP4wuesV2TtphBkQ9IxpwLQH+MUZ1Noqtm5jdvlPpTnKkfiZPCt8=
X-Gm-Gg: ASbGncsAsfTAMnxbkwhepvaxTwyFReZDbqaW97FQFAm08HSZYw/7R5e+mLF70T8O0Bh
	zyViqI80CxppAh/cbUrLdVsN9XLKk+eiffVyioeyH6qiW5m0C18P5pdNLTNEwrRnNMZuCLjTzyn
	hIr/Bs9xzj7yhIKinQGW6uf5jIctJYWXfGlWk2jP81urVR9IMkwiLos0UmwFbBEoxyrRg8f3tRk
	e55h2qYTtRzMD5lIznd2idB7cJU5h3GzVTsrZd4MVI38x4j0w/nWhp01Nh56nTlkCQW/w==
X-Google-Smtp-Source: AGHT+IHtCdQ05BQDY20/LpYx6IfP8mgaeR10Q3ey/YZ+JByIUyxE2J/jobAU8fTKHzVmlAdPD/L43Q==
X-Received: by 2002:a05:600c:1ca2:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-434d09055a8mr17717385e9.0.1733296898918;
        Tue, 03 Dec 2024 23:21:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52aa0b4sm13924315e9.35.2024.12.03.23.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 23:21:38 -0800 (PST)
Message-ID: <068c4e43-d64c-4f08-abff-675334e8f5e9@linaro.org>
Date: Wed, 4 Dec 2024 08:21:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: Enable video engine for IBM System1
To: manojkiran.eda@gmail.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
References: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2024 14:22, Manojkiran Eda via B4 Relay wrote:
> From: Manojkiran Eda <manojkiran.eda@gmail.com>
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
You CC-ed an address, which suggests you do not work on mainline kernel
or you do not use get_maintainers.pl/b4/patman. Regardless of the
reason, process needs improvement: please CC correct address.

Best regards,
Krzysztof

