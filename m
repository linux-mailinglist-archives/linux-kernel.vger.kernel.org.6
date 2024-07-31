Return-Path: <linux-kernel+bounces-269050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB6942CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BDE1C21B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2C1AD9D0;
	Wed, 31 Jul 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n2svMXA2"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57EB1AD9CC;
	Wed, 31 Jul 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423990; cv=none; b=Dkr+7M6AEW5zihsTWrGSzWzOG+P2hCGYvr1pP/dWQgbd1CYrVyiQL79mHxSRHhhMpBnMTm/HBbJhRX7q8JtOldbHyWB7zxUKEe3Db17gnIQXXb8FcgPnNWZwW8E7GoAJakAem4TCjrdt/xQlDXNwnbR1QNg48Ifox+f+QmrVQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423990; c=relaxed/simple;
	bh=qqW9ROasfxzULXDNJwyTDYNkw7xA3mV3jd708Uieyzw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM4XNtplseCLOU9FlfnIxUknKAbrKBluAQk9Tb1U+lYtGUwMnCRQQITUqMkUQjD4UlwDELxT/UAmvXXi6LMWGtmmkrmFAAOvt7bv/stlJ2PO2kdHi0quoH9vKELbalMrEAGYRaxZnpq0xDKkn7ccIEhc9MqmII3iBVvlK++ooK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n2svMXA2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VB68qC003152;
	Wed, 31 Jul 2024 06:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722423968;
	bh=sD6Gjm9intqNxvtkmvWoqH3mQKI1C0bFkBqLXlQoiwU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=n2svMXA2ZKvooYScysFjujLAigj8+Fj2SdKJ0tpMReUL98UZF3LjKtzNGA+Qv0hIK
	 UKU9J0X36JZGfFAntWTLNAMTGYK+MavG+gMYu0gCoFB7OxItV1xNT4/ybB6A36KCmq
	 /aHfFefvYDflhGxQPAnH9JfPZxphtsRDq7kI3YE0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VB68es020021
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 06:06:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 06:06:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 06:06:07 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VB67Uk115008;
	Wed, 31 Jul 2024 06:06:07 -0500
Date: Wed, 31 Jul 2024 06:06:07 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Introduce J742S2 SoC family
Message-ID: <20240731110607.7fb42mgcsf2apodv@unshaven>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
 <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:49-20240731, Manorit Chawdhry wrote:
> > > + */
> > > +
> > > +#include "k3-j784s4.dtsi"
> > > +
> > > +/ {
> > > +	model = "Texas Instruments K3 J742S2 SoC";
> > > +	compatible = "ti,j742s2";
> > > +
> > > +	cpus {
> > > +		cpu-map {
> > > +			/delete-node/ cluster1;
> > > +		};
> > > +	};
> > > +
> > > +	/delete-node/ cpu4;
> > > +	/delete-node/ cpu5;
> > > +	/delete-node/ cpu6;
> > > +	/delete-node/ cpu7;
> > 
> > I suggest refactoring by renaming the dtsi files as common and split out
> > j784s4 similar to j722s/am62p rather than using /delete-node/
> > 
> 
> I don't mind the suggestion Nishanth if there is a reason behind it.
> Could you tell why we should not be using /delete-node/? 
> 

Maintenance, readability and sustenance are the reasons. This is a
optimized die. It will end up having it's own changes in property
and integration details. While reuse is necessary, modifying the
properties with overrides and /delete-nodes/ creates maintenance
challenges down the road. We already went down this road with am62p
reuse with j722s, and eventually determined split and reuse is the
best option. See [1] for additional guidance.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n189

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

