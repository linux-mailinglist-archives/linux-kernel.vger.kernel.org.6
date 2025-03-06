Return-Path: <linux-kernel+bounces-548431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C75A544CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C0189534A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B81FECD1;
	Thu,  6 Mar 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PPtL/0f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfFJl2YR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98AA1F4185
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249523; cv=none; b=QOLQEzg+EushHDxRGeonsDqWIN8VIjoYZfkTorTWY+M7W0S2V8qKCXEY9KVQTsbbvE6RU/6oSHRDm8IysCQr0b36e4L6UgyUsdkUGNiBxrR4rfXukrxMJ9T6gJLKVkXAvlzf7dzw80hMEKaIjZwXOY5i9jvCd3UGl5or/JWtGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249523; c=relaxed/simple;
	bh=f/cqkpVb1cvH8U4ZCmN/tD41SBvW5iYNFF9xUxjQ64w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzT77Dl4yCxOMJNUumhzj2iQptRQpGkm1EL0RaX38isyphjMDlhLqybjmVNoqjYob2XGSW2tQALPUJp1DJLficD7fnic5Wm7vvsKDF4TkE1GCsYefDbGTrHJPtW2ec7pnoVOXJLjK0NC2VtgMGdIvg16Vi7WOstAzHo3R7LzpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PPtL/0f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfFJl2YR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741249519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnHbfXfIm2qhY9DKGP65PuhIGezx3zi3/iWr4kPG5Lk=;
	b=2PPtL/0fcvzaQy4appTbzF6E1AzfM0FqMTFMUzuITJn9XFftX5qUbycEdylw1+A5eW2oVA
	GPWvq/aHb3IW6XKJK+tL9dIo93bcZIbh/tNdxgHLf5c7RAXWhrmKvJN8vDMIr8Rad6aYzV
	h014fxFBQpd3pFxajuJBG2cTBPTrnlhIGiz4ReiD8YCqC57ZiHrw5X/m2RFPbfcSezxA+w
	3ZX5TJqwXgERe9DADn9CQPVZJpNSdFkho6c0P/ER49mSScuvoU2BkByC9vNKl1hWypiMJD
	0HmsSc2CfYGwQB+sSAHanhjfJHxO9ooX0HoBLZTkt2/q8fBGPEZAYko0k0i4Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741249519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnHbfXfIm2qhY9DKGP65PuhIGezx3zi3/iWr4kPG5Lk=;
	b=WfFJl2YRi2XH0pRvMgRjgqj1q1yx95IgcCx9HxDrjOnnuY0j32H1iSYleLHfthBAOfu/9Z
	i/Sg8GMNdPgIXMBw==
To: paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc: jstultz@google.com, sboyd@kernel.org, christian@heusel.eu,
 kernel-team@meta.com
Subject: Re: [PATCH clocksource] Defer marking clocksources unstable to kthread
In-Reply-To: <f6bb6dd3-7183-42db-8e7e-c9103c0bd5ff@paulmck-laptop>
References: <f6bb6dd3-7183-42db-8e7e-c9103c0bd5ff@paulmck-laptop>
Date: Thu, 06 Mar 2025 09:25:19 +0100
Message-ID: <871pva5zww.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul!

On Wed, Mar 05 2025 at 09:43, Paul E. McKenney wrote:

I'm pretty sure, that I pointed this out to you before:

   "[PATCH subsys] Short description"

is not a valid subject line.

The canonical and documented form is:

   [PATCH] subsys: Short description

Can you please stop making your own rules and thereby breaking the
automated workflow of people so they have to manually fix up your stuff?

Thanks,

        tglx

