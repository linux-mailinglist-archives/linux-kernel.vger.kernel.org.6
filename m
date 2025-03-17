Return-Path: <linux-kernel+bounces-563921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD66A64AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB6F3BBAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4D23370C;
	Mon, 17 Mar 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z96YLtgw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Vu3a0nN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z96YLtgw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Vu3a0nN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CA231CB1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207788; cv=none; b=Y4h1+F/CRs7xhOysDD0W6xalkZwQbvDRt+lmGXGVaiPkzK8+deYMGJhJ2SLAKhOS+LVq1Imu7ooCSGXl544et/GX9wOFth+X3qeM9aFZplXnwqTBjYNmBurTDHfOttklPa2zIleWR5PrhV4otsCt2X94wGy3mnOnqP3beAuAvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207788; c=relaxed/simple;
	bh=gkiUIHZSrbwtOKaBnJXHaBWnA15oCRxDa0WoWIYXNgE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gCLW5UMoaqGxJNX4vRKh515VPmdlrywYDiaKiM62T5RZ8OuZE43dV+eGt2+gWg1Jycm3YBKYJE/4+WVPYLHX6AZlMiUqBNJxNFJfx69zvk9vDMK5HjEg0BYEEr8tZnNdFZKNHvcGJmBCuZrQX1220DNo8s4Dr8AVdFn44JnY364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z96YLtgw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Vu3a0nN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z96YLtgw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Vu3a0nN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8C6D21F07;
	Mon, 17 Mar 2025 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742207783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCUYw9mWffBz12keC2rcDopauYcvCdOcFRYio6TMRKw=;
	b=z96YLtgwnVrt3RGyWSmjg/nUdtkQ57gJOgU5csmhlaUQhxd8wg/e6Xx7hdseWfmU/yEzn9
	7tofOkznS6dkRvAptfOjEP0xrYFnC0IoY+i+6Db9GIN0B2Co63+uheLm5T8zTDJc0IWOlz
	KBG2wRnOjnnb7lug1cpaDwZKjHSknCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742207783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCUYw9mWffBz12keC2rcDopauYcvCdOcFRYio6TMRKw=;
	b=1Vu3a0nNgaFRlOJwEzGPQE9NFqZYaqXXtZazE/z4k0xpME9ZumqOYEyGMxQ776As3uxbyp
	NP+8kVmLcmXsTWDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742207783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCUYw9mWffBz12keC2rcDopauYcvCdOcFRYio6TMRKw=;
	b=z96YLtgwnVrt3RGyWSmjg/nUdtkQ57gJOgU5csmhlaUQhxd8wg/e6Xx7hdseWfmU/yEzn9
	7tofOkznS6dkRvAptfOjEP0xrYFnC0IoY+i+6Db9GIN0B2Co63+uheLm5T8zTDJc0IWOlz
	KBG2wRnOjnnb7lug1cpaDwZKjHSknCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742207783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCUYw9mWffBz12keC2rcDopauYcvCdOcFRYio6TMRKw=;
	b=1Vu3a0nNgaFRlOJwEzGPQE9NFqZYaqXXtZazE/z4k0xpME9ZumqOYEyGMxQ776As3uxbyp
	NP+8kVmLcmXsTWDw==
Date: Mon, 17 Mar 2025 11:36:23 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Brendan Jackman <jackmanb@google.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
    linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 03/13] objtool: Improve __noreturn annotation warning
In-Reply-To: <Z9fd82KugPxoGaRS@google.com>
Message-ID: <alpine.LSU.2.21.2503171135460.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org> <Z9fd82KugPxoGaRS@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.28
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.918];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 17 Mar 2025, Brendan Jackman wrote:

> On Fri, Mar 14, 2025 at 12:29:01PM -0700, Josh Poimboeuf wrote:
> > Clarify what needs to be done to resolve the missing __noreturn warning.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  tools/objtool/Documentation/objtool.txt | 12 +++++-------
> >  tools/objtool/check.c                   |  2 +-
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
> > index 7c3ee959b63c..87950a7aaa17 100644
> > --- a/tools/objtool/Documentation/objtool.txt
> > +++ b/tools/objtool/Documentation/objtool.txt
> > @@ -319,14 +319,12 @@ the objtool maintainers.
> >     a just a bad person, you can tell objtool to ignore it.  See the
> >     "Adding exceptions" section below.
> >  
> > -   If it's not actually in a callable function (e.g. kernel entry code),
> > -   change ENDPROC to END.
> 
> Did you mean to delete that?
 
I would say so but it should go to the next patch 4/13 alongside the other 
doc updates.

Miroslav

