Return-Path: <linux-kernel+bounces-310892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F073C96828C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B21F232DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40EA187852;
	Mon,  2 Sep 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IaU8guUU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxZIUg8E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IaU8guUU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxZIUg8E"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB21187345;
	Mon,  2 Sep 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267423; cv=none; b=ZR+gpxfbSHBorBrYWEcCTxClSDKBZjB6jHALIWRcshwj3JMcdgDjJ4gJYRdKLwcGg5xlXE6ZDwXN1ENrwSOzSsnzbD/jkk9xalKvRbWe+9+qq5SmL8DpKmbqbYIKBghB3vKG92dovW9SWuPLW4pdbP61fQRkdZusPu7vvuQGIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267423; c=relaxed/simple;
	bh=sJfnYRQWPkmTnINs3YO9zdTceyMWPciXF+xQNU2qrp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0+FnFB31TAFyRrJnOE0hInOjOql+IQBle2Ai/1lyZGYMKI2k/4IbIOODOhANHEqaTV8LcDcUJOTAFuJzCQlz8Yqykb6LSM6bibzXot8RH39GpvdeW4ACs9/ID6E/sGRFWMix4Gf01XMFpha+iLlSwXsp2UUzTqvDLfNusf9Lf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IaU8guUU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxZIUg8E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IaU8guUU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxZIUg8E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0E8C1FB9D;
	Mon,  2 Sep 2024 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725267418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WSA9U7lugzB3ukAjYh0xJQNLZfRIb4q7TpGenVYMhdM=;
	b=IaU8guUUCTm4JDib5mgg1mUuMLZh7uxJ7ZBnBsORedmn4RB9twHAuPDLb3FUAZBqArXSdJ
	8ijReHu5Ux6xXtUTfab/8s50fn1aPCxf5mBantxLNe5KuSHlKWNMNITu2EVoBI5HwYTX4Q
	aVRYt7rIvrPpMGn1xrwosIdN4Rokvzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725267418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WSA9U7lugzB3ukAjYh0xJQNLZfRIb4q7TpGenVYMhdM=;
	b=XxZIUg8EKw65nsI+ZTfV/pL4fvX10NqWFPcsq/znNaF29ywIK+ArgxR+XqqZoFEYjLMEx4
	Rb9EPIxIpmiETGCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IaU8guUU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XxZIUg8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725267418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WSA9U7lugzB3ukAjYh0xJQNLZfRIb4q7TpGenVYMhdM=;
	b=IaU8guUUCTm4JDib5mgg1mUuMLZh7uxJ7ZBnBsORedmn4RB9twHAuPDLb3FUAZBqArXSdJ
	8ijReHu5Ux6xXtUTfab/8s50fn1aPCxf5mBantxLNe5KuSHlKWNMNITu2EVoBI5HwYTX4Q
	aVRYt7rIvrPpMGn1xrwosIdN4Rokvzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725267418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WSA9U7lugzB3ukAjYh0xJQNLZfRIb4q7TpGenVYMhdM=;
	b=XxZIUg8EKw65nsI+ZTfV/pL4fvX10NqWFPcsq/znNaF29ywIK+ArgxR+XqqZoFEYjLMEx4
	Rb9EPIxIpmiETGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F02913A7C;
	Mon,  2 Sep 2024 08:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3J9bHtp91WZhSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 02 Sep 2024 08:56:58 +0000
Message-ID: <ec7bca4c-e77c-4c5b-9f52-33429e13731f@suse.cz>
Date: Mon, 2 Sep 2024 10:56:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
To: Feng Tang <feng.tang@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, "cl@linux.com" <cl@linux.com>,
 "penberg@kernel.org" <penberg@kernel.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
 "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
 "urezki@gmail.com" <urezki@gmail.com>, "hch@infradead.org"
 <hch@infradead.org>, "kees@kernel.org" <kees@kernel.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
 "mhocko@kernel.org" <mhocko@kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "chandan.babu@oracle.com" <chandan.babu@oracle.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz> <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae> <ZqhDXkFNaN_Cx11e@cassiopeiae>
 <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>
 <ZtUWmmXRo+pDMmDY@feng-clx.sh.intel.com>
 <ZtVjhfITqhKJwqI2@feng-clx.sh.intel.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZtVjhfITqhKJwqI2@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C0E8C1FB9D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.com,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,ellerman.id.au,oracle.com,amd.com,vger.kernel.org,kvack.org,googlegroups.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/2/24 09:04, Feng Tang wrote:
