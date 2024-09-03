Return-Path: <linux-kernel+bounces-312986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A4969EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A341F24DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D91C242A;
	Tue,  3 Sep 2024 13:08:12 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018241A724C;
	Tue,  3 Sep 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368891; cv=none; b=IYFbgjfs0E/V9losBhKX6lsAqmGw3veRFA9AoeytL/8+u1Gc8E9ViWyTIuOpbjrhkF3bebiJcjaXRu1UcYjsEAKCw1UId5Hf/42daBJNVC8EUOiKe62GchYC9qdwNHPj5KJpFeEQPqTCRH6WRfd8sZMNfmm49xMtq/SZEbPw68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368891; c=relaxed/simple;
	bh=KHxS+RzsYQVUstki9O9G2Fth9NOTM3+FP0WNjRpmWGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGFrB5if3PLFA9Il9Y0nMqQjTYKqn4wr9d1IEvgneGCtxb6kcJ54EUUjaL8H3MjuoJEB4jMLlILkrJz7vOgjF9pVqWnLtbjdyphlgGC3hzIemYE2tVAtlGI4ixrjHxkXIrZo9d4Q7M0PcK4YBefqU1tHTbdA8aGQcWNleuERD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iorw.io; spf=none smtp.mailfrom=iorw.io; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iorw.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iorw.io
X-QQ-mid: bizesmtp88t1725368797tvffge9y
X-QQ-Originating-IP: IniwHKqgiTyeNYqQCtQD+YECBJEHxDU1F/TeNYWWD5k=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Sep 2024 21:06:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14936481488341771613
From: Zigit Zo <zig@iorw.io>
To: ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	gary@garyguo.net
Cc: zig@iorw.io,
	rust-for-linux@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: arch/um: use 'large' code model for uml
Date: Tue,  3 Sep 2024 21:06:06 +0800
Message-ID: <54FC087D02C52990+20240903130606.292935-3-zig@iorw.io>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903130606.292935-1-zig@iorw.io>
References: <20240903130606.292935-1-zig@iorw.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:iorw.io:qybglogicsvrgz:qybglogicsvrgz8a-1

The Rust modules compiled against UML should be 'large', without this
the compiler will generate some R_X86_64_32S relocations, but UML is
running at userspace with signed-address larger than zero, therefore
makes '__write_relocate_add' treating the relocation as overflowed.
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index b04b1d4d6dfe..c2a9f2102ba7 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -32,6 +32,7 @@ endif
 
 ifdef CONFIG_64BIT
 	KBUILD_CFLAGS += -mcmodel=large
+	KBUILD_RUSTFLAGS += -Ccode-model=large
 endif
 
 HOST_DIR := arch/$(HEADER_ARCH)
-- 
2.46.0


