Return-Path: <linux-kernel+bounces-551953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7BA57356
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5AF167C30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95443241681;
	Fri,  7 Mar 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LgtImZ6P"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC6187346
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381648; cv=none; b=qOa47sUoRYjoljMQ+6EFt3YLDw781Z3P1PxV06HunC8TKxLXGddlc0z5vwlM04QrCEiezRTKngXdktjbv0sbBNlUIbiAa9wLivdtIOYGT376YtubzoV/xeij2A/8LbdmCK3mxYpE2O4qmudzvTnNPQEwbn/xcSwU531xB9XY4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381648; c=relaxed/simple;
	bh=mfc9+GTLoo1yTtpgXE+CVeqqGU7QJxRNaoF+3JJi8Q8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyLdnwV+gF/Sp/b0i90HO3uWVruJdc2me84wllWK7YaW2H9G8nsewwCCARD1atBUHWw1oJXegxftfA6tUSxfzjHRx2D3l0MPpkKaw9yMAB7s3xSoazs0wHFcKSGUDLe3MmJQVEJsRtw0WNcpcjjGP50NDoUEmWNxM3Tq4XkntZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LgtImZ6P; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527L5I3d470773
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 15:05:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741381518;
	bh=FeEwuvSmJVjOwYwC7OOMZQogVIzR26V0QCyL3wtTDCI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LgtImZ6PWDpbrLsguI0JTTA5qTFisk03bQ6XoaZwwNL9dUhNFXCnY7QzKBuN71GA/
	 77C0ZWpRfnz/hlfoHaHXNSuWfHweGaftqS56xPMsDaV4V9qOt5WxE8aXe106hZXDWc
	 xaKGHLCvK9o8ZoYZSly8DuHg7ugEp/9WedPI16FQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527L5Itd081080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 15:05:18 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 15:05:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 15:05:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527L5HQl128276;
	Fri, 7 Mar 2025 15:05:17 -0600
Date: Fri, 7 Mar 2025 15:05:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Basharath Hussain Khaja <basharath@couthit.com>
CC: <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <pratheesh@ti.com>,
        <prajith@ti.com>, <vigneshr@ti.com>, <danishanwar@ti.com>,
        <praneeth@ti.com>, <srk@ti.com>, <rogerq@ti.com>, <afd@ti.com>,
        <krishna@couthit.com>, <pmohan@couthit.com>, <mohan@couthit.com>,
        <parvathi@couthit.com>, Kevin Hilman
	<khilman@baylibre.com>
Subject: Re: [PATCH v2 1/1] soc: ti: PRUSS OCP configuration
Message-ID: <20250307210517.5xjfc6wntcbj3s4k@precision>
References: <20250108125937.10604-1-basharath@couthit.com>
 <20250108125937.10604-2-basharath@couthit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250108125937.10604-2-basharath@couthit.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 18:29-20250108, Basharath Hussain Khaja wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Updates OCP master port configuration to enable memory access outside
> of the PRU-ICSS subsystem.
> 
> This set of changes configures PRUSS_SYSCFG.STANDBY_INIT bit either
> to enable or disable the OCP master ports (applicable only on SoCs
> using OCP interconnect like the OMAP family).
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>

On the verge of applying this patch, looking deeper, I noticed
drivers/bus/ti-sysc.c managing the sysc controls. infact, I wonder if
b2745d92bb015cc4454d4195c4ce6e2852db397e ("bus: ti-sysc: Add support
for PRUSS SYSC type") could be merged with this?


Could you say why drivers/bus/ti-sysc.c would'nt be the right solution?

Ccying Kevin if he has any ideas about this.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

