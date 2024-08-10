Return-Path: <linux-kernel+bounces-281777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06694DB32
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF591C2128D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97114A4F9;
	Sat, 10 Aug 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c868azLX"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79B3B782
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723274087; cv=none; b=bssJDPpvvoUyMsYyDENnX8zWdTH2boO8Fdosq/Zf5vGkK2ifPG0/nP2bYK+eL14D70TG8vfjOjEeDSapcBL9R195bJxCNlv1L/hOx93+9KaNs2LOcu7NugeMsqSFcrVqpY1+J1lypaigwwZdW9YIF3Ldq3rDEKhZ8k+/DNfEgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723274087; c=relaxed/simple;
	bh=2tS0eWCBDxDsUSBGp58+pIxhFuhjHlr+aBuREye6C0o=;
	h=To:Cc:Message-Id:From:Subject:Date; b=ULrnkEz0dQHjj8OSveDu1ru24RIK3BFvsG/4dYR5fl97KIhRpS0x4GAxMKm1+V43EQTPjTqV7sI7arALggtjybSg66Vj7fd5gOrJg+g2rxGg79S9m9iDagI8vfWEKWEmSWEocUBJrTCmgFVb4gvbEcRP7/gTrvKdXt5iVKvzzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c868azLX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 379BB1151DE1;
	Sat, 10 Aug 2024 03:14:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 10 Aug 2024 03:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723274084; x=1723360484; bh=pzWoJ6kpdS8AV
	2GwnkxogI+qF4smRK+n1tauPh28B5g=; b=c868azLXhPFjbtTy8JFTz45STXwir
	7oWG5Tk8J1gmexFRXp+AFmM3fB/Z13TJHNtqClyMM2oFPZ2yvCUM+xJYN7HJa1rl
	UlE3A22DmMtvjZYyECtFuAnAFQCPGor12T5neHKT0Am5Zl0oMB1otAk4IdyzFKp7
	ksFg0ybwnOhp3mkz8JHcmRP3+g91IXO4asaYMwxEJvdnDbj3sECHIdnqa2PfKnJ5
	J63QZZ7z/wSH1G+wlAj/3QbalpZXIO65L+0iH5V1PSGoIrvNynQKzYl+PeZJVOdp
	x2fqcYGTTihyh9zi3lDZdlPBM8dStUIJDfsLDJC2SB0o1RsfL7TMc8Pcg==
X-ME-Sender: <xms:YxO3ZvM8oBrRztxMPuuR1ni1DuDnU5YniRW3RVUbRAdC1oxfnWbQZQ>
    <xme:YxO3Zp9h9n5J4sOA9zrBHi3KOCJ_8TFL4b10g2yQAxUP5U42ypvmaw2RGrwzp8UDc
    fUtVifqZHeaf8JXE8A>
X-ME-Received: <xmr:YxO3ZuTCkEIEgdFTRtOdtFUnVZsw4etBsDH5t9Zh4SxH9qvO84HXhLKE5Uy1F-DotO_pv2S18HxiewPnoO1igPAnGJ_TgmfLxQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhm
    pefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqe
    enucggtffrrghtthgvrhhnpeffueeileegffegtdehveefkeffveffiedugeefveeuvdet
    tdefiefflefgteegueenucffohhmrghinhepuggvsghirghnrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhn
    uhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthht
    ohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgvrhhgsehlih
    hnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehushgvrhhmheejseihrghhohhordgt
    ohhmpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmie
    ekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:YxO3Zjs_zw0T1lHBEMWfDJ133rn9KVmCMztf3XK3ginS7dNKtbdtVA>
    <xmx:YxO3ZneytMSIo89NjdROVcZuSwYvYl0hDQIpc-XMdka-RNMQC7WU7g>
    <xmx:YxO3Zv2C4VF_ZAoICtLi_pIUIij5DcVfSR_5JsiEAlvM5Z5J9D5X4w>
    <xmx:YxO3Zj-ljRLitzyfu8BjB5ibykDxQLLhAqxj5YbL8vfx4h91fFsFAw>
    <xmx:ZBO3ZoF7ir5_fKnj-6OiX12mtjxL9Bf-U9KB2h7hUkHU19FAmh4tbTIg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Aug 2024 03:14:42 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christian Brauner <brauner@kernel.org>,
    Greg Ungerer <gerg@linux-m68k.org>,
    Stan Johnson <userm57@yahoo.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <ac8100050f448caa1dc46c131079e615e73021a4.1723273396.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Fix kernel_clone_args.flags in m68k_clone()
Date: Sat, 10 Aug 2024 17:03:16 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Stan Johnson recently reported a failure from the 'dump' command:

  DUMP: Date of this level 0 dump: Fri Aug  9 23:37:15 2024
  DUMP: Dumping /dev/sda (an unlisted file system) to /dev/null
  DUMP: Label: none
  DUMP: Writing 10 Kilobyte records
  DUMP: mapping (Pass I) [regular files]
  DUMP: mapping (Pass II) [directories]
  DUMP: estimated 3595695 blocks.
  DUMP: Context save fork fails in parent 671

The dump program uses the clone syscall with the CLONE_IO flag, that is,
flags == 0x80000000. When that value is cast from long int to u64 by
m68k_clone(), it undergoes sign-extension. The new value includes
CLONE_INTO_CGROUP so the validation in cgroup_css_set_fork() fails and
the syscall returns -EBADFD.

Avoid sign-extension by adopting the idiom used in kernel/fork.c when
casting clone flags.

Cc: Stan Johnson <userm57@yahoo.com>
Reported-by: Stan Johnson <userm57@yahoo.com>
Closes: https://lists.debian.org/debian-68k/2024/08/msg00000.html
Fixes: 6aabc1facdb2 ("m68k: Implement copy_thread_tls()")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 2584e94e2134..873dc94fdcd8 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -117,7 +117,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 {
 	/* regs will be equal to current_pt_regs() */
 	struct kernel_clone_args args = {
-		.flags		= regs->d1 & ~CSIGNAL,
+		.flags		= (lower_32_bits(regs->d1) & ~CSIGNAL),
 		.pidfd		= (int __user *)regs->d3,
 		.child_tid	= (int __user *)regs->d4,
 		.parent_tid	= (int __user *)regs->d3,
-- 
2.39.5


