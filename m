Return-Path: <linux-kernel+bounces-294267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA6958B71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B27F282CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0D19309D;
	Tue, 20 Aug 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYa3PeBk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O2wvUUMF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYa3PeBk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O2wvUUMF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAA18FDAB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168250; cv=none; b=sCIP93YxwTRZV5RmYxzYokhXybm4xHUZntsjNSisCV+xr1nAOonEw6qC9boqwpzrIr4qcW9C1+mgwM9BTrHsxBY3soBCJ7pvvb8kF2ADQ1yoyWGGlM5GoH9DYI86RqNZSIAQv0KVvpKW0XAl0GCPhQdP2rvzi3uJFJbQdkuiIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168250; c=relaxed/simple;
	bh=2yffWj0UaIiyBgZeT4GzAyc/ZZXzYWdXCrw78tPQpSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVmRuwD6tRP1pcvW49/qQy7GfUXyWQFRWMwTDUfW+IXSb7KIU8A+pgWNxaywXZ+gXFIAN1GFkmamUji2nqR9w4H2HsRD9lehccTbixHwZYc6mgGL1BbknPesphayKgAmJ8iUdBsLM1NaawryL3l4NdQj0GGcaEavxzxm/mdwFuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYa3PeBk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O2wvUUMF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYa3PeBk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O2wvUUMF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA6E11F80E;
	Tue, 20 Aug 2024 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724168246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8q+tVd0IVc3OuqYTQEo0xFd8mMVK1JV0i0DiNPGyVY=;
	b=oYa3PeBkqJEok6PaO1cgjzXLQ0IFq/Hy3rozwL1TPAe2hMUYoHFLB1SXFBe6qFFozfr4AB
	EfjyB5rLB2vbEo4cmzMH258TwupfKdegBTIj8lbxDhF3LUbMlIlSupf30o4SNzWhXYDQAe
	8jsMcPhPOHkCTpvzZrYzAkZqkyNdUPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724168246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8q+tVd0IVc3OuqYTQEo0xFd8mMVK1JV0i0DiNPGyVY=;
	b=O2wvUUMFZvIIhezXBhIYrWo+ac0JSRFiQXsSL4vZm8L4tqQF0fl5zk71LMnVESjQ7wvjIZ
	AGgKu7+Q/ZljwyDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oYa3PeBk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O2wvUUMF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724168246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8q+tVd0IVc3OuqYTQEo0xFd8mMVK1JV0i0DiNPGyVY=;
	b=oYa3PeBkqJEok6PaO1cgjzXLQ0IFq/Hy3rozwL1TPAe2hMUYoHFLB1SXFBe6qFFozfr4AB
	EfjyB5rLB2vbEo4cmzMH258TwupfKdegBTIj8lbxDhF3LUbMlIlSupf30o4SNzWhXYDQAe
	8jsMcPhPOHkCTpvzZrYzAkZqkyNdUPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724168246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8q+tVd0IVc3OuqYTQEo0xFd8mMVK1JV0i0DiNPGyVY=;
	b=O2wvUUMFZvIIhezXBhIYrWo+ac0JSRFiQXsSL4vZm8L4tqQF0fl5zk71LMnVESjQ7wvjIZ
	AGgKu7+Q/ZljwyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A186C13770;
	Tue, 20 Aug 2024 15:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zfw8JTa4xGZ8OAAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 20 Aug 2024 15:37:26 +0000
Date: Tue, 20 Aug 2024 18:42:20 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Corey Minyard <corey@minyard.net>
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Exit early when there is a SMBus error
Message-ID: <20240820154220.qnbuqebretmz42wd@localhost.localdomain>
References: <20240816065458.117986-1-iivanov@suse.de>
 <Zr+Up+94gmPEHwcJ@mail.minyard.net>
 <84eb700ee647cc40e9e99b086a8648e3@suse.de>
 <20240820102005.4l2j73jpt7lmwloh@localhost.localdomain>
 <CAB9gMfqj2KJ8=dxhKvJewYB8cE04F2y6pqCtHbXnKVJCjTBygQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9gMfqj2KJ8=dxhKvJewYB8cE04F2y6pqCtHbXnKVJCjTBygQ@mail.gmail.com>
X-Rspamd-Queue-Id: BA6E11F80E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi,

On 08-20 10:31, Corey Minyard wrote:
> > >
> > > >
> > > > 3) It appears the response to the GET_DEVICE_ID command, though a
> > > > response is returned, is not valid.  The right way to handle this would
> > > > be to do more validation in the ssif_detect() function.  It doesn't do
> > > > any validation of the response data, and that's really what needs to be
> > > > done.
> > > >
> > >
> > > do_cmd() in ssif_detect() already do validation. Perhaps,
> > > ssif_probe() should just not return ENODEV in case of error.
> > >
> >
> > Oh, I wanted to say ssif_detect, not ssif_probe.
> 
> Yeah, that's probably the right solution.  I'll look at this a bit.
> But I see the problem.  Do you want to do a patch, or do you want me
> to?

If you want to do it, please go ahead. I don't mind.

Thanks,
Ivan

