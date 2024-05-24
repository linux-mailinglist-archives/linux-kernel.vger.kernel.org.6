Return-Path: <linux-kernel+bounces-188358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E18CE105
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC0B281819
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429CF433D0;
	Fri, 24 May 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J0pXQxul";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q9FWROvK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J0pXQxul";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q9FWROvK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F4AD49
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532316; cv=none; b=f0lRCWqjaArLeuj+z/6vHwPy8PHtDurVpJaWIQZGEhl4URCfjxP8QPv8LGlJ3SvpRaQhJjU8wTxMb5wwa/6eCjWoceD5x9Bj7inJuMYuS/ozfwtADkiSy9EtLNgzKeemM4EvRHSYuPBy6FVfg2J1p4a2/9PEvsrIzsUUNv2xS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532316; c=relaxed/simple;
	bh=sISxV3IB0+daKkY6FHuY7Tin0TrZ7WOi3vgqovuLsjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyiFZ4bK+JKjzDypxEQdoVJhu69H3PErVMjXWR/oM+jeqHXr6CCovvm6XlpunghjfreM/vH96sL5r5NeKzLZZ5HEe+kJ5CVdNFD5jKWbAev3bJRPfkYymz6pei055Z7L2L9TgNBnEB8t5xH2awCiIq3TlHtxjy2vCGeXKPPTHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J0pXQxul; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q9FWROvK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J0pXQxul; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q9FWROvK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D62F7207F9;
	Fri, 24 May 2024 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716532311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3InHPw4zDCqDhiB22k++dKm8geIUyYGdUQMnurPTGoo=;
	b=J0pXQxuliTeq56lmsQC5gpb+X6Xw18yN1jNFB4l+7PmDYN51B543hH5eIv5kDHxmgETLwJ
	dUSN0ivO5IAF5bdYBECKohssOoetQU2uGUaj3Zr2wDdl0GD1VJCYT46eek1Uzt7VzfKasg
	hwPdWpOXHzwNL8z/nitiAsoWO2GItEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716532311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3InHPw4zDCqDhiB22k++dKm8geIUyYGdUQMnurPTGoo=;
	b=Q9FWROvKUiebbih++9Dxzqk0ge2cOSBCE6PF+73p4zXOSwHPxx3rFa7BcyZ5lb5vNRRLz8
	TQSPWDXwyrjQa6Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J0pXQxul;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q9FWROvK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716532311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3InHPw4zDCqDhiB22k++dKm8geIUyYGdUQMnurPTGoo=;
	b=J0pXQxuliTeq56lmsQC5gpb+X6Xw18yN1jNFB4l+7PmDYN51B543hH5eIv5kDHxmgETLwJ
	dUSN0ivO5IAF5bdYBECKohssOoetQU2uGUaj3Zr2wDdl0GD1VJCYT46eek1Uzt7VzfKasg
	hwPdWpOXHzwNL8z/nitiAsoWO2GItEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716532311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3InHPw4zDCqDhiB22k++dKm8geIUyYGdUQMnurPTGoo=;
	b=Q9FWROvKUiebbih++9Dxzqk0ge2cOSBCE6PF+73p4zXOSwHPxx3rFa7BcyZ5lb5vNRRLz8
	TQSPWDXwyrjQa6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A5A513A6B;
	Fri, 24 May 2024 06:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2qmLE1c0UGblNAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 24 May 2024 06:31:51 +0000
Date: Fri, 24 May 2024 08:31:45 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Message-ID: <ZlA0Uc_gJ32g0btA@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <Zk-bpBZ_yjsj_B2z@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk-bpBZ_yjsj_B2z@x1n>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[csgroup.eu,linux-foundation.org,nvidia.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D62F7207F9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Thu, May 23, 2024 at 03:40:20PM -0400, Peter Xu wrote:
> I requested for help on the lsfmm hugetlb unification session, but
> unfortunately I don't think there were Power people around.. I'd like to
> request help from Power developers again here on the list: it will be very
> appreciated if you can help have a look at this series.

I am not a powerpc developer but I plan on keep on reviewing this series
today and next week.

thanks


-- 
Oscar Salvador
SUSE Labs

