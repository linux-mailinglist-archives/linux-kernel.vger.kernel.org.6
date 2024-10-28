Return-Path: <linux-kernel+bounces-386035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761F9B3E66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECA6B21B68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CAD1F4FA8;
	Mon, 28 Oct 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FM95yLXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWAaRzHu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270418FC83
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158019; cv=none; b=UYcJEsR7rzxrDogEGDt6ROvD9Q0I9hl2dwUFwESQbIvsoBKFbQ8kJQlDwbpGE2Vyra32idu0AOnI1IBHu01PF+5eyuh6JT+6lm9YIX3wVD3npFAL8cjlW4cs1OoDIunbuBJW93uT+M5thD7TmPDSuRlnbhA7UXMKoW832igGyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158019; c=relaxed/simple;
	bh=GdRMRZ1RGYSZW7qO5jDvSsg21UWD5PPGkPbwdBhvTtE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=SzOKMYZGZydwLjOuT83CdxfKdExNWDiIHhn1JU2hwqoE4dnYgAf6woJQ/B3EBnmLeujY5KVV6Fnrs4hQrLkvRGAosiQtSQ5Fzhe2tE6n4g7VBbFqdMBpn+RrpTZXulJw3j/WDT5X9y8X03J9UYkajE+Qi0FsLnk75r0iubDBOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FM95yLXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWAaRzHu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730158016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=k8MQMIcGw53XfNyfkLuoib3jrJdzTbXAHZV7rzDZeJ0=;
	b=FM95yLXn2HB3C4Kd6xAlSOBRnYNGF4nIwN5bQkoiTFS7E0Ju67OiddDzu+tmBaFTvNJ4iu
	XeS3G3EFVcECt6PSCnVWaHFzvW9kIIYZEpXRbH5WfN+FFWO3DmSoiYpP9H0LISWdalbN11
	NYaXslDAtc9yx8hFzl3pVBHs4rkBpWXifdXQ0h1G9/WNE8EEEHbjI6D5jsafS4siLjar/E
	befkuosNyVsXgHXQEXrzRB5D7qeiBBbeKx6IytdslQ1aiAsRKxkMsdtNOYDiqpPnh5ikj8
	L1jT6RDn5zAFzVbeDaZbxPdwHBEKxKqJzXBmADjuBXbAShZSNCVC1+KfmbDq5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730158016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=k8MQMIcGw53XfNyfkLuoib3jrJdzTbXAHZV7rzDZeJ0=;
	b=rWAaRzHu0x9RRX0YJc3t2jkalK4f+7zmJ45TmiBw3JK6POV76hKjzqTLEs3xLaNgbOLJ3p
	QwcBn/C9FVe3veCg==
To: Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John
 Ogness <john.ogness@linutronix.de>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Tony Lindgren <tony.lindgren@linux.intel.com>,
 kernel-team@fb.com
Subject: Re: [PATCH v6 05/11] MAINTAINERS: Mark printk-basics.rst as owned
 by printk subsystem
In-Reply-To: <62e6a36052a1759e7d01669c5c760b6a1760a9c8.1730133890.git.chris@chrisdown.name>
Date: Tue, 29 Oct 2024 00:26:55 +0100
Message-ID: <87msin3j28.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 16:45, Chris Down wrote:
> We are going to update this in the next patch, so while we're here, we
> might as well mark it as owned by us.

Who is we?

Thanks,

        tglx

