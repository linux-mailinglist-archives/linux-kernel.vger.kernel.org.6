Return-Path: <linux-kernel+bounces-300110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D995DEF1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AE1C20EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68D15574A;
	Sat, 24 Aug 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NGbmB1AU"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9992BAE5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724516269; cv=none; b=b2VEY2gF1OEz+N05KBXuC2eRFQRdeciQDKbGB9aapuT6Ra0bsk0UGxBmT+GAnl0LhWdir60yokQNF+XFcTalQixjC9pHN0nw835+hJvxWVGMpbGz9LlQrx6y6BtTENmTHoDuKomhOywS0gJYJgCxN+yZiLP21UYaZRHacdnuQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724516269; c=relaxed/simple;
	bh=0TRUzX7NRSHjcFUZ99/pBlP0WkhXQfwWMr5tIux8OGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beX5QLcvzDEw+By9bHs9vpTCZGrZCs9QiPb2U0s7N+Y0ybEnsAInYD8/mb3Cu9ytCPyVGCWfZ/b0yKa4Lp247fA3wfCik+u19m93CooamFccsvbxjrf9corcZpHLr000nts4hF/MIiC3YeXEG5nCKq0HrOjSuUVaNRmfEjDDwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NGbmB1AU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f4f505118fso18070601fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724516266; x=1725121066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLewfIc0V1606kS8OnVX5wewyAHhmWACUF+UrTlyhhY=;
        b=NGbmB1AUY3IvLYhvJLM41WQG/hJOsOBtv9RAf2/Sh26ahYggI7GPSmgCFAjgoMvlWU
         N4j2u6ji27fiThh7wL1SRMJoryDz50BRiJfyecMdtQCqw7ZHxYoe9LkxVsnwQZF0nDVP
         jRbvclNRK3bna3ywOhvceqLpIL3s5bU9/t7m1qnTzP8wEbClesns9jZgmmhxy+0v/Jug
         shT0TDJjO5503qZ8kV8ZjmehBbT/Fky0kBgqNsm6TwnUyEY8STeyWwJ9cdAsxgmnMOFe
         WFTeJ39CXW2wrps4EmksW1wJELgPZrj9KMHSHxCSmEpE2NMcQjI0PhorLIP4Gb2WRtje
         w5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724516266; x=1725121066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLewfIc0V1606kS8OnVX5wewyAHhmWACUF+UrTlyhhY=;
        b=S+57VRQbLpZVwAvexjlI0iioCj+yZ7B8bW2PIn6LbNZp5wgN3F2xmR5WxdOAevsUY4
         N4XRmUt1Q1rsfvmt1vsRZC9CeRQyoiSiylyyDlpeHlHVPA7Z5RIv1oLw/S/Dgnv/boFf
         64MRWsQxW+gMdhxJURNtB6kvnZRjELtHFfsPOWIxHHBET+AZ44Q2qHGC91IgMVcff7k+
         qhRqL4Fv4CVTUQVp80gLGQRxZjwtktv2F+RMpkwAXEUmgo71CyrsqVw4edE4NPa9J6j0
         QwkK1/Iz6McHb9QNunigWJGKpHNh7CAstkDFpvBN71zSEYzKqJ36HSMTym46hVVzDUXL
         vidA==
X-Forwarded-Encrypted: i=1; AJvYcCXpRlXVvZ1hG78yqfJ1rAdA8Uy6f8ordoj07il+rPV/5lQhPYfWQ2sJSlPs+7eUwviHphlq5aJcqGUuBZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsM/Jo+ljUklYr90c7lU918ylxv1fArd8twHZhIQCZ5pPUoXl
	kr4ZJjLYKJh9YS7yEYR3TGg4ZyOLZGI4QEU5Dgl3Vx4UMofTEQw8c9oeRDDz4j2c4t4oZQ0PnbW
	P
X-Google-Smtp-Source: AGHT+IG1B8GIfumzhHnj7hWtGm9Ri19lD7phgp+y6ayI6ebhTTQom/sBEbyQQqKIe7quJGIBo5VwAg==
X-Received: by 2002:a05:651c:1548:b0:2ef:268a:a194 with SMTP id 38308e7fff4ca-2f4f48d6dedmr44127171fa.9.1724516265407;
        Sat, 24 Aug 2024 09:17:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c43e7sm3499608a12.70.2024.08.24.09.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 09:17:44 -0700 (PDT)
