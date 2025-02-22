Return-Path: <linux-kernel+bounces-527230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB074A408B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C9219C5E9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477382AEFB;
	Sat, 22 Feb 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRSdjKgm"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797C10E4
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231128; cv=none; b=P2gZsqwIJLk47pY4u1avISzE3T52w0aE859KXnFkLk1vN/PUelTQubEedD+wFlq8wUSWUcCHnWNYjB2RCHjs2tA++CGo4nqoDjnkwxvm0t8I8VjSB00wTjPq8OZlGpDQ/zVm4Wx8GjFsJA4uo4ZE9+3OKMKulTqyIUvKdq4lSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231128; c=relaxed/simple;
	bh=a3q033m9QDXf96Rc4CGugVqhTq8k4H9SG+ued1hT5Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDlr812UTOE8RH9E1Et0GeASOeURBM2mICtxa+4gpJs7nUMgI2SXbME32+RbVdHUMqVLKbXLogfhaO88SziMbRClhrVo9V4OPucfYxVU6SXuA/4S0kkyNRIbL4n57cEuWL6l+xZJh/f476lJSAL7a7RhQRULSfLaN0ZUrhPCl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRSdjKgm; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740231114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RdvTTP7qcW2YqZWjmufUDVNenWR1tHKSuIW1RDRTnoA=;
	b=kRSdjKgmCbk6uoQN/VhJtbqgTzEC3Mf0OCu+FMNO9/e7R4xIpWvCcs1ewTkFW9ggepqJrV
	3u8Jw1Rmf6KdXkGlTH7Dl+k9pmoYyjqpMdaxPV6kNszN4TtJm6tSexh7ns4nmhVkc/VZD+
	6Tl/XLL39XofEbLRa/yArMIynnLDcC8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Remove duplicate condition in return statement
Date: Sat, 22 Feb 2025 14:31:01 +0100
Message-ID: <20250222133100.369710-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The last two conditions in the return statement are identical. Remove
one of them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/extents.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
index 620b284aa34f..8afcf2c75015 100644
--- a/fs/bcachefs/extents.h
+++ b/fs/bcachefs/extents.h
@@ -703,7 +703,6 @@ static inline bool bch2_extent_ptr_eq(struct bch_extent_ptr ptr1,
 	return (ptr1.cached	== ptr2.cached &&
 		ptr1.unwritten	== ptr2.unwritten &&
 		ptr1.offset	== ptr2.offset &&
-		ptr1.dev	== ptr2.dev &&
 		ptr1.dev	== ptr2.dev);
 }
 
-- 
2.48.1


