Return-Path: <linux-kernel+bounces-403899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D441C9C3C67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1299E1C21676
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44477158848;
	Mon, 11 Nov 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/aeF002"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E21547F2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322157; cv=none; b=c48WuRZJ4W+V5DdXkAg+3p6bhCQ8ibFgmaIJqkK0bveN8v1DlmTXsJNUEkgw0RpNojh667InalXriuHB0he8xDoy/RCfFAPAlGMlwLAMTyMoOgAEiEZWE2SyQuVB1DybN8/ryPk6pyeopmm0+r4qPzeICCFz1Xmhl9Pfheu/T78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322157; c=relaxed/simple;
	bh=fcg3bGywh7tkSjY/URATRdpwiLLuXBo8vCeZcKcKh3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvJEAXm/3kMN6rFu81JCvwRR6dVWnm+48jysjdCjst6rQYuiTGQ9iWtN4PPpnKu/QX5b2sBytCafxyONfZrhgXG1i78+s9NqunSIncUjrit+0wZ3ksHxrw3kSHtaRTG2fedbU/fYc01fNPuw76Sv/XAw0YOfdCn6j92d62OceiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/aeF002; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso753498766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731322154; x=1731926954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdFblD4zcwXp9mblURQJJ7/5taoThoLu2/KoJcxRfJU=;
        b=B/aeF002sK4zFZZtcvCmQ5d0PpcAoybXQCc17sZDvlQuR/7oosjGawTEOWyv8H8nBZ
         J58M9Me7kPJSTmeJrs7/RyD55mHSnTySRwp+2t2UuIW4hj4e6wN53fweJxF1YIVITg2a
         Y4mGIb3bX7fPlV1j8owJG9gL1tAKd0m/XwsEFP6sCneHpdh3HTb+7WqAvg27lDhSk/1A
         3CQV3O46ZlqBStglEaqi0XAcrD+r1IJD6oM1gUa6br0V/C/WaonDXXr2B2c6hNR1cvH2
         nHpGURTyexXHffAiunPIeSxX+YsA8uSb25vc2KFJ0k9FmMWM0pqHz7RaR1K1Y3fNWqM+
         s/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322154; x=1731926954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdFblD4zcwXp9mblURQJJ7/5taoThoLu2/KoJcxRfJU=;
        b=KTyd+rrA6NEebKuI9icbEyAqWAxAxI6BmbV/Sa9AKEVToZWQxk+DuQ8KSE6GD6V272
         BdbVRPkeU9D6/LhNzhHc6MNIXsMDVuT5G1qNylJlwUhnXKjhOdlDupSb+TSDnVWe2Cgk
         r0BohWFve9ooy41rNa0Vz/YePEJFTUFsMyPMME8jQxn3/JE7G6QSuGtjr0d8WCZDzy3B
         p73/djsCq6tx+9N0cE3IevCxUgRkUAO+X5Kzr5xBRwlHmaxuNWP18+TqOGp+QPKOMwh4
         juqN3X7gZ5GvXHrnG1ruruqVBlmJx7Tm6yHnDsJMQsz2Iq0y6ZIWi52qTom/mbDZVmKx
         IFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvxuCRrEWJX3SwF/tzfYAM+5lHia434vsuvC6vmQrVLjxGDeAbPvWDpxqih/5P74BDU5uQC5Ui5BS+Dtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQqX0I2aVlJnXoDsirRVUXQF7FuWmROrtha+xd+DYyZyW4nxe
	neMP5FkuIGyMjFMH2tCHKTNGMqWNDpA06copB7I9sWKElhF60Ngv6wMdhEeT/dw=
X-Google-Smtp-Source: AGHT+IGdTAR4XnUV2y3iX0KvJMO8K8H04XHHottJjjNCZCgVGBwvq5CKqAzNGyXzy4bIb/BLVC3+sw==
X-Received: by 2002:a17:907:daa:b0:a9a:2afc:e4cd with SMTP id a640c23a62f3a-a9eefff1798mr1135492666b.44.1731322154409;
        Mon, 11 Nov 2024 02:49:14 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176a6sm577324666b.16.2024.11.11.02.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:49:13 -0800 (PST)
Message-ID: <0525af7c-f9a9-4dfc-9fed-97efc438b2b8@linaro.org>
Date: Mon, 11 Nov 2024 10:49:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: remove mx25u25635f from parts
 list to enable SFDP
To: Parth Pancholi <parth105105@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241105105844.257676-1-parth105105@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241105105844.257676-1-parth105105@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/24 10:58 AM, Parth Pancholi wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> The Macronix mx25u25635f flash device supports SFDP initialization.
> This commit removes the specific mx25u25635f entry (NOR ID 0xc22539),
> along with its size and flags, from the NOR parts list. By removing
> this entry, both mx25u25635f and mx25u25645g (which share the same
> NOR ID) will utilize the generic flash driver configuration.
> 
> This change allows both devices (mx25u25635f and mx25u25645g) to
> leverage SFDP-defined parameters, enabling dual and quad read
> operations without the need for manual adjustment of no_sfdp_flags.

I'm fine with this. We may re-add an entry when BP is used or if someone
reports there's a flash with this ID that doesn't support SFDP, which
has a reasonable amount of probability for macronix flashes, but I'm ok
taking the risk and fixing it afterwards if reported.

Waiting a bit more to get Michael's and Pratyush's opinions on this too.

