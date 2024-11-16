Return-Path: <linux-kernel+bounces-411913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9B9D0117
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF72828632F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518F19ABC6;
	Sat, 16 Nov 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OcFFN6UV"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AACA5A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793720; cv=none; b=u3E7sGXm7J/9r/BGc2PgbKQVW3HK6DZGnQ7ag4ag1FPqVcvlr/EMd+pSBCq1xWbotUXhA6C3L9EbOKE9VJPmFMzBkisUPtVyCLT/VGfakiI20vJrMiLOCLnIqJbvSqJMyIw+V9IKuBoFHj0T4lqPG1td4YPdBm8lpDvOs0uMfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793720; c=relaxed/simple;
	bh=SHGLDzd/e6PUcuXWpTZ/QkJ2eF/AeZnPRAFeOcSmClA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwrqbCxBsoddYKhci2TK57/SequgIPR5h7NA/TKLDjCgOVg4WuWl0rH3n+W3W0eCXeN+GDqeXL/14nwzZbzTvU9JM3J5ju8GSoYQVd23TfjNdbRzApNvgHaUHc63Rf5pccg8WZwoBxdmBD/YHZ0W+4GPGH/54r+Io3ss3RH79ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OcFFN6UV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nty6dReYfFGDB0oxtFwFVw7TtVcb+R4XpknrEgPQYSk=; b=OcFFN6UVSbHHocJgBXyZqEVWD9
	KXcfRzJPIUJVEyow9FuTwtRV9opqJZzo9Sgxkro6Gnf0nPLYWn5l6KIWCc/EirW2SmRuYNm3BziXK
	aKvFvo5y/VDSEw2Z+VaC7SH66swjWCeX+JGiiULkjEZdFk6yNCn1D1oIom+ZqI7GD8k7JQ7fBbMxa
	05imTGoPU15FkGjVCQXPGRMHuvTXqrkn/lybWZ4JnsoRm1bcicUYIZiqgPreX1/mBIRXG8M9vIT/w
	bV5+HTdTVY7EaNyQA5tHrZJSeqL+mfG3uZ0abE3/REcd9ampnoHTZUiIbCp2CwiCFU+kcMttmgKJK
	tWV5eWMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCQee-0000000FtTl-1YrS;
	Sat, 16 Nov 2024 21:48:32 +0000
Date: Sat, 16 Nov 2024 21:48:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nir Lichtman <nir@lichtman.org>, ebiederm@xmission.com, kees@kernel.org,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: make printable macro more concise
Message-ID: <20241116214832.GD3387508@ZenIV>
References: <20241116061258.GA216473@lichtman.org>
 <20241116072804.GA3387508@ZenIV>
 <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 16, 2024 at 08:49:39AM -0800, Linus Torvalds wrote:

> The original ctype array was US-ASCII only, and at some point in the
> random past it got changed to be based on Latin1. Maybe indeed 1.3.60
> as you say, I didn't go digging around.

Almost certainly unrelated.
0.10:
	initial support of #! in do_execve()
0.99.12:
	binfmt added; array, with aout as the hardwired first entry.
	#! handling happens prior to looking through that array.
0.99.13:
	binfmt_elf added; goes into the second slot of array if
	enabled.
0.99.14g:
	binfmt_coff added.
1.1.14:
	formats is a linked list instead of an array now, aout is
	still the hardwired first entry.  Anything else
	should call register_binfmt().  Nobody does, though, so
	elf and coff support got broken?  Lovely...
	At the same point binfmt_elf.c got copied from fs/ to ibcs/,
	along with fs/binfmt_coff.c (originals gone in 1.1.23)
1.1.54:
	fs/binfmt_elf.c returns (ibcs copy sticks around)
	elf_format is added back to the list - explicitly kludged
	into initializer of aout_format if non-modular and
	handled by register_binfmt() if modular.
1.1.77:
	ibcs moved to arch/i386/ibcs, stuff in there still not
	reachable?
1.3.5:
	arch/i386/ibcs finally gone; exists out of tree, with
	varying degrees of rot.
1.3.60:
	binfmt autoload if no match found, setting aliases up is
	up to userland (decimal aliases, at that).  Check for "printable"
	first 4 bytes added, apparently to filter out text files (recall
	that msdosfs marked everything executable).
	Aliases potentially useful for iBCS2 binaries (with out of tree
	module).
1.3.61:
	aout made modular, both elf and aout use register_binfmt()
	both in modular and built-in cases (earlier kludge would
	be hopeless, so it's gone and good riddance).
	These two (aout and elf) are the only binfmt in the tree.
	Aliases are theoretically useful for both, probably set up only
	for aout - insmod(8) itself is ELF by that point.  Again,
	that's up to distros - we are decades before MODULE_ALIAS
	machinery, so the kernel build is not setting those up.

1.3.60/1.3.61 look like a transition to modular a.out, on systems with
already mostly ELF userland - arranging for autoload of modular aout
and allowing it to become modular.  Filter hadn't been there before
that - it appeared along with autoload, so ctype changes are irrelevant;
there hadn't been an earlier stage of that thing anyway.

1.3.71:
	binfmt_script added (unconditional, nominally may be modular,
	in reality always built-in).  Special-casing of #! is gone.
	Never going to be autoloaded (and filter would reject it
	anyway).
1.3.100:
	binfmt_java added.  Two formats (java binary and crapplet);
	the former might be subject to autoload (and I've seen
	such aliases in examples of /etc/module* on the net),
	the latter couldn't - text files.
2.1.23:
	aliases went from binfmt-%hd to binfmt-%04x; userland either
	adapts, or it hadn't needed those in the first place...
2.1.32:
	binfmt_em86 added (alpha emulation of i386 ELF); aliases
	are not going to be useful for that - the first 4 bytes are
	identical to those for native ELF.
2.1.34:
	binfmt_elf32 added (sparc64 compat ELF); same story wrt
	aliases usefulness.
2.1.43pre1:
	binfmt_misc added; at that point aliases have become useless -
	in effect, that's a better replacement for those.
	another binfmt_elf32 (itanic compat)
2.1.44pre3:
	binfmt_irixelf added (irix compat); ELF binaries, so aliases
	are useless.
2.1.44:
	binfmt_aout32 added (sparc64 compat aout)
2.3.5:
	binfmt_java gone

Past that point there's really not much happening - and by now all
traces of aout are gone, which leaves this autoload logics pretty
much useless.

I mean, all ELF binaries are indistinguishable to it, scripts are
out of consideration anyway, aliases for binfmt_misc are pretty
much insane...  What does it leave?  binfmt_flat?  Sorry, the first
4 bytes are "bFLT", so it won't pass the filter...

All alias examples I had been able to find were for
	* a.out variants
	* iBCS2
	* java
Oh, and binfmt-0000 aliased to /bin/true, so that trying to exec a
zero-filled file wouldn't trigger whining from the modprobe when
we hit that autoload.

IMO we should simply take it out.

