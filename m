Return-Path: <linux-kernel+bounces-420821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD89D8451
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F41B28EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C81925A3;
	Mon, 25 Nov 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMkO/bSa"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4B18A92C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530772; cv=none; b=FYRNt45xEx2kLsZGNclk5EBVwFbYRTpJKRTfJdTsHVLXo4CRojchAqLIFwFNNNKHpprOeuWEOc7Exbmk9UZtjuoi7JrFJCbLhtl+jXEd+wkOtRkU9wvoMfv9ttm0wyRXKPOsLlmNQM+C7N4nLo77G+9XSP0aYLq3PGOXwjbpSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530772; c=relaxed/simple;
	bh=CZw438fzgU6+CLnU/rOm3EGzDUGkE8ElDVUYB5jlEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTxJCWHbwklu946gVdr5UJRd40dutD+N8nSQ8vPhFw1swswb8op3B+JnP+yCTnuhzHedf+lbMUGbhPIsF7ItEzkMdeApEiqZRKU0ocmFcg4+/8ig7lER/FYIJcsZmBfBbSVacEmmBZlS3CONqSI0cEw05AkoVmw6FbOqbOrlwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bMkO/bSa; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732530766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MoENqIKox7AY/qS4ViQA7GaA1waqRgjx+z7WAMBdMEo=;
	b=bMkO/bSaeXG8wna8NGwYZD97IubSVEnjUtqNWn5QX57CMa/m8sjN/mEzXBaSJTtHPnONCy
	P4L4ZUqHYgoL9h8/LyD4kJnFGnS5jf4RPv1mZIIQ0Xkj1KdAdrhxFOs85Wzb15SqaZ+gmE
	b3o1WMZqdLzP2aYF37QAudp5CFqTw+U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: Replace one-element array with flexible array member
Date: Mon, 25 Nov 2024 11:32:09 +0100
Message-ID: <20241125103210.134678-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct crb_struct.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/include/asm/hwrpb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/hwrpb.h b/arch/alpha/include/asm/hwrpb.h
index fc76f36265ad..db831cf8de10 100644
--- a/arch/alpha/include/asm/hwrpb.h
+++ b/arch/alpha/include/asm/hwrpb.h
@@ -135,7 +135,7 @@ struct crb_struct {
 	/* virtual->physical map */
 	unsigned long map_entries;
 	unsigned long map_pages;
-	struct vf_map_struct map[1];
+	struct vf_map_struct map[];
 };
 
 struct memclust_struct {
-- 
2.47.0


