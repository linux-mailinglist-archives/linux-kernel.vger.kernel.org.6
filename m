Return-Path: <linux-kernel+bounces-545534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96633A4EE43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BA47A4049
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20924C085;
	Tue,  4 Mar 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdiOMon1"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FA2E3377;
	Tue,  4 Mar 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119775; cv=none; b=N9ZANTFnt+HGoEwSvYn+gtRYT2pW7HQO1ziPeqj8CmvnOtEAiYCtU0FEaMCc+JDw8mnMUA9ICVC8KbyenD9Q+/KK8hNj1YLOtuTO4f40Kz+wA5chcJA/+eGEMzUuWBxS/M+KxqUvn5+yjEsd70GLcT3kfW9hEfsP9lxG4uEbCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119775; c=relaxed/simple;
	bh=ZvZj2BVCDb3Ki+Kicw13DbZrIOHwNXmLmXf15SHHh7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVrYOQAWJ/kfrs4MCpKE7nADYOHbz0SdXx7/K+/AzDHAMLD1DVgk0g++hakM6R/OtE+BG6F4lOvvuphABkuqLnn54bdp+Qxiob/FMt60vReQFh0OxscmmN+MrMjSup5ixdBcT+K9aWzP54exrTqxdrgc2FLwYskHjq4Ev2c0lW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdiOMon1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so10670785a12.0;
        Tue, 04 Mar 2025 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741119772; x=1741724572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZnyTf8R8WIAEBRe+U1MPXmR1flxgLlFr/IMunXCkWs=;
        b=GdiOMon1U9pSSfMWdjsOLDgzPyRyRKBPoLaNKQexwozRsUlk+K95sAJnMgBQBRPAod
         ocY4Eib/EB32XNKCAYzzS3CspoiR+nxDgGDOCVuz5VP6pQb35T7MwHECIxg68OzddxHw
         AaQq4ydCG8xHK3rMqjZw5CtoHoRkyfK/62PJBAMgBrqsrd9ZbeGidbLx+8g1nCatI8yN
         OHCKfkzD3WBGZRKo/TQ8MEOpvZhWP/u/kROQGHoSzzBudzqH3cnmHjgkx86RBYdpFsPN
         WeBjhzPHF/z5h8I2sRuG6GUTaALSec2+d7Hxu9M8RQ9txatOfaeXBiSJeIZbNmrVNxnl
         qVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119772; x=1741724572;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZnyTf8R8WIAEBRe+U1MPXmR1flxgLlFr/IMunXCkWs=;
        b=QA/KAgNdRY+zh6Ad4Ci0J5SG6FUowU149NXhG36NsB/6seJ4NJY/vQdoudYKxwLHNG
         tjRcmjFqf25LKcjSiZUMU6aRXnRfi/jYwHVjFT3a7J/F1+7M0L707xHWEDwuNZWuIb39
         /bAuWnpA4q5TJQjRHEiN45/cm6NyKKLZz3zZo5RKgFTsbOCuS1djegilX71w36l4ZxL3
         IF66IhK7eRMN10NcOcAGsLH3TzJIXl5O/D29a9iPJmeNJLmaSobi6ERxU9thvs4qZq49
         qu743iVaHbt/4Q7PQ48dahghBlczNcrYTXd6JR5Ll7qrMuQukjATLdMhlFnNDL9881Gp
         tCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL7eGJLCPnX2HDplp0sWeTc6Axt7zEO6/BiwRQDREHEt8WC/cGtOohkHo0s377TkVvBxt7LYlh9LIq@vger.kernel.org, AJvYcCVgsPdKHo7fhH9/t1F3Uf4HEOtp/Lm/pFAFDCsOcaBMk/Zx7wyv+bEtrtztrwHb/p9JgVWQgcjrixnk@vger.kernel.org, AJvYcCXH4vOTF/uUy3PJ4LWeHK4fFPywMyMoAXop4BE0TT1ai9jzUYUaA9SDE8VVwkqxZAOmZ93lCtz74nVQ//e3@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQTu2vstt1scPN+VbwnEyE3zGwKFXNApR8fiZtoRvH6+7mqW6
	SV+dv5JaBnOxeY6FvAD+3G4aF2YADutponGtam8YWKBs3nqTbTrM
X-Gm-Gg: ASbGncuzkHXRFdcs9piL5sdOa3LqzjW69wjJSNFpk1hwnDRgKTWUI4P1kwyb514y63l
	KObXBMsazOkPVYjQFxQORxFv/454oK5vx46v/+21orFQd2OpnzHttis5IvEnJslaRinsDkYYAjL
	lx4/Rc4YIJEqBnkvAY4CE0TQ8ioSGeG5SU4fzrrXHRLU71Hz/WsH0R0ZXcDEt1HWiW8kPR2MB7d
	EpfAvGNqtIKPyfzfbvbUu5fdwvyDKoZhAMDwMVm/Bt/TSySL+1JzcgjiAGH2q/Jcq3A87Ji2eFM
	4A7ZIRpB/wqWNmp/zLjJUmsQzI98VSKYHGVuX8ZxZRCUOklDTj8teXp4LUi3yfg4mT3wX02fLpg
	cvhRuiZd1R19j2+GMdiI=
X-Google-Smtp-Source: AGHT+IExdUuc+AfkdfGXERNmvw1J52g0YeELdssSNoIutPuyYqe/wIiIiVbJIIHsYneCx5vjT9I/YA==
X-Received: by 2002:a17:907:948e:b0:ac1:e07b:63ca with SMTP id a640c23a62f3a-ac20dafc168mr37481266b.22.1741119772127;
        Tue, 04 Mar 2025 12:22:52 -0800 (PST)
Received: from [192.168.50.244] (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7fb2eb4asm373090666b.55.2025.03.04.12.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:22:51 -0800 (PST)
Message-ID: <6198559c-775f-4c83-a0e3-ea9557674ed8@gmail.com>
Date: Tue, 4 Mar 2025 21:22:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx
 bus clocks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
 <20250303-kona-bus-clock-v2-2-a363c6a6b798@gmail.com>
 <20250304-fat-nebulous-meerkat-008f04@krzk-bin>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250304-fat-nebulous-meerkat-008f04@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.03.2025 08:35, Krzysztof Kozlowski wrote:
> On Mon, Mar 03, 2025 at 09:27:50PM +0100, Artur Weber wrote:
>>     - if:
>>         properties:
>>           compatible:
>> diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
>> index d74ca42112e79746c513f6861a89628ee03f0f79..15449f998eb7a5a191fd847b689cfbe60b27c541 100644
>> --- a/include/dt-bindings/clock/bcm281xx.h
>> +++ b/include/dt-bindings/clock/bcm281xx.h
>> @@ -34,7 +34,9 @@
>>   #define BCM281XX_AON_CCU_HUB_TIMER		0
>>   #define BCM281XX_AON_CCU_PMU_BSC		1
>>   #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
>> -#define BCM281XX_AON_CCU_CLOCK_COUNT		3
> 
> You cannot change defines, it is an ABI. Unless it is not an ABI... so
> just drop all these counts in separate patch, just like we were doing
> for other platforms.

The clock count defines are not used in device trees, only in the 
driver. Most likely clock count defines were included since the driver
already uses clock ID defines from the DT binding header.

I'll drop the clock count defines in the next version, and see what I
can do to adapt the clock driver.

Best regards
Artur

