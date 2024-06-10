Return-Path: <linux-kernel+bounces-208893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645D902A49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236821C22B56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F905381A;
	Mon, 10 Jun 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1eYfRFM8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2vfdYUX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1eYfRFM8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2vfdYUX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DC6F2FD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052870; cv=none; b=QJpnu71iR6ab/DfKR2Aa1j1/b0Bpt/QyFhpDFIbOQBxiP8Ch/cXnGt5mZqWfD+i+qVOA732hAmeWzxCXUeq32m9ApguUA7blHGrsWQsJmvLAtr82PwvXjJfozFCe6aKEK3IEbi2wUW9mNkMC14cD1BEmxwo2VvrTaB31ywoCpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052870; c=relaxed/simple;
	bh=UV93V0MtfJyC3kFzzVhZfURa1qRcTVKvomW70MH3jpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI9YosaSzd96QVtlw7hsIRrjxuERCi25KuphKfeiKsiYg20A8U7FufqvIdMimFVoVahSZZnDMaQgedXi7PxsN3APqNAjqeoNat2EIfIOkw1XUoYXon/WaCFAMyrsR2JprzOwJRmBwG6wLy/HxjggI7CnwLAqVSc/H9ce5ZkVUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1eYfRFM8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2vfdYUX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1eYfRFM8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2vfdYUX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFF47223A3;
	Mon, 10 Jun 2024 20:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718052866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D8EvIpkskRr1vhGK9ri1iDKoIXzTaRUj7OtCPaP0rAI=;
	b=1eYfRFM8h57O8vZYzfJIqGK1Za2rO4EhW+u4u5kh6HPkEaaAO0qx9Q6hnth9dVSWxqHL0r
	cjhJj/cBvUBnmgCod+vnj0Yl3cAJK4MW43rw+lkvbmehTpoJQoUhF4w8yJ9vzVxARYpnpL
	OlUAQHzyTCOEMLw2KfHpShxYYvqt0EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718052866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D8EvIpkskRr1vhGK9ri1iDKoIXzTaRUj7OtCPaP0rAI=;
	b=G2vfdYUX6E+/CiL22NT2ajbePzW/0qow2pRw0/daEuOXy0dIQI3cHbIiLOqVYWHflF7Q5U
	XQS2NCrUpPIZCFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718052866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D8EvIpkskRr1vhGK9ri1iDKoIXzTaRUj7OtCPaP0rAI=;
	b=1eYfRFM8h57O8vZYzfJIqGK1Za2rO4EhW+u4u5kh6HPkEaaAO0qx9Q6hnth9dVSWxqHL0r
	cjhJj/cBvUBnmgCod+vnj0Yl3cAJK4MW43rw+lkvbmehTpoJQoUhF4w8yJ9vzVxARYpnpL
	OlUAQHzyTCOEMLw2KfHpShxYYvqt0EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718052866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D8EvIpkskRr1vhGK9ri1iDKoIXzTaRUj7OtCPaP0rAI=;
	b=G2vfdYUX6E+/CiL22NT2ajbePzW/0qow2pRw0/daEuOXy0dIQI3cHbIiLOqVYWHflF7Q5U
	XQS2NCrUpPIZCFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFBDE13A51;
	Mon, 10 Jun 2024 20:54:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I8UqLgJoZ2YOLQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Jun 2024 20:54:26 +0000
Message-ID: <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
Date: Mon, 10 Jun 2024 22:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Chengming Zhou <chengming.zhou@linux.dev>
Cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Kees Cook <keescook@chromium.org>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
 <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
 <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,intel.com,kvack.org,vger.kernel.org,bytedance.com,chromium.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.79
X-Spam-Flag: NO

On 6/10/24 7:07 PM, Christoph Lameter (Ampere) wrote:
> On Fri, 7 Jun 2024, Chengming Zhou wrote:
> 
>> There are two inconsistencies in check_object(), which are alignment
>> padding checking and object padding checking. We only print the error
>> messages but don't return 0 to tell callers that something is wrong
>> and needs to be handled. Please see alloc_debug_processing() and
>> free_debug_processing() for details.
> 
> If the error is in the padding and the redzones are ok then its likely 
> that the objects are ok. So we can actually continue with this slab page 
> instead of isolating it.
> 
> We isolate it in the case that the redzones have been violated because 
> that suggests someone overwrote the end of the object f.e. In that case 
> objects may be corrupted. Its best to isolate the slab and hope for the 
> best.
> 
> If it was just the padding then the assumption is that this may be a 
> scribble. So clean it up and continue.

Hm is it really worth such nuance? We enabled debugging and actually hit a
bug. I think it's best to keep things as much as they were and not try to
allow further changes. This e.g. allows more detailed analysis if somebody
later notices the bug report and decides to get a kdump crash dump (or use
drgn on live system). Maybe we should even stop doing the restore_bytes()
stuff, and prevent any further frees in the slab page to happen if possible
without affecting fast paths (now we mark everything as used but don't
prevent further frees of objects that were actually allocated before).

Even if some security people enable parts of slub debugging for security
people it is my impression they would rather panic/reboot or have memory
leaked than trying to salvage the slab page? (CC Kees)

