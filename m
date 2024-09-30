Return-Path: <linux-kernel+bounces-343509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814A7989BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEA3B21219
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0A15E5A6;
	Mon, 30 Sep 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="qxBoHCv8";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="qxBoHCv8"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB446444
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682525; cv=none; b=FtjAlUan9Mba1OBcUGPZi7X9cPwVa3D9ISNnx68tFFE6ZPlitP9k+MEniX7KL8xrRr9LRzXG428n6MkcCAMgm7uluRexo8QBucj+H4PoRbDMiJ0aRg0b2E6uscsO1d985oOeoaFTKMvhqpGfqcy96YVil37tVZozMqdYi7GUJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682525; c=relaxed/simple;
	bh=84X343jKiDTjozyNxc+C+n+/VHMkpClXscNAts07s/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUfnAkMCEz54OGOeUilwtFIiQ7/529TYFC+s/oUSrGmLuvc1/KV1JpMb4QaT2JmztJ9iBEn96AU+pKaZKCnlMvWYUFKAkDkD1uq3UA4jzfUDDWdzJ3rYM4/mXf+b5mx/sQVOx6iMNrYfrFrWahjw7UuWQCQQ4g2187HWned7rNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=qxBoHCv8; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=qxBoHCv8; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1727682123; bh=84X343jKiDTjozyNxc+C+n+/VHMkpClXscNAts07s/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qxBoHCv8YkWfTvy+fFFpX5RJwAu5jUenxYIn3wTFUu3slzCbiK1iWIJPapiDD9h9W
	 PrQs/c1bBA8KrUPW9XQens1uYv/4E0YblQQAAHtvuqhHbdRLeg/IeT1gO+hqE5axnv
	 48aFSUzLCROyRTPlLL9l3G7HnmOE7CYTxmjFeuXlGU8aiV2vQRj5TKkPSadKDLbEdl
	 cgVpGl9k2VDfyqVF/vm0KVQoySCNVhXhE4jq0pniyai1+/sYO/w7uS9WxsPsSylicV
	 I7LgsCHATe63FOV4mCSRDuOQhVdPEIXfCcAhkr2/LsFZPEtxOUTpo4AszT35whzA6L
	 dDYbYebGfF68g==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 59C79383C82;
	Mon, 30 Sep 2024 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1727682123; bh=84X343jKiDTjozyNxc+C+n+/VHMkpClXscNAts07s/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qxBoHCv8YkWfTvy+fFFpX5RJwAu5jUenxYIn3wTFUu3slzCbiK1iWIJPapiDD9h9W
	 PrQs/c1bBA8KrUPW9XQens1uYv/4E0YblQQAAHtvuqhHbdRLeg/IeT1gO+hqE5axnv
	 48aFSUzLCROyRTPlLL9l3G7HnmOE7CYTxmjFeuXlGU8aiV2vQRj5TKkPSadKDLbEdl
	 cgVpGl9k2VDfyqVF/vm0KVQoySCNVhXhE4jq0pniyai1+/sYO/w7uS9WxsPsSylicV
	 I7LgsCHATe63FOV4mCSRDuOQhVdPEIXfCcAhkr2/LsFZPEtxOUTpo4AszT35whzA6L
	 dDYbYebGfF68g==
Message-ID: <d954f7af-0649-483b-9706-956f1eb71e6c@mleia.com>
Date: Mon, 30 Sep 2024 10:42:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvmem: Correct some typos in comments
Content-Language: en-US
To: Shen Lichuan <shenlichuan@vivo.com>, srinivas.kandagatla@linaro.org,
 claudiu.beznea@tuxon.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 opensource.kernel@vivo.com
References: <20240930022922.7369-1-shenlichuan@vivo.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240930022922.7369-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240930_074203_382745_221E49A3 
X-CRM114-Status: GOOD (  10.54  )

On 9/30/24 05:29, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> -in the code comments:
> drivers/nvmem/brcm_nvram.c:25: underlaying ==> underlying
> drivers/nvmem/core.c:1250: alredy ==> already
> drivers/nvmem/core.c:1268: alredy ==> already
> drivers/nvmem/lpc18xx_otp.c:24: reseverd ==> reserved
> drivers/nvmem/microchip-otpc.c:159: devide ==> divide
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

<snip>

> diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
> index adc9948e7b2e..c41a0c58bec7 100644
> --- a/drivers/nvmem/lpc18xx_otp.c
> +++ b/drivers/nvmem/lpc18xx_otp.c
> @@ -21,7 +21,7 @@
>    * LPC18xx OTP memory contains 4 banks with 4 32-bit words. Bank 0 starts
>    * at offset 0 from the base.
>    *
> - * Bank 0 contains the part ID for Flashless devices and is reseverd for
> + * Bank 0 contains the part ID for Flashless devices and is reserved for
>    * devices with Flash.
>    * Bank 1/2 is generale purpose or AES key storage for secure devices.
>    * Bank 3 contains control data, USB ID and generale purpose words.

For lpc43xx/lpc18xx

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

