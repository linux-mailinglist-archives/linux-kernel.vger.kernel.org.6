Return-Path: <linux-kernel+bounces-269461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7094330C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1D11C209E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5B1CAAC;
	Wed, 31 Jul 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJJ75reD"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F717741;
	Wed, 31 Jul 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439116; cv=none; b=cbF1kth5ZvQ7CDLQktLweToEN2Swn0cZcExtlBKwkVWSBNU0PgPWJ8Nj9bORwjYCglkKz/4/6KorJG3v6KekDd4XLh7Zpb1FfFOM25jaLsPaiJP4Y+CXygRXiBSti6cPRc4DIjCT1IUK+yk7NPRQwp9pQZzR3fI/tlabfbYHZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439116; c=relaxed/simple;
	bh=lAUgPsvmwcI5gDVQTdCGu1WnO/70naEh8fqJP0rlrd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN36QH9JNbxuqLA/3se5LxtO6rIf+PFurRArp3czwJ5JpQGn373T92hsIjoZEWRgzy8dmi8J7nktAqR8Cc0snDV9mPQ9p8OWr0DgDB17J97Ag3vW+8uf7l9HOeqNENOrusLgP5JrOu9+zN8pn9s/hiFYOFAkRTopPzVpkEhsgAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AJJ75reD; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VFIM3s082023;
	Wed, 31 Jul 2024 10:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722439102;
	bh=GKzPtifXeFUhvADnUjGHY8DqkpY6PksV+4ieiYc2giU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AJJ75reD3OgZOTwN0SmGjpV4+neBoE+XprN4SLaIvKnHwR+oic19wos/68BWHOGr5
	 9Y4j+R2Sg1GjAJKsL85LWdCGYRALwribBA2iuTRLAwM3RfHL7NVmzrCO2my9KZLmJp
	 sA6PG63uxT8TFoZGYWOvAR3qxz5Nrhy1y93j51Bs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VFIMbm019662
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 10:18:22 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 10:18:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 10:18:21 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VFIKWH077527;
	Wed, 31 Jul 2024 10:18:21 -0500
Date: Wed, 31 Jul 2024 20:48:20 +0530
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
Message-ID: <20240731151820.tf6tzgj2wrc5vh5j@uda0497581>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
 <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
 <20240731110607.7fb42mgcsf2apodv@unshaven>
 <20240731135714.p53lki7mihzxcyk2@uda0497581>
 <087ee9e2-50ec-4791-a534-b3ebbf594fe6@ti.com>
 <20240731145810.xoxal3ef7i3relru@uda0497581>
 <c6497a37-695b-45d8-b413-2b338e3f42a7@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6497a37-695b-45d8-b413-2b338e3f42a7@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 10:03-20240731, Andrew Davis wrote:
> On 7/31/24 9:58 AM, Manorit Chawdhry wrote:
> > Hi Andrew,
> > 
> > On 09:37-20240731, Andrew Davis wrote:
> > > On 7/31/24 8:57 AM, Manorit Chawdhry wrote:
> > > > Hi Nishanth,
> > > > 
> > > > On 06:06-20240731, Nishanth Menon wrote:
> > > > > On 09:49-20240731, Manorit Chawdhry wrote:
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include "k3-j784s4.dtsi"
> > > > > > > > +
> > > > > > > > +/ {
> > > > > > > > +	model = "Texas Instruments K3 J742S2 SoC";
> > > > > > > > +	compatible = "ti,j742s2";
> > > > > > > > +
> > > > > > > > +	cpus {
> > > > > > > > +		cpu-map {
> > > > > > > > +			/delete-node/ cluster1;
> > > > > > > > +		};
> > > > > > > > +	};
> > > > > > > > +
> > > > > > > > +	/delete-node/ cpu4;
> > > > > > > > +	/delete-node/ cpu5;
> > > > > > > > +	/delete-node/ cpu6;
> > > > > > > > +	/delete-node/ cpu7;
> > > > > > > 
> > > > > > > I suggest refactoring by renaming the dtsi files as common and split out
> > > > > > > j784s4 similar to j722s/am62p rather than using /delete-node/
> > > > > > > 
> > > > > > 
> > > > > > I don't mind the suggestion Nishanth if there is a reason behind it.
> > > > > > Could you tell why we should not be using /delete-node/?
> > > > > > 
> > > > > 
> > > > > Maintenance, readability and sustenance are the reasons. This is a
> > > > > optimized die. It will end up having it's own changes in property
> > > > > and integration details. While reuse is necessary, modifying the
> > > > > properties with overrides and /delete-nodes/ creates maintenance
> > > > > challenges down the road. We already went down this road with am62p
> > > > > reuse with j722s, and eventually determined split and reuse is the
> > > > > best option. See [1] for additional guidance.
> > > > > 
> > > > > 
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n189
> > > > 
> > > > Thank you for giving some reasoning, would do the needful!
> > > > 
> > > 
> > > This refactor will require some interesting naming for the
> > > common SoC files. Based on your name for the EVM, I'm guessing
> > > you will go with
> > 
> > One other reason I was trying to avoid that and going with
> > /delete-node/. For such a small delta change tbh, this churn doesn't
> > feel worth the effort to me and is just gonna create confusion.
> > 
> > EVM one was required as Rob did raise an interesting point and we did
> > require a soc file that wasn't existing with the previous patchset but
> > now for deleting just 4 cpus and 1 dsp, am gonna have to rename all the
> > files, change the hierarchical structure, add all the cpus again with
> > some weird naming for the file as don't know if some other soc is gonna
> > come up in future so don't wanna clutter the file names as well with
> > j784s4-j742s2-j7xxx.dtsi which is just gonna create another set of mess
> > in future.
> > 
> 
> Which is why I would suggesting getting the name picked and agreed on
> here before you start doing the renames (renames for .dtsi files are not
> a problem, only the final .dtb names seem to require stability as the
> bootloader tend to load them by name, and those are not changing)
> 
> What is wrong with just k3-j784s4-common.dtsi? All future spins of
> this base device can include from this file. Every spin doesn't need
> to be in the common file's name.

Yeah, was gonna go with that file only right now, but now would I have

- k3-j784s4-mcu-wakeup-common.dtsi ( this is not required at this stage,
but ig for consistency better to now itself )
- k3-j784s4-main-common.dtsi ( all dsps excluding c7x_3 )
- k3-j784s4-thermal-common.dtsi ( not required again but consistency )
- k3-j784s4-common.dtsi ( all this won't have the cpu but will have all
						  other ranges including for the last dsp and all )
- k3-j784s4.dtsi ( have 8 cores )
- k3-j784s4-main.dtsi ( have an additional dsp )
- k3-j742s2.dtsi ( have 4 cores )
- k3-j742s2-main.dtsi ( have firmware name overrides )

I do find it confusing while developing but mostly people would have to get
used to developing in common files and hoping that things should be
okay. 

Regards,
Manorit
> 
> Andrew
> 
> > Regards,
> > Manorit
> > 
> > > 
> > > k3-j784s4-common.dtsi
> > > 
> > > included from the real k3-j784s4.dtsi and the new k3-j742s2.dtsi?
> > > 
> > > Too bad the Jacinto SoC names don't use a hierarchical naming. :(
> > > 
> > > J7<family><part><spin><etc>..
> > > 
> > > Andrew
> > > 
> > > > Regards,
> > > > Manorit
> > > > 
> > > > > 
> > > > > -- 
> > > > > Regards,
> > > > > Nishanth Menon
> > > > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> > > > 

