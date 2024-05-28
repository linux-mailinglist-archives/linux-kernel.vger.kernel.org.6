Return-Path: <linux-kernel+bounces-192161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26478D194F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6231F23305
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0316C690;
	Tue, 28 May 2024 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Qm8HQ2lM"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF64154BF8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895333; cv=none; b=jzGAK5qXohBpTFVasgPA0YNG2S1i3BEknRUMlmVr9xtuDja8VutDn5fZKAmMRTkqQ3DtVaPz+ha608TO6wiETigD5SScr0y5k5aIVdn5Exvwu8dX6z5pXJUU8nX6kj5dmQMPPRnKzzImgZa2Cgf6WibbW6T72MAa8OJPaGyqBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895333; c=relaxed/simple;
	bh=P0Mx1FLXShH0Z5GfwxF5/6SGn4uCtX3vBpArnfROkcY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C06+Xmnr98pk9uRX5bzZm8pME9KHOcsMN1Kk8sAPVNC84xB9TllCgx/8Pt/ZG3SKNityJXvIKZz94zAuGJ82vlfcJ9P7MJqOgE0dI3/7CeqaUBVt3dKnL8atwzXjUElB+NOAp2aFWpIbx32MoJmdByv0pp7oNjgDS5SJ21cjdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Qm8HQ2lM; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id BsJRshTOcSqshBuu3sXJpf; Tue, 28 May 2024 11:22:03 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Buu2s1gTwCaXoBuu2sjQmM; Tue, 28 May 2024 11:22:02 +0000
X-Authority-Analysis: v=2.4 cv=deBL3mXe c=1 sm=1 tr=0 ts=6655be5a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=PHq6YzTAAAAA:8 a=HaFmDPmJAAAA:8 a=HUZBgE9acwSnwOzeVl8A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=nlm17XC03S6CtCLSeiRr:22
 a=ZKzU8r6zoKMcqsNulkmm:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hw6FK+OS+RQG3VzJoQxH+zcl7pjy/9p2BHbiD1a6ayA=; b=Qm8HQ2lM9suyzWh9uYKVG9BMGy
	CyiD3PoFh/66CXhFbxY4RD//aYD6j3QstwcuUFJ0dFQVBNPy47D0eDt7My2tu8p5nR1nfBPfFh1y9
	woyFsBrY1vweaSLBgW3i9pwjtwuSPcXD1VMnNrmmSeuzxC8HDtPMVuY3kGxz0ntFdozcw/vAYKgpT
	uIxsre7QWqsuawjcfOjp0BlFGbP1qv4g9bp6kQvHwc9Khz2R+Lme+WWm+FvdtS3fVEANSHu8j9hc6
	2aE9WNK9Dex9cWKPcukdpohRD46Z61VQQZIUoVCQt6wAdrwDRoeylOaHSA9jJaTvkbZP60PG9ONl9
	VyLld57w==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:40542 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sBuu1-002oBt-0z;
	Tue, 28 May 2024 05:22:01 -0600
Subject: Re: [PATCH] clk: clkdev: don't fail clkdev_alloc() if over-sized
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-clk@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Guenter Roeck <linux@roeck-us.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>,
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 regressions@lists.linux.dev
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
 <E1sBrzn-00E8GK-Ue@rmk-PC.armlinux.org.uk>
From: Ron Economos <re@w6rz.net>
Message-ID: <37dae7f1-d11c-2793-796b-822cbc3d7a31@w6rz.net>
Date: Tue, 28 May 2024 04:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E1sBrzn-00E8GK-Ue@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1sBuu1-002oBt-0z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:40542
X-Source-Auth: re@w6rz.net
X-Email-Count: 13
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMYjZzJSysPVWOvqYeGyCEmEAF33swXTL5mIk2/7ErR2kp7wWM/nNlBTBJh0WovfQLEy6li+UJ0QPMe4Ln/WgDmJQVhtwKkm2wAS3ch7SlpsMo1YnLX4
 3089FPUr1ABUTu977NkISO7+edvbU2GCVJBR8jpb0eHUckpUTh4g6oUHlZn/FW9atPkHe1z7zI4qpO2qIhyxb9GnamPBPcWUuMk=

On 5/28/24 1:15 AM, Russell King (Oracle) wrote:
> Don't fail clkdev_alloc() if the strings are over-sized. In this case,
> the entry will not match during lookup, so its useless. However, since
> code fails if we return NULL leading to boot failure, return a dummy
> entry with the connection and device IDs set to "bad".
>
> Leave the warning so these problems can be found, and the useless
> wasteful clkdev registrations removed.
>
> Fixes: 8d532528ff6a ("clkdev: report over-sized strings when creating clkdev entries")
> Closes: https://lore.kernel.org/linux-clk/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net.
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>
> Please try this patch, which should allow the platform to boot, bit will
> intentionally issue lots of warnings. There is a separate patch posted
> recently that removes the useless registration with clkdev.
>
>   drivers/clk/clkdev.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 6a77d7e201a9..2f83fb97c6fb 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -204,8 +204,15 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
>   	pr_err("%pV:%s: %s ID is greater than %zu\n",
>   	       &vaf, con_id, failure, max_size);
>   	va_end(ap_copy);
> -	kfree(cla);
> -	return NULL;
> +
> +	/*
> +	 * Don't fail in this case, but as the entry won't ever match just
> +	 * fill it with something that also won't match.
> +	 */
> +	strscpy(cla->con_id, "bad", sizeof(cla->con_id));
> +	strscpy(cla->dev_id, "bad", sizeof(cla->dev_id));
> +
> +	return &cla->cl;
>   }
>   
>   static struct clk_lookup *

Works good. Here's what it looks like on HiFive Unmatched.

[0.389138] riscv-plic c000000.interrupt-controller: mapped 69 interrupts 
with 4 handlers for 9 contexts.
[0.390710] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[0.392743] 10000000.clock-controller:corepll: device ID is greater than 24
[0.392792] 10000000.clock-controller:ddrpll: device ID is greater than 24
[0.392820] 10000000.clock-controller:gemgxlpll: device ID is greater 
than 24
[0.392847] 10000000.clock-controller:dvfscorepll: device ID is greater 
than 24
[0.392876] 10000000.clock-controller:hfpclkpll: device ID is greater 
than 24
[0.392903] 10000000.clock-controller:cltxpll: device ID is greater than 24
[0.392929] 10000000.clock-controller:tlclk: device ID is greater than 24
[0.392955] 10000000.clock-controller:pclk: device ID is greater than 24
[0.392981] 10000000.clock-controller:pcie_aux: device ID is greater than 24
[0.394620] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[0.413222] SuperH (H)SCI(F) driver initialized

Tested-by: Ron Economos <re@w6rz.net>


