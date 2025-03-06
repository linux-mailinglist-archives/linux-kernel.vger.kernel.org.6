Return-Path: <linux-kernel+bounces-549142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA60A54DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C51D1896B61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06D16F0E8;
	Thu,  6 Mar 2025 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kARYBte8"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E4DF71
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272126; cv=none; b=N43TETzBS/b3EG61jDhliAxPXmyvwlBzb5FhirG8KFeYFPIRTpW9BZlGDOVAlmr90OBa2mbdQOfWDoRIgqmTPyS8HuMtcBuQu8xv6ECze3RbWsj7y59uD45XFBdxZsTqy4TcGjoavMksmgst2o8pFsHoLWdey7ORVkzyMHuPOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272126; c=relaxed/simple;
	bh=KRUy/oNwOb2/xHP/CNXIPpF2zWth57GB5LAkf0uAKlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRmG6LZ7sjcuywcVLX5ncow0it2TZJ9X5sLkFpHo9OAHgu0AgmEgNKnnw72RLc9kiDFKGG2O/cNvcnQdqIBAu/0wPecj17kfuLlaoAF14R6Q34fpvjl8hcgfdTnxQ4bjpgIkhBkLEDfalR6qHxoiE8alK1P41gQwF70fwgTSgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kARYBte8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so1141195a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741272123; x=1741876923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzC8U5Vx4XxENcWpcmaqiUt/gKOGnuEvw78Wov3AGl0=;
        b=kARYBte8cuOehrOtJB340gHYpcJ+mGjQE7V23o28fR9xBh83Hrt9Qpihs94ozyceVx
         c2ojG/5cvdyM4G4PzDBjS34ym3FXLsLFZVmODpZU/sXhc8wPZTA8E0gBbblq3g6h/OFa
         uWeU922UaI2khU6fIjBKGe1Tv8/PYL2v924sSuFa5l5OpOQXcjz96grUDwTZkuExiUB9
         UZfs0xH/9Jslc4Tpd1GGVE/VTjjbgEGMOiumdKhP3uAT8kleQrqmRfShNr8LSV8VsZCS
         u0J1LTrGstn6ebCJ1/9MlikdJ/M3+2kU1KL46s+Nxv7SqnbwtCBaT//8izztYg1fpSO7
         Yhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272123; x=1741876923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzC8U5Vx4XxENcWpcmaqiUt/gKOGnuEvw78Wov3AGl0=;
        b=gOq5Oq9f208wxnzOiZKVOyUn+bRpFGAPY238J3XjiZuu4AoSC8CG1/uqibKB051Gwl
         7XYZNnVzBmqDmHuW1zYXcO8rEvBo4u/CQHb3b27plVxzPmdQXd6xFJRvGV2Nk6h54GM9
         UAfjFS14r8x01iFxeTw/bUp7/3Ld4M+j0OQEnh3yhOCYAbsiugm005+K2ZgAl8O7N1FV
         zWkGb04FhmuLPIlQURW2OKBwWqpYncDUtldgpRyNU+PeX2NPtOtsQr2gEkRN68f4Nl8x
         cz2+9nRr0B8nfe7QsDRZpHoQ30t6O4KFDrpIF1ag8Qkyh7P0CTHVrI9L23DV/sopSt0/
         6JuA==
X-Forwarded-Encrypted: i=1; AJvYcCXsXJNkqNawlAGO5g7Nw+Vh/X4cKYWOBsdFZH4IgAp+4wuwWDkIFw1PeKrdRj0FEh+SH3uB8o2S9kNStlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhK6goNrERHl/Ca5IoMCEriQoDlpgh90E5mY2pt40CXwSQdga
	nZvVFDmqYCfdwI+x3toGRBeedgjJT1xWk/BP9K0oUL/xVvxN2wVeIMwVozP5aNc=
X-Gm-Gg: ASbGncvpVZwcXQQJgX31EUsIBpdXn77kxWG5nCxnePoiXGrH0g2RUZNpxnPoINB3KsR
	JeOCb8U74G8Z+4jSB+HL0lXf5isWDsVaVkxqsEpNK3DH2BIsWOHFGopRajCGHfV5wqoLhGjBLhH
	ed8ibWySresu4aZhq59xdkib2fTsKMAdGmtYHiCz4hBATZdHNLGnHKVceRb1bqvbZP3kwJUVuod
	+PYNfjRkgsgFlkFT+Whgm6uVxcPevsBRZ7JjOLFmhiWQ2jOvJsZYSOeYMBV9CXQaTi3258+IWi7
	1wFxIy6A6VPuT40tmVZFsbGdHfxvJRilwo/Azn4ArT3Hb4bdU/Pg6g==
X-Google-Smtp-Source: AGHT+IHfceypMXflxij/F6RMQ9oZmVEMDniJh1Ac33s6vhrs2mCfTc4dmPRbZTDckaO3mSjcRB0VJQ==
X-Received: by 2002:a17:907:d92:b0:abf:4bde:51b1 with SMTP id a640c23a62f3a-ac20d9e8f1cmr619555866b.21.1741272122939;
        Thu, 06 Mar 2025 06:42:02 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2390fe76csm106804366b.0.2025.03.06.06.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:42:02 -0800 (PST)
Message-ID: <d674f1bc-b596-46d5-b56d-1e2fb509c684@linaro.org>
Date: Thu, 6 Mar 2025 14:42:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>
References: <20250211063028.382169-1-linchengming884@gmail.com>
 <20250211063028.382169-2-linchengming884@gmail.com>
 <e5458a0e-528f-44ec-a0f0-543472ad3b85@linaro.org>
 <bb9f8a80-4662-4ab1-b9ad-6899977c3827@linaro.org>
 <CAAyq3SamyhtCkd47939dKWCZN3ejaDvM6EJzwizWVqhNW=27bA@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAAyq3SamyhtCkd47939dKWCZN3ejaDvM6EJzwizWVqhNW=27bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/6/25 11:39 AM, Cheng Ming Lin wrote:
> Hi Tudor,
> 
> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2025年3月6日 週四 下午7:01寫道：
>>
>>
>>
>> On 2/11/25 7:20 AM, Tudor Ambarus wrote:
>>> On 2/11/25 6:30 AM, Cheng Ming Lin wrote:
>>>>              .fixup_flags = SPI_NOR_4B_OPCODES,
>>>> +            .fixups = &macronix_qpp4b_fixups,
>>> For your next patch that'll drop the redundant flash info fields, you
>>> can drop SPI_NOR_4B_OPCODES as well if these flashes define the 4bait
>>> sfdp table.
>>
>> Any plan in doing this, please?
> 
> Sorry for the late reply.
> 
> This matter is currently in progress. Since collecting all the chips
> will take some more time, the project has been delayed. Once I
> have all the chips, I will start the verification process immediately.
> Thanks for the reminder.
> 

Thanks, Cheng. Switching them one by one is fine too.

