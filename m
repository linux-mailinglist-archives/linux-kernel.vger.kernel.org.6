Return-Path: <linux-kernel+bounces-255080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACFC933B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ADC281BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05CD17E915;
	Wed, 17 Jul 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VRJDD72n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOHlMCVB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eO2XXnDs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kezN5bOp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2D1878
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213370; cv=none; b=Qsm5xMBRQDbuykHW3C93A0LyqC8pa2dEsLae1JTPVXiJCvaIY+La36xN8CezwahaDhh4CRmTknwmPbVqCmwstxFK1AjnS5Udn/gLT1ap/VfVqpcP4LBIohiRi1po8z8icWHS7qezotyvlVUzXLzrZkKnG4XrPjtHzMrfNcii9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213370; c=relaxed/simple;
	bh=FCPGPawy0PpJUUlXlmwF1rl29mMzK47cfsD2t8sm3jk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GKCD79FzqvVxDPPk/aQrvg7W9Sp4vLK7GUuNheK+11oRrMngOwogE+78qBbpaJ9UaCyxbLn0+wi13YBxB89BUVsTlN4SFRDXnQvcZIqdPf0eC8w97aK0x/KO179G+6oPV6Wykdg4ZaxeUBBuTG+gj1OORQocVV4U0AeBGTUipuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VRJDD72n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gOHlMCVB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eO2XXnDs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kezN5bOp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9D241FB70;
	Wed, 17 Jul 2024 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721213365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=V7NSMy3ZTUPzU+OGqTlPDgE+cYXSpW6JEbS0+KWnipo=;
	b=VRJDD72n/WrACPnkUcpTCdunuuZi8u88NMcZetgB/XdJG3iu2bhwgn62c674puBFXvqRQd
	JZfGUi+7kW+FAKnfcab9YfS8SYtg8VriiZ6lbUvCyW3lU5zK13w4+hunOo4Wgkjkb5Xcxr
	1nEngmqOjK4d7BOSRtjf0paYwQuhWOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721213365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=V7NSMy3ZTUPzU+OGqTlPDgE+cYXSpW6JEbS0+KWnipo=;
	b=gOHlMCVBrinEl9D3gnDTJSVLhqFHZ12/TxyeWSoHXVHhkBE09yA57lupJdTBkc8IEj55A7
	oirsYwZE1pnYXCAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721213363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=V7NSMy3ZTUPzU+OGqTlPDgE+cYXSpW6JEbS0+KWnipo=;
	b=eO2XXnDsM2rvK3MVwjfnmaP10veSdtx1/PGVZudcbajtCnuMPeJy1S/aj4FhfjFIbrX8yh
	jr2oWUahJMg0gGuUdw7YJLsotcq+bl4TG4ZEBq8V1ZKqM2542C6Y9fH4aowNwF4WwtJygf
	0NKrxkuLhsdFitfHsm1B6yqus2Yq4Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721213363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=V7NSMy3ZTUPzU+OGqTlPDgE+cYXSpW6JEbS0+KWnipo=;
	b=kezN5bOp7m/G7iM3SeRGQQ1f4jf6p7B/kbgE6zsfGc80TEwgtQO0zVvNH9U+waq7i0TlOg
	iJ8chxY+tBxK3ZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEACF1368F;
	Wed, 17 Jul 2024 10:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O9QVLrOhl2ZlPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jul 2024 10:49:23 +0000
Message-ID: <746087fd-993b-47b3-99e4-9bd4d3502e71@suse.cz>
Date: Wed, 17 Jul 2024 12:49:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <keescook@chromium.org>,
 Chengming Zhou <chengming.zhou@linux.dev>
Content-Language: en-US
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.com,lge.com,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com,chromium.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.11

no merge conflicts with other trees expected.

Thanks,
Vlastimil

======================================

The most prominent change this time is the kmem_buckets based hardening of
kmalloc() allocations from Kees Cook. We have also extended the kmalloc()
alignment guarantees for non-power-of-two sizes in a way that benefits rust.
The rest are various cleanups and non-critical fixups.

- Dedicated bucket allocator (Kees Cook)

  This series [1] enhances the probabilistic defense against heap
  spraying/grooming of CONFIG_RANDOM_KMALLOC_CACHES from last year. kmalloc()
  users that are known to be useful for exploits can get completely separate
  set of kmalloc caches that can't be shared with other users. The first
  converted users are alloc_msg() and memdup_user(). The hardening is enabled by
  CONFIG_SLAB_BUCKETS.

- Extended kmalloc() alignment guarantees (Vlastimil Babka)

  For years now we have guaranteed natural alignment for power-of-two
  allocations, but nothing was defined for other sizes (in practice, we have
  two such buckets, kmalloc-96 and kmalloc-192). To avoid unnecessary padding
  in the rust layer due to its alignment rules, extend the guarantee so that
  the alignment is at least the largest power-of-two divisor of the requested
  size. This fits what rust needs, is a superset of the existing power-of-two
  guarantee, and does not in practice change the layout (and thus does not add
  overhead due to padding) of the kmalloc-96 and kmalloc-192 caches, unless slab
  debugging is enabled for them.

- Cleanups and non-critical fixups (Chengming Zhou, Suren Baghdasaryan, Matthew
  Willcox, Alex Shi, Vlastimil Babka)

  Various tweaks related to the new alloc profiling code, folio conversion,
  debugging and more leftovers after SLAB.

[1] https://lore.kernel.org/all/20240701190152.it.631-kees@kernel.org/

----------------------------------------------------------------
Alex Shi (Tencent) (1):
      mm/memcg: alignment memcg_data define condition

Chengming Zhou (3):
      slab: make check_object() more consistent
      slab: don't put freepointer outside of object if only orig_size
      slab: delete useless RED_INACTIVE and RED_ACTIVE

Kees Cook (6):
      mm/slab: Introduce kmem_buckets typedef
      mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
      mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets argument
      mm/slab: Introduce kmem_buckets_create() and family
      ipc, msg: Use dedicated slab buckets for alloc_msg()
      mm/util: Use dedicated slab buckets for memdup_user()

Matthew Wilcox (Oracle) (1):
      mm: Reduce the number of slab->folio casts

Suren Baghdasaryan (2):
      mm, slab: move allocation tagging code in the alloc path into a hook
      mm, slab: move prepare_slab_obj_exts_hook under CONFIG_MEM_ALLOC_PROFILING

Vlastimil Babka (3):
      mm, slab: don't wrap internal functions with alloc_hooks()
      slab, rust: extend kmalloc() alignment guarantees to remove Rust padding
      Merge branch 'slab/for-6.11/buckets' into slab/for-next

 Documentation/core-api/memory-allocation.rst |   6 +-
 include/linux/mm.h                           |   6 +-
 include/linux/mm_types.h                     |   9 +-
 include/linux/poison.h                       |   7 +-
 include/linux/slab.h                         |  97 +++++++++----
 ipc/msgutil.c                                |  13 +-
 kernel/configs/hardening.config              |   1 +
 lib/fortify_kunit.c                          |   2 -
 lib/slub_kunit.c                             |   2 +-
 mm/Kconfig                                   |  17 +++
 mm/slab.h                                    |  14 +-
 mm/slab_common.c                             | 111 +++++++++++++-
 mm/slub.c                                    | 209 +++++++++++++++------------
 mm/util.c                                    |  23 ++-
 rust/kernel/alloc/allocator.rs               |  19 +--
 scripts/kernel-doc                           |   1 +
 tools/include/linux/poison.h                 |   7 +-
 17 files changed, 369 insertions(+), 175 deletions(-)

