Return-Path: <linux-kernel+bounces-371984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE649A42F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF261F2254C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C3202F6C;
	Fri, 18 Oct 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J0q++TUO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J0q++TUO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C8201277
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266717; cv=none; b=YsawyokSicYXVwKvkPt5U7v9MVeQAdQcmZQbs80wFNvl0zef7TyWWHpoJ6ItjD5QQ/GewhDfk2Ll0onzUFnuvflfmSmlQhmK/uZBOPwDub3ZVE9Z92xgT2CNy7UaCtCyAcEb4Hm8BHx3LKt8Gv6d78yfMwWs04HsE+2hmz5TUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266717; c=relaxed/simple;
	bh=QeYya6PLVeBUcR5U2zHNvWyl0K1mFebd1ZprbHk4lqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCE3hFYD5lnGB8p8EGr1H0/x7SmWdsCsDsUkKM7wV1jnD5Hs3qknfT7Kl8nckMDlJUcrRrrn5Ir/INjxB9S20OjjZbMqJdUbreb25tnl45Y4Vl79i08fuclzjoIm2zOZ5t0K6vBbEq2UcR+0t9ZBg3u9fzT6+gzDUS461Y4osbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J0q++TUO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J0q++TUO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7AF721C99;
	Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5ikgjVSfBS6Q+1un3aDubfCNJOs1tOymRWICZ/T0eI=;
	b=J0q++TUO0vCDFTuwbKr8sAsMPuyv483sIMgW/ln7chw9NUsT9zbmoYHROd7TvgLchLPIiw
	4KcUD0ew751lyK8kbucdYm14klhgT6VxBxa6yi00Ruaim1Bsbwh2tIBrxbHcWdrq7Qwd4q
	Xb65bz59QTS903Fur4m8hGYdgT+CDHk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5ikgjVSfBS6Q+1un3aDubfCNJOs1tOymRWICZ/T0eI=;
	b=J0q++TUO0vCDFTuwbKr8sAsMPuyv483sIMgW/ln7chw9NUsT9zbmoYHROd7TvgLchLPIiw
	4KcUD0ew751lyK8kbucdYm14klhgT6VxBxa6yi00Ruaim1Bsbwh2tIBrxbHcWdrq7Qwd4q
	Xb65bz59QTS903Fur4m8hGYdgT+CDHk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78F3113680;
	Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLtJGxmEEmcvTwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 18 Oct 2024 15:51:53 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return bool
Date: Fri, 18 Oct 2024 18:51:50 +0300
Message-Id: <20241018155151.702350-3-nik.borisov@suse.com>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

The result of that function is in essence boolean, so simplify to return
the result of the relevant expression. It also makes it follow the
convetion used by __verify_patch_section(). No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9986cb85c951..37a428b109a2 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -282,7 +282,7 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
  * exceed the per-family maximum). @sh_psize is the size read from the section
  * header.
  */
-static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
+static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
 {
 	u8 family = x86_family(bsp_cpuid_1_eax);
 	u32 max_size;
@@ -305,10 +305,7 @@ static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
 		return 0;
 	}
 
-	if (sh_psize > min_t(u32, buf_size, max_size))
-		return 0;
-
-	return sh_psize;
+	return sh_psize <= min_t(u32, buf_size, max_size);
 }
 
 /*
@@ -323,7 +320,6 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 {
 	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
-	unsigned int ret;
 	u32 sh_psize;
 	u16 proc_id;
 	u8 patch_fam;
@@ -347,8 +343,7 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 		return -1;
 	}
 
-	ret = __verify_patch_size(sh_psize, buf_size);
-	if (!ret) {
+	if (!__verify_patch_size(sh_psize, buf_size)) {
 		pr_debug("Per-family patch size mismatch.\n");
 		return -1;
 	}
-- 
2.34.1


