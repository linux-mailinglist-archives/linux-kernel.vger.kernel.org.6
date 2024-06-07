Return-Path: <linux-kernel+bounces-205890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24549001E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979F71F21EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286EC1946AB;
	Fri,  7 Jun 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUFMFR2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261419414D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759039; cv=none; b=fLr2N2tp+uO48yREIc2ATCtnDz055D+S2lBvdpSlEq7tIwBKIxGNNd7cpyv3KmN/eitZg2kMxRQLNFsXQZsvI5m9bSo31d9FzcLYUcRJnpPldn9vLx7XT8UWDi1b+kc8ekVeQhdl/AULwoJNsDoKHSEbnBw/4zMfDFWRwwNe3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759039; c=relaxed/simple;
	bh=jX1K1qcahG4Vu37vWyHa5G78VbBr/6o4XnfwKu5fGm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfndsI/s6NLJfMI5gTK9Fy60BXxGBZSKMLUOxzRIFG7PWxAMfVtYP6oRY6C7xzE4uN4ZsB4iRmFJBuE9aLfHyVC7mvr4gxVDTUQlY+Sg5gFCAo6gwXlkKkx7DQMdTllabQeV0iK8MdoHoEYavdGeV9PY66/Xok2Q45J/m4Nr92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUFMFR2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3E8C32786;
	Fri,  7 Jun 2024 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759039;
	bh=jX1K1qcahG4Vu37vWyHa5G78VbBr/6o4XnfwKu5fGm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUFMFR2cNGUKSMc+qXLfgKCE7sTZwvnPDvT0zcTZzXKja6Cx/0HKLgMW3OZQYzg/V
	 u6mPG6WxhlugDq43S4MaoNzhH1+Wvnuu37kjc++smZa5P2SM3hdPIwScqEHFBNV5S4
	 xiSp8fg81N3DqUjW3kLmxDlSEE4BDWkNzLZiZeoKL8FU4xZEVVnvYsBZhJO7z6j0Rf
	 HEaNeoSGJRg4/cup/XKNR71pTkV1oJh9MLG0LB7dfAfzfPz0DbmjSXz4CVcdaxJBwO
	 G0rA3UnN5omC9AcsmC0/HPdoz12dvKfMAaMokc0xw+D4txcmwtfdEJHa70B/hjRXAX
	 8tiIEWevUjtyw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 09/14] x86/alternative: Convert ALTERNATIVE_TERNARY()
Date: Fri,  7 Jun 2024 13:16:56 +0200
Message-ID: <20240607111701.8366-10-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607111701.8366-1-bp@kernel.org>
References: <20240607111701.8366-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

The C macro.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index bc260f27d7f1..007baab32c14 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -274,15 +274,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-		      newinstr_yes, ft_flags)
-
-/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
-#define N_ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-
 #define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
 			newinsn3, ft_flags3)				\
 	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-- 
2.43.0


