Return-Path: <linux-kernel+bounces-208713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE0902866
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6557E1C2233C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21014B084;
	Mon, 10 Jun 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENFNM9lW"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE26F9F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043052; cv=none; b=oR45txPg2NHjMX0+BDr5tQTItJV/pMEqNDuZvkzdUk4/QHb/HBlASs1bQJQHVeKc7Rq4gp7ylN5QwVjMb4Gte3s6EeVcwFD7k+IjJ2I+xL5wbgqcflKCNhO+IZqi6dxeqL/t+/fgw856GNVRl8n2hH2dXaYw9O4FolEGtB7Znjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043052; c=relaxed/simple;
	bh=TKJNWw/ctgTnu0aRZKtRjOBDAYS/Wup/cHzbGfyP7p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2yUD2sTyQRsOTBmD3ZORdtq+ho+k1/C1NO8ee88tZvkkDXcKG5ByNWT3h5w9/Z0C2rbSmBxmtpM1Gr8Yr+xhBD8RlGtJudQ/XTt/Omm1E/DSSQCMAs22YsqS5bSO1P6jXxFV5SmwmlZMmioyBGpgj2wLeuC4d7e/oHEJT+6zTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENFNM9lW; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso50979711fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043049; x=1718647849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2j2tH1MJf5DFoBED87jcc+yRdvZ3ulPlrgCse54t5gI=;
        b=ENFNM9lWxQSVACcWqHbWW/n5cACkZN408M52DJeKnkHtCR5GNWoT4xYD8Whd1olWq+
         ma12keKm1teZ3UWs97GwvftK1JUCGF8dXrhFgmu4XBCrGmvPvRkBF4gwHZAH3DaWSZ9P
         Swmnyo2UhImKTRWC7Z9vF+pcdHVmV6PtNElBhSwmbzihdxZFKdjm9bthgjrxuLdRItGj
         JmHENg2wlNM8Ou+eBVorXWeipfKLdyUYzgCHc+grgAlS6fGgXdhEoTclQqkWCiAitkv1
         9TeBoW7lKFalw5U9kS0IV9yT/qfr5F8/g2WEYmKl6GK0F3CM1/AOxJ84/URStXCgpXoF
         7ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043049; x=1718647849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j2tH1MJf5DFoBED87jcc+yRdvZ3ulPlrgCse54t5gI=;
        b=HEvSt9GCwoGUEwu99C22U5/HmvH4BRzRlGyP6S9aB5iKm9OLF2Gjosf/XWrT7BhRVR
         ieG2KMtbfvFgicEaarjgUIdDKYSMG75y2XEqqCieZikOACeMiP1vbULn3EnpxubOtL+z
         QMOLX4jZxO44junAFqhpL8BOJTYnHHosb6ZZQvj/JgvgLolRXvzwh24Z6KS3E8aNGARG
         yI9erMElvPa0LSbci0qA0pAIHSrlDPHZwLFUwyq3U9lRkoxWq8R3+TdY2qj9yXcOsCs8
         YnvByIZ4+terFbjJ/IJ+xn7uAZXy+SkSERmeH6vV3b9C7FWatGMgs8clRYE/N2jQgS/K
         8gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3cDfAPGx8bkFbwPXdtf53C85ojMECbxqlrrkfWN+uMHnAxJKVpl5dpU6HG2mDFx5wK2mBXPQ4zcHt1EKnPhAsgLHdr7DY4taOgdFt
X-Gm-Message-State: AOJu0YzFUI84rS+WkE2TCkGp/KnEOSELvG6FbX1o1zyz3qqK4e3dcyka
	zXqrHo695Tj1gnkfadp7ce+QMUkvf0iHQc4Fu+7X8roqmtrlAkjL
X-Google-Smtp-Source: AGHT+IGlrL3f6dl5O0yO6FNxoPk33Q3dtwwLC77xKGnjU61vwxCQWfdswQMz6DKtIxqQs9hvzKxMSw==
X-Received: by 2002:a05:651c:1048:b0:2ea:eaf4:e07b with SMTP id 38308e7fff4ca-2eaeaf4e1ccmr60883731fa.22.1718043049005;
        Mon, 10 Jun 2024 11:10:49 -0700 (PDT)
Received: from localhost (p200300f667069eac100880648459ae0d.dip0.t-ipconnect.de. [2003:f6:6706:9eac:1008:8064:8459:ae0d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eaea784805sm14562851fa.76.2024.06.10.11.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:10:48 -0700 (PDT)
Message-ID: <568312ec-4feb-4e90-93cc-2c119c5a1ae1@gmail.com>
Date: Mon, 10 Jun 2024 20:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
To: Michael Walle <mwalle@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240610074809.2180535-1-mwalle@kernel.org>
Content-Language: en-GB, de-DE
From: e9hack <e9hack@gmail.com>
In-Reply-To: <20240610074809.2180535-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.06.2024 um 09:48 schrieb Michael Walle:
> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This turned out to be wrong. Add the no_sfdp_flags as
> well as the size again.
> 
> Reported-by: e9hack <e9hack@gmail.com>

Reported-by: Hartmut Birr <e9hack@gmail.com>

> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Hartmut, Linus, could you please test it on your boards? Also, do
> you have a real name we should put in the Reported-by tag?

I cannot test it. I'm using OpenWRT on both routers. OpenWRT uses linux 6.6.32. The differences are to big.

Regards,
Hartmut

> 
> This will also need a manual backport to the stable kernels due to
> the new syntax. But that should be straight forward.
> ---
>   drivers/mtd/spi-nor/winbond.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index ca67bf2c46c3..6b6dec6f8faf 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
>   	}, {
>   		.id = SNOR_ID(0xef, 0x40, 0x18),
>   		.name = "w25q128",
> +		.size = SZ_16M,
>   		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>   	}, {
>   		.id = SNOR_ID(0xef, 0x40, 0x19),
>   		.name = "w25q256",


