Return-Path: <linux-kernel+bounces-396134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797DC9BC85B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF5DB22231
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4251CEADD;
	Tue,  5 Nov 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FraONsYj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7fjqsD4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FraONsYj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7fjqsD4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF31C1738
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796781; cv=none; b=mN5GOT+plYNV82cLGFj+vjplrtSf+6lux8hOa7rnPHCI9/DPnj5wOuA3NE3C0nNNAqR7ICRTEq8ufPbebXsIh6kPkzdEQWhv/14RGdGPUpfKqNqHniL6LIHlVTI1w50CEjC5fqGm6fws8Z2tJPWP2QvLZtWbV+UeMpJjg9BkBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796781; c=relaxed/simple;
	bh=jEI/Sjm4Rs3/2LnDD/N2aLo9wxH3cqCmYFCry2MViP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VFrYpVjAOYEmvZhA78fId9SfnwKF5CCmTx++oX0K58mp+FXv7TKL4DgOywJlj+7ylT1ej86ZE0NE2KJQH+O3kjEL1aAbzkFg9qCKy/cRIMfBRVjtYRClh3zAZqNuiaSq9IUm2E1T7qqfwEmp03DRNHDN2kImU6g7SUhw8kEd+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FraONsYj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7fjqsD4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FraONsYj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7fjqsD4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3E7F1F833;
	Tue,  5 Nov 2024 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730796777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LUM478KzVIHLcpIL4jhs6GAcn7kWqyYTe5aM5si1AJc=;
	b=FraONsYjpKFwfAQJHrNEPpAmA1uWcJHC96MgjM2rcRBpsZXUsFxogYFuIXwxJzTArP/h2b
	cF++4tcwtlqpNZxB0z5MSJvJ3ri3LHaMUX2X3ECaHQGVnHNRvQ1w7k5yUsagJ57tsyN9vq
	ICQ9zOLzD6zB4Z2A7rOpnqhMXwJ6vXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730796777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LUM478KzVIHLcpIL4jhs6GAcn7kWqyYTe5aM5si1AJc=;
	b=g7fjqsD4ympj+MosF6wB3N3MPN3rwElcHze0yDFIsBy0IQ5856oz0iyMZQTpdV+hyxTmit
	m4LsqA61yXF85kCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FraONsYj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g7fjqsD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730796777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LUM478KzVIHLcpIL4jhs6GAcn7kWqyYTe5aM5si1AJc=;
	b=FraONsYjpKFwfAQJHrNEPpAmA1uWcJHC96MgjM2rcRBpsZXUsFxogYFuIXwxJzTArP/h2b
	cF++4tcwtlqpNZxB0z5MSJvJ3ri3LHaMUX2X3ECaHQGVnHNRvQ1w7k5yUsagJ57tsyN9vq
	ICQ9zOLzD6zB4Z2A7rOpnqhMXwJ6vXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730796777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LUM478KzVIHLcpIL4jhs6GAcn7kWqyYTe5aM5si1AJc=;
	b=g7fjqsD4ympj+MosF6wB3N3MPN3rwElcHze0yDFIsBy0IQ5856oz0iyMZQTpdV+hyxTmit
	m4LsqA61yXF85kCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7217F1394A;
	Tue,  5 Nov 2024 08:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hvpNGencKWcJMgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 05 Nov 2024 08:52:57 +0000
Date: Tue, 5 Nov 2024 09:52:53 +0100
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>, Peter Zijlstra 
 <peterz@infradead.org>
Subject: [PATCH v2] perf/x86/amd/uncore: Avoid a false positive warning
 about snprintf truncation in amd_uncore_umc_ctx_init
Message-ID: <20241105095253.18f34b4d@endymion.delvare>
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
X-Rspamd-Queue-Id: A3E7F1F833
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
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
Changes in v2:
 * Use the proper printf conversion specifier, to be on the safe side.

An alternative fix would be to extend UNCORE_NAME_LEN to 20, the
downside being an increased memory consumption. Depends whether we
expect UNCORE_GROUP_MAX to ever be increased, or groups to ever
support more than 255 PMU.

 arch/x86/events/amd/uncore.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
@@ -948,7 +949,7 @@ int amd_uncore_umc_ctx_init(struct amd_u
 	for_each_set_bit(gid, gmask, UNCORE_GROUP_MAX) {
 		for (i =3D 0; i < group_num_pmus[gid]; i++) {
 			pmu =3D &uncore->pmus[index];
-			snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
+			snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%hu", index);
 			pmu->num_counters =3D group_num_pmcs[gid] / group_num_pmus[gid];
 			pmu->msr_base =3D MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
 			pmu->rdpmc_base =3D -1;


--=20
Jean Delvare
SUSE L3 Support

