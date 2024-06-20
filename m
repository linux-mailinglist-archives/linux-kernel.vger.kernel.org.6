Return-Path: <linux-kernel+bounces-223195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A879910F61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D91C20B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095D1BC068;
	Thu, 20 Jun 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp2LJqaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68161BBBF8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905248; cv=none; b=A+fs2Ncf5mbCPdCH9xgWEcDlkVC3nj4i3nsj0Y0cy3RsoWtKb53CRQyyRHuT5mni5i7GY//WD4TIF82BvLrhzfFQqzIV1OXI3nkWA5yMORfR8in5w25e8WMI+ixZBkEtYldIIQpPRfPGbMlxn+AhgdBIiBhp/0hOD0O46z3Juc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905248; c=relaxed/simple;
	bh=zNW29kTA336wSHv1E3ERKYzkegNL6fCNgK+d+Y3zO7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwYnaGzDEhjt0zqq5DF4fTXw5MbJ36uYHVZX5OJx7OY23UGRYkxUz/ttorBrdNw17JZ49i0eI+jjcsoimpa6kIBMsOIxtNm1XvHBYDAg7YiSAnUizoJZRaJTm80Jg8ePtsQx/ftuRhJg7soC51tvxEWJZ20nK6Nk54kdO14+s6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp2LJqaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA84C2BD10;
	Thu, 20 Jun 2024 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718905248;
	bh=zNW29kTA336wSHv1E3ERKYzkegNL6fCNgK+d+Y3zO7o=;
	h=From:To:Cc:Subject:Date:From;
	b=fp2LJqazgnX9r8cNdj5baOza8yJBGlCqVHXG4OQLhpEnNk5ss2vyP5Qy+cUDjfQ9t
	 sbxLUXZM1CkBTrM/uHBkBD/QwyEf8s8mW6aAWsNT8iVKgY1/Ze1D9swZSg9aQ4JjDR
	 s/DCDy5pQqZn0hOss7Y5zF6sm0nKDsrDW0F0lxvHebr2o08d7esMlbqvFYrJ6Wipkg
	 eWGS7KlDTmhHdqEZc8aynTJBqgXefVk17yE4Rrn5sCDs3U0T2X94CQpxo4ug3uqsMn
	 7jmisUGumphXd/SOGVkVb2I7nEVxGWZwZ9IKhNBhSWCdFrEgBV6yeEZwENseVjhopz
	 a6A+bfKqVEGGQ==
From: Mike Rapoport <rppt@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Kconfig: fix typo in __builtin_return_adddress
Date: Thu, 20 Jun 2024 20:40:38 +0300
Message-ID: <20240620174038.3721466-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Comment about BUILTIN_RETURN_ADDRESS_STRIPS_PAC spells
__builtin_return_adddress with a triple 'd', fix it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..3f39657af2cb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -381,7 +381,7 @@ config BROKEN_GAS_INST
 
 config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
 	bool
-	# Clang's __builtin_return_adddress() strips the PAC since 12.0.0
+	# Clang's __builtin_return_address() strips the PAC since 12.0.0
 	# https://github.com/llvm/llvm-project/commit/2a96f47c5ffca84cd774ad402cacd137f4bf45e2
 	default y if CC_IS_CLANG
 	# GCC's __builtin_return_address() strips the PAC since 11.1.0,
-- 
2.43.0


