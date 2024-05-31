Return-Path: <linux-kernel+bounces-196790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14368D61DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38C11C245B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A845158DC1;
	Fri, 31 May 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMIg2FBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D915884D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158921; cv=none; b=mVuyZGfk0RJI0IA3CHoWjo0F7klkGtfbSjKFmsCmN7u/EmIIIHHZAgO54NhbnHBtmDBNkd77JHK+RychFD2e4ph+Dj6Hp6/Q5X/cxRUxgMOZ2dcRKbNe3lWBKwn2W5wPm/8i6TqFhWsqfCqsalbZ6HD0FWwSFeef3IGpDGY0YeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158921; c=relaxed/simple;
	bh=OZwBq4zhE7sZbzL9CtiglYHCMatlBRlDf8o+veIibKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWpPqUH3Nqi1zRaKIQF7ui5tzPpJCJVxfNHKQOZqae2wXVb0EyTHrHw8nduz7X6r4vpKoNd4s6eP9j0EDk3zzBQPegeaTmJNbVc0+7W9jBIFBcl1RgWdIrIWU6krQH6OGT/dCUGNF0DRwGxc2RQJ+CPjjm51osqB/911OixFwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMIg2FBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41976C4AF07;
	Fri, 31 May 2024 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158921;
	bh=OZwBq4zhE7sZbzL9CtiglYHCMatlBRlDf8o+veIibKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMIg2FBGQtew7H+4WbkjVChd1F9CQ3bw7TkT9hA1ddo3nml6Tsr5zspAvpS6Hh6DF
	 hfoVmOE4Ia/SGGcxF4Xru9MqifCVnBlspdARggAnXiyiTzQ0+J8uEi6GN2H7VbMUT/
	 O75qoNcjFpdaRDpdMVZzV564wRZgi4YmDGh4oiYME68yvz7GVTaV3KGCN9GLz6Kj+q
	 /+LdsrJets0FAODfcHGu5p/GNc7h2weHGYwWNyccJDxRcyjhmdgNLSSsyRSoIask1m
	 sAJsDtJwu2ZV1cJRcDAGQRgTNcAf5c6um0Me6egqNw6K4l7Cb1YADLUv3SD6fvwqie
	 vERkV2LmH5RKQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 04/14] x86/alternative: Convert alternative_2()
Date: Fri, 31 May 2024 14:35:01 +0200
Message-ID: <20240531123512.21427-5-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531123512.21427-1-bp@kernel.org>
References: <20240531123512.21427-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index c622ec7c4462..1dd445c6e2e1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -319,9 +319,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
-
-#define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
 /*
-- 
2.43.0


