Return-Path: <linux-kernel+bounces-268479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70CA942522
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701851F233CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243341B7F4;
	Wed, 31 Jul 2024 03:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b="rElqWGJ6"
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148FD1758E;
	Wed, 31 Jul 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397300; cv=none; b=KCiKvhy+qWafv7tNUKHlYjyXwV6mlEesv78YekpRlEqNbUP4Wb/ryJx5/GJx+AtRdUoPkdtl1tw/OCgwGkTgw60aTl3g2LHHae8ZfR129cO1UC9xxejZMW4A8Y93iqKigGJTxxOana+rFfrJFq5BPypWIqVcwpT9+RxBesQFpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397300; c=relaxed/simple;
	bh=lzjZl/VOtHSlkY6zSysCMvp6XITg7Ealf7nsFzpcTJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svds+SmspTcw7UhdHAtr0kEG5lPIIyo6Kf8Ik+lKoB+7+Lww4Na2vGFy2NdqSMPQzHcnAN7oSXpZI2gzZFSiSXWsUtii8uy3eoJDBNWd3KhSSZutvqlm2cabBYtn+6jAEhWqhcJO2hxiUNj7nNwFGxIY5MK7cJMucnGcB7zjMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn; spf=pass smtp.mailfrom=whu.edu.cn; dkim=fail (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b=rElqWGJ6 reason="key not found in DNS"; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whu.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=SGe0w
	04NrXG0POhBZ8e5VOKgXrrmS/WG4AesW9zLv6Y=; b=rElqWGJ6oq+T2wCXIeCCf
	hQXQJePwhAE6rBQ6DdlXDYBPFGtCmj/QJYmpvRmOHA6hxF+XE9Xrf9uNxcdnztN/
	jydEVZrNb7reAJjFdMYwZyQJWrQEWkqCdYVZv8EMO4qwMQ1m1Nl22t/QZEgVqIzY
	3fkjNoPPRcQOGd8qfa7v6I=
Received: from whu.edu.cn (unknown [10.1.14.8])
	by app2 (Coremail) with SMTP id Bw4BCgB3bhRlsqlmFs8SAA--.53786S2;
	Wed, 31 Jul 2024 11:41:25 +0800 (CST)
Received: from zehuixu-vmwarevirtualplatform.localdomain (unknown [82.130.46.207])
	by mtasvr (Coremail) with SMTP id _____wAn1MNbsqlm6GcLAA--.3583S2;
	Wed, 31 Jul 2024 11:41:20 +0800 (CST)
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
Subject: [PATCH v2] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
Date: Wed, 31 Jul 2024 06:41:12 +0300
Message-ID: <20240731034112.6060-1-zehuixu@whu.edu.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Bw4BCgB3bhRlsqlmFs8SAA--.53786S2
Authentication-Results: app2; spf=neutral smtp.mail=zehuixu@whu.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4kXr17WF1kZFWxKr43trb_yoWrXr4kpa
	9Y9F9rGr4UJFWktws2yw4rJayava1rKF1UCr1q9w18urWDAFyvkrWI9F15K347Gr1fCFy2
	vF429Fy5Kr1UC37anT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jw
	0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4xMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8CwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07
	C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jMXd8UUUUU=
X-CM-SenderInfo: qsqrmjqqqqijqqxyq4lkxovvfxof0/1tbiAQcPA2apDkwYeAABsm

GCC 14 recently added the -fmin-function-alignment option and the
root Makefile uses it to replace -falign-functions when available.
However, this flag can cause issues when passed to the Rust
Makefile and affect the bindgen process. Bindgen relies on
libclang to parse C code, and currently does not support the
-fmin-function-alignment flag, leading to compilation failures
when GCC 14 is used.

This patch addresses the issue by adding -fmin-function-alignment
to the bindgen_skip_c_flags in rust/Makefile. This prevents the
flag from causing compilation issues and maintains compatibility.

In addition, since -falign-functions is not used when
-fmin-function-alignment is available but skipped and libclang
supports -falign-functions, this patch adds it back to the
bindgen_extra_c_flags to ensure the intended function alignment
is maintained.

Link: https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@suse.com/
Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
---
Hello again!

This is the second version of my patch. I discovered some issues right after
sending the email. Since this is my first kernel patch, I was too excited.
I will be more careful and calm during my checks next time. Compared to the
first patch, this version includes not only changes to the format of the
commit message (thanks to Miguel Ojeda for the patient guidance) but also
some code changes.

While preparing the second version of the patch, I realized that the root
Makefile replaces -falign-functions with -fmin-function-alignment, and if we
simply skip we'll lose this config. To ensure consistency, I added it back in
bindgen_extra_c_flags. Though I am uncertain if this is a good approach.

Looking for suggestions and thank you all for your time!

v1:
* https://lore.kernel.org/all/20240730222053.37066-1-zehuixu@whu.edu.cn/

v2:
* Added -falign-functions to bindgen_extra_c_flags when skipping 
  -fmin-function-alignment to maintain function alignment settings in GCC 14
* Used reasonable length to wrap commit messages
* Moved email content out of the commit message
* Used the "Link" tag instead of "Reference:" and removed empty lines between tags
* Specified the base commit

 rust/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 1f10f92737f2..bb21e74abd87 100644
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
@@ -254,6 +254,16 @@ bindgen_extra_c_flags += -enable-trivial-auto-var-init-zero-knowing-it-will-be-r
 endif
 endif
 
+# Starting from GCC 14, the root Makefile uses -fmin-function-alignment to replace
+# -falign-functions, which libclang doesn't support. We skipped
+# -fmin-function-alignment in bindgen_skip_c_flags, resulting in missing
+# compilation flags. Therefore we add -falign-functions in bindgen_extra_c_flags
+# to fall back and complete the alignment settings.
+# https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@suse.com/
+ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
+bindgen_extra_c_flags += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
+endif
+
 bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
 	$(bindgen_extra_c_flags)
 endif

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.45.2


