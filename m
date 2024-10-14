Return-Path: <linux-kernel+bounces-364423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC199D473
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AC01F23C47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9691AC450;
	Mon, 14 Oct 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cOFwW2Rr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BA20323;
	Mon, 14 Oct 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922573; cv=none; b=aApCj4HKbugyPvQB1Q4l2xX6j//su7dqiQqiSLkMQQJNUlsuhhS8auG62lvQOzA3zDh4awCMp2SDg1yd1ddcImYGdv74GWIL87YbGw0X9prmwyCvziHU5vJRG0D1PVjfa+H8Y9vplDDftOObspu2+du6ebeTIxn9Yz/vsYiTYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922573; c=relaxed/simple;
	bh=zRv+5ICbmICC8lLulQye0gpcpQRjLqfBK4wwQxCwFQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZ/PPWlz3sQW7n//74mEwe5LvNIwkCbhtMHWCJZLmRqlAdpDZPWjh5Nmm6x5UGh3+OPDw0bO1ob6wsTkeEOyXtldIUnQdQbmm85NLCAwrCfWxabm+mejQPCXulbEoJ+Dass1U+My8sEQcKwz+o41OCYKAB/3d77QCRGaAXPZB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cOFwW2Rr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C05DB42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728922571; bh=J5fEbVcW0uhdB55dqfS20FIGCPc2N2MZWHsQ7Tw263g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cOFwW2RrwnpKbDtI2QeHkx6bihLVWvRtqbpp/Q2vHulf40/tz7F8TlPa8W23yvkp6
	 LIReYzHmciHVpGhDF89YR0vBpi+xTvQxWhUGPOheHZP5tAUSvMlOjn2Mv2cfvtwzds
	 2cdLurU18gXDKZ67PcJuUAH3ILa/cck5H2Rc1N/11ai1tWacsqbys5Xm7WlgPWuIeF
	 n97wKpW6l4dt5W8+uU+SMEmRsHATSKnUOoZvh09OJYECof95D6fZqbchtisvg9+9YF
	 Vyudk8jSkCZNScoqnHXmOOMHC9KgaWu1LX0+xkgNNkxhk16lGOrnHiXQ0Qqi2qGkts
	 W/hZ+/+b5y7tg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C05DB42BFE;
	Mon, 14 Oct 2024 16:16:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pengyu Zhang <zpenya1314@gmail.com>
Cc: rppt@kernel.org, linus.walleij@linaro.org, fmdefrancesco@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com, Pengyu Zhang <zpenya1314@gmail.com>
Subject: Re: [PATCH v2] Docs/mm: Fix a mistake for pfn in page_tables.rst
In-Reply-To: <20241009144135.12453-1-zpenya1314@gmail.com>
References: <20241009144135.12453-1-zpenya1314@gmail.com>
Date: Mon, 14 Oct 2024 10:16:10 -0600
Message-ID: <87msj6slrp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pengyu Zhang <zpenya1314@gmail.com> writes:

> The documentation incorrectly calculate the pfn value as 0x3fffff,
> which should be 0x3ffff instead. It is obtained by right-shifting
> 0xffffc000 by 14 bits.
>
> This patch corrects the value to prevent any potential confusion
> for developers referencing this document.
>
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
> ---
>  Documentation/mm/page_tables.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
> index be47b192a596..e7c69cc32493 100644
> --- a/Documentation/mm/page_tables.rst
> +++ b/Documentation/mm/page_tables.rst
> @@ -29,7 +29,7 @@ address.
>  With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
>  address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
>  and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
> -at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
> +at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
>  

Applied, thanks.

For future reference, when you submit an updated version of a patch,
please make a note of what has changed below the "---" line.  Also, you
didn't pick up Mike's Reviewed-by from the first version; I've added it.

Thanks,

jon

