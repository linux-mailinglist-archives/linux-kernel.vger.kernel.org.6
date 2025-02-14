Return-Path: <linux-kernel+bounces-514544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A3A35850
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E04168E00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7F21CC4E;
	Fri, 14 Feb 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NaxdaKET";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DDwhNG9o"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3221CA1F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520000; cv=none; b=Ei51F5/a3Hh/vJN/6pyOZk5fKfpv0uVKvNfgB+lF03YtXoNgsS+WTT3h6qqmXWhuVvC4dNeeX+8byxjiwr37uX6mWlkPc/EF3HC7tR9Jh0+9IEdiSugYJP3XGX7KWm7SogiywRXFSfISomPYEloPFaXgpV8Ubap6C0aUIDV0W8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520000; c=relaxed/simple;
	bh=DKMGO+BlRls70FJsTX8R+XDMAZDrzb6etwUX4idhAP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaCIQnV+X26Df8CFCmtikpMmZOLK1nvzgasn3oFDaZOH43hanTMzFDSnebY3qP+VEYnFpuaaGlegkjzl+SHM7xiWYys0rwyO3FCkCZoHnHTCfSeCwQJSiDtqLtN/oaBAXQuQFTFQ31FcJY0gDFA2r6DTe66vJ4nAlei1O1FUZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NaxdaKET; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DDwhNG9o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 390351F451;
	Fri, 14 Feb 2025 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739519997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vl42sO+5tmTPqeo1iMS87UANmhyjUCvI0bsY48G3xH8=;
	b=NaxdaKETD89REe6+zWdTKRrZKJfxGwWBd1s0J2O8nqi4oi82y0Uj69jiadBW5WcVZgXG6b
	jQr6vDFKxJr0FKpUMq3UY0N67EevVoMemWMXVkwCDNJ/u5WTkDEXNmXcLN421R40gzxSTx
	AE9U5n0dKSa4w1KPI5ig5Nk/pBTfwkc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DDwhNG9o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739519996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vl42sO+5tmTPqeo1iMS87UANmhyjUCvI0bsY48G3xH8=;
	b=DDwhNG9oNfUmq8eCdhdieU+vhk41r8ul7PAso9e/ktTQHDcuNx8ftuYovRuh1tZjmZCvFh
	bLVSceznziO1updZV2ERfD9elmWiQ+Aqu4BoQDxRkoNm24V1SDFYKY+KkojTRKpZSst9/g
	vhKzegdr1UmcQqhrCp7YbCrSWYwR//g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0177413285;
	Fri, 14 Feb 2025 07:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L8g3Ovv3rmdXHAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 14 Feb 2025 07:59:55 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.14-rc3
Date: Fri, 14 Feb 2025 08:59:55 +0100
Message-ID: <20250214075955.17913-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 390351F451
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.14-rc3-tag

xen: branch for v6.14-rc3

It contains 3 patches related to the xen-swiotlb driver:

- 2 fixes for issues coming up due to another fix in 6.12
- 1 addition of an __init annotation


Thanks.

Juergen

 arch/x86/xen/mmu_pv.c     | 71 +++++++++++++++++++++++++++++++++++++++++------
 drivers/xen/swiotlb-xen.c | 22 +++++++++------
 2 files changed, 75 insertions(+), 18 deletions(-)

Jan Beulich (1):
      Xen/swiotlb: mark xen_swiotlb_fixup() __init

Juergen Gross (2):
      xen/swiotlb: relax alignment requirements
      x86/xen: allow larger contiguous memory regions in PV guests

