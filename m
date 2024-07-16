Return-Path: <linux-kernel+bounces-253343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED4E931FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CFA1F21F59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF5915E9B;
	Tue, 16 Jul 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sRls5mRj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xf6/6dhP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD8C8F3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721105586; cv=none; b=izOEKFSBI9CtDT93v0oM/dronDO6P/GzglWOMiEeuPcNwR0pp/cYBu6nAMgc0wTVRdKJvNB6ecthnM/0gf3xlbU3+KMiouTF29n/P+ZptJtxR7p66Od071hAV4dOyV086lVYcd6lGZfYYgp0x2yE54ox5EYtmEsEV5M8uayPlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721105586; c=relaxed/simple;
	bh=/OtZk5m2UAV+NT0SE9NvB+kPppU+AJ1Ye3V5x6ixlek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CeivMQxzAVBDRHOWQY3Kgs23y+M4QaTvdvcI88QT72v5+3Un2EkgVwSXgjWfJa1W/CcrGMzw8ZpN97sCaftSq7EivVGVP6E8ogKNx6n4tfG1D2fDwaCNTfaF0yl0TTBXkuPUBInclgYCMsX5YnYIjQlnyd3z3BjV4srxVqYLwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sRls5mRj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xf6/6dhP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721105584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gg14NXJzPuenCuOxUfFLndl7rlyCYD39HTI4xWO9j7s=;
	b=sRls5mRj+jbw1P4xLtrFBQ582SC++QsUTjQFAxHuQyFq5J1XRnLVFc2++1akadtJX23FKq
	qhgFS+17pZJN+ctZfzBrmFTkzMi92IwPAHDiRECNgmUWtUkDwFw334OwGDU0Q4OiFX+Iq8
	ejowUSLo2prMxos5GQjhCrlEUaylwe/OpguJ6iQT+JVBlPHrtfFc5K1b4EtPMb1hLFuctV
	XCx8pmPAzLH95lViOgEZFwYPpuorgWeUntQYABsmVGpkupj1Rfs9PyAhX2j/IAbklUvMyS
	eW7gNbdM5uzRRaNkkRcy9z8MdRnVCAUebeKGqKvRkf6dFD1c9hwwiRzeg1kjWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721105584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gg14NXJzPuenCuOxUfFLndl7rlyCYD39HTI4xWO9j7s=;
	b=Xf6/6dhP0cj+cUSFTYtVremP7c2zMnyzvvHP1J+o+NAy9ZHt98L+WtYV4QgxR5FZpQnmLK
	5ochXKKFSPYEnPAg==
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Zijlstra
 <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2 2/3] cpu/hotplug: Weak fallback for
 arch_cpuhp_init_parallel_bringup
In-Reply-To: <20240715-loongarch-hotplug-v2-2-7d18b3d46b11@flygoat.com>
References: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
 <20240715-loongarch-hotplug-v2-2-7d18b3d46b11@flygoat.com>
Date: Tue, 16 Jul 2024 06:53:03 +0200
Message-ID: <87cyneq6og.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 15 2024 at 21:35, Jiaxun Yang wrote:
> It is a general assumption that architectures entitled to parallel
> bringup with CONFIG_HOTPLUG_PARALLEL do expect parallel bringup to
> be available.

I can't parse that sentence.

> Provide a weak fallback arch_cpuhp_init_parallel_bringup function
> to match this assumption.

I assume you want to say something like this:

 CONFIG_HOTPLUG_PARALLEL expects the architecture to implement
 arch_cpuhp_init_parallel_bringup() to decide whether paralllel hotplug
 is possible and to do the necessary architecture specific
 initialization.

 There are architectures which can enable it unconditionally and do not
 require architecture specific initialization.

 Provide a wark fallback for arch_cpuhp_init_parallel_bringup() so that
 such architectures are not forced to implement empty stub functions.

Thanks,

        tglx

