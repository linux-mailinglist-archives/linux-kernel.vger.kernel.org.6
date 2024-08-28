Return-Path: <linux-kernel+bounces-305391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1A962DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8203B22A68
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462841A705E;
	Wed, 28 Aug 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mYG2kvwE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D481A4F1A;
	Wed, 28 Aug 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864405; cv=none; b=dvPmP7ja/sRloFaMe+P9FuYLhgmu02RoGCnpz2CAHRkGNU8eQJ7pEPZoZLv7B3XZ4ST+i0aKkvymuhNK4oao5UpU5PMKUfyGOvrQhD6vSOrmfUL0szh8oXJF1kAS7lQnpLYzdp/FNPHhgkFhgVAYC7jPvnOEsUErbVEpTpQMe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864405; c=relaxed/simple;
	bh=kEsPKUR2T+Ch4/rin+qLVKFxP+TWUI9hktFf9GxDYGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bySplWseXzfEr+HMhfEJuaGJc9s4HiuoF2F8sKlrV/WK0bMJxKr8LWBBX41OhgWzEaB1SlJWh1U2Wx8VgxXrT27lSu2pPGUeRbzAcQexIrUQOBMYoLYMKD3nzV4Hk07VPDAr5DACdJWLmpd9BrC9aSEIKvdhzuADiMq4NEAM4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mYG2kvwE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SGxsN0069441;
	Wed, 28 Aug 2024 11:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724864394;
	bh=yCu3p6k7jYdq0sC+LK3TcbQgS0qZfJnmMCl1ItmtqWY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mYG2kvwEsWVFGSsze5CkQuYVi1FPhMb3OlNpGHDRxM8g1rfCiuG9DMLyepJponl7a
	 0dFkbIT+/xmUpWklW1QNp4pFTpcXNYUOXYxCO8+O9oRfcPEYsDrYz3ud5qE4dOz95h
	 j/P0+e5uimIsNIeYFB7MCrvJj3/6HmUGA9LnACYs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SGxsFn004449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 11:59:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 11:59:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 11:59:54 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SGxsHE027680;
	Wed, 28 Aug 2024 11:59:54 -0500
Date: Wed, 28 Aug 2024 11:59:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>,
        Drew
 Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
Message-ID: <20240828165954.4d2uf65khni7rlr5@uncurled>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com>
 <20240824184415.o7ehjqm523igqbbi@cornhusk>
 <CAOCHtYiap7JzwEXZ3aHDC+yhXEdoJuyb+q-sZAmbMENHCjtvUw@mail.gmail.com>
 <CAOCHtYg8DTuGncoxKPvTOyKvGrF-zNMwVvKcNWzRHxT5Hvt7nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOCHtYg8DTuGncoxKPvTOyKvGrF-zNMwVvKcNWzRHxT5Hvt7nw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:34-20240828, Robert Nelson wrote:
[...]
> 
> /builds/RobertCNelson/arm64-multiplatform/KERNEL/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb:
> leds: led-0:linux,default-trigger: 'oneOf' conditional failed, one
> must be fixed:
> 'off' is not one of ['backlight', 'default-on', 'heartbeat',
> 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern',
> 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash',
> 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget',
> 'usb-host', 'usbport']
> 
> I guess, 'none' is close... off/etc..
> 

I'd just suggest to drop the property since you already use heartbeat.

Also function = is alternate option, if you choose to go down the road
of enabling a function

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/leds/common.h#n77

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/common.yaml#n83


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

