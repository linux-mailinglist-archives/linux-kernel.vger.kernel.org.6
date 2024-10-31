Return-Path: <linux-kernel+bounces-391152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A974D9B8342
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E109281247
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D331CBE86;
	Thu, 31 Oct 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAotM7qd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB021CB50D;
	Thu, 31 Oct 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402505; cv=none; b=PY42mS2EibO2OCKTw0XKwiVv9Eg2ONQ9Z/DRQlkEXurzsIusUMNgvf0TAeYmFP++kRqFhvH26SyN4pMsTKp1VtPZwoPQcJntWThVSOqc9H/UXRFv3Lw2IZ09dzK54ujxLMF/Gqm3463LcHjsnKfuMERSmZpbvg2uS2oL+n03oMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402505; c=relaxed/simple;
	bh=0ZSgsybRkNgA//hqHaFbgWNG+1PnzRnJxZ3UfA4h9Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=baj/cIlTsE3+H0jT3h9LQrr7BeBMrYUtsmOHzq4yX+9I98SLUz6lzMDcbxSGRHLUb5DMtA3bQ/4ih6iWsYjGHbywS9JEoDlQJfIIpIZFXq2v35x3p9aAdkN58Wb7iwJ/f58+RMg435LMvo5DD4adLi1Cu8ocZs7QfP4vq7hEISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAotM7qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D72CC4CED3;
	Thu, 31 Oct 2024 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402504;
	bh=0ZSgsybRkNgA//hqHaFbgWNG+1PnzRnJxZ3UfA4h9Rs=;
	h=From:Date:Subject:To:Cc:From;
	b=jAotM7qdJB81uguvOPNpxfpjVngo51BMHoiWwhXcNwIr86J2udKL3utXN7I8nPX9D
	 0i5FNYPAvnweqqvT0bm0XYe1PtZ4mKOgF9eoqRskXUjc/MV0MJOAxvbjx8vDBLL7P1
	 IznFmDgKZJ7m4+clMiJKYbYRyJU4OKXSAaSTe6KFtu/wypGH16NGKR5dtJ8HUyWrwK
	 hP1l9PZWShs9wx8rvpOQOXdW8JG7Xn42JrzsKZWz6Qs/Eue1hHS889sSa5NlOJYFPo
	 bqg91tOQdWR2/9gmviQwUdmeISpwPXAxxQ35CttsiqQfOsDQ8Q+NPVHYR5rKsPIGtb
	 UOSjGJZfOXQSg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Oct 2024 19:21:38 +0000
Subject: [PATCH] arm64/gcs: Fix outdated ptrace documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-arm64-gcs-doc-disable-v1-1-d7f6ded62046@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMHYI2cC/x3MwQqDMAyA4VeRnA0krp2wVxkeahtdwLWjARHEd
 1/x+B3+/wSTqmLw6k6osqtpyQ3cdxA/Ia+CmpphoMExPRhD/T4drtEwlYhJLcyboDiKxOz9SAK
 t/VVZ9Li/7+m6/vrBbvZnAAAA
X-Change-ID: 20241031-arm64-gcs-doc-disable-e40c0115570e
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0ZSgsybRkNgA//hqHaFbgWNG+1PnzRnJxZ3UfA4h9Rs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnI9jG+FCHClvg5NARf9CZ3l7Gnyt4LVv9jrok91J5
 qnOg2QOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyPYxgAKCRAk1otyXVSH0GolB/
 9x7Rxxvu35bazi1kYivVoC5b5L6KYYjB5ulPK+yCDLHX1M2g2elshC33kBGGBQfzRF3JggFfO+88p8
 n20h9PE6vHwLrVDuNFBtsQrhgsVJ/rw+HfLsPeYmQCRljuCtnUUcmGX23ZtPv6h3rfIYE2WJh+lqlj
 vZWgVQyxmUNdT+moVsN+2SRNllvrhzUVbob4Z2ynSYARcreMguOwoOJ3tGLUAYLxNjshJuKLVF/DcL
 88+iglT8m6AMP5OQN0oWaVN14FBlUNvt8uL3JSwQaMEtO2wfKYq+r4HpnjmXb23NY7hbmSWihugV69
 twT6cz31E1oSFzQJj4edC/qPaQK0Rz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ptrace documentation for GCS was written prior to the implementation of
clone3() when we still blocked enabling of GCS via ptrace. This restriction
was relaxed as part of implementing clone3() support since we implemented
support for the GCS not being managed by the kernel but the documentation
still mentions the restriction. Update the documentation to reflect what
was merged.

We have not yet merged clone3() itself but all the support other than in
clone() itself is there.

Fixes: 7058bf87cd59 ("arm64/gcs: Document the ABI for Guarded Control Stacks")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/gcs.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/arm64/gcs.rst b/Documentation/arch/arm64/gcs.rst
index af58d9151cb72df9058ddccadb2602127b479c95..1f65a3193e7765dce9bfd6ad88b9fbd6a225ed86 100644
--- a/Documentation/arch/arm64/gcs.rst
+++ b/Documentation/arch/arm64/gcs.rst
@@ -204,11 +204,8 @@ When returning from a signal handler:
 * A new regset NT_ARM_GCS is defined for use with PTRACE_GETREGSET and
   PTRACE_SETREGSET.
 
-* Due to the complexity surrounding allocation and deallocation of stacks and
-  lack of practical application it is not possible to enable GCS via ptrace.
-  GCS may be disabled via the ptrace interface.
-
-* Other GCS modes may be configured via ptrace.
+* The GCS mode, including enable and disable, may be configured via ptrace.
+  If GCS is enabled via ptrace no new GCS will be allocated for the thread.
 
 * Configuration via ptrace ignores locking of GCS mode bits.
 

---
base-commit: 9b9be78258511e67767e4aa51f587cf22feb5065
change-id: 20241031-arm64-gcs-doc-disable-e40c0115570e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


