Return-Path: <linux-kernel+bounces-553931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78605A590D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345873AB24A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340DD22540A;
	Mon, 10 Mar 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSgaQ4cf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5A288A5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601653; cv=none; b=IzMBOj6HVp/eodHvYl5pmXnrpuqJDFXzcpDcGWd1qe9OsOGNt4WEWRZDjTWAvOT0alwEqRzfhgICXrsTOXLCOwMgsGZh5T4RoXpUMykXqRGwsabqyJsk9QbF7Kxcb2R4IXrYy3AMvEXMPaCzUFZ9LGBFbw1BR6kzPYcR6LH6ggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601653; c=relaxed/simple;
	bh=qrhY1Bxhk9wF+bTuRi9kE+Jcd+57pGlbPZGR1j8y7ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhsL8bJ1Zp0Otwb6lqdLXAxZO65llaLtqSafAFaEkzt0QmkN7IobGWrhycZ56YhsG3/oMfx0kWGjWUA0e6It+opSA30OJOlRIrBJL5mtldP4ReI4rj4E+xItCQOPbpHykQmanBKoANSOFppXYz5Yqk4arXhiOvnfTdjcoNBop5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSgaQ4cf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so22999235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741601649; x=1742206449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mb4ZEjkPxTZLwNM/RV2EyY1xOkJQUnNNIIHGYtjQ6vA=;
        b=KSgaQ4cfqu560dgTpKRH7f18NRb/hxqlOVwHREc3haj7tXsq1WWisb4HEXLr2bpc8z
         7n1tGNp1fCiJI3aSMs4BLu3gaOk/CKYBybhSPGDATBCEnZ9kAUoavGK7QzXp31OvRpOD
         b7cmzoqWGdIqTaco8km5iNxg13yxr2Jd9VCYF4r6kwaT5HlbIO7G/h8KtY77CdojDvWh
         cW0XPTrHFH9+TiMbv4eRztkjeSnAUAfzFpN4TK/6XUvMC6NfSnlr1Bfl98QzCkQ9Z/A1
         NkQxoV7HXWhqdSeIe55Oyp+mbrmjbWdXVWDSkQn9u7c52TTctZZm+gfyeUL8cNdK86Rq
         z5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741601649; x=1742206449;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb4ZEjkPxTZLwNM/RV2EyY1xOkJQUnNNIIHGYtjQ6vA=;
        b=XokdYUCLDgkGbVZZN6M2XpbAFRRvwJ3Ul820mWsKHl09CnHGDge4RlHMuoT2FQssEp
         FHPAeZgSV4YNDeDuACLzBnrODXULkHC4Ub2+WKbOPBzlx7hEh5Uoi9yXQevvuySDk3So
         jqmaF3it2n1e9UDyKj9M9poAVCUQGkszFaDVLqGHqWHsCYvmv4DyOPx3CRy0DM4XRbSn
         8+qsBPcGKPsEa3/e0oI4nonV7A2oogOWRFKHGARJu7bkVoYgWYv/YPBlRcCZGfqf/xsG
         ZnPyI93rs3vBAHyV90I1He2hAI7RB3KjZHoyH3JHkbpVXFgtNRtIubqxJ+f+j+OcQ1iW
         Y8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX5CXzGKxHKlHr8Ri+T0J0YFllbPT6vnqTh6zteb4F0iH61Mvhxw+yX/UGpeCFQyZ4LtMHajKBaoo+WziA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBgtf/xaSNAFE6PtaNXV8Zb9P7ojIpzl93Dsx7pWbumzvlinj
	OZcq0e/W3dpZMCCSky8YhcrIis3eaLh6O0I65WciZ69GGfFhk9xChvLxxNrJeiY=
X-Gm-Gg: ASbGncv/ggCYvtmYHrdjMfULSdgjE23HqbYtvvjEyiRlRzm6DhVAezvJKYf79qw26+7
	MNLmA/pSp24q5+jGazoBKh+AzOrh/EvCkQu5dOWjebmYH5j7bNCB1xRY7EF2OuqLHfiETSlPbe7
	2DJom7qE5wIQtMwWLK2KFdUah0hepB2xZYerTgQBXYvuG14Xn+T+ArpoTby4mnROWOhHbbnRjoN
	YK6DEuly0ltdjW+zg+ZwO8l2OBopI0DX1r6uu5oQiqgjnu+PeTgsS1f9kcQ27VfeOal5dv/o1vt
	aET4gb4uZcQv7GW5q/IBpC/cw+tENNzvaqsfUCUg3VA2QM/LUtM3kw==
