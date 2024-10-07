Return-Path: <linux-kernel+bounces-352911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0B992606
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267DD1F21195
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FC170A00;
	Mon,  7 Oct 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ORmNAPgt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jq61R+8M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DSo+sjC8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E/qq1q0p"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94791BC5C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285850; cv=none; b=LUmin5z5430+XyfIWhcSJXx+vRfYfbx54vN/+9qvpXE4a5kHJOayIAlOt2z/L6TS0XJwp6CPiN+EhsKuc+MpCqlZu+gxoZ3fOFdfhXroXyxWVp1/Qky8Mgj2ytpJkyvTXb01Wv4D5B6AYFR+YNNzxV/GHsXbPl8EZuRBUku3VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285850; c=relaxed/simple;
	bh=cOFvncNvugzfWHnXqgSofSxQW5kvj+EchwIbpa1sU7I=;
	h=From:To:Subject:CC:Date:Message-ID:MIME-Version:Content-Type; b=MFfbGtbIkZK+h+xBHPoaZT/Yi7f0qW7BlOhvbrHfega1MIURiLjn7q5Mn0eosQtl8GgZTwEFxbEq7NL8HNtDhALLvQ0o4Ob5+Gtc9FRTTPAk4qhBwOPXebb3mayDRmEVstKfQ/SUgCXb2/k/UqufNZuJGwG5kXzcHTpOZcfxZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ORmNAPgt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jq61R+8M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DSo+sjC8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E/qq1q0p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
	by smtp-out2.suse.de (Postfix) with ESMTP id E22941FD13;
	Mon,  7 Oct 2024 07:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728285847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VVxqbpcpXZewZglUoXE5j167IfC1NCYRa8tUWDda670=;
	b=ORmNAPgt+/y2C43V4nq4xzectkjXblHHtN7bO9t5NcoQDleqbZOgs1pBOP0vC5L9dj5o0d
	f13BDzF2HRnzAaLjoLN7itJByDXIcRQjgmH1GwYasxPNQ5Jy6gWCjh2rIAyLtoLAfoiNBC
	W4R5lPAsN6dKBxlnESrHCSZgbhflzKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728285847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VVxqbpcpXZewZglUoXE5j167IfC1NCYRa8tUWDda670=;
	b=jq61R+8MZenGVidiIuZQDmp2CMq48kjPBFa3ju7/oT0qgWtXz6REFbgd8izbe9WXOTFd97
	UKtnK5UqspSSxvDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DSo+sjC8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="E/qq1q0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728285846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VVxqbpcpXZewZglUoXE5j167IfC1NCYRa8tUWDda670=;
	b=DSo+sjC8iNf1Bifsk4jNlIWcPPLInYL9z9mVipp1DO0hBkoCNc2S/IVzsbTw8JZWz6TUJE
	5JCHfjixSZ0Aevek+bzitKkhP7Idz/YHwIcIB3c6q6ylrj5BsHzt98xFvpPcrK+vhCGcBz
	I2oCSRhgIPPR5iNmycJ7tecNBctE8cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728285846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VVxqbpcpXZewZglUoXE5j167IfC1NCYRa8tUWDda670=;
	b=E/qq1q0pO8/g/96NKAkfFJMkIsyRH+yVbrfDTb9oVjEHp3fTD31R7hn8YoFbbeqN4MkVNa
	E8vFRBj0Pp9wZbAQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id AB2B04A03D4; Mon,  7 Oct 2024 09:24:06 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Subject: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
CC: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,  Andrea Parri
 <parri.andrea@gmail.com>,  linux-kernel@vger.kernel.org
X-Yow: FUN is never having to say you're SUSHI!!
Date: Mon, 07 Oct 2024 09:24:06 +0200
Message-ID: <mvm5xq44bqh.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: ****************
X-Spamd-Result: default: False [16.77 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[0.999];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.99)[0.995];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MX_GOOD(-0.01)[];
	DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_ONE(0.00)[1];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Spam-Score: 16.77
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: E22941FD13
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

This is needed so that <asm/barrier.h> can find <asm/fence.h> on riscv.

Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 tools/include/asm/fence.h | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/include/asm/fence.h

diff --git a/tools/include/asm/fence.h b/tools/include/asm/fence.h
new file mode 100644
index 000000000000..917a173059a4
--- /dev/null
+++ b/tools/include/asm/fence.h
@@ -0,0 +1,3 @@
+#if defined(__riscv)
+#include "../../arch/riscv/include/asm/fence.h"
+#endif
-- 
2.46.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

