Return-Path: <linux-kernel+bounces-564154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72973A64EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0558188B5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794D23959B;
	Mon, 17 Mar 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QWT5rwGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qrWh5L6n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QWT5rwGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qrWh5L6n"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065D23909E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214554; cv=none; b=Fie3lU9ssFvFNVLX/rmy3Rs5OglPnlUk+bZGzkUsLSHrHaLCzXl3RXjIhjijtkKPT29TeC1dsHLQN4WdeG3UuSGrtihdTdE/RdmBlCf6KolLfX0KY5XQZI/vJxAAr3v8UmuOeT8hwpSakJ2hLsTJDR+WA7kgk7EDU0hBvSURuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214554; c=relaxed/simple;
	bh=Utovbs3rbIBIRN09nzbTlcatZHEC7W9LgIE5HufaywM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F/YchIhIYLoY7Tlf6ileZJN7H+a4jhjzVTitEm7M7a8byEpkATHRNVNHp7QdhAF6PFJ4k8IwpWvo2fi2HssuVg1/rjPc0+dr6A4Xzz7XdEOnnHelA9d42PWTOYtwF1ldkMDkVpCA9JoBilQRLkmg9p2VOg79kd6EqGQ+8ajUjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QWT5rwGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qrWh5L6n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QWT5rwGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qrWh5L6n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6846C21DD9;
	Mon, 17 Mar 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742214550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS/BtndIbf3pAv9JtQcUPas1YBGnOg5o2mUT46doVNg=;
	b=QWT5rwGYlpD/x3UFxulgEEXu46pyF16f2yZ94yE2lQvUZ1Jkf+sUMsRJ7NNgxevtqpbWKa
	P2zaGUQ6AAP/daqwVopA7X8dr1U96U4bopWx3NG8W9qGT5g67sbo8BtUjJHKsdBQocl9Yt
	I+k9wkbjXG614Qg3QAi2oqx+5m7/Mnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742214550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS/BtndIbf3pAv9JtQcUPas1YBGnOg5o2mUT46doVNg=;
	b=qrWh5L6nzESaS1UbbZAnM43Kxs8TES8e7puNoug+CnyfYXtzcMA9Hw6gAP/n9i6ZhhvzLB
	2R3N/XrSkaNMxxAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742214550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS/BtndIbf3pAv9JtQcUPas1YBGnOg5o2mUT46doVNg=;
	b=QWT5rwGYlpD/x3UFxulgEEXu46pyF16f2yZ94yE2lQvUZ1Jkf+sUMsRJ7NNgxevtqpbWKa
	P2zaGUQ6AAP/daqwVopA7X8dr1U96U4bopWx3NG8W9qGT5g67sbo8BtUjJHKsdBQocl9Yt
	I+k9wkbjXG614Qg3QAi2oqx+5m7/Mnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742214550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS/BtndIbf3pAv9JtQcUPas1YBGnOg5o2mUT46doVNg=;
	b=qrWh5L6nzESaS1UbbZAnM43Kxs8TES8e7puNoug+CnyfYXtzcMA9Hw6gAP/n9i6ZhhvzLB
	2R3N/XrSkaNMxxAw==
Date: Mon, 17 Mar 2025 13:29:10 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Brendan Jackman <jackmanb@google.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
    linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 05/13] objtool: Increase per-function WARN_FUNC() rate
 limit
In-Reply-To: <Z9foFvqpmo0nX1XP@google.com>
Message-ID: <alpine.LSU.2.21.2503171327420.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org> <Z9foFvqpmo0nX1XP@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 17 Mar 2025, Brendan Jackman wrote:

