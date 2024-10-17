Return-Path: <linux-kernel+bounces-370004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8E9A25A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF2D1C21668
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E51DE898;
	Thu, 17 Oct 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="i7JNo3OL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67D5FDA7;
	Thu, 17 Oct 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176914; cv=none; b=Zu8L6wPyK59DZxKfSi1k3roJHhkTo6H/uFocG/8qFEfC7GD1rYS55CDvDOLbHF5l+XV/NmSVLCCW2xJpx7AJZVx9eIhwgnQvs4gRnpNkfV1bR4Qb4Ac0f0Ys7nbblka5NiWKwoSlQsFaZBrvWWPCuNsG/nwLJCXtYO2lYnpc7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176914; c=relaxed/simple;
	bh=DoFY2iD96+wqSuATKBb8JyxtIM8c5mXhhuF5A4bsgbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJp5VHcWsm3rpOu8HOcZ8h6x1UL2el2SFdyTGGWUY4JQ+9PPJsEANwbhDl+gDG8Bk7K9/vhOZjUchLRPnN5nd0Bu+6pufcWqHjrpnDVXdZ7AM9zdcv6vqxIAYes0dg4+Ude7pW8JdeJVuap4uwMJtJVEmWcjO+pQnRP5p5jaO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=i7JNo3OL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A9264188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729176903; bh=iGWdPCM32NaN8xEw15ApyIdxD1xtftBNW37FhOEMxmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i7JNo3OLhhJCSWX/qqHPPEk0vbSj4F5AAkXU2m0CFi8Aj7PMFCWFZo5Vu5/wbp/uS
	 U384SMNmnMUdELIk5kEDX8AJhhiIQfWg+LDav52M+Z28KrVGB+R+TbAouNG+tqplup
	 kO7zAAQTPfb6AnvDdiJglfh0w9EZSsaXxygLW6Pn5SsZjRAGKHVPawPQWb8ijP4I2i
	 It9z72XIz7N47/0JN+E7BYpksYabhfO2RzPK6zi4A1GtkaCxinHxPw9/OQbSYf2Bi1
	 8Uv4hkd4MeHyzxdLhWXktJaJIgSbPumEkV0ov0qmytxg8NfCK5KeGQmOKd04SQ5y7O
	 iq5Ij6syQ76Ew==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7A9264188F;
	Thu, 17 Oct 2024 14:55:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, seakeel@gmail.com, si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com, zenghui.yu@linux.dev, Pengyu Zhang
 <zpenya1314@gmail.com>, Mike Rapoport <rppt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 2/4] Docs/mm: Fix a mistake for pfn in page_tables.rst
In-Reply-To: <20241016141801.25487-3-zpenya1314@gmail.com>
References: <20241016141801.25487-1-zpenya1314@gmail.com>
 <20241016141801.25487-3-zpenya1314@gmail.com>
Date: Thu, 17 Oct 2024 08:55:02 -0600
Message-ID: <87o73i3hkp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pengyu Zhang <zpenya1314@gmail.com> writes:

> The documentation incorrectly calculate the pfn value as 0x3fffff,
> which should be 0x3ffff instead. It is obtained by right-shifting
> 0xffffc000 by 14 bits.
>
> This patch corrects the value to prevent any potential confusion
> for developers referencing this document.
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
> ---
> v5->v6:no changed
>  Documentation/mm/page_tables.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have already applied this one, there is no need to keep sending it.

jon

