Return-Path: <linux-kernel+bounces-282574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8794E5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2357B1C21419
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1734714B940;
	Mon, 12 Aug 2024 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BOdQ6Xb+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666A380;
	Mon, 12 Aug 2024 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723439474; cv=none; b=I/0fYT8KOVLJIJI4n5h8AecmsJRJPXeoO5QIXTP6rmsxKdABOl1bHXH6yJoKDP35KQ0tY1hZJzlcy6Er4lS6EF0czITbb7trTwaGpu6l1iuBp5QRN3tT4wk0qjwbbOfe/iK1HgXSLH7/DlqH42vcE20FaRwOpKOxOUlZMcE94NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723439474; c=relaxed/simple;
	bh=hMGQnuLjw/QJkAWzcYNfzbpFDw4Yi+89B4oDnbGKOoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfzndsJQLN4esdbc42GtEZW2pI9Kh9o9hYjIpt+pd9mNRrqdosdsxLSf6Ef8UGvqxJ4qrCu1CbtyWY3U4t3L35eUmJSdvP+olv3rYilHTIusv+nDV+ASwjso5bhRAgs86erdrtVaDgOmW/vaI7qgCaUQ7xrOprQSC/5vydMtTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BOdQ6Xb+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C5B0Sa037613;
	Mon, 12 Aug 2024 00:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723439460;
	bh=ICM5BEPN42HtGeNQ/kumXVS9/LZOahJxGvyqIAoP8g8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BOdQ6Xb+Jhl/OD337rK7H+O5ykyS3E5W4bb/OGf/8BPYZ2jo8Dn2pTnDgvJw7aDVL
	 fJoQ9d/ZKHDtyaCTo3C8jGeP7+RgWwXb7bqY/YcKXaGYAtEGMmqhwEMPVshxQnK26J
	 9vSGpVWALdoJfxvO9wxg88JI5kJ4yaZtXFLtXs7c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C5B0sf005961
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 00:11:00 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 00:11:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 00:11:00 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C5Axe3102109;
	Mon, 12 Aug 2024 00:11:00 -0500
Date: Mon, 12 Aug 2024 10:40:58 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <sinthu.raja@ti.com>,
        <n-francis@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin
 mux for mmc1
Message-ID: <20240812051058.ooq7uxd6xdbhgjln@uda0497581>
References: <20240809072231.2931206-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809072231.2931206-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya,

On 12:52-20240809, Bhavya Kapoor wrote:
> mmc1 is not functional and needs clock loopback so that it can
> create sampling clock from this for high speed SDIO operations.
> Thus, add clklb pin mux to get mmc1 working.
> 
> Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> 

R-by already given in v1 [0]

[0]: https://lore.kernel.org/all/20240808050914.4jleprwmlrtv4alb@uda0497581/

Regards,
Manorit