Message-ID: <717bd06f-3eba-4825-a53f-b2f9aa1c81c8@tuxon.dev>
Date: Sat, 24 Aug 2024 19:17:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] Microchip OTPC driver on SAM9X60 exposing UIDxR
 as additional nvmem device
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240821105943.230281-1-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,

On 21.08.2024 13:59, Alexander Dahl wrote:
> Hei hei,
> 
> on a custom sam9x60 based board we want to access a unique ID of the
> SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
> content of the OTPC Product UID x Register in that case.
> 
> (On different boards with a SAMA5D2 we use the Serial Number x Register
> exposed through the atmel soc driver.  Those registers are not present
> in the SAM9X60 series, but only for SAMA5D2/SAMA5D4 AFAIK.)

Not sure if you are talking about Chip ID, Chip ID extension registers.
These are available also on SAM9X60.

> 
> There is a driver for the OTPC of the SAMA7G5 and after comparing
> register layouts it seems that one is almost identical to the one used
> by SAM9X60.  Currently that driver has no support for the UIDx
> registers, but I suppose it would be the right place to implement it,
> because the registers are within the OTPC register address offsets.
> 
> The patch series starts with fixups for the current driver.  It then
> adds the necessary pieces to DT and driver to work on SAM9X60 in
> general.  Later support for enabling the main RC oscillator is added,
> which is required on SAM9X60 for the OTPC to work.  The last patch adds
> an additional nvmem device for the UIDx registers.
> 
> This v1 of the series was _not_ tested on SAMA7G5, because I don't have
> such a board for testing.  Actually I don't know if the main_rc_osc
> clock is required on SAMA7G5 too, and if yes how to handle that with
> regard to the different clock ids.  If someone could test on SAMA7G5
> and/or help me sorting out the core clock id things, that would be
> highly appreciated.

Please add Nicolas in the loop on the next revisions of this series as this
should also be tested on SAMA7G5. I don't have a SAMA7G5 with OTP memory
populated.

> 
> Also I assume some more devicetree and/or sysfs documentation is
> necessary.  If someone could point me what's exactly required, this
> would be very helpful for me.  You see I expect at least another version
> v2 of the series. ;-)
> 
> Maybe some files having that "sama7g5" should be renamed, because that
> DT binding is used for more SoCs now and deserves a more generic name?

Not needed, adding your compatible there is enough.

> Thinking of these for example:
> 
> - Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> - include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> 
> Are there other SoCs than SAMA7G5 and SAM9X60 using the same OTPC?
> 
> Last question: Should the UID be added to the device entropy pool with
> add_device_randomness() as done in the SAMA5D2 sfr driver?
> 
> I sent an RFC patch on this topic earlier this year, you'll find the
> link below as a reference to the discussion.  The patch itself was
> trivial and not meant for applying as is anyways, so I decided to not
> write a full changelog from RFC to v1.
> 
> Last not least, special thanks to Christian Melki on IRC, who wrote and
> tested parts of this, and was very kind and helpful in discussing the
> topic several times in the past months.
> 
> Christian, if you feel there's credit missing, just point me where to
> add Co-developed-by and I'll happily do that for v2.
> 
> Greets
> Alex
> 
> (series based on v6.11-rc4)
> 
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Link: https://lore.kernel.org/all/20240412140802.1571935-2-ada@thorsis.com/
> 
> Alexander Dahl (12):
>   nvmem: microchip-otpc: Avoid writing a write-only register
>   nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
>   dt-bindings: nvmem: microchip-otpc: Add compatible for SAM9X60
>   nvmem: microchip-otpc: Add SAM9X60 support
>   ARM: dts: microchip: sam9x60: Add OTPC node
>   ARM: dts: microchip: sam9x60_curiosity: Enable OTP Controller
>   nvmem: microchip-otpc: Add missing register definitions
>   nvmem: microchip-otpc: Add warnings for bad OTPC conditions on probe
>   clk: at91: sam9x60: Allow enabling main_rc_osc through DT
>   ARM: dts: microchip: sam9x60: Add clock properties to OTPC
>   nvmem: microchip-otpc: Enable main RC oscillator clock
>   nvmem: microchip-otpc: Expose UID registers as 2nd nvmem device
> 
>  .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
>  .../dts/microchip/at91-sam9x60_curiosity.dts  |  4 +
>  arch/arm/boot/dts/microchip/sam9x60.dtsi      | 10 +++
>  drivers/clk/at91/sam9x60.c                    |  3 +-
>  drivers/nvmem/microchip-otpc.c                | 86 ++++++++++++++++++-
>  include/dt-bindings/clock/at91.h              |  1 +
>  6 files changed, 100 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399

