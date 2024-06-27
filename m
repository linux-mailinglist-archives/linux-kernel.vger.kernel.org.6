Return-Path: <linux-kernel+bounces-232762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25F091AE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AB51F2933A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B1719AA54;
	Thu, 27 Jun 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="akna2kaA"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327419A299
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509397; cv=none; b=AJ0g8/DmfmPskjJXGo92/EnKHBY07fbHA2aVAHc/1ViNj++cMEVmgREwbwnSjO7DOf7aqb4fSZel1SDY475zBzNMKCeI1EprfGHNXQJjyQOp0fqv+WNqL6QzwIImSR9wPZGfgccZxJ72b9HQtt8q32ck9MkXW+k4uDpb/4ZRPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509397; c=relaxed/simple;
	bh=zMRQ/km/ojBXUyTchfAUC4Oo3PeRMFSSBFUgEoe9vv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwIwr05VMBuVjQdKz1a7IpAGzwdlQEl1UhCHiUhhdOyUCZ/qzq5mu/LEJp2S39hNiqqxC9k/VRSuE5i9h4AYb1FfR0Wsl392jTatHGSvbnjdTkiR0fy8l1SNNAHFEpBTgDaGpfatGpSz+e6MIr5/5ffrn5TNfe2899Oj1SZgck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=akna2kaA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-721b0a32e3eso197168a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719509395; x=1720114195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xq35sMd32yDMo3+5aiKsKt9qyz5ihWle20B7ES2hH4A=;
        b=akna2kaAGhYyzk5DSRrvFcE4EBM0fUSvcM67HYMoSp6uEh+wzkXmAnbYSme2mAwCVx
         r7HJu7JQNID6F4DHkT7T1cSlyewJ8EN8WoqPnNV/COG9QyPz9jGYa2sNlAbiKNAuVRHm
         qHiqImxz+sUFxyfUk64rLrdUXUILZkwTQ0Sp+89rB8gn5eSjdjg+W95LcuKaXvbB4R9j
         eAJ4JG0TjaxVgZLy8U3s3Ci0DsiKMV5vCo/gOu1h3caPHlivKKe3hXf6nTHjHoWtAndl
         Qa0jjDTPiCwheBzThEvIT3tM6K+T4FyH2bqSvhokrtU7ctTDPsXLh3nykJhFgebD0goH
         f0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509395; x=1720114195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq35sMd32yDMo3+5aiKsKt9qyz5ihWle20B7ES2hH4A=;
        b=BfSCFKErY8/GG2HHPSdOe8F6xOhJU5ewNILwu7MTP1SQNAQ8JlTOuP9f3NWQN7obCf
         tr/COQREhkZIeXndSIkp0Jtl9x8l1j7GOAomo2F3rUVk5RjuGIlEh+pAPfKK3/v/uFKt
         L5NL7oc9sSDhSwvNC6jSsDItsIoLOQVqv0JPTqUiXV+TSeQUGIgd5yMXxfegnfRdx5DW
         MpKVN0R087M2vxkxp2SiH72cZemRjTHGurpx00Rj1ht5yyajPJWSDEjP/7uSRTMkB/nc
         FkHK58WVepfwckdx9Yq9HsJYgl4sHvPUv8JL4IXG1jOO7RymKO1n0hzFDyV4dGIDscYA
         F+ig==
X-Forwarded-Encrypted: i=1; AJvYcCVpBlFGpAr4JZ9GLm/Ted2joZ3gPpsqiU+/Zf8eov21zqc4g3Lf3DTRpepb8o/rWFAXOLnzi23b3d8dy6mbX7RLHtTTcMe7CQVXBrxJ
X-Gm-Message-State: AOJu0YwbTBqUf/PoNDoZY3Oq72gSdbhsVuJ1Oiei2K7e1Xpuz8Eh3PgJ
	MGTaFKs+T4W6LbUSdaXW0zJuE3laPmoRoCRUNFBLPW1XUBba4smgZTTdE7GBYw==
X-Google-Smtp-Source: AGHT+IG4jsuAgbaK2DOf116t1+8AqkjA80ebNfG3cD1TZDM6FHT74Gu8f8B4YCrrhyZLG4RiOPzc8Q==
X-Received: by 2002:a05:6a00:408b:b0:706:5c2c:e202 with SMTP id d2e1a72fcca58-70667bd82ccmr16214504b3a.0.1719509395232;
        Thu, 27 Jun 2024 10:29:55 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3e:18b0:f314:9f76:9f94:eb43? ([2401:4900:1f3e:18b0:f314:9f76:9f94:eb43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b491014csm1631764b3a.50.2024.06.27.10.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:29:54 -0700 (PDT)
Message-ID: <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
Date: Thu, 27 Jun 2024 22:59:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 22:42, Michael Walle wrote:

> Hi,
>
> Could you give us a DT snippet of how this should look like with a
> board?
>
> On Thu Jun 27, 2024 at 6:26 PM CEST, Ayush Singh wrote:
>> +  board:
>> +    description: board attached to mikrobus connector
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> Shouldn't this be a subnode of the connector?
>
> i.e.
>
> connector {
> 	compatible = "mikrobus-connector";
>
> 	// phandles to the parent controllers
>
> 	spi {
> 		temp-sensor@0 {
> 			compatible = "maxim,max31855k";
> 			reg = <0>;
> 		};
> 	};
>
> 	i2c {
> 		..
> 	};
> };
>
> I don't think you can introduce a new
>    compatible = "maxim,max31855k", "mikrobus,spi";
> if there is already a binding for "maxim,max31855k". But I might be
> wrong. Why is this compatible needed at all?

So I did consider the design you just proposed, but I was not able to 
solve a few issues.

1. How to deal with say 2 mikrobus connectors in a single system?

My goal is to have only 1 overlay required for the board config at most. 
Ideally, I would actually like to add the dt for most mikroBUS boards to 
upstream and thus only the following overlay would be required:

```

&connector0 {

     board = <&temp-board>;

};

```


The problem with making it children is that each connector will require 
seperate overlays for board configs.


Additionally, there are boards with 1 wire eeprom available which can 
theselves store the overlay. In the current setup it will look as follows:

```

&mikrobus_board {

     thermo-sensor {

         ...

     };

};

```

Which is completely independent of the connector. If the same can be 
achieved with child-node as well, then I am open to doing that.


>
> Also, the mikrobus-connector driver could translate the chipselects.
>
> -michael

Yes, so it is currently doing that. Translating chip select name to the 
actual number. I am doing it the name way since some boards might use 
pins other than CS as chipselect and not all connectors will allow all 
pins to be used as chipselect.


Ayush Singh


