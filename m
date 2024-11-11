Return-Path: <linux-kernel+bounces-403809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D399C3B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165701C21DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06CB14B956;
	Mon, 11 Nov 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0J85s4Tb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HFqNBeb/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0J85s4Tb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HFqNBeb/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950F224D6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318116; cv=none; b=Zwaa0nzdidHtWNmyH0AcYUUpiXjN0pW3l3ygkPv75nGQ1+Nz/OPNyqtvlheUZF3GtcNHIuhImU/1XFgMeeUZd+8+Pe292f3cacRd1x3Bj0IK/2b6bAjOqBDQYx6hwZDhyWG+ZfRfNNMa6K3dk2CEyeMHUE9/SIPZeOj9rezqkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318116; c=relaxed/simple;
	bh=MoiU8XfhCwZhfNBNDdPejz1ykAeuY27WjcKaAkDOMzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPz1gddWtMZvOLgAr1XQYCx2uiqHb5aiAsmBILdrzcA3mPc6T2Qw0LH54YfQBr1VhNJX2ryTj6xljm6iqUZ6aMAs5fw/ohVXJOxyhT1y+Yjg62BxHG3d6lTKGMET32bBYl+xvuK1AeJEOvZ0JfvPEhznxB71qmCYLyYszrjlhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0J85s4Tb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HFqNBeb/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0J85s4Tb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HFqNBeb/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 977841F38F;
	Mon, 11 Nov 2024 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731318112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcW3XJ6RBr7sYPiVps5XbwDo8mGo2lps7pml0tEgRE8=;
	b=0J85s4Tb6TLfFK+PGfAYx5YGxHRgGuPs1mVdg1H59IkIetpYq98lSyZSHuB7NWwePVAYi+
	mvgNOvzVOLTHqLtqul0MMODopf7Uy9MBmDGp/qK6fFV2YnZw1d3IYcNFOB9fcsvlQTe13/
	PTug7oXAfejTqTG3ojrzvoWiQ6sV8uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731318112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcW3XJ6RBr7sYPiVps5XbwDo8mGo2lps7pml0tEgRE8=;
	b=HFqNBeb/niypMYyTBmrNfnFfbKMaqNxlpQgcimnxw1ZzyzBqMBoP4lzDR+dsaZHOo/d4KP
	k5Rb/k4FrHFj25Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731318112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcW3XJ6RBr7sYPiVps5XbwDo8mGo2lps7pml0tEgRE8=;
	b=0J85s4Tb6TLfFK+PGfAYx5YGxHRgGuPs1mVdg1H59IkIetpYq98lSyZSHuB7NWwePVAYi+
	mvgNOvzVOLTHqLtqul0MMODopf7Uy9MBmDGp/qK6fFV2YnZw1d3IYcNFOB9fcsvlQTe13/
	PTug7oXAfejTqTG3ojrzvoWiQ6sV8uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731318112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcW3XJ6RBr7sYPiVps5XbwDo8mGo2lps7pml0tEgRE8=;
	b=HFqNBeb/niypMYyTBmrNfnFfbKMaqNxlpQgcimnxw1ZzyzBqMBoP4lzDR+dsaZHOo/d4KP
	k5Rb/k4FrHFj25Ag==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 3AF244A0564; Mon, 11 Nov 2024 10:41:52 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,  =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
  Charlie Jenkins <charlie@rivosinc.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Andrea Parri <parri.andrea@gmail.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
In-Reply-To: <d380fd10-ebc4-4d66-becb-13995372d41a@ghiti.fr> (Alexandre
	Ghiti's message of "Mon, 4 Nov 2024 11:02:14 +0100")
References: <mvm5xq44bqh.fsf@suse.de>
	<d380fd10-ebc4-4d66-becb-13995372d41a@ghiti.fr>
X-Yow: I think my CAREER is RUINED!!
Date: Mon, 11 Nov 2024 10:41:52 +0100
Message-ID: <mvmfrnyxg2n.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,rivosinc.com,sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.70
X-Spam-Flag: NO

On Nov 04 2024, Alexandre Ghiti wrote:

> Unless you have any objection, we'll try to make Bjorn's patch into
> 6.12-rc7 instead of yours.

It still fails the same:

In file included from /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/include/asm/barrier.h:12,
                 from /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/include/linux/ring_buffer.h:4,
                 from libbpf.c:37:
/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/include/asm/../../arch/riscv/include/asm/barrier.h:13:10: fatal error: asm/fence.h: No such file or directory
   13 | #include <asm/fence.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[5]: *** [/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/tools/build/Makefile.build:106: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [Makefile:164: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/linux-obj/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
make[3]: *** [Makefile:63: /home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/linux-obj/tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-default-6.12~rc7/linux-6.12-rc7/Makefile:1393: tools/bpf/resolve_btfids] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [../Makefile:224: __sub-make] Error 2

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

