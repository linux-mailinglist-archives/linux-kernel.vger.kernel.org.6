Return-Path: <linux-kernel+bounces-283045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE594EC47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD9FB22496
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6CA3715E;
	Mon, 12 Aug 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xiU8XvQ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Iqbi5nOQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xiU8XvQ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Iqbi5nOQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835D178379
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464147; cv=none; b=NpDneIeZHRpxupvkLiORmmJ5C6VYQwgQj/uMBEAEX6R265+Ml59wLr1ZUjoYuUIu2sSFsONkio4kxDC+Pzgie8Gfu7AuLpeaf9bhgq5KdMR1RpDMT0lnw217ZFXnFvXxOSD+Yn8u2QDXb8jtuvbcZLLdtUNjPeAlVWKI5dwPIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464147; c=relaxed/simple;
	bh=RQo2jjLZZ7coDQ83/lz24So4c5zBz5QUMsoXibSmImM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj/ANLIPfjiFDx0yqxAMaiKBxXLeMfFbgIS+vuIH4Lx3ip8vKdcDdNPaQuh+rhkIQvImXVWL2NDd8dZqe3mCniqS0wEBolvHtz7EIcEu7R/mTL/0CuBrjTM3XWK+OJbPLWg1zaNYviuPr9vrQg3w/QfcPyjTuCL3FPEY0WIRs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xiU8XvQ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Iqbi5nOQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xiU8XvQ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Iqbi5nOQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B6A51F8BD;
	Mon, 12 Aug 2024 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723464143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
	b=xiU8XvQ//VNpLejWYYWjjEiPhoiZb6mHv6sSdA835NfAN7kw2iaQTtewd+sTaPGgcDcA/W
	ew1B6ogQdoYTYPiMT9BeOaynJKiyOUX7uKGEkkMDifFAifNoAaF6j8zbtSeKltA20sc5hQ
	JlDwvao04AoxUGj//1/XHV0rXi7XtNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723464143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
	b=Iqbi5nOQoLbcxMhXVZhTsJ5XwFepyplDX+XinbgK3X15n0Vq1/DDgYWphAmb4MTiFw2tHe
	BnNfhSOfmlrmSRBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723464143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
	b=xiU8XvQ//VNpLejWYYWjjEiPhoiZb6mHv6sSdA835NfAN7kw2iaQTtewd+sTaPGgcDcA/W
	ew1B6ogQdoYTYPiMT9BeOaynJKiyOUX7uKGEkkMDifFAifNoAaF6j8zbtSeKltA20sc5hQ
	JlDwvao04AoxUGj//1/XHV0rXi7XtNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723464143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
	b=Iqbi5nOQoLbcxMhXVZhTsJ5XwFepyplDX+XinbgK3X15n0Vq1/DDgYWphAmb4MTiFw2tHe
	BnNfhSOfmlrmSRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DA3D13A23;
	Mon, 12 Aug 2024 12:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OlqgFc/5uWYQYAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 12 Aug 2024 12:02:23 +0000
Date: Mon, 12 Aug 2024 14:02:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [LTP] [PATCH] syscalls/execve04, creat07: skip for kernels 6.11
 and later
Message-ID: <20240812120221.GA195572@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jan,

> The behaviour is allowed since commit:
>   2a010c412853 ("fs: don't block i_writecount during exec")
> that landed in 6.11-rc1.

Thanks for noticing and fixing this!

It was reported some time ago:
https://lore.kernel.org/all/202406141431.2b72ca61-oliver.sang@intel.com/
https://lore.kernel.org/ltp/202407162117.7730986d-oliver.sang@intel.com/

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/creat/creat07.c   | 10 ++++++++++
>  testcases/kernel/syscalls/execve/execve04.c | 10 ++++++++++
>  2 files changed, 20 insertions(+)

> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index 7bd32ab4d328..f157e1a8fbb2 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -47,7 +47,17 @@ static void verify_creat(void)
>  	SAFE_WAITPID(pid, NULL, 0);
>  }

> +static void setup(void)
> +{
> +	if ((tst_kvercmp(6, 11, 0)) >= 0) {
> +		tst_brk(TCONF, "Skipping test, write to executed file is "
> +			"allowed since 6.11-rc1.\n"
> +			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
> +	}
> +}
> +
>  static struct tst_test test = {
> +	.setup = setup,
>  	.test_all = verify_creat,
>  	.needs_checkpoints = 1,
>  	.forks_child = 1,
> diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
> index 3bac642e5412..7bbfece85906 100644
> --- a/testcases/kernel/syscalls/execve/execve04.c
> +++ b/testcases/kernel/syscalls/execve/execve04.c
> @@ -65,7 +65,17 @@ static void do_child(void)
>  	exit(0);
>  }

> +static void setup(void)
> +{
> +	if ((tst_kvercmp(6, 11, 0)) >= 0) {
> +		tst_brk(TCONF, "Skipping test, write to executed file is "
> +			"allowed since 6.11-rc1.\n"
> +			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
> +	}
> +}
> +
>  static struct tst_test test = {
> +	.setup = setup,
>  	.test_all = verify_execve,
>  	.forks_child = 1,
>  	.child_needs_reinit = 1,

