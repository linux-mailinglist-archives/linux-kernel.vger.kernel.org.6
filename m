Return-Path: <linux-kernel+bounces-421272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6A9D8A84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D8EB3074C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103991B3934;
	Mon, 25 Nov 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6ruaafA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDA1AC453;
	Mon, 25 Nov 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547595; cv=none; b=Ufi/7WQjBE694fVpXgOhkAUhVeoLybghVdZACM2dEGGoc1SHhRmg3ec0ly1J+emcPhdGvRFRuEtFVnNGxpjNdxKQWVrDHUdf5lmAHbdgCx335jiI2EAgiqdQEtnMw2lfHR1esN/lqKwQj08VT11KiuUC5qvDt2zUy1hPKf4c3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547595; c=relaxed/simple;
	bh=BsyKX6vvZXO6hyTAnWAhmcMb39KdsKIPgutxDoUf/8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIGv1WkKnc41Kz2CCnLSNkdJSrKIHMeRzDoeoMXcc0Jt34OnOO5e6S7+0o8oFymUKRGDC6Uv/88kgRTw2HmguqpOuYog1QW5+YsShaPYGtPUxwRDSJe3JAQMXLCO1PJw5KgfF9q3EF8c1zdkBs3QXXWOABu5e2cpQzPAAXzzuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6ruaafA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf3e36a76so44030845ad.0;
        Mon, 25 Nov 2024 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547593; x=1733152393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hWIkfUGCL9W1Zq8MHpEKhoEtRwgrNR9DLJVdVZwUULI=;
        b=P6ruaafAcaqKRhlOZdeewkOz10xGdSsHzkKpq+gXsd3N6Zh2avrZEaPjlJrNm7m7f8
         mCqPAOcf4LtRN8C5b+sD9Mi3c70EjcSMYPYCdI+S8/9jJsjiBHZSpYsid41LxahYSs0w
         NJkwm9Wpt1EWhqAimrCfvErtmd2WgPB/su34jw4KFXd8FALpU6bH/WvyvudEDjgVqzU/
         ilo15fmaAaSinOcaq4+EeL3gf3o69S8Dj5uswCYvQaTuuys5tn8skMRobsSy+GjjJ0g9
         1rV+TYuTTRTeCrGyUQlgE1HR3iuasMgTOMkdyHJX12ujN6bC14PsH26cmLIMTG6HS57v
         DQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547593; x=1733152393;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWIkfUGCL9W1Zq8MHpEKhoEtRwgrNR9DLJVdVZwUULI=;
        b=dLDYrFB27tBbyuKSGDtV9QWPruG967xINgo5T5vTMgHsoDGixC6gffmgYRMWqanTKA
         FTTZ1y1WT+OGHSGkM7ML3tsHTunVcAD/afbhDWrcsahFsR7uc8S3etT8xu0MBvX60woh
         +ZrfIour3/1Ar33KtzW70t8v2Lw64QrU3Z4w9VgPiLX/H8XxOOMxidEcZ7a0luYPmqN0
         ELLKWhHSHYNMPbZCoWpvnza59Fp7mzfecmW2Exaiuw1+CR81KU1PzQwRzyVtD7xyZ7y/
         6DanjuODeNpe4A++wWWDSdtMWoaInLt2Ua/Pwg3t5DKbeZOlL1dgfDHpOHuo1Pr0tfP+
         0KkA==
X-Forwarded-Encrypted: i=1; AJvYcCUgkpn+tm55ZciCAbuQVRn95s99zswTpeX5PeKyhVGkJ/X1BTYxc2FM3Uea9nGEln0CtxbEJkU/FtCELJo=@vger.kernel.org, AJvYcCUxM5jjSCQDhBKQCdrQzkm6/KEnY9WT5juRx9ACP5zL1wWDJXh/P18wiMm6MqrtSr/PYDBK6BWHzliBAUaA@vger.kernel.org, AJvYcCXCiWqmBLMN05haLRm90+Xayt+BMTWB9yMBC4IFuuGQn8dNn2RqP8pn2uufx0wWszGdSRkCsXSqPLnu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv7/99sS9M3MpRIUA/ktm5bHYv3J1yCB6woktEvRNpoaQSDJW
	7ssmbW8AHIYO20LblSKI5GVAsDuF821IvJblg6Y72QfBNQfvPyQundnhUQ==
X-Gm-Gg: ASbGncu9osjOZpOtgXO+vPmXN2Rh8cHTnY/OdrhrwBGO+ql0KlWvuCBdZyM1HpW8qq5
	PxTo/G+5IMhghdM+4NALdT3/tp3AqSMzHpA54k0EW0iso1Ro22RGZ933JMKACgSp05em7qMLxEN
	hMQLhHurp9OiA9VShOXLptaVTqd9vup1DKJpGf0lDqfiAwK7Ej1SUYN17QuEowEg1BvBlDV/WwN
	pthYwWm3DuLYMtCP7vViJ6RWYIWqtJ+8abLoRID8kD0kW1zDCqS9uTj/MCijuavZ80OhVBdb0R8
	+GzBcFlJOCwZ/cod4i4ha1A=
X-Google-Smtp-Source: AGHT+IH3avj46PI2YmdHD4XdBJ/CME2+CtrwR1lq6ajtQWeRonWYz4xkncuORRFHdz7BiObxVsK+Lg==
X-Received: by 2002:a17:902:e743:b0:20c:f261:2516 with SMTP id d9443c01a7336-2129f67b19amr188974355ad.8.1732547592793;
        Mon, 25 Nov 2024 07:13:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc23a35sm66188195ad.250.2024.11.25.07.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:13:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <893bbd30-300f-4138-8f68-64573e1f0140@roeck-us.net>
Date: Mon, 25 Nov 2024 07:13:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add properties for thermal
 sensor cells
To: Krzysztof Kozlowski <krzk@kernel.org>, "Sung-Chi, Li"
 <lschyi@chromium.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@weissschuh.net>, Jean Delvare <jdelvare@suse.com>,
 devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241113024000.3327161-1-lschyi@chromium.org>
 <20241113024000.3327161-2-lschyi@chromium.org>
 <4efe981f-f7ae-41c7-9c12-2aa3a5d2d046@roeck-us.net>
 <eb1c249c-5f42-4878-8934-09d6ea5c43f2@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <eb1c249c-5f42-4878-8934-09d6ea5c43f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 00:52, Krzysztof Kozlowski wrote:
> On 13/11/2024 04:05, Guenter Roeck wrote:
>> On 11/12/24 18:39, Sung-Chi, Li wrote:
>>> The cros_ec supports reading thermal values from thermal sensors
>>> connect to it. Add the property '#thermal-sensor-cells' bindings, such
>>> that thermal framework can recognize cros_ec as a valid thermal device.
>>>
>>> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>    Changes in v2:
>>>      - Add changes for DTS binding.
>>>    Changes in v3:
>>>      - Remove unneeded Change-Id tag in commit message.
>>> ---
>>
>> I can't apply this one (not in hwmon space), so
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> with the assumption that Lee will pick it up.
> 
> This was merged, while I was AFK, so the ship has sailed, but let me
> state here objection for any future discussions:
> 
> NAK, this is not a thermal sensor. The commit msg explains what they
> want to achieve, but that's not a valid reason to add property from
> different class of devices.
> 
> This is some hardware/temperature monitoring device or power supply, not
> part of SoC, not integrated into any SoC thermal zone. Calling it

I am confused. We have several thermal sensors registering as thermal
zone, and fan controllers registering themselves as thermal cooling devices.

Are you saying that this is all not permitted because they are not part
of a SoC ?

Guenter


