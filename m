Return-Path: <linux-kernel+bounces-398673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C69BF481
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DD8B242E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E899207215;
	Wed,  6 Nov 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp0JQOxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D916B391;
	Wed,  6 Nov 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915120; cv=none; b=QwdyvJPg0dbcp1yv5dUTWlwMcJmJy/nZFtiTccaCYincwzgpfUsWMgNJ+ODE/0GZ9zU7iCAZyMXHIuZWDYdJZDkz50m70mWTQUpgtONLUi8cX5hDv8JnbfLrfb1c7hzOr0f9sJNrAL/4yMWo8GpsiAcJWpBrtur1yoAwEjC6PzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915120; c=relaxed/simple;
	bh=4hI5vTzKe6h+64EipIsPRN3WM31BsmB5rIzxFxXmrcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fWWMwsFqrX6GUvsdV6N+mSclwj0JpTohZwgG5iblES7W7DOIB+kg2KhVfSmhcrJFfuoBfB0SzlN78YqD2MTFFa5Wexw6YGUkl8F+TPnCoq/OHKQ177wrYoXpXy8w0cXhXug8600C4EPqOKxeZINrt0ofGmPt79Kwfmv2fF80zB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp0JQOxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175A9C4CEC6;
	Wed,  6 Nov 2024 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730915119;
	bh=4hI5vTzKe6h+64EipIsPRN3WM31BsmB5rIzxFxXmrcM=;
	h=From:Date:Subject:To:Cc:From;
	b=Xp0JQOxUM8tiNHv49Avg3KvXMij3Sz2uB58vmTu3GzENRfQOCbJYBy6ysQKXd3Qle
	 jQRh+1Z1YUu+T/2CcaM6kxUX6vfCLUeueasQfhJfgilu9xDA4IKdcoXkNVc5xKty1M
	 9xoNw35t4CL/6GTn5W8yI7COeD29SI4xOuXUwVTeqz7ok6vptiv5XfsVVjRFFIMtt/
	 G1HBNz606HZDHoD65bG3Ef6xaXoSsuG0bd6flZ8ZRnZiElCo1GP+gE5aHEbXCVZoCl
	 XA6XuTdmMx1Qg+XYIgMFPBFV8GMxOVlpi957pZJ90ygOIKaawKKidSvOYorJb/eiqi
	 I1oRHCYKrxhvA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Nov 2024 17:41:32 +0000
Subject: [PATCH] arm64/ptrace: Clarify documentation of VL configuration
 via ptrace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-arm64-sve-ptrace-vl-set-v1-1-3b164e8b559c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEuqK2cC/x3MQQqDQAxG4atI1g0Yq0J7FelinPnVQKuSyFAQ7
 96hy2/x3kkOUzg9q5MMWV23tUBuFcUlrDNYUzE1ddOK1MLBPn3LnsH7YSGC85sdB6exuyOkcYo
 PoVLvhkm///Pwuq4f56rUi2kAAAA=
X-Change-ID: 20241101-arm64-sve-ptrace-vl-set-db53eadbfc91
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3892; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4hI5vTzKe6h+64EipIsPRN3WM31BsmB5rIzxFxXmrcM=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnTt1dpJH/3n8YT2XzdrO2/A3byD0Texw26xadTGysIvYsVh
 WfqdjMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBEiuPY//ueOuCV5+JTZrr8aujm+l
 3My8o+OBYxzAmQtdD0v1ju3zBxik4Z19afp6vPLpdfYXIxMyZGW7aH61zmAdHLEiv15DIaQuRuxUrY
 TfoqvtAg6lLCw4DTObcqj7DxWD6Y3f+9ukVAWcPm4PNe3Y/uhiejWwTS39x75PBLor/jfOBy3VvXIl
 7E3Sy3NWfzCOWe8GjB/O1ZBtaK/02S1V+uWmBaoR7xe37lGpVrDyaV8nw/W8tV1CG3couguXiNytuN
 gdGNf868WK8bu05N1rU+KMa/4dHDZ/xTpzyu5zTgf9h7J/zVtiUv/n7/n5QdKsB/68ivKN/+ZrGSl5
 wVP+T+a39nWS6Tnna7csrlqBQFAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we configure SVE, SSVE or ZA via ptrace we allow the user to configure
the vector length and specify any of the flags that are accepted when
configuring via prctl(). This includes the S[VM]E_SET_VL_ONEXEC flag which
defers the configuration of the VL until an exec(). We don't do anything to
limit the provision of register data as part of configuring the _ONEXEC VL
but as a function of the VL enumeration support we do this will be
interpreted using the vector length currently configured for the process.

This is all a bit surprising, and probably we should just not have allowed
register data to be specified with _ONEXEC, but it's our ABI so let's
add some explicit documentation in both the ABI documents and the source
calling out what happens.

The comments are also missing the fact that since SME does not have a
mandatory 128 bit VL it is possible for VL enumeration to result in the
configuration of a higher VL than was requested, cover that too.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sme.rst |  4 ++++
 Documentation/arch/arm64/sve.rst |  4 ++++
 arch/arm64/kernel/ptrace.c       | 12 ++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
index be317d457417434c24811edce3ef2bad88f2cace..b2fa01f85cb5e33350c59f752aba9248e4fbd80e 100644
--- a/Documentation/arch/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -346,6 +346,10 @@ The regset data starts with struct user_za_header, containing:
 
 * Writes to NT_ARM_ZT will set PSTATE.ZA to 1.
 
+* If any register data is provided along with SME_PT_VL_ONEXEC then the
+  registers data will be interpreted with the current vector length, not
+  the vector length configured for use on exec.
+
 
 8.  ELF coredump extensions
 ---------------------------
diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
index 8d8837fc39ec71414a72dfef9e834f0800106fdd..28152492c29cbc7a81165a367e87d4aa327690f4 100644
--- a/Documentation/arch/arm64/sve.rst
+++ b/Documentation/arch/arm64/sve.rst
@@ -402,6 +402,10 @@ The regset data starts with struct user_sve_header, containing:
   streaming mode and any SETREGSET of NT_ARM_SSVE will enter streaming mode
   if the target was not in streaming mode.
 
+* If any register data is provided along with SVE_PT_VL_ONEXEC then the
+  registers data will be interpreted with the current vector length, not
+  the vector length configured for use on exec.
+
 * The effect of writing a partial, incomplete payload is unspecified.
 
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b756578aeaeea1d3250276734520e3eaae8a671d..f09ffd70c9166aeb306376a34316499010376044 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -898,7 +898,11 @@ static int sve_set_common(struct task_struct *target,
 	if (ret)
 		goto out;
 
-	/* Actual VL set may be less than the user asked for: */
+	/*
+	 * Actual VL set may be different from what the user asked
+	 * for, or we may have configured the _ONEXEC VL not the
+	 * current VL:
+	 */
 	vq = sve_vq_from_vl(task_get_vl(target, type));
 
 	/* Enter/exit streaming mode */
@@ -1125,7 +1129,11 @@ static int za_set(struct task_struct *target,
 	if (ret)
 		goto out;
 
-	/* Actual VL set may be less than the user asked for: */
+	/*
+	 * Actual VL set may be different from what the user asked
+	 * for, or we may have configured the _ONEXEC rather than
+	 * current VL:
+	 */
 	vq = sve_vq_from_vl(task_get_sme_vl(target));
 
 	/* Ensure there is some SVE storage for streaming mode */

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241101-arm64-sve-ptrace-vl-set-db53eadbfc91

Best regards,
-- 
Mark Brown <broonie@kernel.org>


