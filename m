Return-Path: <linux-kernel+bounces-404054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341939C3E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654C41C20CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D819CC28;
	Mon, 11 Nov 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hRv5/ELF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108C139578
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328783; cv=none; b=BfPdpVTWEIJnw8I9xSLIG3Ah5rpcVzePv0ZgFCZ9DYQVtM6YN9yKWkR5v5G11y2XFeVsj+3CZOc+7vdsZXB2PUfgi/ocwyFkp13ssaLKO4ByhpYFfV8pFb1D0JrE7ws7niIQ2mFSeWE2UKC+sTxrCMuF7utrVlW4jiTwutZXTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328783; c=relaxed/simple;
	bh=kFBN2Iutr1bU/L6zXAvRL1WuYK4IeuSMKscTxpxn06k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLa+lprW2AFcNPj6vKAbZ5VDXb8dhleDWAEUzaiX7uyY8BAwuouxoIcAeBYAnvCqijATU9aUTnIrLHUtcFao/jC0RLpiTMboyZWtGyKqfm77RSwpO7F1LIqlk01msfjX/eUZE/yM8ctnKjUW91OtvM3jKibb/z+oXHlx7GTG4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hRv5/ELF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ABCdX46089589;
	Mon, 11 Nov 2024 06:39:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731328773;
	bh=mS5DOIX6lsBiG357g64aoL+wyhfRzIDHFpvOfAlb8YY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hRv5/ELFjWGqKeZUQCevBhOVO+tUZFTKGtV+6bcVn9UQA6V33ewFW3c3Ss5DGZXbp
	 WXsiqW6m5gUxB7c7eprgO6B+5EGePrbclssN0S2r3dv5+lYmJKTtmBiCTG/HFfDMXe
	 FKQGKfun3lUCimelQKoNebRh6n8LvyEOftYMTjcg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABCdXSU111433
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 06:39:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 06:39:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 06:39:33 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ABCdXqj063198;
	Mon, 11 Nov 2024 06:39:33 -0600
Date: Mon, 11 Nov 2024 06:39:33 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: guanjing <guanjing@cmss.chinamobile.com>, <s-anna@ti.com>,
        <horms@kernel.org>, <p-mohan@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: ti: pruss: remove misplaced semicolon from
 pruss_cfg_xfr_enable
Message-ID: <20241111123933.giglmztd2pnax6g7@hurried>
References: <20241109032631.258765-1-guanjing@cmss.chinamobile.com>
 <5324102e-b2f3-4b39-8861-da9ebb78ad40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5324102e-b2f3-4b39-8861-da9ebb78ad40@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 14:32-20241111, Roger Quadros wrote:
> 
> 
> On 09/11/2024 05:26, guanjing wrote:
> > Remove misplaced colon in inline variant of pruss_cfg_xfr_enable()
> 
> s/colon/semicolon
> 
> > which results in a syntax error when the code is compiled without
> > CONFIG_TI_PRUSS.
> > 
> > Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
> > Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

https://lore.kernel.org/all/Zy3nBW3XvFy-Y1Fe@kernel.org/

Please also add to the commit message what Simon suggested (Found using ..)
- how was this found? That helps other folks learn better practises.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

