Return-Path: <linux-kernel+bounces-309359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5E966954
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F581C20E08
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14C1BDA9B;
	Fri, 30 Aug 2024 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nOZQ1YRY"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6EC1B29D2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045075; cv=none; b=Ne6fhehrKgQd5adtFvOa8puKxHfAE4iLi8Z0N5KlCmrMNRXKwkFaMc3MdYJ/I13WYT3jKuA5JBOHQdINKKhJ0AcCBfimjm2f7VEAoGdK3qfc7GB4yIxfLb6Y+psfQY2DhmjQ9Lsj2kwcFq9isasXGka01L0We74E2JWve5Px9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045075; c=relaxed/simple;
	bh=AGFDpfa+bqvaKAyzR3i8XqMbzLG42VLnwzugz17jL9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7y64aWMUVIfX92CLeCMD654wBQl8SkHNNheor+odJBTEicLyVpIB+wI2qjW2O1QI0zQT1/UMZ0awRi+8lLTD0WQchxoDxhesWezlJfxiIYwHHV2+glIPfO4qrCPDudIYD6oIUbIS+cLXAcc98i+VloHHFG40Tn7Ktp3N4CmapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nOZQ1YRY; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725045071;
	bh=AGFDpfa+bqvaKAyzR3i8XqMbzLG42VLnwzugz17jL9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOZQ1YRYxq0Zyyinb9H+IICCQLk+CV1rWnBJaasEXEdJHWNH1Rf+Z/COOh6oHqERh
	 j/TDngwVcSiTLh5I30v7H4y5UxiuuRsG2V5fJfGfC3c6/I9WurOoRer8pA9Q1TR7eW
	 Posir0GrAycxafyiZR9edZVEAr6x+EPWtppR7yk49dJ04HMUf+wd6kMx4YYUw8WBLD
	 pu8EZD/QOx/0AWj4SowkLaZrVS7LBe5lUg4V75mXwn03Y2GOsDnh1wdG4D4pbvjYEW
	 /3nhPq3TObH9VGPKZTxGB9LYZjhUaRCHNxthuDeyLlRxusu0Gicrr//SqxLPOEbqR7
	 PvPd01SB4iTJQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwSRf6f4qz1Jjy;
	Fri, 30 Aug 2024 15:11:10 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 1/6] lib: Clarify comment on top of find_next_andnot_bit
Date: Fri, 30 Aug 2024 15:10:38 -0400
Message-Id: <20240830191043.1028827-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
References: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the comment on top of find_next_andnot_bit clearer by discussing in
terms of "cleared bits" rather than "excluding bits".

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/find.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..8a170aa55634 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -102,15 +102,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 
 #ifndef find_next_andnot_bit
 /**
- * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
- *                        in *addr2
+ * find_next_andnot_bit - find the next set bit in *addr1, cleared in *addr2
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
  * @size: The bitmap size in bits
  * @offset: The bitnumber to start searching at
  *
- * Returns the bit number for the next set bit
- * If no bits are set, returns @size.
+ * Returns the bit number for the next bit set in *addr1, cleared in *addr2.
+ * If no such bits are found, returns @size.
  */
 static inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
-- 
2.39.2


