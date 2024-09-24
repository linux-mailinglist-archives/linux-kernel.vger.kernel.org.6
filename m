Return-Path: <linux-kernel+bounces-336574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9F983C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86461F22600
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7D49652;
	Tue, 24 Sep 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHsnr4g5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A819770E5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157877; cv=none; b=Phwe6HpeRZ7ofYj9pQ0z05loJ7C7dTFrDzRQDsxXkCbE4U0Xq3BoMOoqgmQfx0XJ59paaR9M+Y4IT5I3wL+wLf6cLDGRpuT4OPrVr7sl4BGWw+M1B0HC9fjWqPxM8KwF2GkiQ+onOFJEVmcQIudqxJD/iuEJ5xw8haAB+ymJlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157877; c=relaxed/simple;
	bh=6rcrW71ZP88vsJq+Rm3jrHCL2rSoJ6nT6MfAts5dF4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxe/CBPD3W5groO99vV7xeNO4rRKVWiSuTb07cKnqOImTb2xl9cOJNRiND7osbm/vAH7pLa+6M7AGsZBhTPx171NgOguRd2YHne+2c5Vj4vyNRfyMBXM8h/AZ6xHEjFB1It7Fg1N+aiHSyZ4tv+hpMNT9wt3W+caopj2RMJmWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHsnr4g5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so49095075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727157874; x=1727762674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rcrW71ZP88vsJq+Rm3jrHCL2rSoJ6nT6MfAts5dF4Y=;
        b=CHsnr4g53BO2RPxdx1f8ta7YntgnFLu2jWhX3pqwPL+jZPDE2R/1XeSVyKncwZ7DJg
         NCfVahb4RrnMwM0QqYj7QYzXFDcje9owH1bQhvCszgwO/9g5QRsJLnJCU6huuQ7IZP4m
         dQw45oHKGh2hwVQRuMxPPjrk/Glfff0FnsXIs8N9iJrPdaWBi//d17Fhvosbr2/ouDw4
         6ky2TNpRBLSkXPBM+1xkAoDlpKzknO3iUrBLsDIBrHNg/1CKkmiNL3DF3K/C0R1tMnGj
         lTlD3qoWunBeJCoyI5jkUliZwDrqeWjOpyM0XuIlgV4WcGP2GuEf0KjG1cdoIERbqoEl
         KN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727157874; x=1727762674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rcrW71ZP88vsJq+Rm3jrHCL2rSoJ6nT6MfAts5dF4Y=;
        b=Vpt7ahxeZl6+aXZPThbD0fMCrNW9MbcRDLSJJ6CRmBrHKG0fT4oYvOsQYw+i5gzdK4
         8dRjt/swcv2qY4bIfarr7zX+q2FDFgv9ZoMwcpepA2bdiE3aA4kQ01o05RgY4pHE6Cuu
         oCK1H96MthDoakSuDsKO6uFk4KYd52rhnGU11ZYu9OVYVj2Rjk/zvv/ohzIT/x7RpHO7
         N2NcFjW1PN8sYk+c9Gh1nQyYpNMzYS3iNZtq5ed7tp24U9CTVKspzPBCZaRizuVbv5gp
         szBCzPKAYG/xnmWBO56GbaOj/TROfjpZ+NAkxSWUcDz4WxpfA2/cezQO8xNxDypf6qtl
         1JNg==
X-Forwarded-Encrypted: i=1; AJvYcCX0qqOVE8A3opg14HXCG4Q2Y7R/3tfkO9WY3dHOWpSnd0hN45jRdwYw4o5QEuCx1g8I1PG3ThSJhfp+bcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvRr8e13W2cdf+M1fosiDb0Ogq8bI5dKIhIzahPS62yDL46EF
	1h6FpJPKd3Ahw8Q8E3JYX37lcvKE8zVwyweaW4wMBsdJicyKGjGJoBldh8nuozHucUiIrYkn1Qs
	K
X-Google-Smtp-Source: AGHT+IEVDQFzeiyRgulfL9oGUpluoLBy4clrJQHLJVmYY4jTv+qxHoQ6jSCN1aN2Pe29faDnW0Sk+A==
X-Received: by 2002:a05:600c:3b8c:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-42e7add1c1cmr101358965e9.32.1727157873871;
        Mon, 23 Sep 2024 23:04:33 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1ef1sm665368f8f.35.2024.09.23.23.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 23:04:32 -0700 (PDT)
Message-ID: <6663a723-547b-4f91-afce-7775c86d0c0c@linaro.org>
Date: Tue, 24 Sep 2024 07:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Erez <erezgeva2@gmail.com>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <2c87568d-3caa-4162-91de-094684f1b268@linaro.org>
 <CANeKEMO4ckeJZHKEOKHVeamPzR045jpwkXWfJS9S6rBiMTayuQ@mail.gmail.com>
 <688d3e68-c339-4a44-b6b5-366dd5f12965@linaro.org>
 <CANeKEMNKF5WtVgzxbMnLFsqRHNOz=+gD-if8aBqsWwjgDvz3GA@mail.gmail.com>
 <ca2c03f7-0769-4b2a-b743-3ebda9e29755@linaro.org>
 <CANeKEMNdGvteumpvLHhDoiVoZwPJ4iOs+Ej8KDoXR9-Vz0-rvQ@mail.gmail.com>
 <CANeKEMOH=CTC9GY5LFLj0mx2OoytR-9bOsFM7edDQ6-e=CaNgw@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMOH=CTC9GY5LFLj0mx2OoytR-9bOsFM7edDQ6-e=CaNgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/24 10:41 PM, Erez wrote:
> What if we put a JEDEC ID + SFDP Macronix OTP probing code under a
> kernel configuration with a poorer warning?

No, we don't add kernel configs for such things.

