Return-Path: <linux-kernel+bounces-211774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496709056A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D5F1F24DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3917F517;
	Wed, 12 Jun 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XuNsj3YH"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B017A931;
	Wed, 12 Jun 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205289; cv=none; b=qDgJMGzqQJhNluSx+KEMf5A+7oyZMA4LyADtcB4gerkiZPJGIUYZ+YVZxhS4lI7xYkYwAiCD1gjYvApc26ZibgbUm7D4EyVeOJIX1rrL+Uu8D2wV+iahlkPzJSwsSlkv3YScUYtib273SnIEMdwxvPnc2VaMKfFrCtRxiTF+EwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205289; c=relaxed/simple;
	bh=F0oobLlGKnFr+fG6VaYDMjL+pyaTnFN3hWXrY/RnodU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BUwCZktHc/ofuGWnKIqkoVpRGGNgiEXLdlXCkRM35oAi0AggHUQBDCDTZPQgnxpe+qIYTak4a9IZKJmDFpdMKOna3Sx8WZP6Bzy2WSZ+ufop7Bc/i0udb0yz+jprsARHzIJICpH70Sor8xdfRyLJFhsn3SfMQmvk0niwTiwa190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XuNsj3YH; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CFEZfk114948;
	Wed, 12 Jun 2024 10:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718205275;
	bh=SOp7ioaeTnSBAJsPInMdghcr+7PCNHH0J+fTQkyCoDE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XuNsj3YHif5sszjIAx0TFdeSToNMfzdvXQVoHXmBDplJf5ftWAHyWGJkRWCG3XWKz
	 lWpZ/o6AGJlDAEvYDwcTKMLfRpzj4Esl5XG41KRTPdSUVK8oTivrNUdLxoH36dKh6N
	 3QXpQe2pledCkwZOiM9CR4p824COuUthmAQDd/78=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CFEZFS001763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:14:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 10:14:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 10:14:35 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CFEY2B106064;
	Wed, 12 Jun 2024 10:14:34 -0500
Message-ID: <864eefde-61b9-461d-a003-f2ebb9627b51@ti.com>
Date: Wed, 12 Jun 2024 10:14:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: ARM: nspire: add Krzysztof Kozlowski as
 maintainer
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arm@kernel.org>, <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof
 Johansson <olof@lixom.net>
CC: Daniel Tang <dt.tangr@gmail.com>
References: <20240612141740.8470-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240612141740.8470-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/12/24 9:17 AM, Krzysztof Kozlowski wrote:
> Apparently there was never a maintainers entry for the ARM Texas
> Instruments Nspire SoC, thus patches end up nowhere.  Add such entry,
> because even if platform is orphaned and on its way out of the kernel,
> it is nice to take patches if someone sends something.
> 
> I do not plan to actively support/maintain Nspire platform but I can
> take odd fixes now and then.
> 
> Cc: Daniel Tang <dt.tangr@gmail.com>
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 647233a62f50..4b262cb060b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3048,6 +3048,15 @@ F:	Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>   F:	arch/arm64/boot/dts/ti/Makefile
>   F:	arch/arm64/boot/dts/ti/k3-*
>   
> +ARM/TEXAS INSTRUMENTS NSPIRE ARCHITECTURE
> +M:	Krzysztof Kozlowski <krzk@kernel.org>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/*/*/ti,nspire*
> +F:	Documentation/devicetree/bindings/*/ti,nspire*
> +F:	Documentation/devicetree/bindings/arm/ti/nspire.yaml
> +F:	arch/arm/boot/dts/nspire/
> +
>   ARM/TOSHIBA VISCONTI ARCHITECTURE
>   M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

