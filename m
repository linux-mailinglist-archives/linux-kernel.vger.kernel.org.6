Return-Path: <linux-kernel+bounces-268283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332629422B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46A8285675
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023C1917C1;
	Tue, 30 Jul 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b="sVlb9nUq"
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A64157466;
	Tue, 30 Jul 2024 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378076; cv=none; b=k4mkhF2uI/pR9qfUu9889O8lnMsTyBF6UbjKjRa8KkGBWNK1hdKCyQiThmv+vUiZ/reH/BL4lG4tPnuNL4zGbpHYIASjhbUo/MTu6XiLWJt2OfPRE3UxX7rYiBmO7gZGb6NHRkd6ekVhTfuB3kK6Is6li64b7FmA+n3Y3YzW7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378076; c=relaxed/simple;
	bh=IBY9niT3crChkL57i2tqKYDFZoHdqXWz0t4ljNwbLrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxJo7fokmHfOXXyiuloMYifUhCdBA4092P4t5tk0wqFQY9Ka0pGbqBhuH90UL24oOeYMm/Vg7+GrbVbrw940cNQF9ChYJVmYiHO2/PKbQI5RiLSq/rHwSNGSHTFmURT3+QUaMx0D6sAQgrQnj4vci6bQ947r38hK7ULgsG49rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn; spf=pass smtp.mailfrom=whu.edu.cn; dkim=fail (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b=sVlb9nUq reason="key not found in DNS"; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whu.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=JLqJc
	6R1ahX/CN5dyLs8cECox0Rx+KE2rkJzMprmvtI=; b=sVlb9nUqZ9YRy2/cPQcpP
	r+VmKV2zgaKIfS+BU4iX68cyUZ5Hw2CgHnPcgkkROzfjal7HiBCQrK0bVIklopiQ
	zPba+yd7KKKfah+8y67T4+2FnmVDrqkCWlclim1OTE4YTq1vwFxr+1BxRoAK36rb
	1y0vsAvRuheuxb2lo7mR+U=
Received: from whu.edu.cn (unknown [10.1.14.8])
	by app1 (Coremail) with SMTP id Bg4BCgAnACZOZ6lmc4bOAA--.29964S2;
	Wed, 31 Jul 2024 06:21:02 +0800 (CST)
Received: from zehuixu-vmwarevirtualplatform.localdomain (unknown [82.130.46.207])
	by mtasvr (Coremail) with SMTP id _____wB3Q_VIZ6lmkd4JAA--.480S2;
	Wed, 31 Jul 2024 06:21:01 +0800 (CST)
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
Subject: [PATCH] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
Date: Wed, 31 Jul 2024 01:20:53 +0300
Message-ID: <20240730222053.37066-1-zehuixu@whu.edu.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Bg4BCgAnACZOZ6lmc4bOAA--.29964S2
Authentication-Results: app1; spf=neutral smtp.mail=zehuixu@whu.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13Gw47KF4rGw4kGw1xKrg_yoW8Wry7pa
	sYkr4xCa1DGr4vkrs7Cr4fXay0934Sqa1UuFyjgw1rZrZxKF92krWxKry5GrW2yr1furWa
	vrnrKFy3tF1UA3DanT9S1TB71UUUU1JqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUtV
	W8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GF4lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r4xMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I
	0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IUjKLvtUUUUU==
X-CM-SenderInfo: qsqrmjqqqqijqqxyq4lkxovvfxof0/1tbiAgYOA2apDkcEwwAAsI

GCC recently added the -fmin-function-alignment option, which will appear in GCC 14. However, this flag can cause issues when passed to the Rust Makefile and affect the bindgen process. Bindgen relies on libclang to parse C code, and currently does not support the -fmin-function-alignment flag, leading to compilation failures when GCC 14 is used.

This patch addresses the issue by adding -fmin-function-alignment to the bindgen_skip_c_flags in rust/Makefile, ensuring it is skipped during the bindgen process. This prevents the flag from causing compilation issues and maintains compatibility with the upcoming GCC 14.

This is my first patch to the kernel, if there are any issues or improvements needed, please let me know. ;)

Reference:
https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@suse.com/

Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
---
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
-- 
2.45.2


