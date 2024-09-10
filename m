Return-Path: <linux-kernel+bounces-322882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C49731F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC56B28D6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0E192D7A;
	Tue, 10 Sep 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NbGIlpkm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TdneqX7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCCD14D431
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963132; cv=none; b=MUERv7b33l/IXhWFY7/MLWcWa2Q7XA8HyJyUXpzfoLlMDIej/cwiV1qnQs8a/6UCwSJy9smAb8uIYotmX/3xd1FSkfcXM2NVBdxgnsA+UR68VO5GsZ1PsHwNkJDiHTcaWq1Xw0PzzetAlyeDpOqgMNdPZjb6DbK3lCa7vvQZWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963132; c=relaxed/simple;
	bh=9m5IjxKoPD6XiedqdwCbhDSCNLIFmi0zHPZF5KqAlok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=brsi7+0Apv63IX2nnmOXEQ9jsIpRtVB5Hjyx7i9Stz1LyF7NxQ1xGR53wWYxCn8pU8rdnRi8+oTwxGzY07FmPsJGkr7rKFkNOp7EeDq3wMphvpW7zQLQg+ynGDlIyxfjXUwhEV+c/lItTdCz4u9kY9GVOzY8VMBUHYLcLpO7gx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NbGIlpkm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TdneqX7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725963129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+v4fTa9/h5xHAdpjSadO0s8xEcUKuA4Aml4c3MVzfM4=;
	b=NbGIlpkmAiR/+yxCb8BC72vUNpt683PFKZDY7xStfB1bahNnkR+srROKcakMxGIYGg7nmH
	GiG550Uud+0koXBo0Oyh+lDpGZmKX3JChBxSpZRZe3aYJ2fIWg5rKLFXFT/TsEcFECClBc
	Io1gYQ3SU9/BGYSRkBlhUsoBM8mCUK0Jf+Ez0kOTRDUQWIyeOT+ZG2SOG0BP5iIUJQGySk
	uHvynKiyp+e+3Zred5VOmte69h952+bO+ilxD+6QSjDbs+UDUO+/cmu0HFD80gkTON/DS4
	78o3PjtmJq0oNpvnZB8NfVxtmJVhGuHF1n0AAmhROcGnKnKweprxsQ4cnym0pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725963129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+v4fTa9/h5xHAdpjSadO0s8xEcUKuA4Aml4c3MVzfM4=;
	b=8TdneqX7paMLLLwKZf8dBKcprudADTwCZwO8AbfI5c/gyjpl+fW65jpISsSwvWCG03Gozy
	yKOqo0J1gq3iupBA==
Subject: [PATCH 0/2] x86: vdso: Two small ifdef cleanups
Date: Tue, 10 Sep 2024 12:11:34 +0200
Message-Id: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYb4GYC/x3MPQ6EIBBA4auYqXcSJP7AXmVjoTDoNGKYjdEY7
 i5afsV7FwglJoFvdUGinYXjWlB/KnDLuM6E7ItBK90oqywepsPdS0QOngLqyY+2dcYZ20OJtkS
 Bj3f4G4oXln9M5/PPOd9AY7yJbwAAAA==
To: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725963129; l=701;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9m5IjxKoPD6XiedqdwCbhDSCNLIFmi0zHPZF5KqAlok=;
 b=ER0ODrl2RB5LAORwjcZpwLRjtlMxxrDlPviyKfH6ZuE2VVgmJkIY9CCu9QOiSkflbsK1kdAEv
 iX9/F6ZbxThCalkgcIK3iJpbJg7R3k5FeIH54Os3c725e5f7mWyOIPk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some small non-functional cleanups to make the vdso setup easier to
read.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      x86: vdso: Remove ifdeffery around page setup variants
      x86: vdso: Remove redundant ifdeffery around in_ia32_syscall()

 arch/x86/entry/vdso/vma.c   | 35 ++++++++++++-----------------------
 arch/x86/include/asm/elf.h  |  4 ----
 arch/x86/include/asm/vdso.h |  8 --------
 3 files changed, 12 insertions(+), 35 deletions(-)
---
base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
change-id: 20240909-x86-vdso-ifdef-2bda95c8c897

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


