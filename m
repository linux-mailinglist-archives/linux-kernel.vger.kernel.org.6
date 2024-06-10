Return-Path: <linux-kernel+bounces-207879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D7901D66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4569E1F2156C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895516F314;
	Mon, 10 Jun 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VFLXiMq4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCD6F2E8;
	Mon, 10 Jun 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009810; cv=none; b=Vq0/0zET9SFWv1OMwa1XEYuR4qoSJP3RBk2RAHzpMcT4NLz43JaWJ2Pnp6uVfzUG4ly4WVvUHgopQsRFlzKqgc3xLDKgy3+hPU4+YaB68XwCvfQQ6cMMp+HOEX55CCgjZH6oslMMEwJRx2P4A1BB665q4aE9ZjM+0nz5avbdjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009810; c=relaxed/simple;
	bh=6X5u4niWKGCPgbslu73NSK8WhevO5joHCSScvTBKzFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PBreddQOA6InuL3HHCCU5WsDr/PpKBlgpruiZCq8SKyirvSr4cFWujVFEYKtdNg8uVm8tDjf5npLVE+6Nu7SRpHk53DLE4JqgJevyrpEuLJ1sP5xvQgamZ9XqJI/5Zq5Mna+G7BX9l3sGksIEam7qlJI/um5eZupk9IBMBeYN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VFLXiMq4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45A8ucTl011341;
	Mon, 10 Jun 2024 03:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718009798;
	bh=O8v2PxB1K+ZmBgIIu/uWr2jstH6oJ92TLaUNHM4HmLE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VFLXiMq4RCCyfDl/I+ETl9jr03kXMDGi9fpBzk62Ythw0O4YOfVf76hLQbS/c+TvJ
	 qmFICJphw8t6JIewOsW/uYr5cLWDbStYNOSLpYa+Ms/VugfYPlqTPmDouaU/1tIRVt
	 L3350g9DTWhdFNbxdUxkrhgi4Sn8dmwPpRwyVbzQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45A8uba8104073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 03:56:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 03:56:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 03:56:37 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45A8uXxw051246;
	Mon, 10 Jun 2024 03:56:34 -0500
Message-ID: <bf928964-2c00-4e4a-a677-ad920cdc9759@ti.com>
Date: Mon, 10 Jun 2024 14:26:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: am642-phyboard-electra: Add
 overlay to enable PCIe
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20240513225646.3603803-1-nmorrisson@phytec.com>
 <20240513225646.3603803-3-nmorrisson@phytec.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240513225646.3603803-3-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi

On 14/05/24 04:26, Nathan Morrisson wrote:
> Add an overlay to enable PCIe on the am642-phyboard-electra. This
> will disable USB3 and restrict us to USB2.
> 


Commit message still doesn't answer why? Could you explain why the
overlay is needed


I am guessing USB3 and PCIe are exclusive at SoC level and board has
capabilities for both? So, please add the same to commit message.


[...]
-- 
Regards
Vignesh

