Return-Path: <linux-kernel+bounces-271092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644CB944964
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886761C20F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA1170A33;
	Thu,  1 Aug 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YZDDq0Ye";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vH2A30OZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A73BBE5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508581; cv=none; b=krabKzmTgjzgqpxL5ea2iBsCkkW+1Z1XDrxRdF+Y3cihwMD8Hcbz0qbGiWLYaAjLxoqIGd0eoGaolJPfC7dnydDmEbMI8clvXntG1i1RGRCnxy6l+KV5E+BCxYeUnA03xCJH1oR03JPdvFx29YYXPmmNi1KKWW/SIvEgkpd18Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508581; c=relaxed/simple;
	bh=5wXmqN7cEw8KxW7zGPiqdIYQ6j409CQOBB1zUcyNIoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ggxkZLTZJad0DcPtQ7MZyHY9KUPgAfIhBZt/KAWvFs4CR5YOmrlvd5CKhLgHua6LF7+Flq8eCMTVshcpk7sGVvuHoYFoFwcMH/oszFQNW9BNtGTw+JrBDCndK8+CaBE/lz8ZsV73s8Af2/BnaW7TsimsXsmGc9kA7IHv8iXAifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YZDDq0Ye; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vH2A30OZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722508577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pSGdedTnrKHyGVkygnUytyWdZqoA6ccx0V5Arx0A2o=;
	b=YZDDq0YeYlcFlFz8zgHfnLJpNr4EDCzlGLaWR4lm985l5vuDRRvnIkcI6rP8/pF75pJU3D
	OFcHyyP7xBI+TtoLud3ZUqWlulyRHRGc56oHNHOpt8XFQZWMgl7rKxoGOX3kWAA8nE0/Of
	stQ+p9ZDXUwMGj8qCgpPUWyQU6zeqeN2r0OdilmiwdFIiJbmcF7IrUvWx9mF1fEIiA3M+7
	JOJSK25ZH1jn2OP4YdWybzZEoK19W0VyNe6aV3GHf6fnwzjNBE+jv4csFrhu+pSWTPAJrx
	IYFWSkbD93B/U38hLGAnoKzYJ6MovRvmBm9LMS/gbOetpvax5aU9gkq//Umxbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722508577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pSGdedTnrKHyGVkygnUytyWdZqoA6ccx0V5Arx0A2o=;
	b=vH2A30OZZV7ITVYUpIAF2gS72r5BOxeA8JZgDoC+UfePCVPovEM2vegvtBuH1at0vGrlqT
	r6msIPD3wksROgAg==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [RFC PATCH 0/3] drm/log: Introduce a new boot logger to draw
 the kmsg on the screen
In-Reply-To: <20240801100640.462606-1-jfalempe@redhat.com>
References: <20240801100640.462606-1-jfalempe@redhat.com>
Date: Thu, 01 Aug 2024 12:42:17 +0206
Message-ID: <87r0b8zg0u.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>  * I tried to use the new nbcon interface, but didn't get any message
>  from the write_atomic() callback, but the goal is to use that when
>  it's ready.

Be aware that the write_atomic() callback _must_ also print from NMI
context. write_thread() may be the callback you are interested
instead. Note that for CON_NBCON, write_atomic() is optional,
write_thread() is mandatory.

Disclaimer: All of this currently only available in the PREEMPT_RT
patchset. So until it hits mainline, semantics may yet change.

John Ogness

