Return-Path: <linux-kernel+bounces-524666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B07A3E59A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB06E188DAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E802638AA;
	Thu, 20 Feb 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRJ0XVxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B11E5B6C;
	Thu, 20 Feb 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082113; cv=none; b=YWO+1dXmI569bxpIxW2hLGFqkRGzAGFPBHbWACNlt/YK80uVtUAele4rTwq7E2sFR/YQi6eN9dLEiHvYj9J4WFP/JlW5QdREBBxSTBDpe1DApaiJgZ+C8nR2clu+XTQLBlRuIVH1nBb2lq5ZfP+RzGNHcj5HZFKeBSMEHkZydwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082113; c=relaxed/simple;
	bh=lPBiKxjuC256MMVQZ8f6blsgV1GTsYOZHt3/gF8LqGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jtCZbfE+x/FBIRChS8X7H+JBL8AJNgWTgj0mza54n/rorJiLIUgYFXRIMPEtP3DQ6AOVvj0/BUxJzCurEAmFuYmByKZrC70Nz6iZU+c85vVCyNS5GmGwxZ6qIyG1s/qPMXI0OvfptDewcxBbQyIxfSM2L7/YSsQXEqaiJQyj8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRJ0XVxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EB8C4CED6;
	Thu, 20 Feb 2025 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740082112;
	bh=lPBiKxjuC256MMVQZ8f6blsgV1GTsYOZHt3/gF8LqGw=;
	h=From:Date:Subject:To:Cc:From;
	b=PRJ0XVxggujyxnrHni2FyRl0rpTgCiuhKaJcrFgqGDAxA4aIrr6GWBhGsGE2k1SIm
	 AFvJMUe9AFBcuoBNcuCwxM1V0UBubEmtN+yjbU86a6EFwFLYJB9lGr/4N9aLKmA0at
	 EndEl55FmUhLnkU63vtpHMvhWvVv186OBeBpRlHmivnt4yneXbVlEJEtc2RtCOFaKM
	 +t/fvXMK6pLrky8LhCGN42fxUrWc8XrusaA4uDlfuOuL4pprojPgy6Eay0z50geQlj
	 cBBPYa1+uqLO0vJTwZ3aXRioaj5/xInTXecazKi/dN3YRlhaKllqgt57vV0/yhLrGn
	 O7d0YuPk0QqVA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 20 Feb 2025 13:08:12 -0700
Subject: [PATCH] x86/build: Raise the minimum LLVM version to 15.0.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKuLt2cC/x3MSwqEMAwA0KtI1hOo8TM6VxEXfqKGsbW0KgXx7
 haXb/Mu8OyEPfySCxyf4mUzEekngWHpzMwoYzSQokIRKQxVif2hLWoxuK6nxmlz6Pdu+FusOSu
 qsc+/JRPEwjqeJLx90973Aw51aWNuAAAA
X-Change-ID: 20250220-x86-bump-min-llvm-for-stackp-9e358db476e2
To: Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lPBiKxjuC256MMVQZ8f6blsgV1GTsYOZHt3/gF8LqGw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOnbu/et1pTZcGijnav8PTX2pkOuXafjbrkWP3nm7Ms8+
 S7XmQyvjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRPUEM/5Svc22+NqEv9Uqg
 l2HozrV+4f8+1UxwijqlFCXsUVxRN52RYUr5lQWvFb2fBItemfJ+u4S7TpDQ/5KKyNS0oOnh3KL
 b2AE=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

In a similar vein as commit a3e8fe814ad1 ("x86/build: Raise the minimum
GCC version to 8.1"), bump the minimum supported version of LLVM for
building x86 kernels to 15.0.0, as that is the first version that has
support for '-mstack-protector-guard-symbol', which is used
unconditionally after commit 80d47defddc0 ("x86/stackprotector/64:
Convert to normal per-CPU variable"):

  clang-14: error: unknown argument: '-mstack-protector-guard-symbol=__ref_stack_chk_guard'

Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU variable")
Link: https://github.com/llvm/llvm-project/commit/efbaad1c4a526e91b034e56386e98a9268cd87b2
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/min-tool-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 06c4e410ecab..787868183b84 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -26,7 +26,7 @@ gcc)
 	fi
 	;;
 llvm)
-	if [ "$SRCARCH" = s390 ]; then
+	if [ "$SRCARCH" = s390 -o "$SRCARCH" = x86 ]; then
 		echo 15.0.0
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0

---
base-commit: 929ce2d9f919967fe8edf7e840165e43612c2576
change-id: 20250220-x86-bump-min-llvm-for-stackp-9e358db476e2

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


