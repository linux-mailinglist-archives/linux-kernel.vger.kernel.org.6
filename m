Return-Path: <linux-kernel+bounces-208120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF2902103
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288E51F22580
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD677FBD1;
	Mon, 10 Jun 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HWmo+Dxe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HWmo+Dxe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4078C9C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020648; cv=none; b=tkMae3Xvab2qSDLuwXobE3Z6awpbEvFvjpDQ5gerBncjrHFcXWxg+XdovEYUnyViwgWhgUq63myNcBf5GIyhZNxazquWOP/jYTWaUOaaWXi25u/dw3F8yAGSuAxxDHcdAZ5tW94cHeCKwJK37hWWkO70U0I5YqIbnd3HAIvorYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020648; c=relaxed/simple;
	bh=5qBxDQUXasngRYkylw5SsgPhp9hRTNTgYYxtIvVzhuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5GxQY6RQkgDOYmR4rvQ2q9qC6M4QDf3JXcB3jCrN5v3fez3JnHn22JH1BO+a1AABF+GolsJ6mLP0APrLGs0y2Zav7VbQnWTxRfoslv4ojhb+BYfjmxuCuQY6jtP5gxi9Y4OuSO62P7xewxzDVs9RH7Go+C55++Vdj5zz0om7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HWmo+Dxe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HWmo+Dxe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFACC21A4D;
	Mon, 10 Jun 2024 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718020644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/TdWq8PyXuXVwPR8Hv+sr1APX3Q4DXtBA/3pEQPpwp0=;
	b=HWmo+Dxe5K/yvlC1OWu7k0Zr5LtVLLDAi658wUHUu3i+nH1NbdOEb2NGyCMuKdC/jmBnAW
	TPhYi8oJc8o9jzA6YdgH1Ovs/qfLjJQW2dLp9vXv/sOhP0QwQoHFhaLH1nIXeqFX1G4OPf
	mC3vom045mH3Aicxtlz8grGCfXw6Wow=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718020644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/TdWq8PyXuXVwPR8Hv+sr1APX3Q4DXtBA/3pEQPpwp0=;
	b=HWmo+Dxe5K/yvlC1OWu7k0Zr5LtVLLDAi658wUHUu3i+nH1NbdOEb2NGyCMuKdC/jmBnAW
	TPhYi8oJc8o9jzA6YdgH1Ovs/qfLjJQW2dLp9vXv/sOhP0QwQoHFhaLH1nIXeqFX1G4OPf
	mC3vom045mH3Aicxtlz8grGCfXw6Wow=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 662E113A7F;
	Mon, 10 Jun 2024 11:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qpOeFiTqZma9GAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 10 Jun 2024 11:57:24 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/boot: Remove unused function __fortify_panic()
Date: Mon, 10 Jun 2024 14:57:22 +0300
Message-Id: <20240610115722.107780-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[25.82%];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.20
X-Spam-Flag: NO

That functino is only used when the kernel is compiled with
FORTIFY_SOURCE and when the kernel proper string.h header is used. The
decompressor code doesn't use the kernel proper header but has local
copy which doesn't contain any fortified implementations of the various
string functions. As such __fortify_panic can never be called from the
decompressor so let's remove it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/boot/compressed/misc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..944454306ef4 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -531,8 +531,3 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 
 	return output + entry_offset;
 }
-
-void __fortify_panic(const u8 reason, size_t avail, size_t size)
-{
-	error("detected buffer overflow");
-}
-- 
2.34.1


