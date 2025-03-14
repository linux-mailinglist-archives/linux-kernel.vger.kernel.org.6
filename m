Return-Path: <linux-kernel+bounces-561067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84553A60D35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715D419C1221
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77C1EEA5D;
	Fri, 14 Mar 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b9kg9Eou";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7mxcR2c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b9kg9Eou";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7mxcR2c"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28F1EEA2A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944339; cv=none; b=BDl+CjrywfDq1y0IwbgvOioU8WNdxmKW6UiNpADlYDmaXQnOcZ+UOETDa4yPGFTByFxdEtlJtsgkOV0O9drEOFE0nPEP47flRF54UZS/VybBYrVx1GjIwpyXNcZXyPbab/P7yONzB/Y81ukOAOyGzs6FX77cHHQ36thObWxyGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944339; c=relaxed/simple;
	bh=5ZsmaxJhr/V+579363Xlhk2wdnVfWqhybz2vgd3iu+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh5BaxS76KT0ehPQgjRep+JHW81Pl8g/+Fe3CtVrNmDYdrXUlQ5HlhULIZlMv0+EMft8brip/J8eVGfLP72v/O9XF3pDnyNTjP7FXLZS5sNw2bTCPQcC31K9S+0Y8S74bgCDZKcpAoozZPy6rCgU5YDHhMc6yclcf4z4InOOGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b9kg9Eou; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7mxcR2c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b9kg9Eou; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7mxcR2c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out2.suse.de (Postfix) with ESMTP id E4D6D1F388;
	Fri, 14 Mar 2025 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741944336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmaj98J/fxkfgoUEV6gT/fCczi5L/Uyg0IXGLFH63V0=;
	b=b9kg9Eou7sCDQ/zMFDOXv2H8frkSr3cznK8uO1q2nlfJ1MgNxEMIbULLgTEF/eRko5Uvnv
	OQEF3kV9QxJcUihfWAjzyHHtsgeD7MSdAmF+HPkt9ZMXRHE9J+13AtLPFO8ILNvlbwMAh0
	gsr2QI9XLrCao3MIBWnUjjX8eV1Ue0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741944336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmaj98J/fxkfgoUEV6gT/fCczi5L/Uyg0IXGLFH63V0=;
	b=t7mxcR2c1iON3DvFhhP1If79mdaLUE48gbYj39tjy2K4g2QGidh1bGc08oHM2aGlOa1EVw
	j13KQvs+dBPrNlBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741944336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmaj98J/fxkfgoUEV6gT/fCczi5L/Uyg0IXGLFH63V0=;
	b=b9kg9Eou7sCDQ/zMFDOXv2H8frkSr3cznK8uO1q2nlfJ1MgNxEMIbULLgTEF/eRko5Uvnv
	OQEF3kV9QxJcUihfWAjzyHHtsgeD7MSdAmF+HPkt9ZMXRHE9J+13AtLPFO8ILNvlbwMAh0
	gsr2QI9XLrCao3MIBWnUjjX8eV1Ue0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741944336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmaj98J/fxkfgoUEV6gT/fCczi5L/Uyg0IXGLFH63V0=;
	b=t7mxcR2c1iON3DvFhhP1If79mdaLUE48gbYj39tjy2K4g2QGidh1bGc08oHM2aGlOa1EVw
	j13KQvs+dBPrNlBA==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	"Nysal Jan K.A." <nysal@linux.ibm.com>
Subject: [PATCH v2] powerpc/boot: Fix build with gcc 15
Date: Fri, 14 Mar 2025 10:25:23 +0100
Message-ID: <20250314092528.15506-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z86liwlwP5WvrEkw@kitsune.suse.cz>
References: <Z86liwlwP5WvrEkw@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,fjasle.eu,google.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Similar to x86 the ppc boot code does not build with GCC 15.

Copy the fix from
commit ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Move the fix outside of ifdef to apply to all subarchitectures
---
 arch/powerpc/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1ff6ad4f6cd2..210c60d3d4cc 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -32,6 +32,8 @@ else
     BOOTAR := $(AR)
 endif
 
+BOOTTARGETFLAGS	+= -std=gnu11
+
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTTARGETFLAGS	+= -m64
 BOOTTARGETFLAGS	+= -mabi=elfv2
-- 
2.47.1


