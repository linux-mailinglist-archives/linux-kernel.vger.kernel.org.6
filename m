Return-Path: <linux-kernel+bounces-195992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC518D55D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3401C23B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2551836CE;
	Thu, 30 May 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHDmYdw3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04297770E2;
	Thu, 30 May 2024 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109523; cv=none; b=ALuaCO+OBq7pR/8b1fccksvtBTXOD0cYS3M1sfJLJarP6qCLB2F0w/r37496p8miJk2DeipiJEypO9qHKIG2yng4UBQoIR5a4zN2I9fL2SsJ0ZIr9yBedoPQNGNnY9Ur84VEvJketmbn5uKaZawwzMb3wbEDVLwH/1YnC96SUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109523; c=relaxed/simple;
	bh=esM4Ng1cjWry7Pi6WQgc+vs4PZklIwNsf8xjapEXNYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3rb3mSwbD+jJkkNRFpyUQS2NwqF5WS+gkerTqPibG4X5yZ7SyqNulG8YnjYsQ4b/UhU56qyy5h8Xuz+Ub6YJes1oCaS83jxOzeLjQoGwa31CSyKxZ0hMLt0ZbYxMLNDsyPS4qvE7QKrGpfZQxoCEKuTLekrWUtoID5gbaVURA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHDmYdw3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6134df05fso13428415ad.1;
        Thu, 30 May 2024 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717109520; x=1717714320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TfMb4eq1XqctB8Z1VY0M363Pe4OUmqZl0YWn1pmmK1g=;
        b=CHDmYdw3y86B3/KzCC4H6Uvra3W4xlVE8kXACsNfJMFvIlTV4CZhJ09IcvTT3l3CAw
         XY1bfpcc9jpk1IUyxz8GCKXzrSrA0DeaMXsbRZ/JgDd1GmMpSRWQagpzeWzvnNglxq4D
         rVWIaXrvvAGSAv194BrEm9B/wG1iRPUAQd3YR35T/25VlLaRIt9rbfU0Ynj986qm72k5
         /MnmrXIfjmGja5lVV3zJL9ncV7rxPlB25gM7mMXRK0VWC0bSL+SRQ+AcCNhBSLs16IVc
         e4sMHYmA8pm5xttLwXsaTc6rziW3RecgN2rz+AjRPpwk+Y5EGj3H0LlOpJo63jW3Giut
         x9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717109520; x=1717714320;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfMb4eq1XqctB8Z1VY0M363Pe4OUmqZl0YWn1pmmK1g=;
        b=Mx/KcyW+ucyNg/Ig+tTwzx+N5F16SkU+NZ6K2aWbnZBbvekHMjOWR3QsdtsSkdP4DZ
         4ZJTmruFJhy31TLjY9xjZCSJBMZBgEm0UayuSyEPMOOp3PztQIXutT9BGzen2eOssF4H
         POEgjZAkkRUiR+0LiCHO788bhR9nPV12ENGJ0wYvgYhYA6DTs3CMRN86knPgwWvcbxz7
         1v01jGZFQomWP6QZtol+HXLsN79zfKqRmP9mCPvW+EdmxFWCe2ZKoVqk5uLsXkHDtEHS
         Ni0ymKW8e+uJBIuxvJXxJLL1zUfpnn12+2DCVL1rjKezLLMn0he+g3MlVuk/SKBzqWYL
         AO9w==
X-Forwarded-Encrypted: i=1; AJvYcCUaFUB6Repxo+UF8NdFVva9rlfZw+UMb/VaqYMh1bX3M9jzNjjyRlSv6haLKFUEY6jqszeslrS46Y7Ouj4HM+8H2k6/BF4n56eO7qGn
X-Gm-Message-State: AOJu0Yxxo1GcpVxPyw/Hnzy9JIg0TO7DORLuX1XOJtm28gAcwuvR25jQ
	eH7OVX/RMoDWwI2p/O1J5JJywkPYqXhe5KQTS/IwR/tiQ5xEn9QGQz5W2w==
X-Google-Smtp-Source: AGHT+IGuY0I0anEJSrBNOIsJ4SaJReLMNog8bighPuGMI1Y7afrOdbsu9nz73J3wvyAkLS85wVhukw==
X-Received: by 2002:a17:902:e5c9:b0:1f3:39f8:7e7f with SMTP id d9443c01a7336-1f636fd9c99mr2368225ad.14.1717109520431;
        Thu, 30 May 2024 15:52:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323f8544sm3005705ad.239.2024.05.30.15.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 15:51:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2520ad43-59a3-4c48-a975-08d856736942@roeck-us.net>
Date: Thu, 30 May 2024 15:51:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hwmon: Add support for SPD5118 compliant
 temperature sensors
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
References: <20240530223939.1027659-1-linux@roeck-us.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240530223939.1027659-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 15:39, Guenter Roeck wrote:
> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
> sensors. Such sensors are typically found on DDR5 memory modules.
> 
> The first patch of the series adds SPD5118 devicetree bindings. The second
> patch adds support for SPD5118 temperature sensors. The third patch adds
> support for suspend/resume.
> 
> Note: The driver introduced with this patch series does not currently
> support accessing the SPD5118 EEPROM, or accessing SPD5118 compatible chips
> in I3C mode.
> 
> v2: Drop PEC support; it only applies to I3C mode.
>      Update documentation
>      Add suspend/resume support
> 
> ----------------------------------------------------------------
> Guenter Roeck (3):
>        dt-bindings: hwmon: jedec,spd5118: Add bindings
>        hwmon: Add support for SPD5118 compliant temperature sensors
>        hwmon: (spd5118) Add suspend/resume support
> 
>   .../devicetree/bindings/hwmon/jedec,spd5118.yaml   |  48 ++
>   Documentation/hwmon/index.rst                      |   1 +
>   Documentation/hwmon/spd5118.rst                    |  56 +++
>   drivers/hwmon/Kconfig                              |  12 +
>   drivers/hwmon/Makefile                             |   1 +
>   drivers/hwmon/spd5118.c                            | 510 +++++++++++++++++++++
>   6 files changed, 628 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
>   create mode 100644 Documentation/hwmon/spd5118.rst
>   create mode 100644 drivers/hwmon/spd5118.c

Obviously this should have been patch 0/3. Sory.

Guenter


