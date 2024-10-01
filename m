Return-Path: <linux-kernel+bounces-345663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B498B8F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FFD2838F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1851A0731;
	Tue,  1 Oct 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGRANYJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uv6WRnNs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGRANYJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uv6WRnNs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E48E1C693
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777360; cv=none; b=mdVIMWmW8ZneM/8e7aCfZQMK6aKyDT38+elu9QmfCZRQyHV7hRecty21ZisCKMOz09s21G3AUN9XybFqEUkV5JjoFWwENAU1AFwOIpnTvnO77jKQAnynkEMmuem9tFBEQzpyz3r85vbXql8UiHAVAKvdw3Wpcl5+FoI4JPIW3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777360; c=relaxed/simple;
	bh=l8VCuzpeBd7YIAqsx0TUeYwS/UrzXT1XBZ6ibUvBIMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR4GksGXUQLsASaux6Qaj7b2H6nWvGunuaUNAszagyHGnwdwZ0DXWsIKdvT3a6z78QxKfPMEuY4Je9LKy6agj4cx+RrE44Yc+i/NfpfEWWe6RUMo3Jg2vgwGPMi89gvuAe41R68D+czacY8Y+TBiN0Y6GuMrz6NWFS2xTy/xMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zGRANYJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uv6WRnNs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zGRANYJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uv6WRnNs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3437421AE6;
	Tue,  1 Oct 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727777357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vsLdevLuxWWZZcQWZ6K460x6RCmyx9r/j4uIM4zeFJY=;
	b=zGRANYJePyCLq6fKuTYj+Hj7if3j15l3x7wsOjfAcoDbR/x8G92ZH6jYdPJPkoanQoKKmv
	M47VBZq92JPunSVo1ep0qrMwxLo7YJUpP7MCdGRsBOU6HAjbU6bgIdeu1OMjuLLNmkdFfV
	Xhpxm3/CXHwc/LGTh2xZvK/ExaUqTuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727777357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vsLdevLuxWWZZcQWZ6K460x6RCmyx9r/j4uIM4zeFJY=;
	b=uv6WRnNsRi/weQxvtZxFKNW3vjfvW/BmBxyk6drDdJ7sx38j2ijVLPKOr6NJaMqGVmqtQk
	AyayX+fhj7KHOUCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727777357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vsLdevLuxWWZZcQWZ6K460x6RCmyx9r/j4uIM4zeFJY=;
	b=zGRANYJePyCLq6fKuTYj+Hj7if3j15l3x7wsOjfAcoDbR/x8G92ZH6jYdPJPkoanQoKKmv
	M47VBZq92JPunSVo1ep0qrMwxLo7YJUpP7MCdGRsBOU6HAjbU6bgIdeu1OMjuLLNmkdFfV
	Xhpxm3/CXHwc/LGTh2xZvK/ExaUqTuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727777357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vsLdevLuxWWZZcQWZ6K460x6RCmyx9r/j4uIM4zeFJY=;
	b=uv6WRnNsRi/weQxvtZxFKNW3vjfvW/BmBxyk6drDdJ7sx38j2ijVLPKOr6NJaMqGVmqtQk
	AyayX+fhj7KHOUCA==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/sstep: Unexport analyze_instr, emulate_vsx_load, emulate_vsx_store
Date: Tue,  1 Oct 2024 12:08:47 +0200
Message-ID: <8ecdbd907a8a92cbf9c7308df13f9d19f5ba5621.1727777273.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.46.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.de,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com,ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

There is no modular user of analyze_instr, and the latter two are only
used by sstep itself.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/lib/sstep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index e65f3fb68d06..a0557b0d9a24 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -863,7 +863,6 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(emulate_vsx_load);
 NOKPROBE_SYMBOL(emulate_vsx_load);
 
 void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
@@ -955,7 +954,6 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(emulate_vsx_store);
 NOKPROBE_SYMBOL(emulate_vsx_store);
 
 static nokprobe_inline int do_vsx_load(struct instruction_op *op,
@@ -3172,7 +3170,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	op->val = SRR1_PROGTRAP;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(analyse_instr);
 NOKPROBE_SYMBOL(analyse_instr);
 
 /*
-- 
2.46.0


