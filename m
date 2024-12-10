Return-Path: <linux-kernel+bounces-439943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE479EB68B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC43B28353C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FA22FE1C;
	Tue, 10 Dec 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rpbpZatN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytWnKGwJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rpbpZatN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytWnKGwJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699211BDA97
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848479; cv=none; b=I3RwJuSJ0ukDr7lVl1J267+TE8NJ9VgMh/041SFfbqgLB2LVwwRAvmCt4fKEHXO00aqTmMPw+qUw33t3LPFvdkmOUGSEcLF5hmItRzWy6EYXd5xBP92giNRc1EN1FXCsJctBSsZBoqs0rNqBCzImR4GgnARcJLuNMaLPfxx3oEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848479; c=relaxed/simple;
	bh=nZI7XfU27kPJXdg1x3tUblQVb3NKDoTIh1yr+4o5zzw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HCAnx/xtUB3HClYLTEjVcJm7INSPapBsIBbpOjPD1fb3aJ72BG2F1gt0dCmL1fMeM+QkEhSlBr+S2cA7d6cP7FbyYvKrN4fCCd9d8gU0JhWmY7LcjiLUJCrZcyibefAzdyoOzrvtI+TkYPdaxnbcaz0KADcy5ZwzoK5N3EhFV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rpbpZatN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytWnKGwJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rpbpZatN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytWnKGwJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97FAF210F2;
	Tue, 10 Dec 2024 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733848474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkGpqLCIKMaHKx4zZZuWx31TXzSGMol/+IvVniTOhsU=;
	b=rpbpZatNFY6ip0fwhXjVAwgH0sADv3kjRFty46fgI96ZYKEmP1KgYx137uQAHvI+UVu6MU
	TQZzG4cbKE87E4No+fP6avlSiTh8mjNv9kAd1b4Y9tNMJQuXd4xoyKXvRo5WnCLZwbzfew
	wD9aQJEFN1+nUBhctg1VJMrwZv/P4OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733848474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkGpqLCIKMaHKx4zZZuWx31TXzSGMol/+IvVniTOhsU=;
	b=ytWnKGwJ1KeRdQbvDslIjx3EgLNZvxWEJVqzo7DQl/YpxHzdfyrtDXdSWiOokbEPAJkBJ4
	zaf5rzP1CrktI9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733848474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkGpqLCIKMaHKx4zZZuWx31TXzSGMol/+IvVniTOhsU=;
	b=rpbpZatNFY6ip0fwhXjVAwgH0sADv3kjRFty46fgI96ZYKEmP1KgYx137uQAHvI+UVu6MU
	TQZzG4cbKE87E4No+fP6avlSiTh8mjNv9kAd1b4Y9tNMJQuXd4xoyKXvRo5WnCLZwbzfew
	wD9aQJEFN1+nUBhctg1VJMrwZv/P4OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733848474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkGpqLCIKMaHKx4zZZuWx31TXzSGMol/+IvVniTOhsU=;
	b=ytWnKGwJ1KeRdQbvDslIjx3EgLNZvxWEJVqzo7DQl/YpxHzdfyrtDXdSWiOokbEPAJkBJ4
	zaf5rzP1CrktI9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B648313A15;
	Tue, 10 Dec 2024 16:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eE+3HJhtWGccPgAAD6G6ig
	(envelope-from <colyli@suse.de>); Tue, 10 Dec 2024 16:34:32 +0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: drivers/md/bcache/super.c:108:14: sparse: sparse: restricted
 __le64 degrades to integer
From: Coly Li <colyli@suse.de>
In-Reply-To: <202412071044.tthTVBw4-lkp@intel.com>
Date: Wed, 11 Dec 2024 00:34:20 +0800
Cc: Christoph Hellwig <hch@lst.de>,
 oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <33E9C2B1-BF96-46DD-BE45-00811C986ABD@suse.de>
