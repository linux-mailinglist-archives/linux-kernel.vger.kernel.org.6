Return-Path: <linux-kernel+bounces-536857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A772DA48513
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179CE1886837
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B71B043D;
	Thu, 27 Feb 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIfOoQEy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+xrodu3M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIfOoQEy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+xrodu3M"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455F1B041C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673591; cv=none; b=Huli89p8SUw9LMTBwuFUHVcxAvgr4Uld/dnd46R03S4X1FV8MaaYNDHs5b92K0odlNT8LhInSH1sPOAiBj1g/jkowrC4ywu7l1LJQ+23/27bYhTPsXmJxksqb5izSayKo1cy0vf3ZQzv5Vz9bR64lFy2NguAdPl9ftZqXbGnwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673591; c=relaxed/simple;
	bh=Z0SxxWVcDnyhS64XxmG9uTMQYJ/O9T1it72XhO+4Q+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O7yjSytwTVKPdBADAs/B8uyP2KuJbuSgYvaipg2oChYxCWro+BlF7sIXHAvTnrS8Uv0mE5TcIGOPGiU23ZGwMua1TmMXZbKbzHBX4zC6ezL1RNCsq62ypQdGznH5uhsPGhH69bl+hBqyI+56pMzEIQCJ72yeG0wViUdJ2aNeNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIfOoQEy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+xrodu3M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIfOoQEy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+xrodu3M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2AB021189;
	Thu, 27 Feb 2025 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740673587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vyVsR4Q4LAukuHFIQ6wrluc/uk2zT74RbyvFHc6oqA4=;
	b=aIfOoQEyATKjvnsYbdyhOhxoSvQ/7Di5oOvSAkV8rRy6HZEB/0OTC/lh0+IW1gsQcIwPoZ
	ZvaC0xhSR77KED/aSYdd+OORnjm1+MnKSPai2wySBIloSaT7YvvvZcIGDObFTrqa4znxqa
	dualDg/kDb7DEtro4k5fZoma5wsMves=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740673587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vyVsR4Q4LAukuHFIQ6wrluc/uk2zT74RbyvFHc6oqA4=;
	b=+xrodu3MZEtPxcgg9/ZC5I38RNqas2GH6u7JWgv6ePLBD9QJUM+fPRm0LOGYGkek4TtcOw
	nZfJPm9ZMxlnyfBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aIfOoQEy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+xrodu3M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740673587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vyVsR4Q4LAukuHFIQ6wrluc/uk2zT74RbyvFHc6oqA4=;
	b=aIfOoQEyATKjvnsYbdyhOhxoSvQ/7Di5oOvSAkV8rRy6HZEB/0OTC/lh0+IW1gsQcIwPoZ
	ZvaC0xhSR77KED/aSYdd+OORnjm1+MnKSPai2wySBIloSaT7YvvvZcIGDObFTrqa4znxqa
	dualDg/kDb7DEtro4k5fZoma5wsMves=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740673587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vyVsR4Q4LAukuHFIQ6wrluc/uk2zT74RbyvFHc6oqA4=;
	b=+xrodu3MZEtPxcgg9/ZC5I38RNqas2GH6u7JWgv6ePLBD9QJUM+fPRm0LOGYGkek4TtcOw
	nZfJPm9ZMxlnyfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4491376A;
	Thu, 27 Feb 2025 16:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kayXGTOSwGekIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 27 Feb 2025 16:26:27 +0000
