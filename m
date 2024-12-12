Return-Path: <linux-kernel+bounces-443598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FBF9EF923
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36EB28EFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4D223E81;
	Thu, 12 Dec 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfUQP5FX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VwUt/ypO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uUFAaM5H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ICx7c4xB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91302222D59
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025573; cv=none; b=uLUPx5P/kLV+UeeMERUi65DfR3FX9+i43jZ8iLCMz+ayO/cfp91KlAREV+NjS/9LQUiDnZMXsPMn8iBMPyy1ByLWErZ7oRqHDTwlZDkr3geDHrS5KizMSecL/mt7cG6YB7HClDaJ0ViWXf7u37oyJDwuSgtFWPcGNQWQqkhfhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025573; c=relaxed/simple;
	bh=0k44xRDak3T7dq0MM3PWlfEOiJV+ACccfpwwp66sOVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LAyNbLbcBZPCzeDtE1Bw96Caz92XbPj4qrYqVCXXlQCr4N8+r2/nq2xi/Zys5f0ZTL6EJzydqKUd1Evdugj1SUHOESt7ZVfeGt1jWfmQWy4KPurKd7t5Wo1i/4o0NlCJ5KEa91Tf9pqzDBRVGkK9G9oSn1JYlon+yfAgJaSKF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfUQP5FX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VwUt/ypO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uUFAaM5H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ICx7c4xB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BFF22116E;
	Thu, 12 Dec 2024 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734025569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dDxZZoaRr2SMMGOXQzLLcMrHH32cNN145k3HwrhiwY=;
	b=OfUQP5FXRAi4hXbktbHT/LVbBkAb+6wT8K+Fvo8GkWhLfw1Xv4mNE8wgzQ9w3Ir408QGuj
	1fUYzK+ZWVTE0mOs0L1P+sXStQ25L8cpM5grvRRDZ5hC8+Aj2V+NmVQROPUjcQu7sS+M5Q
	pqD9uVAi9Nr3s5DUzBNOowqcfx80xAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734025569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dDxZZoaRr2SMMGOXQzLLcMrHH32cNN145k3HwrhiwY=;
	b=VwUt/ypO/G/Jxv3VLR11n+4JrynAdbX527IUCUAwHGwpeWVCPdVGmnujJ90EXsgdHZylyc
	Q4ZDjEUgM2NP4zDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uUFAaM5H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ICx7c4xB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734025568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dDxZZoaRr2SMMGOXQzLLcMrHH32cNN145k3HwrhiwY=;
	b=uUFAaM5HC2PqpTK3WbHgRKkTQK6mAvUBgSxlyOFZTXF0raF4ZUMpoXPorp41SDP7BV//AV
	dKsiiStceCVg0evaN1T7Fa+u5obMDksZBPzbQmpc/6Vym0msNlbE415CbsBWfGCvly2SJh
	5CoCD32wDytD9gg188MEBLUKNKjIvJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734025568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dDxZZoaRr2SMMGOXQzLLcMrHH32cNN145k3HwrhiwY=;
	b=ICx7c4xBM0gsl0kPxNViUxMMfXrsv24qDflbcYtLd8n0XI0a63t6BQ8dcJ23FdleQXdL2E
	39SVQNKDvtGHPmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99CFC13508;
	Thu, 12 Dec 2024 17:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSJfFV4hW2cFLAAAD6G6ig
	(envelope-from <colyli@suse.de>); Thu, 12 Dec 2024 17:46:06 +0000
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
In-Reply-To: <20241212062353.GB5586@lst.de>
Date: Fri, 13 Dec 2024 01:45:53 +0800
Cc: kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <351022FF-9B41-4C4F-A507-560EAB5A42B7@suse.de>
References: <202412071044.tthTVBw4-lkp@intel.com>
 <33E9C2B1-BF96-46DD-BE45-00811C986ABD@suse.de> <20241212062353.GB5586@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3826.200.121)
X-Rspamd-Queue-Id: 6BFF22116E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO



> 2024=E5=B9=B412=E6=9C=8812=E6=97=A5 14:23=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Dec 11, 2024 at 12:34:20AM +0800, Coly Li wrote:
>>>  drivers/md/bcache/super.c:108:24: sparse:     expected unsigned int =
nr_keys
>>>  drivers/md/bcache/super.c:108:24: sparse:     got restricted __le16 =
[usertype] keys
>>>>> drivers/md/bcache/super.c:108:14: sparse: sparse: restricted =
__le64 degrades to integer
>>=20
>> It complains about line 108 which is,
>>> cafe563591446cf Kent Overstreet   2013-03-23  107   err =3D "Bad =
checksum";
>>> cafe563591446cf Kent Overstreet   2013-03-23 @108   if (s->csum !=3D =
csum_set(s))
>>> cafe563591446cf Kent Overstreet   2013-03-23  109   goto err;
>>=20
>> Here s->sum is __le64, csum_set() is uint64_t, these two types have =
same length. I don=E2=80=99t see the direct connection between code and =
warning.
>=20
> The are the same size, but not the same endianess.  In other words =
this
> is a hint that this code is most likely broken on big endian systems
> due to the lack of a bytespace (which is a no-op on little endian
> systems).

Oh I see. Thank you for the information.

Bcache doesn=E2=80=99t support moving cache device between machines with =
different endians. The on-disk data always has identical endian type as =
the in-memory data. The reason for __le64 was because it had to be a =
type defined.
Although there are some cpu_to_xxx used in code, indeed the btree keys =
are used directly after reading in from disk, or written directly =
without any cpu_to_xxx convert.

So this warning can be ignored.


Coly Li=

