Return-Path: <linux-kernel+bounces-205887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE949001DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FC0B2485F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438D194085;
	Fri,  7 Jun 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daIHVpvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43519309F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759035; cv=none; b=I5sir601KUsy+OdDMcMFKWrC5OeWsrCmeGXwCf022q2mXbeeaIsg7cFmZAQYR7HR1p7JpRdbfsBn4er2pm7qytHf06GWSH4/7gNTChKgWuWxDazVUYDJzLLLRyST4iDK2dVypsmuPzWUwyPssJ0BVlP+YLJqE1pFjiYuXk9laQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759035; c=relaxed/simple;
	bh=0HCrS9uz4EYBWWuk9AcMKlySTziLWW736XUxfxX+jiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hint7jC/jTGTtx1Ki6stTuFCWRK7mcJyHOrxd9bLWGd4wYFBnXr/6jU1lGn7QvmN2X93NWBzOs/j0Elp4tancZQ9c45vPm3SQ2vya0KeoOs/Xcow3mNjHLk79V+lQBCV+FzLqRX25L088wPyWZjrnOuoKJj6WOOt+MEtKEWv7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daIHVpvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B202C4AF08;
	Fri,  7 Jun 2024 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759035;
	bh=0HCrS9uz4EYBWWuk9AcMKlySTziLWW736XUxfxX+jiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daIHVpvES9VNvuR9PbB68XZV+OO9B20a/uGZBKngLVoIYxOInrYZ2Glp/P/DXiv3x
	 V6uORJoGgfsnDna3dPKOAH72VugYFeC1/5V/I80Q8QGIr1U4HuJERo4DTqmQH28doB
	 ZADbwSNoE7duI6tamzLg6biRvQU9w2YiFpWMJgn5zPqHbyW7nJ4VTDn42Q5ElkKoP0
	 Z2qDVYBwVt3nlvIkndIGU+Xoaf8F0fTH5wK2csCTbqIqP9IF/oiWCfVFC5PPx8+7WK
	 Mr9eGZ0VkbVEYlPS62HZBcm9my7MPDNq4yPdMrtD1ycdBzCktYLkMm3Xnqo07wbDqG
	 IMwqyN1HSr8NQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 06/14] x86/alternative: Convert alternative_io()
Date: Fri,  7 Jun 2024 13:16:53 +0200
Message-ID: <20240607111701.8366-7-bp@kernel.org>
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

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 428d6efeb333..6a746811c602 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -335,11 +335,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
-		: output : "i" (0), ## input)
-
-#define n_alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
 /*
-- 
2.43.0


