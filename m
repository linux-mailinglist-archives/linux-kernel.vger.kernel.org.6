Return-Path: <linux-kernel+bounces-248570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44FD92DF25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B51F22EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04823EA9A;
	Thu, 11 Jul 2024 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ifQddp+b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="huDiHLvd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ifQddp+b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="huDiHLvd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57763D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720672913; cv=none; b=eiR0nTj47Z9a9H9MurRHq0V7tJr5/di6fQfAmgyRGK9+8/mK9rOSQARUHOPyvDCez75mgm1X7PoQfZg/6031jgv4sOOKdhaT8mHP5nwGbwaZ5QPUKvLxxuz0IJn2t3E5RumQJFoB7sARLVB6g5Vq76hwh8ep/XT+vI6zQpj/sXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720672913; c=relaxed/simple;
	bh=+BxlrVpRH+vw7AQ7ZyqswdtAw7kYQPMV6e0BHQ2wjrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adIgoDpri2GABJLv9OWEKw8Gxb0ph6XACO2c5PqQtFyoVOykHc6M6qmB+TxxRisOlLcSEiKk79nAEjr+sGog+QVP59wI2o5rQsnuOYxRAyNHjlfupVjlw84NnDyHpv2CB1h/fdfKo1GP9zoSfzciCgA3JfQ09RagMq3I4ggH9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ifQddp+b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=huDiHLvd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ifQddp+b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=huDiHLvd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5048D21AD9;
	Thu, 11 Jul 2024 04:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720672909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGC4t0EPsoDxakk7kovehODLvnJDDjL515TUwaqwESk=;
	b=ifQddp+bVIeM+Yx+z9uKTOHtGHhCStkpqcwPYZe6gJ0Dk5hU/dR5KMBejCNnNTG+O6ze5d
	dh9RObfIQIj7ndmf0GbFkX9sj5fVX6hZkJfmlMEBZw0r9E24oHS/e/WPjQ3wVcgM5TPwhr
	qTC085XcWU6rkFYGxnRq+wGsOc2T77w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720672909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGC4t0EPsoDxakk7kovehODLvnJDDjL515TUwaqwESk=;
	b=huDiHLvd0kRpqQ791FvfFmskD0Uh2F2/dbc1hQTNr8yKgicf6jV6fKPwoSu2sKBZhOVDXU
	uV4IYonSvhQooODg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720672909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGC4t0EPsoDxakk7kovehODLvnJDDjL515TUwaqwESk=;
	b=ifQddp+bVIeM+Yx+z9uKTOHtGHhCStkpqcwPYZe6gJ0Dk5hU/dR5KMBejCNnNTG+O6ze5d
	dh9RObfIQIj7ndmf0GbFkX9sj5fVX6hZkJfmlMEBZw0r9E24oHS/e/WPjQ3wVcgM5TPwhr
	qTC085XcWU6rkFYGxnRq+wGsOc2T77w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720672909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGC4t0EPsoDxakk7kovehODLvnJDDjL515TUwaqwESk=;
	b=huDiHLvd0kRpqQ791FvfFmskD0Uh2F2/dbc1hQTNr8yKgicf6jV6fKPwoSu2sKBZhOVDXU
	uV4IYonSvhQooODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86248136D6;
	Thu, 11 Jul 2024 04:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b21xG4xij2bSFgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 11 Jul 2024 04:41:48 +0000
Date: Thu, 11 Jul 2024 06:41:38 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 2/3] mm: Remove pud_user() from
 asm-generic/pgtable-nopmd.h
Message-ID: <Zo9igs5GoQqjoi0w@localhost.localdomain>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
 <c31a39463929daba6c91917598ec05cf47103af5.1720597744.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31a39463929daba6c91917598ec05cf47103af5.1720597744.git.christophe.leroy@csgroup.eu>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Wed, Jul 10, 2024 at 09:51:21AM +0200, Christophe Leroy wrote:
> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> issues") added pud_user() in include/asm-generic/pgtable-nopmd.h
> 
> But pud_user() only exists on ARM64 and RISCV and is not expected
> by any part of MM.
> 
> Add the missing definition in arch/riscv/include/asm/pgtable-32.h
> and remove it from asm-generic/pgtable-nopmd.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

