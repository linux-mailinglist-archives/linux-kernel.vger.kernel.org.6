Return-Path: <linux-kernel+bounces-537981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6EA49339
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5AA3B4C23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C041245008;
	Fri, 28 Feb 2025 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="il+YwljU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90A242937
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730712; cv=none; b=au/BpS7VeiRgBz0DkGRdizRJ8yrQWl4DK3qecsssaAuB9Cf7as6qlvJHJXIM9BjG655eNlhEwJboy1NrRAURGdW/HnjSRa1+R36hICxXT0PvnNk3Bs6eATufcwK4XRk5R2WP9Md+Q76YwQiYWsvJt92CC40VsZlVCTZUbr6zKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730712; c=relaxed/simple;
	bh=g791kg9Jj13cPSH7pEkjvldmLvRdZOxf2VzDKwaVK74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKG0P1lxymZHGpMn8xmemd6HJF/YILU3tlTD1wBPLfwDGLySukcC553+dIK17KicXx2TH7ow8XTUinEBTiJwYDh4NLc+0rkp46jpcd8BpqDuvNU7K5xL9WyEY2sAE3M3tEk34x8nSCcGr9Ut7ZLEwTOJXX/imdQaq1l5N8pOyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=il+YwljU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740730708;
	bh=g791kg9Jj13cPSH7pEkjvldmLvRdZOxf2VzDKwaVK74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=il+YwljUM0dzlAlgcvtUcIG4r4cvos9WFqe7HoNh0VX1GyA4btPUFpWu7ZMgbHLb6
	 ZN1hYL1Xt+Gdg+iMwGHJyMjmEqrf6k/++MMmMLHRG7S0Ya15ubPmv26qrumBc0TONC
	 c+4zlo+nD9LgfuYloQ+cPB9vnsYQS1ifZV8KSHJ7OL1C+93j8FZIXAwTJ/F8JMKQuO
	 DND1cv3VH2OleNf/+NveRO8ywJvpWOyiv+mloyBGrBrkarQmSPExqsb5hnI0zkGsOI
	 6c12Z53GIl9f9egDkiCaiD0jmpE8sVPS50nOH1YdJshvXvo3IVm7sHAsHBRqaICZd1
	 B06/IDCm+GsBQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DBD6E17E017D;
	Fri, 28 Feb 2025 09:18:27 +0100 (CET)
Date: Fri, 28 Feb 2025 09:18:21 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Mihail Atanassov
 <mihail.atanassov@arm.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panthor: Avoid sleep locking in the internal
 BO size path
Message-ID: <20250228091821.75d4d436@collabora.com>
In-Reply-To: <20250227231628.4048738-2-adrian.larumbe@collabora.com>
References: <20250227231628.4048738-1-adrian.larumbe@collabora.com>
	<20250227231628.4048738-2-adrian.larumbe@collabora.com>
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

On Thu, 27 Feb 2025 23:16:26 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> -static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
> +static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  				    struct panthor_vm *vm,
>  				    struct panthor_heap *heap,
>  				    bool initial_chunk)

The pool has a ptdev and a vm, so we can get rid of the vm field and
make the panthor_alloc_heap_chunk() and panthor_fre_heap_chunk() helpers
consistent.

