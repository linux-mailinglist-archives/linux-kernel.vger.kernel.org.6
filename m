Return-Path: <linux-kernel+bounces-363272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E399BFE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004D9280CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79337143C72;
	Mon, 14 Oct 2024 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rBEOYEXl"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196A13D52C;
	Mon, 14 Oct 2024 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886466; cv=none; b=PMQ0/kaRDhKjZcwMB/2gWiM4pfXsooJGWbsVMJAJ1OIBaentRo34SvpFtVR3LWFWVF/Pd409dBFWULwzcR8dyAoYKi+ykHAYSfVtCVU4sZpggE8mu4PlD779bhZSC7YB9UY528SHcY5YtCnBPuWlYVuEUYopyX5p9ncYVyCfCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886466; c=relaxed/simple;
	bh=2xW8bIiq09NnXoxP2tokvnSnq43iNaCxMflmkwukjJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQKVWdSJlsxcwY/eri6cY85DjfnwMNkU2k/TdVPsLWsXqiR12qpc/u5coHZh3TjvQ49312LaHhQMHMxaXyKa+cj97BOxFlGBrlcewjZvxjRtxX53/3qfze0ZRwnra2JOOg7AfiNXkIG/1JovXomUMfhHxDhgXpl9BNqeKyOWWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rBEOYEXl; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E6EC6i043840;
	Mon, 14 Oct 2024 01:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728886452;
	bh=ix3SCsutgg2XyGIhJ2EF8E7b98fPAOvRyGHxdyctPNo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rBEOYEXlVio0+XS6JVK5rzvDHHlcQCPHBf20W0TQWHeSov3WUikeQnVMa8K+2MRaz
	 5Uzq+TgGmGCtXue2V1EQErH1dlIt8+5zgULZwlYw3bnh5xkDhe/7Ul2ToeN73q3b9B
	 hu1mckA6VY/zRfgehwx05IU2OhPI3V4t31XU3ncY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E6ECJR096235
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 01:14:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 01:14:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 01:14:11 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E6EAsh095900;
	Mon, 14 Oct 2024 01:14:11 -0500
Date: Mon, 14 Oct 2024 11:44:10 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all
 property in cpsw_mac_syscon node
Message-ID: <325fe19d-3bdc-4386-b404-b0d8cf98b593@ti.com>
References: <20241011110207.600678-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011110207.600678-1-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Oct 11, 2024 at 04:32:07PM +0530, Chintan Vankar wrote:
> Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

