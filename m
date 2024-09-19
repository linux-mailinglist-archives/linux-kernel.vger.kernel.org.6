Return-Path: <linux-kernel+bounces-333580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CE97CAEB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EED61F21133
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94819F10E;
	Thu, 19 Sep 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bVQnp6MN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBC194083
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756008; cv=none; b=OgYvBvJUfPXWtKNGKsL8qohdDkhlP2OHrCdYxdws+QtNPPAxp/lSljr3OmL1BqDbj3r7/QnH5SFzTBFRTlevUZb0/oI2BTaGmvn+FfUZtFzym+PTqo/aLgBuZGjSGSaKpzhYVqrEROKTyV+KJp9obymKo2sP8Uyvu+StKDXQ3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756008; c=relaxed/simple;
	bh=s1FeyuPuKAIkLxdmr7dFkDqlUjqdMhFEPRBAKufHSN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgJ+sG+J8FIE4MJNr0/hwT/UBjrW5DMj7NTZPKOEyh31jTe96/gfeJqIL9GpaSpSC8tlJGYZBF9qo3eb4vNum9F13eitJHzXPYUDqmmgWxgcnTCcQO9QgD1aH6zhXGmXMXqqs2BV1/9WJ7ekNmtWqO7XV5oYUT659GdwFxXVWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bVQnp6MN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21BCE220;
	Thu, 19 Sep 2024 16:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726755922;
	bh=s1FeyuPuKAIkLxdmr7dFkDqlUjqdMhFEPRBAKufHSN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bVQnp6MN+PMKmgP6Duaony/7IgS93qcalJy/OluC/T6k9ONrcrNZhqF7C/vIvare3
	 51+IBI2df3qDIyhFrpF82Z0xOm2KzL3cL3L7xzcOhUH3d37qpioaNHaUHEgXOwYFzr
	 30Mf0S7Ml2jBmX+dgIN4Hb8jrGjeZVcjlTKupAXI=
Message-ID: <19b477a1-635c-4197-b63a-14d10d0d0a34@ideasonboard.com>
Date: Thu, 19 Sep 2024 19:56:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] staging: vchiq_core: Consolidate bulk xfer helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Stefan Wahren <wahrenst@gmx.net>
References: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

forgot to mention, series to is built and tested on top of

"[PATCH 0/6] staging: vchiq_core: bulk xfer killable() completions"

https://lore.kernel.org/linux-staging/20240918163100.870596-1-umang.jain@ideasonboard.com/T/#t

On 19/09/24 7:51 pm, Umang Jain wrote:
> Few functions were identified were their declaration, definition
> and usage were spread (incorrectly) across vchiq_core and vchiq_arm.
>
> These are being consolidated into vchiq_core in this series.
> Please look at individual patches for details.
>
> 2/3 is in particular a big one. The code is just a move, but
> seems big - as it was diffcult to split it into smaller, compilable
> hunks of individual patches.
>
> Umang Jain (3):
>    staging: vchiq_core: Move remote_event_signal() vchiq_core
>    staging: vchiq_core: Move bulk data functions in vchiq_core
>    staging: vchiq_core: Drop vchiq_pagelist.h
>
>   .../interface/vchiq_arm/vchiq_arm.c           | 356 ------------------
>   .../interface/vchiq_arm/vchiq_core.c          | 350 +++++++++++++++++
>   .../interface/vchiq_arm/vchiq_core.h          |  30 +-
>   .../interface/vchiq_arm/vchiq_pagelist.h      |  21 --
>   4 files changed, 373 insertions(+), 384 deletions(-)
>   delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
>


