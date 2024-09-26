Return-Path: <linux-kernel+bounces-340451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A43987397
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F711C24F33
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA72914;
	Thu, 26 Sep 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pezpaX6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3JmPbeA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pezpaX6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3JmPbeA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61AA48
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353814; cv=none; b=nXQWKD3RRYje1E9MN2QyJLWNJi7vSbY2OAzLKfCuc3UTTpeWL8wC9VcSk9ki60dB8/+cRLJUZPAT3sehI4cByzDZBzRHFjjXDeiGi/BW73QnJ6WYN4nh4+25Sl75G3q0oU9/fhXKnbDKwg/ayI1n7ttR6l0TDH/W2rEFqDEqFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353814; c=relaxed/simple;
	bh=+QoAen+fXg/sLex7/M1M5fANMsERLbLK01Fje5GYF78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp5Jd90OtD4Y0Q48i7GQyBjKHcrXIU1PforvW42qGqAX9Jy9EGWUUVCRv/DgcVD/oeZ53CTE9ekMO5Milxl5KK22f1wYHlbpCNpfCVwl3/F18vOgJ1jMpqpWAeF3rU5KguHOZ77M4T0gVk91Hi/QaZw13NuEcJGyXGuVXmbiImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pezpaX6T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3JmPbeA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pezpaX6T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3JmPbeA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D34121B2E;
	Thu, 26 Sep 2024 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727353810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zo60jMjO00nVhNNFzE7/q+zcOcoj7XavvWfdajyI+ok=;
	b=pezpaX6TOGBZuNk6teSUx0JJsWnZvNbz4A6PpfIBUfCobn4bebJSf2TfvhLnKbHv1nIPer
	dVFZ+MECdH/zlTGiNgkmTETY2J9VWsq20LtD/kSDjin5UxMD/XD/apQMw442AIVX0rAfPC
	l6m2nm4CwkIms5cfBKpmwN7y5yJHBmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727353810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zo60jMjO00nVhNNFzE7/q+zcOcoj7XavvWfdajyI+ok=;
	b=r3JmPbeAdr8Y4HT+NwCZzsOPrgg0TYn0vRApj2eqseJRxqm+O7eTQPw9cXhwSvY5PILzfD
	ANbGvyELHbIozgCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pezpaX6T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r3JmPbeA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727353810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zo60jMjO00nVhNNFzE7/q+zcOcoj7XavvWfdajyI+ok=;
	b=pezpaX6TOGBZuNk6teSUx0JJsWnZvNbz4A6PpfIBUfCobn4bebJSf2TfvhLnKbHv1nIPer
	dVFZ+MECdH/zlTGiNgkmTETY2J9VWsq20LtD/kSDjin5UxMD/XD/apQMw442AIVX0rAfPC
	l6m2nm4CwkIms5cfBKpmwN7y5yJHBmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727353810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zo60jMjO00nVhNNFzE7/q+zcOcoj7XavvWfdajyI+ok=;
	b=r3JmPbeAdr8Y4HT+NwCZzsOPrgg0TYn0vRApj2eqseJRxqm+O7eTQPw9cXhwSvY5PILzfD
	ANbGvyELHbIozgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F73013318;
	Thu, 26 Sep 2024 12:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BuIPE9JT9WaIUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 26 Sep 2024 12:30:10 +0000
Message-ID: <cb3b4858-00a8-459f-a195-7f9092f0da8e@suse.cz>
Date: Thu, 26 Sep 2024 14:30:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Introduce panic function when slub leaks
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tkjos@google.com,
 Fangzheng Zhang <fangzheng.zhang1003@gmail.com>,
 Yuming Han <yuming.han@unisoc.com>
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
 <CAB=+i9TJcnFhwef+efw8yBynZ28M2tWiYvuYS0aVoD4yt_+0Zw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAB=+i9TJcnFhwef+efw8yBynZ28M2tWiYvuYS0aVoD4yt_+0Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D34121B2E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,unisoc.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,linuxfoundation.org,kvack.org,vger.kernel.org,gmail.com,unisoc.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 9/25/24 15:18, Hyeonggon Yoo wrote:
> On Wed, Sep 25, 2024 at 12:23 PM Fangzheng Zhang
> <fangzheng.zhang@unisoc.com> wrote:
>>
>> Hi all,
> 
> Hi Fangzheng,
> 
>> A method to detect slub leaks by monitoring its usage in real time
>> on the page allocation path of the slub. When the slub occupancy
>> exceeds the user-set value, it is considered that the slub is leaking
>> at this time
> 
> I'm not sure why this should be a kernel feature. Why not write a user
> script that parses
> MemTotal: and Slab: part of /proc/meminfo file and generates a log
> entry or an alarm?

Yes very much agreed. It seems rather arbitrary. Why slab, why not any other
kernel-specific counter in /proc/meminfo? Why include NR_SLAB_RECLAIMABLE_B
when that's used by caches with shrinkers?
A userspace solution should be straightforward and universal - easily
configurable for different scenarios.

>> and a panic operation will be triggered immediately.
> 
> I don't think it would be a good idea to panic unnecessarily.
> IMO it is not proper to panic when the kernel can still run.

Yes these days it's practically impossible to add a BUG_ON() for more
serious conditions than this.

Please don't post new versions addressing specific implementation details
until this fundamental issue is addressed.

Thanks,
Vlastimil

> Any thoughts?
> 
> Thanks,
> Hyeonggon