> On Fri, Mar 14, 2025 at 12:29:03PM -0700, Josh Poimboeuf wrote:
> > Increase the per-function WARN_FUNC() rate limit from 1 to 2.  If the
> > number of warnings for a given function goes beyond 2, print "skipping
> > duplicate warning(s)".  This helps root out additional warnings in a
> > function that might be hiding behind the first one.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  tools/objtool/check.c                |  2 +-
> >  tools/objtool/include/objtool/elf.h  |  2 +-
> >  tools/objtool/include/objtool/warn.h | 14 +++++++++++---
> >  3 files changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 6b9ad3afe389..3ddaefe97f55 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -4528,7 +4528,7 @@ static int disas_warned_funcs(struct objtool_file *file)
> >  	char *funcs = NULL, *tmp;
> >  
> >  	for_each_sym(file, sym) {
> > -		if (sym->warned) {
> > +		if (sym->warnings) {
> >  			if (!funcs) {
> >  				funcs = malloc(strlen(sym->name) + 1);
> >  				strcpy(funcs, sym->name);
> > diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> > index d7e815c2fd15..223ac1c24b90 100644
> > --- a/tools/objtool/include/objtool/elf.h
> > +++ b/tools/objtool/include/objtool/elf.h
> > @@ -65,10 +65,10 @@ struct symbol {
> >  	u8 return_thunk      : 1;
> >  	u8 fentry            : 1;
> >  	u8 profiling_func    : 1;
> > -	u8 warned	     : 1;
> >  	u8 embedded_insn     : 1;
> >  	u8 local_label       : 1;
> >  	u8 frame_pointer     : 1;
> > +	u8 warnings	     : 2;
> >  	struct list_head pv_target;
> >  	struct reloc *relocs;
> >  };
> > diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> > index ac04d3fe4dd9..6180288927fd 100644
> > --- a/tools/objtool/include/objtool/warn.h
> > +++ b/tools/objtool/include/objtool/warn.h
> > @@ -53,14 +53,22 @@ static inline char *offstr(struct section *sec, unsigned long offset)
> >  	free(_str);					\
> >  })
> >  
> > +#define WARN_LIMIT 2
> > +
> >  #define WARN_INSN(insn, format, ...)					\
> >  ({									\
> >  	struct instruction *_insn = (insn);				\
> > -	if (!_insn->sym || !_insn->sym->warned)				\
> > +	BUILD_BUG_ON(WARN_LIMIT > 2);					\
> 
> Shouldn't this be >3? Anyway, I think it would be clearer if the
> coupling was more explicit, e.g:

I think it is correct but I also think that the difference between bits 
and the actual number of "allowed" warnings can be confusing.
 
> diff --git i/tools/objtool/include/objtool/elf.h w/tools/objtool/include/objtool/elf.h
> index 223ac1c24b90..a86e43d2056f 100644
> --- i/tools/objtool/include/objtool/elf.h
> +++ w/tools/objtool/include/objtool/elf.h
> @@ -46,6 +46,8 @@ struct section {
>         struct reloc *relocs;
>  };
> 
> +#define STRUCT_SYMBOL_WARNING_BITS 2
> +
>  struct symbol {
>         struct list_head list;
>         struct rb_node node;
> @@ -68,7 +70,7 @@ struct symbol {
>         u8 embedded_insn     : 1;
>         u8 local_label       : 1;
>         u8 frame_pointer     : 1;
> -       u8 warnings          : 2;
> +       u8 warnings          : STRUCT_SYMBOL_WARNING_BITS;
>         struct list_head pv_target;
>         struct reloc *relocs;
>  };
> diff --git i/tools/objtool/include/objtool/warn.h w/tools/objtool/include/objtool/warn.h
> index e72b9d630551..2fba6866fd2d 100644
> --- i/tools/objtool/include/objtool/warn.h
> +++ w/tools/objtool/include/objtool/warn.h
> @@ -56,6 +56,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
>  })
> 
>  #define WARN_LIMIT 2
> +static_assert(WARN_LIMIT < (1 << STRUCT_SYMBOL_WARNING_BITS), "symbol.warnings too small");
> 
>  #define WARN_INSN(insn, format, ...)                                   \
>  ({
> 
> 
> Or just drop the bitfield (surely it can't be that important to save a
> byte here?) and use sizeof, e.g:

If I remember correctly, it is important. Josh and Peter spent quite some 
time on optimizing the data structures in the past as every bit counts.
 
> BUILD_BUG_ON(ilog2(WARN_LIMIT) > sizeof(_insn->sym->warnings));

Miroslav

