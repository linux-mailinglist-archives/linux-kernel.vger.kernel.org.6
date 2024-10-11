Return-Path: <linux-kernel+bounces-361123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B899A3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41FA1C221EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E0218592;
	Fri, 11 Oct 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lWFcp1Wp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lWFcp1Wp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17868215026
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649677; cv=none; b=ftUqI+QLGnYasuNZHaF3dVWupPUteTyd0ZTQPtxPFNaCPao6HWJ4FO39lLMFq979V3voxZ7BcCa6Sn2eSSHU5F+b9h82kbP/FB9CwM9ppDr5nNfjTCWutelW4Kce9+v9NKCPVQYx2R4lLX+w9bd/hHzXBkbBxRs3dX8eKDv6nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649677; c=relaxed/simple;
	bh=HT3YcLxWIxdrHCxufQIP6UWA9eHrgCfL6vnyCrX/REE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5lmcU8oPKPZI1og4arT+XHi116qZSbOrSZcPn5iLyhAkCyLErYv8F3L3LZay+/u8S51M4HgxZ8872IlZ8iJb64+4BYcJLm9tYeUzm/NnaEICOPujGKtBw+IKYWL6TLVzn19qA0+eo9U03c0XKzTY13NRmZbxhFR7lZXu6MX9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lWFcp1Wp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lWFcp1Wp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E7B121FC9;
	Fri, 11 Oct 2024 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728649673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mSeU2If84l66PDOJ59XMLcV7XLr9GTHLce28wgBx0f0=;
	b=lWFcp1WphKFXgNm+inqiBzipp4RIZjt72yYvDN0mlWb3D2FPKylLVXjslI3k/u3lsV5/Qs
	aF3GcU74vCQEpy24blbDE8sdm/soDFp6Ifu3hvN8iiOU9NTtAfw+2rH4MfcI9DF3ERII4o
	3RLAGCNSdWIyjZV1a0r5zVsCuGX9exM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728649673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mSeU2If84l66PDOJ59XMLcV7XLr9GTHLce28wgBx0f0=;
	b=lWFcp1WphKFXgNm+inqiBzipp4RIZjt72yYvDN0mlWb3D2FPKylLVXjslI3k/u3lsV5/Qs
	aF3GcU74vCQEpy24blbDE8sdm/soDFp6Ifu3hvN8iiOU9NTtAfw+2rH4MfcI9DF3ERII4o
	3RLAGCNSdWIyjZV1a0r5zVsCuGX9exM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEBE7136E0;
	Fri, 11 Oct 2024 12:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bFPjNMgZCWfkagAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Oct 2024 12:27:52 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.12-rc3
Date: Fri, 11 Oct 2024 14:27:52 +0200
Message-ID: <20241011122752.13233-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc3-tag

xen: branch for v6.12-rc3

It contains a single fix for topology information of Xen PV guests.

Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c | 4 ++++
 1 file changed, 4 insertions(+)

Juergen Gross (1):
      x86/xen: mark boot CPU of PV guest in MSR_IA32_APICBASE

