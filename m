Return-Path: <linux-kernel+bounces-412418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976409D08D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28518B22242
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B213CA8A;
	Mon, 18 Nov 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SC/iYJx+"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AE13A863
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907596; cv=none; b=tEDy45MfndOvIBdEAHMVexBdQN1aOX30eou7Oym1uYtqYSDcpVNsVhRYwFwYGIl8GLmMa3Wg4AX7Yl30B0Y8JOMim5gCqShGHDJmbYrilDJaV37Z2ubVYfG96RcXNXTQCrBphNoD4Aq1wndkIs0XMyPzzfEhOs5g819viCj98r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907596; c=relaxed/simple;
	bh=PBw+2l4k/U/8zjU5cemT5owgK8Rdjbs+7eB+L9/Ycbc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=oDG5TiVXA5bYpuoaoVRrE30iJ4aug+FvCESIALAT7YaQpA001HoKBGwtJtoyDqeYJFb0xImUb9AkvLLNsnIqa6u/m6b9Ba+qEhN8KoAbSPQQ/pCfmjuDAv8wnq3yYOgE7hfGUcZVJQpr+8TLHpbw6CAMUnRaPDzOoUznyaA+qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SC/iYJx+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A45A82540099;
	Mon, 18 Nov 2024 00:26:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 00:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731907593; x=1731993993; bh=r29dMPQRv+Gn3SilhPT9HklbBYac
	hEKIULVz8FVwt98=; b=SC/iYJx+sKpMleDE+xAoZhBhE/3Mnusj5JjlquJ2nNxo
	aGdk/YyMFID9FPszZaZWI/7PnZUG+23PMAjhoZR2UOGeothdF0YOG6dou44ab2NH
	1CbaLvGoxA0jIPF/SZ0+FPHkfkZmy6XRElfDwR+QKJ+3mWMCP6+x2Vz017uEp7Lz
	J8grHWFPTNbE4ypPMs1U7oCQ3FsKBl3J1X56L7wTo7uXG4J4TMn/rNJSLDX26qmJ
	P06+A9u1+nE1dfMp9j0387k+tAhTwuUmWs+ejw4sJBnxzFnYDhfApwKwkB/Ef37F
	TDGIDsxh8O6suOhaBhn0Ziec0a0wWrW+37eM3wQu2g==
X-ME-Sender: <xms:CdA6ZzwpsTcUiNLU2Ah7gf5v1jYFrpd0EA8OT3UlSG6TgbbJy0zSuQ>
    <xme:CdA6Z7SSwDQiDk4rGGw5FzuH811YOY1AXV-MiApsGj8Ise-gtbkXwnR_0qay_xfPS
    HoRaZrybo7mM_Wtank>
X-ME-Received: <xmr:CdA6Z9WGHMd0RNRJpqLudIoPl5pjdY58QlRH9vnxJ9ZgxMpu84DCY5lmRL7oaVMxbdtBCQARlPTLZrqn7jPjz1drDOlXDTWoQvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnhepheetuddufffgfeekkeejudeivdfgfedtleetkeduleekueef
    hfevueekkeeftdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvghnthhrhidrsh
    gsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhht
    hhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhope
    hvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhu
    gidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CdA6Z9gyiK-uybv89e-UnMjKKSyShYW8bYHHkMfhUl9kFSs-LarbjA>
    <xmx:CdA6Z1B6D4ZmtrCmJ3rbM3TRO3-Edt6Vt2W4a-X1DL-jhYTbDPH6Ug>
    <xmx:CdA6Z2KQIZ_54T-8Q4lWF41eMV9dVohLksLxjF9k5NsuzI1aS2Miwg>
    <xmx:CdA6Z0AX-HGbl7K8IvhikAPzOARtzXXA-GNj_q6F9i6nzS3HNCxoiQ>
    <xmx:CdA6Zw9OnTiTE3LwE-DMvPIeLtuahOJb0GjVFAfhBFVvmr48RU8hLhXs>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:26:31 -0500 (EST)
Date: Mon, 18 Nov 2024 16:27:03 +1100
Message-ID: <8ed2db60211f05173e66de2b084dc3f7@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.4.y] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 50e43a57334400668952f8e551c9d87d3ed2dfef ]

We get there when sigreturn has performed obscene acts on kernel stack;
in particular, the location of pt_regs has shifted.  We are about to call
syscall_trace(), which might stop for tracer.  If that happens, we'd better
have task_pt_regs() returning correct result...

Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: bd6f56a75bb2 ("m68k: Missing syscall_trace() on sigreturn")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 417d8f0e8962..0d03b4f2077b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -182,6 +182,8 @@ ENTRY(ret_from_signal)
 	movel	%curptr@(TASK_STACK),%a1
 	tstb	%a1@(TINFO_FLAGS+2)
 	jge	1f
+	lea	%sp@(SWITCH_STACK_SIZE),%a1
+	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
 	addql	#4,%sp

