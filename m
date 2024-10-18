Return-Path: <linux-kernel+bounces-371985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5579A42F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D61D2820C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DC9202F6F;
	Fri, 18 Oct 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ude7u+Cn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ude7u+Cn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B10201271
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266717; cv=none; b=K5DVQ3mJeo7giD3SuIR5vgUWCri8DlyI2DCePfHot+KdUxBlMquGvmVjBmOjWXlrqFYIBaB/pyYRP2RJBxI8hGlmIEC6dV5L8SCmHahXamI+bvtnh+589Hj+Sq6NpioPGZn78JDHQWV8Ck6+XIyYsuq4RjPwyJ9TzOpOiydmfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266717; c=relaxed/simple;
	bh=oS68MaL8eWy4mAk70gs3Fwr6dLNVT/QWAf+96r2AMRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4dEzowvRmYa1knQOJTsp/M9NOzCc40f9cqEx9NIjs/KRf/7S+IC1K2UiMf5MGqQwv/xZIo+O1my9oULsFWZWTnsF6Wnokx5ODgxZzz6KnuwSF/jcGgCZtSrlp9FQbXx3lTA/xrkvXVglLUaUor1AaezM3R30yt0PgDCeIZ2MOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ude7u+Cn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ude7u+Cn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EF1D1F7FD;
	Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPGclzRuSriQ1LArqFrQu9QFEEXg4iJhqamCVoDdVOE=;
	b=ude7u+CnoxmgRluTXqbwvj8Jssm92wJdoHLDc4+KQOw4lPBEmmjmTjRB7KihZLsxw/RF/H
	Pt7IltMPkdiMlv6Unf33g3mk/7YYQ5V85KtY0Mj3mD0HH+e3pjDjsVFgA829dq12GEPsgd
	Eg9s6Y9RuCVRIpPVRyiwLBwyGumwaOY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPGclzRuSriQ1LArqFrQu9QFEEXg4iJhqamCVoDdVOE=;
	b=ude7u+CnoxmgRluTXqbwvj8Jssm92wJdoHLDc4+KQOw4lPBEmmjmTjRB7KihZLsxw/RF/H
	Pt7IltMPkdiMlv6Unf33g3mk/7YYQ5V85KtY0Mj3mD0HH+e3pjDjsVFgA829dq12GEPsgd
	Eg9s6Y9RuCVRIpPVRyiwLBwyGumwaOY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EE9613A7F;
	Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Dw3CRmEEmcvTwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 18 Oct 2024 15:51:53 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 1/3] x86/microcode/AMD: Return bool from find_blobs_in_containers()
Date: Fri, 18 Oct 2024 18:51:49 +0300
Message-Id: <20241018155151.702350-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018155151.702350-1-nik.borisov@suse.com>
References: <20241018155151.702350-1-nik.borisov@suse.com>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Instead of open-coding the check for size/data move it inside the
function and make it return a boolean indicating whether data was found
or not. No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f63b051f25a0..9986cb85c951 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -554,7 +554,7 @@ static bool get_builtin_microcode(struct cpio_data *cp)
 	return false;
 }
 
-static void __init find_blobs_in_containers(struct cpio_data *ret)
+static bool __init find_blobs_in_containers(struct cpio_data *ret)
 {
 	struct cpio_data cp;
 
@@ -562,6 +562,7 @@ static void __init find_blobs_in_containers(struct cpio_data *ret)
 		cp = find_microcode_in_initrd(ucode_path);
 
 	*ret = cp;
+	return cp.data && cp.size;
 }
 
 void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)
@@ -576,8 +577,7 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
-	find_blobs_in_containers(&cp);
-	if (!(cp.data && cp.size))
+	if (!find_blobs_in_containers(&cp))
 		return;
 
 	if (early_apply_microcode(ed->old_rev, cp.data, cp.size))
@@ -597,8 +597,7 @@ static int __init save_microcode_in_initrd(void)
 	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
-	find_blobs_in_containers(&cp);
-	if (!(cp.data && cp.size))
+	if (!find_blobs_in_containers(&cp))
 		return -EINVAL;
 
 	scan_containers(cp.data, cp.size, &desc);
-- 
2.34.1


