Return-Path: <linux-kernel+bounces-269300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED9943132
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEA82816CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E71B29A9;
	Wed, 31 Jul 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b="bWkuyoKK"
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6531AD3EA;
	Wed, 31 Jul 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433528; cv=none; b=itEemG9/g+Q80/vMELjdBo4zv70B51iuAWQJXjqkFKwOEBgWmh+nT5EWb0pnFpOqwtBQk/pBBL9GuAPy5u3eQSvkBSVxZ/umHYdf5UdY+JOoBCm/LYJiupBjn2mVDDy6w0xwWUkCKB44rdspKDv39pZPTgidJF/1l2PcrHM8Xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433528; c=relaxed/simple;
	bh=vEzDWAaQFISxk2MVHPNVs7Hdqh8O2hvbSqPnbnv0k8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izchG4POVpJ8mam47likuh4i9tpWgYxoEof2x+5/ZjDy4dibnxFs3HwpBWkMoWC083E1l2AlKKVoYdgTlmZ53Dkz0BEbKG6w2Q59wrlKtwM9+vusQYtVinqH5BBYJWc7B4pfunezO+i36M+LJs9dMh60ptfvyNTXqVHvi05FvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn; spf=pass smtp.mailfrom=whu.edu.cn; dkim=fail (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b=bWkuyoKK reason="key not found in DNS"; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whu.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=gynHM
	f4s1+VR8dld2tFPa35dOzHpxTGWHOttfWgBivE=; b=bWkuyoKKwCjAyq6+dMdaY
	kZ1X5xbIhJYwH/4maoBpbhamvO36WNlBPCrPvedhIhnIaw6GlB/zpL9WnfSdajZ6
	DWLs0/TosiBIf2EE14bj2mn6RYd6ybgcbtyZ1Hx6n8295NtgrGy7/U7B6S1AcrHA
	zilaHc9iwzr0JBhEPFQciQ=
Received: from whu.edu.cn (unknown [10.1.14.8])
	by app2 (Coremail) with SMTP id Bw4BCgA3LxXrP6pmM_ITAA--.56813S2;
	Wed, 31 Jul 2024 21:45:15 +0800 (CST)
Received: from zehuixu-vmwarevirtualplatform.localdomain (unknown [82.130.46.207])
	by mtasvr (Coremail) with SMTP id _____wBHal_jP6pmCXYOAA--.4925S2;
	Wed, 31 Jul 2024 21:45:13 +0800 (CST)
From: Zehui Xu <zehuixu@whu.edu.cn>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zehuixu@whu.edu.cn
Subject: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
Date: Wed, 31 Jul 2024 16:43:46 +0300
Message-ID: <20240731134346.10630-1-zehuixu@whu.edu.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Bw4BCgA3LxXrP6pmM_ITAA--.56813S2
Authentication-Results: app2; spf=neutral smtp.mail=zehuixu@whu.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8KFyfGF43Xry3Cr4kJFb_yoW8Kr18pa
	sYkFy3GayDGFWkKrs2yw4fXayj934Yqa1Uur1jgw18urZrtF1v9rZ2kF15A343Jr1rCFW5
	ZanF9Fy3tFyUA37anT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8CwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_GF4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2
	xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IUba9aDUUUUU==
X-CM-SenderInfo: qsqrmjqqqqijqqxyq4lkxovvfxof0/1tbiAQcPA2apDkw-KwAAsT

GCC 14 recently added -fmin-function-alignment option and the
root Makefile uses it to replace -falign-functions when available.
However, this flag can cause issues when passed to the Rust
Makefile and affect the bindgen process. Bindgen relies on
libclang to parse C code, and currently does not support the
-fmin-function-alignment flag, leading to compilation failures
when GCC 14 is used.

This patch addresses the issue by adding -fmin-function-alignment
to the bindgen_skip_c_flags in rust/Makefile. This prevents the
flag from causing compilation issues.

Link: https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@suse.com/
Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
---
Since -falign-functions does not affect bindgen output, we do not
need logic to add it back to the flags. Thanks to the community's
help, especially Miguel Ojeda. Hope this patch is free of problems
and can be submitted smoothly : )

v1:
* https://lore.kernel.org/all/20240730222053.37066-1-zehuixu@whu.edu.cn/

v2:
* Added -falign-functions to bindgen_extra_c_flags when skipping 
  -fmin-function-alignment to maintain function alignment settings in GCC 14
* Used reasonable length and moved email content out of the commit message
* Used "Link" tag instead of "Reference:" and removed empty lines between tags
* Specified the base commit
* https://lore.kernel.org/all/20240731034112.6060-1-zehuixu@whu.edu.cn/

v3:
* Removed logic from patch v2 which adds -falign-functions

 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 1f10f92737f2..0c8736cce64f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -227,7 +227,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
-	-fstrict-flex-arrays=% \
+	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.45.2


