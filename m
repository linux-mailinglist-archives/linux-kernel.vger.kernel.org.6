Return-Path: <linux-kernel+bounces-394900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040C9BB58A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003F51F2238A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C91BBBD7;
	Mon,  4 Nov 2024 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ExmoQJdJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n2Y93TZJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WkAlKuKr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="En2MZTEg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677F1AC42C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726054; cv=none; b=JHHrbrQjCIyIg5+JEiwDnfav+QqUh7emC4ss3kyPepBgopYmSl6VRbeI51Yf51YiKJd8XqJq+bglnF03nAE4jOR9M0iNMLlvv8XwmNILkat+YjGiSxPfXvOiqXL6ANmRq2Lec/T6se4ptVHrK/t9U+zSOAk5de8kfpRwOSD9jHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726054; c=relaxed/simple;
	bh=Vnfwv3peD4894dmCI61LBI4pB/PrtJmGhY7BR4ZRF5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E1AMs6SyjNWveXfvos7B/AGzbmIKQBYAP6VzS3fo7UAK+n7yGKHyIdCg7de7dCLO7KcphSGkcXv757JGVKEB3iq3SZWgIjeFoHcNUSHRgCTo75ePfa19y/t1Rw0zJkAqIy5KGa7hwfVS7othQn3N/4XpZdWzgH0g0o+wbSAxc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ExmoQJdJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n2Y93TZJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WkAlKuKr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=En2MZTEg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 690DB21DB2;
	Mon,  4 Nov 2024 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JrHg7cJ2Ud/6FQ/E7PLJqj1OANRhy5LU90CcoT2e/bA=;
	b=ExmoQJdJWOJ/Ly7WoTV0odylN7ToOBFytIJQOtpmwNfJO3Eot0SgtI9L3wRSlgqob0cG6N
	3TLrg55nf8oeMUkwsOPm1JlQhYopAT0q2A+QtKC1o628Nj+IJkqgJssnnC10ZB5NniUZLG
	fbAsfYODUayvyKRMgiFsLquLnNS8g78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JrHg7cJ2Ud/6FQ/E7PLJqj1OANRhy5LU90CcoT2e/bA=;
	b=n2Y93TZJlWF7rILDmz8ranQppFqFzvsXw67w/Kst85b0GS9Vyy64ptna7zD8Jt/imEVJf5
	TLRPGLgJ77qP+KBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WkAlKuKr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=En2MZTEg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JrHg7cJ2Ud/6FQ/E7PLJqj1OANRhy5LU90CcoT2e/bA=;
	b=WkAlKuKrt752Czq3blOy83INdicN4PxXZdaXilhB4I+58aqqkIGZCXn+M35/axpDLbrKmk
	/NBoySqyMGdehY04V7/oL3/WtVCeAem0hVMjDK5s2gywtI4TMqxmxWRcmMeKSAEdfhugbn
	I+VVZyzOA95YrHO1SFK6B7v7fz/6P/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JrHg7cJ2Ud/6FQ/E7PLJqj1OANRhy5LU90CcoT2e/bA=;
	b=En2MZTEgiGet4f1TYSKrahpr/cLBtiRwr7cDSQUrNuzM5NDcqSG7+LSnKi5mwCGyK2pYak
	vg2ZzHTZ5bXascAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E8AA1373E;
	Mon,  4 Nov 2024 13:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pCtBCaHIKGeLZgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 04 Nov 2024 13:14:09 +0000
Date: Mon, 4 Nov 2024 14:14:06 +0100
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: [PATCH] perf/x86/amd/uncore: Avoid a false positive warning about
 snprintf truncation in amd_uncore_umc_ctx_init
Message-ID: <20241104141406.3fd11254@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 690DB21DB2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,endymion.delvare:mid];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Fix the following warning:
  CC [M]  arch/x86/events/amd/uncore.o
arch/x86/events/amd/uncore.c: In function =E2=80=98amd_uncore_umc_ctx_init=
=E2=80=99:
arch/x86/events/amd/uncore.c:951:52: warning: =E2=80=98%d=E2=80=99 directiv=
e output may be truncated writing between 1 and 10 bytes into a region of s=
ize 8 [-Wformat-truncation=3D]
    snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
                                                    ^~
arch/x86/events/amd/uncore.c:951:43: note: directive argument in the range =
[0, 2147483647]
    snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
                                           ^~~~~~~~~~~~
arch/x86/events/amd/uncore.c:951:4: note: =E2=80=98snprintf=E2=80=99 output=
 between 10 and 19 bytes into a destination of size 16
    snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As far as I can see, there can't be more than UNCORE_GROUP_MAX (256)
groups and each group can't have more than 255 PMU, so the number
printed by this %d can't exceed 65279, that's only 5 digits and would
fit into the buffer. So it's a false positive warning. But we can
make the compiler happy by declaring index as a 16-bit number.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
An alternative fix would be to extend UNCORE_NAME_LEN to 20, the
downside being an increased memory consumption. Depends whether we
expect UNCORE_GROUP_MAX to ever be increased, or groups to ever
support more than 255 PMU.

 arch/x86/events/amd/uncore.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-6.12-rc6.orig/arch/x86/events/amd/uncore.c
+++ linux-6.12-rc6/arch/x86/events/amd/uncore.c
@@ -916,7 +916,8 @@ int amd_uncore_umc_ctx_init(struct amd_u
 	u8 group_num_pmcs[UNCORE_GROUP_MAX] =3D { 0 };
 	union amd_uncore_info info;
 	struct amd_uncore_pmu *pmu;
-	int index =3D 0, gid, i;
+	int gid, i;
+	u16 index =3D 0;
=20
 	if (pmu_version < 2)
 		return 0;

--=20
Jean Delvare
SUSE L3 Support

