Return-Path: <linux-kernel+bounces-574699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B9A6E8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB6F1896AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEB1A5BA8;
	Tue, 25 Mar 2025 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooFJ2Q67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8D1FDD;
	Tue, 25 Mar 2025 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872988; cv=none; b=AYUmFM8EJt0H0l0d7Ydp8BkTDXp/OM3J0Ec1wdS89bWvWtr/QIgg1HuWnKAmOFKYVEyterqHTnsQGxAp3gio7rUFNukCreeoWt5kOYujUDHxwVUGZ7e2uc9NalZ9/dAu9tvRHdRaL0bBOA+iXFH8d/UlVe7xEbOCTuzbOCwtqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872988; c=relaxed/simple;
	bh=B5CgC8k+ueVLbr3bDHXKKpwXdQGUkovCwBBrpjyzWUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eEixY6b5idgi+MwbDThk9+nRkRoJ3tRkXCXGdwxHpJRoNYY9G1FaRt705xOKdWixIW6iBmRFrYRQ5JXuOQIRiemZ1/fF6N1ORx8JwS2WQMCH5I68+LtUiqnLmW+NfauMZ66lYtQyRr3dwApKutOTsa3n6Rtw3aNqc4/jME1irAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooFJ2Q67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AFFC4CEE9;
	Tue, 25 Mar 2025 03:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872988;
	bh=B5CgC8k+ueVLbr3bDHXKKpwXdQGUkovCwBBrpjyzWUA=;
	h=From:Date:Subject:To:Cc:From;
	b=ooFJ2Q67kbdBSmW/v/YQ/aS2T0IPwN7RTFZ/VUw/TkYuNp1tag/+U2XZ9dO1dVGcS
	 COMqqPodrEd+eL/IMPjwTmZZydkI2hx54iir4fcqig91lOAATTA6VmF9KBu22FDmLH
	 Sq0mPMZm0GS/yST0xr5skh5Bk6Sm7VCq0iJaLAQ8leiuRhiYl4EscWAa9yjhoqpZyb
	 1khkmEJ9duDXZMS23R7UqlbNTYdlvmsAeU7X8AUp+MHqaDPyMpakOaH3pGx8OpAA4/
	 otx/bQ74NfYZ9kFZW3Py/X9VqO63ZLHyQcEcW4gbl7i2iiJbipYfoEH1t2pJys6V7+
	 Jo8Jg0qb521YQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 24 Mar 2025 20:23:00 -0700
Subject: [PATCH] x86/kbuild/64: Restrict clang versions that can use
 '-march=native'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-x86-march-native-clang-19-and-newer-v1-1-3a05ed32a89e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJMh4mcC/x2N0QqDMAwAf0XyvIBmreh+ZfjQtdkMuGykooL47
 xYfD467HTKbcIZHtYPxIll+WqC5VRDHoB9GSYWBavL1nRxuXYvfYHFEDbMsjHEqGjY9Bk2ovLI
 hOfKp8+T41UMp/Y3fsl2X53AcJ9T21pd1AAAA
X-Change-ID: 20250324-x86-march-native-clang-19-and-newer-2425d8524eb9
To: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, Tor Vic <torvic9@mailbox.org>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2832; i=nathan@kernel.org;
 h=from:subject:message-id; bh=B5CgC8k+ueVLbr3bDHXKKpwXdQGUkovCwBBrpjyzWUA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmPFGdVWufEby7Kbd8/+Xb1GUVBjzPuDgt0HLkT9I9e/
 HP7pnxmRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIVFFGhrNrJ816kC3q+2GP
 Q1WNv1OXfpFWmo1xIr/6QYH/9lOnXGb4Xz2JPbt77XLX/tCUb1fbQmX+vTuzYvoLobZ5WiI/itN
 3MwMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

There are two issues that can appear when building with clang and
'-march=native'.

The first issue is a compiler crash in the ipv6 stack with clang-18,
such as when building allmodconfig. This was frequently reported on the
LLVM issue tracker [1].

  Stack dump:
  0.      Program arguments: clang ... -march=native ... net/ipv6/ip6_input.c
  1.      <eof> parser at end of file
  2.      Code generation
  3.      Running pass 'Function Pass Manager' on module 'net/ipv6/ip6_input.c'.
  4.      Running pass 'X86 DAG->DAG Instruction Selection' on function '@ip6_rcv_core'

The second issue is certain -Wframe-larger-than warnings that appear
with clang versions prior to 19, which introduced an optimization that
produces much better code [2].

clang-18:

  drivers/media/pci/saa7164/saa7164-core.c:605:20: error: stack frame size (2392) exceeds limit (2048) in 'saa7164_irq' [-Werror,-Wframe-larger-than]
    605 | static irqreturn_t saa7164_irq(int irq, void *dev_id)
        |                    ^

clang-19:

  drivers/media/pci/saa7164/saa7164-core.c:605:20: error: stack frame size (216) exceeds limit (128) in 'saa7164_irq' [-Werror,-Wframe-larger-than]
    605 | static irqreturn_t saa7164_irq(int irq, void *dev_id)
        |                    ^

Restrict the testing of the availability of '-march=native' to all
supported GCC versions and clang-19 and newer to avoid these known
resolved issues.

Fixes: 0480bc7e65dc ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Link: https://github.com/llvm/llvm-project/issues?q=is%3Aissue%20ip6_rcv_core [1]
Link: https://github.com/llvm/llvm-project/commit/90ba33099cbb17e7c159e9ebc5a512037db99d6d [2]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig.cpu | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 87bede96e800..f928cf6e3252 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -248,6 +248,12 @@ endchoice
 config CC_HAS_MARCH_NATIVE
 	# This flag might not be available in cross-compilers:
 	def_bool $(cc-option, -march=native)
+	# LLVM 18 has an easily triggered internal compiler error in core
+	# networking code with '-march=native' on certain systems:
+	# https://github.com/llvm/llvm-project/issues/72026
+	# LLVM 19 introduces an optimization that resolves some high stack
+	# usage warnings that only appear wth '-march=native'.
+	depends on CC_IS_GCC || CLANG_VERSION >= 190100
 
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"

---
base-commit: 7c241e07bddf9300af40c0dd44367a83df633f35
change-id: 20250324-x86-march-native-clang-19-and-newer-2425d8524eb9

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


