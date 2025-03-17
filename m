Return-Path: <linux-kernel+bounces-563865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F743A649A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A52167D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D1239560;
	Mon, 17 Mar 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjtclElq"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75523643A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206997; cv=none; b=Hf2Hp5+ew+txnYEjHnoku3GrnBjre00AqbZVHOsy5ErB8MyN03IvmhZckf3Gr4W0eNr/xerYsKgVpkA2ot9/8rP8v7PKbj6G31R3IJgUIo6Bd+ZPO2XYmZ+/Umk4xAD/mmAgFhyzBZuMyDA/r6NrLGNjMThB8i36vtIpzrFvq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206997; c=relaxed/simple;
	bh=iGSQ6NXu+6+ukEkaDKOdZLmmLzGAHGQQcsI1Moc2sHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqcp1VPh4fEIAaJja/paHYRC4WQfEcA0pxRpo1iTN7ce0/dMnPfjaXedSwPMatIeuDdnXc2mGxDW8mdZIReotqYTDFsmGK6u2nkj74yO2zdb3tcWzYWxz1YXEPZ1Guqo1U9lNDXNGb8tSE5rC+j7aglSdxby+OuGIhduaIm3MLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjtclElq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso7295270a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742206994; x=1742811794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qdm1qAxomHTlqJ31Ysp8XFGoFz7wUaS6yogMNzcGP94=;
        b=tjtclElqRrQiP9G4KkD2nG6CA74QShWZsqLGfAlVe0BB+pcBT+NQ0IfgpZi9XDlHfg
         lbzOWqn8sWFJSmIm2PR4B3F2If3eQi65O+1QVkC8ZhHWP0erjV8UXoukiwpOy9gdzjhv
         BGl+2DIFlCOhyI4rvN2/0RPTd7Z46ZQt+ycU/o6JZjCGuY4DsFu/iZDBbHk2e4oBJ3kC
         RhIuECCtKYxB1lBR0VBlzHHuFABQsgr3TPXUYf2lDZue4IkFY2uYC8OdVuguJ3ZQMQy9
         KWTOLusyletSAIy6DtWcphddzFSGh+c9167lg/660o2eFVVxAZ1+7F6TCcuk1et2a0Xp
         H3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206994; x=1742811794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qdm1qAxomHTlqJ31Ysp8XFGoFz7wUaS6yogMNzcGP94=;
        b=Ccbgu6+tutrMo/JrsQspArnt6tiR3fOgEm4BL0NIwjdNE1WSx9kc9MZMqL2G3w2I3W
         TPEpbJFeDDjapT10NQYOvtnwgRC2DCCD6qg9SQvicPgB6qJGBYGhlrGHqhtiScJ3rf0G
         khlqa5HWNAAZY2YrzoOOYcCSW/MLB1FJpJohIlrQWJY5hylD5bRKWFAS3X6DaTIGvu5S
         PovNJbCep2fEi7ycwK/yMPfE9Gee1GxAmx+yRQMCf5VEsQXzWupe/gUX3yIs6mGgA4P6
         eUqIlFRVR5fPp2C7HRixJjYyDW7Bq2hxaFRQeJ0xiJ2P6q1yg8z8Zbe1RYX+zG+LSue8
         8v8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUGbeH76BT8BRyus1JMx0NiEEJzUxohEVyrZdk0OGb7NbLY6lD7GRAy0+7NqBmdfrjH/4wdRX5a9vKUFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TI1aMItpCJ3OPVwKeIJxs0Nq5NiAP145DMbcfDQwFtp4ZN9Y
	FhgYMA7yWA8QkwB+K5CE7Yj+VIu5FvB8H9IaJyEWw6+MmZyaDOsAQTlX4POHjEk=
X-Gm-Gg: ASbGncvOIBqpcfj5vvhjAZgqhqBW6MNKnS4hFzpppgojv5AbGPXN0mccBK4ZbmC8qiz
	A1exep6demJxxEzzqnymXJarJPnayOYnLG66TsNrmzqX69EuQwqDuTn4yUbSoqRIRy1IQuB26/1
	cNS49zTtWM4UUOrDtP1A3U2wtRsLmHakTel5ip7/kr4I6dtpeU6mvuRLxtdmZfgUr/qcILWMt4z
	HafjHbYu5ahiO5lOnk9k0kpiykeuiwXO5vgDR99OEddcTROqSJtA8u/zjy2NDs08lt1P4PL4oIN
	i/pauJwqAF4CXEWoSuQlWXcJgJBd84K6sYGwkmPrNE+Ggx5jbVkV+FHiofNGdmk+0XpVdBuX1+U
	0XFhaWq+uUMy3lmjPVwI=
X-Google-Smtp-Source: AGHT+IHCBMDjgNT3Tdkp1GpOCjRuCJSOXbxDi3KNnxO9K77oOjx1sb8tnp36htT883NnLPExiPbV3A==
X-Received: by 2002:a17:907:6ea9:b0:abf:52e1:2615 with SMTP id a640c23a62f3a-ac3301db85emr1309545066b.7.1742206993695;
        Mon, 17 Mar 2025 03:23:13 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:900a:ff00:eb98:2c37:6a77:39? ([2a02:2f04:900a:ff00:eb98:2c37:6a77:39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a497bbsm647663666b.148.2025.03.17.03.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:23:12 -0700 (PDT)
Message-ID: <5918c64f-856b-4820-b35b-538ffdd9ac6a@linaro.org>
Date: Mon, 17 Mar 2025 10:23:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] firmware: exynos-acpm: fix reading longer results
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
 <20250314-acpm-fixes-v1-1-ab03ca8e723f@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250314-acpm-fixes-v1-1-ab03ca8e723f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/14/25 4:40 PM, André Draszik wrote:
> ACPM commands that return more than 8 bytes currently don't work
> correctly, as this driver ignores any such returned bytes.
> 
> This is evident in at least acpm_pmic_bulk_read(), where up to 8
> registers can be read back and those 8 register values are placed
> starting at &xfer->rxd[8].
> 
> The reason is that xfter->rxlen is initialized with the size of a
> pointer (8 bytes), rather than the size of the byte array that pointer
> points to (16 bytes)
> 
> Update the code such that we set the number of bytes expected to be the
> size of the rx buffer.
> 
> Note1: While different commands have different lengths rx buffers, we
> have to specify the same length for all rx buffers since acpm_get_rx()
> assumes they're all the same length.
> 
> Note2: The different commands also have different lengths tx buffers,
> but before switching the code to use the minimum possible length, some
> more testing would have to be done to ensure this works correctly in
> all situations. It seems wiser to just apply this fix here without
> additional logic changes for now.
> 
> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

