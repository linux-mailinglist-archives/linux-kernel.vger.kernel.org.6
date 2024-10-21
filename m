Return-Path: <linux-kernel+bounces-374571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC669A6C27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278D7B22C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241D1F941B;
	Mon, 21 Oct 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FDqJ6/ir"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D81EABA5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521159; cv=none; b=g7Z2t3Nr3XkXTCedYVLLPEgTs85+zjY5csCRrXrEWIz7tO7X/yC5gmrUEGOvyWtKMmn9YZcHAVjkFTCLWVC8FDIpCeZCXAfqoRP7f4CXFQ3xbrvhP7mJ4hZ6OLJyvQJqoNH7/aObxOgYlFKuxLykJeKlfk+Dqyh5EMR0xzXNyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521159; c=relaxed/simple;
	bh=rn95rF2fboY7GstKLD34RXgjFuI1VKElP0eQ7RTRRHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlIAKeTIOi/PXkmyurl5oke+7hk0h0zpRPw831LgM6ZKKYJAy/w25yurCYa2lKRCU3Y7U8xvxhfZvZFZcbXXkyYGid2LYKFkg+X2I8YLPKoomAqX/SXKS31bIYhYIOao3OAYeKLLmB55GoKWof0MZ/A5WySaEMgmEAOr8atPQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FDqJ6/ir; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729521154;
	bh=rn95rF2fboY7GstKLD34RXgjFuI1VKElP0eQ7RTRRHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDqJ6/irESSCq15TiTom67nknR3uWIraqS3ZUlDpEOZwnoOg1T+p8wxMPwMZCS6gH
	 NuAaKishSdoBXZv9EankpJ1lwWzheHn9Idk9n9SlgiIpxOIRwc4f5gMz9FPcU1wJ0D
	 RdoCcOsHewd1jAwEBfskis7jLC8PFsnHEpfEaAkpzbU5QdCMNp5xYtFv2rKkrD8UW4
	 xRvZDZA+6HtAfFV/E5HBXkGRJVz6yS3+j2F5sN8YCvdM4Y9CM8qpa9C5e3glxUIqpw
	 Kxq3pq9Z/dJddjDY0Pg+/LkfdkcEmCEWYxgg0FThkckVjf8DxK7hoVuNSqrGsBbuR+
	 D9Gg+0sNkfNqg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9451D17E3624;
	Mon, 21 Oct 2024 16:32:33 +0200 (CEST)
Date: Mon, 21 Oct 2024 16:32:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] drm/panfrost: Handle page mapping failure
Message-ID: <20241021163227.1312bbcd@collabora.com>
In-Reply-To: <20241014233758.994861-5-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
	<20241014233758.994861-5-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 00:31:40 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> -			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
> +			ret =3D ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
>  				       GFP_KERNEL, &mapped);
> +			if (ret) {
> +				/* Unmap everything we mapped and bail out */
> +				mmu_unmap_range(mapped, start_iova, is_heap, ops);
> +				return ret;
> +			}

I'm pretty sure you don't need to know whether this is a heap BO or not
in that path. All you need to do is unmap what you've already mapped,
which gives you some guarantees:

- the pages you unmap must be present (no need to iova_to_phys())
- unmapping one 2M page at a time is not needed, because you know where
  the mapped region starts/ends, so you don't need this
  "is-this-the-end-of-the-heap-buffer" check that forces us to scan 2M
  at a time

