Return-Path: <linux-kernel+bounces-269706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E289435FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29734B24E80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE24EB5E;
	Wed, 31 Jul 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0qL0Ogw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C1E14F9F4;
	Wed, 31 Jul 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452363; cv=none; b=dsDo2Sa7oOSoFAeHq55ESkbCtZvktGWmCxN7Ex90gC/HYe2NdR0UdSFd86u1eVBJX+AeyyU3ihZbYy7DUUSeZDd7brXaElIJ1VFDjTou97XkuJBnjVoiepsCVnY81H1tXcVM8OoY3DU2E29OAymApGSZrFyzhCdeBLGuRJS8bYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452363; c=relaxed/simple;
	bh=D1SKn5zDUad8T7fVsAtfQDtAE7+9Q9bJUWeW7NKX3PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6oglkzu4pUIVzccj+MqwHmmjQbJFQoi3N/vEq8WGbdP5Pysm4P6UGkyGUWRRmowBVuS1l8AmgINtDPeGjUyyfjH+qJGnDMO50lreNePP94PXz+E1fd8VYVgZ9jfyPSo2uXmXJ3k21vw4rgv8bu0v0Bpmd2AljlRbfchTrma2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0qL0Ogw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09AEC4AF10;
	Wed, 31 Jul 2024 18:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722452363;
	bh=D1SKn5zDUad8T7fVsAtfQDtAE7+9Q9bJUWeW7NKX3PU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B0qL0OgwBkTw/11CjRtPe7lABacGq+Nc1+ru4CS7zzz8j2RpYMFmdp6VcUZilzedk
	 AzDInJuMRgAGxbbsvW8Ld2zX7MTfMf9QsrrNn2muf20GGpB1AdI8w2d/peeHtsFONA
	 V00PrRGhQoxhIWvEBlj21QEOThBR1WxcX+CTaMgxCA9dKQPC9vCFTjz0Ota4o9QRPD
	 VRfxQRsbGaYK/955AFfFpnKexiFqIr/gRa6fPnhwSBrwWfLH+AiqPo0POaQIrDORQp
	 MUFpP2GwyOn1O/3dnvsiXOCRUb5Dd0oD9UJqnvHOxeF15BAUyxXfLk5bdnl+/ZAbf6
	 cnJDqtxLdjmqA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 19:58:38 +0100
Subject: [PATCH 2/2] KVM: arm64: Clarify meaning of _MASK and _nMASK for
 FGT registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-kvm-arm64-fgt-doc-v1-2-abb364f8fe57@kernel.org>
References: <20240731-kvm-arm64-fgt-doc-v1-0-abb364f8fe57@kernel.org>
In-Reply-To: <20240731-kvm-arm64-fgt-doc-v1-0-abb364f8fe57@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Fuad Tabba <tabba@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D1SKn5zDUad8T7fVsAtfQDtAE7+9Q9bJUWeW7NKX3PU=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrRVnU1eRZ/vFpwzi/Q2mtfjLsIi7fnm9ifeNw6L50w5+STy
 gsH/TkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIm+S2P+ns+i9Trj/OzvfYcraR8
 uN85U/2F/8lnTF2DJs4vVqlRkrwvgWpIdI1XkK6IX3JT8Ou15noPb5rPOproeZ6tp6craLVtiEm9av
 Zlu4SuuOHDtj9oOgpdoOTRu9cjnCnxV4hbzOfM/89VHvrPOrGf+n1ti1PVq6plfs27wsk4IFZ41mC6
 gc/ZNn9Wbh1LY9y20qA/foxE+yqsjhu8h6u+Jt8VrRLyrih2/7ijv3nDWXrdnTzOysMctQKubaWjbL
 2yHmCgcVV2o0Jc9s1U3KOp6ntTbsa7CJgN3NeNer2jc8y669OP/As6TzzIbvFVV8mj4OeafjZWtf3N
 As9/i1TF6JLSnqbhr/HQbl1fWPAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since the use of _MASK to mean bits where setting the bit causes traps to
be generated is a little unusual add a clarifying comment.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d347483395b4..1d8745740fb1 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -343,6 +343,10 @@
  * FGT register definitions
  *
  * RES0 and polarity masks for the FGT registers.
+ *
+ * _RES0:  Bits which are RES0
+ * _MASK:  Bits which enable traps when set
+ * _nMASK: Bits which disable traps when set
  */
 #define __HFGRTR_EL2_RES0	HFGxTR_EL2_RES0
 #define __HFGRTR_EL2_MASK	GENMASK(49, 0)

-- 
2.39.2