X-Google-Smtp-Source: AGHT+IE1Ord0Tl8BurkaPnDuV4r4Te8iOeVLYyzC08bi05bzSeYXOW3onsNn3uUNCaQEE8mKnUg7hw==
X-Received: by 2002:a05:600c:45d1:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43c686f96a0mr83815175e9.30.1741601648928;
        Mon, 10 Mar 2025 03:14:08 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfa7e4f36sm22681595e9.40.2025.03.10.03.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 03:14:08 -0700 (PDT)
Message-ID: <f1111d1b-a111-4171-9467-450d90a14c0a@linaro.org>
Date: Mon, 10 Mar 2025 12:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] mtd: spinand: Use more specific naming for the
 reset op
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
 <9004166e-5535-4024-8114-9fdb217407bb@linaro.org>
 <87v7skrgjl.fsf@bootlin.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <87v7skrgjl.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07.03.2025 17:45, Miquel Raynal wrote:
> Hi Tudor,

Hi!

> 
>>> -#define SPINAND_RESET_OP						\
>>> +#define SPINAND_RESET_1S_0_0_OP						\
>> Hi, Miquel,
>>
>> Have you seen any reset op with address or data? If not, I'm not really
>> sure whether we shall change the name for these basic operations.
>>
>> Changing them to 1S-0-0 may also indicate that there are resets with
>> address or data fields, which I find confusing.
>>
>> I think the change is good for reads and writes. I'll check further in
>> the series and let you know.
> 
> I want to rename this macro for two reasons:
> - We might see in the near future the addition of 8D-0-0 ops (I plan on
>   working on it).
> - I would like some kind of harmony among these macros.
> 
> Now, whether is should be named like I proposed or just
> SPINAND_RESET_OP_1S, I have no strong preference and I can change that
> in an upcoming version.
> 
> Which one would you prefer?

I don't know. Which one is backed up by a standard?

JESD216F defines
"(An-Bn-Cn): Command mode nomenclature used to indicate the number of
active pins used for the instruction (A), address (B), and data (C), and
the data rate used for each. Data rates(n) can be single (S) and dual (D)."

Also, "(x-y-z) nomenclature is equivalent to(AS-BS-CS) unless otherwise
noted."

What's an "active pin"?

Then if I look at JESD251-1.01 and JESD251C, (An-Bn-Cn) is referred to
as "protocol mode". Write Enable, which is just an instruction command
with no address or data, is seen as a required command in both 4D-4D-4D
and 8D-8D-8D protocol modes, and it's defined as a "1.A" transaction
format command. And the transaction format is:
'''
The following transaction formats are used in Profile 1.0 mode 8D-8D-8D:
Format 1.A: Command and Command Extension
Format 1.B: Command, Command Extension, 4-byte Address, ‘n’ Latency
Cycles, and Read Data
Format 1.C: Command, Command Extension, and 4-byte Address
Format 1.D: Command, Command Extension, 4-byte Address, and Write Data
'''

So according to these standards maybe we shall refer to it as:
WREN-8D-8D-8D-1A? This seems less intuitive than 8D-0-0, but I think it
all depends on what's an "active pin". I think it describes the protocol
mode, and not what's actually sent on the line. As we saw, WREN is
considered an 8D-8D-8D command, and not an 8D-0-0 command.

For dual mode, which is not covered by xSPI, I guess we can use the
single spi transaction formats 0.{A,B,C,...}.

How do you feel about a OP-An-Bn-Cn-transaction-format,
	where A, B, C is {1, 2, 4, 8}
	n is {S, D}
	transaction format is {0,1,2,3}{A,B,C,...}

Care must be taken care of at the transaction format, as I see there are
a few, depending on the xSPI profile and protocol mode.

Cheers,
ta

