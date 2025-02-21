Return-Path: <linux-kernel+bounces-525536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC822A3F0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DAA3B76C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9884202C32;
	Fri, 21 Feb 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J8g6ynmI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SiIisenH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rndu6kxt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwHv7E2s"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDC204087
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131318; cv=none; b=ea7hdsrFGjjYT+sMHImLc5FfkBiDK6pfoaUYWrIaEtaF4+fEmY/tyHysFSY4WkCxGsLGJ/JOgepCiMyG8e9bmwGYH4uDCjfovj+/yBk6F3MaPgyNBQt0HiqeeKaUY7x5UuBgY63o2FZ58L6nQUnHCWBEfQTrchesR8d7CexUInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131318; c=relaxed/simple;
	bh=thg+KPgdeNl5ZEv8D01cSfBVXSh8ziTQ7XXzKSqmXOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idTVPtsrYYkfwPxlA12/qbCIgi05bwQeZRrsTEqjM5gemngFAu9LqQi+OFU7MnIq9zNnQXvCNYqAjPSPBb5djRp38bpuXglFPfZn0ZAW8F6H6yOmS4yKlfHu8vLsCukXjEZA7hLbRl8Q365Qg4blOEPfB8lQGL7u8eyw3L8qMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J8g6ynmI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SiIisenH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rndu6kxt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwHv7E2s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F010F211D2;
	Fri, 21 Feb 2025 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740131309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyX7HGqPKp4niDYTusUzp5w/Yf2gRba6+xe39ad1cc=;
	b=J8g6ynmIvSu4XXEpTtBbpskTxMPL4ZX1c/QyTPREln/InEUNChz+EgoaxXdJUh5o+YtZxH
	L2R0pH69rbi8LETBbP5atwHYY38YvwxhVB8E2+84sDYlYvVOCn9dsRWB1H/h/wO5YQP/TY
	pF5vzB+QJWd54vk/coDFIUdsPEwy4Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740131309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyX7HGqPKp4niDYTusUzp5w/Yf2gRba6+xe39ad1cc=;
	b=SiIisenHj+jkGc9PSBgzR6yE7xEpbmn7yQHBOsHoGNzqn/P84SpXfIn+R/QqSzCTH7Chq6
	ZBfha9WpVOk202AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rndu6kxt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wwHv7E2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740131308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyX7HGqPKp4niDYTusUzp5w/Yf2gRba6+xe39ad1cc=;
	b=Rndu6kxt4mMRvoIxJor9KNG2q7htS7KGO/4owQ86bVMsbg3eHK57Fs83MtNwJVvEYjHJRa
	3RjHOBiukI2cTe7kOTMynvxTCBsl4gy5H0dqCdYg1K3OuAxclQPsjvnjpA4UUyc/lZ3hbF
	f71Tsf7TlC71zG1XfA/91/e5uVKkWjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740131308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyX7HGqPKp4niDYTusUzp5w/Yf2gRba6+xe39ad1cc=;
	b=wwHv7E2sD9jV31h0+MjtCCx/du9cFxjGcGyPW82y2xZp7o9VxiwSfyfaI0Bpnn0DTWZMi9
	2ajRllDyEzAiDXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8A43136AD;
	Fri, 21 Feb 2025 09:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nnPHMuxLuGcZLQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Feb 2025 09:48:28 +0000
Message-ID: <cfc2d4f2-08d4-45c1-830f-d1786306454a@suse.cz>
Date: Fri, 21 Feb 2025 10:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Content-Language: en-US
To: Dennis Zhou <dennis@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org> <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org> <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org> <Z60VE9SJHXEtfIbw@snowbird>
 <Z69mygllBATJ6dsm@tiehlicka> <Z7fmnsHTU49eYEaU@snowbird>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z7fmnsHTU49eYEaU@snowbird>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F010F211D2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/21/25 03:36, Dennis Zhou wrote:
> I've thought about this in the back of my head for the past few weeks. I
> think I have 2 questions about this change.
> 
> 1. Back to what TJ said earlier about probing. I feel like GFP_KERNEL
>    allocations should be okay because that more or less is control plane
>    time? I'm not sure dropping PR_SET_IO_FLUSHER is all that big of a
>    work around?

This solves the iscsid case but not other cases, where GFP_KERNEL
allocations are fundamentally impossible.

> 2. This change breaks the feedback loop as we discussed above.
>    Historically we've targeted 2-4 free pages worth of percpu memory.
>    This is done by kicking the percpu work off. That does GFP_KERNEL
>    allocations and if that requires reclaim then it goes and does it.
>    However, now we're saying kswapd is going to work in parallel while
>    we try to get pages in the worker thread.
> 
>    Given you're more versed in the reclaim side. I presume it must be
>    pretty bad if we're failing to get order-0 pages even if we have
>    NOFS/NOIO set?

IMHO yes, so I don't think we need to pre-emptively fear that situation that
much. OTOH in the current state, depleting pcpu's atomic reserves and
failing pcpu_alloc due to not being allowed to take the mutex can happen
easily and even if there's plenty of free memory.

>    My feeling is that we should add back some knowledge of the
>    dependency so if the worker fails to get pages, it doesn't reschedule
>    immediately. Maybe it's as simple as adding a sleep in the worker or
>    playing with delayed work...

I think if we wanted things to be more robust (and perhaps there's no need
to, see above), the best way would be to make the worker preallocate with
GFP_KERNEL outside of pcpu_alloc_mutex. I assume it's probably not easy to
implement as page table allocations are involved in the process and we don't
have a way to supply preallocated memory for those.

> Thanks,
> Dennis


