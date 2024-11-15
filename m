Return-Path: <linux-kernel+bounces-410803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C49CE126
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AA0287CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D961D0DDF;
	Fri, 15 Nov 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVJEV54D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8I5+RuzT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVJEV54D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8I5+RuzT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3161CEEAA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680554; cv=none; b=NtZLYDgGi1cMI0um6p0D0OJGyHtOecOpZViCiyW254QUvGKtLb3uM3SROiz96Tje2t2EYuDWXoPW74N080d2GgKki3zI89xpkAawYV5HO1IvwEDdZPjYtlrY2gehvxeRvvvJUp7ho0oS6G9PYIsSPjQ5tOXvxXtY3xG29x4u5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680554; c=relaxed/simple;
	bh=mmqyevj/dPTQrSEM+jlj4BcvtH2dmVKNbXXLtbPGsIU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jY6AVSTuS8cfneSwgC2aUA/71DFwdlq2UoW6u6XYp1ophcTP2NU/Xlx9W9nMlQI+i710J+r7OSStIh0b7VJZLf/qhps52xQ0R2BHdzok3+uqfNXZ+pLrF1e1I82JAeFHTRy7TTn0uG1dNV+R5NiZnHKmym/CPjoro4dr7NKB4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVJEV54D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8I5+RuzT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVJEV54D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8I5+RuzT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA4382127D;
	Fri, 15 Nov 2024 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731680550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=19ewfW9UTUsKqRxUAhyaAYGUe64lA2CjC/VuqEemcmM=;
	b=TVJEV54DFoB1kLSzDEKJb5Cp4pvGOc2jo0lcFX2d0GVoiM9PYazuKzcUbsoLujvPEtUNt2
	ty1PwhMDD8GPCZWLDVXcgYddEoMG182vtFfFhdXSPvHOdveabQrNU0N5u9gjwpP20TEMNj
	r8vLvYh4DFQFxVFQdYAhgyYKSLB2Hjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731680550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=19ewfW9UTUsKqRxUAhyaAYGUe64lA2CjC/VuqEemcmM=;
	b=8I5+RuzTSGCRZzi0vSFGYYpyXfnLx8JDHbu4dxkPgw/lR7KEPvV3Mofa4V90DatSlj3VML
	76ByGF5JYDHx/5Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TVJEV54D;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8I5+RuzT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731680550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=19ewfW9UTUsKqRxUAhyaAYGUe64lA2CjC/VuqEemcmM=;
	b=TVJEV54DFoB1kLSzDEKJb5Cp4pvGOc2jo0lcFX2d0GVoiM9PYazuKzcUbsoLujvPEtUNt2
	ty1PwhMDD8GPCZWLDVXcgYddEoMG182vtFfFhdXSPvHOdveabQrNU0N5u9gjwpP20TEMNj
	r8vLvYh4DFQFxVFQdYAhgyYKSLB2Hjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731680550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=19ewfW9UTUsKqRxUAhyaAYGUe64lA2CjC/VuqEemcmM=;
	b=8I5+RuzTSGCRZzi0vSFGYYpyXfnLx8JDHbu4dxkPgw/lR7KEPvV3Mofa4V90DatSlj3VML
	76ByGF5JYDHx/5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94AC3134B8;
	Fri, 15 Nov 2024 14:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NhLgIyZZN2cbJwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Nov 2024 14:22:30 +0000
Message-ID: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz>
Date: Fri, 15 Nov 2024 15:22:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Language: en-US
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA4382127D
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.com,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13

One new feature and non-critical fixes (mostly related to debugging).
No conflicts to be expected, AFAIK.

Thanks,
Vlastimil

======================================

- Add new slab_strict_numa boot parameter to enforce per-object memory policies
  on top of slab folio policies, for systems where saving cost of remote
  accesses is more important than minimizing slab allocation overhead
  (Christoph Lameter)

- krealloc() fixes for not violating __GFP_ZERO guarantees on krealloc() when
  slub_debug (redzone and object tracking) is enabled (Feng Tang)

- Fix a memory leak in case sysfs registration fails for a slab cache, and also
  no longer fail to create the cache in that case (Hyeonggon Yoo)

- Fix handling of detected consistency problems (due to buggy slab user) with
  slub_debug enabled, so that it does not cause further list corruption bugs
  (yuan.gao)

- Code cleanup and kerneldocs polishing (Zhen Lei, Vlastimil Babka)

----------------------------------------------------------------
Christoph Lameter (1):
      SLUB: Add support for per object memory policies

Feng Tang (5):
      mm/kasan: Don't store metadata inside kmalloc object when slub_debug_orig_size is on
      mm/slub: Move krealloc() and related code to slub.c
      mm/slub: Consider kfence case for get_orig_size()
      mm/slub: Improve redzone check and zeroing for krealloc()
      mm/slub, kunit: Add testcase for krealloc redzone and zeroing

Hyeonggon Yoo (1):
      mm/slab: Allow cache creation to proceed even if sysfs registration fails

Vlastimil Babka (2):
      mm, slab: add kerneldocs for common SLAB_ flags
      Merge branch 'slab/for-6.13/features' into slab/for-next

Zhen Lei (1):
      mm/slab: remove duplicate check in create_cache()

yuan.gao (1):
      mm/slub: Avoid list corruption when removing a slab from the full list

 Documentation/admin-guide/kernel-parameters.txt |  10 ++
 Documentation/mm/slub.rst                       |   9 +
 include/linux/slab.h                            |  60 ++++---
 lib/slub_kunit.c                                |  42 +++++
 mm/kasan/generic.c                              |   7 +-
 mm/slab.h                                       |  11 ++
 mm/slab_common.c                                | 101 ++---------
 mm/slub.c                                       | 212 +++++++++++++++++++++---
 8 files changed, 320 insertions(+), 132 deletions(-)

