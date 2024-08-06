Return-Path: <linux-kernel+bounces-276471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765C949434
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A6C1F26EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6C1EA0D1;
	Tue,  6 Aug 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NxOARqOs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695A41C72;
	Tue,  6 Aug 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956828; cv=none; b=ZJALmBZEMrWgzzXshOdbHe+QXDKo973l1CkwDpwGFo2Oh3Hlizfp2wpqBnpck2/f0cEbCWbm1FIOfH/J7fMZ4eToo7vrT41LAZzaBDV/LLpFI+XHcS8q1dgbDNegYezNMPImmWxOg7PbIT+UYlEXWJJIUIqXT8PaGlB+NjF+qI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956828; c=relaxed/simple;
	bh=E4T5iMgWla8u2bPDPyNq6jKw4BX8V6l0Y0+HoWrYLFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeN716bnbPO+PnqXaY1PXpqZmDdS4pO1cTqxrqOyDltuiuusS0LSGwnlTfM0wu2BTHi6fFhqPwAKuzmkd9G8MSInc/sItbHJsGcD/TFiQTqpx8JF3CFJilaH/eJ+LdabGY7teHKbN7JsyxLLPnDXGWZKUblzPT0n+tYdMOcW3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NxOARqOs; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476F71vU085165;
	Tue, 6 Aug 2024 10:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722956821;
	bh=ZcDXjPxu0CrzKFKZS0pqzSaM6z2Ugwz648cU4XeZ/lM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NxOARqOsS8dcvHVjHZ0qRzoGc2Ugzb0XGw5s+2w/q+p0StdGlxMwFi/eYdDEp2wwY
	 i0c9mW6zY46vzVuEtfraU7ACn5kywA5S0obgiOzLEjKrEqQABz+LA5R+kXMoHKPZVT
	 lEZmnU+ImxmClicsBdB+Fy1moKkDazF7IFXtYns4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476F71wV006159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 10:07:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 10:07:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 10:07:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476F70bb113834;
	Tue, 6 Aug 2024 10:07:00 -0500
Date: Tue, 6 Aug 2024 10:07:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240806150700.uw4xdanjr4ypdvm3@rasping>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:43-20240806, Andrew Davis wrote:
> On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > utilise them.
> 
> U-Boot? Let's try to pretend like this is a generic property and
> just say "bootloader" :)
> > @@ -445,6 +446,7 @@ flash@0 {
> >   		cdns,tchsh-ns = <60>;
> >   		cdns,tslch-ns = <60>;
> >   		cdns,read-delay = <4>;
> > +		bootph-all;

Here and elsewhere, follow:
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

> >   	};
> >   };
> > 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

