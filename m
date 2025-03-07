Return-Path: <linux-kernel+bounces-551976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5714A573A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA523AE272
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E7258CE1;
	Fri,  7 Mar 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="phzDXKtZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGvP4IAh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="phzDXKtZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGvP4IAh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17A2580D5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382999; cv=none; b=qDiwXLHgspsELqHfwDjCnv16Qt2A4/ZawsHYIU6M78oDV+rGUtnDApYd0mSnicvqVaFz7qRdN/6Jab4LNFh5KE7/3CwwHs+jS7jizTYP/9R4QM/WVS477j4nY2KRpNLmMv/YxIiwDy0vbNecSVsPK9v9zwWikbwnJz4ASBeKAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382999; c=relaxed/simple;
	bh=RARnbd4Vt4PdhFrRYNqDsQzu3ik1SaQZf+GdQESEsK0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hqJG/zUgh9MRO6PFSBGN+s8WI3HZyPYH5tY13g+FeubnABAY3yFnbiCtr8q9Q6KW0S1QNaZCQ6FV7bHEEk9CWZhIExcODYvo1sp3xfxDdh1ljyjiJktoBDMC8YwWJiIO06LEZ8+lLg3dx9gRz+1ksDLyGLyJR0WuNlgrNpauGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=phzDXKtZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGvP4IAh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=phzDXKtZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGvP4IAh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 948721F38C;
	Fri,  7 Mar 2025 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741382995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MIiRGuOPGAMUb6TkFm59Ncg0Ak41mYyNnQ5D48qr47s=;
	b=phzDXKtZ/6IolOMPgYC7hfgqDh8Ax3GbBaKllgVCYo7BDzzaq2o9DsJDKawWngfu3XocUI
	GdlcTcqlQzeel+t0/Vd13HwlUhh4qBvbjfg4vQRbvpo2N3E7B3oWdIzBKq5HJT089gbrpW
	Z1Z1cdQx9caZiVuykvjkMHlt8xzyUNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741382995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MIiRGuOPGAMUb6TkFm59Ncg0Ak41mYyNnQ5D48qr47s=;
	b=RGvP4IAhoOCl6zMNBWa7YOfXvqekM/P6JybKiNNzxjmSLVKm44CJjxiq0rc6oaA+GgA4Pp
	K8/+NpYSLGVZ8HDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=phzDXKtZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RGvP4IAh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741382995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MIiRGuOPGAMUb6TkFm59Ncg0Ak41mYyNnQ5D48qr47s=;
	b=phzDXKtZ/6IolOMPgYC7hfgqDh8Ax3GbBaKllgVCYo7BDzzaq2o9DsJDKawWngfu3XocUI
	GdlcTcqlQzeel+t0/Vd13HwlUhh4qBvbjfg4vQRbvpo2N3E7B3oWdIzBKq5HJT089gbrpW
	Z1Z1cdQx9caZiVuykvjkMHlt8xzyUNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741382995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MIiRGuOPGAMUb6TkFm59Ncg0Ak41mYyNnQ5D48qr47s=;
	b=RGvP4IAhoOCl6zMNBWa7YOfXvqekM/P6JybKiNNzxjmSLVKm44CJjxiq0rc6oaA+GgA4Pp
	K8/+NpYSLGVZ8HDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7958D13939;
	Fri,  7 Mar 2025 21:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D4L9HFNly2eiJwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Mar 2025 21:29:55 +0000
Message-ID: <d0a04abe-6f6c-4d9f-895c-b3aef4617505@suse.cz>
Date: Fri, 7 Mar 2025 22:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab fixes for 6.14-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 948721F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.com,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Linus,

please pull the latest slab fixes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14-rc5

Thanks,
Vlastimil

I've bumped my gpg key expiry this week. Not yet refreshed in pgpkeys.git
but at least here:

https://keys.openpgp.org/vks/v1/by-fingerprint/A940D434992C2E8E99103D50224FA7E7CC82A664

======================================

- Stable fix for kmem_cache_destroy() called from a WQ_MEM_RECLAIM workqueue
  causing a warning due to the new kvfree_rcu_barrier() (Uladzislau Rezki). 

----------------------------------------------------------------
Uladzislau Rezki (Sony) (1):
      mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq

 mm/slab_common.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


