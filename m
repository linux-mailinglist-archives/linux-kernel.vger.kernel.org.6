Return-Path: <linux-kernel+bounces-331482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5997AD60
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615AA284CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F078185E6A;
	Tue, 17 Sep 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0OvTIsN6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HbGI2XGA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE917C9A7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563261; cv=none; b=Tk3qzdd3RB1jLOOKLyKO7RHUr14/pRDoU6D8jiMj8Pusbrpcm14AkgWY5j/h91ssRJLczGTN9jeV1MoJeJHqjK2q9vRmSSLkjMN0JGWYWduNsaPg1LP5P54tfbjZzPe2yUNZ1MXIF1veB7sl4Z3fb/JwKQZkXcmzoMecwkcOTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563261; c=relaxed/simple;
	bh=pzUSAh18AYqBCbwjh/GN//mecRt+OLohH4hWsziwYYo=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=YfL+Z2xaTCl0YiymfKlvw2JlPvfblRo7aB3RaxchreTnt3Z74+ZKE//oawQRo6+4vw/JDtW4eGMrIsn0Vp6BxEhrBk3RzhhZmi68REEMANj58/qWmFUuHw0mBOOkEIbrlTQksaQWn70sVPsFbS7bm6zNWhYLhAd1G9yAiB2dDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0OvTIsN6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HbGI2XGA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=Os8LXJnGsjKqBulp/VpRnhys0IdyT2Lfigxu/T0oo94=;
	b=0OvTIsN6qJadph1vnXc2WEoPjWPvx34UHORXxcacE/fuKiOEyjcJn8hXZWDx2ACnz0GhPZ
	EbTb7f/oFM8GFIiBlFhM10j7GPZucowypB9Xggtj+yOdIgXYO5l19O1jg0w3f/q/Pm8H3N
	/2lvZwmU3nfmH74jQHrblsWhL51tOrlMUozUGusMJoPlh7L3rvSkctXeSt1M3zVCkTmFWM
	ta0gqMxBEG7zn0xCOvdT+/COtdVhWlQXjYL2VNAWh9Xs87KN9O7MJaI01QZCDx4iE4LGbD
	QaUX7eMX9Mdr5fE8vuuJrrrrmHnXUULpSSit9lCqiQLVL2HFst6i1ZjQgWAWdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=Os8LXJnGsjKqBulp/VpRnhys0IdyT2Lfigxu/T0oo94=;
	b=HbGI2XGA+FAcXxYgumsb3fFXfPN+dZxdIR5DmLOCR+qj3Vqjglf3Ct8F0wGIGuZuQOa/hB
	+zrEqphxirePXiCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/platform for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656199380.2471820.14920924502861484723.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:17 +0200 (CEST)

Linus,

please pull the latest x86/platform branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-202=
4-09-17

up to:  22f426972655: x86/platform/uv: Remove unused declaration uv_irq_2_mmr=
_info()

Remove a stale declaration from the UV platform code

Thanks,

	tglx

------------------>
Yue Haibing (1):
      x86/platform/uv: Remove unused declaration uv_irq_2_mmr_info()


 arch/x86/include/asm/uv/uv_irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv_irq.h b/arch/x86/include/asm/uv/uv_ir=
q.h
index d6b17c760622..1876b5edd142 100644
--- a/arch/x86/include/asm/uv/uv_irq.h
+++ b/arch/x86/include/asm/uv/uv_irq.h
@@ -31,7 +31,6 @@ enum {
 	UV_AFFINITY_CPU
 };
=20
-extern int uv_irq_2_mmr_info(int, unsigned long *, int *);
 extern int uv_setup_irq(char *, int, int, unsigned long, int);
 extern void uv_teardown_irq(unsigned int);
=20


