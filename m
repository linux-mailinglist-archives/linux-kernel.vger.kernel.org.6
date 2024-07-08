Return-Path: <linux-kernel+bounces-244121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C848929F73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DB1287EB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE897A158;
	Mon,  8 Jul 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZK/SEAT"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C046BFA3;
	Mon,  8 Jul 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431760; cv=none; b=ZxIhIXX00eag3yyb1Of4QqiaqVnX1jEky9aJ7lfKWspd6R25k8SvB8mqfEoo7Gu2vVDIHSdZ6KvOHZNOON4v25nTrNlfPuTYezjP6Bmvg/I9dnQDnpBCAOvo90UQhlIF7HTVKGX8l7XTNx7Vm42KagrX7J7HRRO2slC4TPl/5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431760; c=relaxed/simple;
	bh=mz07ADnOpqBfEoQZoFqYXG8RDvaEWb7YImF8yp934tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fILUcoQM7mzuaAoxbOC2lnv1OsYXD7LM3HpIfS36cmUZra5Qa914du101pdImCBalat4088BGLv50evr3b/n+O0xL9aqaLkewwMY4o3Sf5yxtD7f63ByYb08YUNuD2v441sJOLSS2p3QJ9fw75wVj9WFGD711f8+8FzjCP+NT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZK/SEAT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38028so4622260a12.0;
        Mon, 08 Jul 2024 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720431757; x=1721036557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPFgBOg0BwvjqhaIzOQzuUDIJVPwIY9J0BPpaCd2cV8=;
        b=GZK/SEATo9L9x8d7qzhgGmZj0ApGqTzskzWJuAlSOMmSQurEMqUvVRGmy/B5Ewku8C
         meZqyJ2nScGK4wtld0sc7N4bhJohgKY4kKPELzcJfKqF3wcazhieyrrGRZeB3YoXn3/l
         mmaXgdraKPIkrTNmccxfw5EZHk8cBRZRYe1VMN0yo066jJUawiJK2AHGsq+f/PYYjdO8
         0qMfCZ8epOgvYMFGM+d5e8D7LwUDOllTeHVYlK4wgYn8j/bITdxn4asMmRiASFwdOZ33
         akWaEvZmJBZ6StCQisSaqv8e3jbYAKHU2LVQp7K7mg4RW491o81NQSl6TiWJx4jRVW+5
         gM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431757; x=1721036557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPFgBOg0BwvjqhaIzOQzuUDIJVPwIY9J0BPpaCd2cV8=;
        b=w5ip6+pPnQndeHPjW6JG9H21p8HdNTbMJ5jPBAYbZSf/j7PNvaFJX4q3HAlFpfJydD
         nfVbw07EsWQDBZY+KOY6WbskuHkcWfH2okWdiBPaF9QQaw1ore1MwbL0WFXEu1Fyi0MC
         OAL9hqj0Po6qDjzMExhxx7KzMdT9Yfbg0DSvajN79AV/kOSbygfEPL0MhLIh9afkcbXQ
         iCtQgZoYb4nxi6CdnidpAgYiS3v8sc5XToeo2IQCakkGOi5OCR4s3XkDZg5YWvb3u9PM
         j7KdETuoNuNLgnFDgaHQuvXfru9Iy0/daASa5JSAQR1BqQeeEOMtizfa0MfJfV5Y/Azo
         l8bw==
X-Forwarded-Encrypted: i=1; AJvYcCVXbFMWsSs6htMDJSlVlADSd217W54OGGmUQVTng7tBz8V/hRmZj3UlffyglcadpoJAm+xeQVzCeHX1kjQlBX7hi0MW5vVBfJQ5F5RfMTgA9BuWxNB0VU7UtfLbnmlrJcAYif0P3XjkGA==
X-Gm-Message-State: AOJu0YyzBb9r36K9rZcRZO8ngiXu7eQENqylmV1F8bgW3NKBagkCGd2U
	vmGuR08klLaDESohWZ9js4ZvYvWqr0zI0Vg2JiSv2fPnmBkhs7sP
X-Google-Smtp-Source: AGHT+IGJTVwfxRPLlqsy1KIoSb8jqnFfw/igQQIrxqMOb9EfhE4RP8yDb4xRHk0zohcC0359UuhRFw==
X-Received: by 2002:a05:6402:2349:b0:57c:aac9:cd8 with SMTP id 4fb4d7f45d1cf-58e5a7e8b66mr7953030a12.8.1720431756473;
        Mon, 08 Jul 2024 02:42:36 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5925eb01124sm1539068a12.32.2024.07.08.02.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 02:42:35 -0700 (PDT)
Message-ID: <329fefa1-5274-4f74-8d7a-aaf8d2a65189@gmail.com>
Date: Mon, 8 Jul 2024 11:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240705225821.13196-1-zajec5@gmail.com>
 <20240708083208.322f4418@xps-13>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240708083208.322f4418@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8.07.2024 08:32, Miquel Raynal wrote:
> zajec5@gmail.com wrote on Sat,  6 Jul 2024 00:58:21 +0200:
> 
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot environment variables can be stored in various data sources. MTD
>> is just one of available options. Refactor DT binding into a layout so
>> it can be used with UBI volumes and other NVMEM devices.
>>
>> Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> I'm sending this PATCH without Linux changes to see if this is the
>> right approach - for developers and (DT) maintainers to review it first.
>>
>> My previous attempt (see above Link) turned out in refusal so I'm just
>> trying to save some time in case this one goes wrong as well.
>>
>> Hopefully the included example (which I really think we should add)
>> explains well how I think this binding should be used with layouts.
>>
>> If I get some positive feedback I'll work on V2 with actual Linux
>> changes.
>>
> 
> I am still in favor of this change. I know from a binding perspective
> it might be questionable; but from an OS perspective it makes total
> sense to deprecated the old U-Boot env "device" driver in favor of this.

Please note that at this point I didn't decide to deprecate the old
binding (using "u-boot,env" for flash device partition). That would
require mixing "nvmem-layout" with "partitions" which I believe Rob
objected to.

My PATCH in its current form just allows reusing this binding with
"nvmem-layout"s which is needed for cases where we agreed to allow
"nvmem-layout" (UBI volumes and pure - non-MTD - NVMEM devices).

If we want to refactor this binding in MTD partitions context I hope we
can handle that at different time if we agree on some solution. I hope
and I don't think this should be a blocked for this PATCH.

