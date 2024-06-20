Return-Path: <linux-kernel+bounces-222797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0CB9107B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA8C1C21D45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F51AD4B6;
	Thu, 20 Jun 2024 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SosjpOJV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C91AB91B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892802; cv=none; b=aK4agXT4HVzWQWlILXtbEJhhhlFVpSG94CPqCQRjp8H0Y6JpTBg/datDMUGAxF7lSE1QIwTfw5DcX3UiiE+OYKrE3FKBAGg/dbiVO6Kwm9Dfslpwyvur5H8+imaRkwT1kgXQKThfF8sgfMk7SbYbxaNf8xYJ/a2BAzg1QqNujx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892802; c=relaxed/simple;
	bh=olSiu3J+EtvKE9a90Hz+Sv8Z0VuG5pOr75ws0mWvlSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIcZxOA1xVSM0cMF+wFmcrpycU5evZvZIUwR9ayxftak24BQ53/qBJ2Mu2iX47Dv1wsiEUO+Xzd1NdQmx7ypxX50K5csbOPph5A8AdyQPUby6LZIXK8WuzomXTJ7OAoPOFycwI4SI1V8TqL/WoH7K2Zi1gM7/BEkpN19XCD5/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SosjpOJV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718892799;
	bh=olSiu3J+EtvKE9a90Hz+Sv8Z0VuG5pOr75ws0mWvlSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SosjpOJVY4lojik3GdezMYF6eS5mJbcN1xlua2+2zcVM9P9Bt1BFg1/C7ZOL7qzJn
	 fhMrLnHvJkQULepPXbu1yO/iEek+7L/4hDo4bMyglCQ6OoG1gDrYXrj5vztxJ21hEM
	 PZe2CdTMXNdOPccljc8Br22686dw8xQMuzQQVneRRA3JFG6NvPDAqzjGjvlYmfFV7p
	 QnsEbTqSyM0oWbfD8/exWc8/3NvFNcbwh6xUxTMIygL0zbrT4Ldk7E84oyWni9WfjF
	 bjKGCKAThtMyl7lNtzaPAAWsM2plaulqcuU0G5ugBzaJdubCLYUgldLxvp7pVRhzgi
	 oDzH1GNXa1XWA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 07D2437821D3;
	Thu, 20 Jun 2024 14:13:18 +0000 (UTC)
Date: Thu, 20 Jun 2024 16:13:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Hari.PrasathGE@microchip.com>, <Dharma.B@microchip.com>,
 <sam@ravnborg.org>, <bbrezillon@kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: update Microchip's Atmel-HLCDC driver
 maintainers
Message-ID: <20240620161317.063833a9@collabora.com>
In-Reply-To: <20240620095856.777390-1-manikandan.m@microchip.com>
References: <20240620095856.777390-1-manikandan.m@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:28:56 +0530
Manikandan Muralidharan <manikandan.m@microchip.com> wrote:

> Drop Sam Ravnborg and Boris Brezillon as they are no longer interested in
> maintaining the drivers. Add myself and Dharma Balasubiramani as the
> Maintainer and co-maintainer for Microchip's Atmel-HLCDC driver.
> Thanks for their work.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1566c647a50..8f2a40285544 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7290,8 +7290,8 @@ F:	drivers/gpu/drm/ci/xfails/meson*
>  F:	drivers/gpu/drm/meson/
>  
>  DRM DRIVERS FOR ATMEL HLCDC
> -M:	Sam Ravnborg <sam@ravnborg.org>
> -M:	Boris Brezillon <bbrezillon@kernel.org>
> +M:	Manikandan Muralidharan <manikandan.m@microchip.com>
> +M:	Dharma Balasubiramani <dharma.b@microchip.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git


