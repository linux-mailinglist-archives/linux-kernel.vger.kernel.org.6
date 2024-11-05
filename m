Return-Path: <linux-kernel+bounces-396478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F59BCDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619821F21EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305CD1D5AA9;
	Tue,  5 Nov 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCnOLWs0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bk3Uo3Aw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E01D416A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812635; cv=none; b=GI7QZwX2TS3MBNjZx0IwUaKkK4eDY+Uz/g8scFt0yXr+/Qbub0wNZ2e9GwjyGTtZfRu7C4Z5TgjKw8QKY6ezPsjp9YgmutxJokPqACOJNZFOUe8yghJSADiBOhMzZqtwA2Glcp9f3/x6vyZiLmW7hK7JTvpNNKIFs+pfgNKM1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812635; c=relaxed/simple;
	bh=K4W2DVwjGFKZ4BCBSaN1M0hjr3+iDj0J8sxoOxVTCYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VX6uuJUy+fvmNia/2+RdNayU+AcWSHw0QwecAMljZm5ysmbOVZ5SoupO1Y0oyN4Lv1IKdGxZHnsTE0KQsrm57QgphmB4hhrkKRtTI/NVZlg6pybI7hsyJn1p6zEsFHAp6z4+1NubxJ8JFlLD3nLZWLu3dwzmTZ/PTgun5lxjr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCnOLWs0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bk3Uo3Aw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730812632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4W2DVwjGFKZ4BCBSaN1M0hjr3+iDj0J8sxoOxVTCYw=;
	b=RCnOLWs0E22uRdavElFnBEMBIbwd4S0uRs38a/Pt25hmnTWWAkI0zCJKSdquJORW6JKMUT
	GWNwR+QajenzBuxyK4pTEuxgVEuEw1LWwJL26xVmTCitWwyz5AoVB7Hn8z6wkggOWEeQZL
	SZMOW/m+sY+Xf0Sp2WagmZeFJ1+8nmbrCWVgtKQbNLYn4/E+sSOUVdCnI/34d4KIc/9Yl4
	D2Yf89bQ3KasXYjN11El59/B2Jv0PldWaT9t+ySaTGAflLSYCov2o531hHLia8egsrQtof
	d+1LUW9usp8kZ0OTpMleVe2UPQ3V6TvUsk1ma2rDsM/f38plptFtOYh/RATaeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730812632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4W2DVwjGFKZ4BCBSaN1M0hjr3+iDj0J8sxoOxVTCYw=;
	b=bk3Uo3Awv+CfakV5KFLy+VM6RJhAAZ1LibiIK52jef3AoJA4VE5nVhIXTRVxi8EB7u6ia2
	yz/OjmV6H5tuPaCg==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v6 5/6] drm/log: Implement suspend/resume
In-Reply-To: <20241105125109.226866-6-jfalempe@redhat.com>
References: <20241105125109.226866-1-jfalempe@redhat.com>
 <20241105125109.226866-6-jfalempe@redhat.com>
Date: Tue, 05 Nov 2024 14:23:11 +0106
Message-ID: <84cyj9es6g.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-05, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> Normally the console is already suspended when the graphic driver
> suspend callback is called, but if the parameter no_console_suspend
> is set, it might still be active.
> So call console_stop()/console_start() in the suspend/resume
> callbacks, to make sure it won't try to write to the framebuffer
> while the graphic driver is suspended.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

