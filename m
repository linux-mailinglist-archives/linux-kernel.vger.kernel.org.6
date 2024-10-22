Return-Path: <linux-kernel+bounces-375977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954F9A9E17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0471F1F274BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D26195809;
	Tue, 22 Oct 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL3ulpYg"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41C155330;
	Tue, 22 Oct 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588479; cv=none; b=Pepy3Yj1ZPU3wsTTgCserxVQrGJ2s0jUidfYhN8GJTJ4b4YIXCz/JY5stCzayFYuGIzgRd6HZmj8cF+JCJagF22ziYOvf3lpHkipXcBil2g4iNT9JYfBO3A6Cp4WCdOf74Zecl9G7m13i+k1aTcGZC7N42b2GtdBftmipb7z8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588479; c=relaxed/simple;
	bh=f+VA8/ybdfD4gsOa8oxcs6/Kl0Jm/VzGANxxPbg3Qb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD33MlC34U0IRFVQtKFUxEe82A56a/g8cZ4vqXaR6oKMTKmRm452ajrsO9R48mM+6dJbujiCQjT9fSGkmLgu6X0355cRHK6JkirelPRi5s0Kv6bMJ7/w4zyKxLFbZlE5MxKyJWHtMqOwLKjxSM1klJ0QewTRcE716ZYtioXtZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL3ulpYg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbca51687so53860605ad.1;
        Tue, 22 Oct 2024 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588477; x=1730193277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K51whSOoccfWJ1oT5QsGS1IjvPrInQRVrtM/UwrHahw=;
        b=CL3ulpYgMdDpIWHAblCNPF0NlJQKmP09bxNz+BIq0YgLx4htXO4Kj7z588DNxTBGFm
         wycdVBMdXG3haHvW2j0QM+eco1p7lobbxzkHckodnQG1WMsPdVLHbhGrGP8/QGTBBKLn
         abWPdzNhH6B4MV9g806plucAu+YP30+toojaPQ0LdTtnIJ+j8Mv8qbIiByWY+Jx2XDt6
         H5vHs7xl3w64580GbYKOQssUR/qVZyr3HyIFpZG0EVn2L7wG1FvSO17gkX3aLcVkg+R6
         iF9IeGANI8hEZ9JHm1HAHea+OQMEJ459dp5/TkEcN9HWAcDiPsALYLwP482OMLe7GYvV
         8Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588477; x=1730193277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K51whSOoccfWJ1oT5QsGS1IjvPrInQRVrtM/UwrHahw=;
        b=tHhyyVJclNAbQEk0VPm5E84KCyg0xXgTEuA0iuqBUg2vbLeUqDCQTe8N299HLnh0Ap
         CbYhSH4no3yy1mFXEDAGWvyM+441Lz0uqBAWd4qS3t6KIQhcBc6fWdH/340M1M6UdxCC
         jSbp8MsWi6CtZqEY7TdRusGvoilOlldQlg11km1izbTb5FEW4qcCGQx8q6EdFBhaxrOF
         IkAonahphnhhKLvFllp+q0/rFdQz1XvTNsCNRRou2n/5q6iOhsQZl9fEvkgJBKxfsZ2F
         g5P7XZDlkOOZap6DOqVmUqBN50rBgw05+5YaWPq79LrjsqmhBjZP+RqwWNu9HGhgu+VT
         bYWA==
X-Forwarded-Encrypted: i=1; AJvYcCVALmPji43nBYbtWKmQgPFdbgLJdKamKu+FbBNERhU2b1/qh81zSaeUIivJbsjmkrNxo7Q9sVtppFFI@vger.kernel.org, AJvYcCWJSvhtErhwm45P4wCxqZmiHct+bZtOCxgO0Eoo7u40xYP7L01XUCdGo2VPEgi8KIaIx8ULs+9y4JfDbq+v@vger.kernel.org
X-Gm-Message-State: AOJu0YysX0vNSWbhq2yKC4+Zm2YUKXi8SuU6sbxU0ceefhSu6JC4uk9n
	y5NSCiv7tS8n4qM48wM/iUdvs3gK9y4ajz+8SwF2CO/lE0vOAQTf
X-Google-Smtp-Source: AGHT+IHH9sYrSSvfbEf+31ytxi3WDRRewNjbMkhS8kbu4X5qoBQrSZpw/oFE2eqC02U58aD5xBFgQQ==
X-Received: by 2002:a17:902:d2ce:b0:20b:6a57:bf25 with SMTP id d9443c01a7336-20e5a7749damr228551665ad.20.1729588476937;
        Tue, 22 Oct 2024 02:14:36 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd48fsm38623195ad.129.2024.10.22.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:14:36 -0700 (PDT)
Message-ID: <38aba46a-c5e5-4832-8a73-4260d5a94b68@gmail.com>
Date: Tue, 22 Oct 2024 17:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
 <20241018022519.721914-3-hpchen0nvt@gmail.com>
 <20241021103254.1f31205b@xps-13>
 <9cfd923a-4bc8-4a6c-986d-8d0c6fd6d9bb@gmail.com>
 <20241022105109.1906f524@xps-13>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <20241022105109.1906f524@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.


On 2024/10/22 下午 04:51, Miquel Raynal wrote:
> Hi Hui-Ping,
>
>>>> +
>>>> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>>>> +				      int oob_required, int page)
>>>> +{
>>> The hardware ECC engine should always be disabled by default.
>>>
>>> Then, in these helpers you should:
>>> * enable the ECC engine
>>> * do your things
>>> * disable the ECC engine
>> The ECC engine of the MA35 NAND controller cannot be turned on or off separately.
>>
>> The ECC engine is activated with the DMA,
>>
>> and it calculates and writes to the OOB during the transfer.
> What about:
>
> ECC Algorithm Enable Bit [23] ECCEN
>
> 	This field is used to select the ECC algorithm for data
> 	protecting. The BCH algorithm can correct 8 or 12 or 24 bits.
> 	0 = BCH code encode/decode Disabled.
> 	1 = BCH code encode/decode Enabled.
>
> ?

That's right, this bit represents this meaning, but ECC operations will 
only occur when DMA is activated.

I will add enable/disable ECC engine before and after reading/writing 
the page.


> Thanks,
> Miquèl


Best regards,

Hui-Ping Chen



