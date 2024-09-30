Return-Path: <linux-kernel+bounces-343452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A37989B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2275C28205C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AA537FF;
	Mon, 30 Sep 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m8VXD7ya"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFB45027
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680110; cv=none; b=rQy9Mmkr/xSb7SkI6VDoKxHh8VFhDthxK4L/5+Es81zmvIrFRRJnErkbZydw5p/Vn0i+JqD8FZdHrMXr+C37CE9o0Xt2gEDNawS//PC4mymOcJudH5j5eyyiff7wLzTSZ67GfdvgNjkArEqgLMXMF6x0YNb6u8K51dBTiFETib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680110; c=relaxed/simple;
	bh=D25fOXeJbLoKGgr27NS29CleC8T4/PtWnoBorQk9jHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYKg8V63Cl9ZQ62npP7dNgMJgMv3JVrIt2M595EUMOyOkIIX/7PWf1NRlB+tOnK8dTEmoqb/5Vvx9wxoCPrk2l6WUswfVDKjcIKzPS+laIJ+IO5Kq5Yj8tbSjgIHk9aFAvpOxt4zMOuE3PxOxRFGmHxi1XOVEkCdUCjxW/0HIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m8VXD7ya; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727680101;
	bh=D25fOXeJbLoKGgr27NS29CleC8T4/PtWnoBorQk9jHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8VXD7yaNlqpy+yBCJaX/rnIFHb9Ff0X59herYW2wRQiDBZuComAQE7Nd08D9KWUj
	 X1qfkL3m9FkjmZVWqCwtiHoxN1EEQlLInQMBmSA7fPiFTT/ptnmdKcexqWShW4YI4q
	 fGPU7OYFNlPr/wFURAl9W0Qk5Q8NN2XVivnir6afdseodqtp4EG0Au4MlY1ZXNoy07
	 dT3AnDK2i4SPXSFitEpiOqmQyDlRosqu4INj/bK0isX0MWlvJjkxNP7Wvr3pe4Xfcf
	 KD4PGqyXiNJWGq8Pl8MFb6juYPHYBieu887Fgdt4YO9vnXf8ZhUsVKYXXesW7WAOpa
	 NuJb2nsfRVvww==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3035D17E1003;
	Mon, 30 Sep 2024 09:08:21 +0200 (CEST)
Date: Mon, 30 Sep 2024 09:08:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: nicolas.ferre@microchip.com, miquel.raynal@bootlin.com, richard@nod.at,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: of atmel_pmecc_destroy_user
Message-ID: <20240930090817.0a86e538@collabora.com>
In-Reply-To: <ZvmIvRJCf6VhHvpo@gallifrey>
References: <ZvmIvRJCf6VhHvpo@gallifrey>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi David,

On Sun, 29 Sep 2024 17:05:01 +0000
"Dr. David Alan Gilbert" <linux@treblig.org> wrote:

> Hi Boris and co,
>   One of my scripts noticed that 'atmel_pmecc_destroy_user'
> isn't called anywhere; I was going to delete it, but hmm, I wonder
> if it's actually a missing call and leaking (in the unlikely case
> the device was ever removed).
> 
> It was added by your:
>   commit f88fc122cc34c2545dec9562eaab121494e401ef
>   Author: Boris Brezillon <bbrezillon@kernel.org>
>   Date:   Thu Mar 16 09:02:40 2017 +0100
> 
>     mtd: nand: Cleanup/rework the atmel_nand driver
> 
> and I see the allocation in:
>      user = kzalloc(size, GFP_KERNEL);
>        in
>      nand->pmecc = atmel_pmecc_create_user(nc->pmecc, &req);
>        called in atmel_nand_pmecc_init
>          from atmel_nand_ecc_init
>            from atmel_hsmc_nand_ecc_init
>  
> But I don't see any freeing.
> 
> (I don't knowingly have hardware to test a fix, although I guess
> there's probably one somewhere....)
> 
> Suggestions?

There's definitely a leak. I haven't looked at NAND stuff for a while
though, so I'll let Miquel advise you on where
atmel_pmecc_destroy_user() should be called.

Regards,

Boris

