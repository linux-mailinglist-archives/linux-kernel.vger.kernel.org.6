Return-Path: <linux-kernel+bounces-337256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C909847AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF9F7B22422
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329B1AAE2A;
	Tue, 24 Sep 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlFdBqfL"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9811AAE02
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188184; cv=none; b=FG/9dNTKdps97cWtX3lihrqx/OfLZiZ2ptSSOab105ZwyrZw+Nj+74+jPXJli1dq1ZKpHPIy5CTymvLvEBw0QIngTHPv/ClwKRH/JJ7ivg4Qz6xi1AjKTkUHR5W5dlcZDGJ7IbYRS22/jleNY7/BnK6ea6iJi34bpM0DOIz2SEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188184; c=relaxed/simple;
	bh=FngZq51ki6qCptx3vUMPj1acgIGtnSKHuHPNES28BJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPOa3Mhy+Q0KvjwXIAPMMLkej9dW3U1+DAgQF8FdPP821RKzPK0IhI69YyQJ7c19FNIU4Vvro5DMY/iKucCnmv1UaWlm3InpoGoKA8wU2X+R299J4WLPNvgwxchNFZAAYRc/mfTcE5Tag7ld2XXZUFZpfIiUnuuLANT2Xo8LodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MlFdBqfL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f759b87f83so59435391fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727188181; x=1727792981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4cZlZAMjE0Ne1cxdgDT0MlDCgX/48/03XwVDrLKtwc=;
        b=MlFdBqfLRXeILdMKeUFGE/O8MaqhrNmOjmgUwlL5luUrOzOst1O/oQ3ZMu65DgcMt2
         2D1+nemtS0xsLtmzu/yRmFWOApL09KggFvsK1ZS8mSpuvHioswjcbP9516pccK8fpzm9
         39JuTE9l4XatVybiasatkWeftvzaS2QjwKruRri2aBjNPAywkCwdnbEKhfyXt3zshwFY
         F9dFwTDj4uFthNueThbKoHtyb6z6sPyK5SHG42PZMSDDG/BLj3frTe++Grk6vlw3EuL8
         FCKlITs1tateGuR4/nb+xx25A0Da5zl1Wdnow90wHLs8kBmRPKo0fF1HWAiPq6QrYC+k
         vMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188181; x=1727792981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4cZlZAMjE0Ne1cxdgDT0MlDCgX/48/03XwVDrLKtwc=;
        b=szJtrcqyaiiGle/6S9fn4BUdIcSJmLNY3R35uhzZ4lJNzxyRgJsENZKWqJPYPGsiAR
         MioBnIbNJd/R3tstOk4P/TIGTrIm1c3wEljB6b81fRBz0QhqFqk1V1FL6FvlFsVRJH8F
         2CV9yeAFAOO8ktarnlKUpf7s2pcmehl+MkpKAC/eb6CyjLPx5XdzRmGUjTnTfX5ItfwA
         TVy3M1FdD1xxb1uR+g5xXnKYUffg+YbytEskfxXKz8IPGHnvfxzDG51771wUtSVQbOhi
         nXzlvhAroQZF8SUAInfiZiBrOkDEzrmKUjP1mUiz+danQpW/KOedxBIlsm6gHeF/OLGO
         MclQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcgotY/651hvYR26U340RVZOcA6EM5J36gtqWBym6SoaB1Bflv5PLeboIK0AqxrKsqdVPdjQYiJQkcnv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0u4sMCRYR0TrVMpg9sGflZghgN2k2ULL/g9/DehEYO8jVuPEv
	7dsQb3/XFi1Fdj5jEufIqqtmHlG4jdRWvRt1Ilru9pCLgkdSL1CTkHTvaKXb+S4=
X-Google-Smtp-Source: AGHT+IHqqbNSNbNJsHX8o3utWIHB/GoQ4Xc0CjtuLGIi0iI5bbvuRybVAXmwL11ncdRlK449c9p3oA==
X-Received: by 2002:ac2:4e09:0:b0:532:fdba:e7bc with SMTP id 2adb3069b0e04-536ad3f168fmr7657143e87.57.1727188180585;
        Tue, 24 Sep 2024 07:29:40 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cae67sm89840866b.121.2024.09.24.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:29:39 -0700 (PDT)
Message-ID: <a87a159e-eff1-45c3-bf26-115d4ca5a9be@linaro.org>
Date: Tue, 24 Sep 2024 15:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] spi: mxic: Add support for swapping byte
To: Mark Brown <broonie@kernel.org>, AlvinZhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-6-alvinzhou.tw@gmail.com>
 <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mark,

On 9/24/24 12:38 PM, Mark Brown wrote:
> On Thu, Jul 18, 2024 at 11:46:13AM +0800, AlvinZhou wrote:
>> From: AlvinZhou <alvinzhou@mxic.com.tw>
>>
>> Some SPI-NOR flash swap the bytes on a 16-bit boundary when
>> configured in Octal DTR mode. It means data format D0 D1 D2 D3
>> would be swapped to D1 D0 D3 D2. So that whether controller
>> support swapping bytes should be checked before enable Octal
>> DTR mode. Add swap byte support on a 16-bit boundary when
>> configured in Octal DTR mode for Macronix xSPI host controller
>> dirver.
> 
> driver

I can amend that.

> 
> Acked-by: Mark Brown <broonie@kernel.org>

I'm fine with the SPI bits as well. Shall I take the SPI/SPIMEM patches
through mtd and provide you an immutable tag? I can do that after -rc1
is out.

Or you can take them directly through spi/, but I'll need an immutable tag.

Thanks,
ta

