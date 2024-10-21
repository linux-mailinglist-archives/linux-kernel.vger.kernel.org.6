Return-Path: <linux-kernel+bounces-374477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA389A6ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07551F2388A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A861F9ED3;
	Mon, 21 Oct 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WwlovjZ6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845F1F943A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518262; cv=none; b=Bm74ZzHdpdkZkDfloWxT8G/crCes3QS3cQdHev2IZpmh3Mfo/ladqwnxAb7ZYPWuit+oZYY367CrBJejAjnbrvBc1U82auFr7m+kLZR7eUSTyfn0dsoGEnbeuBc0MN+q14gBXzgMi7sl4chcIpAHffXI3heIWujUo6plSs82P94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518262; c=relaxed/simple;
	bh=BAFBA3PSylWKEW63BdR/LWiXoxleLdw7dvkAgNGemzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swUNVCySHJ/8EgO3GE3Me7CDybcWmf5ihC2QtgAhHtuu9t5D+CZhYQHu0F7brppmt7a0y6EbgVKisoNTDavhj25rXFqS8il3Ayqe6SZDlwM6Lfcp7pmiCF+FanBMD9fWS8NPv+YDovmbrsGDicjQhn+2PpyYwMv2uL5SPW/xmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WwlovjZ6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso42231975ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729518260; x=1730123060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEnajADAbGhm3M1pNyKurdElPnt+aWsHL33PQ0Q7Gvs=;
        b=WwlovjZ6pDY2FQvWAJuusjt6o9AjBfDJPIS7b3ik8JP3zfeGy8Fu5m6oQY2qAatr/K
         Je+uQXkSs/s/gQqSZmYJluYzoOlGu24pBZbaWIp7LFqzB8MxLvEeir/ZfSapN9ZCVTuW
         G7CTjlRYkWOYfmf/4hOWaKp2zFjYfp+s8R/lfhVsOlsdjlwpgzisLdmZ84TfBg3vhXUv
         IvgZhOVMdPh8FHfXWbpvigZcsxEiEwWkJib9uWrRjKV0toFMfUU8BU481+amUuO+huze
         QTmGQhsER2tLjx4F5ug11hB7Cqx2qvMlEoJ8TYDIrWgc/bVGIl5DB2PKXWGf5UFLROfm
         JcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518260; x=1730123060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEnajADAbGhm3M1pNyKurdElPnt+aWsHL33PQ0Q7Gvs=;
        b=Rg38lAuPcfAhG4fgia9on4gE9D96KTWKRJaKYqLnc26C9wU8pKUTWjW13aH5JLCR94
         2x2jdY6jSVbf4Zzso4siafupX1b3rcMJE6VdOgNF/uJQcOdQO/A5G9DPckTALy5ZR7Xi
         TubrqxT52u2/4B620DcGWeJW9lJZ1yAmMVlWTCP+npfrRLFGoj2ukWvmPNwIaxosj005
         75sgM1V9M3RJem+4Zlf+w1cCRRi8CkLYfA4JM7+edwB0Kz9it4bgk6HRE+E65ApsI+iK
         gKMATHNndpF79/K+6VUidF+OlIfNV65mSlIi5/CRSJjr09tTXZEvprR2v/649/Vw2EUt
         iY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOb8HxXZ+vsMGlQoJa0YYZiUUCgQE/trDv9Tt+uaoQPxtD9qI8XmgaRxFvzqS9SuWsSfR/iGOVg3Fu3yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZVV2wjlL3WP7vhpFSDWVdiZXsxXvP7Tc8GUy3hAl4Gsb+bDT
	lGTYZOLrrVn135Prcmw7Ku7jOpcba/oMY4AqwixJKZkOvbjmbBFYPSUJMbyleJk=
X-Google-Smtp-Source: AGHT+IHN/ehUoWz4nWNTcpRpWVKsXcIc7vWF74OZtujCoQlKZC39nGhEfqrrlaKVy+NS5GzpK/RF+Q==
X-Received: by 2002:a17:903:1d1:b0:20c:e262:2580 with SMTP id d9443c01a7336-20e5a8fb25amr172757925ad.44.1729518260070;
        Mon, 21 Oct 2024 06:44:20 -0700 (PDT)
Received: from [10.211.55.3] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef1a953sm26029185ad.112.2024.10.21.06.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 06:44:19 -0700 (PDT)
Message-ID: <2b449955-6596-4c9a-9799-f15d186e260f@riscstar.com>
Date: Mon, 21 Oct 2024 08:44:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Michael Zhu <michael.zhu@starfivetech.com>,
 Drew Fustini <drew@beagleboard.org>, Alexandru Stan <ams@frame.work>,
 Daniel Schaefer <dhs@frame.work>, Sandie Cao <sandie.cao@deepcomputing.io>,
 Yuning Liang <yuning.liang@deepcomputing.io>,
 Huiming Qiu <huiming.qiu@deepcomputing.io>, linux@frame.work,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241020134959.519462-1-guodong@riscstar.com>
 <20241020134959.519462-4-guodong@riscstar.com>
 <ae5gels34ozgzrcrwz53wj22hoy5cq3crn3dmkhitxlffmnavt@6lbmrcpjmqyd>
 <20241021-unroll-empower-3ab903615d6d@spud>
 <c048d270-7a07-4807-b816-0f4e0aeb67f7@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <c048d270-7a07-4807-b816-0f4e0aeb67f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 7:47 AM, Krzysztof Kozlowski wrote:
> On 21/10/2024 13:16, Conor Dooley wrote:
>> On Mon, Oct 21, 2024 at 09:17:59AM +0200, Krzysztof Kozlowski wrote:
>>> On Sun, Oct 20, 2024 at 09:49:59PM +0800, Guodong Xu wrote:
>>>> From: Sandie Cao <sandie.cao@deepcomputing.io>
>>>> +&camss {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&csi2rx {
>>>> +	status = "disabled";
>>>> +};
>>
>> You can drop these two, I marked them disabled in the common file
>> earlier this week.
>> 1
>>>> +
>>>> +&gmac0 {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&i2c0 {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&pwm {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&pwmdac {
>>>> +	status = "disabled";
>>>> +};
>>>> +
>>>> +&spi0 {
>>>> +	status = "disabled";
>>>
>>> If your board has to disable all these, then they should not have been
>>> enabled in DTSI in the first place. Only blocks present and working in
>>> the SoC (without amny external needs) should be enabled.
>>>
>>> I suggest to fix that aspect first.
>>
>> Eh, I don't think I agree. Having 5 disables here is a lesser evil than
>> reproducing 90% of jh7110-common.dtsi or shunting a bunch of stuff
>> around. Emil?
> 
> Why reproducing 90%? Only enable would be here, no? Or you want to say
> the common DTSI has things which do not exist?

For what it's worth, I agree with Krzysztof.  In the (long) cover
page we pointed this out, and offered to do it in a followup patch.
But if requested we can do it now.

So in v6, a new patch would be inserted before the other three,
and it would:
- Remove the status = "okay" lines for those nodes that are not enabled
   in this new platform, in "jh7110-common.dtsi"
- Add nodes where appropriate in:
     jh7110-milkv-mars.dts
     jh7110-pine64-star64.dts
     jh7110-starfive-visionfive-2.dtsi
   They'll look like this, to enable the ones disabled above, e.g.:
     &gmac0 {
         status = "okay";
     };

     &i2c0 {
         status = "okay";
     };

You guys should come to agreement, but I do think what Krzysztof says
is the right approach.  And unless convinced otherwise, this will be
what shows up in the next version of this series.

					-Alex

> Best regards,
> Krzysztof
> 


