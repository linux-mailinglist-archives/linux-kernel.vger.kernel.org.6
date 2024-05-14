Return-Path: <linux-kernel+bounces-179142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC178C5C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6D72810E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60637181BA9;
	Tue, 14 May 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B26BTArW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1IRBTVc1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B26BTArW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1IRBTVc1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D618133B;
	Tue, 14 May 2024 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718420; cv=none; b=BXKVdn63ykt4W5OAAdOWqRLITe4aP1FQda9OsTq6HmGcO0niQkSjdz7JyQu0erw5JGbp5RcuvPOLqLaepRXaoLnP9ot2ygO7PnombnY4yuyipW9SmVwrHiCmn0tqoSQHWIm5fxJYtl+atztHR7MES545PRB6J40gg6xxkUDq1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718420; c=relaxed/simple;
	bh=oU0zTOQEazN2a80NqjhwaXY8nU6keZNiSCitSjyv7TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV/90qgpLUcom9nkGhmWMTbinWmsoDjHEjsLT/iLPRRapEbK6EJyZYebaLO5Vaa4s40LJH+fRY43Z7An45vSK658pBCoegEXdSko1HLzV6XuOEL1C7gqG0oR96sqHSi6uRHfzSHpy8ck5PneRpvb0kLUvfV0TnGvZr3oByMVUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B26BTArW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1IRBTVc1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B26BTArW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1IRBTVc1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 731611F8BF;
	Tue, 14 May 2024 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715718416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yjxIwA1Fan6uISC9vU5afpsy0S0SjDWMQ82F600DAs=;
	b=B26BTArW7pLJtAbCnS8oHTPC4ZDZhEY+OSzSERTB3KdheXmHuHHbJerwugQ/S4xJqV7buD
	5mSzjHiXphrrAcFgozcOGhK+RBxF6kqZWb4uYjACars0BkL4RuLEL9E20b3DvyaNL2AxJJ
	kRt1K249Nnxyi7njIRMt1tqGOy8m4fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715718416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yjxIwA1Fan6uISC9vU5afpsy0S0SjDWMQ82F600DAs=;
	b=1IRBTVc1wBNIu6pO4byzhdDLYzRc7KSHpbB5c3jy4WMztCRTijmkU8eYjPHutAAcT0vUZ/
	V4wKrHrvTZFnLpAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B26BTArW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1IRBTVc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715718416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yjxIwA1Fan6uISC9vU5afpsy0S0SjDWMQ82F600DAs=;
	b=B26BTArW7pLJtAbCnS8oHTPC4ZDZhEY+OSzSERTB3KdheXmHuHHbJerwugQ/S4xJqV7buD
	5mSzjHiXphrrAcFgozcOGhK+RBxF6kqZWb4uYjACars0BkL4RuLEL9E20b3DvyaNL2AxJJ
	kRt1K249Nnxyi7njIRMt1tqGOy8m4fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715718416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yjxIwA1Fan6uISC9vU5afpsy0S0SjDWMQ82F600DAs=;
	b=1IRBTVc1wBNIu6pO4byzhdDLYzRc7KSHpbB5c3jy4WMztCRTijmkU8eYjPHutAAcT0vUZ/
	V4wKrHrvTZFnLpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DB3B1372E;
	Tue, 14 May 2024 20:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IIFZOw7JQ2YLHwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 20:26:54 +0000
Date: Tue, 14 May 2024 22:26:49 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <ZkPJCc5N1Eotpa4u@localhost.localdomain>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <Zj51rEwZeSK4Vr1G@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj51rEwZeSK4Vr1G@x1n>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,kernel.org,alien8.de,csgroup.eu,linux.intel.com,redhat.com,zytor.com,gmx.de,hansenpartnership.com,nvidia.com,huawei.com,infradead.org,ellerman.id.au,linux.dev,linux.ibm.com,gmail.com,linutronix.de,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLeqp5gkuwhygrjzi4zhnnr4iu)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 731611F8BF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

On Fri, May 10, 2024 at 03:29:48PM -0400, Peter Xu wrote:
> IMHO we shouldn't mention that detail, but only state the effect which is
> to not report the event to syslog.
> 
> There's no hard rule that a pte marker can't reflect a real page poison in
> the future even MCE.  Actually I still remember most places don't care
> about the pfn in the hwpoison swap entry so maybe we can even do it? But
> that's another story regardless..

But we should not use pte markers for real hwpoisons events (aka MCE), right?
I mean, we do have the means to mark a page as hwpoisoned when a real
MCE gets triggered, why would we want a pte marker to also reflect that?
Or is that something for userfaultd realm?

> And also not report swapin error is, IMHO, only because arch errors said
> "MCE" in the error logs which may not apply here.  Logically speaking
> swapin error should also be reported so admin knows better on why a proc is
> killed.  Now it can still confuse the admin if it really happens, iiuc.

I am bit confused by this.
It seems we create poisoned pte markers on swap errors (e.g:
unuse_pte()), which get passed down the chain with VM_FAULT_HWPOISON,
which end up in sigbus (I guess?).

This all seems very subtle to me.

First of all, why not passing VM_FAULT_SIGBUS if that is what will end
up happening?
I mean, at the moment that is not possible because we convolute swaping
errors and uffd poison in the same type of marker, so we do not have any
means to differentiate between the two of them.

Would it make sense to create yet another pte marker type to split that
up? Because when I look at VM_FAULT_HWPOISON, I get reminded of MCE
stuff, and that does not hold here.

 

-- 
Oscar Salvador
SUSE Labs

