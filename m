Return-Path: <linux-kernel+bounces-221689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6190F73D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7722823BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC782158DB4;
	Wed, 19 Jun 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g2jq7otu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g2jq7otu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC91876
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826894; cv=none; b=eE1QeUnaTuaYKN2jiKAdwVneBOboyOpPFQtlb1nCQTKTEH46NpuIS9ES47Ws6msa7juP42EuwLykCc5xNvpKcGqoJeeWFCgLuC7CBz4jXHowVToNH9z6G148/6CvKxoM+dJL7NRAqpojex2PNvFpZfoym/dX/e9t8CDBuHXZ6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826894; c=relaxed/simple;
	bh=jpQtD/db0pmjbS5p1djOR0Ntw8Lzd/wA0QE9Cm14fSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhNLZ5KsKv+2DxQitZFkt14pBZys8N05GqQV3ZGo3/erYgUzYFiFyhCSZUGtcpR8lbG8z6ULz3VMllHTQWyAD6kl8Bex9D88e4yOHcqslD+SsdyGvOhp6IIooum+8BsrqDEdo5lP6xSbmrqc0uTtpBygGBSUeGJJYZsJVNTvveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g2jq7otu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g2jq7otu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA4911F7D2;
	Wed, 19 Jun 2024 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718826889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vvPxvXNf8zuYWdKZlteUBeJJW5m05KwucRi2QZhjROQ=;
	b=g2jq7otuPH8lGW2UWyXzZQldU9CjsEl0R1MsMmgW92a44eQZgQNJdoBgM4Tq0qR4LvV7KR
	tJXTDkFn7OIAYGXeDt2YpcQ41O2aVPcsGzWzLrJ86hHKUL+BEBjA09rIBLjpzNryWfSszW
	mM0JbY9v6zgaa2IEqn3aT+XEpcveK04=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=g2jq7otu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718826889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vvPxvXNf8zuYWdKZlteUBeJJW5m05KwucRi2QZhjROQ=;
	b=g2jq7otuPH8lGW2UWyXzZQldU9CjsEl0R1MsMmgW92a44eQZgQNJdoBgM4Tq0qR4LvV7KR
	tJXTDkFn7OIAYGXeDt2YpcQ41O2aVPcsGzWzLrJ86hHKUL+BEBjA09rIBLjpzNryWfSszW
	mM0JbY9v6zgaa2IEqn3aT+XEpcveK04=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91B6013668;
	Wed, 19 Jun 2024 19:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hAWKIIk3c2bDcQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 19 Jun 2024 19:54:49 +0000
Date: Wed, 19 Jun 2024 21:54:48 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <ZnM3iFLPtFVVmCpR@tiehlicka>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka>
 <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
 <ZnKXNuuQRwNxRe4z@tiehlicka>
 <ZnKbR7IOd0b6GDBI@tiehlicka>
 <20240619174751.7r2s7iojxbaxpqlw@linux.dev>
 <CAHk-=whXL32xG1HWGaVaOkHf+g407upYbvZeZgmhnsxn2R+JRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXL32xG1HWGaVaOkHf+g407upYbvZeZgmhnsxn2R+JRQ@mail.gmail.com>
X-Rspamd-Queue-Id: AA4911F7D2
X-Spam-Score: -6.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 19-06-24 12:30:42, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 10:47, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Linus, please let me know if you have any concerns on the approach
> > Michal is suggesting i.e. a variant for warn once for unique call stack.
> 
> I think we should just try to change the existing WARN_ONCE(), and see
> if it causes any issues.
> 
> A new "WARN_UNIQUE()" might be the borign and safe approach, but
> 
>  (a) it won't actually be unique if you don't have stackdepot anyway,
> and will just be WARN_ONCE
> 
>  (b) I suspect most WARN_ONCE users really do want WARN_UNIQUE
> 
> so let's at least _start_ with just changing semantics of the existing
> "once", and then if it causes problems we'll have to revisit this.
> 
> I doubt it will cause problems,

I would be careful about the WARN_ONCE used from stackdepot itself. It's
been some time since I have looked into that code but a quick grep tells
there is some usage.

-- 
Michal Hocko
SUSE Labs

