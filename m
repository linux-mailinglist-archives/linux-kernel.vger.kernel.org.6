Return-Path: <linux-kernel+bounces-231901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F491A01A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048A71C20BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7C487BC;
	Thu, 27 Jun 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WvCmvmg/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31747A74;
	Thu, 27 Jun 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472379; cv=none; b=oP1mDOpoRAAWnCfGfXUYMQcCzGAMXN/Fjenxd0QwJ/E0qGOLGPrnhQPqx5nqZzVElZ8o0dFmhuqIDOfRhoKmhkhAFMzuIakhDyzT7lyiA26Aeu0Ot+6yefRHLwrCUFtwTkfS9OLP3zJUAnVPp7W3CqBQ442W8rVPHYpaPyKAO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472379; c=relaxed/simple;
	bh=HZ1ieO5mdOeI/L53TPPVa0yOUEeO3yiTK54ycoeCtrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fFrf5p+5/aPLSjDcoOQ7n/YrpdpSnv0QTzRjw7kTTTQH9H9T1kEpssJQHnLyuJdXtcmQIjhZ5ZgfycURacb0Yya3JTxF5OgD35qlD2Nrd2aPnSROs8uvS5sz2KNnRhEjS5gqX2DFtkDDxNt0kSorxgITQ0iyWQI8Ndnvina0Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WvCmvmg/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45R7CUcg066000;
	Thu, 27 Jun 2024 02:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719472350;
	bh=9/nt+OwWswhCPKKWAujQ3ZdvXlga4u8MUGMl58MIwQ8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WvCmvmg/Xagn/PUZZhekH2f6Qzd96bL+1Igzvf8dDSbTpcefJ+K98NnFljwGdVVWU
	 SULh0L+t8KXzhjlCdgju+Hkxm4Wftw11vkn+CDD9L4VFVwSk2xf9zh35laRS6r6r7I
	 JTzGpCr3DniOJ1sJ5AvNyqzr/UchFd+irGZBdzIs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45R7CUgr027376
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 02:12:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 02:12:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 02:12:30 -0500
Received: from [172.24.23.9] (lt5cg1457vgj.dhcp.ti.com [172.24.23.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45R7CRwH130459;
	Thu, 27 Jun 2024 02:12:28 -0500
Message-ID: <4b867d2e-fdb0-4d5a-a9a9-e00758f2cd05@ti.com>
Date: Thu, 27 Jun 2024 12:42:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] mtd: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Miquel Raynal
	<miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240610-md-drivers-mtd-v1-1-0f59183e4005@quicinc.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240610-md-drivers-mtd-v1-1-0f59183e4005@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/11/2024 10:37 AM, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/brcm_u-boot.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/tplink_safeloader.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> ---


>  drivers/mtd/chips/cfi_cmdset_0020.c     | 1 +
>  drivers/mtd/chips/cfi_util.c            | 1 +

For the CFI bits

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>


[...]

