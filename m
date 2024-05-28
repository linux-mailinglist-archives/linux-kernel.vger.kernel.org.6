Return-Path: <linux-kernel+bounces-191968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966208D16B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DB91C22C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C486E13C906;
	Tue, 28 May 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c0KJnS0y"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EA6E614;
	Tue, 28 May 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886590; cv=none; b=s0wDptKp7/CLOnBlcbh8CvYHBB3kbQbx7xHJBLQ3P1WSAoWge4pzQ9stGwqWDmDMbhgbkhL0ciZ8yVLOyQY8+2P4t9wBab6vYDcITZQf75z68an1XR2Jl1bBC/8VqZ9GsS27rrj9gZbhqV7sN9Sl4FZkxzcPNJkysvROJiKHJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886590; c=relaxed/simple;
	bh=/K6bSsAQt4UC2gwTDWV1w6ThrIAydwf7VkdyMtYJZqc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+B5sPb9uizSiTMMUNT93LZUrUPH29vew0VR/8vnIVVfzFz44ZzIbCDIfhqjRFkZLHLK85HkDt95z9nl/pHG+YhK2tKlByvZkB3kKyPUQB+Rx/1dnr3XI5hvM31i7g7I06PThD6Fu4fWDrdfPYgynABGp5xzMXjg5xHlBhatbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c0KJnS0y; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S8uFY8005280;
	Tue, 28 May 2024 03:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716886575;
	bh=/K6bSsAQt4UC2gwTDWV1w6ThrIAydwf7VkdyMtYJZqc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=c0KJnS0y5b9hEvxFCX7Ev0hyvoC99HtFjWSNPJOO/sE8pWBYh4NmQVTWL4US7DJvM
	 bHkrrl6f0YSCo88OB0y7Zv1OHu2FVF4rHVIimC/ECWo6CrdqvV4EdlPpOUkpMD0CdO
	 QUm5rQULRRT0JDFs94wOh9VzwpVc6ZOOSFFG0wTs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S8uFQQ068117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 03:56:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 03:56:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 03:56:15 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S8uEDt107098;
	Tue, 28 May 2024 03:56:14 -0500
Date: Tue, 28 May 2024 14:26:13 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 0/3] Add PCIe DT support for TI's J784S4 SoC
Message-ID: <3fd10101-1078-4979-b2d4-c5d4d7a40f4c@ti.com>
References: <20240523111008.4057988-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523111008.4057988-1-s-vadapalli@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, May 23, 2024 at 04:40:05PM +0530, Siddharth Vadapalli wrote:
> TI's J784S4 has two x4 Lane and two x2 Lane Gen3 PCIe Controllers.
> This series adds the device-tree nodes for all 4 PCIe instances in the
> SoC file. The Board (J784S4-EVM) has only PCIe0 and PCIe1 instances of
> PCIe brought out, due to which only those PCIe instances are being
> enabled in the board file. The device-tree overlay to enable PCIe0 and
> PCIe1 in Endpoint mode of operation is also included in this series.

Kindly ignore this series. I will post the v4 series with PCIe2 and
PCIe3 regions reserved in k3-j784s4.dtsi which I have missed in this
series.

Regards,
Siddharth.

