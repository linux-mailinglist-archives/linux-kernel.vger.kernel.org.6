Return-Path: <linux-kernel+bounces-194362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8870F8D3AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6171C215C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAF41802D6;
	Wed, 29 May 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GZeXdiV7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GZeXdiV7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D997746E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996537; cv=none; b=PsrihvUGTRrKhrUQtJBqj+AFPEEF8yq4NKhcASrA3k83KVeLCb1OAkbmAmfWgMgHyzdGIZORoQeu27+W9hFrPscX2s4mn1uT8LqfjCwYz3DISWj0nxo85oXGhqGAd/RWfacNpYVuoVX6+78vUCAhtKHIDD1GirvcTrnIi5oZLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996537; c=relaxed/simple;
	bh=KV2PN+zHiynw9SsYBN77fsZ7CbSVNoJRxI7I3GKbct8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EPJHs9f/P1aIL2B3XO7zzeoTFq+68ght+pc4lht6g3U4DL12Y1+8nhNEG3/k98FyqUwQwsTS6A/R3JEm0HPh9AoeW61FHmyf+cAHX+tCKnNdXis29JfyLsjxp8EkMpq7z1WKO5pZaDw/NS/JsaLqs9r1CuvGVLsrJVl3pPBCAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GZeXdiV7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GZeXdiV7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A796821BFD;
	Wed, 29 May 2024 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716996533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QVcS2ml1yTHvRqrZdzEVXS8S59w2Jdj6F5oGk4wAxvg=;
	b=GZeXdiV7AESq8LWFOTwkC2yUIAkzK7fP5T4wwRNs8MumG7Dcn+a5MuPzpGefTrRvmo82rw
	xdY0AlishzYZDBpNVYQYMFN2DzuVlyGLG5WSiANQmuj+TA3T+FHdfveoSs3IFRYQuLJRdt
	VMhye90r3sBKYU0MMxMZeOGJZ7tthvU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716996533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QVcS2ml1yTHvRqrZdzEVXS8S59w2Jdj6F5oGk4wAxvg=;
	b=GZeXdiV7AESq8LWFOTwkC2yUIAkzK7fP5T4wwRNs8MumG7Dcn+a5MuPzpGefTrRvmo82rw
	xdY0AlishzYZDBpNVYQYMFN2DzuVlyGLG5WSiANQmuj+TA3T+FHdfveoSs3IFRYQuLJRdt
	VMhye90r3sBKYU0MMxMZeOGJZ7tthvU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7287413A6B;
	Wed, 29 May 2024 15:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UhqkGbVJV2ZJdAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 29 May 2024 15:28:53 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/kexec: Remove spurious jmp 1f from from identity_mapped()
Date: Wed, 29 May 2024 18:28:50 +0300
Message-Id: <20240529152850.1227756-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.66 / 50.00];
	BAYES_HAM(-2.86)[99.39%];
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
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.66
X-Spam-Flag: NO

This seemingly straightforward jmp was introduced in the initial version
of the the 64bit kexec code without any explanation. It turns out (check
accompanying link) it's likely a copy/paste artefact from 32bit code,
where such a jmp could be used as a serialising instruction for the 486's
prefetch queue. On x86_64 that's not needed beacuse there's already a
preceding write to cr4 which itself is a serialising operation.

Link: https://lore.kernel.org/all/55bc0649-c017-49ab-905d-212f140a403f@citrix.com/
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..54e620021c7e 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -153,9 +153,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 1:
 	movq	%rax, %cr4

-	jmp 1f
-1:
-
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3

--
2.34.1


