Return-Path: <linux-kernel+bounces-420771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB19D82F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8782163930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155281917EB;
	Mon, 25 Nov 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfgpKuZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="phIQdhnl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfgpKuZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="phIQdhnl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67341190067
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528623; cv=none; b=WrEHKR/XNcKHcQrGLawsWN+g23pz3fQKLerfXXOorBMeY4d6mCiYbBBJbpd3evJU/hXeF5JhAlnN+WZm1CJlMBkICSXzYxttnqd76shRJ7y4P2ei1MKpbkOgT2S0H5gxEaA2ybZU8aYJQPgMjIyXZm3Dk4KFIpoGgXuLSdC/DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528623; c=relaxed/simple;
	bh=ql0uoq4N0ApMmQKKGf+5LDuT+y4Ir/FSnXaBANe0iNw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RBAMRqGdUY/PCW63ejnmex/YooxfPlroRADG+qythq7z87QE0C5LcaaYXusLYy35ivNzAxWABoQLyNMSEjCnyZ7EVsQPK5PwfM4G8DHiJI5poAVkkRriXc1KG2p1P0S8dGmTL99ULR7T8r782Wx1lYQVLi+D28gdGVSFuGCuOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfgpKuZD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=phIQdhnl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfgpKuZD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=phIQdhnl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BE681F381;
	Mon, 25 Nov 2024 09:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732528613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=AdD1tY3/9e9DWsJA17kDb2v1X2CH+I1XWqcrnkbEmp0=;
	b=QfgpKuZDKJoMJNReE41GJbWl0ZPV9t7ktZFWQYv5MBerOo59HUaptkShiEu7Q8dSPgITjr
	xd7ahHoZ7R824mMYGEUJXH95q9aJsujTLhfm9UYwR01s3pNJKn2KUjR1OqBTG+3cHLIye+
	0VzHfJpoUsO2AZ1+GPsUk8ZftX9SSYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732528613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=AdD1tY3/9e9DWsJA17kDb2v1X2CH+I1XWqcrnkbEmp0=;
	b=phIQdhnl/knGcn97gHctfxEeIyrWa0xtM1UQ+z8NTnksXh001VaYgOazuWcmZG8ldV8BB1
	cB1lpmYDj9b9q0DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732528613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=AdD1tY3/9e9DWsJA17kDb2v1X2CH+I1XWqcrnkbEmp0=;
	b=QfgpKuZDKJoMJNReE41GJbWl0ZPV9t7ktZFWQYv5MBerOo59HUaptkShiEu7Q8dSPgITjr
	xd7ahHoZ7R824mMYGEUJXH95q9aJsujTLhfm9UYwR01s3pNJKn2KUjR1OqBTG+3cHLIye+
	0VzHfJpoUsO2AZ1+GPsUk8ZftX9SSYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732528613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=AdD1tY3/9e9DWsJA17kDb2v1X2CH+I1XWqcrnkbEmp0=;
	b=phIQdhnl/knGcn97gHctfxEeIyrWa0xtM1UQ+z8NTnksXh001VaYgOazuWcmZG8ldV8BB1
	cB1lpmYDj9b9q0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 077F313890;
	Mon, 25 Nov 2024 09:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+WCAeVJRGeiawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Nov 2024 09:56:53 +0000
Message-ID: <1e81a4f1-a3f0-4131-8515-cecfdc3b001a@suse.cz>
Date: Mon, 25 Nov 2024 10:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.13 v2
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.com,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13-v2

One new feature and non-critical fixes (mostly related to debugging).
No conflicts to be expected, AFAIK.

After fixing up the bug that was in the v1 pull 9 days ago, I've only added
Geert's fix on top 5 days ago, and it was all in -next.

Thanks,
Vlastimil

======================================

- Add new slab_strict_numa boot parameter to enforce per-object memory policies
  on top of slab folio policies, for systems where saving cost of remote
  accesses is more important than minimizing slab allocation overhead
  (Christoph Lameter)

- Fix for freeptr_offset alignment check being too strict for m68k (Geert
  Uytterhoeven)

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

Geert Uytterhoeven (1):
      slab: Fix too strict alignment check in create_cache()

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
 mm/slab_common.c                                | 103 ++---------
 mm/slub.c                                       | 218 +++++++++++++++++++++---
 8 files changed, 324 insertions(+), 136 deletions(-)

