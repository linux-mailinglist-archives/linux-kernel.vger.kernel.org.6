Return-Path: <linux-kernel+bounces-218372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561F90BD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF47B21D32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23385199238;
	Mon, 17 Jun 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VdD0t9BZ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5D19146C;
	Mon, 17 Jun 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663117; cv=none; b=VExqfrNs46j2SlDNVfeMExdp8TrgGZApdjzfpX94vv/oIJG5EFCfEh/GuZdvzSvWfIt+4u1SnjOHA/MZ/XERczhQLeVUiXvorDii9jAgG8v2o12lFzaCoAT72pHc9Wx5/cECM380OcFRTyTTipUjNGJTSpz7C4dUI4ZZ0vAyYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663117; c=relaxed/simple;
	bh=yr8aF+6cl0PvM7Z4K4YPH/pvE+gJlEklbIIjCHB8nC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gza++854I40SPGxB+84kELih75c/sjU8dd/Hyy5lJZtoVykxvlm8gDWld31UTAm5sU/eBy0WLBimi9Z6bGxdJyiCCXmvW0NmFTOVRIstqBVbXgKqea7t2aFDV3pm5WT6du8zeatj1voEzeZQ0sEXCnh1QMHG0ylgSVx65qCqwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VdD0t9BZ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B65F145E2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718663115; bh=C4irShnxUq3Qay/2WqB7RvyVUXEGysIQbUzCnN557I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VdD0t9BZfjVRwVNQ7jaQhAr9a4E9hkxKVtwflz/o/CZYyWCUA+uhNRKcjIk1PQ10R
	 OFvfeKrBxPQuohtGa8XCoit6wVBjSSpXyQ8ANwS0aAkvqNWl5CRRQ5KyWBF2YxfhQJ
	 YwwWcabOxRiX/GzvotTI46HLcIh1P+O8/xHh/CQ0FbnsoczR5CmodIUtGaR8k824id
	 mcHM6SSPalgvt1ZQwRebCFzDvlGGZWQ+b4Tvk22GGOzCe8jf1AaEYymcv4GQqM/WtF
	 ODCTa98flzrzdPe5AIE3FB3juAj5SddLFMVFC6NglpcRgnDFxSHrrCELIc7xJxMbM4
	 CN1hPv7sKJJxw==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B65F145E2A;
	Mon, 17 Jun 2024 22:25:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Alexander
 Shiyan <shc_work@mail.ru>, Olof Johansson <olof@lixom.net>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Documentation: Remove unused "spia_*" kernel parameters
In-Reply-To: <20240614184041.601056-1-thuth@redhat.com>
References: <20240614184041.601056-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:25:14 -0600
Message-ID: <87plsfgqb9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> The kernel module parameters "spia_io_base", "spia_fio_base",
> "spia_pedr" and "spia_peddr" have been removed via commit e377ca1e32f6
> ("ARM: clps711x: p720t: Special driver for handling NAND memory is removed").
> Time to remove them from the documentation now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ff02e1a02e12..dd8436c98735 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6273,11 +6273,6 @@
>  			Not specifying this option is equivalent to
>  			spec_store_bypass_disable=auto.
>  
> -	spia_io_base=	[HW,MTD]
> -	spia_fio_base=
> -	spia_pedr=
> -	spia_peddr=
> -

Applied, thanks.

jon

