Return-Path: <linux-kernel+bounces-245990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F083E92BC6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8332838AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352619B5AA;
	Tue,  9 Jul 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioFG9pVz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OiIzH1Oj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioFG9pVz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OiIzH1Oj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFF19B581
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533786; cv=none; b=Pkr/kyEBwrSgZnXmj5lc5CNoUU5vO4/Mq4Gll5RzUEL4g53KVTxrW0Ll/+Kgx1pTaoHtkioZK9G02WEXentzhyFlPxWAZp+MKt4mkswg2PljBr11dCFCrW6ML7NBCidvabvUNKK57EgntLe3D1rrH1pvOVemOYU21seqLi+FLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533786; c=relaxed/simple;
	bh=4cBtKCqTn2DNHHRdH23m7TBSp/YWmBxCZHwmuYIrDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8xS9xOcOVOBx1g13oANjSF3uowiYiHgoMcuXmG3VCMqVsYOstzaC+rY+qY6SBShgwcPyAOlhRDS2lJhu5BdR94zmOe4AWulumLv/2K6MKo2wz5nPeF3ssuJeXfI+RIT70Tn+AfNtN6BIv5AeR4bEu6WDAogoLXttJ4cV2gqXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioFG9pVz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OiIzH1Oj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioFG9pVz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OiIzH1Oj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7A91F7C2;
	Tue,  9 Jul 2024 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720533782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyncx8i5TISJb9MacWlSDc+0IoMyxyZ0b26Lhk5kcb0=;
	b=ioFG9pVzU7mE8jjm9TgIpDzOkFYk7ODhFZ/UWwvTLllHffD6KzweFC06PqeVkBgbBQftCz
	5TRAHuQG2yyqj4lObOLLeVAUSX7Z/CPuFT/LKVQ9xInsUF9hM9RtJMaU0HezV6925uzP3Y
	3o4no6rdZw1A/IJXjpEjlD5aox6475M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720533782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyncx8i5TISJb9MacWlSDc+0IoMyxyZ0b26Lhk5kcb0=;
	b=OiIzH1OjTd5PyW7ExdfqTP+oT8gAnMxSKm3kYycY5Ondq8KUZ1R3AIys7RxE29p18dy6gL
	N9PMYDsu/4F5KkAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720533782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyncx8i5TISJb9MacWlSDc+0IoMyxyZ0b26Lhk5kcb0=;
	b=ioFG9pVzU7mE8jjm9TgIpDzOkFYk7ODhFZ/UWwvTLllHffD6KzweFC06PqeVkBgbBQftCz
	5TRAHuQG2yyqj4lObOLLeVAUSX7Z/CPuFT/LKVQ9xInsUF9hM9RtJMaU0HezV6925uzP3Y
	3o4no6rdZw1A/IJXjpEjlD5aox6475M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720533782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyncx8i5TISJb9MacWlSDc+0IoMyxyZ0b26Lhk5kcb0=;
	b=OiIzH1OjTd5PyW7ExdfqTP+oT8gAnMxSKm3kYycY5Ondq8KUZ1R3AIys7RxE29p18dy6gL
	N9PMYDsu/4F5KkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA5FE1396E;
	Tue,  9 Jul 2024 14:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a6stLxRDjWavFwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 09 Jul 2024 14:03:00 +0000
Date: Tue, 9 Jul 2024 16:02:58 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tony Battersby <tonyb@cybernetics.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: Ensure
 generic_hugetlb_get_unmapped_area() returns higher address than
 mmap_min_addr
Message-ID: <Zo1DEjDawvmeqwRH@localhost.localdomain>
References: <20240709092122.41232-1-donettom@linux.ibm.com>
 <Zo0JSVzKKmG_1ADQ@localhost.localdomain>
 <dc4a8671-b8c2-484f-a83c-03bfc1fbe078@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4a8671-b8c2-484f-a83c-03bfc1fbe078@linux.ibm.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,linux.intel.com,kvack.org,vger.kernel.org,gmail.com,kernel.org,redhat.com,infradead.org,cybernetics.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Tue, Jul 09, 2024 at 07:14:38PM +0530, Donet Tom wrote:
> Thank you Oscar.

Hi Donet,

> The issue I am trying to fix will also get fixed by this new changes right.
> So should we drop my patch or should we continue it?

I would keep this patch as it is easier to backport as a small fixup.

Thanks

-- 
Oscar Salvador
SUSE Labs

