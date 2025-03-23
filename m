Return-Path: <linux-kernel+bounces-572764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC08A6CE67
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4907E3B5596
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2751202C2E;
	Sun, 23 Mar 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BYJf5RaM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y/JF0Czr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BYJf5RaM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y/JF0Czr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EB78F2F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742720069; cv=none; b=aeA+wwt5ys81qD06sKZuqWf/BIYZqqWIiikrbtoc+UY3mSIeYzly14ZnXyT9EOazVXX0oYeerVKz0fnc1COzstw9qfKV3meqJAgFM87QqRemYstkNyT+/ICBmGvNWUAKrHjVykQFLu7vzzdfN1v0WHRShHAeOuQrB1mKHzIcOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742720069; c=relaxed/simple;
	bh=sOwFzpDjJkd55J6qu3JCI8cMcG/o+3c2lv3F//WoEQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxMcpHQm8vMveiW32lENWQBarv3oFk4vbzafRO4m2Oswj15tUadN2ntljimKwxEW5RyHn3tvx4PX7JIELRBsRq5WTFboYjwxe/2uuraRM+tgvt/9kySMSiF6oqLcbFyZJW9GLQdjDR8Q4q8pVPY43wEFE1YqJtRkvvzTosW0dWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BYJf5RaM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y/JF0Czr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BYJf5RaM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y/JF0Czr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from suse.de (unknown [10.100.2.194])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4EEC21F393;
	Sun, 23 Mar 2025 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742720060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oWsoZ+l4mclhrCB2O5/XZ/kP3wx9wmzAL1n98yjQb9E=;
	b=BYJf5RaMgxZpsYYt+gTpSs3D+Vhl7PNG01/AlCONBp+PWfNzEV0Dw/i4J3qimS+ucoocS6
	Pjhgk17SkIaQaDLlR9Bseytjp+ky6FteWTxNiR7Vb/XqvWGZAZcMgA1DNycp9R+1LznzA7
	4qoNnMjGEhtjoXqdFI/8p/X4SNVnDo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742720060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oWsoZ+l4mclhrCB2O5/XZ/kP3wx9wmzAL1n98yjQb9E=;
	b=Y/JF0CzrVRY41BdZWbR7vO8WIV/dEXddz2WRCVjeICgXpIcYIdgQIGID73t5zBpBIgwWln
	HWakfSgJwDsZG2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742720060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oWsoZ+l4mclhrCB2O5/XZ/kP3wx9wmzAL1n98yjQb9E=;
	b=BYJf5RaMgxZpsYYt+gTpSs3D+Vhl7PNG01/AlCONBp+PWfNzEV0Dw/i4J3qimS+ucoocS6
	Pjhgk17SkIaQaDLlR9Bseytjp+ky6FteWTxNiR7Vb/XqvWGZAZcMgA1DNycp9R+1LznzA7
	4qoNnMjGEhtjoXqdFI/8p/X4SNVnDo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742720060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oWsoZ+l4mclhrCB2O5/XZ/kP3wx9wmzAL1n98yjQb9E=;
	b=Y/JF0CzrVRY41BdZWbR7vO8WIV/dEXddz2WRCVjeICgXpIcYIdgQIGID73t5zBpBIgwWln
	HWakfSgJwDsZG2CA==
Received: by suse.de (Postfix, from userid 1000)
	id 423821806D7; Sun, 23 Mar 2025 09:54:20 +0100 (CET)
From: Marcus Meissner <meissner@suse.de>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	carsten.haitzler@arm.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marcus Meissner <meissner@suse.de>
Subject: [PATCH] perf: annotate asm_pure_loop.S
Date: Sun, 23 Mar 2025 09:53:45 +0100
Message-ID: <20250323085410.23751-1-meissner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.70
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Annotate so it is built with non-executable stack.

Fixes: 8b97519711c3a0f9eb8274a227dff3fe4f0f72a2
Signed-off-by: Marcus Meissner <meissner@suse.de>
---
 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
index 75cf084a927d..577760046772 100644
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
@@ -26,3 +26,5 @@ skip:
 	mov	x0, #0
 	mov	x8, #93 // __NR_exit syscall
 	svc	#0
+
+.section .note.GNU-stack, "", @progbits
-- 
2.43.0


