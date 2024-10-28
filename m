Return-Path: <linux-kernel+bounces-385440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21559B3733
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40201C20898
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D331DF248;
	Mon, 28 Oct 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fikjyliv"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D10155A52;
	Mon, 28 Oct 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134735; cv=none; b=eZfWy5wY0Xkg6rAdmqTqo8T7LExmp2VSPv2iEwj6O6kuueh2r5eDbksgWs0xKKj/elKJKWwOSHtHo4aAEKWsFX/O1oRguCiaRmMrP3FOUZq5HYcyCu0VkvVJ/Ug+mk6hsd57MMNW0/DtVwvjBAefEOrkmYMwIrXN5FyA2ca7XK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134735; c=relaxed/simple;
	bh=ioStSMFcHelYWsqJVLRcWXQhN6hk/BjBdIbyjSj1Pqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rovIql2/gP9umA6P0UUvIQEYVaT8eAPMS7znh2Hg1vcrOzH2u9Xa9DjRQpogs3+O4GafkOXnrT2NUAvV/kG3JXUyYnM/m9ike+D83ZqUUSFKQ5x1FDmEGymnKwsv2Qtt0ZK/cAx7J5dA+LdjZ78LwPPXJ7jcTBJycDoidvmBwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fikjyliv; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SGwlFS127484;
	Mon, 28 Oct 2024 11:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730134727;
	bh=MMdoqtd5Or4egsm/ysACUyrqRpKWAPTDiHGIU58xz0g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FikjylivUnHNMVaS4gfS000Fxsf5d00p551H8vGEHp3SQXATPCqJhtoeOOEYE7lv6
	 DHGKP2heoAVrCK4AKFbWmlfiUSo0ojKPFufEwpMf/3zoSGLWL8U3rtjzbO1Dlexuol
	 +WyAKNEJ6Ibm5Owy2hjoCQvXT5JhGI/gAhDnxivs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SGwlOW120677;
	Mon, 28 Oct 2024 11:58:47 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 11:58:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 11:58:47 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SGwh3V128346;
	Mon, 28 Oct 2024 11:58:44 -0500
Message-ID: <3d6f78b8-d6b1-4c11-b87a-3922254ce360@ti.com>
Date: Mon, 28 Oct 2024 22:28:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Add GPIO INTR region in ranges
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240903055733.3483840-1-vaishnav.a@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240903055733.3483840-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 03/09/24 11:27, Vaishnav Achath wrote:
> Add GPIO Interrupt Router regions in ranges. Although not currently used
> by the Linux TI-SCI INTR driver, these regions should be included in the
> ranges mapping.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> This was observed while trying to boot Xen hypervisor on these platforms
> and the mapping failed due to missing GPIO INTR region.
> 
> Keeping all platforms changes in single patch as it is identical and trivial.
> 


Please rebase on top of latest -next


-- 
Regards
Vignesh

