Return-Path: <linux-kernel+bounces-241027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A893292760A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEC11C22F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4141AE847;
	Thu,  4 Jul 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lgRaACEF"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264611AAE3B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096248; cv=none; b=a9w923KBdlB3jDubRH9zXBlivhhB0H2rCSxlcuy1PUnGQvKY+hUzu8PEHHXBW8C/JSkCKR/VWgOgYdRLaOpHJKgMXZCX/nGhxnyP7LkcJJYr2WEQzYG9bMxXMZbUwrY0EAHjhV4mlwZXJzQ4CKtWoSHA+2+CNeBixM4Up32jP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096248; c=relaxed/simple;
	bh=GQNlcL0hhyiDupAqvrBgnUjQtwvvkpjxgxF38pJzhBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jBVHAqWGy+7E8WsaP5r404OwNJ6YLBqu6urVCNhwRAjcR7ivGxLA+7B5hd7Y0xDsi/y24pKWj0NuNaZr4MNTeQAEXY/uCdbwiometot/EvjLrSj386a+7ohshYAdnGboT1/YAJO192Upm6GIbXBfGbrxiTqDIOQgBK8g9QsYhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lgRaACEF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720096244;
	bh=hV8Q5ucKShGyatQdfOoPFgps6/gf+P033enmjkUarIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lgRaACEFtOZsGM62UnjfaXb5LPf5GTyQi5X+DTgBKeXaSbfw7KT1oOWftPEb+mDxS
	 OfGBTeXn6iyBfx2WiGBAztlTz+TK1F+laUdSdX33+d/NJEXAEJ7MnBB5DalSu25qLM
	 jdb0EtkWdQIr8vUVE8JxP0SUXFAyy5vAp1zIAKZsGeN18DeKL7IUHF5jkZrE1ZPLHE
	 tdZ+zSCdmjMnjnyWkxQy59mE2JcPZmG/DA9TH8iZf04AyjNavrOR17WwMFG75XHnhn
	 pb0lK3Oc0sF+H8qvUMSNAvP1mwZX0EJ39Vx0oO9442lsKRRpywe/Fac84ZxtrrvhCV
	 f/LhRD89n+c4A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFGFv739vz4wbp;
	Thu,  4 Jul 2024 22:30:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] macintosh/mac_hid: add MODULE_DESCRIPTION()
In-Reply-To: <20240509-mac_hid-md-v1-1-4091f1e4e4e0@quicinc.com>
References: <20240509-mac_hid-md-v1-1-4091f1e4e4e0@quicinc.com>
Date: Thu, 04 Jul 2024 22:30:43 +1000
Message-ID: <871q49jq4s.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> Fix the make W=1 warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/macintosh/mac_hid.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/macintosh/mac_hid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
> index 1ae3539beff5..eb7a173da071 100644
> --- a/drivers/macintosh/mac_hid.c
> +++ b/drivers/macintosh/mac_hid.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> +MODULE_DESCRIPTION("Macintosh mouse button 2+3 emulation");

I dropped the "Macintosh" from this, because AIUI the driver is not
actually mac specific, despite where it lives in the tree.

cheers

