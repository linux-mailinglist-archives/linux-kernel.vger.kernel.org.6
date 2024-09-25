Return-Path: <linux-kernel+bounces-338029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1865985284
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A4D1C2312E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4371514CB;
	Wed, 25 Sep 2024 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UMUlUCHP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0hkDPIK/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UMUlUCHP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0hkDPIK/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FED155C9E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242546; cv=none; b=tS8/zwqF1umJDCmQ1PI+3IvGAZKVuMz09C2PMzXPmBm0fprwXQJaGYyZVBN5uMPK4U0WGqI4bBlRY8SC3lsN41IzX3EXuC5lkPeXWxlrYicFV9aBOh0x+BuVjEMNuuHpENHIpcVIyHCJ9H8XETt2ApycrfpNY+Pg0eqaKAn2y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242546; c=relaxed/simple;
	bh=N9NdYYGasVrRzl0/Q+SKJBKiOt72dSEA9FdgVhZEigc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ap/rcTTVAhNoP1JBP77sQyWnbZfY4E+rVLcuhr/rOzalK7LrODzMCJi3GP6HnxAeAH0JYIF2esMRZ5JfqdqDlJPTxPPo0UwCha2D5GhO14XYDePKWB0KfSv6OF4bGsfGvG7VmcKH2hJZ2FXyAU8GZfpo8N20iiVH262oNA9eYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UMUlUCHP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0hkDPIK/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UMUlUCHP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0hkDPIK/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C67821A6B;
	Wed, 25 Sep 2024 05:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sc/10c9hn4P5aTMAX0ta1fAQw5abGkfLPhBeXvTIkBg=;
	b=UMUlUCHP+g4ne+H7fJAZqqeCKyxMVV2+APyGcfJ+ISt7MscBAHbCyxy/LiLUt2USZabMpx
	e6UHcPzNxHFSi5D80zomhVMAf2Go8xqCZgpvxhhYDhxww6KaxQsL46yU18HCFmfILDBZph
	yysl1A3goE38+PCgRtH6gLKGZP235N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sc/10c9hn4P5aTMAX0ta1fAQw5abGkfLPhBeXvTIkBg=;
	b=0hkDPIK/vD2bpyF+cA4AUVo7LP+FsH/VPbdcs/5ZUHGGul2sb5ExSrrqVf7/lw+Pwu8OKP
	weEpu5G7+xhuY9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UMUlUCHP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="0hkDPIK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sc/10c9hn4P5aTMAX0ta1fAQw5abGkfLPhBeXvTIkBg=;
	b=UMUlUCHP+g4ne+H7fJAZqqeCKyxMVV2+APyGcfJ+ISt7MscBAHbCyxy/LiLUt2USZabMpx
	e6UHcPzNxHFSi5D80zomhVMAf2Go8xqCZgpvxhhYDhxww6KaxQsL46yU18HCFmfILDBZph
	yysl1A3goE38+PCgRtH6gLKGZP235N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sc/10c9hn4P5aTMAX0ta1fAQw5abGkfLPhBeXvTIkBg=;
	b=0hkDPIK/vD2bpyF+cA4AUVo7LP+FsH/VPbdcs/5ZUHGGul2sb5ExSrrqVf7/lw+Pwu8OKP
	weEpu5G7+xhuY9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1887013A66;
	Wed, 25 Sep 2024 05:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rKEPMC2h82aCUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:35:41 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7 v3] Make wake_up_{bit,var} less fragile
Date: Wed, 25 Sep 2024 15:31:37 +1000
Message-ID: <20240925053405.3960701-1-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C67821A6B
X-Spam-Score: -5.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

 this is a revised set of patches for cleaning up wake_up_bit and
 wake_up_var and related.  They are the result of more proof reading,
 and of trying to make use of the new interfaces anywhere in the kernel
 where these interfaces are used.

 This should apply after -rc1, or at least after the block tree is merged.

 Note that on current master these cause a build error in bcachefs as it
 hasn't been updated with the new i_state bit management.

 Apart from proof-reading fixes this series enhances the previous series:

 - adds wait_var_event_any_lock() which can be used with any lock for
   which there are foo_lock and foo_unlock functions.  This is useful to
   deal with places that want to call filemap_invalidate_unlock/lock
   while waiting for a var

 - removes might_sleep() for wait_var_event_spinlock() as the code won't
   sleep until after it take the lock

 - adds wait_var_event_io() for io_schedule waits - xfs can use this.

 - as a bonus, softirq gets some improvements to waiting.  Feel free to
   drop or delay that one if not completely comfortable.

Thanks,
NeilBrown


