Return-Path: <linux-kernel+bounces-277314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9FE949F29
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFE81C20DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE5192B8D;
	Wed,  7 Aug 2024 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LVutFsMh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6441922CD;
	Wed,  7 Aug 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008403; cv=none; b=AS7YshuyEjH2hJNf31l0v832G2nb0bsVhQdlvn4gAAspxJ8HVL+pesNzkJDB00HRXMkcw8AQzpHVnbaaR25i4v+k09yfq/mh+sqWI4WJdLdED5HZ7x0nN6vNLtbqVga/pXGTJbjPOHSHCiToqR62TBUgR2usmhUpP/4JtDVZSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008403; c=relaxed/simple;
	bh=NmcnngzeLDtpQOLg7NFFazf8/hMMDWNHs6ZElkXjvAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Glb3pkxKwPZrBIulX02eWmkOQkZn3vtReG3Xj7XfENQDsW1uw7JC2/79lA1XZYw6t8Tu33qkCwCcSzzh6wHV2L31JUSYIyEzUcUYIWRZIXcNiIdJIiVnn+sfKP3PGJafraZZS5XDiXmyXTfUKqaltuH9NsKo+n3YsLOcGp4qfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LVutFsMh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4775QUcG107470;
	Wed, 7 Aug 2024 00:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723008390;
	bh=tg52rkz2WFEcqAbf2aTDLAV72PSYlrhhqlWbO4/cC6E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LVutFsMhhOvL54ixIJKPgyTM4CbsGsRiIEU0N3ziIm1r6ooj2A8szrhWt94pqMIT8
	 xh8oiGYcW/rAqX+hgm76MCZLpBzrzY/o/XFJLEFC4WYtCaBdPX/meE4kkB2vsvx4m+
	 AdgivU7prZcGrgiV4h8/f+vEoWDxAKgF2TutU4z0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4775QUqP124427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 00:26:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 00:26:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 00:26:29 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4775QSg5011554;
	Wed, 7 Aug 2024 00:26:29 -0500
Date: Wed, 7 Aug 2024 10:56:28 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240807052628.jclbmw4zs72jm6km@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806150700.uw4xdanjr4ypdvm3@rasping>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 10:07-20240806, Nishanth Menon wrote:
> On 09:43-20240806, Andrew Davis wrote:
> > On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > > utilise them.
> > 
> > U-Boot? Let's try to pretend like this is a generic property and
> > just say "bootloader" :)
> > > @@ -445,6 +446,7 @@ flash@0 {
> > >   		cdns,tchsh-ns = <60>;
> > >   		cdns,tslch-ns = <60>;
> > >   		cdns,read-delay = <4>;
> > > +		bootph-all;
> 
> Here and elsewhere, follow:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

Could you tell me what are you seeing wrong? The dts-coding-style that
you shared doesn't tell a specific location for bootph-* properties so
using the generic reasoning.

"1. Most important properties start the node: compatible then bus addressing to
   match unit address."

This is the least important property considering Linux and hence the
reasoning was that it should come in the last. Also, j722s and am62p
follow the same convention so it was taken from there only.

Regards,
Manorit

> 
> 
> > >   	};
> > >   };
> > > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