Message-ID: <a206637e-f63b-432a-aaa2-2e947ae5f4d8@suse.cz>
Date: Thu, 27 Feb 2025 17:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] mm: slub: Enhanced debugging in slub error
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, harry.yoo@oracle.com,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <CGME20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa@epcas2p4.samsung.com>
 <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <c1db529b-f16c-4195-8832-8f2cecd84ece@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <c1db529b-f16c-4195-8832-8f2cecd84ece@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A2AB021189
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[samsung.com,oracle.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/27/25 17:12, Vlastimil Babka wrote:
> On 2/26/25 09:11, Hyesoo Yu wrote:
>> Dear Maintainer,
>> 
>> The purpose is to improve the debugging capabilities of the slub allocator
>> when a error occurs. The following improvements have been made:
>> 
>>  - Added WARN() calls at specific locations (slab_err, object_err) to detect
>> errors effectively and to generate a crash dump if panic_on_warn is enabled.
>> 
>>  - Additionally, the error printing location in check_object has been adjusted to
>> display the broken data before the restoration process. This improvement
>> allows for a better understanding of how the data was corrupted.
>> 
>> This series combines two patches that were discussed seperately in the links below.
>> https://lore.kernel.org/linux-mm/20250120082908.4162780-1-hyesoo.yu@samsung.com/
>> https://lore.kernel.org/linux-mm/20250120083023.4162932-1-hyesoo.yu@samsung.com/
>> 
>> Thanks you.
> 
> Thanks. On top of things already mentioned, I added some kunit suppressions
> in patch 2. Please check the result:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.15/fixes-cleanups

What do you think about the following patch on top?

---8<---
From c38dadde6293cacdb91f95afc3615c22dec5830a Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 27 Feb 2025 16:05:46 +0100
Subject: [PATCH] mm, slab: cleanup slab_bug() parameters

slab_err() has variadic printf arguments but instead of passing them to
slab_bug() it does vsnprintf() to a buffer and passes %s, buf.

To allow passing them directly, turn slab_bug() to __slab_bug() with a
va_list parameter, and slab_bug() a wrapper with fmt, ... parameters.
Then slab_err() can call __slab_bug() without the intermediate buffer.

Also constify fmt everywhere, which also simplifies object_err()'s
call to slab_bug().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a9a02b4ae4d6..d94af020b305 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1017,12 +1017,12 @@ void skip_orig_size_check(struct kmem_cache *s, const void *object)
 	set_orig_size(s, (void *)object, s->object_size);
 }
 
-static void slab_bug(struct kmem_cache *s, char *fmt, ...)
+static void __slab_bug(struct kmem_cache *s, const char *fmt, va_list argsp)
 {
 	struct va_format vaf;
 	va_list args;
 
-	va_start(args, fmt);
+	va_copy(args, argsp);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	pr_err("=============================================================================\n");
@@ -1031,8 +1031,17 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 	va_end(args);
 }
 
+static void slab_bug(struct kmem_cache *s, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	__slab_bug(s, fmt, args);
+	va_end(args);
+}
+
 __printf(2, 3)
-static void slab_fix(struct kmem_cache *s, char *fmt, ...)
+static void slab_fix(struct kmem_cache *s, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -1088,12 +1097,12 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 }
 
 static void object_err(struct kmem_cache *s, struct slab *slab,
-			u8 *object, char *reason)
+			u8 *object, const char *reason)
 {
 	if (slab_add_kunit_errors())
 		return;
 
-	slab_bug(s, "%s", reason);
+	slab_bug(s, reason);
 	print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
@@ -1129,15 +1138,14 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 			const char *fmt, ...)
 {
 	va_list args;
-	char buf[100];
 
 	if (slab_add_kunit_errors())
 		return;
 
 	va_start(args, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, args);
+	__slab_bug(s, fmt, args);
 	va_end(args);
-	slab_bug(s, "%s", buf);
+
 	__slab_err(slab);
 }
 
@@ -1175,7 +1183,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 					  s->inuse - poison_size);
 }
 
-static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
+static void restore_bytes(struct kmem_cache *s, const char *message, u8 data,
 						void *from, void *to)
 {
 	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
@@ -1190,7 +1198,7 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 
 static pad_check_attributes int
 check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, char *what, u8 *start, unsigned int value,
+		       u8 *object, const char *what, u8 *start, unsigned int value,
 		       unsigned int bytes, bool slab_obj_print)
 {
 	u8 *fault;
-- 
2.48.1



