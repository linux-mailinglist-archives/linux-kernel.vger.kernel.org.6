Return-Path: <linux-kernel+bounces-281385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ABD94D64A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C7B21918
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6A8154C15;
	Fri,  9 Aug 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Po7AcCmx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbiOHTF4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Po7AcCmx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbiOHTF4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555314F124
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228072; cv=none; b=g90zCHccaw5CFpWAJiVy0nBqvdSNlJdtuiZbfh+wLbB30HKfFh3ch6dKSvm05LypLFAMq3QLZVN13g4gOUore8PNzV6ZPh73bk/3UkK04HeYUetadXQ29e+aXRAJghXMuQ7TvqfV/SV+QdBFQLgXhkb27VF8aneRq+9ITZWEhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228072; c=relaxed/simple;
	bh=HrVPXfJ8FcSRKfcEa92qd4melVApsxDvRmnzwdudVJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ81qJee8WEtiw6NXhpWSVkybV1bVs6VxqkxrxPsfSb2MmMtSAycnGuWQJTDsALNB2zIMUas1PmWK59wfZukAnM1b6kfEtprWjzaGsQQPyHUBIG8ggojd9nGQNnpgV548FdGnaiyoTeqcxphpLOnG8EY0bv7sJZA6jm/Xju0seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Po7AcCmx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbiOHTF4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Po7AcCmx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbiOHTF4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3170D21FAF;
	Fri,  9 Aug 2024 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723228068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rySDgwHwzk4soBkVhT5EA19C8VPh9xFHysLEK1LhtqQ=;
	b=Po7AcCmxLbJLLcSkX8H1OC+EwyZVgfr4wyskii6YpruHcD2iwTNIaJWZUGx3KgnBvoX4GB
	ee9ROCs2ElC6PxmUlbAdDw8G5SqMvoE5zGosV3Pa3CgL9LbtLhPkDMVlalFF4iJGluteki
	81xVJjxAaytVfzQmlPCr8X6F9t4i1V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723228068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rySDgwHwzk4soBkVhT5EA19C8VPh9xFHysLEK1LhtqQ=;
	b=pbiOHTF4OZtlfghBY56EDmFT71dpDONi6l30T7/+gBclVpeq9naKsDDox/QtvKzGe19j/h
	9qY5S3aT4ZkbNMCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723228068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rySDgwHwzk4soBkVhT5EA19C8VPh9xFHysLEK1LhtqQ=;
	b=Po7AcCmxLbJLLcSkX8H1OC+EwyZVgfr4wyskii6YpruHcD2iwTNIaJWZUGx3KgnBvoX4GB
	ee9ROCs2ElC6PxmUlbAdDw8G5SqMvoE5zGosV3Pa3CgL9LbtLhPkDMVlalFF4iJGluteki
	81xVJjxAaytVfzQmlPCr8X6F9t4i1V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723228068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rySDgwHwzk4soBkVhT5EA19C8VPh9xFHysLEK1LhtqQ=;
	b=pbiOHTF4OZtlfghBY56EDmFT71dpDONi6l30T7/+gBclVpeq9naKsDDox/QtvKzGe19j/h
	9qY5S3aT4ZkbNMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D7B1398D;
	Fri,  9 Aug 2024 18:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tr2yAaRftmayUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Aug 2024 18:27:48 +0000
Date: Fri, 9 Aug 2024 20:27:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Marco Elver <elver@google.com>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Sterba <dsterba@suse.cz>,
	syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
Subject: Re: [PATCH v8 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Message-ID: <20240809182746.GB25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[263726e59eab6b442723];
	FREEMAIL_CC(0.00)[gmail.com,google.com,arm.com,linux-foundation.org,linux.com,kernel.org,lge.com,suse.cz,linux.dev,googlegroups.com,vger.kernel.org,kvack.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Fri, Aug 09, 2024 at 05:36:54PM +0200, Jann Horn wrote:
> Changes in v8:
> - in patch 2/2:
>   - move rcu_barrier() out of locked region (vbabka)
>   - rearrange code in slab_free_after_rcu_debug (vbabka)
> - Link to v7: https://lore.kernel.org/r/20240808-kasan-tsbrcu-v7-0-0d0590c54ae6@google.com
> 
> Changes in v7:
> - in patch 2/2:
>   - clarify kconfig comment (Marco)
>   - fix memory leak (vbabka and dsterba)

FWIW, I've retested v7 and got no OOM (caused by the leak), on KASAN,
KFENCE and other debugging options enabled.

