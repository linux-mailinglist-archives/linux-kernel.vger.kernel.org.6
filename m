Return-Path: <linux-kernel+bounces-422376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D49D98D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C100D162792
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D671D54CB;
	Tue, 26 Nov 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FHmUu+o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32/x3/cD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB11D5169
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628854; cv=none; b=pXUY9adZm7J09jDXgxS9mRCjZf3n+vOi8QCg3qK6dgnWtthkYxup38HMzaYAn1If3jKx7SWkEl5mO6W/TOuygDXgMt2HRC/461IcgwgY4nS9YOrSy18lc45A3VVpfKE4l/EISn+6vInWH9cPhQp0sMNikp1m9t8V3jzwQ89YgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628854; c=relaxed/simple;
	bh=gwrmaCTUtXsmRl3WbdCiEpFpKkDZMJE2/lTzDvAP83I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WM2Lo9neKbaKIod/33WjdwY8YEDZg2VvERzSQ/GjfRcD7smgOwS3OxHXGgZOSakhdXUVPexNP/hTveS7hoyzeHEuZh/60zPLuJQZ6d6qiYHh8zJ2BDnZHdTGhRLRWIc+lXlW7p0dNprYBrb2f/XdkZukgKZ3v89m8lrbo1zGrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FHmUu+o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32/x3/cD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732628849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRp8+EyAb5VfurGneR/dmqwkiaLgGf4J4Z1pubo3vro=;
	b=4FHmUu+o4mRy6G6J4YEPIDsKt57DJoR1MfHU+VkJCGirjki7msXoazMIoiDavPD0oqpBUX
	EX81V4o+rrUh7sHnNzf+0d6dghDIbIy0XPRG8Xkto/IzfQ1Lv2u9ElCPcM1+jnrjn1DZfJ
	pGGBRcg1+sGsKyYZXOIfJyt830OV8+FvGpQ/Kw7En3UJu9yXutzKcVqOkXLCHkpcAh0hs9
	c1gxeIOF5CDBf1xzJDmvDABfkaMfrzWWQo4w1R7TNWScwE9tCKIKhouAbGKZYLMZqVPk6A
	3am80I/yfsm1FZP0TdZ+z+M8B2b7ZPk8b6Pp8WkcaSx3/wGZAkoII6zuHOOxiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732628849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRp8+EyAb5VfurGneR/dmqwkiaLgGf4J4Z1pubo3vro=;
	b=32/x3/cDPJeLNQvqgRMiAvcvXErgxtfynnAozFo4ToR4jF7CMhoJ35vWN29KAu8ZFyZNSo
	lYcOX3cB6kcfZKDg==
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86/CPU/AMD: Terminate the erratum_1386_microcode array.
Date: Tue, 26 Nov 2024 14:47:22 +0100
Message-ID: <20241126134722.480975-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The erratum_1386_microcode array requires an empty entry at the end.
Otherwise x86_match_cpu_with_stepping() will continue iterrate the array
after it ended.

Add an empty entry to erratum_1386_microcode to its end.

Fixes: 29ba89f189528 ("x86/CPU/AMD: Improve the erratum 1386 workaround")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 823f44f7bc946..d8408aafeed98 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -798,6 +798,7 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 static const struct x86_cpu_desc erratum_1386_microcode[] =3D {
 	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
 	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
+	{},
 };
=20
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
--=20
2.45.2


