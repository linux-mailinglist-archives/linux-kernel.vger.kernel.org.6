Return-Path: <linux-kernel+bounces-300149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66295DF73
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF429281666
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A736F61FFC;
	Sat, 24 Aug 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="apivGjQJ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD75EE8D;
	Sat, 24 Aug 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522879; cv=none; b=mJ3YuX/+gH36yltQXDnw3rei5CPHuXPDS4KO2XmLdG52VIXPPBDjUofN9cGs0mLxMdsW0/wETc6e3tZZbCLkvYJHGcaZWtLb8jPWPyEdeKb7gIlIhb3aKdcef+QrIi2taNBCwrTGzjBFepl1NMAJ+r9C7a1SgJJbflsbIUzEJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522879; c=relaxed/simple;
	bh=6vrEWOofIrl8Bf/41TGh8l5rF6n8el/WsoLFZkkZPHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STljo+OzV1D1LV/ffWM04ZkBw1U4SOcsebHKUA+t0mdpNrdzhNzRKrJT7IqF1WldHfga6t/YgiGXx9glalB/iimCgiqtwKdsq/XxS3JxM/nEOB6epZWPSkfCWfk85wDnyOAIPfBx3fYqbt2O+xGSomIG4ZwcUu8Tb49/+6FeKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=apivGjQJ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OI7jf3043986;
	Sat, 24 Aug 2024 13:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724522865;
	bh=oPkWxnMNagkBkdhdJdV6FlbtyFyeS8K40MFcS+T1eRg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=apivGjQJuoSDUL4JcpChH09XiYjlbP7QUucN8qqAIqZhjY0Nys0ywDS5gs3wXSl7O
	 D9Ml05+3xdiRS3YGv2PyWSrYqs1D+ZEC5b2O+DlSNfMpo3gd3lLfl8nLFZxsCnZzxy
	 eKnzFwq7c5AznS87CBdNrWGYQ3I4pxoiXBjS4qfw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OI7jR2053077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 13:07:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 13:07:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 13:07:44 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OI7iwV053211;
	Sat, 24 Aug 2024 13:07:44 -0500
Date: Sat, 24 Aug 2024 13:07:44 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <u-kumar1@ti.com>,
        <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Switch MAIN R5F clusters to Split-mode for TI SoCs
Message-ID: <20240824180744.qd7axughywodxhfg@underage>
References: <20240821095200.3050878-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240821095200.3050878-1-b-padhi@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:21-20240821, Beleswar Padhi wrote:
> TI SoCs (J7200, J721E, J721S2 & J784S4) have multiple R5F clusters in
> the MAIN domain. All of these clusters are configured for LockStep mode
> at the moment. Switch all of these R5F clusters to Split mode by default
> to maximize the number of R5F cores.
> 
> v2: Changelog:
> 1) Update commit messages to drop "Lockstep-mode" as default mode for early booted remoteprocs.
> 
> Link to v1:
> https://lore.kernel.org/all/20240503062414.804209-1-b-padhi@ti.com/
> 
> Apurva Nandan (1):
>   arm64: dts: ti: k3-j784s4-main: Switch MAIN R5F clusters to Split-mode
> 
> Beleswar Padhi (1):
>   arm64: dts: ti: k3-j721s2-main: Switch MAIN R5F clusters to Split-mode
> 
> Suman Anna (2):
>   arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode
>   arm64: dts: ti: k3-j721e-main: Switch MAIN R5F clusters to Split-mode

Why are you doing this for all boards? if it is a specific firmware
behavior, handle that in the board dts? leave the defaults alone. don't
create surprises for downstream users.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

