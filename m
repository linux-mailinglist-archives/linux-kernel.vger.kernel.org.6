Return-Path: <linux-kernel+bounces-566584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB7A67A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19663B3A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F3211499;
	Tue, 18 Mar 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVy2DK/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXiZ+E61";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVy2DK/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXiZ+E61"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361420F072
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316814; cv=none; b=D4kGTa6aMcI7TrPzp5rj5qYmRVE2UGgaggvCyOfnPPACBMpkCqFuFm0crjm9RYYhdDXSnPL49mEGNuIK6J3zQmWKsedjmWpiqu2/fA0WiD9g8eDvmBRw9+1AZBt1T/+iSNZX8FBZTjwXOD6wRznhGFnTG2lCjH8PI6zL+iAdOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316814; c=relaxed/simple;
	bh=huD/3rYpbgj/Jzgvm+lMxKm+98VVM9vJbCWT+ryMaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7b9M43JA/gWcciBOq7Jece1y7hdyQldCKFEVVgmVsHsyjp3NHdUky/W8IdFssUVLGtdPQ3Rk83wxS3ffGfIz+ylsrZhf20tKnCjdqWZ+KUg+kO7qL0Ow/xtvUflQw4FnqS4jy/yPFKOZ72x/WS/QS3QJUjf1OLuXJr3xKr6doM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVy2DK/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NXiZ+E61; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVy2DK/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NXiZ+E61; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1286121BCC;
	Tue, 18 Mar 2025 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742316809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uhsVI2r46zANuNt59z1NRXPtx5+Phkk79KyKcCpfak=;
	b=wVy2DK/yijOwDDGRiES2YMsB9a2QSRJ+HyI2djkOTdvcEly+AJ6UZiIS4IyHlqjV09dlK2
	eroZpZ54Ng3O6CO1d0ZrwAJ6jEiBkFW4rSLs0IfECGOfwAACYBNa+kyPQAwqbU5lUHdTy+
	YoCbwKH8w+jBlZVzp62vSbbzFkgnzFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742316809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uhsVI2r46zANuNt59z1NRXPtx5+Phkk79KyKcCpfak=;
	b=NXiZ+E61wIOh/PdJsBSWzKSBRhwCR+1nG89LlVbGvuV1PooWoRyYK8Umk7JoqGmAN7uDup
	YROyHZSD8XAsWCCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wVy2DK/y";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NXiZ+E61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742316809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uhsVI2r46zANuNt59z1NRXPtx5+Phkk79KyKcCpfak=;
	b=wVy2DK/yijOwDDGRiES2YMsB9a2QSRJ+HyI2djkOTdvcEly+AJ6UZiIS4IyHlqjV09dlK2
	eroZpZ54Ng3O6CO1d0ZrwAJ6jEiBkFW4rSLs0IfECGOfwAACYBNa+kyPQAwqbU5lUHdTy+
	YoCbwKH8w+jBlZVzp62vSbbzFkgnzFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742316809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uhsVI2r46zANuNt59z1NRXPtx5+Phkk79KyKcCpfak=;
	b=NXiZ+E61wIOh/PdJsBSWzKSBRhwCR+1nG89LlVbGvuV1PooWoRyYK8Umk7JoqGmAN7uDup
	YROyHZSD8XAsWCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3F1D139D2;
	Tue, 18 Mar 2025 16:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CoNrNwil2Wf9PgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 16:53:28 +0000
Date: Tue, 18 Mar 2025 17:53:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Nick Terrell <nickrterrell@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
	Kernel Team <Kernel-team@fb.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/1] zstd: Import upstream v1.5.7
Message-ID: <20250318165312.GI32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250313205923.4105088-1-nickrterrell@gmail.com>
 <20250318131636.GC32661@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318131636.GC32661@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1286121BCC
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 18, 2025 at 02:16:36PM +0100, David Sterba wrote:
> On Thu, Mar 13, 2025 at 01:59:20PM -0700, Nick Terrell wrote:
> > From: Nick Terrell <terrelln@fb.com>
> > 
> > Since this is a large patch, I have also prepared a pull request as an
> > alternate means of fetching the commit:
> > 
> > The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:
> > 
> >   Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://github.com/terrelln/linux.git tags/2025-03-13-zstd-v1.5.7-v1
> 
> This tag is not in the branch that is pulled to the linux-next tree, the
> zstd-next branch still points to v6.14-rc5. This means the 1.5.7 update
> hasn't been exposed to linux-next testing. Please update the branch to
> the tag as well, the merge window opens next week leaving little time
> before sending the pull request.

I'm taking a proactive step and the tag mentioned above is now merged to
my btrfs for-next branch snapshot. As it's been pulled from your tree
the commit id (65d1f5507ed2c78c64fce40e44e5574a9419eb09) is the same and
git will handle it transparently in case you update your zstd-next
branch.

