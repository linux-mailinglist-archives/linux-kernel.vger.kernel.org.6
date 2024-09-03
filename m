Return-Path: <linux-kernel+bounces-312985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7359969EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF01F24E16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31711A7274;
	Tue,  3 Sep 2024 13:08:09 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57831A726B;
	Tue,  3 Sep 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368889; cv=none; b=oWKG3xgK+DqMbaSb8AV1SPGKpZpTVcHZ3/8Hf7gYRlzuLNvF2DBtDZh8cE5vLV9FGEfOLL0d5BJvrYbBwCZ0CNmwgomD/L2FCDNTC56J4tRjIkVE7CHKbXRT0RPJp/qHEHg7OKJCKcSNERSeWvzkZl8Hdbwg14LYKMQnDwW/0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368889; c=relaxed/simple;
	bh=u9CwxNkvI3ZJBQnFwfURgj9YQRiyEmNKrwNWOOWYoJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQBKu4WpbUf7M1WXz8q4GYt+oFzx8/fT1JbL7BrOOdoWYhtxT9xxahm3Zc7jgo89iU+DJTYPciHE37QYFPInC4YtY+ADpmt2pjh7sIL79i3IlbzK9/JQwcS5CinBQ9moF4Qmuzi2pN+QhLK0jlKRm1k8CwVdu452pscnUjDsX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iorw.io; spf=none smtp.mailfrom=iorw.io; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iorw.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iorw.io
X-QQ-mid: bizesmtp88t1725368790tz166xl2
X-QQ-Originating-IP: 5Ox9MZOpB4HGff4JCHX+EhqYhjuTtoZvUONrgWtGZ5o=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Sep 2024 21:06:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5789562387442949554
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
Subject: [PATCH 1/2] rust: arch/um: use 'static' relocation model for uml modules
Date: Tue,  3 Sep 2024 21:06:05 +0800
Message-ID: <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io>
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

In the x86_64 UML, kernel modules compiled with Rust will currently
generate some R_X86_64_GOTPCREL relocations, which will then be rejected
by the kernel.

And because of the kernel modules of UML are only got handled by the UML
itself, relocation model 'static' can work as expected other than 'pie'.
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 00b63bac5eff..b04b1d4d6dfe 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -63,7 +63,7 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
 
-KBUILD_RUSTFLAGS += -Crelocation-model=pie
+KBUILD_RUSTFLAGS_KERNEL += -Crelocation-model=pie
 
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
-- 
2.46.0