> On Mon, Sep 02, 2024 at 09:36:26AM +0800, Tang, Feng wrote:
>> On Tue, Jul 30, 2024 at 08:15:34PM +0800, Vlastimil Babka wrote:
>> > On 7/30/24 3:35 AM, Danilo Krummrich wrote:
> [...]
>> > 
>> > Let's say we kmalloc(56, __GFP_ZERO), we get an object from kmalloc-64
>> > cache. Since commit 946fa0dbf2d89 ("mm/slub: extend redzone check to
>> > extra allocated kmalloc space than requested") and preceding commits, if
>> > slub_debug is enabled (red zoning or user tracking), only the 56 bytes
>> > will be zeroed. The rest will be either unknown garbage, or redzone.
>> 
>> Yes.
>> 
>> > 
>> > Then we might e.g. krealloc(120) and get a kmalloc-128 object and 64
>> > bytes (result of ksize()) will be copied, including the garbage/redzone.
>> > I think it's fixable because when we do this in slub_debug, we also
>> > store the original size in the metadata, so we could read it back and
>> > adjust how many bytes are copied.
>> 
>> krealloc() --> __do_krealloc() --> ksize()
>> When ksize() is called, as we don't know what user will do with the
>> extra space ([57, 64] here), the orig_size check will be unset by
>> __ksize() calling skip_orig_size_check(). 
>> 
>> And if the newsize is bigger than the old 'ksize', the 'orig_size'
>> will be correctly set for the newly allocated kmalloc object.

Yes, but the memcpy() to the new object will be done using ksize() thus
include the redzone, e.g. [57, 64]

>> For the 'unstable' branch of -mm tree, which has all latest patches
>> from Danilo, I run some basic test and it seems to be fine. 

To test it would not always be enough to expect some slub_debug to fail,
you'd e.g. have to kmalloc(48, GFP_KERNEL | GFP_ZERO), krealloc(128,
GFP_KERNEL | GFP_ZERO) and then verify there are zeroes from 48 to 128. I
suspect there won't be zeroes from 48 to 64 due to redzone.

(this would have made a great lib/slub_kunit.c test :))

> when doing more test, I found one case matching Vlastimil's previous
> concern, that if we kzalloc a small object, and then krealloc with
> a slightly bigger size which can still reuse the kmalloc object,
> some redzone will be preserved.
> 
> With test code like: 
> 
> 	buf = kzalloc(36, GFP_KERNEL);
> 	memset(buf, 0xff, 36);
> 
> 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> 
> Data after kzalloc+memset :
> 
> 	ffff88802189b040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  
> 	ffff88802189b050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  
> 	ffff88802189b060: ff ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc  
> 	ffff88802189b070: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  
> 
> Data after krealloc:
> 
> 	ffff88802189b040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 	ffff88802189b050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 	ffff88802189b060: ff ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc
> 	ffff88802189b070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> If we really want to make [37, 48] to be zeroed too, we can lift the
> get_orig_size() from slub.c to slab_common.c and use it as the start
> of zeroing in krealloc().

Or maybe just move krealloc() to mm/slub.c so there are no unnecessary calls
between the files.

We should also set a new orig_size in cases we are shrinking or enlarging
within same object (i.e. 48->40 or 48->64). In case of shrinking, we also
might need to redzone the shrinked area (i.e. [40, 48]) or later checks will
fail.  But if the current object is from kfence, then probably not do any of
this... sigh this gets complicated. And really we need kunit tests for all
the scenarios :/

> Thanks,
> Feng


