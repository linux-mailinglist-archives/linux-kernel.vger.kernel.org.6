Return-Path: <linux-kernel+bounces-312769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4433969AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6860B1F24B59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D91B12F2;
	Tue,  3 Sep 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBkyVXIk"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A51B12CD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360923; cv=none; b=SUx/u297oKOcb9nrMso9gJwQ5JUyuPJXXtBuBOJTe8Obu5ysoqS9bprPNp4HU/zas15gHK1F+8PytvSWDl2b+JFmCecwK+6aCFa34JvbzKQY44lCFnaY+5ZzGH3cztUg+bnspTXjr5Vzes2WXqAydhxo2sbYNCS4VP6LXAf4DXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360923; c=relaxed/simple;
	bh=0wNqV2ftrBb/yvgxhpVC0B/1IuajgOBIg6LCvNxgrLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRtQfi1Z9bmRrsTLZusR6z6JzeCgj1tFb/dT+TkM6z8yYVhUenIR3ZsGLCr3pI9RDsveHpHGmozE3c1gQctO/Cf/EuRSzyiK9yXTTf0Ha8eLo5/lCmlvzmCB5/wVI/WR9EmWzeKYuA88lznicnQDlpsoDH30dxx4WslHeMLet84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBkyVXIk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso5626685a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725360920; x=1725965720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LXTxwAYU83TR52hgXwDwk5YF00xnfdgeG8lvMn1Uc4=;
        b=hBkyVXIkh8+1Df8lQ5TeXN/KEFUImWPcw1SsWg+pSnIEh5p3eEffMkxjd5hi21UKDD
         SCvwGTX16HC9Ffy7PHAymRnNwi1UfepoDfVrykva3ZWCGAyPbcoqlCXoErIebpj9z8mm
         dU/zZ364vUZjRfLJqE+Kh/lgLlKfyRqO7ow9JmHu6T6TVTvEWiFDG3PgEokDsPkNsZkU
         Mg+KNdz6PRygj1Vrbv9aTY6FC59mkIw2xkmcIuKigUMXGwwlSixmv762qxRTZDX7ZQZJ
         P9aD6Vk4e9u/M5X0phM/cBxuDv9WwocmcLCGg2mpCnSkbFO4n97sy14vk6FTILDlktVA
         NTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725360920; x=1725965720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LXTxwAYU83TR52hgXwDwk5YF00xnfdgeG8lvMn1Uc4=;
        b=QSkbSNIXE/1zbT4PLcyW90+ifdHq7AmUhOnKAexZQw9Ew36uOcfQoLRZYRkuCmPCNs
         +yILjGDm8DLmgO41dQOdku8fSjq/atP8Ld6WqWieAOswpxQqZj75MKz+np+oG5QbiBeW
         PJVuQUvb+rka7DCVuct5YgdjTviMgdB/pCkvuZjYqCw0pfp2M2CAeFlaX+3FZkPt0Vxp
         ZAl8RkUFQpJ8M5xxfgRhd0KWx1E3Jj8kWLOH/zy9fTGxRr8pbYFjQX8pqQCWW3jPccUE
         igfRH8BFRS50SFZh5cio9JxA6+QOP9U6eebTsTXUaSN8Z2gqSuA7G/TB9PyQlyFFfMJW
         pyjw==
X-Gm-Message-State: AOJu0YwsctC6eKCnevz2J7o9cGpXhRBmw2RkXoQxPQzD+fOWJjTL2yHz
	CVsPl054A3+ZVDHDOMAz5njT6ImEEWW0ceWkNkFBbRQ8i2vdwmT4RGEt1wObTSfCDkuZVPeOpc9
	1
X-Google-Smtp-Source: AGHT+IFfrsOdNOvTywWpNdDWwAxzOFdZykoEm+DJ2XCn3hRcHd0PrSnEPtDL8DxfK1M1rxKcKpNCkg==
X-Received: by 2002:a05:6402:5c8:b0:5c2:5254:cdc4 with SMTP id 4fb4d7f45d1cf-5c25254cf8dmr6542396a12.17.1725360920204;
        Tue, 03 Sep 2024 03:55:20 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfe84sm6267068a12.71.2024.09.03.03.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:55:19 -0700 (PDT)
Message-ID: <23d78063-1ad9-40c3-8e91-e9fcabc53df1@linaro.org>
Date: Tue, 3 Sep 2024 11:55:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] nvmem: layouts: add U-Boot env layout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-5-srinivas.kandagatla@linaro.org>
 <2024090308-smasher-craftwork-0db5@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2024090308-smasher-craftwork-0db5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/09/2024 11:12, Greg KH wrote:
> On Mon, Sep 02, 2024 at 03:29:47PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot environment variables are stored in a specific format. Actual
>> data can be placed in various storage sources (MTD, UBI volume, EEPROM,
>> NVRAM, etc.).
>>
>> Move all generic (NVMEM device independent) code from NVMEM device
>> driver to an NVMEM layout driver. Then add a simple NVMEM layout code on
>> top of it.
>>
>> This allows using NVMEM layout for parsing U-Boot env data stored in any
>> kind of NVMEM device.
>>
>> The old NVMEM glue driver stays in place for handling bindings in the
>> MTD context. To avoid code duplication it uses exported layout parsing
>> function. Please note that handling MTD & NVMEM layout bindings may be
>> refactored in the future.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   MAINTAINERS                        |   1 +
>>   drivers/nvmem/Kconfig              |   3 +-
>>   drivers/nvmem/layouts/Kconfig      |  11 ++
>>   drivers/nvmem/layouts/Makefile     |   1 +
>>   drivers/nvmem/layouts/u-boot-env.c | 211 +++++++++++++++++++++++++++++
>>   drivers/nvmem/layouts/u-boot-env.h |  15 ++
>>   drivers/nvmem/u-boot-env.c         | 165 +---------------------
>>   7 files changed, 242 insertions(+), 165 deletions(-)
>>   create mode 100644 drivers/nvmem/layouts/u-boot-env.c
>>   create mode 100644 drivers/nvmem/layouts/u-boot-env.h
> 
> This patch doesn't apply to my tree :(
> 
> Also, if you generate patches with 'git format-patch -M' you can see
> when files move easier (if that's what happened here, hard to tell..)
> 

Let me rebase this again on top of char-misc and resend it.

It might be the case that this was dependent on some of the fixes.

--srini
> thanks,
> 
> greg k-h

