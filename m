Return-Path: <linux-kernel+bounces-269494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AC943372
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CD1C23FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AC1B581F;
	Wed, 31 Jul 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sJIUGo9D"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEEF171AA;
	Wed, 31 Jul 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440116; cv=none; b=FqPs31iOgAxMg5wyg9A3+QYT+VvEuEpAQzBtxohhI+3fH0K+6U6brR/qJZ1nsGHTXlVcTfB7zwOR/Gmw6QuUGAUSCSU19vrJrPUenSpEAthG5XwVA5U2hGHxezvtU4EJ94Smmk/qLtRL2GKlk4bKd6zQwJanSl31cnDQu3+lusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440116; c=relaxed/simple;
	bh=2l41MchfAIjHt4Bz76v0tD55VOiYm6bwIm/fPEV9z2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlAlUdKQoJ5LDGBq6ew4arB7XKGcVTAUJ7RKmWKwzK8TV9OhdHsL7yj7ivsHVF8T0QlYKOnK6qNcePwjJNA8D0gaDM1fC0fCn375AFFD2MmCt4Ozsu99KYi8z/F0+TMG0N7O6PC3IXMDcXAAV18mcGOinBx7dyG7j9HDjdWSuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sJIUGo9D; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VFYx5J091451;
	Wed, 31 Jul 2024 10:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722440099;
	bh=QIm6IrDV+gQOpmKk71pPzCWOhpAQbCEAy0F1Z+JymJo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sJIUGo9DO2bKYmokR3JKlSecUfhZDtFOFfMus+t0ui0IHzU9nhgbrX7VRECbf2PmV
	 mBp24WbXiEqLNMni9RNrtgZootWDKk6Ud85vnKlbuOrGJqLbZB8CK6KuSkMyT576+D
	 R680dEFsyTddlZQAXFkHMmLGtZmQ+cJZqysm6er4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VFYwlk056708
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 10:34:58 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 10:34:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 10:34:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VFYwNQ102431;
	Wed, 31 Jul 2024 10:34:58 -0500
Date: Wed, 31 Jul 2024 10:34:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Introduce J742S2 SoC family
Message-ID: <20240731153458.7o3i2xcjvn22igxa@squatted>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
 <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
 <20240731110607.7fb42mgcsf2apodv@unshaven>
 <20240731135714.p53lki7mihzxcyk2@uda0497581>
 <087ee9e2-50ec-4791-a534-b3ebbf594fe6@ti.com>
 <20240731145810.xoxal3ef7i3relru@uda0497581>
 <c6497a37-695b-45d8-b413-2b338e3f42a7@ti.com>
 <20240731151820.tf6tzgj2wrc5vh5j@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240731151820.tf6tzgj2wrc5vh5j@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 20:48-20240731, Manorit Chawdhry wrote:
[...]
> Yeah, was gonna go with that file only right now, but now would I have
> 
> - k3-j784s4-mcu-wakeup-common.dtsi ( this is not required at this stage,
> but ig for consistency better to now itself )
> - k3-j784s4-main-common.dtsi ( all dsps excluding c7x_3 )
> - k3-j784s4-thermal-common.dtsi ( not required again but consistency )
> - k3-j784s4-common.dtsi ( all this won't have the cpu but will have all
> 						  other ranges including for the last dsp and all )

We already use k3-am62p-j722s-common-main.dtsi so that people don't
ask what is this common to and track down via grep who is including
what. I'd rather us follow that convention for now that debate is done
with and integrated in master. I don't see a strong reason yet to change
the same. Again, everyone will have an subjective opinion, I prefer to
follow existing convention that is established on topics that are
cosmetic.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

