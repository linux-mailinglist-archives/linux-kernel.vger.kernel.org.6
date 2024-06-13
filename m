Return-Path: <linux-kernel+bounces-213074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6760906ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC2282805
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF8142E83;
	Thu, 13 Jun 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BCIFIW7J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BCIFIW7J"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026A13F44A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276925; cv=none; b=EJNzp602YGdjrFncDKyLL+p7yY6VG3oAMqhOrH5W+M+oRMLqOA/HopzqmH0FmL5BulAb/MOys9qjPzVTZSoKwOXZKwlpghfKNOq+u4hKxVoxDPHfQaW+sphr9vBHfTG4umrOL30Afn6b5AwB+LrobPDLSiJvdsIkeMm5IJNHGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276925; c=relaxed/simple;
	bh=NoKlM3z2XRRml8IVaCoEAkq7esY2u38pvl3GFNeJv3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fv2G6i8OwtJJJ1Lr6KduvgiOFsIg73SIh/VcDuPXEiZQQ1dTyrqu6kR3VEi5qnuFPTM7aL+Bxf8hmpdQ8MjAbAfPo36mbZlzGH3av46R7TWP+z5S2hJY9HEyek4+M1XWTQPhCnuzM7Y5ZEnIT3dPhAIahXvx1sfGEsWdbKGcAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BCIFIW7J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BCIFIW7J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 620A7352E8;
	Thu, 13 Jun 2024 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718276921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V/iWbWhG2My8bCeL6MeDIo/emE8CbfAk8+jMy72Gqbo=;
	b=BCIFIW7JSProNphxHllz/TO+0aLiO6qBN8kvBH81YIO4Wv/eJcxqpNO7wIi9s7bhEIsQCy
	mkHWsmTH5zP6fX+c/sovbv8wOvfhvioRTv3KgO2TW63V9JsfcU+IWfEPQEgFXM1TZI0k7j
	dwHhD5Dg+gyL5719oodLn4yC5G5Cvak=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718276921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V/iWbWhG2My8bCeL6MeDIo/emE8CbfAk8+jMy72Gqbo=;
	b=BCIFIW7JSProNphxHllz/TO+0aLiO6qBN8kvBH81YIO4Wv/eJcxqpNO7wIi9s7bhEIsQCy
	mkHWsmTH5zP6fX+c/sovbv8wOvfhvioRTv3KgO2TW63V9JsfcU+IWfEPQEgFXM1TZI0k7j
	dwHhD5Dg+gyL5719oodLn4yC5G5Cvak=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A8A713A7F;
	Thu, 13 Jun 2024 11:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EEw2ADnTamb/DgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 13 Jun 2024 11:08:41 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2] x86/boot: Remove unused function __fortify_panic()
Date: Thu, 13 Jun 2024 14:08:37 +0300
Message-Id: <20240613110837.300273-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.78
X-Spam-Level: 

That function is only used when the kernel is compiled with
FORTIFY_SOURCE and when the kernel proper string.h header is used. The
decompressor code doesn't use the kernel proper header but has local
copy which doesn't contain any fortified implementations of the various
string functions. As such __fortify_panic() can never be called from the
decompressor so let's remove it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
Since v1:
	* Fixed typo in function
	* Added () after __fortify_panic mention in the changelog...

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


