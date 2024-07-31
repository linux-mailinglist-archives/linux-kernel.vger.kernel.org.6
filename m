Return-Path: <linux-kernel+bounces-269408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF06943288
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88411C20AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697F1BBBEA;
	Wed, 31 Jul 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IaUvdhIF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807E186E4F;
	Wed, 31 Jul 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437900; cv=none; b=K6S+LDCk/8vKTiWbc7VJOz02V9FHzYOuXsZl8YHt8AYgrYUm/8YKl9sNGmI9ScC1+8GiwdxBu+Eleoi74MAmm5jvUcPxuMkYGyitVBlp3tQSi8ciRRt8YCOcIAkWWz7h2Bm4Y7DLJTSiT94+1n3T5nzBi9tDDeDuAxZiaN4hyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437900; c=relaxed/simple;
	bh=gRxptiPpJoMbRFyIMNoXDXxeINftFgTK635awdM4nZg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyZj3arFOuWQhbDkLkwF91AdBtuRkqSphT/qAYYJGlhrzCIcBiidGXtv24Q7s5lCPWY7ezHK9wpszIbbTMFCILODGSD98Q1W7Pr+YOdu7Kez5c4Nv2vNpLweqt+52s32Q9muTdufAtTZUTN5em9C3L/bMS5MmSF/avGUtXF6wow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IaUvdhIF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VEwClG056748;
	Wed, 31 Jul 2024 09:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722437892;
	bh=wWfWjYfY1LUP58W0JQcL+f/TU7wLTX3//5xKhnoI6tw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IaUvdhIFlJ6oqiEahWA0zZuE1X2KpUsSerAQeIs4S/EVzijL8HdvfMn6+qJ7lwtvx
	 sg5DfcAXOECWF8XnRy4LKYYwyTJ6USdIvxpat4NGTW92ENo1WSirIgC54IL1BmZOT/
	 vRScP+FiYeOhGcNAweuZnSw4iKl4SZbuRKIwejbA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VEwCQc049240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 09:58:12 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 09:58:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 09:58:11 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VEwACd095111;
	Wed, 31 Jul 2024 09:58:11 -0500
Date: Wed, 31 Jul 2024 20:28:10 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
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
Message-ID: <20240731145810.xoxal3ef7i3relru@uda0497581>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
 <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
 <20240731110607.7fb42mgcsf2apodv@unshaven>
 <20240731135714.p53lki7mihzxcyk2@uda0497581>
 <087ee9e2-50ec-4791-a534-b3ebbf594fe6@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <087ee9e2-50ec-4791-a534-b3ebbf594fe6@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 09:37-20240731, Andrew Davis wrote:
> On 7/31/24 8:57 AM, Manorit Chawdhry wrote:
> > Hi Nishanth,
> > 
> > On 06:06-20240731, Nishanth Menon wrote:
> > > On 09:49-20240731, Manorit Chawdhry wrote:
> > > > > > + */
> > > > > > +
> > > > > > +#include "k3-j784s4.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +	model = "Texas Instruments K3 J742S2 SoC";
> > > > > > +	compatible = "ti,j742s2";
> > > > > > +
> > > > > > +	cpus {
> > > > > > +		cpu-map {
> > > > > > +			/delete-node/ cluster1;
> > > > > > +		};
> > > > > > +	};
> > > > > > +
> > > > > > +	/delete-node/ cpu4;
> > > > > > +	/delete-node/ cpu5;
> > > > > > +	/delete-node/ cpu6;
> > > > > > +	/delete-node/ cpu7;
> > > > > 
> > > > > I suggest refactoring by renaming the dtsi files as common and split out
> > > > > j784s4 similar to j722s/am62p rather than using /delete-node/
> > > > > 
> > > > 
> > > > I don't mind the suggestion Nishanth if there is a reason behind it.
> > > > Could you tell why we should not be using /delete-node/?
> > > > 
> > > 
> > > Maintenance, readability and sustenance are the reasons. This is a
> > > optimized die. It will end up having it's own changes in property
> > > and integration details. While reuse is necessary, modifying the
> > > properties with overrides and /delete-nodes/ creates maintenance
> > > challenges down the road. We already went down this road with am62p
> > > reuse with j722s, and eventually determined split and reuse is the
> > > best option. See [1] for additional guidance.
> > > 
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n189
> > 
> > Thank you for giving some reasoning, would do the needful!
> > 
> 
> This refactor will require some interesting naming for the
> common SoC files. Based on your name for the EVM, I'm guessing
> you will go with

One other reason I was trying to avoid that and going with
/delete-node/. For such a small delta change tbh, this churn doesn't
feel worth the effort to me and is just gonna create confusion.

EVM one was required as Rob did raise an interesting point and we did
require a soc file that wasn't existing with the previous patchset but
now for deleting just 4 cpus and 1 dsp, am gonna have to rename all the
files, change the hierarchical structure, add all the cpus again with
some weird naming for the file as don't know if some other soc is gonna
come up in future so don't wanna clutter the file names as well with
j784s4-j742s2-j7xxx.dtsi which is just gonna create another set of mess
in future.

Regards,
Manorit

> 
> k3-j784s4-common.dtsi
> 
> included from the real k3-j784s4.dtsi and the new k3-j742s2.dtsi?
> 
> Too bad the Jacinto SoC names don't use a hierarchical naming. :(
> 
> J7<family><part><spin><etc>..
> 
> Andrew
> 
> > Regards,
> > Manorit
> > 
> > > 
> > > -- 
> > > Regards,
> > > Nishanth Menon
> > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> > 

