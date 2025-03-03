Return-Path: <linux-kernel+bounces-542167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC84A4C672
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31731162336
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE422FDF3;
	Mon,  3 Mar 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kwCThq2g";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kwCThq2g"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68722E01E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018138; cv=none; b=d0RfA5+xPta5415mHf397ynyeYdd6I74Pt8P1QO6MetC6FLHD0twsuolIco+AOFxjtuL1wTgntx5cQFkiIuIikvrMPiPVTlYh//psMdmaK5sIR5VnDQXW2MS400h+BwVSexfPEGkby5sJ+Pm+Z5ee7UOafvjjvD5+TWLYuFiIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018138; c=relaxed/simple;
	bh=rGEdzRDu8/Ay8CXkrLVZRuHpUfVbnrvk3k+RgsSv50A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ls+4Q3uEs/Ht9P81/H8xDsqrvIwYMZuRfmxQiUqlgIh8S07rlLu5ayzcuGCIiO91sDIG8H1bO0SZMi2jboeoCCHL56yUHfMVF3w06qAiqfVM3YigM7zO/H0gHwhAciGyamerYlE2C6sX66yhSsPcn7VNJ4eIiqGPJpW38VcJqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kwCThq2g; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kwCThq2g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A52B71F444;
	Mon,  3 Mar 2025 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741018134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L+k4VAY33zlc7nZBeb3NhV3ZRptjc5DJlJ3GC+ZM/bM=;
	b=kwCThq2gOGlNGMKorPWtd3rWczzFn0R4NZNptx2+Hpmkjum5W96tPh3oYYa9fOPBS+N06o
	Ydhr3dj9HdUSI0TwbMytfXY1dbUSESyyLqiB+IB45BIVd6h61kG5BMOtu/2/KL88sJzoh9
	WOgbVx4qDfJBphqefQj5l2SGrP/eVbY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kwCThq2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741018134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L+k4VAY33zlc7nZBeb3NhV3ZRptjc5DJlJ3GC+ZM/bM=;
	b=kwCThq2gOGlNGMKorPWtd3rWczzFn0R4NZNptx2+Hpmkjum5W96tPh3oYYa9fOPBS+N06o
	Ydhr3dj9HdUSI0TwbMytfXY1dbUSESyyLqiB+IB45BIVd6h61kG5BMOtu/2/KL88sJzoh9
	WOgbVx4qDfJBphqefQj5l2SGrP/eVbY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5DB13939;
	Mon,  3 Mar 2025 16:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /H5mJhbUxWdhHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 16:08:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fixes for 6.14-rc5
Date: Mon,  3 Mar 2025 17:08:53 +0100
Message-ID: <cover.1741016639.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A52B71F444
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull two fixes from Simon Tatham. They're real bugfixes for
problems with OFS floppy disks created on linux and then read in the
emulated Workbench environment. Thanks.

----------------------------------------------------------------
The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-6.14-rc5-tag

for you to fetch changes up to 011ea742a25a77bac3d995f457886a67d178c6f0:

  affs: don't write overlarge OFS data block size fields (2025-02-26 15:20:57 +0100)

----------------------------------------------------------------
Simon Tatham (2):
      affs: generate OFS sequence numbers starting at 1
      affs: don't write overlarge OFS data block size fields

 fs/affs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

