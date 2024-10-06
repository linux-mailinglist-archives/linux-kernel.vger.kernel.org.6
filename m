Return-Path: <linux-kernel+bounces-352489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74AB991FF1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0517F1F21531
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A446189B8C;
	Sun,  6 Oct 2024 17:32:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC516133C
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235958; cv=none; b=DtTozjAvpvS4E1ujYZjO6FhstMFtluqL6gwfvavU5ZA+KI5Sf/n+DYpQVl+mu+DxyuOFpZ7xpIbAYAFrtUdD79Hl9tLPyzHiuWUN/cXMmyOAig3QdEDeDeUTK1ugQ9zg2L8GpMM/c7ZAxwrEew/1LPenphCe/11z12/e0ew3pHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235958; c=relaxed/simple;
	bh=l+T+RgKCtvct4AX5zT8qKmc1Xo9wTrcLtr/E44+FIeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NhB36JzW+pOQLbMTaUQwMod1pXjj60cyDpMQ+FMl1uT6GA9UbCwWHSB2Vjn1dq7Npr7gF0MIMvfpf4PTDKjVCv4W96qCsK97gmfftrm9rC7gTJxX1a0AizNOUpoOzgUGp8q4wiFfpLus9BArx+WjmfNlZsGFDS1aNnqatTx9Q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D65C4CECD;
	Sun,  6 Oct 2024 17:32:36 +0000 (UTC)
Date: Sun, 6 Oct 2024 13:32:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: reserve_mem command line option causing a reboot but not by the
 kernel
Message-ID: <20241006133233.32c8708c@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is mostly just an FYI,

I upgraded both my server and my workstation to 6.12-rc1 to try out the
new reserve_mem and my persistent trace instance. My server which is a
Dell PowerEdge T430 (bought here: https://www.newegg.com/dell-poweredge-t430-tower/p/2NS-0008-70EW5)
worked flawlessly. I enabled tracing, did a reboot and it contained the
trace on the following bootup. This used the following command line:

  reserve_mem=112M:2097152:trace trace_instance=boot_mapped@trace,console

Then I tried it out on my workstation. This is a machine I built years
ago. It has an American Megatrends Inc. BIOS (no UEFI). Since it only
has 8 CPUs, I had the command line of:

  reserve_mem=20M:2097152:trace trace_instance=boot_mapped@trace,console

Rebooted, and right after grub (legacy grub) loaded the kernel, the
machine rebooted again. I removed the "reserve_mem" option, and the
kernel booted fine with the rest of the options.

I started debugging this, but something else happened. When the system
rebooted, I picked an older kernel. But it rebooted too! That is,
booting a kernel without the "reserve_mem" code but the "reserve_mem"
option also had this issue! When installing, I did an "update_grub"
that added the command line to every kernel. It rebooted on any kernel
that had "reserve_mem" as one of the kernel command line options. I
tried kernels down to 6.6.

I then renamed the option in the 6.12-rc1 kernel as "reserve_mm" and
tried again. It booted fine! Although I found that my BIOS on this
machine does not keep memory consistent across reboots so the option is
useless.

The strange thing here is why "reserve_mem" on the kernel command line
causes the machine to reboot? It reboots very early. I even hooked up a
serial and enabled earlyprintk, and it doesn't ever print anything when
the reboot happens.

I'm wondering if this has something to do with legacy grub? Perhaps it
is parsing the kernel command line parameter too and does something
special with "reserve_mem"? My server is using grub2, and so are most
of the other machines I tested on. The ones without grub2 had extlinux,
which worked fine too.

I don't have time to debug further. Maybe I need to look at the legacy
grub code. I just found this interesting and decided to share. Perhaps
someone else might hit this too?

-- Steve


