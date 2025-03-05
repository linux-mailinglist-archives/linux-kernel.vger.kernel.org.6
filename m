Return-Path: <linux-kernel+bounces-547156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE52A5038C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500F47A3F73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39924EA82;
	Wed,  5 Mar 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGnYCtN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJvTI7T6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGnYCtN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJvTI7T6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9B17BEC5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188912; cv=none; b=W7iC1xOMlQuuHkm4AjuVCr4qDTR4Jm4fv804CExsBvKWWP6PhTeiLG3xkw8sxPyzKYAVN7u2St26ooH99BOtaWNrIn4L+LTyULug378WjiucJ7v7cn71oJWj8ZdA5CEIh/06zGY8F6PQPsRu2hdQHHdagx9tCcDZWNesF5Ne4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188912; c=relaxed/simple;
	bh=2Tsn3RX6Jpg6Y+PhKh0UX0nU6NsLzQZI+eGeBSU2+9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpmKayLWg4dYtCEKHYdtB0gk0sBtYw3xGb4ix18Um3l+nC4jqkuXiPuZmrFwBg8d5sjvYMhPoaQF/gdLriWAvOh0uHp5qOtlxnXfj67I8BOE3VQp6CdsC+RFz0w9Dye7RXF3+sWPYPFsG2khUD8I9oJFL+VGTG3HUzzciADvBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGnYCtN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJvTI7T6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGnYCtN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJvTI7T6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02BA01F455;
	Wed,  5 Mar 2025 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741188908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOv6CS9JAeNPbidCSJjm5U4++3N2p7V/En6on/y0/EQ=;
	b=mGnYCtN3/84vs6YtmCIc83L3ibfReJunwbX+cOQedUOgr6Idw+q771eiuPXUDt9zgOaYkf
	XQvrX50XPV0MPa8h8KHBc4ptmxus9zSXgg49QPEW8HyXt9pN/cpWGkFpwrap64XnENvvgU
	NOmgrHM1IFHVUt2F91x9j77T5mA0uRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741188908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOv6CS9JAeNPbidCSJjm5U4++3N2p7V/En6on/y0/EQ=;
	b=dJvTI7T6pdCJ58suBq5aTzQVHTD1PaOzUtQHZZttBmoRKOyrbMbbXatP372mT7SsPt82Va
	p2BDAXhPSk5P0kCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741188908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOv6CS9JAeNPbidCSJjm5U4++3N2p7V/En6on/y0/EQ=;
	b=mGnYCtN3/84vs6YtmCIc83L3ibfReJunwbX+cOQedUOgr6Idw+q771eiuPXUDt9zgOaYkf
	XQvrX50XPV0MPa8h8KHBc4ptmxus9zSXgg49QPEW8HyXt9pN/cpWGkFpwrap64XnENvvgU
	NOmgrHM1IFHVUt2F91x9j77T5mA0uRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741188908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOv6CS9JAeNPbidCSJjm5U4++3N2p7V/En6on/y0/EQ=;
	b=dJvTI7T6pdCJ58suBq5aTzQVHTD1PaOzUtQHZZttBmoRKOyrbMbbXatP372mT7SsPt82Va
	p2BDAXhPSk5P0kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2D1F1366F;
	Wed,  5 Mar 2025 15:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gArqNitvyGdVagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Mar 2025 15:35:07 +0000
Message-ID: <edda21bc-0dfe-4fd9-81e6-705095de9b1b@suse.cz>
Date: Wed, 5 Mar 2025 16:35:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Filipe Manana <fdmanana@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org> <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org> <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org> <Z60VE9SJHXEtfIbw@snowbird>
 <Z69mygllBATJ6dsm@tiehlicka> <Z7fmnsHTU49eYEaU@snowbird>
 <cfc2d4f2-08d4-45c1-830f-d1786306454a@suse.cz> <Z8hpWSsDuMX1salt@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z8hpWSsDuMX1salt@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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

On 3/5/25 16:10, Michal Hocko wrote:
> Sorry, I have missed follow ups here.
> 
>> I assume it's probably not easy to
>> implement as page table allocations are involved in the process and we don't
>> have a way to supply preallocated memory for those.
> 
> Why would this be a concern if the allocation is done outside of the
> lock?

It's not a concern if it can be done outside of the lock. I don't know the
code enough to see if it's feasible. There's e.g. pcpu_populate_chunk()
ending up doing vmap_pages_range_noflush() that AFAIK means page table
allocations. Can it be done outside of the lock?

