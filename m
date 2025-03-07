Return-Path: <linux-kernel+bounces-551440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE3A56C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F0F3AFB6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168121D58F;
	Fri,  7 Mar 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD38+2g4"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8121D5BF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362308; cv=none; b=mFd94ThI61V7qxnVHxI/iHvvfsH3BjVMM0HuZoLQyvUwjxX2imeX/TQngrf8z5ioCm+sDUkmKtVums6sAbxf6dMEtRIdh9AOYiFJhoNUser0TlV6fu1X9BW3vHP7V745kN090Qd94R01ppN/2wNevPDehof4+f4TV95XqWhG5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362308; c=relaxed/simple;
	bh=hp4/XGgKZswfxI/E1Yn63TPUSKhNdGFmWc8P6pHuvt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmqMPh/1CCn0QyzdjaTTk4ZuUfY4tLaGZ+ZLzQvZA+HwyIhkS7X1bmYqAIKJTkox7Kpsk6rW5Jdy4lt8+xD0/ligwTTV7s5PbfBm5FPtq77JT47G5MFNqN0kOOWAjwdcHhoTuiDw0aBpUEW/fMseF05gxcumMGeud+gd1ZxCe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rD38+2g4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so221522a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741362305; x=1741967105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hp4/XGgKZswfxI/E1Yn63TPUSKhNdGFmWc8P6pHuvt0=;
        b=rD38+2g4USbEU2aMOSG9Gk1X/JuZ/idXGMbBB5JqIq72xq5ksZ7uOJV7yKMfj8MDU6
         4i7MOi5pzc79jybT0sn2i8nE7ZmnXecKOIxoyca1KsEM++RZhFOtTeYdngUKjRWBWtkr
         pq0fUFpBXQVsXqlEV2ftgZXU9x0X6gKqikQ0ef1B1MhD04IMVl30G9dVE5T6W3O1lgyd
         xb6GR6MQe3TvbCnTipivsaC8ToRDuxtVEXKsF41QfMeIAmSMAshSqUJBnPbPPPgW+hdd
         nQsJRdpndBL1aC1PMpKn/F92T/oNKSpUArM3DXEiVcfzGlX3gH81t3QkUL4Vd7TdkM3J
         D0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362305; x=1741967105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hp4/XGgKZswfxI/E1Yn63TPUSKhNdGFmWc8P6pHuvt0=;
        b=tp3v4R4BY+83qRv0z7hk8sMyYNr9KO+NGnrv1IabZxYQ/vyKXuAgGhUPV1GXurlI+F
         h12V+acV4gURlTfQFc4lc0p5dGAbtif1rDR2SwtbkxtbfZl/gdhtKw/AonF0QX9saFXi
         9xCLDLvdhvlJYmfSh+NRP30XH7fkMxbqaoA/g1qIeivJP8cjiR8oV5GhJ8z3HnBZK+sW
         ebw13QKw/bqY5vHDhDYuCDblVF5NShr8jyZYD5tAZWyiYTdC5dyqWKMbI98+UV5Q8bex
         TWHSAmIjEyMysmm/QOyTWsOJ8PjtzQKwy/iTfQ5lAt00vwEyNvU9WDPNnHTG4ThcxdKD
         qSHw==
X-Forwarded-Encrypted: i=1; AJvYcCWncMNEWr1x66Ws1ShV64yyiGp5qNE6SZMSjh+jGlILPjooMCu4sYPd/xViCQSzIdiCs4maPXUyy6+ymx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwumUEesHubXtuz+W1nl8FL+w/UcyfthMrsFjuuWyEVqyCGNyev
	NL4HFKXKYUB1rTIeiYggB8Cd16iQ+dz4HcovA60TAqTB/u7mNqkrcinh04d5ZkJSs3VPKOjCySJ
	X
X-Gm-Gg: ASbGncu6kufcJ1/3qbDg0G1aaDPxXsVORvuhCB4YgX16F3eRAugCX6zJ0kiMD3uBJNx
	0kD5IfdGL6vRrvhD4ikc3VNKg7ifwPls4DApxdJiZgFjs82ZjEenOEuBGH6ZgIVDPBM2xV4F+Md
	Y4f8v5fs/b37zVjP6+2w1JkJZu6wTd/Lq3PtVsGBi7wrAdPugHyN3zlZDHqfAyKwLp9y4hjg1el
	0RoABXLpRvlBRw9txSnzfTFWm1MZe/qB1I0XpdCd3sb+sXoBiyqnL/npCL6FUbPCKRSU+9o4wIA
	29avhtUUP/cp0vM5QZtq3G7KDfLRwr+EnVOe6UCXQbsddIpfVlG2+g==
X-Google-Smtp-Source: AGHT+IFhcx40CPO1Woyn59Kqm0r2csraaIahBrV7s8VQeWauV/MiFRVCSNDB3Hhg8+uOA1i1mGPpqw==
X-Received: by 2002:a17:906:e4a:b0:ac2:64e1:c75a with SMTP id a640c23a62f3a-ac264e1d275mr166691966b.45.1741362305221;
        Fri, 07 Mar 2025 07:45:05 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239438955sm296532966b.19.2025.03.07.07.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:45:04 -0800 (PST)
Message-ID: <48453010-560b-4985-a6e5-31401da24d62@linaro.org>
Date: Fri, 7 Mar 2025 15:45:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] mtd: spinand: Use more specific naming for the
 erase op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-5-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-5-45c1e074ad74@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


If there's no chip erase for SPI NANDs, then keeping the name as it was
makes more sense to me.

