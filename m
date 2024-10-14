Return-Path: <linux-kernel+bounces-364468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34E99D501
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6671C21039
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44B1ABEC9;
	Mon, 14 Oct 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OQgbaa2C"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04406288B1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924808; cv=none; b=fHMgYEjDjNy5JNGkUzOk8wwjlll8smvI8mNyUGvvcvXa2D0VbO7l5IOAnTQsZLMeHcGAoUU8X8UriUYcpTKFfsGZyooHCaB6caZTAVLTGlzV/U9bYiYOVf6QUtWSG2wEOvfKnHdzE5Wf/PGXY7GSfbCqTBlBQ4msYWwZ2ahXRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924808; c=relaxed/simple;
	bh=y7p1mYuJ3TMrD/axVpS02SaUnCUn5y4pbRmWPT/P+F0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXoa6CoLmVdLi7hbRGIqq80BxOj+yu86ssz2FklEBRjURcCYLYVGqLfwakNuUL+kiCqOFFAQStEznZJNPaf4IVqDPaWaTiGlR3ZvSLxtvSDzN9YmOorxLXEAYJ1RU3T8I2r2cADP4sQcJc+O7kQk9ZXa3yoP0cfsg4icTAlusPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OQgbaa2C; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EGrGoR100226;
	Mon, 14 Oct 2024 11:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728924796;
	bh=P94W8RcpLOlR0UzPhZdcTWnXomV7JRlzuvuQEtFZQr0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OQgbaa2C8/KYyesCZ/AR+SS4K6HKZ1IpFCBr5ChzlcctsSZawkf5mYzBu/IIoHgUl
	 0hCUo49YmPxHONI7N+DcfwsjYOiYkLoRiGl6DvYbTcs7/EwGeyxVqIkEcOQwt7pENm
	 1DMoekeWvjnD3u21mXWao/7teMO4xqn79yNrhyJw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EGrGl8039015
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 11:53:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 11:53:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 11:53:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EGrFXU015884;
	Mon, 14 Oct 2024 11:53:15 -0500
Date: Mon, 14 Oct 2024 11:53:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Hari
 Nagalla <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Enable compile testing of TI MSGMGR/SPROXY driver
Message-ID: <20241014165315.vvsbtv6uoep5ufss@subatomic>
References: <20241014144821.15094-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241014144821.15094-1-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 09:48-20241014, Andrew Davis wrote:
> Hello all,
> 
> This driver can be compile tested on non-TI platforms. Enabling this
> also allows compile testing of drivers down the dependency tree,
> such as TI_SCI_PROTOCOL.
> 
> Thanks,
> Andrew
> 
> Andrew Davis (2):
>   mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
>   mailbox: ti-msgmgr: Allow building under COMPILE_TEST
> 
>  drivers/mailbox/Kconfig     | 2 +-
>  drivers/mailbox/ti-msgmgr.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.2
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

