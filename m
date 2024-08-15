Return-Path: <linux-kernel+bounces-287926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC030952E48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545482843A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304D19E811;
	Thu, 15 Aug 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y8UTJgix"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85019DF8C;
	Thu, 15 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724990; cv=none; b=Ll6r8n6Rs3esniw675DORd6wiGfImpLtsmPobNhosuXkPmVdPAzk4q1CEtI/0gQ6llz/ZirC88/AUgdFfqF5V06HEJAQuRIQXO6e50xedh7LeLgY5e1c+GhNfSMVFHYgLbucdvuaXpY6pzZfVA9VVzz7BZq15UT+CVBNXCq4PkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724990; c=relaxed/simple;
	bh=VXG227f/PGcqZg6pKxOAl11n6MvqEeXAhYlXpkMCtmY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw+BYtEoH5TOJzoJ/KiNi/262mu6WclAgpACMVArf+isfQk6Egef07tORxhR+AJkXMsO43Z9JQdh8G4yCc2IlS2uJv1PmeIHASwR+GQ9MErWs2eJdseNVDmoeADzejSnB8ZnLfPxLLmDD0Q+RvPRTDuRWJ92e95TxvjOnG8DUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y8UTJgix; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FCTToj110761;
	Thu, 15 Aug 2024 07:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723724969;
	bh=vptO+iJw3hIRvfbJivAJR2nQ1WrRDHA5c8+ffEW6Tus=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Y8UTJgixFjp5dAXIL3+Es6vqJzAwoqDZUsya1qBOrvm9qdaC4AfayDNsTJlOeyhFn
	 QIxhLmD6jSTCjU7IvuXmHD1mJ7j0dxeI3K+GjYJBrFWC3hc3zzEHCJ0aN+CzVPIjpQ
	 oiHOKubUbM0pAJge8vQZ2ef9qozbSjg3RNEbj12o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FCTTot020998
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 07:29:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 07:29:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 07:29:28 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FCTSFC043957;
	Thu, 15 Aug 2024 07:29:28 -0500
Date: Thu, 15 Aug 2024 07:29:28 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, <devicetree@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>
Subject: Re: [PATCH v2 0/6] Add and fix ESM nodes
Message-ID: <20240815122928.4i2yob5aj5ssqhzw@reply>
References: <20240813230312.3289428-1-jm@ti.com>
 <4295a15a-6285-4005-bc40-328e52addc2b@siemens.com>
 <6134b3c1-f7ea-4cca-8777-56e5705aadf6@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6134b3c1-f7ea-4cca-8777-56e5705aadf6@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:59-20240814, Judith Mendez wrote:
> Hi Jan,
> 
> On 8/13/24 11:04 PM, Jan Kiszka wrote:
> > On 14.08.24 01:03, Judith Mendez wrote:
> > > The following patch adds ESM nodes and fixes ESM source
> > > interrupts for Sitara K3 platforms. Currently watchdog cannot
> > > reset the CPU because of misconfiguration or missing ESM node
> > > in DT.
> > > 
> > > ESM node was added for am62ax and am65x. For am62px ESM source
> > > interrupts are fixed. Comments were also added for clarity on what
> > > source interrupts are routed to ESM based on device TRM.
> > > 
> > > ESM nodes like MCU ESM for am65x are added for device completion,
> > > currently, some ESM0 events are not routed to MCU ESM, so watchdog
> > > cannot reset the CPU using the current implementation.
> > 
> > Yes, that's why there is https://github.com/siemens/k3-rti-wdt and
> > probably similar bits in other R5 firmware. I was always told that is
> > the only way to reset the /system/ (CPU alone would not help). That
> > information is still correct?
> 
> If you look at 9.4.14 MCU_ESM0 Interrupt Map, ESM0_ESM_INT_CFG_LVL_0,
> ESM0_ESM_INT_HI_LVL_0, and ESM0_ESM_INT_LOW_LVL_0 are not routed to
> MCU_ESM0. So the current implementation to route events from ESM0 to
> MCU_ESM0 to reset the CPU will not work for AM65x, this is the
> implementation on other K3 Sitara platforms and how watchdog can reset
> the cpu.
> 
> I did find MAIN_ESM_ERROR_INT which should be SOC_SAFETY_ERRORn, look
> at Figure 12-3690. Perhaps the ESMs could be configured to use
> SOC_SAFETY_ERRORn instead, not sure.
> 
> The above should apply to both SR1 and SR2 devices according to the TRM.

Thanks for clarifying - you should add that in the commit message.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

