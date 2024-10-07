Return-Path: <linux-kernel+bounces-353146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BB992965
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF301F242F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384CB1C878E;
	Mon,  7 Oct 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uXtvUwVV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uXtvUwVV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555D14AD17
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297727; cv=none; b=ibmMMrTBTohEfGi4AqcmMQas6p20VCox5alAXBedWGoqLy/hQd48ZiBXtVeZdTPT5551I2U/bW3DfnHVF6v9+qfqeEEx8h5subuP6MRzOURAujengzkvdeg/aQLNH78qcup6qhGVBcdY0SS3g45vZ5DIbp8eqjoIOZvrmrm9GR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297727; c=relaxed/simple;
	bh=q2O1EWbb3H9OlvF18UvBExVCURf4mkffR8ncq7RjTQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l10C4GTCYRSNwTgL5JSwOkGkec8EXuuM8owPCngKM2iWVV/18B+ygL99r8d+aqt5kUY6b4fyDvuyKhwVL7aSZiJySL2N7JuNkP7yBW+FLhbBE/gHkOaTiw2ZOJG8UyXD7+Q65kpiFlREyVW/IASG+SLtXYLXSGRUZYt2prcUOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uXtvUwVV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uXtvUwVV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4C8C21C0F;
	Mon,  7 Oct 2024 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728297723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BD5PqP23e7/83Pok91rp0zgpvGvnOoNWAFujvQURO0Y=;
	b=uXtvUwVVTWamdCCB5gkbPQvkslxeS+AD8S+d35rK1j18gHSNdXkZbY6KSMibb5uqLZ77k9
	FN3V799o9L39Sf6Q/QXuu7pAmtrAnngIbO0BEn9k9X5vkbR5H65Vc/QMt8zqqBn7wmTMFq
	t8KIn7KNpc3beG5wxA+k1bmoVvOEWXA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uXtvUwVV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728297723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BD5PqP23e7/83Pok91rp0zgpvGvnOoNWAFujvQURO0Y=;
	b=uXtvUwVVTWamdCCB5gkbPQvkslxeS+AD8S+d35rK1j18gHSNdXkZbY6KSMibb5uqLZ77k9
	FN3V799o9L39Sf6Q/QXuu7pAmtrAnngIbO0BEn9k9X5vkbR5H65Vc/QMt8zqqBn7wmTMFq
	t8KIn7KNpc3beG5wxA+k1bmoVvOEWXA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C82D132BD;
	Mon,  7 Oct 2024 10:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kbxuGPu6A2fJLAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 07 Oct 2024 10:42:03 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org,
	Niels Dettenbach <nd@syndicat.com>
Subject: [PATCH] x86/xen: mark boot CPU of PV guest in MSR_IA32_APICBASE
Date: Mon,  7 Oct 2024 12:42:01 +0200
Message-ID: <20241007104201.15607-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4C8C21C0F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Recent topology checks of the x86 boot code uncovered the need for
PV guests to have the boot cpu marked in the APICBASE MSR.

Fixes: 9d22c96316ac ("x86/topology: Handle bogus ACPI tables correctly")
Reported-by: Niels Dettenbach <nd@syndicat.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 2c12ae42dc8b..d6818c6cafda 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1032,6 +1032,10 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 	switch (msr) {
 	case MSR_IA32_APICBASE:
 		val &= ~X2APIC_ENABLE;
+		if (smp_processor_id() == 0)
+			val |= MSR_IA32_APICBASE_BSP;
+		else
+			val &= ~MSR_IA32_APICBASE_BSP;
 		break;
 	}
 	return val;
-- 
2.43.0


