Return-Path: <linux-kernel+bounces-368449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61B9A0FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337C0B2294B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D92101A3;
	Wed, 16 Oct 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nkkt5QsK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+cGKVfL7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEB186E54
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096691; cv=none; b=Zp+UZPjuFcwwWLAeLnuMJBDBeJD4Ff7zScHjLF5vkhhpzeOKkO0n3aWnnlqj7qk1/0kSl/dZ8koY0FAiqJ0Hu1qZZuStGsVTF/SjE0bGDlUC9W0m7pyMRsQV1EjIQJfhFPntmXoQ7YA/+VGH3qTEVjRVRXUTwDx9NDRLhHQ0Rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096691; c=relaxed/simple;
	bh=/JRgY6v3vVDLJdmmWmMTSn3lGOmg9Wodcw/LR92PgGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udjv/EG30DtUdGSk3/IDzRAMsnuNv0gl1x3PQqHUuaOkmyXfbakUmxsZeVRwogw0YWSBU4okJpsPORWYCAYSDVPyu+zfNha8KPsMA9/c0qwBJe7Xi1R1SNg3ciUnKy+PTpFcmobL1fi8TvP5v0+sZv3ZXbLyZXFFCfcMRAvEMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nkkt5QsK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+cGKVfL7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729096688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQd8DtA+iW1m0FmZBPv+tfBhOg80y4eKkAWgUNhOCrE=;
	b=Nkkt5QsKWBjC07ItHtUwgMyzOPJ7G+7o2VrwW4hoIQSlWgEnXc6N3+00P4lAmI/YQvZxi9
	MFGQZ9r5jhIzgr0FQPdMa86ktUAXtpZXO09pdOJrfWp9kMvMTdGTrOmdysGHUM8j8rhtYS
	zcxwJM1G4+qokPqyaEpbFGyVhABgzVwXSxrruamhK9DuRV6lTyWM7vLbjqTKDzbQi6a3t9
	BL/130EJnfQlnL/sJZXNTjWRmpbyfcA9VsG4/FrYwx78v8+SfrQiUGX5ESH6vz2ZwABXm8
	vbQIqyTzIvVA4WG7M3J+rvaqLjPcKKXCysi6sdjAKQgHP/NtpQOATcdiSfdlqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729096688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQd8DtA+iW1m0FmZBPv+tfBhOg80y4eKkAWgUNhOCrE=;
	b=+cGKVfL7DNpuqYKZ97dHOLxjQvApg33uqYqhKRyV/MoWQQDLTtiLGlxqQN2kl9pnzbQt7X
	O1UHyd1j7ShFQRDQ==
To: Guillaume La Roque <glaroque@baylibre.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vishalm@ti.com, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kevin
 Hilman <khilman@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH v3 1/2] irqchip: Kconfig: module build support for the
 TI interrupt router driver
In-Reply-To: <20241016-timodules-v3-1-fa71091ade98@baylibre.com>
References: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
 <20241016-timodules-v3-1-fa71091ade98@baylibre.com>
Date: Wed, 16 Oct 2024 18:38:07 +0200
Message-ID: <875xpsatqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 16 2024 at 11:41, Guillaume La Roque wrote:
> From: Nicolas Frayer <nfrayer@baylibre.com>

irqchip: Kconfig: is not a valid prefix.

This is about the TI SCI router, so this wants to use the
irqchip/ti-whatever prefix.

>
> Added module build support in Kconfig for the TI SCI interrupt router
> driver

Added?

This wants to be 'Add ...'

You fail to explain why it is valid to build this as a module, i.e. you
did the analysis that there is no dependency on this before modules can
be loaded.

>  MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
>  MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
> +MODULE_LICENSE("GPL");

This change is not mentioned in the change log.

Thanks,

        tglx

