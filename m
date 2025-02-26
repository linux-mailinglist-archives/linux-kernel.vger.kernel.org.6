Return-Path: <linux-kernel+bounces-534992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB2A46DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA21188ABD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B63262819;
	Wed, 26 Feb 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0e3TEVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCD261571
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605870; cv=none; b=Mhy9u+ow9enAQqQxwFZ7ZoeA4azVpWYYIyge/PcbK1XtbQ9DbfBVZnQKq10D8gG113BMyrB/aJWb2ulSOZJVviwNUNPSH+PB/jOjjn3+x6BzJU0fg3eGYjI+vsUYHaPfPkWQcuKoR0makEVCGNrbfRad/5RNFMHnhyLA4tHwsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605870; c=relaxed/simple;
	bh=nfF50qU0K8TasWt7EehLA/reFwMuJ1HxCQcE1bCyR+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmZi2xNTIBTuIO8TerG7Ym+9QuhPte4azp5HlMIKq3Mom9D1Ob0qvZiiCLDCcUxJuaMmXrK0+ejyOYwl72rd27fyIp+NRsIewg/NlKPbqLt3GqBdkhu9btlNI4WVz3owS6qqlyzyuKe/e9DLFpt6a3KlpL2bYWFHrPd8p2qhZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0e3TEVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67E5C4CED6;
	Wed, 26 Feb 2025 21:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605869;
	bh=nfF50qU0K8TasWt7EehLA/reFwMuJ1HxCQcE1bCyR+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0e3TEVG5g8DCgONdIOzy3GUGIKZhjnDhKkCV1SHe4bfTi0e9+OiWgzG+CSc06XUz
	 rzpRLsq/6RtCPSFfAwmZWMW3LwGnLDwhOkT/qawpxKa4QnI1AoDCN4cqiMUr6l7igM
	 h9426T9qTMdduPpuC5opmCvT5cU4MYj7bsvSfaWj52Xw5cDOsPH9HyEQdTfjUkveXL
	 rYJlKlDoMuIGOhUVtPrHpkF0SU+46RDx9S4sDLaGRtIxnfztIOnTCh2q6/4i/3sHuy
	 4t5gsL0V2QAwbgj/Z8FWmDd5O6mx9xZYQ7vShV1FDV6jITd7L5/qwlDn+iMnxPk5j2
	 k2MSQr1W0egCA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 06/10] x86: drop SWIOTLB for PAE
Date: Wed, 26 Feb 2025 22:37:10 +0100
Message-Id: <20250226213714.4040853-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Since kernels with and without CONFIG_X86_PAE are now limited
to the low 4GB of physical address space, there is no need to
use swiotlb any more, so stop selecting this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d785cb368125..2810482dc183 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1461,7 +1461,6 @@ config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
 	depends on X86_32 && X86_HAVE_PAE
 	select PHYS_ADDR_T_64BIT
-	select SWIOTLB
 	help
 	  PAE is required for NX support, and furthermore enables
 	  larger swapspace support for non-overcommit purposes. It
-- 
2.39.5


