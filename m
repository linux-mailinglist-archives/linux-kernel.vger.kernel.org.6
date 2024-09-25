Return-Path: <linux-kernel+bounces-338020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B752985279
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A0FB2310D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EB1547FF;
	Wed, 25 Sep 2024 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C9xN2hI/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rFnLwwk2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1zzP43Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L3gb575C"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2C1547C8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242459; cv=none; b=YsTuEpXYeUTCz/nCbBhCclhURyXG1Q/dmPJQjqM2r3L+OdSrwiFLL0XKhZWCyz8JwmSgorgQ6bGIKp5IHTcaB7qpXZ9K/JFSaib9J5zG3SS8IbEynFGZ/VtIyATbxu5FD5iR5C28xAaf5fMPOangMylTIPaCqh7vaE4Wnwhie/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242459; c=relaxed/simple;
	bh=kQ6jIrvpcQSM1AdlTQgqv/QgfsWKwpRXVJkJ1sRcnUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icBNCVOZYDdwC1gbZQI1fvFmtpDxPn9fMUxztry3erU8yI09pGO5pLnj8bhCc100IwWPJM68e53Fo36mPdZC1UlAI19Ju4ITJJEzZuJ1yv/U6ysxXbagED84+zrOvugO6PKlAPtPGCJnPLvLD8JkNQmpumZbeAnC+1paBmeXxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C9xN2hI/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rFnLwwk2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1zzP43Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L3gb575C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEF0821A4A;
	Wed, 25 Sep 2024 05:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W6jaTWCPs3jWvYnx4eAnlNzKUSbzRVBjJmT3LSvnkdw=;
	b=C9xN2hI/OXoNZl7usd6oaRtbit+Zep9ol3bJZ9hRt+jrEo87t+UdKwW0g/2EbS0aOpw6/b
	VwDZc6mWk6AczphdAWEwMc+4J+LKRX+phryFn6imfDRGhp1+5FRHPXGquHJ4pwBDAhJZOT
	mbbUTtwYVaFB9JR4pWcSAkb1uwPSNxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W6jaTWCPs3jWvYnx4eAnlNzKUSbzRVBjJmT3LSvnkdw=;
	b=rFnLwwk2dboKpKSGH8AsG4RrTO2Ho7BfPqJb4pz1K/cq9THwLSeX3qOMo0ANxyRlON654A
	pJMCbt13ZjzP0xAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o1zzP43Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L3gb575C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W6jaTWCPs3jWvYnx4eAnlNzKUSbzRVBjJmT3LSvnkdw=;
	b=o1zzP43Qjxk1ga7WzbGr6aLXnApiWUryngeWqDeaJN1ddaeLkvReg7Dpdoip7r5jONFww8
	yBfDGmkFA+6+q9ZP/G1YbL7az/TwUir1Qn0rysWAsxk0wQ518ios13LB+PDJr0negO7dAy
	iBPmGNSmECpsySAT+QlGRKRxXtZc0fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W6jaTWCPs3jWvYnx4eAnlNzKUSbzRVBjJmT3LSvnkdw=;
	b=L3gb575CvpMWd1G9tVMfKonC8B2XZqJNGyE7nfLbgrelHkw23twC4efDqjTGvAhhd7K2NK
	PVvR6pYJdgQ0MLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E22213A66;
	Wed, 25 Sep 2024 05:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FbfSBNWg82YVUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:34:13 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8 v3] Make wake_up_{bit,var} less fragile
Date: Wed, 25 Sep 2024 15:24:03 +1000
Message-ID: <20240925053118.3956520-1-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEF0821A4A
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

Hi,

 this is a revised set of patches for cleaning up wake_up_bit and
 wake_up_var and related.  They are result of more proof reading, and of
 trying to make use of the new interfaces anywhere in the kernel where
 these interfaces are used.

 This should apply after -rc1, or at least after the block tree is merged.

 Note that on current master the cause a build error in bcachefs as it
 hasn't been updated with the new i_state bit management.

 Apart from proof-reading fixes this series adds to the previous series:

 - adds wait_var_event_any_lock() which can be used with any lock for
   which there are foo_lock and foo_unlock functions.  This is useful to
   deal with places that want to call filemap_invalidate_unlock/lock
   while waiting for a var

 - adds wait_var_event_io() for io_schedule waits - xfs can use this.

 - as a bonus, softirq gets some improvements to waiting.

Thanks,
NeilBrown


 [PATCH 1/8] block: change wait on bd_claiming to use a var_waitqueue,
 [PATCH 2/8] sched: change wake_up_bit() and related function to
 [PATCH 3/8] sched: Improve documentation for wake_up_bit/wait_on_bit
 [PATCH 4/8] sched: Document wait_var_event() family of functions and
 [PATCH 5/8] sched: Add test_and_clear_wake_up_bit() and
 [PATCH 6/8] sched: Add wait/wake interface for variable updated under
 [PATCH 7/8] sched: add wait_var_event_io()
 [PATCH 8/8] softirq: use bit waits instead of var waits.

