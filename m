Return-Path: <linux-kernel+bounces-536887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C16A48556
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417EF3A3D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7191B4155;
	Thu, 27 Feb 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ph8oWogX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pJlstLFH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E41B0409
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674378; cv=none; b=Wo65ZC+4n31mzfkd+Myf+6xozR9vLiNBVErY1jRSeWRdx7obvo6Jzj/BHn0fw87eQQNfc2pstmSo6H6iweiMZWu45+U+JxIxGJGLNPEpedot3GRBl/h33WT51BI9Iahz0TFUJXfDhhpfICJ7yNuDWozVR/BeAxHt44P/3RMlRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674378; c=relaxed/simple;
	bh=64o8j6cVEr9JbVAK2DAuDX0P8B2k0DQFx3sNT2u0wnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rb3U6dyeLHTgFA80V6gZWK35KZLnMJSMyTCk2/7+v+vdVEyGzMt5uU0odZj6UyUKWPVQsyE21V9nelnSrGQ0IARk4HRvQVDgJ2DD1ZCPjov7xAuUdgqYOWvM0JTwjgcw6VWDOZgMQVQUpEluG8VsxtFFs3Hhz2oDKXslrMVnNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ph8oWogX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pJlstLFH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BB7F1F38A;
	Thu, 27 Feb 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740674374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=13okJ43oCKHgKKB8RsUnHCLh7BL/drDJTLZToPO9fPk=;
	b=Ph8oWogXkPo5WUr9R3rgvnl0I7dxDrOf5Jg5kr0HKMi3hVVygeFPqLO3JEf0IZMVplnq7g
	Wcl7lO2yy2oD8qafeccxapdXwdDSduftN7ixPwqpbSijm0r31ysammZ0e7KVdRNzl7qBPA
	Z3BgzCF1zE5+qwJUyo8DaAwpQ/LUDt8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740674373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=13okJ43oCKHgKKB8RsUnHCLh7BL/drDJTLZToPO9fPk=;
	b=pJlstLFH16KY+cAt4l2WfHCuvKck3c71JaQM/Yuz4I+MUYmOUUEQzLq244qt+59EbQTSP0
	dlluK4h/XrHSfonBXuAPzs24vol5RaMVELKWb6oVh98DD/+t55q48ZXmmCuLvVduowveAp
	LG0M0DpHMHYjgRRr/Fl8+2N+mdgUxxU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06AB91376A;
	Thu, 27 Feb 2025 16:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Aj9AAEWVwGcNJQAAD6G6ig
	(envelope-from <vincenzo.mezzela@suse.com>); Thu, 27 Feb 2025 16:39:33 +0000
From: Vincenzo MEZZELA <vincenzo.mezzela@suse.com>
To: live-patching@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	corbet@lwn.net,
	Vincenzo MEZZELA <vincenzo.mezzela@suse.com>
Subject: [PATCH v2] docs: livepatch: move text out of code block
Date: Thu, 27 Feb 2025 17:39:29 +0100
Message-ID: <20250227163929.141053-1-vincenzo.mezzela@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Part of the documentation text is included in the readelf output code
block. Hence, split the code block and move the affected text outside.

Signed-off-by: Vincenzo MEZZELA <vincenzo.mezzela@suse.com>
---
Changes in v2:
- Fixed usage of "::" in literal blocks

 Documentation/livepatch/module-elf-format.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/livepatch/module-elf-format.rst b/Documentation/livepatch/module-elf-format.rst
index a03ed02ec57e..5d48778d4dfc 100644
--- a/Documentation/livepatch/module-elf-format.rst
+++ b/Documentation/livepatch/module-elf-format.rst
@@ -217,16 +217,19 @@ livepatch relocation section refer to their respective symbols with their symbol
 indices, and the original symbol indices (and thus the symtab ordering) must be
 preserved in order for apply_relocate_add() to find the right symbol.
 
-For example, take this particular rela from a livepatch module:::
+For example, take this particular rela from a livepatch module::
 
   Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
   000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
 
-  This rela refers to the symbol '.klp.sym.vmlinux.printk,0', and the symbol index is encoded
-  in 'Info'. Here its symbol index is 0x5e, which is 94 in decimal, which refers to the
-  symbol index 94.
-  And in this patch module's corresponding symbol table, symbol index 94 refers to that very symbol:
+This rela refers to the symbol '.klp.sym.vmlinux.printk,0', and the symbol
+index is encoded in 'Info'. Here its symbol index is 0x5e, which is 94 in
+decimal, which refers to the symbol index 94.
+
+And in this patch module's corresponding symbol table, symbol index 94 refers
+to that very symbol::
+
   [ snip ]
   94: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.printk,0
   [ snip ]
-- 
2.48.1


