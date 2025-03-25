Return-Path: <linux-kernel+bounces-575766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F39A70702
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC68416DC77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398425D8E1;
	Tue, 25 Mar 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="URC/8W1W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="URC/8W1W"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB51547C0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920317; cv=none; b=iXeyXCScL9cjLhTjj3U7L+OeGKTTQXc2IDe1YZQ1DNMtIuKY5Sg0+wGNG0o733yDgwynVzivLHGHSnwjIvyJmtko29xmHtNKd2NSZUCLqqF0TgASt2KkTIV4logMYEOA5675lNrmLKsrsdeuddEoAQDuffH+iSi8nuVgVx+Sd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920317; c=relaxed/simple;
	bh=eWXxqsgrKXzBPrF8cRI2av7A685G//8p1hBb4smPizU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shSsCB3N6/r37izEpJpRBgCtO3oLxVzE6pbAarMWyd8ssPWSwwKbGpzk/986NEErOYdQduIy8NPtsG5QEBstLtbS0wjOrQpN1BiA6yyUYOdQ6oyWskRalTKVr+V7DI0fk7wVB5sVpWiJkEs+19ytf/AtyxfGUprQqfJpn7L/FAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=URC/8W1W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=URC/8W1W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCCA21172;
	Tue, 25 Mar 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AuQwi+dDekrTDrq2NHVrIsKGsWOSbGf0aot71i79cVU=;
	b=URC/8W1WkTHl5TKhRtah2NP68RUjELY64QIJRNsU8cFltTJT97MmY+huDHTZWUpItZgDPl
	SflVbYIRhTXQlLpGAOWDJz0OVCTYOspZfubRo+i8btewVumMpwUwZatiRq7lBGLGYyQCLA
	ExA8yDADY5Ys7WKUjgGN4WDb1jd0dEs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="URC/8W1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AuQwi+dDekrTDrq2NHVrIsKGsWOSbGf0aot71i79cVU=;
	b=URC/8W1WkTHl5TKhRtah2NP68RUjELY64QIJRNsU8cFltTJT97MmY+huDHTZWUpItZgDPl
	SflVbYIRhTXQlLpGAOWDJz0OVCTYOspZfubRo+i8btewVumMpwUwZatiRq7lBGLGYyQCLA
	ExA8yDADY5Ys7WKUjgGN4WDb1jd0dEs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CFA7137AC;
	Tue, 25 Mar 2025 16:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jU3Enna4meDSQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 25 Mar 2025 16:31:53 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] btrfs: extent buffer flags cleanup
Date: Tue, 25 Mar 2025 17:31:35 +0100
Message-ID: <20250325163139.878473-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FCCA21172
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There are a few leftover extent buffer flags not being meaningfully used
anymore for some time. Simply clean them up.

Daniel Vacek (3):
  btrfs: cleanup EXTENT_BUFFER_READ_ERR flag
  btrfs: cleanup EXTENT_BUFFER_READAHEAD flag
  btrfs: cleanup EXTENT_BUFFER_CORRUPT flag

 fs/btrfs/disk-io.c     | 11 ++---------
 fs/btrfs/extent-tree.c |  6 ------
 fs/btrfs/extent_io.c   |  7 ++-----
 fs/btrfs/extent_io.h   |  5 -----
 4 files changed, 4 insertions(+), 25 deletions(-)

-- 
2.47.2


