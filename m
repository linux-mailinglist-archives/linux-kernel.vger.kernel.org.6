Return-Path: <linux-kernel+bounces-415843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3739D3D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EA3283EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544ED1A725C;
	Wed, 20 Nov 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq9H5H8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF801BD4EB;
	Wed, 20 Nov 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111650; cv=none; b=p5RJwHtECYOW/in8uwYPhZWZH9z5U0AUWBVKb0ylnDKQ1Yv1YFD4GwRg40f39dvgkdVJTVeHRJMlNF7DQO8hJETN8QgOx1ZsXoKPsGzjLFR3hTCawNOWa7unXzYYR5szF3t9bMEMRHTmfYFF6R1hpx+nqx9q0AVrqcRKjeruhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111650; c=relaxed/simple;
	bh=WqjuFiHEcg6WRWy7fxL8Sy+36LBCtbIcgCASBJpeiLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzHQiGqZgwwTigQf6PVqGDua6o8ONDh4OhRjOX/bIE8OSFYKoYj5YqKh2JEGBxP/bIyhLJNnuFdMfto9TzepfQyuocwewMhWou/iJPLNZ0dPxWcpDh748/oeFl81+JWLCQ8PGg2mme0d8oogmWUrCiiNqEbeX0+BsAryIhHXrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq9H5H8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F4C4CECE;
	Wed, 20 Nov 2024 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111650;
	bh=WqjuFiHEcg6WRWy7fxL8Sy+36LBCtbIcgCASBJpeiLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uq9H5H8OAtn/nmT0myUVWbw/0l2Qsa6p8jyzfU6/BW6aMXZU3RbpGVJ1fv6oLXNaS
	 aLzzHwZsA1vzQZ2nY8w0MhtsvXpfhNHWCspsocgt4CAk44INmmU5SqfD1ZcZYFWA3u
	 PpL1KOj1dEYb7CugO7oKCEzq0zIOosYELZ1CHkihkN6IKMcy6Xtd2GgCyie0o4icQa
	 MXp4zgNjHhSIvQZN9WRUox382zEwFQotyVk4/0EFHlxs9/Hh/G/ABWW//xBgR6Bk+P
	 urbNmg/YWGXWLjQxpcJuhgg6W8m1BY5c0m1SxBbt9Sevncw6WZN0ZKmuJCk8WlZ9hZ
	 pEWNF+ntG8CPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuli Wang <wangyuli@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	vincenzo.frascino@arm.com,
	max.kellermann@ionos.com,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 2/6] LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS
Date: Wed, 20 Nov 2024 09:07:08 -0500
Message-ID: <20241120140722.1769147-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140722.1769147-1-sashal@kernel.org>
References: <20241120140722.1769147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.118
Content-Transfer-Encoding: 8bit

From: Yuli Wang <wangyuli@uniontech.com>

[ Upstream commit c859900a841b0a6cd9a73d16426465e44cdde29c ]

This is a trivial cleanup, commit c62da0c35d58518d ("mm/vma: define a
default value for VM_DATA_DEFAULT_FLAGS") has unified default values of
VM_DATA_DEFAULT_FLAGS across different platforms.

Apply the same consistency to LoongArch.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/page.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index bbac81dd73788..9919253804e61 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -102,10 +102,7 @@ static inline int pfn_valid(unsigned long pfn)
 extern int __virt_addr_valid(volatile void *kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((volatile void *)(kaddr))
 
-#define VM_DATA_DEFAULT_FLAGS \
-	(VM_READ | VM_WRITE | \
-	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
-	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
-- 
2.43.0


