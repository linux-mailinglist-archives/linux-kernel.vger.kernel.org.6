Return-Path: <linux-kernel+bounces-355675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AE99558E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AACA1F25DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70F61FA253;
	Tue,  8 Oct 2024 17:22:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA9433B5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408178; cv=none; b=ZUSZZAOm9xe5seezsPebPFxnSLoxXU805ldTFMHP1H0xeSV27539unB+RuBTr9F+0Xe9M6JCAYrjtxgxCOX7TKGVqUiVyAehXif2S2sChe3dwIDvE03r88fx92mLzBHRKIoRNxUB1z88zGj+ReuLKzEWVPmM5R3SJKW7F4TJ5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408178; c=relaxed/simple;
	bh=sitovRrrUDpMVJTaHKBXXrXEAlGykN9z1Jy3ZQOv3kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkgzbuZPjzapE24g+5JvkME81qHgR2jo9HeaSHgXAtl17ofUUCy9Rf48BBNGGQUKF1aWNgFHKM86ABmRO5UWpoVlRnL6vZcIeqlb1oCW17805u8YcsDRKv1cTTVXCZStT2EoSHul6cPZD6x8y8w3wlSwAYmsSca6TF4/UV2cS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B8C4CEC7;
	Tue,  8 Oct 2024 17:22:56 +0000 (UTC)
Date: Tue, 8 Oct 2024 13:22:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: reserve_mem command line option causing a reboot but not by the
 kernel
Message-ID: <20241008132259.52a5f274@gandalf.local.home>
In-Reply-To: <20241006133233.32c8708c@rorschach.local.home>
References: <20241006133233.32c8708c@rorschach.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2024 13:32:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I don't have time to debug further. Maybe I need to look at the legacy
> grub code. I just found this interesting and decided to share. Perhaps
> someone else might hit this too?

I found that one of my old test machines also uses legacy grub, and it too
has the same issue.

It appears that grub does indeed search for "mem=" (without looking for
something before it) in the kernel command line.

  https://github.com/jezze/grub-legacy/blob/master/stage2/boot.c#L275

Thus, "reserve_mem=" (or any other "mem=" option) cannot be used with legacy
grub installs :-p

-- Steve

