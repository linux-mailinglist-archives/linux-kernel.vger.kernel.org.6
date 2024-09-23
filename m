Return-Path: <linux-kernel+bounces-336205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A54D97F091
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E8A1F21F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E21A0BDA;
	Mon, 23 Sep 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkCUa3GT"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF01A0717
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115678; cv=none; b=dDnJp5cL0lN+A2CCHVSt2I5hlYwnccK8RDo5oiLiJlvfFyktxp95vZEUiEGwSSSYukomX9VaM2+fDOtPRLXEA/ly4W04pNNzAZ7Fd44LmttKqTZ1UERlKX88HdUCH7czJJFIX347rui7C23qklbOlz6HJjtm3FSoP7nVavz27Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115678; c=relaxed/simple;
	bh=UqUXgYuqU0kIexUNzZ/9X/LQo5DdxjKVQvVx/S+OXaw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QncfAb7ZrUa5m30E/QMWjRjG0KVWAZwQeWuQsI74HlWzlJ3mg3N1koLc8u3GzdwMss/S8L69qR3Qna8eWsFmGPdxPsWtC9qc4aLLz5mzG42ieL14woioa5Q3t7/JtKimoHcv9Dw9r1SuO4rKX4nZ8TSEdwElI6FI5so6HQdVW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkCUa3GT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so3193530f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727115675; x=1727720475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqUXgYuqU0kIexUNzZ/9X/LQo5DdxjKVQvVx/S+OXaw=;
        b=UkCUa3GTmW8z3qALzt/eXt0STIsU5JHlfmOqLgtinEPsICvvm7Mr2ozVVGt+AFMg7a
         8SciocpmyOTKU5f6pf4o1Fpx1e9jJ6cKwZCEoii3e1m0F1lVZb2GyIiUpsi/nRA/+3Ze
         xqWPFx8FIzQab1eyMTjssdnNGTMG510RQuHyIBCuUEj0NoEUjZIaiJCykNSXK2EbryyZ
         0azYRoF+C3gk01zLZgw7nsg7yr5usz2Xr8WN6iPOP/fiVTXd2Efg5ac3Wd6j5MCbOAXp
         A8f/KvTk5hxHu5kYLqwCDmTaeFHd2q8vt3O5JYaVAZtBGIENGZOmOx0eSKyuFkmCMQXA
         7mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115675; x=1727720475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqUXgYuqU0kIexUNzZ/9X/LQo5DdxjKVQvVx/S+OXaw=;
        b=l46r75rXif97V3/wwoVYfmWEdFzMLSnYPfAVXr3sE6DB5RG9mCSY4fuCGhPcwn0TsH
         7Cff912MBIwm0Lj2Ditnn1dKpnganP6rGe8ns8PzywNUo0SySVGbcoCSLwGU1lCM9afg
         aDcsJP1vGlbH6cluBAVeku1RZtD/IDRf1P+Hy0gKuL82i5pCxNs7QMCK1np32Pw0KfUm
         jAPH7VCcyFDjumZTiOj5jJGNjTfFFXqwpaLD3/Psfmh9V4Hr7p20xvVdxwsgEXOTFau5
         DvbmLPWqX1ugea5sNw4uujq0UkRVGccB2tD74PwnU82VIx4xORIRFCWMtiRDKTFWQpK8
         p9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWXgSm1v/XXGH7xHwNI9WKU9B4MijIk5Fud4F98ht4si2pJYCfWocbajFvRs9hJcWDHLZjLuAxJOl6jPis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6CAsFd3pLpc0E+17IjK/DMQYB4XSZ4vhUaK7cPpZCe1IwZv4
	0f+Bf3nHiJeI0+HilwYKTKyoVgnyJJ9MnUpMymQcsaZgOJaScZdMAd5Yd97bN3k=
X-Google-Smtp-Source: AGHT+IEyW5r2mR9KpKQXU3vq9s6UmBL0KAMEAFIWLjveUAe8Jbyp8SjbxG2qsaBNBpw2RKlYUrjsag==
X-Received: by 2002:adf:f183:0:b0:374:c4e2:3cad with SMTP id ffacd0b85a97d-37a42379f47mr7987215f8f.52.1727115674731;
        Mon, 23 Sep 2024 11:21:14 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e6c71c72fsm145269025e9.1.2024.09.23.11.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:21:14 -0700 (PDT)
Message-ID: <502f1855-09df-4167-a7ab-8cbae0da9348@linaro.org>
Date: Mon, 23 Sep 2024 19:21:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Erez <erezgeva2@gmail.com>, Michael Walle <mwalle@kernel.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
 <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
 <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
 <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
 <906df2b1-2827-444f-9de2-9b59f4d49b5c@linaro.org>
Content-Language: en-US
In-Reply-To: <906df2b1-2827-444f-9de2-9b59f4d49b5c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/24 7:04 PM, Tudor Ambarus wrote:
>> * Always read Macronix chips SFDP, as Macronix replaced all old chips
>> in the Manufacture table.
> I'll NACK it unless you prove that the old flavors of flashes are not
> used anymore in the kernel.

Even if you can prove that the older flashes are not used in the kernel
anymore, we can't just switch to parsing SFDP, because we have seen in
the past flashes with wrong SFDP data that made the flashes misbehave.
The recommended way is to update just the flashes that you can test.

