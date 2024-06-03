Return-Path: <linux-kernel+bounces-199541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B718D8856
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860DD1F23673
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FA1384BF;
	Mon,  3 Jun 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t4Z5PXlT"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84669137924
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437569; cv=none; b=DXMPN+BXq5jrzqKfh174wl1TXjYNPgheZb/7iQHxeD3kcP/Te9aO532OVlM1yp+fnJpjK5UdwxfUZmkF00iu1wpIf8XTQqHeB0kQ0vBtuChgsTV7uJ3FZu5XKvv6SLPFnY4FC/m7gYcvDrkASw3vWSsFTwIQSAUhwjA3Oqbs+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437569; c=relaxed/simple;
	bh=jDmLN/lImiLQzT0dis1BR3L/GQwRSmgfEJ/wjWITAmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA4UjhEd6pXzsO/F0lJvQTFMyhk0gnPH4bTHeucmP7JqjvaSY71XHwoZTZOe7lIEwcnzssshPsfe2DTPkNibBPx4EaCcoQ63XWcQJBc1LcGskUpGIsLC0TkYAfFUb9+oGAPSJbcmQ5iEvS2cP7iL8xdSaXUNCS47DRABI2vx+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=t4Z5PXlT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 931E5412C1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717437565;
	bh=NGNhTqQ1puFiyXl8JAY4ZMmpCE46IAqVnU13ZC7hB8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=t4Z5PXlTqdPGuA2urZ36V7CwiNTr4Oy4UAu5qCTWaNXMy/ACQay/jSrGrWCsrSB8Z
	 iposiVa5tnORkNdVZP6ttLKLKN+fkthsyWXOjGo8MKv7LNzLvep/ZL2PD0Lp2dmpDD
	 +IrAPHsQ7emaOQURxQQT2d1Yq8Fw2mu9DRsYNzTxPGVgPOQGpm8xD7og9S3thkBDYx
	 9dQ321CvvocTFqkTYuymHzSFv63kGtpCNShdETkeyUovFTnelOOV/lIDD6XgwI+Ag8
	 KD8E+abJtSyY/w4gJuPDiL/FUOZjOMOdWh/D/wSX8Y6e/odnFBIwNsrWuuWhzkYMD5
	 s1c+thjFwb+hw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a68eb60d73cso6108666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437564; x=1718042364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGNhTqQ1puFiyXl8JAY4ZMmpCE46IAqVnU13ZC7hB8k=;
        b=rqb3IWSrEvrIvVzSUnF1dhXxoGebOW/W6bJouagdgna2avdtk/QZutdbuh7GOITAx0
         aGeJ21I8nXO7ziu7zenE9s47iCILeu6IqBAWYxGUqWolMfOA+r/T9yH629ZxLxkgok1D
         wQUM2oOYAhzQLpPKKkDetv3jKX3U5Psu/zBJxLmeqrg5lSlRgOjh+p52PY7oFVRfL96r
         AAyL4orljwiyBRe4MW4ZPWqpxluVYVFKCSts1b9dWxK+3+nPUn2H4jdafifpLH69Zg7K
         TzsvaMcASBnEdx5BDuPcqwrrPp1AovD/WhWhFnWKHB6X//H1by6XRHQJGA80ScvdHjmZ
         iwvA==
X-Forwarded-Encrypted: i=1; AJvYcCV7m87I18+b/pyn00eW/COjbmODOIKYvnBQn452+WmVFBswQfwqSbM07Z1AIE/b9wZJX7dQpsidFLMaWzCCfYt3qFnyTCdFLZQoZJKD
X-Gm-Message-State: AOJu0YzqbzsJKwmQz1GbkVRv4epXFMkP/mrVbSBGGjkk1sCXpzcZSfhA
	CMHGy0qLY4iBve1y74TzpMHT4P5VAQ75Yi9/xTZ86F8VJDzvmUiwWFrugxH/xuvsESVosseStEZ
	4v0Q9xwVYEIXEjlZA81IZBvbWqKhlNyAe7aqqVxSUeZtoNe/V3uywKhPPz2GhRdfYfF39z+15Kd
	hE9A==
X-Received: by 2002:a17:906:a985:b0:a59:9c58:763a with SMTP id a640c23a62f3a-a6820902b4bmr606924866b.46.1717437564354;
        Mon, 03 Jun 2024 10:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtG7dbqJYpRx2MknxitYZaS+Oa0hsRvMnbn+9VSSfDEbOmEheu0+SmHp7vtsXcmGpJsSf7CA==
X-Received: by 2002:a17:906:a985:b0:a59:9c58:763a with SMTP id a640c23a62f3a-a6820902b4bmr606924166b.46.1717437563874;
        Mon, 03 Jun 2024 10:59:23 -0700 (PDT)
Received: from ?IPV6:2a00:20:d00b:f75d:4268:6ea6:3e93:63b4? ([2a00:20:d00b:f75d:4268:6ea6:3e93:63b4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68afbaac03sm395655666b.149.2024.06.03.10.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 10:59:23 -0700 (PDT)
Message-ID: <0eb3b03d-f817-4f6d-8a29-abf87c3632f6@canonical.com>
Date: Mon, 3 Jun 2024 19:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: Update flash partition layout
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: devicetree@vger.kernel.org, aou@eecs.berkeley.edu, duwe@suse.de,
 linux-kernel@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 linux-riscv@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 matthias.bgg@kernel.org, kernel@esmil.dk, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <20240603150759.9643-1-matthias.bgg@kernel.org>
 <CAJM55Z82+_RL1Z+DCW+_xgE7ZMmiWdPekCt6qtREPXg1jB+68g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAJM55Z82+_RL1Z+DCW+_xgE7ZMmiWdPekCt6qtREPXg1jB+68g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 18:10, Emil Renner Berthing wrote:
> matthias.bgg@ wrote:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Up to now, the describe flash partition layout has some gaps.
>> Use the whole flash chip by getting rid of the gaps.
>>
>> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Hi Matthias,
> 
> Thanks for the patch.
> 
>>
>> ---
>>
>>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> index 8ff6ea64f0489..37b4c294ffcc5 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> @@ -321,16 +321,13 @@ partitions {
>>   			#size-cells = <1>;
>>
>>   			spl@0 {
>> -				reg = <0x0 0x80000>;
>> +				reg = <0x0 0xf0000>;
> 
> ..this is definitely fine, but..
> 
>>   			};
>>   			uboot-env@f0000 {
>>   				reg = <0xf0000 0x10000>;
>>   			};
>>   			uboot@100000 {
>> -				reg = <0x100000 0x400000>;
>> -			};
>> -			reserved-data@600000 {
>> -				reg = <0x600000 0xa00000>;
>> +				reg = <0x100000 0xf00000>;
> 
> Do we know that all of the VF2 1.2A, VF2 1.3B and Milk-V Mars boards have at
> least 15kB SPI flash chips? In other words were there a reason this previously
> ended at 10kB?
> 
> Also it looks like my Mars board and VF2 1.3B both report discovering a
> "gd25lq128d" chip of 16kB, so why stop at 15kB?

Hello Emil,

0xf00000 (15 MiB) is the value of the size-cell. gd25lq128d has 128 Mbit 
(=16 MiB).

Cf. the examples in 
Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml

The prior partition scheme had a partition 'reserved-data' also ending 
at 16 MiB. We don't change the expected size with the current patch.

Best regards

Heinrich

> 
> /Emil


