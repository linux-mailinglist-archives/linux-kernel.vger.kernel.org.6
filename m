Return-Path: <linux-kernel+bounces-529289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A91A42282
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAC67A9145
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45B189903;
	Mon, 24 Feb 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mH8GCZ3U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYPGVfSt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WP+6ygUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlpSMHRo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAC13AA2D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406139; cv=none; b=ir4jYnhgw/IZq3sEmOeTSEefFaucIncgUaaw6t/G9g3M0ovZGbRqUp2LmU8pkhr5/MZ9taUd96LZtdg0ZJwcNlCI4fdyoEdoigdbiU2ZN0sEHseCeg4pmvFILCTVBcFpgmZPHIY0kVP/6CqiOzQI6xr6ky2Sg9TYAadKtJYiodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406139; c=relaxed/simple;
	bh=aRwgMBJEbC4DyepJ6lbB2uCfUtkzVlqDzVmBh0v/Mb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPwampWV8kCyQKZ+QIzMYG0+KFmvTRv3yYMrM0+whd8EuSWYUtkUjWZFzBUzswwMIvUd2GqQaJ18IT2NdJEPd2xZZioMKSIWRB2CAXQbHvvf80OZbxkX1/HqF9gG0bcc8aK8/Z/ZH3RUkkoJgD5FJqZD5Aobhw1V9wEzJ9/BMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mH8GCZ3U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYPGVfSt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WP+6ygUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlpSMHRo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E40361F395;
	Mon, 24 Feb 2025 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740406136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PJR6cxjc6nT2mQRF4wpwYFdBd4uWHFlc6Sghszo4W9s=;
	b=mH8GCZ3UonDbjty1DLnuO0nTZXzuL2c5sfGdbflzPnXOBowY3sPJmvAXusjVlP6tk/YQMJ
	0k1k6gXnz4nAo+P9UBg5rQmjwNgEi9l0CH0RLuGUQSXpB+TSzT6caED9B0n1WvCcMd3gfy
	xUA53xN1yZKdQ6CYk6nO3hsOPw4lqKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740406136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PJR6cxjc6nT2mQRF4wpwYFdBd4uWHFlc6Sghszo4W9s=;
	b=AYPGVfSt7QV4PnDTGjhuRzY+A07fqcHiasxlhmW/I7c9Yl4r0If0WwdAp5fSCFT/U85Me3
	q2NbeBdmaXFhCECg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WP+6ygUB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QlpSMHRo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740406135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PJR6cxjc6nT2mQRF4wpwYFdBd4uWHFlc6Sghszo4W9s=;
	b=WP+6ygUBL0W+SfETyxi+HjwrclftWv+PFpg6ZnLUz48o6YmCSeTGUvGDMlT21aXYP+aZ+1
	NanA1ODOuLZLdz+PTWvAf2ZRZZDvHFYFJDd8y7gD+UTGcUeBx73o/2Gu0ojq4dc7QROUsR
	8cOeAviSdl5DwwebXoF99PMbKHH+Xa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740406135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PJR6cxjc6nT2mQRF4wpwYFdBd4uWHFlc6Sghszo4W9s=;
	b=QlpSMHRoaRJ+zBI/YefB95gc9THj3HfKpsaZnt95/X2dUibDLrFMZQ7KdrDsPomZ30JyBP
	w63c0jqxuaymE0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C789613707;
	Mon, 24 Feb 2025 14:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aAEsMHd9vGdxPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 24 Feb 2025 14:08:55 +0000
Message-ID: <746be93d-7e62-4260-9b3e-0d7c1780c9c7@suse.cz>
Date: Mon, 24 Feb 2025 15:08:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
To: Hyesoo Yu <hyesoo.yu@samsung.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: janghyuck.kim@samsung.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
 <CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
 <20250220033953.1606820-2-hyesoo.yu@samsung.com> <Z7g2QeQp6HkyqCol@harry>
 <20250224024323.GA2153960@tiffany>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250224024323.GA2153960@tiffany>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E40361F395
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[samsung.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/24/25 03:43, Hyesoo Yu wrote:
> On Fri, Feb 21, 2025 at 05:16:01PM +0900, Harry Yoo wrote:
>> On Thu, Feb 20, 2025 at 12:39:43PM +0900, Hyesoo Yu wrote:
>> > Previously, the restore occured after printing the object in slub.
>> > After commit 47d911b02cbe ("slab: make check_object() more consistent"),
>> > the bytes are printed after the restore. This information about the bytes
>> > before the restore is highly valuable for debugging purpose.
>> > For instance, in a event of cache issue, it displays byte patterns
>> > by breaking them down into 64-bytes units. Without this information,
>> > we can only speculate on how it was broken. Hence the corrupted regions
>> > should be printed prior to the restoration process. However if an object
>> > breaks in multiple places, the same log may be output multiple times.
>> > Therefore the slub log is reported only once to prevent redundant printing,
>> > by sending a parameter indicating whether an error has occurred previously.
>> > 
>> > Changes in v3:
>> > - Change the parameter type of check_bytes_and_report.
>> > 
>> > Changes in v2:
>> > - Instead of using print_section every time on check_bytes_and_report,
>> > just print it once for the entire slub object before the restore.
>> > 
>> > Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
>> > Change-Id: I73cf76c110eed62506643913517c957c05a29520
>> > ---
>> >  mm/slub.c | 29 ++++++++++++++---------------
>> >  1 file changed, 14 insertions(+), 15 deletions(-)
>> > 
>> 
>> > @@ -1212,11 +1213,14 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>> >  	if (slab_add_kunit_errors())
>> >  		goto skip_bug_print;
>> >  
>> > -	slab_bug(s, "%s overwritten", what);
>> >  	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>> >  					fault, end - 1, fault - addr,
>> >  					fault[0], value);
>> >  
>> > +	scnprintf(buf, 100, "%s overwritten", what);
>> > +	if (slab_obj_print)
>> > +		object_err(s, slab, object, buf);
>> 
>> 
>> Wait, I think it's better to keep printing "%s overwritten" regardless
>> of slab_obj_print and only call __slab_err() if slab_obj_print == true
>> as discussed here [1]? Becuase in case there are multiple errors,
>> users should know.
>> 
>> [1] https://lore.kernel.org/all/2ff52c5e-4b6b-4b3d-9047-f00967315d3e@suse.cz
>> 
> 
> Hi,
> 
> __slab_err() doesn't include print_trainer(). It needs object_err().

print_trailer() could be used directly?

> How about including the specific error name 'what' to pr_err ?
> And then object_err would print "Object corrupt" at the beginning once
> without buf like below.

Could also work.

> 	if (slab_obj_print)
> 		object_err(s, slab, object, "Object corrupt");
> 
> 	pr_err("[%s] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>  	       what, fault, end - 1, fault - addr, fault[0], value);

Probably in opposite order so object_err doesn't panic_on_warn before the
pr_err?

> Thanks,
> Regards.
>> -- 
>> Cheers,
>> Harry
>> 
> 
> 


