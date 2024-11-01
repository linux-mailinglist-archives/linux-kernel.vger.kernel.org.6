Return-Path: <linux-kernel+bounces-392911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A49B998E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F849B2131C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13771D9A57;
	Fri,  1 Nov 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFaO+9nI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kwD7tfNO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6D155330
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493494; cv=none; b=rXx1fIrsDHUzzS+ouSdllm7dhuVPZEFGUSfm+omCq1BXBhqAXYseETSUn4KMtRkfQF/TS0uhaYmktTqkwUp6Y558oDRp7BSF3Zz34lP7xQr5N889VBp6g0Gud6R31jFsunrA7awjCbao25fSYGO1BGjM+A0VnAWvRJ6s1Vt3tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493494; c=relaxed/simple;
	bh=SBACPA9V5nzZweUuKmqak0mDycFJu9G93mxziuWtmGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kx8s25X9ruLcYl4XLE3JoxpDgQwC42VBr+kwJMZ03NJ1q/nM24bRtACl3dsyjoMXyrse0Qij4qZZ2SH1qkAObKZdfITB9avLkzXxK+2nCZ3rSD2GmxsmVc98dXfCPga2uob1k2kg04ax9ztIyZXYUOslj21f9YlrDXYTG3f8Wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFaO+9nI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kwD7tfNO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730493491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MRLnqWvM2ql7IvVtB0NYXK1XHuLHkBLw0Ksd5fpaYU=;
	b=kFaO+9nIimAhpwQZ+gzcVwEJbx+nNio/VnvEHGU20Wcy92cNwpBSwHL7sOMmInQJ15SvIy
	KbcgF3T38LEgHsQEglYLRbA9MLwFmuqMhraKL1DSyPnMtBPOsaffkxkLrOD1VwAUmXXTIC
	KTg22z17XJy6HkB5Xx3DJyEezszgyf3onmwY3y85wYwPP6fBv/ccuwxt7nMQEnM+4VbJ6e
	ahZECEi2zHswaOLHQ1DVzKG28LpUGggago+TQyOfhWyGrW8kmuTaDsdB+/WLhBYTBrTGvM
	+YlHj9uMu/y+2/AzHhbajqBuYXKS1QklYAUyvoRxK4+pOozr67gzS1CCilisaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730493491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MRLnqWvM2ql7IvVtB0NYXK1XHuLHkBLw0Ksd5fpaYU=;
	b=kwD7tfNORs/JcSFr9wU6ijZvj0VxrKhXgHeh0sidq3j1voXvBnTRyGVD64keC1ihTU8Oyd
	f/jpljUwsqzL+5BQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 15/20] posix-timers: Handle ignored list on delete
 and exit
In-Reply-To: <ZyTb-oMrREz006d5@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.498474639@linutronix.de>
 <ZyTb-oMrREz006d5@localhost.localdomain>
Date: Fri, 01 Nov 2024 21:38:10 +0100
Message-ID: <874j4qvgel.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01 2024 at 14:47, Frederic Weisbecker wrote:
> Le Thu, Oct 31, 2024 at 04:46:41PM +0100, Thomas Gleixner a =C3=A9crit :
>> +	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
>> +	while (!hlist_empty(&timers))
>> +		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer=
, list));
>
> s/list/ignored_list ?

Ooops. This code path was obviously never reached so that went
unnoticed. Thanks for spotting it!

> Other than that:
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
>
>>  }
>>=20=20
>>  SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
>>=20
>>=20

