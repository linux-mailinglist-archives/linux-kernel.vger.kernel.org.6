Return-Path: <linux-kernel+bounces-371986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F50D9A42F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3DB1F23EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEF202F75;
	Fri, 18 Oct 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XM6EL3qq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XM6EL3qq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE9165EFC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266717; cv=none; b=i8lq7hPNk/NBv9S9LEX30F2XFj3uX8jcK95CQHCqzxWNJvIMmcEpkzH2izuL+y9EwtMhdgFTZg+sBS9YmoE19k3LkltJ9xg3EWwJ3YVr/Vgjwpw/jjpkDdsrwC4tloxVlFGbIKnYuw1DvsvI8wSVgYxPWJ3PxT8GzKkQq1ruhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266717; c=relaxed/simple;
	bh=bKVbGZrcmlJayVE3NlLl398wEqLngGiUSaAH0OJkd5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxYuHOsd1csi7TzI0dsfdAufLwdJPEPgndk4DUW5k18eKaOu50AoXwDa5EsQ5P/bdlasxHDlb1Inun+vuFESf2o1zItbM1Uzmx+2lNt2VYdrSj3S6DMHdmTUaeQ7JN1xhTQfWRknwLNqecHcvM8FtjN51B5ZlQGDu14FAdiZ0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XM6EL3qq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XM6EL3qq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1015D21D06;
	Fri, 18 Oct 2024 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6GRUW7l8LPVKjGnWI+EPQJ0S+pCZSweLZVBQClN/cA=;
	b=XM6EL3qqhWxezdgAPBXd8gaSwDJPsF+u27MTAqZpJki4L+C43+EWD9JGHS1+JQdPN4CD5v
	1J5CsIk9mBZxJDqyVPFL5Ficc4VJWu8PIVRcZa5tkQUxCcfee/0MYP+GuiX2Lv0C8B6IOG
	smTO9/GfJ3DhBl5VYUEHfQ/rS55e+9Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729266714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6GRUW7l8LPVKjGnWI+EPQJ0S+pCZSweLZVBQClN/cA=;
	b=XM6EL3qqhWxezdgAPBXd8gaSwDJPsF+u27MTAqZpJki4L+C43+EWD9JGHS1+JQdPN4CD5v
	1J5CsIk9mBZxJDqyVPFL5Ficc4VJWu8PIVRcZa5tkQUxCcfee/0MYP+GuiX2Lv0C8B6IOG
	smTO9/GfJ3DhBl5VYUEHfQ/rS55e+9Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C872413A7F;
	Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBAnLhmEEmcvTwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 18 Oct 2024 15:51:53 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 3/3] x86/microcode/AMD: Remove bogus comment from parse_container()
Date: Fri, 18 Oct 2024 18:51:51 +0300
Message-Id: <20241018155151.702350-4-nik.borisov@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The functions doesn't return an equivalence ID, remove the false
comment.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 37a428b109a2..f4e6d1f96b6b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -375,8 +375,8 @@ static bool mc_patch_matches(struct microcode_amd *mc, u16 eq_id)
 
 /*
  * This scans the ucode blob for the proper container as we can have multiple
- * containers glued together. Returns the equivalence ID from the equivalence
- * table or 0 if none found.
+ * containers glued together.
+ *
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */
-- 
2.34.1


