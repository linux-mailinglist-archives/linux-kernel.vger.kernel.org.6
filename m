Return-Path: <linux-kernel+bounces-372543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727149A4A13
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B21C213B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CDD19046E;
	Fri, 18 Oct 2024 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xAbEgft";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ivQoPze2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AC1E519
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294000; cv=none; b=WD8Rg9XFgniOn57LkZ/I3n2QTsRbTk/6x2RCQETos6H2UlPzQ2Pl/VE6jjFTF9AyuSxoDJd2iDJyaatueAMaQBlsJr4sYht/blBCSYVOIO+u7WPwT9KNluriX8xWMfodNwaug9AmuZcmgYtG09Uc9uAAECk2Bzm7qLkLasHQZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294000; c=relaxed/simple;
	bh=8XnKyLXgA/KzQQ4ovZmNRf3gln7b+TS5IthVxkwBly8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQp9QuF/fHwwwXa9P3fAGny4J85apRs0hxCdw6KmWQVbb6I1oREA7ch7gjwj8LJ553hM651Ct8prWsGNa8T7ez8mQxlJFAjohAZqOYP3eDMEmC3VDAiBBuKIXqBfrHd2bMmFYGxrqqTackwSvHt8QyHB1s0cTpMMwAaPeURJIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1xAbEgft; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ivQoPze2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729293995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWC6JkgIb+RQN5je0mzDc/D1H/8Kno1sYfnv3hVL0ng=;
	b=1xAbEgftp+MJLtviSvJ0P+3fL46B1+0Teu5+TeJ6DpU1PrdVsV1Hts6QyJCO8s+XZb/K0B
	3Rc4kTlZZbSGCyXS0VsijhVkDIA0hXHJSICQSwPl+B6Y5VH6QDh2XzAKdf7PKxUfuWjmst
	s16oCJrjhip45BK5/zJkhI2e3xrJvQDnSLzrFTqmPxitnQOUJx1UWYv22gzQkKuA7WBVZN
	t4sb4xg6Ivo2Re9LQBTiqV3GfgCFiqaLKr7fyeOK4uqw711ePkU/E+zIWg6EiRiTwnvu0o
	4Po7F+Lz8p6t7rYkOF70QpEHPEMGjw3VMRD1+7aMgXW/BwGaXrbCBvSIK8vx9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729293995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWC6JkgIb+RQN5je0mzDc/D1H/8Kno1sYfnv3hVL0ng=;
	b=ivQoPze2Oaa1HraUE9pYJxPRgV+OWEYK/2qiQ0T/AnAmQIIzwv+byKXB3pJ9SbFFvcezec
	RQuMlAt1ktAFnlCg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, anna-maria@linutronix.de,
 frederic@kernel.org, kuba@kernel.org, ruanjinjie@huawei.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] posix-clock: posix-clock: Fix unbalanced locking in
 pc_clock_settime()
In-Reply-To: <20241018100748.706462-1-ruanjinjie@huawei.com>
References: <20241018100748.706462-1-ruanjinjie@huawei.com>
Date: Sat, 19 Oct 2024 01:26:34 +0200
Message-ID: <878qul802d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 18 2024 at 18:07, Jinjie Ruan wrote:
 If get_clock_desc() succeeds, it calls fget() for the clockid's fd,
> and get the clk->rwsem read lock, so the error path should release
> the lock to make the lock balance and fput the clockid's fd to make
> the refcount balance and release the fd related reosurce.
>
> However the below commit left the error path locked behind resulting in
> unbalanced locking. Check timespec64_valid_strict() before
> get_clock_desc() to fix it, because the "ts" is not changed
> after that.
>
> Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in
> pc_clock_settime()")

Jakub, I expect _you_ are going to pick this up and explain to Linus and
the stable people why we need a fix for the rushed in "fix".

Thanks,

        tglx


