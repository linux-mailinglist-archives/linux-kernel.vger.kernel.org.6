Return-Path: <linux-kernel+bounces-374530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565139A6B99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A71F216C9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A91F427B;
	Mon, 21 Oct 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R+ZT0LCk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C211E526
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519684; cv=none; b=VSoOd8waGSGYzqZAUeIh+vbsy5UGJ4jWXAGHA7wSwNGuiir80vZqqqz2zYS0BcIGRmh7pxfsYy5p669uhrgUsxFTdUes6AumbMzy++apQ7zKG7Ua6wTUuIKAvPEx298qjzux57CorQoJCSvIrLr/rQDY3+msqtL9oNZEi0IJQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519684; c=relaxed/simple;
	bh=hp1nFcv/cw2s7r/PFwgkDdXRyrA3l8PSWu+z40NPYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lus8iR0ROP6MRdsZ+DT0BuPvDDNx1y3e1aTqneQuNUza7vbfsgovEjdqt3eGcxHjwGpkW4L6zjinOs0jxhX2WtKiTMUQ+Aiv9WdeyYB+ssQgDMEmYRIHrR4QXdOUDreSpVxhMaN61R4eXWyh+VoS4DyLeP75SuezUNjliClouuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R+ZT0LCk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729519680;
	bh=hp1nFcv/cw2s7r/PFwgkDdXRyrA3l8PSWu+z40NPYF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+ZT0LCkIgysznj3jyQGw/RCgT60fIQRhn13UUZHe5CGoSZ3H71HAMXwKIAsKX8od
	 HcqAYENXbN5F109ijKQBbKPYa+zlp4YiUpkdXFKxUQ6pzDIhceodsqWaNwZQ2PA6Q+
	 HbOtJsjmdNLfi8wd3yfFZeGUzWvxGhKRIsXO4gu4cbIepxaOXIR+9eWAi5JotCF7MG
	 SPNSqSjdq66UJxWe1rYV6GfSqPFnjqUkfCApmuVey3uJqfb61ZR5f2mes2Tkul6GQ3
	 PNRB0RM2IVJpeoEpGl7UxyNKsdLU8QnJy4S02yP9sCROCqTHHu3d/rEqg3Q3uMaYpQ
	 TUGtGvinFC0iA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0484D17E361F;
	Mon, 21 Oct 2024 16:07:59 +0200 (CEST)
Date: Mon, 21 Oct 2024 16:07:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] drm/panfrost: handle error when allocating AS
 number
Message-ID: <20241021160756.442e7e55@collabora.com>
In-Reply-To: <20241014233758.994861-3-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
	<20241014233758.994861-3-adrian.larumbe@collabora.com>
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

On Tue, 15 Oct 2024 00:31:38 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> -u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_m=
mu *mmu)
> +int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_m=
mu *mmu, u32 *asi)

Or, we return an int that encodes the AS id when >=3D 0, and the error
code when < 0.

>  {
>  	int as;

