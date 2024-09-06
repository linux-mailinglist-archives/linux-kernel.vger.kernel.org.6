Return-Path: <linux-kernel+bounces-318475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372F96EE83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0828B20E16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC114A604;
	Fri,  6 Sep 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jmHTdtdU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4EvLS17"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8781FAA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612449; cv=none; b=E0/Oh0qM7lww8yVEm7RSi43bJBovEJbfOO7yC5kb2mxeK08x/qf8eR7zgeepdS4fA6DMVm6tFn7nHfbSsOW38ABypoI+UhmXq+GOblR36VMdNO5qd5jQPxpGNfElcFD4JKXrAoAGhCwNShe7O+7/JT3dBP9kksM6KN9IPYiKETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612449; c=relaxed/simple;
	bh=Oa8B0exPuHorkfb3VBgoef687xB6sMs73RRCB0C9WhI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7tRV9W7KtQ+fc4eNvmzSuz6vEcKooXY7tEzIZeLNGhRirs3tu4dr2NQE14u8nYtqlsWErXkuTJgQO4zlSPRUSY75ABIIRfUyZ23Onl49zK7Xkw7W4mQHAKAPO8gS7XY5knn3fgJFh9kKG6CW5j+C5mqEhfxGiM7EivwFX8CV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jmHTdtdU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4EvLS17; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725612445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa8B0exPuHorkfb3VBgoef687xB6sMs73RRCB0C9WhI=;
	b=jmHTdtdUGvZY4c5xEMGMPt8nSh9czuB7Jj3l9qfv9EQigYmGn3Ie9SEOdanBnAHuPojb7l
	hUgVGAdt7WpDxjVkLzCObUOrc4wsqiVEURn3vfiVd+CKSgRCsnrN9ecA94HQbkIFgi1Hr9
	NlDzC73sZikE6Er/v5CtxHroxj8eNasoNl+SmnxIYVbu4xuSS1PwNy/56spFcGxTpi10oj
	3alpK/SvjsKYfNSt8ACVCEhta4rwCvERxeFiwfSADG5TwSM85dcyBt2QhOCX9TS7alaP6V
	Ruwd63raIZjTRYXFDwOQj3yBsIdr5UY0vqEWeFFJ3SXDmGRlN3tHPj60/CZuxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725612445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa8B0exPuHorkfb3VBgoef687xB6sMs73RRCB0C9WhI=;
	b=p4EvLS17dbTj5Ob8xY8Oe8RB2BbwrpnLWY2cdQDAt6u+h2mzS9aSCA82XaY0xA2fN/usUZ
	PBAoxx6bWkAvNkBA==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] drm/log: Introduce a new boot logger to draw
 the kmsg on the screen
In-Reply-To: <87seudchlu.fsf@jogness.linutronix.de>
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
 <87o76czfb2.fsf@jogness.linutronix.de>
 <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
 <87zfpwxqpc.fsf@jogness.linutronix.de>
 <87a5gm2khw.fsf@jogness.linutronix.de>
 <a421b31b-53ad-4f56-88be-66a7d4c3bb61@redhat.com>
 <87seudchlu.fsf@jogness.linutronix.de>
Date: Fri, 06 Sep 2024 10:53:25 +0206
Message-ID: <87plphcgo2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-06, John Ogness <john.ogness@linutronix.de> wrote:
> Your device_lock()/device_unlock() callbacks probably just need to
> lock/unlock your mutex @drm_log_lock.

Sorry, forgot to mention that the device_lock() callback must also
disable migration. Since you are using a mutex, you will need to
manually do that as well...

mutex_lock(&drm_log_lock);
migrate_disable();

John

