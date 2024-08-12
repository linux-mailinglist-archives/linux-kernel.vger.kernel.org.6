Return-Path: <linux-kernel+bounces-283170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F794EE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC2C283323
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894BA17B4E9;
	Mon, 12 Aug 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLapCMux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhXM7zMI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLapCMux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhXM7zMI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2D17C219
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469474; cv=none; b=nL8yOzXmgzFyLF7YDdN9ZrriYUqavj9cgGVj4NnnSyZc2mIclDYMcNsEohW7MEEaRZFckbZQr1qkmlw4s9fuH7scJ+pb466c2hODty5ejC42fle7X7kHHv+GXBr2XUrg2AUm1Da8MzVzUyQvmzszVku/G+RzIpWiCUOj9Q23GNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469474; c=relaxed/simple;
	bh=Oc6xe+jC2OH32SIXJ7YDiRVD7GSkjYovv0g6BUTo4yo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAmLj/LmRQbCjS9BSZXV8Dq9hhfbF75IA4yiMKkwEWX0s2cLuqML4PxgaBmFaK9JjpmILd9G85hloa8GMCajXAHgsaWeJ31N4L1UbEZ20Jic7rzHr3oHW7O1NikbnPv3zV4cohsSbESTI9zxYpjQ7cCz2PfyxoBs8wTH05cAWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLapCMux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhXM7zMI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLapCMux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhXM7zMI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93DF820283;
	Mon, 12 Aug 2024 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723469470;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNa9aNdNEbGZBcz/f1OlDIXuzmlb5DvcgkUkGMyfeQY=;
	b=vLapCMux471miowY4cMeTfdfFlLfoblA3bYiezPMkVIAamMcVGnoI+4A8is8mWLjnEnjLD
	bI6nib7PU7d92Td5VzhcQX0/sBbGwK1NV1ReEVKii5do1WWKGj6iIQgKdqqVoQszlnEifD
	3xcYXzp1iU6B0uMdHFf0yrfcam/xCmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723469470;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNa9aNdNEbGZBcz/f1OlDIXuzmlb5DvcgkUkGMyfeQY=;
	b=nhXM7zMIF4j+55a9cd03Eqq58fMbUoVJdwgHAGcBc0/29muD+9P35DseqdXKejLUO2ATTf
	U+CbKXNnfkRVWEDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vLapCMux;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nhXM7zMI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723469470;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNa9aNdNEbGZBcz/f1OlDIXuzmlb5DvcgkUkGMyfeQY=;
	b=vLapCMux471miowY4cMeTfdfFlLfoblA3bYiezPMkVIAamMcVGnoI+4A8is8mWLjnEnjLD
	bI6nib7PU7d92Td5VzhcQX0/sBbGwK1NV1ReEVKii5do1WWKGj6iIQgKdqqVoQszlnEifD
	3xcYXzp1iU6B0uMdHFf0yrfcam/xCmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723469470;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNa9aNdNEbGZBcz/f1OlDIXuzmlb5DvcgkUkGMyfeQY=;
	b=nhXM7zMIF4j+55a9cd03Eqq58fMbUoVJdwgHAGcBc0/29muD+9P35DseqdXKejLUO2ATTf
	U+CbKXNnfkRVWEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E0E137BA;
	Mon, 12 Aug 2024 13:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LFC1C50OumatfAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 12 Aug 2024 13:31:09 +0000
Date: Mon, 12 Aug 2024 15:31:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [LTP] [PATCH] syscalls/execve04, creat07: skip for kernels 6.11
 and later
Message-ID: <20240812133103.GA437233@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
 <20240812120221.GA195572@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812120221.GA195572@pevik>
X-Spam-Score: -3.71
X-Rspamd-Queue-Id: 93DF820283
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

Hi Jan,

> Hi Jan,

> > The behaviour is allowed since commit:
> >   2a010c412853 ("fs: don't block i_writecount during exec")
> > that landed in 6.11-rc1.

> Thanks for noticing and fixing this!

> It was reported some time ago:
> https://lore.kernel.org/all/202406141431.2b72ca61-oliver.sang@intel.com/
> https://lore.kernel.org/ltp/202407162117.7730986d-oliver.sang@intel.com/

I have no idea, if you found it yourself, but let's give them the credit:

Reported-by: kernel test robot <oliver.sang@intel.com>

Kind regards,
Petr

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
...

