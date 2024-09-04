Return-Path: <linux-kernel+bounces-314267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425A96B0DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A021C24A70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542EC12CDAE;
	Wed,  4 Sep 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOoSmkMx"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E284D13;
	Wed,  4 Sep 2024 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429501; cv=none; b=NNsRl+hnNgqe8Z/lOK5O/7GoFHydrQMPo/swy80i7eyolgArstkaxiM/Zhutm6jr52fnWWJBVJOfuymIAW7hrewQZnA3L1RWt5/E0zq0heji/BfrD1P85veD9ZB4VWLiqvIFhuJXmG+CGoXpWrD24XfvKJEBoI+CG8l8EzQ7Z7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429501; c=relaxed/simple;
	bh=oNYwWJYWQpGDpgKwRgiKGALfmLe7qGgfN2efI+xa5oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZgh6t+rlhH+Mk0saYZi2OToMinl+Shxor2Ndv75WmpI1FKNpHXWpx85BdkemRjjq26dpgpETl/FpsjReoZE6vSPtEBQKnErqQ5wNay4wBCP9nSbpTCiRL8OX63i4xkGm2R1FUlQboyKgabEIxZcMCzjJ4Eb40HGltvNy6vfrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOoSmkMx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f51e5f0656so69124161fa.1;
        Tue, 03 Sep 2024 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725429498; x=1726034298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0omUFOs4OLQJD4yIoRA604ndLcoIUTdDs1NjVzHrUE=;
        b=bOoSmkMximZyROFw6ZSQieRuCdExJJwRH6Qd9Hki3LS9O6bR1qUQPFMPLzSYZpnsmg
         DP1fCovgj+OhXARRB3auxPQ+d1ejHkTPaInJYNF7iVRkEEgRx8ZgvZOjbT0JkvNG4lWh
         kQhv83YymyorKlisQuZPoq0Usz37gYxkIyXtZeqW06fdqqytzA0i7/WXzMPABTCTCkl7
         VSlGhWeYCPaKQjDDdSqIsvr9Up3VbMAfZV4bb0e6BFJjb7fwKdwjmwM+nBO64GsosWYb
         3gGH71LwOGqEvWj1QfIygjd2rO81hPHBzJCLMQ32TX/pJrKRP/NVoMN+wVzDsYaGn6J+
         OnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725429498; x=1726034298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0omUFOs4OLQJD4yIoRA604ndLcoIUTdDs1NjVzHrUE=;
        b=p7o1wSpyrZMx2/928xqxAodsJHgAD117JNJgEjPNzDJdJPJ+I/nEKw5yXQ3L1dynW3
         oeu1jaai4Zew1BD4fY3nzGwAGt+t5I9hjyiMQqgc2I86ph3iL55b59lkNY5QUh6knFO0
         7ghUJunfPcWup7/MEiWTFFS+tAP7Vclg4Kz5MLJJ69IA7VpmTEdAeT2IIMCV3i4hnqAn
         teMejrcI3mUNlk5YH1BEwp6JQsl2qpC/uiaEQQcdwXnfgPhs/WGPcfPxXsx0kR+9MRkm
         RNtp7KZqVM5hF52OdNoS23/SmhKxQNQwGJQs1q5CbQ7huzjzZg/1LU8Ko2GbQE/sWWCI
         4M/g==
X-Forwarded-Encrypted: i=1; AJvYcCVx0vvSE4YhoLUuE1xq7sczU7JRPZh/SYrSzQ6dhWFuuqWksp8nGPxmS+eISRPlHWKozy3PgEOFus6f9P9I@vger.kernel.org, AJvYcCW+xGfMnUPqiIx+vXIg5/2RvpyYK0UB8I6OTO1dGvEYljI7QwFGH3ilQvPD4S5760A6+BB27i3AGKif@vger.kernel.org
X-Gm-Message-State: AOJu0YyZChMp82k89V3eCwKzV/DBrZ7ZjSPx9zmkWdW63jRWGf+vIyCs
	UCigBRDyQ3CEvYBqtkFZP5gok496wqJDgErYdESV+L0DUuVexDce
X-Google-Smtp-Source: AGHT+IHrPNxxS2Cd6TM3AgMeS8IBGFzfsDnDgx8CO/vlipfZW89aKYRhbHhycVmpyp/1oYDnXRagsg==
X-Received: by 2002:a2e:70a:0:b0:2f3:fa99:4bab with SMTP id 38308e7fff4ca-2f6103a7574mr114751601fa.15.1725429497026;
        Tue, 03 Sep 2024 22:58:17 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615183134sm25255471fa.122.2024.09.03.22.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 22:58:16 -0700 (PDT)
Message-ID: <d9607b0f-555a-4a98-b3a9-ca99c0d1aace@gmail.com>
Date: Wed, 4 Sep 2024 08:58:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: Fix various typos
To: Yu-Chun Lin <eleanor15x@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, broonie@kernel.org,
 angelogioacchino.delregno@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
References: <20240903164242.2188895-1-eleanor15x@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240903164242.2188895-1-eleanor15x@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 19:42, Yu-Chun Lin wrote:
> Corrected several typos in Documentatin/devicetree/bindings files.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
> v1 -> v2
> I took Krzysztof's advice to fix more typos.
> 
> v1
> Link: https://lore.kernel.org/lkml/ZtUTg0C81FwChfDh@visitorckw-System-Product-Name/T/
> 
> .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml   | 2 +-
>   Documentation/devicetree/bindings/cpu/idle-states.yaml        | 2 +-
>   Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt     | 2 +-
>   Documentation/devicetree/bindings/iio/accel/lis302.txt        | 2 +-
>   .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml  | 2 +-
>   Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml    | 2 +-
>   .../devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt    | 2 +-
>   .../devicetree/bindings/media/i2c/thine,thp7312.yaml          | 2 +-
>   .../devicetree/bindings/media/samsung,exynos4210-fimc.yaml    | 2 +-
>   Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml  | 2 +-

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


