Return-Path: <linux-kernel+bounces-271423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532B944E04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6261F265F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3421A57CC;
	Thu,  1 Aug 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaJtkggl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8SRgewnh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94901A57C5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522515; cv=none; b=FUF0zUsUTfed3j4Y3UncRJiYRiI+Z7u6j7hGYDM5sXELoA7GW4bt9Ipac6Us6IbE7EEFFjLHHCO9tUs7/b+Gv4jrCY73T06lhgnb7CsOCaqNETWoXStpfLev2kZkMLaWjy9xQX6zDRyQQlZCTJ087mj7+x33iGC+VoPRS1qpTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522515; c=relaxed/simple;
	bh=IIQ5uRwYXhoY3X2ooGCX30n8xR3R9831eLGQsegoiWE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aglCwb+b+lw/xCkYjtZEHZam29hee4sV0t5xjadydIdtMG2Z0KRjr5/Y09/2qeS7H7fmlYF5dIQAPVmkvVCMy32MMJEOLgaogFXmNs8gC4uW6QlGnZePChGmH/GqL9gYQqlycmC+XuWmYzkVOOvyirLFoow3BkLODctKAjzM4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaJtkggl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8SRgewnh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722522512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IIQ5uRwYXhoY3X2ooGCX30n8xR3R9831eLGQsegoiWE=;
	b=YaJtkgglPssTF6lKCViNqI0lvCwRJqTAwPbnlo6rT4qz+2GQupGefTP4MfyV2sqS60jn9C
	ofbCKyBDMDaAb0MEQ5nwYROoA8vCkx8TGHLHeJWs6XO7qVC7DY1auIwkEfeljJGns0fDWE
	+mM8hTGzlaf/NRFU3P9hWjrDftDzDasj5nJWHpyZ/wJ7Tcb2Ij5DZlQq4yBpuabm9IAwqV
	SWS/qgfRD+8Q3KClKe+EaIZz4opB46JroGz9vqAlh6hR/vJtol4gpVhzJ+ImUzIjq5ksou
	OMLuipseA6+l68dAFU+646t0bI/OTjHXx6Oq06qdBLFea48xK9WmzOPI5HQOhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722522512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IIQ5uRwYXhoY3X2ooGCX30n8xR3R9831eLGQsegoiWE=;
	b=8SRgewnhoFhfMIxvgWvp+pLp+3Wpt89xZ3dqNs28rkUAK+kUvWfLZIWEjuUuSrKnAc9Ogn
	P5dbywfp+U27s0Cw==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] drm/log: Introduce a new boot logger to draw
 the kmsg on the screen
In-Reply-To: <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
 <87o76czfb2.fsf@jogness.linutronix.de>
 <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
Date: Thu, 01 Aug 2024 16:34:31 +0206
Message-ID: <87zfpwxqpc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> I think I can also register one console for each drm driver, which
> will simplify drm_log even further. (currently it would mean having a
> circular buffer and work function for each driver which is a bit too
> much).

Indeed.

> Do you know if there is a chance to have write_thread() in 6.12 or
> 6.13 ?

Sorry, I have no crystal ball. Petr Mladek and I are working really hard
to get things in shape for mainline. I do think there is a chance for
the 6.12 merge window. But it would also need to get past Linus. Our
recent atomic console efforts were rejected [0] for the 6.11 merge
window. We are working to get that series in shape for 6.12 in parallel.

John

[0] https://lore.kernel.org/lkml/CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com

