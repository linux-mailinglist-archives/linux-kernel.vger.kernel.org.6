Return-Path: <linux-kernel+bounces-307685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B034E965160
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7AB283BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59318B497;
	Thu, 29 Aug 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ya/SEl5u"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59514A614;
	Thu, 29 Aug 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965654; cv=none; b=C1jwZKjdB4rnMaES/oxSDeAeAP3fko5CfsEMW93IyRg3PPkyWGSVFpDo91n0cAIRszO6yQOfAHNPMld6/hijVR0gEO79issWVpoOA07dY5Wt5fqqizkJshfDFARz8LnswZdf1UhTlYfHQ/oqovFgOz6PrtMKtjINyZEKmZMn4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965654; c=relaxed/simple;
	bh=TaivfIdjh0TSI85jNY77CELnXdBC7Jd65G6SlY8tMwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUXVXdJzG0fmWhGNq9bTGQ9i7rUldVjh7ptBmQeAToh4i7JE6zmnCraH6uYMF2/QW7MyyK6fADb7jH3ef/g5ERSKjIvNa7S8yFDihXqcPi6aBnyTbtTQBHqKle90W68AKEyEwyoQqip53Xad3IdNe9Cg1IbkGfJ71+MkvxRNd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ya/SEl5u; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TL7K1D123687;
	Thu, 29 Aug 2024 16:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724965640;
	bh=GzlXiTAHsbZukH7gUwsKWEWduTwBkldcsOPp8jNhcMA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ya/SEl5ut7pYXuzjdqqjyU5ShZdEFk8+drTKX/gyNHTP2ejrhPmMJr3BoF51ranPN
	 mg23HaPF8p+b8lPxUy0VYVc6vk5fvfTcPLjJHwQeH4+go8fC3hRH/rVQIhXrZadbQC
	 h+uKVRipNMW9KyDyXcBn6UusBJL2PHEFrYKXhRYw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TL7KeU036977
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 16:07:20 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 16:07:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 16:07:19 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TL7J06017255;
	Thu, 29 Aug 2024 16:07:19 -0500
Date: Thu, 29 Aug 2024 16:07:19 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/6] Add and fix ESM nodes
Message-ID: <20240829210719.ir3yubhdrzwg7mym@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240815204833.452132-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240815204833.452132-1-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On August 15, 2024 thus sayeth Judith Mendez:
> The following patch adds ESM nodes and fixes ESM source
> interrupts for Sitara K3 platforms. Currently watchdog cannot
> reset the CPU because of misconfiguration or missing ESM node
> in DT.
> 
> ESM node was added for am62ax and am65x. For am62px ESM source
> interrupts are fixed. Comments were also added for clarity on what
> source interrupts are routed to ESM based on device TRM.
> 
> ESM nodes like MCU ESM for am65x are added for device completion,
> currently, some ESM0 events are not routed to MCU ESM, so watchdog
> cannot reset the CPU using the current implementation.
> 
> Changes since v2:
> - Fix commit message for patch 6/6
> - cc linux-arm-kernel
> 
> Judith Mendez (5):
>   arm64: dts: ti: k3-am62a: Add ESM nodes
>   arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
>   arm64: dts: ti: k3-am62: Add comments to ESM nodes
>   arm64: dts: ti: k3-am64: Add more ESM interrupt sources
>   arm64: dts: ti: k3-am65: Add ESM nodes
> 
> Santhosh Kumar K (1):
>   arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM
> 

Thanks for sending these out Judith! 

For the series:

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