References: <202412071044.tthTVBw4-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	APPLE_MAILER_COMMON(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

I don=E2=80=99t know whom to ask, just try to ask kernel test robot =
directly.

Although this patch was not composed from me, I still wonder who to =
understand the following warning information and where the problem is.
e.g. for the following warning,

> sparse warnings: (new ones prefixed by >>)
>   drivers/md/bcache/super.c:108:24: sparse: sparse: incorrect type in =
argument 2 (different base types) @@     expected unsigned int nr_keys =
@@     got restricted __le16 [usertype] keys @@
>   drivers/md/bcache/super.c:108:24: sparse:     expected unsigned int =
nr_keys
>   drivers/md/bcache/super.c:108:24: sparse:     got restricted __le16 =
[usertype] keys
>>> drivers/md/bcache/super.c:108:14: sparse: sparse: restricted __le64 =
degrades to integer

It complains about line 108 which is,
> cafe563591446cf Kent Overstreet   2013-03-23  107   err =3D "Bad =
checksum";
> cafe563591446cf Kent Overstreet   2013-03-23 @108   if (s->csum !=3D =
csum_set(s))
> cafe563591446cf Kent Overstreet   2013-03-23  109   goto err;

Here s->sum is __le64, csum_set() is uint64_t, these two types have same =
length. I don=E2=80=99t see the direct connection between code and =
warning.

Thanks in advance for the patience to give me a hint.

Coly Li



> 2024=E5=B9=B412=E6=9C=889=E6=97=A5 12:00=EF=BC=8Ckernel test robot =
<lkp@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
> head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
> commit: a702a692cd7559053ea573f4e2c84828f0e62824 bcache: use a =
separate data structure for the on-disk super block
> date:   4 years, 10 months ago
> config: x86_64-randconfig-r133-20240105 =
(https://download.01.org/0day-ci/archive/20241207/202412071044.tthTVBw4-lk=
p@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): =
(https://download.01.org/0day-ci/archive/20241207/202412071044.tthTVBw4-lk=
p@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202412071044.tthTVBw4-lkp@intel.com/=

>=20
> sparse warnings: (new ones prefixed by >>)
>   drivers/md/bcache/super.c:108:24: sparse: sparse: incorrect type in =
argument 2 (different base types) @@     expected unsigned int nr_keys =
@@     got restricted __le16 [usertype] keys @@
>   drivers/md/bcache/super.c:108:24: sparse:     expected unsigned int =
nr_keys
>   drivers/md/bcache/super.c:108:24: sparse:     got restricted __le16 =
[usertype] keys
>>> drivers/md/bcache/super.c:108:14: sparse: sparse: restricted __le64 =
degrades to integer
>   drivers/md/bcache/super.c:237:21: sparse: sparse: incorrect type in =
argument 2 (different base types) @@     expected unsigned int nr_keys =
@@     got restricted __le16 [usertype] keys @@
>   drivers/md/bcache/super.c:237:21: sparse:     expected unsigned int =
nr_keys
>   drivers/md/bcache/super.c:237:21: sparse:     got restricted __le16 =
[usertype] keys
>>> drivers/md/bcache/super.c:237:19: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected restricted __le64 =
[usertype] csum @@     got unsigned long long @@
>   drivers/md/bcache/super.c:237:19: sparse:     expected restricted =
__le64 [usertype] csum
>   drivers/md/bcache/super.c:237:19: sparse:     got unsigned long long
>   drivers/md/bcache/super.c: note: in included file (through =
drivers/md/bcache/bcache.h):
>   include/uapi/linux/bcache.h:345:38: sparse: sparse: array of =
flexible structures
>   drivers/md/bcache/super.c:574:33: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected unsigned short =
[usertype] prio @@     got restricted __le16 [usertype] @@
>   drivers/md/bcache/super.c:574:33: sparse:     expected unsigned =
short [usertype] prio
>   drivers/md/bcache/super.c:574:33: sparse:     got restricted __le16 =
[usertype]
>   drivers/md/bcache/super.c:642:27: sparse: sparse: cast to restricted =
__le16
>   drivers/md/bcache/super.c:744:32: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected unsigned int =
[usertype] invalidated @@     got restricted __le32 [usertype] @@
>   drivers/md/bcache/super.c:744:32: sparse:     expected unsigned int =
[usertype] invalidated
>   drivers/md/bcache/super.c:744:32: sparse:     got restricted __le32 =
[usertype]
>   drivers/md/bcache/super.c:1104:26: sparse: sparse: incorrect type in =
initializer (different base types) @@     expected unsigned int =
[usertype] rtime @@     got restricted __le32 [usertype] @@
>   drivers/md/bcache/super.c:1104:26: sparse:     expected unsigned int =
[usertype] rtime
>   drivers/md/bcache/super.c:1104:26: sparse:     got restricted __le32 =
[usertype]
>   drivers/md/bcache/super.c:1148:32: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected unsigned int =
[usertype] invalidated @@     got restricted __le32 [usertype] @@
>   drivers/md/bcache/super.c:1148:32: sparse:     expected unsigned int =
[usertype] invalidated
>   drivers/md/bcache/super.c:1148:32: sparse:     got restricted __le32 =
[usertype]
>   drivers/md/bcache/super.c:1502:36: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected unsigned int =
[usertype] last_reg @@     got restricted __le32 [usertype] @@
>   drivers/md/bcache/super.c:1502:36: sparse:     expected unsigned int =
[usertype] last_reg
>   drivers/md/bcache/super.c:1502:36: sparse:     got restricted __le32 =
[usertype]
>   drivers/md/bcache/super.c: note: in included file (through =
drivers/md/bcache/bcache.h):
>   drivers/md/bcache/bset.h:231:36: sparse: sparse: array of flexible =
structures
>=20
> vim +108 drivers/md/bcache/super.c
>=20
> cafe563591446cf Kent Overstreet   2013-03-23   61 =20
> cafe563591446cf Kent Overstreet   2013-03-23   62  static const char =
*read_super(struct cache_sb *sb, struct block_device *bdev,
> cafe563591446cf Kent Overstreet   2013-03-23   63        struct page =
**res)
> cafe563591446cf Kent Overstreet   2013-03-23   64  {
> cafe563591446cf Kent Overstreet   2013-03-23   65   const char *err;
> a702a692cd75590 Christoph Hellwig 2020-01-24   66   struct =
cache_sb_disk *s;
> cafe563591446cf Kent Overstreet   2013-03-23   67   struct buffer_head =
*bh =3D __bread(bdev, 1, SB_SIZE);
> 6f10f7d1b02b1bb Coly Li           2018-08-11   68   unsigned int i;
> cafe563591446cf Kent Overstreet   2013-03-23   69 =20
> cafe563591446cf Kent Overstreet   2013-03-23   70   if (!bh)
> cafe563591446cf Kent Overstreet   2013-03-23   71   return "IO error";
> cafe563591446cf Kent Overstreet   2013-03-23   72 =20
> a702a692cd75590 Christoph Hellwig 2020-01-24   73   s =3D (struct =
cache_sb_disk *)bh->b_data;
> cafe563591446cf Kent Overstreet   2013-03-23   74 =20
> cafe563591446cf Kent Overstreet   2013-03-23   75   sb->offset =3D =
le64_to_cpu(s->offset);
> cafe563591446cf Kent Overstreet   2013-03-23   76   sb->version =3D =
le64_to_cpu(s->version);
> cafe563591446cf Kent Overstreet   2013-03-23   77 =20
> cafe563591446cf Kent Overstreet   2013-03-23   78   memcpy(sb->magic, =
s->magic, 16);
> cafe563591446cf Kent Overstreet   2013-03-23   79   memcpy(sb->uuid, =
s->uuid, 16);
> cafe563591446cf Kent Overstreet   2013-03-23   80   =
memcpy(sb->set_uuid, s->set_uuid, 16);
> cafe563591446cf Kent Overstreet   2013-03-23   81   memcpy(sb->label, =
s->label, SB_LABEL_SIZE);
> cafe563591446cf Kent Overstreet   2013-03-23   82 =20
> cafe563591446cf Kent Overstreet   2013-03-23   83   sb->flags =3D =
le64_to_cpu(s->flags);
> cafe563591446cf Kent Overstreet   2013-03-23   84   sb->seq =3D =
le64_to_cpu(s->seq);
> cafe563591446cf Kent Overstreet   2013-03-23   85   sb->last_mount =3D =
le32_to_cpu(s->last_mount);
> cafe563591446cf Kent Overstreet   2013-03-23   86   sb->first_bucket =3D=
 le16_to_cpu(s->first_bucket);
> cafe563591446cf Kent Overstreet   2013-03-23   87   sb->keys =3D =
le16_to_cpu(s->keys);
> cafe563591446cf Kent Overstreet   2013-03-23   88 =20
> cafe563591446cf Kent Overstreet   2013-03-23   89   for (i =3D 0; i < =
SB_JOURNAL_BUCKETS; i++)
> cafe563591446cf Kent Overstreet   2013-03-23   90   sb->d[i] =3D =
le64_to_cpu(s->d[i]);
> cafe563591446cf Kent Overstreet   2013-03-23   91 =20
> cafe563591446cf Kent Overstreet   2013-03-23   92   pr_debug("read sb =
version %llu, flags %llu, seq %llu, journal size %u",
> cafe563591446cf Kent Overstreet   2013-03-23   93   sb->version, =
sb->flags, sb->seq, sb->keys);
> cafe563591446cf Kent Overstreet   2013-03-23   94 =20
> aaf8dbeab586572 Coly Li           2019-11-13   95   err =3D "Not a =
bcache superblock (bad offset)";
> cafe563591446cf Kent Overstreet   2013-03-23   96   if (sb->offset !=3D =
SB_SECTOR)
> cafe563591446cf Kent Overstreet   2013-03-23   97   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23   98 =20
> aaf8dbeab586572 Coly Li           2019-11-13   99   err =3D "Not a =
bcache superblock (bad magic)";
> cafe563591446cf Kent Overstreet   2013-03-23  100   if =
(memcmp(sb->magic, bcache_magic, 16))
> cafe563591446cf Kent Overstreet   2013-03-23  101   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  102 =20
> cafe563591446cf Kent Overstreet   2013-03-23  103   err =3D "Too many =
journal buckets";
> cafe563591446cf Kent Overstreet   2013-03-23  104   if (sb->keys > =
SB_JOURNAL_BUCKETS)
> cafe563591446cf Kent Overstreet   2013-03-23  105   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  106 =20
> cafe563591446cf Kent Overstreet   2013-03-23  107   err =3D "Bad =
checksum";
> cafe563591446cf Kent Overstreet   2013-03-23 @108   if (s->csum !=3D =
csum_set(s))
> cafe563591446cf Kent Overstreet   2013-03-23  109   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  110 =20
> cafe563591446cf Kent Overstreet   2013-03-23  111   err =3D "Bad =
UUID";
> 169ef1cf6171d35 Kent Overstreet   2013-03-28  112   if =
(bch_is_zero(sb->uuid, 16))
> cafe563591446cf Kent Overstreet   2013-03-23  113   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  114 =20
> 8abb2a5dbadab91 Kent Overstreet   2013-04-23  115   sb->block_size =3D =
le16_to_cpu(s->block_size);
> 8abb2a5dbadab91 Kent Overstreet   2013-04-23  116 =20
> 8abb2a5dbadab91 Kent Overstreet   2013-04-23  117   err =3D =
"Superblock block size smaller than device block size";
> 8abb2a5dbadab91 Kent Overstreet   2013-04-23  118   if (sb->block_size =
<< 9 < bdev_logical_block_size(bdev))
> 8abb2a5dbadab91 Kent Overstreet   2013-04-23  119   goto err;
> 8abb2a5dbadab91 Kent Overstreet   2013-04-23  120 =20
> 2903381fce71004 Kent Overstreet   2013-04-11  121   switch =
(sb->version) {
> 2903381fce71004 Kent Overstreet   2013-04-11  122   case =
BCACHE_SB_VERSION_BDEV:
> 2903381fce71004 Kent Overstreet   2013-04-11  123   sb->data_offset =3D =
BDEV_DATA_START_DEFAULT;
> 2903381fce71004 Kent Overstreet   2013-04-11  124   break;
> 2903381fce71004 Kent Overstreet   2013-04-11  125   case =
BCACHE_SB_VERSION_BDEV_WITH_OFFSET:
> 2903381fce71004 Kent Overstreet   2013-04-11  126   sb->data_offset =3D =
le64_to_cpu(s->data_offset);
> cafe563591446cf Kent Overstreet   2013-03-23  127 =20
> 2903381fce71004 Kent Overstreet   2013-04-11  128   err =3D "Bad data =
offset";
> 2903381fce71004 Kent Overstreet   2013-04-11  129   if =
(sb->data_offset < BDEV_DATA_START_DEFAULT)
> cafe563591446cf Kent Overstreet   2013-03-23  130   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  131 =20
> 2903381fce71004 Kent Overstreet   2013-04-11  132   break;
> 2903381fce71004 Kent Overstreet   2013-04-11  133   case =
BCACHE_SB_VERSION_CDEV:
> 2903381fce71004 Kent Overstreet   2013-04-11  134   case =
BCACHE_SB_VERSION_CDEV_WITH_UUID:
> 2903381fce71004 Kent Overstreet   2013-04-11  135   sb->nbuckets =3D =
le64_to_cpu(s->nbuckets);
> 2903381fce71004 Kent Overstreet   2013-04-11  136   sb->bucket_size =3D =
le16_to_cpu(s->bucket_size);
> 2903381fce71004 Kent Overstreet   2013-04-11  137 =20
> 2903381fce71004 Kent Overstreet   2013-04-11  138   sb->nr_in_set =3D =
le16_to_cpu(s->nr_in_set);
> 2903381fce71004 Kent Overstreet   2013-04-11  139   sb->nr_this_dev =3D =
le16_to_cpu(s->nr_this_dev);
> 2903381fce71004 Kent Overstreet   2013-04-11  140 =20
> cafe563591446cf Kent Overstreet   2013-03-23  141   err =3D "Too many =
buckets";
> cafe563591446cf Kent Overstreet   2013-03-23  142   if (sb->nbuckets > =
LONG_MAX)
> cafe563591446cf Kent Overstreet   2013-03-23  143   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  144 =20
> cafe563591446cf Kent Overstreet   2013-03-23  145   err =3D "Not =
enough buckets";
> cafe563591446cf Kent Overstreet   2013-03-23  146   if (sb->nbuckets < =
1 << 7)
> cafe563591446cf Kent Overstreet   2013-03-23  147   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  148 =20
> 2903381fce71004 Kent Overstreet   2013-04-11  149   err =3D "Bad =
block/bucket size";
> 2903381fce71004 Kent Overstreet   2013-04-11  150   if =
(!is_power_of_2(sb->block_size) ||
> 2903381fce71004 Kent Overstreet   2013-04-11  151      sb->block_size =
> PAGE_SECTORS ||
> 2903381fce71004 Kent Overstreet   2013-04-11  152      =
!is_power_of_2(sb->bucket_size) ||
> 2903381fce71004 Kent Overstreet   2013-04-11  153      sb->bucket_size =
< PAGE_SECTORS)
> 2903381fce71004 Kent Overstreet   2013-04-11  154   goto err;
> 2903381fce71004 Kent Overstreet   2013-04-11  155 =20
> cafe563591446cf Kent Overstreet   2013-03-23  156   err =3D "Invalid =
superblock: device too small";
> b0d30981c05f32d Coly Li           2018-08-11  157   if =
(get_capacity(bdev->bd_disk) <
> b0d30981c05f32d Coly Li           2018-08-11  158      sb->bucket_size =
* sb->nbuckets)
> cafe563591446cf Kent Overstreet   2013-03-23  159   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  160 =20
> cafe563591446cf Kent Overstreet   2013-03-23  161   err =3D "Bad =
UUID";
> 169ef1cf6171d35 Kent Overstreet   2013-03-28  162   if =
(bch_is_zero(sb->set_uuid, 16))
> cafe563591446cf Kent Overstreet   2013-03-23  163   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  164 =20
> cafe563591446cf Kent Overstreet   2013-03-23  165   err =3D "Bad cache =
device number in set";
> cafe563591446cf Kent Overstreet   2013-03-23  166   if (!sb->nr_in_set =
||
> cafe563591446cf Kent Overstreet   2013-03-23  167      sb->nr_in_set =
<=3D sb->nr_this_dev ||
> cafe563591446cf Kent Overstreet   2013-03-23  168      sb->nr_in_set > =
MAX_CACHES_PER_SET)
> cafe563591446cf Kent Overstreet   2013-03-23  169   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  170 =20
> cafe563591446cf Kent Overstreet   2013-03-23  171   err =3D "Journal =
buckets not sequential";
> cafe563591446cf Kent Overstreet   2013-03-23  172   for (i =3D 0; i < =
sb->keys; i++)
> cafe563591446cf Kent Overstreet   2013-03-23  173   if (sb->d[i] !=3D =
sb->first_bucket + i)
> cafe563591446cf Kent Overstreet   2013-03-23  174   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  175 =20
> cafe563591446cf Kent Overstreet   2013-03-23  176   err =3D "Too many =
journal buckets";
> cafe563591446cf Kent Overstreet   2013-03-23  177   if =
(sb->first_bucket + sb->keys > sb->nbuckets)
> cafe563591446cf Kent Overstreet   2013-03-23  178   goto err;
> cafe563591446cf Kent Overstreet   2013-03-23  179 =20
> cafe563591446cf Kent Overstreet   2013-03-23  180   err =3D "Invalid =
superblock: first bucket comes before end of super";
> cafe563591446cf Kent Overstreet   2013-03-23  181   if =
(sb->first_bucket * sb->bucket_size < 16)
> cafe563591446cf Kent Overstreet   2013-03-23  182   goto err;
> 2903381fce71004 Kent Overstreet   2013-04-11  183 =20
> 2903381fce71004 Kent Overstreet   2013-04-11  184   break;
> 2903381fce71004 Kent Overstreet   2013-04-11  185   default:
> 2903381fce71004 Kent Overstreet   2013-04-11  186   err =3D =
"Unsupported superblock version";
> 2903381fce71004 Kent Overstreet   2013-04-11  187   goto err;
> 2903381fce71004 Kent Overstreet   2013-04-11  188   }
> 2903381fce71004 Kent Overstreet   2013-04-11  189 =20
> 75cbb3f1d840429 Arnd Bergmann     2018-07-26  190   sb->last_mount =3D =
(u32)ktime_get_real_seconds();
> cafe563591446cf Kent Overstreet   2013-03-23  191   err =3D NULL;
> cafe563591446cf Kent Overstreet   2013-03-23  192 =20
> cafe563591446cf Kent Overstreet   2013-03-23  193   =
get_page(bh->b_page);
> cafe563591446cf Kent Overstreet   2013-03-23  194   *res =3D =
bh->b_page;
> cafe563591446cf Kent Overstreet   2013-03-23  195  err:
> cafe563591446cf Kent Overstreet   2013-03-23  196   put_bh(bh);
> cafe563591446cf Kent Overstreet   2013-03-23  197   return err;
> cafe563591446cf Kent Overstreet   2013-03-23  198  }
> cafe563591446cf Kent Overstreet   2013-03-23  199 =20
> 4246a0b63bd8f56 Christoph Hellwig 2015-07-20  200  static void =
write_bdev_super_endio(struct bio *bio)
> cafe563591446cf Kent Overstreet   2013-03-23  201  {
> cafe563591446cf Kent Overstreet   2013-03-23  202   struct cached_dev =
*dc =3D bio->bi_private;
> 08ec1e6282f2716 Coly Li           2019-06-28  203 =20
> 08ec1e6282f2716 Coly Li           2019-06-28  204   if =
(bio->bi_status)
> 08ec1e6282f2716 Coly Li           2019-06-28  205   =
bch_count_backing_io_errors(dc, bio);
> cafe563591446cf Kent Overstreet   2013-03-23  206 =20
> cb7a583e6a6ace6 Kent Overstreet   2013-12-16  207   =
closure_put(&dc->sb_write);
> cafe563591446cf Kent Overstreet   2013-03-23  208  }
> cafe563591446cf Kent Overstreet   2013-03-23  209 =20
> cafe563591446cf Kent Overstreet   2013-03-23  210  static void =
__write_super(struct cache_sb *sb, struct bio *bio)
> cafe563591446cf Kent Overstreet   2013-03-23  211  {
> a702a692cd75590 Christoph Hellwig 2020-01-24  212   struct =
cache_sb_disk *out =3D page_address(bio_first_page_all(bio));
> 6f10f7d1b02b1bb Coly Li           2018-08-11  213   unsigned int i;
> cafe563591446cf Kent Overstreet   2013-03-23  214 =20
> 4f024f3797c43cb Kent Overstreet   2013-10-11  215   =
bio->bi_iter.bi_sector =3D SB_SECTOR;
> 4f024f3797c43cb Kent Overstreet   2013-10-11  216   =
bio->bi_iter.bi_size =3D SB_SIZE;
> ad0d9e76a412470 Mike Christie     2016-06-05  217   =
bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC|REQ_META);
> 169ef1cf6171d35 Kent Overstreet   2013-03-28  218   bch_bio_map(bio, =
NULL);
> cafe563591446cf Kent Overstreet   2013-03-23  219 =20
> cafe563591446cf Kent Overstreet   2013-03-23  220   out->offset =3D =
cpu_to_le64(sb->offset);
> cafe563591446cf Kent Overstreet   2013-03-23  221   out->version =3D =
cpu_to_le64(sb->version);
> cafe563591446cf Kent Overstreet   2013-03-23  222 =20
> cafe563591446cf Kent Overstreet   2013-03-23  223   memcpy(out->uuid, =
sb->uuid, 16);
> cafe563591446cf Kent Overstreet   2013-03-23  224   =
memcpy(out->set_uuid, sb->set_uuid, 16);
> cafe563591446cf Kent Overstreet   2013-03-23  225   memcpy(out->label, =
sb->label, SB_LABEL_SIZE);
> cafe563591446cf Kent Overstreet   2013-03-23  226 =20
> cafe563591446cf Kent Overstreet   2013-03-23  227   out->flags =3D =
cpu_to_le64(sb->flags);
> cafe563591446cf Kent Overstreet   2013-03-23  228   out->seq =3D =
cpu_to_le64(sb->seq);
> cafe563591446cf Kent Overstreet   2013-03-23  229 =20
> cafe563591446cf Kent Overstreet   2013-03-23  230   out->last_mount =3D =
cpu_to_le32(sb->last_mount);
> cafe563591446cf Kent Overstreet   2013-03-23  231   out->first_bucket =
=3D cpu_to_le16(sb->first_bucket);
> cafe563591446cf Kent Overstreet   2013-03-23  232   out->keys =3D =
cpu_to_le16(sb->keys);
> cafe563591446cf Kent Overstreet   2013-03-23  233 =20
> cafe563591446cf Kent Overstreet   2013-03-23  234   for (i =3D 0; i < =
sb->keys; i++)
> cafe563591446cf Kent Overstreet   2013-03-23  235   out->d[i] =3D =
cpu_to_le64(sb->d[i]);
> cafe563591446cf Kent Overstreet   2013-03-23  236 =20
> cafe563591446cf Kent Overstreet   2013-03-23 @237   out->csum =3D =
csum_set(out);
> cafe563591446cf Kent Overstreet   2013-03-23  238 =20
> cafe563591446cf Kent Overstreet   2013-03-23  239   pr_debug("ver =
%llu, flags %llu, seq %llu",
> cafe563591446cf Kent Overstreet   2013-03-23  240   sb->version, =
sb->flags, sb->seq);
> cafe563591446cf Kent Overstreet   2013-03-23  241 =20
> 4e49ea4a3d27636 Mike Christie     2016-06-05  242   submit_bio(bio);
> cafe563591446cf Kent Overstreet   2013-03-23  243  }
> cafe563591446cf Kent Overstreet   2013-03-23  244 =20
>=20
> :::::: The code at line 108 was first introduced by commit
> :::::: cafe563591446cf80bfbc2fe3bc72a2e36cf1060 bcache: A block layer =
cache
>=20
> :::::: TO: Kent Overstreet <koverstreet@google.com>
> :::::: CC: Kent Overstreet <koverstreet@google.com>
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


