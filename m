Return-Path: <linux-kernel+bounces-308031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96A1965655
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6691C22141
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503A1411C8;
	Fri, 30 Aug 2024 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jalR//3k"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46620EB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992539; cv=none; b=Ff9mSpoK4Kd0U2ksQdtfKG0GwJCEqfBXnVXWrnVCmHSMioEV/fk/kyAPQBeY2bDNy0zOpUGvnm6lQh5K4IDTRUwj6xR22E93JrlIxD3uXrMWGLJPfqvUsO69Jb+W1de6Y0vA5C0f5OW6JfAzwjC3/qaYao+GlRPlLY2fjIQKQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992539; c=relaxed/simple;
	bh=6lme29SUVZMNjUYQR2Bw9sMkdBAARlR/BG0mLAeJGto=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVsvPs8j1K9sIDPY3y0ZZHGw8kO+buvILekNMxF0yHqfifxNAtLhBjk9vNBwNX5y5cKiyJzDTtk/iuohtaZpinE7xO7+b9qG6YAYfE2/s+JVjd4sIH9Hty0kF0o0BJ4kg/JwE6G2IgYKP2sfnJ2dIvdPcuL0AlPZ7tZAYmw0Ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jalR//3k; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47U4ZUo3083552;
	Thu, 29 Aug 2024 23:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724992530;
	bh=v5j0W8rMVLi7gb2W/LeZtE4q2VahruXBxMCiU7WwVGk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jalR//3kcMQrp2HAz0AYG0df2uYXq+S/zssZ3/VQGVUBuS4JHWGxgTi567hpTrVR2
	 JptWLG8X3ieNX1F4RKWtNKlnwTKxsrkV7z788yqhi5i6hnvclNtw9jgNAklNypMHNv
	 5xYbjEf5qs36QuckjqXMPf7lhJuuaUjxsJYfqBM8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47U4ZU9h041646;
	Thu, 29 Aug 2024 23:35:30 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 23:35:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 23:35:30 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47U4ZTqU113945;
	Thu, 29 Aug 2024 23:35:29 -0500
Date: Fri, 30 Aug 2024 10:05:29 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v11 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240830043529.a2lsvazchc3onrzi@lcpd911>
References: <20240829201606.1407773-1-msp@baylibre.com>
 <20240829201606.1407773-4-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829201606.1407773-4-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 29, 2024 at 22:16:04 +0200, Markus Schneider-Pargmann wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Introduce power management ops supported by the TISCI
> Low Power Mode API [1].
> 
> 1) TISCI_MSG_LPM_WAKE_REASON
> Get which wake up source woke the SoC from Low Power Mode.
> The wake up source IDs will be common for all K3 platforms.
> 
> 2) TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT
> Set LPM constraint on behalf of a device. By setting a constraint, the
> device ensures that it will not be powered off or reset in the selected
> mode.
> 
> 3) TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT
> Set LPM resume latency constraint. By setting a constraint, the host
> ensures that the resume time from selected mode will be less than the
> constraint value.
> 
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [g-vlaev@ti.com: LPM_WAKE_REASON and IO_ISOLATION support]
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> [a-kaur@ti.com: SET_DEVICE_CONSTRAINT support]
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> [vibhore@ti.com: SET_LATENCY_CONSTRAINT support]
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Akashdeep Kaur <a-kaur@ti.com>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c              | 198 +++++++++++++++++++++++++
>  drivers/firmware/ti_sci.h              |  76 ++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h |  26 ++++
>  3 files changed, 300 insertions(+)
> 

<removing older email addresses from CC>

LGTM,
Acked-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

