Return-Path: <linux-kernel+bounces-373182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F348F9A536D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3B2830BA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76D811F1;
	Sun, 20 Oct 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EAAlkW7u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EAAlkW7u"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C12C181
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729418738; cv=none; b=VIz5aXX5KD6+cJlz9lvrxh6Ug5+aZGcNLVcmkqhpJnccS818xjcrWaoOtl1Z4Ol9xkX93USYZ7UzE2zXXht+QqnKxgLGmUIRkq5wBzwHp8HS7oqDzDbDLP6K7ZDImHCNxui0LsPayatQHoh4tuKnhCrdCHaEmVbH4pKpFhYdgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729418738; c=relaxed/simple;
	bh=1zubAoXozFOi4/w84S1PdSPAh60vA3TEyGruyHvh3QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDXt/rFTVBmc7RW4nBusUnsbQesqu5F0minHG2e8vseD6lF01pDPj31bCyuDLTHLuLZv9FWEARo3DSrp8hlEtTWV3rzURs0nVQjJQF7tx81Q/lORy0pbGmi+AJT0FRIj1guM8KlFQH7QRLWJRSbZcku+DGkaUX7+Kn8grjU6XPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EAAlkW7u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EAAlkW7u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E34B1FDDE;
	Sun, 20 Oct 2024 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729418734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yN4mSamSE977luvalP1/nrLwKNupeevFLON1NVBJIOg=;
	b=EAAlkW7uunjfa8n0lH/lb98e3o41KEvzMwShkY4eq3LWOKb8mfPFGTcrocv6u/seuTvXB6
	kMlWiGdoE13/3su9CIhYGsgsPXGjMvUb0J+c9Wa9piiCIqXMsoIlVRalWj3njXP6Z/O8+r
	QP8fTyXGkDZda3C8kZKMf4G+MJ5zvkc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729418734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yN4mSamSE977luvalP1/nrLwKNupeevFLON1NVBJIOg=;
	b=EAAlkW7uunjfa8n0lH/lb98e3o41KEvzMwShkY4eq3LWOKb8mfPFGTcrocv6u/seuTvXB6
	kMlWiGdoE13/3su9CIhYGsgsPXGjMvUb0J+c9Wa9piiCIqXMsoIlVRalWj3njXP6Z/O8+r
	QP8fTyXGkDZda3C8kZKMf4G+MJ5zvkc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD2AF13894;
	Sun, 20 Oct 2024 10:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gQNDMO3VFGd4IgAAD6G6ig
	(envelope-from <jgross@suse.com>); Sun, 20 Oct 2024 10:05:33 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.12-rc4
Date: Sun, 20 Oct 2024 12:05:33 +0200
Message-ID: <20241020100533.24289-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc4-tag

xen: branch for v6.12-rc4

It contains just a single fix for a build failure introduced with a
patch in the 6.12 merge window.

Thanks.

Juergen

 drivers/xen/Kconfig                |  1 -
 drivers/xen/acpi.c                 | 24 ++++++++++++++++++++++++
 drivers/xen/privcmd.c              |  6 ++----
 drivers/xen/xen-pciback/pci_stub.c | 11 +++++++++--
 include/xen/acpi.h                 | 14 +++++++++-----
 5 files changed, 44 insertions(+), 12 deletions(-)

Jiqian Chen (1):
      xen: Remove dependency between pciback and privcmd

