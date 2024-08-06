Return-Path: <linux-kernel+bounces-276504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553DC9494B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31201F258E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9543156;
	Tue,  6 Aug 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lIa5yPq7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA93FB30
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958763; cv=none; b=Qz9HcyU7axVXo3IJJXKAcFR3D35DXFDtkrL+Ou3pcAtAMxrhCFUVjGQxgIAMiFjBznAP34iGfp9vzNTDDBFAMKsVaQz5ulf2227edY1Z6HPX7WZQh3Kt0l4FecNhtQ3TsrhSEwXnVN5TKbhgDKpQDOQIVsue7u97HYmuPPdHFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958763; c=relaxed/simple;
	bh=tkpAoD7kUeZuje2mJc9H5rGufhlXIKBMgSJyJCVyqEE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFRYIzYTY1OQIUM6yKWhBaaCddtkbQ3uPVhr6pt2PHJJXSdzSmwzHBITvjpSZ9o3K/g0zSHsWQI42/GlEvJnZcy+KA9BnJFWZ0N8dCKQd/7ec6+9yAUos2mfPJsLaqSztdWYF37YBylPMI0C0kos5wVEUGkwTV90jD1NBdmjtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lIa5yPq7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476FdD71097666;
	Tue, 6 Aug 2024 10:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722958753;
	bh=493QlqllTK4asevKGpWT91qeIbSWuou5nw9FbudkgSM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=lIa5yPq7+Ec9r6K0UYBbNfsHlRgoCL4+YYOrrvMgsb+d67NZL0pgZUodbwM44GQWu
	 qWuHKOULFMF1DS+UI5kc1GF9svXZE2QCeNFCSaODDxr0Zfg2MEKMRZpRBjCrcoC/Fh
	 AFhMfOlqgCznbSk4jPCuo1OumRpklvcAGPVx52hA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476FdDS7046593
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 10:39:13 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 10:39:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 10:39:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476FdCqt035437;
	Tue, 6 Aug 2024 10:39:12 -0500
Date: Tue, 6 Aug 2024 10:39:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        "Dhruva Gole" <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Georgi Vlaev
	<g-vlaev@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v8 1/3] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240806153912.sqsirnic5eb7witi@unsealed>
References: <20240801195422.2296347-1-msp@baylibre.com>
 <20240801195422.2296347-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801195422.2296347-2-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:54-20240801, Markus Schneider-Pargmann wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
[...]

> +	pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;

did you miss populating the rest of the pm ops?
	See https://lore.kernel.org/all/202408031302.28NpPykP-lkp@intel.com/

It might be better to introduce the APIs one at a time?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

