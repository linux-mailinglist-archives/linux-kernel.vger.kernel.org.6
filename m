Return-Path: <linux-kernel+bounces-277838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B594A732
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D247E1F23E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769D1E4879;
	Wed,  7 Aug 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u9IPYufL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6244171E69;
	Wed,  7 Aug 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031396; cv=none; b=o4Ka3r3Bi2R7mMdmRY6SIlgpubaznq202uc2HW2l0f+t0YXiXFmvgrVBm6t6NGn/dLcmWo4Hf67wrqjb0rITG+u/UZhpP1xsdoEjPzlw+vWewrW+FFk5aiWSBFbjCCMDWuqugv96WyjA2HmxiMaWxWyURMlekgEHFkZ6+QsK7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031396; c=relaxed/simple;
	bh=lGdHNNk9h6XWZpvkVmYh8i6y2fcDCUpV6CobdiYtP2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFfcoapQfc4R+JQ4LBCxz/2pTHr/PGirGys3Z/ROPpoDbGSKWHHBTZ/8NOCApScIDn5COiLLqhnVvBuLzEWEnMGmer56M7D/2X2M4ATlKvW+OEYNIrvhZ9Eapl3/sv0qY89HYn2HJPExd/j91yn+cB6S0Lht1k5VSgF5Lrwxox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u9IPYufL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477BnlVW071665;
	Wed, 7 Aug 2024 06:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723031387;
	bh=M1Bcd1eXKm7KKW15MBceH1CEwN6f2fPzJ/u4GxXZU2E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=u9IPYufLnNzx3QQU7jvThUGsI9p9jAwyEIfms+UMAWpMNmvmwGCpg2JBnW2aDgwbb
	 uViptqyXPUZ8EH3FzeznmybOfmnSxJOaRPS1UECWNj5ivrJEGMGvOd/HXUjURRUGa+
	 Z5x4H9EeTz9aqm+IIWFwG3hYNXkZhXKpJ1+fD3Fs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477Bnljr058925
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 06:49:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 06:49:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 06:49:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477BnlFF109039;
	Wed, 7 Aug 2024 06:49:47 -0500
Date: Wed, 7 Aug 2024 06:49:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye
	<a-limaye@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240807114947.tvkpo4k2ggncxcce@scouts>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
 <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
 <20240807054243.pvfgexgusahe7d4x@uda0497581>
 <99da73bf-87a1-4402-9008-3d9076074d14@ti.com>
 <20240807063624.2pmqr5t7qx6elk5j@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807063624.2pmqr5t7qx6elk5j@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:06-20240807, Manorit Chawdhry wrote:
[...]

> > > > 
> > > > Not sure if this is what he meant, but bootph-* comes under standard/common
> > > > properties as per my understanding of the coding style. And status needs to
> > > > be at the very end if it's there (in this case it's not but just
> > > > mentioning).
> > > 
> > > I see status property being at the top of many nodes so I don't think
> > > it's even followed right now, with that reasoning, I don't think I can
> > > use that point for ordering the dt nodes. If it's under common nodes
> > > then also I think it's in the appropriate location considering that even
> > > in those properties it is the least important and should be coming in
> > > the last. If you see any problem with this node then please let me know
> > > in the ordering.
> > > 
> > 
> > Aren't cdns,-* vendor specific properties?
> > 
> > Also I understand that most DTS aren't following majority of the rules, but
> > considering it was a review comment I assume they want a check on what goes
> > in at least so I've mentioned what I think they're asking for.
> 
> I can fix it in places where it can be fixed ( I see few places where
> order exist ) but where there is no order there this will be difficult
> to handle. That'd require a total fix for ordering across all the places
> and that will require a separate cleanup ig. So if people are okay, in
> those places I'll be keeping bootph-* in the last like how it's followed
> in right now.

Just make sure that when new properties or nodes are introduced, follow
the convention. For new SoCs, this is mandatory for new nodes that are
introduced (not when renaming file etc).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

