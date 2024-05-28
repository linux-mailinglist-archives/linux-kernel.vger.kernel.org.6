Return-Path: <linux-kernel+bounces-192325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301A8D1B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EE31F228F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F116D9AE;
	Tue, 28 May 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AE6rvFds"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168AC1EB3F;
	Tue, 28 May 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900258; cv=none; b=AJIcS4AqvXsBB38D5mD+apGDV+pBB9mdtzh8CfLeqDj/ThSpDZuSNRMCyFqYtXihrILxnUnxgwH8M/zU1ZFX8dBtMnbqEJ9GRgqhF7oBj5BpqwJrgKidI3/WYrJieayYqQukkQP/dLTfaP7PtIDz5+7JRpj2sFI4kfT/SvTCpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900258; c=relaxed/simple;
	bh=tQXQTMR5G234QCe92JDOaJwq6JO0YPHdVfA+0fIU1HU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz9Slkd8Q5Rs2XTi3rCYHIMZ7H1Cih+4s1asa153lB1FjlbG9Yht96cziJIC2dtZL0fNI6PyUUQAzsmdvh7YP4/781ip5ebKGHzWZoGcMXD1Zle28tsh+GX1zZhDW/7N08NJf4drHWt+K2cTWNMVFSPmBKeHnFbB6J6PdiWrlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AE6rvFds; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SCiAvA051720;
	Tue, 28 May 2024 07:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716900250;
	bh=JmFVvqPhWyfqK/XNqtMKhNTGIKcBale9VkrI0xk6Hoc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AE6rvFdsB6hqFqAsTGJRojeLLpJ1LyEKqQ3010bimov8lJJX+uI4iE6pYq3y9mwHM
	 rFdBgYXKwsbd+9EtvEG87RB/QEnBK9mb8dKDlRiYYnL4YH5Jzt0G2tcpdNckc6DfTY
	 whRKwl3nmsetDeutY8YIRzSbkVaO0WfDYPkXFxeU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SCiAbP027194
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:44:10 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:44:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:44:10 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SCi9Ww052614;
	Tue, 28 May 2024 07:44:09 -0500
Date: Tue, 28 May 2024 18:14:08 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: ti: k3-j722s: Add support for PCIe0
Message-ID: <ff6cb81b-7760-4c99-9c17-907b0a31396c@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-8-s-vadapalli@ti.com>
 <a6fe1fbe-681d-429b-99cc-a5f07af1cd15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6fe1fbe-681d-429b-99cc-a5f07af1cd15@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:26:11PM +0300, Roger Quadros wrote:

[...]

> >  
> > +#include <dt-bindings/phy/phy-cadence.h>
> >  #include <dt-bindings/phy/phy-ti.h>
> >  
> >  /*
> > @@ -96,6 +97,35 @@ serdes1: serdes@f010000 {
> >  		};
> >  	};
> >  
> > +	pcie0_rc: pcie@f102000 {
> 
> Please split PCIe node addition in  to separate patch. hopefully you can squash it with patches that
> add USB, SERDES0 and SERDES1 to k3-j722s-main.dtsi.

I will do so in the v4 series. Thank you for reviewing and sharing your
feedback on this series.

Regards,
Siddharth.

