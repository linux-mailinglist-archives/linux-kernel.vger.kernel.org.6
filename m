Return-Path: <linux-kernel+bounces-177538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950B18C4061
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84291C2237C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29214F113;
	Mon, 13 May 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wo780eQs"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768114EC5E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601875; cv=none; b=gtQCAEMnrUoRJy7YDAK+44zZ9AI0Tq4ZInx6zWNdN+mUmk5PnOTPjBZg3fvoVuX02utH2Lh9lLCWV1kygJ4TNw93nbrZTr4Sb0trt0zUDO0hl2i4g3PIHw/qd7/HgDQBHC0M0POlqSOnnK8hQEGllnA930XRNUgcu/uiYZIlSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601875; c=relaxed/simple;
	bh=5j40C07Qf/yIsZFYFIIXmoDKx9psThMJypiQuPwNDBE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lyVVsWGWtoQqoNEIKLF6zVBKkCf6cbo9W7SeodeG3N7A2Q/UHYQ9xU5pJ0UDZigop6nqlDLwgqlAaZs+3wEH2MFmQqzv40uwBlMEEbPgIYewjuZs+lC1OUBArG6lGEc7le/ylGvXySqn/2AUmVdYRpYNpjcKOjlSBg44iHOLXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wo780eQs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so26417105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715601872; x=1716206672; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=evr7Nj7xKQ7Cd3Ztm3Cf+ORmYJrKhwgikDv0J0g06qQ=;
        b=wo780eQs09LomHHrPqf+wef963s6432F1cAI0SJZBFsHMHKXoqCwsoePDkU9kP8vqm
         y3gnFhtJOb6qio3NvsjH69VzZr8Kqo3clE+tU2dLt7AurQcLid2aZ4SKDD1d1tA+u53h
         SPcIFYpZhDhkxABxXdTEX9muLVb/Idchq4prQq71+oSY3x0FvBBbxeqz29alGYrwdvQA
         sqvSS4bk6B9imWs/+lo6pyknbtsSE9VD0RCRVBj1VL7vpWs+f/u9YUo7q4IARG0DUTwk
         WqQr+fjFa/LwkwXpS7TYzRKWzl7f3921B63XIDQ1/zQCBqqjRdKVdpyKucGoVNAeL1NQ
         iijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601872; x=1716206672;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evr7Nj7xKQ7Cd3Ztm3Cf+ORmYJrKhwgikDv0J0g06qQ=;
        b=kYNyrm9N/O5pBvwf3pTIDyjxau5hhkvbDuaIiqyN4LZjgdmVrnSozdav2JQQnQpRhb
         PBogu5zB9hS1L7K7FMET4RcK23G9aCZEqHTet3IHQTbm5HJktSpG2Obfn4M6g1WCap0e
         6fJPoKa0onTAoUOZA0uC/2cXGFuxECnvSHXgGsG2V1Cpr2KyVFGrfYmpKO3/LZCSnwzi
         o1DkBJhsodpO8/T3DtAlwlkCbGaTulQ3UWgXek+hYxwfCvKPHxZtDnGOWE3HSY29CQPM
         mZh2bqaoIFF5CGmPUeQnghW3dBCPWoWYtEL3juInOy6ff6zXjMEXo5FwV6+C9dh4EYYk
         2hDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+N4t+acdVNQbN5cfQnlpFPuishhkGq+Ztp32bJ+3MEVBBCbd+mU/Z3BrCPkye2ZATS/JLP9iJnyCkkt/vABiK3WLgAX/PRyt+gR+e
X-Gm-Message-State: AOJu0Yx0sEbtuUpyoE33/uIYqNVuA5f5P13Z2ktwsJc3xFIzJq5mxie9
	UiA4vBABUGqhui5ZPgKWY01ci6l31RJXdUmsSBce1cd9K04PJQUb/UMcG8re7VM=
X-Google-Smtp-Source: AGHT+IGnkiii1p31wpEBxYvlhM/aMqmsmiEtQ3NQ+1Qn6f87Nt4y/G9/2KcL8KQaX8/8bf+QvAuVbg==
X-Received: by 2002:a05:600c:4fcf:b0:420:1585:7a99 with SMTP id 5b1f17b1804b1-42015857b80mr27774355e9.38.1715601871464;
        Mon, 13 May 2024 05:04:31 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5b77:3e5a:a808:339a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013c5fa61sm49472435e9.40.2024.05.13.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:04:31 -0700 (PDT)
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-5-ddrokosov@salutedevices.com>
 <20240511-courier-afflicted-e351af5cded2@spud>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Conor Dooley <conor@kernel.org>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, neil.armstrong@linaro.org,
 jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 khilman@baylibre.com, martin.blumenstingl@googlemail.com,
 jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: meson: a1: peripherals:
 support sys_pll_div16 input
Date: Mon, 13 May 2024 14:02:21 +0200
In-reply-to: <20240511-courier-afflicted-e351af5cded2@spud>
Message-ID: <1jo799zzn5.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Sat 11 May 2024 at 14:03, Conor Dooley <conor@kernel.org> wrote:

> [[PGP Signed Part:Undecided]]
> On Fri, May 10, 2024 at 12:08:56PM +0300, Dmitry Rokosov wrote:
>> The 'sys_pll_div16' input clock is used as one of the sources for the
>> GEN clock.
>> 
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>
> Provided that this new clock is optional in the driver,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

The way CCF works, it is not going to crash if DT does not have this.
It will be viewed as non-connected input, in a way

>
> Cheers,
> Conor.
>
>> ---
>>  .../bindings/clock/amlogic,a1-peripherals-clkc.yaml        | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
>> index 6d84cee1bd75..11862746ba44 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
>> @@ -30,6 +30,7 @@ properties:
>>        - description: input fixed pll div7
>>        - description: input hifi pll
>>        - description: input oscillator (usually at 24MHz)
>> +      - description: input sys pll div16
>>  
>>    clock-names:
>>      items:
>> @@ -39,6 +40,7 @@ properties:
>>        - const: fclk_div7
>>        - const: hifi_pll
>>        - const: xtal
>> +      - const: sys_pll_div16
>>  
>>  required:
>>    - compatible
>> @@ -65,9 +67,10 @@ examples:
>>                       <&clkc_pll CLKID_FCLK_DIV5>,
>>                       <&clkc_pll CLKID_FCLK_DIV7>,
>>                       <&clkc_pll CLKID_HIFI_PLL>,
>> -                     <&xtal>;
>> +                     <&xtal>,
>> +                     <&clkc_pll CLKID_SYS_PLL_DIV16>;
>>              clock-names = "fclk_div2", "fclk_div3",
>>                            "fclk_div5", "fclk_div7",
>> -                          "hifi_pll", "xtal";
>> +                          "hifi_pll", "xtal", "sys_pll_div16";
>>          };
>>      };
>> -- 
>> 2.43.0
>> 
>> 
>
> [[End of PGP Signed Part]]


-- 
Jerome

