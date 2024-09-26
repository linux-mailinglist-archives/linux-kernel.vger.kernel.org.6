Return-Path: <linux-kernel+bounces-341020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DA987A59
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AFA1F23AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5418595E;
	Thu, 26 Sep 2024 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cvlQewNl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KhG4vPDH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cvlQewNl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KhG4vPDH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C0487B0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385313; cv=none; b=mXH1Pm3wgSzgce9ehQ4iKwLsHKNeL5wD5pz7ef9YDxVqudVyxqaTAXvXXX0HCwZ6G1J32HViVrcFh+FK8NYwe0p6Fw9SDwNlIDqfMFmPl9TMCIshCWx20vjHlHQq/nc4IDUcMZ4DX29ATb1R8KcEv5+jUU8A3yozE904DRiaCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385313; c=relaxed/simple;
	bh=5TOoeI+tI80xbDMPAAeUHSPHHFiYKPhbh4Ua18DIO+E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cjyUBFeHJffRHdYhVdH+Vmnhi8O8INsChMd+zdRYXs3b2aUGkM/dbw+iZFuHXUQP5qSmOxsgN+4pPlJveQhujpAnOQaqkh9wuMdVmdzanpmlP13zBXu2bliQ2AD8FPrTHO91oC4/ABN/U+meQ6/sdxlikd01JDepaIbOi/KLqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cvlQewNl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KhG4vPDH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cvlQewNl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KhG4vPDH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B118121B2C;
	Thu, 26 Sep 2024 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727385308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3LZGquUZtI7FiWvOn/zCPgcCWiKd/G2Xtk3qGxNpYM=;
	b=cvlQewNlXtFg7Owz23J21hFOG3qQtAlQFjFAbtRPGajbfc3as1GxKnT/4ITK1cfYIpvXMU
	g5DvPORIhmLnDwNEj1dBpUIt4rf2BvRhf9h5i86T62Yg1zHx1yPpdsZWVmOLnS6hMn4/nt
	xhNCqApyv2xsu9z8yTAeJvCm+ypTmgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727385308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3LZGquUZtI7FiWvOn/zCPgcCWiKd/G2Xtk3qGxNpYM=;
	b=KhG4vPDHtEyKqoNqXp0ZVYBwXzRPzopw+C3lb9rv82jwMGujMgswJcq5hNjSH/wWfvPIPn
	GYnypXJ/IPMmv8CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cvlQewNl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KhG4vPDH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727385308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3LZGquUZtI7FiWvOn/zCPgcCWiKd/G2Xtk3qGxNpYM=;
	b=cvlQewNlXtFg7Owz23J21hFOG3qQtAlQFjFAbtRPGajbfc3as1GxKnT/4ITK1cfYIpvXMU
	g5DvPORIhmLnDwNEj1dBpUIt4rf2BvRhf9h5i86T62Yg1zHx1yPpdsZWVmOLnS6hMn4/nt
	xhNCqApyv2xsu9z8yTAeJvCm+ypTmgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727385308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3LZGquUZtI7FiWvOn/zCPgcCWiKd/G2Xtk3qGxNpYM=;
	b=KhG4vPDHtEyKqoNqXp0ZVYBwXzRPzopw+C3lb9rv82jwMGujMgswJcq5hNjSH/wWfvPIPn
	GYnypXJ/IPMmv8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E292913793;
	Thu, 26 Sep 2024 21:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nzOiJdrO9WZxZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 26 Sep 2024 21:15:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7 v3] Make wake_up_{bit,var} less fragile
In-reply-to: <87a5fu2v96.ffs@tglx>
References: <20240925053405.3960701-1-neilb@suse.de>, <87a5fu2v96.ffs@tglx>
Date: Fri, 27 Sep 2024 07:14:48 +1000
Message-id: <172738528850.470955.17847209131107637985@noble.neil.brown.name>
X-Rspamd-Queue-Id: B118121B2C
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 27 Sep 2024, Thomas Gleixner wrote:
> On Wed, Sep 25 2024 at 15:31, NeilBrown wrote:
> >  this is a revised set of patches for cleaning up wake_up_bit and
> >  wake_up_var and related.  They are the result of more proof reading,
> >  and of trying to make use of the new interfaces anywhere in the kernel
> >  where these interfaces are used.
> 
> Now I have two variants of a v3 patch set in my inbox. One with 7 and
> one with 8 patches. Both sent within a couple of minutes....
> 
> Confused.

Arg - sorry about that.  I realise now what went wrong.

Please use the one with 7 patches.  The first patch in the set of 8 has
already been accepted by Jens for the block tree and has now been merged
(as of Wednesday afternoon).

Thanks,
NeilBrown

