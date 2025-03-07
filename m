Return-Path: <linux-kernel+bounces-551066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62284A567BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540FB3A7090
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B5218EA1;
	Fri,  7 Mar 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiZrPpQQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1221884B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350122; cv=none; b=Ui20UNxB+zJCcgEb2HAfQcAJkX/Gy3KJ+a49+N9X9s7sJqMoIXAM3DJbvMqTDFCG5fD3cKBkQs84jbNJdFDQgS1Asm/WNvU6cPyEKZ7XWJl7Z+/BvLDStWzJJsHO/0qdGcpmJxG+4HY9YKtTICBu/fqnAWzYH8A8J/eaQscFLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350122; c=relaxed/simple;
	bh=cq1+OteKDtgJWfu1nYckuUeYuh1/3pv+gICqyQxiZeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnc5FaXqoqdMS3W5evBMCUOclIHm60DdiqbswWRx1GFcCDYquaKcshrO1ckiw79BUgqIE7Hu+kkNGl/jnerwfDVbpVDgU0vwjaO074PSDvEjz8zFfZyBIEnecVl+d1YBi/O50dpNYd4x7DaVif3zToRE8LRFn4fY5AmSDAsjumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SiZrPpQQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1761713e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 04:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741350118; x=1741954918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LSXN2s87KZIXIkPkPFgGyIKtJmmpgi3DyLUElVYvfM=;
        b=SiZrPpQQQ7oHoHSTkmFZWMsGYcUe8VknD33562SMDVM1kh/OFTcoJz2uvSb6xJKMV8
         nptrWBjOXeenZodMgIRFYlOU5pQrp6xILyeXpRdgYyXtpqS7bQckq9aua9UjULDwLMXq
         SZNQTHMWtpGufbX1dg2WgJwQRlxE70BJzM6yrGE7IqUWxhqZ5nv5/gS3Ww6xlZX3XPO8
         ZdcLj29UWqlZ0IUm3M114nkokRnrmcoHMXvtZIvXXlxC6z+J42LI0XMil0sJ3TJZ2OcG
         zureo9yVLUPgzp2lDccjKkzFvndAJliPtLFtfzxMp6juDzvKURkCVkT3k+PlzRRlSblL
         MiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741350118; x=1741954918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LSXN2s87KZIXIkPkPFgGyIKtJmmpgi3DyLUElVYvfM=;
        b=iM00p/QYuCs0egcmVWsB0dEYMZvwCEUIk+rz/YhRT8IsatTfUUaAn240rF/hPpEaHS
         vqJw4lOGrIDmUqtj6eQseXPYpISnhW2gn1E/ce59/749EI0JaQqUpwSzKceozdKpxAdD
         Wx1eu7RbjerntuUHo8D6z6cwPByGW0P3ZXlwAFTLIcCf+3+F6XwK5H8rHiH3o8AmnX0t
         0CzT4kaRXRg9TNmWlR9HgO3PHKXcMRiA0qh1qQfspcYYQhTRvs3J7QMeXQ4Rt4CAP7JZ
         ZLGSNVbdSyFHBAxQo7pzTAz2Eo/SXNgu2FS20rqvCa828SyfUJ5bDSLqMS1ox9zAzytw
         ZQRw==
X-Forwarded-Encrypted: i=1; AJvYcCWOXeMVVan19aEnS/mDb7diZ/BIXeI7CQGXXnTwYjQ/lPmOu0TpxhFj0dNBbYEKOL9l7XnqfbCkzlsS2xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmau4o5/t/w80WZq6HbqpaH98bXovYeabaeF3nVYGQAmVC14n9
	d7q7bpr9zSF7e/jRL3t13O7aHLfBcXxgiOhBHtaoPZze00Mb2naTNxwiLiAGMqM=
X-Gm-Gg: ASbGnctdamxD1O2W/O40TDF5Q8gp3asWibaQmrLGxZx4b5vNJTE31aLYO/XJj5ny0DV
	CboAie4T5IXR6fg5o51L0dRo6fI8NIdzc2nFiEgLTDrlqKyGmxwyC2up5osQtpO8LaDOwMsz0oe
	D1CzrsOsCtNcR/JZdpwDW7xBn2hv2lOWA4BXzfrEkDYgDadzjaCHSc/JfEGd/5ZqyaAlybzVz9J
	yIW/io6zYC/TLfdEISW4w7BsVmXH0LhwW6CQBx1hvQwotD38ynAu2GU4DjvG4FR2XzeYSsdQ74J
	RZT3UgUqHh7BiCByafgiEstFb5RkIy9/TKGq6c103WioOuhm0btz8w==
X-Google-Smtp-Source: AGHT+IEkE7ifgMpdMezpZQNCnHBP1lZ6rxE+o6lKPh6Da3+fmM6emG5u6CXIK1LjuK/UverWoewG9g==
X-Received: by 2002:a05:6512:1242:b0:545:2a9a:aa02 with SMTP id 2adb3069b0e04-54990435209mr1307217e87.19.1741350118331;
        Fri, 07 Mar 2025 04:21:58 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58093sm473524e87.57.2025.03.07.04.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 04:21:57 -0800 (PST)
Message-ID: <924c370e-2c42-4e29-b790-a1d16e7c1e24@linaro.org>
Date: Fri, 7 Mar 2025 12:21:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: spi-nor: explicitly include
 <linux/mod_devicetable.h>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
 <20250307-spi-nor-headers-cleanup-v1-2-c186a9511c1e@linaro.org>
 <875xkltfle.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <875xkltfle.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 8:22 AM, Miquel Raynal wrote:
> Hello Tudor,

Hi, Miquel!
> 
> On 07/03/2025 at 09:09:06 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> The core driver is using 'struct of_device_id' and relies on implicit
>> inclusion of <linux/mod_devicetable.h>, which comes from
>> <linux/of_platform.h>.
> 
> It is actually included from of.h now (since patch 1) and I wonder
> whether there is a need for it to be included explicitly. As a user it
> feels like "of.h" should already include whatever is needed for us (and

Seems so. I'll drop this patch. Thanks!
ta

