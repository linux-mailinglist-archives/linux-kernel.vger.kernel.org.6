Return-Path: <linux-kernel+bounces-309328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44D9668F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACEB2847AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613DA1BC9F4;
	Fri, 30 Aug 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CF+Cqugv"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A538136353;
	Fri, 30 Aug 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042637; cv=none; b=coCnS7VV6OECDTgjtB1DsnYVTjBSERJx/LmMmi5jIJfRiMLj9oCYUki/YaKESTT6icvW2pUwPULfGFJEPOkPnW6Dtn+f8cR5mmwxhCWBb/oyGw7ffAOciIBbys/EfIbeX9PR0FK4Dcur9p3zoz1eTBpEqSBd+tc9Jw6urCiYaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042637; c=relaxed/simple;
	bh=fH2Jp83DT0nnZfcR5go8oS1EOcfKbfB2+QGFbM+syNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PC+XeEy2VUSkxzzvGX0TtaecnDAvW3piC0+aQl2HicbNgx993wU3N5rIOOxaORpLQx4W3TlhnAVikBC9F+7bE+QsQ9yFLrMOHN3V30M3HjXSdTnQwam1kKskcL3oJHDqLNjrtmtsa0UdpT05dBbwlVU5nb08NMTjHrWa0WYP7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CF+Cqugv; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UIUPtk080819;
	Fri, 30 Aug 2024 13:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725042625;
	bh=jHEa1WSAt7/ZTUf0s7cB0K91wd9S8ZH92X+c2jpZJrA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CF+CqugvrGh6GSR/Vbimz6/+IxmKWqxEPavqnYDoLk37qyTaruajQz8e91gCBmJ20
	 3c2nnA/ynqW4oSMDof061W4fMjgmcnEc242bsc+S+I9u8C+bNrrlyRfQZlmfM4oNKh
	 jbiIkjDmafSJRDmBcjadA2bTTr2gAR6RQaw8g8iI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UIUPZX017362;
	Fri, 30 Aug 2024 13:30:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 13:30:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 13:30:24 -0500
Received: from [128.247.81.191] (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UIUOx5118074;
	Fri, 30 Aug 2024 13:30:24 -0500
Message-ID: <4c694d18-040f-4520-bce2-e56ab15f25f3@ti.com>
Date: Fri, 30 Aug 2024 13:30:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: ti: Add BeagleY-AI
To: Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrei Aldea
	<a-aldea@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
References: <20240829213929.48540-1-robertcnelson@gmail.com>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <20240829213929.48540-1-robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/29/24 16:39, Robert Nelson wrote:
> This board is based on ti,j722s family using the am67a variation.
>
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Tero Kristo <kristo@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Andrew Davis <afd@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Andrei Aldea <a-aldea@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>

Reviewed-by: Jared McArthur <j-mcarthur@ti.com>
-- 
Best,
Jared McArthur


