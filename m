Return-Path: <linux-kernel+bounces-569264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8CCA6A0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3D01894CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBAC1EE034;
	Thu, 20 Mar 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j+mT875P"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9311BE251
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456944; cv=none; b=P60qK5685dyYdOjy1Bx9nO+YwPRi76KP7V3Lg25vLJtgCnTDxaUQZbJejk5+tojq2Qx0bg0UsFRRgmAfr1I7W85W51dh+2iN990DdPHPrPSSsQYO5DC7nYDB5N2EbTUbzraWh+4NSSwNgmwZ4sNeztMYwHb2MzPgKIh96mgSAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456944; c=relaxed/simple;
	bh=VEdQkK/M+AHwY+qnwBstoqwJ9cdmVKhiNgj+o7GwjyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl6QJYQqnrDb+Bndr5cKuX5uIslHsNvgCxIU5W+ROe10/wRJTLpC0B6HTqjl6k8/FFVrQMVDipKfiEeHM2UgsHVYFi/OcUmNWOd8VRAnlN1zPe/wijCqGIpBeARz3MCc5DfiAks9Ru0NvMDZ0syzvl/Yl4sNFxcZIh3xiyQuynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j+mT875P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742456939;
	bh=VEdQkK/M+AHwY+qnwBstoqwJ9cdmVKhiNgj+o7GwjyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j+mT875PgH3qCuHWdopTEF922HTEWxsQfNNs1FqbCjPLRLW4iYDX6Ofww+qncNhMQ
	 uwVWtoi9eVsZ604BswYZf16lLC1+uypnQcKKwqElozxuOPdBTBKhRiMV7peYETdw2d
	 7o07uUfztUY2byQhg5bgGJFktbB+2BaZpdfQYwf3Ewa/XmThDnqFwOQ3EAFt3uZUbm
	 nH0dBx5j7L9C1NzjVMkoYB1V5gK1MMSv+1hV3zhBNwuF8a1ilwecKbeG4xdhN4ibKc
	 AcGsPTdX/xN9iTArNn9ARbnkkZSexhdb/JBXek8PsOmWhUwgZRMWtyRuC0vvwV82Ve
	 ZHdbXwUzPKHKw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 22E3017E0B46;
	Thu, 20 Mar 2025 08:48:59 +0100 (CET)
Date: Thu, 20 Mar 2025 08:48:54 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: <Hari.PrasathGE@microchip.com>
Cc: <Manikandan.M@microchip.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <Dharma.B@microchip.com>,
 <sam@ravnborg.org>, <bbrezillon@kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: update Microchip's Atmel-HLCDC driver
 maintainers
Message-ID: <20250320084854.49d61c2a@collabora.com>
In-Reply-To: <662be697-acdb-42c2-8078-6baeb985a4ba@microchip.com>
References: <20240620095856.777390-1-manikandan.m@microchip.com>
	<20240620161317.063833a9@collabora.com>
	<662be697-acdb-42c2-8078-6baeb985a4ba@microchip.com>
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

On Mon, 17 Mar 2025 08:30:51 +0000
<Hari.PrasathGE@microchip.com> wrote:

> Hello,
> 
> On 6/20/24 7:43 PM, Boris Brezillon wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, 20 Jun 2024 15:28:56 +0530
> > Manikandan Muralidharan <manikandan.m@microchip.com> wrote:
> >   
> >> Drop Sam Ravnborg and Boris Brezillon as they are no longer interested in
> >> maintaining the drivers. Add myself and Dharma Balasubiramani as the
> >> Maintainer and co-maintainer for Microchip's Atmel-HLCDC driver.
> >> Thanks for their work.
> >>
> >> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>  
> > 
> > Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> >   
> 
> Looks like this patch is still not applied. May I know if there is 
> anything do be done from our side ?

Uh, sorry about that, I thought it had been applied by Sam. I just
queued the patch to drm-misc-next. Sorry again for the delay.

Regards,

Boris

