Return-Path: <linux-kernel+bounces-393708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E919BA43C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1241F218BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8067148FF3;
	Sun,  3 Nov 2024 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBHHSVFZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96C83CDA;
	Sun,  3 Nov 2024 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730614021; cv=none; b=C3c5GMabals2PjkUhPpkvJMwc3HdnYWkG10gnpYQAH4fMmvrC9sb0w3hLucq8oqLK3I3M6QZTaPbVpFWayYKFoz1VkC2XtZwWLVrTDCQuT0U1ham5K3X2UCs6bWJMmyWIhPAAgcDdfpoHi3tOpkBWtTFVL7g2J1Z6tvrZ5BpKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730614021; c=relaxed/simple;
	bh=oz+wxi6Yr5rBjaQ5qPS3ySPFnEj+AGajI/WYCSDfsUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OK41E1Fu8MBtF2e+M9DmS3R9H0LPsslydUbA24lok6AyMKGE2bUwchlMdrC8+1+xV+d0oBsgKyEt3iGDqjvqanVRs2OmkPliTfEw5YdUrI10tMpyN30rBs8zqnQRiaRJ7r6/GFibEOnnoMbpS2jX89D4YEX6mmnIBb1xne+J4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TBHHSVFZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A366cdJ041862;
	Sun, 3 Nov 2024 01:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730613998;
	bh=ZGHRHWeJS1fyqOYk6SMKIsYTqRUn1UDquo8pHRshV3Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TBHHSVFZVGEyse+ezWW6ab6PPcE1luoIDTljMwNtcxO9pbtnOQZyYPNI7FCojI/tS
	 9ZzwtngsXGIbg1EpxQ3fqaUkZdelAaBC5E/u0TNveYqvVqmtnk6tM0W64NuZBHF5E0
	 X0OoVObS4+gkVBOwrs8NpvMDSa5MXU6lc6Zc0M10=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A366cwP124647
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 Nov 2024 01:06:38 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 01:06:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 01:06:38 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A366Y9C003673;
	Sun, 3 Nov 2024 01:06:35 -0500
Message-ID: <613421dd-ff8f-414f-837c-a43912384336@ti.com>
Date: Sun, 3 Nov 2024 11:36:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add dt overlay to disable
 icssg for Linux
To: MD Danish Anwar <danishanwar@ti.com>, <nm@ti.com>
CC: <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kristo@kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241030114458.1358800-1-danishanwar@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20241030114458.1358800-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 30/10/24 17:14, MD Danish Anwar wrote:
> Add k3-am642-evm-icssg1-disable.dtso overlay file that disables
> icssg1-eth from Linux so that icssg peripherals can be used by
> RTOS or some other OS running on R5 core.
> 

NACK,

Firstly, you disable more than ICSSG (eg OSPI why?)

Secondly, if we keep introducing a "disable-xxx" DT overlay to disable
every other component in use by RTOS on R5 (which changes per customer
whims) then we will have explosion of dtso

If there is a corresponding firmware in linux-firmware.git that solves
need of a specific end equipment or usecase, then we can talk.

Regards
Vignesh

[...]

