Return-Path: <linux-kernel+bounces-307552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA0964EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C33C1C20B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB041B9B40;
	Thu, 29 Aug 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZSBgRe5z"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E81898E0;
	Thu, 29 Aug 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959984; cv=none; b=d43XjgN+prEwhN0Pdt0WIWdAa2Wnq6JhbOfpU/7m9kwaxvDjtvSN8bUaCFtjT3DBrg2WNEgVMYMeI3rF56e934QqpPHZRZgM7TkESAuIHn/5T9qOJhMWZEMIBXkn/kb4S4/YI5ggImoCkUdhIbxWfuJ+v9d9+ImekXvyFEaUNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959984; c=relaxed/simple;
	bh=qmGX9eJRgH1hbqst2Em1rnwLWLwIQK5OOkaNCPG8PGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tdMCxjcseRVeZWYy8chc7CYF5UowI99KWhQaDnQz4hexZGwgcMM2YNB4rM5vwlWKkiq3MPONM8U0addjUpAbloFBRbCth38UAtZEIJwizWP9mxsv1lMnvG/ScwgLpDrgzKytyrPe1Cn6PkDZDnYH2M7Ig4gh8A33baPxKTr0TRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZSBgRe5z; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TJWgaQ099234;
	Thu, 29 Aug 2024 14:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724959962;
	bh=dyu/27ZfP1csr/zH6BWhuyjds/vmIq6uZY6YiBmUtec=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZSBgRe5zkgW95OlrPlOj/KU38puY/VvhGpgMhBCdkn+Mo8+HmFL4POYFvYnz/D5DP
	 kw+2XwSkED+ci0J6j8hXLdXF4Qx09AvkPDnECJdZBqNlOk1K8mVofEa3OiYLmUMpi7
	 xs7M1UxxWzaIQr2oXfnRcqidFPJ95CH8gPq1G248=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TJWg07059052
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 14:32:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 14:32:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 14:32:41 -0500
Received: from [128.247.81.191] (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TJWfjJ036644;
	Thu, 29 Aug 2024 14:32:41 -0500
Message-ID: <a39ebd71-0aef-4925-ab94-23dc2ee785fd@ti.com>
Date: Thu, 29 Aug 2024 14:32:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix register map for main
 domain pmx
To: Aniket Limaye <a-limaye@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mranostay@ti.com>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <robh@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <u-kumar1@ti.com>
References: <20240829071208.2172825-1-a-limaye@ti.com>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <20240829071208.2172825-1-a-limaye@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/29/24 02:12, Aniket Limaye wrote:
> From: Jared McArthur <j-mcarthur@ti.com>
>
> Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
> range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
> due to a non-addressable region, but incorrectly represented the
> ranges. As a result, the memory map for the pinctrl is incorrect. Fix
> this by introducing the correct ranges.
>
> The ranges are taken from the J7200 TRM (Table 5-695. CTRL_MMR0
> Registers). Padconfig registers stretch from 0x11c000 to 0x11c168
> with non-addressable portions from 0x11c10c to 0x11c10f, 0x11x114 to
> 0x11c11b, and 0x11c128 to 0x11c163.

Still unsure whether these registers are correct. There is a
conflict between the TRM [1] and the datasheet [2] on whether
PADCONFIG63 exists. The datasheet doesn't think it does. I would like
to confirm this before the patch is submitted/accepted, because the
pinmuxing would need to change again if the datasheet is correct.

[1] https://www.ti.com/lit/pdf/spruiu1
[2] https://www.ti.com/lit/gpn/dra821u

> Link: https://www.ti.com/lit/ug/spruiu1c/spruiu1c.pdf (TRM)
> Fixes: 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux range")
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>

[...]

-- 
Best,
Jared McArthur


