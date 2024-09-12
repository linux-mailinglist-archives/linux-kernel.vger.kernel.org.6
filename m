Return-Path: <linux-kernel+bounces-326192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D329764AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF80AB23BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52BC18EFFB;
	Thu, 12 Sep 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ieZZFiIM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="enyGsZuL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ieZZFiIM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="enyGsZuL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D6146A6F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130084; cv=none; b=hAtvyDv5S6AgLduVSOGIJamtoL0qVNgfY39f7zhf+Lmoh1LtipBZi8DGYSUuxRvf7zXClnlxf4WqynZWDQsvGaQ9QMy7+YIwu/nVT4XIwj6wr6HPrQ/MVYjisfGjG0HJUDymeL9WC7EslELucahSd1UzFN5AsC1HVaRxVQCAROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130084; c=relaxed/simple;
	bh=ySlQY3U5V6jOYrsy6HoDI1cAB5mV+6C0L+OvHlrCL/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpSQhcWy2Wt1vYSpizlX5jpMu5k3I+omA2IQqB2bF+Vg14jk0J8FaAPxd09uqcd/edK/WAO9LniFXp7I5TO2LGFJUNZ4hmRuCAHTkLRrtwrElZDkgLMxd6pStpg708RoSWGWyyw/pB/JeRu7HS5lC6jhsuxLssuJ1lSyp4zPqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ieZZFiIM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=enyGsZuL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ieZZFiIM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=enyGsZuL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6797F1F749;
	Thu, 12 Sep 2024 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726130073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vSlW2mj6hD4LR8e4gZcftplwnj3Y6rJwu2Q/qh132ws=;
	b=ieZZFiIMP5aHssROuIp4Jhg4OSalKWvMbOdsunRFbXSgcza58pcLTC/DTQYoeBFAViWin+
	DHfUbQAloMkokau70DbacxBtjLb5CObAqHH7vvJcTzwoy/vszq7erLNOkoClUKyKHVBlkV
	eTk4AtsoaV6VyD4iYW814wX2fT31lFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726130073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vSlW2mj6hD4LR8e4gZcftplwnj3Y6rJwu2Q/qh132ws=;
	b=enyGsZuLGxxaBGRlOQkwdTC0dbHpXmAObY7F2CKboLiYoFy2qWfVnDwFN0K+qSV21NvXNW
	vHnOj9NcWdK2qHDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ieZZFiIM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=enyGsZuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726130073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vSlW2mj6hD4LR8e4gZcftplwnj3Y6rJwu2Q/qh132ws=;
	b=ieZZFiIMP5aHssROuIp4Jhg4OSalKWvMbOdsunRFbXSgcza58pcLTC/DTQYoeBFAViWin+
	DHfUbQAloMkokau70DbacxBtjLb5CObAqHH7vvJcTzwoy/vszq7erLNOkoClUKyKHVBlkV
	eTk4AtsoaV6VyD4iYW814wX2fT31lFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726130073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vSlW2mj6hD4LR8e4gZcftplwnj3Y6rJwu2Q/qh132ws=;
	b=enyGsZuLGxxaBGRlOQkwdTC0dbHpXmAObY7F2CKboLiYoFy2qWfVnDwFN0K+qSV21NvXNW
	vHnOj9NcWdK2qHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54C2B13AD8;
	Thu, 12 Sep 2024 08:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f59WFJmn4mb+DwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 12 Sep 2024 08:34:33 +0000
Message-ID: <c71a884d-714f-4741-906f-4df162bde303@suse.cz>
Date: Thu, 12 Sep 2024 10:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about freeing of empty per-CPU partial slabs in SLUB
Content-Language: en-US
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Imran Khan <imran.f.khan@oracle.com>
References: <CA+fCnZfFZCCq6ZQuVHoKY2tRJ3z1p0ftPW360-s=1JWd5Rv3JQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CA+fCnZfFZCCq6ZQuVHoKY2tRJ3z1p0ftPW360-s=1JWd5Rv3JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6797F1F749
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,google.com,linux.com,gmail.com,oracle.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 9/10/24 18:38, Andrey Konovalov wrote:
> Hi Vlastimil

Hi!

> (and other SLUB maintainers),

you didn't CC them, so doing it at least for the active ones...

> I have a question about freeing of empty per-CPU partial slabs in the
> SLUB allocator.
> 
> The "Linux SLUB Allocator Internals and Debugging" article [1] states:

And we can Cc Imran too :)

> "If the partial slab becomes an empty slab after freeing up the
> object, it will be left in its current list if the number of partial
> slabs for the concerned node is within the limits (i.e < slab cache’s
> min_partial). This applies to both slabs belonging to a per-cpu
> partial slab list and slabs belonging to a per-node partial slab list.
> If the number of partial slabs are outside the limit (i.e >= slab
> cache’s min partial) then the newly available empty slab is freed and
> is removed from the corresponding partial slab list."
> 
> The part that seems wrong to me here is the statement that this
> applies to the per-CPU partial list. Based on the code in __slab_free,
> it looks like it cannot reach the slab_empty label for a slab that is
> on the per-CPU partial list.
> 
> (I know that an empty per-CPU partial slab can be freed when the list
> overflows or via shrinking, the question is about the slab being freed
> directly by __slab_free.)
> 
> Is the article wrong with regards to this case? Or did this behavior
> change recently (I failed found any traces of this)?

I don't think the behavior changed recently in this aspect, only in some
other details like tracking on_node_partial with a page flag for better
performance, and slabs on per-cpu partial list are no longer frozen.

I think the paragraph you quoted can be interpreted together with this part
of the preceding one: "However while putting this partial slab on a per-cpu
partial slab list if it is found that the per-cpu partial slab list is
already full, then all slabs from the per-cpu partial slab list are unfrozen
i.e they are moved to a per-node partial slab list and this new partial slab
is put on the per-cpu partial slab list."

So while flushing the per-cpu partial list, the per-cpu partial slabs are
moved to per-node partial list, and when __put_partials() finds some of them
are empty, it applies the same s->min_partial threshold to decide whether to
keep them in node partial list or free them. So in that sense "This applies
to both..." part is correct, although as you say it cannot immediately
affect a slab on partial list we are freeing to.

> Other than this statement, the article seems to be correct about all
> other small details that I looked into, so I'm not sure whether my
> understanding of the code is wrong of the article is.

Yeah I like the articles too. Checking the code as well is a good strategy
as it may always evolve further since publishing :)

> I hope you could clarify this.

Hope that helps!
Vlastimil

> Thank you!
> 
> [1] https://blogs.oracle.com/linux/post/linux-slub-allocator-internals-and-debugging-1


