Return-Path: <linux-kernel+bounces-338058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3C9852DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B081F24572
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7315535B;
	Wed, 25 Sep 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="reD/XONV"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768014C582
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245363; cv=none; b=EtG0nFVwggaKsn8RWBD+xl6/ZmEzoqxJmvViPPzUgNijkYBsnl42ad2pnq2O1NlpdCp1zdTta8c+dhIZdfCRrvSP+IrGxY/s1q+Z1Fkje0/B6x7+H01vnSKT/SzF/26yHBE+OrnNx9BnTzUUPhZJfI0xdMj0nV/lvPI2/d/h1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245363; c=relaxed/simple;
	bh=IVhzGzAjVHafS0MM02RpmBp4pWCImbqC4zkBAGpgAPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPYJxtK7qXDvwwcibhmn/tYK0njq1h69iyD86paWxZx6fW9cmktk3K2E3pHGKjHht4fKzc5yWD40FHxD7eR6kTKyIP9/XSWyKsb3VHT5UOuEwMXiCth8vRQyViXBPsPuMk/gpjkFMF+tzSchmq+w5hmghy+/OkAttkb+iUXQZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=reD/XONV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cc810ce73so75864f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727245360; x=1727850160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/oS2ugpeUSW+6nwIvuuz9Sn1patnKM1K1PU0Uod2NY=;
        b=reD/XONVK9Hj3Mi+mPdHnK4uB8BdM0NsM9BNoJEjTC3nlXSc5UgLynP6qXYK0e0edy
         zA9u5AS7UbLTT5ViZ6/UrnsCvgh14+EehjeeUmvXznFmQY3Adcc7eLAM8qOdvuqzDPQz
         1OO0aKcv020DbUDCZ2qHD4HeqH18FBRTxu+QIO02Zy1q5xu1mu/JonKRX8VKIo7CP51z
         n4N9c0zcex7N5EUkxCYmwjhBMWqgZoWGOSOVDqy0v7GYuXSJH7gHcr8dhBPcnrk3qxrX
         UxjhYucCjjDhQUleOJIdQMe58c9/PzBKA0ZBSuDQ0uNyoOH0jXSwmhJnOLyIvwA1gyhe
         wp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727245360; x=1727850160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/oS2ugpeUSW+6nwIvuuz9Sn1patnKM1K1PU0Uod2NY=;
        b=xCSphHvtHrXQfJ2Q8AHdGgydiZk7EbOC2pXVflMaJqX4BZDETRMT0QGJ5siRIw9cW6
         TVzTj5HBSpymAzyyqVVSB8HYA1rJaQSv0R5KV6bWQQTKqBXjn59xads2JM9tFNBpHJGR
         tSYhgWAMGi3Ax9lkQ/W/pTVwRGgjpqssGjXH8XOtMR+wuwqyFMdAQclJIKfUkjS/vR0M
         Eiqa9vu3FriJYE9ryjyD7hWV6QWO6uYaKckx8luJDr3AALSXXUyZfUbh/Ddv1vGK+Q7C
         MK5s1+3v7lUZsNsx+RwoWTrz+a6fVqWt9GZjdlZLvzP47X0mdzNK9MBvFNsHY5jyFwfF
         iMgA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgAPTWTUoVG9mYK6JxE6d6Y2YKsC8T3f9ZWR2xb+L+l0xij8nu6cIXAptOUZXO3JxfTxgZBPtf5RFlEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62MFqwal0uP2PuzuMujUEMBVj+mAimQ2RPfH9rZOPzXChTTo5
	0GC9FVkHx4jy5MTLnFtQVYmUQY2nzwcfIgC0HEouoUvIB8HXvGGnguknYC8avbw=
X-Google-Smtp-Source: AGHT+IG3dYAVXO0Ep2i7vx0JuRGZS2wbqrxhkLOCav4gzYfGhkJtR3KQHMBdbfF5LZr1l8Ir4MTfmw==
X-Received: by 2002:a05:6000:4388:b0:37c:c870:b454 with SMTP id ffacd0b85a97d-37cc870bc64mr149201f8f.49.1727245359901;
        Tue, 24 Sep 2024 23:22:39 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2d25absm3108089f8f.65.2024.09.24.23.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 23:22:39 -0700 (PDT)
Message-ID: <b4dae4ba-c016-4384-8a20-5184cf113902@linaro.org>
Date: Wed, 25 Sep 2024 07:22:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] spi: mxic: Add support for swapping byte
To: Mark Brown <broonie@kernel.org>
Cc: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, chengminglin@mxic.com.tw,
 leoyu@mxic.com.tw, AlvinZhou <alvinzhou@mxic.com.tw>,
 JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-6-alvinzhou.tw@gmail.com>
 <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
 <a87a159e-eff1-45c3-bf26-115d4ca5a9be@linaro.org>
 <ZvLSLt95Hrd7JYj3@finisterre.sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZvLSLt95Hrd7JYj3@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/24 3:52 PM, Mark Brown wrote:
> On Tue, Sep 24, 2024 at 03:29:37PM +0100, Tudor Ambarus wrote:
>> On 9/24/24 12:38 PM, Mark Brown wrote:
> 
>>> Acked-by: Mark Brown <broonie@kernel.org>
> 
>> I'm fine with the SPI bits as well. Shall I take the SPI/SPIMEM patches
>> through mtd and provide you an immutable tag? I can do that after -rc1
>> is out.
> 
>> Or you can take them directly through spi/, but I'll need an immutable tag.
> 
> If you apply and send me a pull request with the tag that should be
> good.

okay, will do, after -rc1 is out.

Cheers,
ta

