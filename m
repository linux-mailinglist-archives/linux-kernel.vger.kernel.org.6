Return-Path: <linux-kernel+bounces-263011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38493CFC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57031C22210
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC174070;
	Fri, 26 Jul 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R3HXmDR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="36/yyFSj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H6HHdttb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="raVTTpIt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E654405
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983526; cv=none; b=VtdvBBoCyZ+Usfc0iv5D9GBEHtiY1rTbCYOUXIsG2A9cYwwGlHE6ZNGOpt72gBJbpZJ3xeT9G4ImDEMdXN46uCENFJFmafYBPvS6ik3pWvQ4vj1Vxpxw+szTgZbluJK70/tSyfcophFhWGrhJANaO07jhzXOaTPSLdPlwxTk7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983526; c=relaxed/simple;
	bh=iQ5IhtZgLm+rkc5eoGm9hIH3ZDzmZomFvTPndZ9kpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIv2bZfWxLHY9uEYlQJKvjl2Sv4nnIxg32RvHKwi/EXB+uip0oT68mOph+9BRCftaYVsYYndfjDpMTza97nAgo802sjBIfLs59pK7mvgt6NCmTF66CkUBQtDkjs2gMaxXJ8KnX+lUuOFX74SZVMdZqWU+EUN9JrQCDonsgjs+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R3HXmDR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=36/yyFSj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H6HHdttb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=raVTTpIt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E12D921B83;
	Fri, 26 Jul 2024 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721983522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=R3HXmDR6ZntbVRxRffgSFTTFCjpeC/kN3PMIin3QZEPiOgPU2l6rr/y51TE9rGobZloSv+
	asMgT8ANa4gqphYS7JOE9GB8WoML0BXBhx49x8H1mxaYUNPjc42IUnz8hRQiiFE8cJBnja
	jYA4GXkqSJeMCrwMNVMKkZPs5Wbxc3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721983522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=36/yyFSjmKBVMEURwThxikMOX33AYH0q1VmW2fUFK6ymNOB4KUO497LGddWPbAXBwfMshn
	vZUEuTFhvFKr3bBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H6HHdttb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=raVTTpIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721983520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=H6HHdttbDtoV35snBjAs3Wrj/CV9s8nCVWIORdmuBBR7nuaCmw9NnX/sAwS5w01oyI8bgc
	/pAyd5PXUt6Gubw6G98G7eN53401/ztCSYzax8fwfkvhx2XN7p8xhMvhoJtYkmSa30zHY5
	7HEDdzj/czcr/jwW2Efr9YDXoZt9hPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721983520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=raVTTpIto06gD02x/iPJvqEW5wYTU5i5JtCrDGqjhlDcFcJ2n/plQF9R7ERv2+bEh7zyPG
	OUvIWi+zCrfRbVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3D03138A7;
	Fri, 26 Jul 2024 08:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S71pLiBio2YjOQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 26 Jul 2024 08:45:20 +0000
Date: Fri, 26 Jul 2024 10:44:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>,
	Yang Xu <xuyang2018.jy@fujitsu.com>,
	Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Vorel <petr.vorel@gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Update LTP members and web
Message-ID: <ZqNiCJXCIUzn-KmP@yuki>
References: <20240726072009.1021599-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726072009.1021599-1-pvorel@suse.cz>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,fujitsu.com,suse.de,lists.linux.it,linux-foundation.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.31
X-Rspamd-Queue-Id: E12D921B83

Hi!
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

