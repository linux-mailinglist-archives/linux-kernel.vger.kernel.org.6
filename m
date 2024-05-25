Return-Path: <linux-kernel+bounces-189267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018A8CEDC0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 05:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC70B2145E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 03:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51C2566;
	Sat, 25 May 2024 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gbS6YMSD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PtQqpJd0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gbS6YMSD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PtQqpJd0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74F17C9
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716608449; cv=none; b=Cuh5RnYGqNiZPQrg36bBjmy1bEBKw+ZIR1oBsS6AErsUtRg6b3atNpBdWZFn9w59dsKHx3bA+i4M+NtCxScDYg1hl3q5IXoKUh8MigPHt7sFCkoXT8qR8ksjShOW2pywyqa07A8v91MQwUavUSw7hRSh+dt9qX8OKY+dW/ApKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716608449; c=relaxed/simple;
	bh=BSeadLFnETLBmUA2XkITyKrdiuc0yEm1qP2/t4hx7EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1sb7TlgVPPqoLPrIV++k/Pm3MNd1OBwGuxXdc0kcZPViBBr7n4ntFUZAmeNhzMh0BjjrxY3rejDWG3QoHoZlV1Zzz2hR8RXgZBG6j/TTCzs35aQb45Or8CCfLa5rcAxOd4MYkvv+jTh+0v0l3UoKjIPw6ISHsc5sNcXCfSUKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gbS6YMSD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PtQqpJd0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gbS6YMSD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PtQqpJd0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1126521064;
	Sat, 25 May 2024 03:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716608445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNU9qeFsepeeGAGmgqAiK1AB+JMwJT8Q/7/phgdxQnM=;
	b=gbS6YMSDrrW/op936j3VdnuxmlZL9irjQ2NG0X6TvIvvAIbrkBsw0rAFq3ja+xG3srbLZA
	fHmsifiDSol0mgcYmbps1aLgvx0mzNcQWwIkq5EEUNSzpn63f2JGODct2jw6xf50JDnUR9
	59bGfE3PWlOmkifgjq6okByNTNN09E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716608445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNU9qeFsepeeGAGmgqAiK1AB+JMwJT8Q/7/phgdxQnM=;
	b=PtQqpJd0PtIVCSb7oGuQx6Gpn1OZtY4kuLNMzrLkbocOfcK5956p3Vbw1Fu9QS2j7fE2+2
	JSAYmnKrfXw7pEDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716608445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNU9qeFsepeeGAGmgqAiK1AB+JMwJT8Q/7/phgdxQnM=;
	b=gbS6YMSDrrW/op936j3VdnuxmlZL9irjQ2NG0X6TvIvvAIbrkBsw0rAFq3ja+xG3srbLZA
	fHmsifiDSol0mgcYmbps1aLgvx0mzNcQWwIkq5EEUNSzpn63f2JGODct2jw6xf50JDnUR9
	59bGfE3PWlOmkifgjq6okByNTNN09E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716608445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNU9qeFsepeeGAGmgqAiK1AB+JMwJT8Q/7/phgdxQnM=;
	b=PtQqpJd0PtIVCSb7oGuQx6Gpn1OZtY4kuLNMzrLkbocOfcK5956p3Vbw1Fu9QS2j7fE2+2
	JSAYmnKrfXw7pEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8187913A1E;
	Sat, 25 May 2024 03:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zaR5HLxdUWa8MAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 03:40:44 +0000
Date: Sat, 25 May 2024 05:40:35 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 09/20] powerpc/mm: Remove _PAGE_PSIZE
Message-ID: <ZlFdsyo2MB2stf41@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <c1d3ab0dc3cb890663a72597d516cce56b47f6e2.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d3ab0dc3cb890663a72597d516cce56b47f6e2.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, May 17, 2024 at 09:00:03PM +0200, Christophe Leroy wrote:
> _PAGE_PSIZE macro is never used outside the place it is defined
> and is used only on 8xx and e500.
> 
> Remove indirection, remove it and use its content directly.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

