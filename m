Return-Path: <linux-kernel+bounces-376054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62919A9F49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BC8283557
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B519925F;
	Tue, 22 Oct 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOG8FUQF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MjHN/rUG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOG8FUQF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MjHN/rUG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71136198E91
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590931; cv=none; b=jg7QPCLhNNFbc4QX07nprgIbRQrL78vWw9qOGEz+gNnbMRjdbH5DGdhPiZV43h7ZCvGfUY+0BQKcGs5YpexnXkgWstUzH+wXq8IM78Hm2q19LOD4D8DOr/8w+AEyzEJc+BGfCRqocGCJPhaV1flyoOTnum7eERy13CVRoXFhsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590931; c=relaxed/simple;
	bh=lLN9XCWSAbWhcxeUCuYnjty++tHJbicZhl83HjCKcKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gmp4n83O49W5vi/IBG8h5jzftL/gwW2qUiY3wxJlHYY6vBiUjH/F/3ixKyPCPLlTJNMWcCFldhMtnNF99C/ogX9tg1RjQ10x8m1PkrPYMd2zGnSHCvvxB2oArb4MQ9ba/lSTl+FBVNlXfD6zWW/nV9WtG3kw30vZW4uq5T3k0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOG8FUQF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MjHN/rUG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOG8FUQF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MjHN/rUG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E0CD21C6F;
	Tue, 22 Oct 2024 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729590926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tLxno3zV9lqhIbmsZT7VMpZzM9bhASbyUfo/bqklLrU=;
	b=vOG8FUQF1CENhy0lu3Ku4bkEOBs5DTzZPh0gELfKM9l6nyyBS9bTj723PRM7BY/zgF5EzO
	0BRKNNYtdmh63N029HT1/CuLjt+0Aaq4CiYP0nOLumpRtKq7aaImMrOnNZANVpKc82SM5m
	eyXJMKiPg7By3pBEFwIQc0ZuKv2RTeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729590926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tLxno3zV9lqhIbmsZT7VMpZzM9bhASbyUfo/bqklLrU=;
	b=MjHN/rUGzPC1JkSzdtFEjFRtC1yAKQU1eIwGlT5W4/vuAVhzmrQJEJRwDppWqKA0UJmdIB
	Ob5JsC/W58RXviCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729590926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tLxno3zV9lqhIbmsZT7VMpZzM9bhASbyUfo/bqklLrU=;
	b=vOG8FUQF1CENhy0lu3Ku4bkEOBs5DTzZPh0gELfKM9l6nyyBS9bTj723PRM7BY/zgF5EzO
	0BRKNNYtdmh63N029HT1/CuLjt+0Aaq4CiYP0nOLumpRtKq7aaImMrOnNZANVpKc82SM5m
	eyXJMKiPg7By3pBEFwIQc0ZuKv2RTeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729590926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tLxno3zV9lqhIbmsZT7VMpZzM9bhASbyUfo/bqklLrU=;
	b=MjHN/rUGzPC1JkSzdtFEjFRtC1yAKQU1eIwGlT5W4/vuAVhzmrQJEJRwDppWqKA0UJmdIB
	Ob5JsC/W58RXviCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CB6E13AC9;
	Tue, 22 Oct 2024 09:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l/ccHo52F2eqGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Oct 2024 09:55:26 +0000
Message-ID: <ed2be51d-d294-498e-86dc-1d76b33e376c@suse.cz>
Date: Tue, 22 Oct 2024 11:55:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Steven Rostedt <rostedt@goodmis.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241022041243.7f2e53ad@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/22/24 10:12, Steven Rostedt wrote:
> On Mon, 21 Oct 2024 23:48:34 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> > How about this, instead: no one sends -rc1 PRs to Linus that didn't go
>> > through -next. Just have a bot that replies to all PRs with a health
>> > check, and Linus can pull it if he thinks it looks good.   
>> 
>> Not just -rc1, otherwise agreed.
> 
> You mean have everything go into linux-next before going to Linus after -rc1?
> 
> I'm one that doesn't do this. That's because my code in linux-next
> after -rc1 is for the next merge window, and the code I send to Linus
> is only fixes for code I sent before -rc1. I tend to keep an "urgent"
> and "core" branch. My "core" branch is everything I plan to send in the
> next merge window and goes into linux-next (via being pulled into my
> for-next branch). After I send my pull request to Linus, and he pulls
> it in the merge window, that "core" branch becomes my "urgent" branch.
> 
> But when I find a bug that's in Linus's tree, I put the fix on top of
> "urgent", run it through my test suite (takes 8 hours or so), then send
> a pull request to Linus. My "urgent" branch doesn't go into linux-next
> as it doesn't have changes that should affect others work, which is
> what I think linux-next is mostly for. I also find known bugs in
> Linus's tree to be high priority to be fixed (I stop what I'm doing to
> get the fix out ASAP).
> 
> Now, if there was better testing from linux-next, maybe it would be
> worth the time to push my urgent branch there for a bit. But so far I
> haven't seen the benefit of doing that.

I've seen somewhere mentioned (but can't now find where it was) that -next
has a pending-fixes branch [1] that's exactly intended to collect hotfix
branches from maintainer trees separately from the true "for next merge
window" branches. And that one of the points from the maintainers summit was
that this would be made more widely known and expected of maintainers to
use. Can anyone confirm?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=pending-fixes

>> 
>> > For example, for a given PR, the bot can report:
>> > 
>> > - Were the patches CCed to a mailing list?
>> > - A histogram of how long the patches were in next (to show bake times)
>> > - Are any patches associated with test failures? (0day and many other
>> > CIs are already running tests against -next; parse those reports)
>> > 
>> > We could have a real pre-submit checker! :)  
>> 
>> That would be very useful.  Items 1 and 2 should be trivial, 3 would
>> require a bit of work but would still be very useful.
> 
> If there was more feedback to going into linux-next, that would be good.
> 
> -- Steve
> 


