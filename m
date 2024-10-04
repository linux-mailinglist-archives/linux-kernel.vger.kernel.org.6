Return-Path: <linux-kernel+bounces-350418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76D9904EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2365E1C21192
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468CF212EFD;
	Fri,  4 Oct 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HVd0xC19";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4RWfQ8h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HVd0xC19";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4RWfQ8h"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86152101A7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050111; cv=none; b=iV8RPPgZzjPcU2NEpxC771rcT0WMgZb0EmSfpPbCI02Oo9qIGo1avdR1H+I5WD4CIhLTUgtOKq5MtyMj0CTlJz1QFJFlz+2wOgCNnc6dV8N/1Dw7QowF2qjSp4H8myaesj1bkWF3Pjbo3KopsN6jP0amuBwvf1EVqP7YVL/vJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050111; c=relaxed/simple;
	bh=/rcR+yeDUHl1+0UgMVbpyTsPgkZRt4tKyxFS+uCqpHY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AxGgMdYUhngfyrT0VxzESGFjmmV6djhk3/KeAcH2QPS5S4ETDSqmkLqx5coUtmmjdpUzzGA2nlDsLa/Vrej8ytlT3sjKEI1tR1zzxGRiVvuu9gZd/9LZuefPniwUMm7XM2ykOGzSBYEwAdy0BdkRT9Nf6kIudoCZrI2qOnFkNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HVd0xC19; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4RWfQ8h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HVd0xC19; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4RWfQ8h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 060E21FD8B;
	Fri,  4 Oct 2024 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728050108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=SN55S+hdaY6vIBeF2zIBytHRXHkj/YvO5Am0y62L86c=;
	b=HVd0xC19jcJ3+pe0XIJUkE76U4ZcP7y1OSNPi+WCMqZ5T9FthC4rpBsxX86XnhpKggcWJH
	IOnUC5sL+Askn70GgJ9GIPb1Vc1/s0KzrKPNRmugM8e0X7l4ek97T6+/VsBnvN9A3wsuC+
	foNtumjbNjUbIkoEJ3PBk6YLPyRa1us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728050108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=SN55S+hdaY6vIBeF2zIBytHRXHkj/YvO5Am0y62L86c=;
	b=D4RWfQ8hu6mE2REGw39/hD8LVXG9639EzRD1eL0Ddj6QMhh1zbJALp5QC+yt2ImoNmSPq/
	+k9wWcio3FG8N/CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HVd0xC19;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D4RWfQ8h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728050108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=SN55S+hdaY6vIBeF2zIBytHRXHkj/YvO5Am0y62L86c=;
	b=HVd0xC19jcJ3+pe0XIJUkE76U4ZcP7y1OSNPi+WCMqZ5T9FthC4rpBsxX86XnhpKggcWJH
	IOnUC5sL+Askn70GgJ9GIPb1Vc1/s0KzrKPNRmugM8e0X7l4ek97T6+/VsBnvN9A3wsuC+
	foNtumjbNjUbIkoEJ3PBk6YLPyRa1us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728050108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=SN55S+hdaY6vIBeF2zIBytHRXHkj/YvO5Am0y62L86c=;
	b=D4RWfQ8hu6mE2REGw39/hD8LVXG9639EzRD1eL0Ddj6QMhh1zbJALp5QC+yt2ImoNmSPq/
	+k9wWcio3FG8N/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E25DF13A6E;
	Fri,  4 Oct 2024 13:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qnrnNrvz/2ahXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 04 Oct 2024 13:55:07 +0000
Message-ID: <f26fdcde-b8fd-4d63-b113-d6d39ab3bf15@suse.cz>
Date: Fri, 4 Oct 2024 15:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab fixes for 6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 060E21FD8B
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.com,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com,roeck-us.net];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Linus,

please pull the latest slab fixes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc1

Thanks,
Vlastimil

======================================

Fixes for issues introduced in 6.12-rc1: kobject memory leak, unsupressed
warning and possible lockup in new slub_kunit tests, misleading code in
kvfree_rcu_queue_batch().

----------------------------------------------------------------
Nilay Shroff (1):
      mm, slab: fix use of SLAB_SUPPORTS_SYSFS in kmem_cache_release()

Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Refactor kvfree_rcu_queue_batch()

Vlastimil Babka (2):
      mm, slab: suppress warnings in test_leak_destroy kunit test
      slub/kunit: skip test_kfree_rcu when the slub kunit test is built-in

 kernel/rcu/tree.c |  9 +++++----
 lib/slub_kunit.c  | 18 ++++++++++++------
 mm/slab.h         |  8 +++++++-
 mm/slab_common.c  |  5 +++--
 mm/slub.c         |  5 +++--
 5 files changed, 30 insertions(+), 15 deletions(-)

