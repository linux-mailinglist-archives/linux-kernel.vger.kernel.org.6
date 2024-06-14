Return-Path: <linux-kernel+bounces-214629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CF908751
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB171F22B33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79839192B6B;
	Fri, 14 Jun 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRHaktSq"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96C1922E2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357101; cv=none; b=kgRKSuAWEOWTbQa4E+Wrp26c3Hu4l9WI5BARuqTUDCq3Bb8Z2IZza8xCjzoLwCjf20wqmKhQ+2X/ZNVcIBc6tNwUPAPfNubpPfnmEdd5PaypJ5puKZnzkNGkmPlqYbYooJQLc8ZRpMj+9VHf7twNCBHQD0vUK1F77N57aU15KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357101; c=relaxed/simple;
	bh=rEuUggRIk/XgZhGaxQCvlMpbOVQaaZo2o/x5sic676g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TUPFvUyULnfC8VPohpAVnui0mLzAywqsAijJc5yoe4hpaJrL4/leOMCl+513NNRdLHyWuKMfmVtBtrwYxijHqw2/L7jeaVkI2tTONOegMQdQnDjcsTRRVKTTFvujUnFyRvgrARuol+cJ4AuB05NQRALPMOKLcf3xg/XEPZ3FhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRHaktSq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e3741519d7so1391984a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718357100; x=1718961900; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGigGFS7JoII0JOouFlQKMXgDZ1z5wjwFvfN+o3HCRQ=;
        b=gRHaktSqhTRqBla45DAXUG8m4ZtvybH4KKtxEPE8gyV3E6h8zgmgT7m2gs5refWWE7
         fHpPoh2QecAx/NXF+JlPUlEX/a86iQGpepKOb4uCpmx10L/mfVydKbw361w6DdsSoMML
         K9vW5AT5xMJR3xvdHiVeia43fAo+uaHxCmaeBNfb8EEo/YKtU83DhfrOacVGAzbqqDb9
         cWR2gBiFymDVEur2pKe72PFxUmg5rirOi2wwKpH87WHUJLrHOzZbGPUvTlj84U5U6hNK
         m9uiqxP1IWs7tycOMvVPdqzgnKzoteEwyhgQ87caeY6wwOzKWV9rQ1+2hPP4zGyRSWk3
         0nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357100; x=1718961900;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGigGFS7JoII0JOouFlQKMXgDZ1z5wjwFvfN+o3HCRQ=;
        b=c1vtEifjtE2Bk1T1IMo1ls93igOGXy4S6DilY/OZD+NwrP8gVwwON1wQ4R+vvXcGF4
         B2FCA6vK5KGt+QglJeCv5oaA/YjwxQ3l+W9l1cNHYLWNtjLBRLi3Sx4+VyPmuPomp8Ag
         9SWTGt9cc5p977kz4ucM4lcTZDDThYeb0lVwx4KSSdrsRdmGF4tg6GoWnYU/4bY+gsie
         pENb5D2xDkEsSBWtqmYeDrWI6Xd8dgyJY/xfBF6pQ6Wzq8jjzp2uSZHJ0ncdiseALON8
         FfK53CDDvWs2ZzY2myDNBBPHTfxBfIBCbvwYiCzhWCOtId63T1mJAEDqGDr6PcuTNeIV
         YKTw==
X-Forwarded-Encrypted: i=1; AJvYcCWmucMXHOnb0IV1hQAuYlEYKo8vazKtpNL2QCVVkKHVc3Qvv/T4EPsGtEUmaW5OYuphRPDzJ1DdX2C1QZbl5QrnY55Fa6QG57wnhT0z
X-Gm-Message-State: AOJu0Yy5Y/2NZCobN9AeBAnKKnNYs/9dQd3akXlqJGP5L3Xxx+N+I9OA
	4vL8R+lh+hqgMfqOfXi8K1vCX5DMpgEQCOzbkHPL0cykqR55y2JT
X-Google-Smtp-Source: AGHT+IFSA4N7tpOYJXsM/k7aczTA2dZZ9nLaQdNsrgXCpb8pkXFDVXfxwgGSfBeZQ27W5YvaMOZK3g==
X-Received: by 2002:a05:6a20:914b:b0:1b2:a94d:4eca with SMTP id adf61e73a8af0-1bae823dc94mr2526921637.41.1718357099706;
        Fri, 14 Jun 2024 02:24:59 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c4a76ab1c8sm5646383a91.52.2024.06.14.02.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:24:58 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] maple_tree: modified return type of mas_wr_store_entry()
Date: Fri, 14 Jun 2024 18:24:28 +0900
Message-Id: <20240614092428.29491-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since the return value of mas_wr_store_entry() is not used,
the return type can be changed to void.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..aa3a5df15b8e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
  *
  * Return: The contents that was stored at the index.
  */
-static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
+static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
 	wr_mas->content = mas_start(mas);
 	if (mas_is_none(mas) || mas_is_ptr(mas)) {
 		mas_store_root(mas, wr_mas->entry);
-		return wr_mas->content;
+		return;
 	}
 
 	if (unlikely(!mas_wr_walk(wr_mas))) {
 		mas_wr_spanning_store(wr_mas);
-		return wr_mas->content;
+		return;
 	}
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
 	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		mas_new_root(mas, wr_mas->entry);
-		return wr_mas->content;
-	}
-
-	mas_wr_modify(wr_mas);
-	return wr_mas->content;
+	else
+		mas_wr_modify(wr_mas);
 }
 
 /**
-- 
2.17.1


