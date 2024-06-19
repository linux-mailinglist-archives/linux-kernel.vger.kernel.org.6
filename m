Return-Path: <linux-kernel+bounces-220491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7D90E273
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756D41F21BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64941E4A6;
	Wed, 19 Jun 2024 04:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZM46F3aX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316A55884;
	Wed, 19 Jun 2024 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718772792; cv=none; b=lK7+tTuDr6uTgR/nauVrdNF8MGXE/2NO5lZ2d5GTEYLXg/GVKWBkzu0kIZllYsvzXFlJST/bLVUYpWp9OBvHFSgQnweY/Gm48aRYqTRZCEVO5msP68Y0DY/L79kUIyD/aTK7pSD7FvJZn25J3OqDUpi0mJxYMDRR7gmW2Ab2vl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718772792; c=relaxed/simple;
	bh=lx4rLJyPej68BOmpr7+ocvYiPmWPWtwIPfezXOc0vP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnCo6BgDAVeQ+p29g2XeWsSg3NNV9r8+oWwWsN+0MYfni47kmJ6WgSpxqldyCJ1Q0M8oa1sVWMw21sdTXT0RHssw0R7VlDA+eXldqCrhJslEP6pzEEq42SHVyA/Q9bWZLHlOR/EJE9ZOzuLf02EvEI+gL1wKn/5nrax/qDrgXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZM46F3aX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45J4r0Fs026309;
	Tue, 18 Jun 2024 23:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718772780;
	bh=Rc7qJe4uEyOVn3qro5Eomd2bfcwDyg3lU37JTh3HO84=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ZM46F3aXZCyNlCOHHqj6ruWfStvtIZ0I0oagQ78iXdkrZpKO4NGuF2HoVEsDyAr36
	 5hCY/MOee5ivglzVaqN6D1OnOO8cl0gOF3twYDW6YPsDZIfdH2v5T5YrPEX1vMH9Ok
	 VfJPezd5W9furyfCDYXrw2UJM4j3Gny5tBK10xh4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45J4r0Xd023468
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 23:53:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 23:53:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 23:52:59 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45J4qxSg008198;
	Tue, 18 Jun 2024 23:52:59 -0500
Date: Wed, 19 Jun 2024 10:22:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-pinctrl: Define a generic GPIO
 MUX Mode
Message-ID: <20240619045258.xy4pwqv6ut5wzk63@dhruva>
References: <20240618173123.2592074-1-nm@ti.com>
 <20240618173123.2592074-2-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618173123.2592074-2-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On Jun 18, 2024 at 12:31:21 -0500, Nishanth Menon wrote:
> Introduce a GPIO mux mode macro for easier readability. All K3 devices
> use mux mode 7 to switch to GPIO mux.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 4cd2df467d0b..b1a0415e6611 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -38,6 +38,8 @@
>  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
>  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
>  
> +#define PIN_GPIO_MUX_MODE	(7)
> +

While I do agree that this is a standard thing, don't you think that
updating it everywhere else (k3 DTs) makes sense? Having the number 7 in some
places and others having PIN_GPIO_MUX_MODE will give rise to confusion I
feel.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

