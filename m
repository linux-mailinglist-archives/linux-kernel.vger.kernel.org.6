Return-Path: <linux-kernel+bounces-197660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A68D6D95
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C221C213BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEFA8F6D;
	Sat,  1 Jun 2024 02:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCcb9zpi"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D744A1C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717210555; cv=none; b=KYb5F7yRniKQasZEj1MPHFjLGVvVU804fcM4HuzAlRbf6Kb0WeGuoFIoXZGJJifIhBMoDY6nj0aGMde0eZjfCwEI6Kn/y2H2MoKsWHlUTfLb9C8/WJOtIEGrrTiMPOENfbNPplVusRgPecO7s+UWiNHQPrSl0kxIKfYMc7AM5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717210555; c=relaxed/simple;
	bh=lFDHCFuHx/4ELXBrao5r8KeIjTe8vc6reOF0OlBdfwk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q4iCyhH2fUnY5Rj329RYs7ZaOF3PAJLEqCs0kfRnufiTejwcVMHUj7bohkd7IVBjioeNsPxtCRqk1qQnwI1fRdczyoXgtDYc93usLa+1VSNRWC+6hO4Ksm01a6R5p8d/XdQ6FBC+8WU1jrXcRn1Ag/T9fEEhn9sZsjXxxCcEMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCcb9zpi; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1d78b7418so1575753b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717210553; x=1717815353; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cuT18JOZza/4e5QCGWHwOGAqlrdJNqLc1S/ZVkgtOY=;
        b=CCcb9zpiPkRvth5yak9vY+F8MD1InuLW+TxmzK40AgMhXkJS6G+EcIZkV6/VkvFuVu
         cd0rLjxipTjRs09VYuFou98h2VzTsSoMQ8hdo6HHDzBM/hPofdEf9dfLt6OOPKiuvkKS
         5+8jdrq0bScugh9KrhzNXC0k6jEn0Cw3uy/TjCRwoxKbpU2Dxt3iL159eGqrbcvK5zaH
         q84jc6NAOUWqU17lqPSt27vWrj8uBAb1pK53jjLDKuk5chV/HxjLp6lqxqW1YOxHWz5q
         OI/c1U+nbp6mhZjEJutsgkX4Y47pn4+CuxlAZ4ut2Je4AM1Xq3mjWMCI73FOJlONsY8w
         JRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717210553; x=1717815353;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cuT18JOZza/4e5QCGWHwOGAqlrdJNqLc1S/ZVkgtOY=;
        b=AijLhsJvg+aYsdqgBDQ7z7ym+e/4VYrPlTlB8cr09riCHQmSAJ7CdE6IOlOCQsVpa6
         VjkWAHc+G5qNolkzWsP4ij+s+ACJ1B0BMz5/fKOxnekXxEUPZG+Y1ttdUUjheh1Vdkkv
         96FoM1Nj64TLhT2THx8kh9KxIlz7FuOd+ujkNTt+5omk/gIFeXnUzVyxXU17IfGUJ3ZO
         tD1oYzR/B/r650QY1pEuXT+X7irXXiW53FmLiquV9DDKd5Qx7xVrZuqhWkf4kV/jb88Z
         AG1L3R2ByygSTp4m6OnMMuXnZ2KRsUnC6x4+KxXm1a3niushT5Nd8oSvJd3/nwlXRP8m
         XXUA==
X-Forwarded-Encrypted: i=1; AJvYcCWTAxYmUMQMn93h6090Q9gVZxaR/8BiA50vDweQ7dV0xLQIbp0WJNYm8sl14T7abTn5v4RL86RH/eBA/gG+AYgT3WoCfrpSYSH4QEQh
X-Gm-Message-State: AOJu0Yy7yl7t5rsEMLyGS/CJnj6XWZPMCVi3YfOOolY4yIjsQRn106SE
	FOJOZ70YE6BuzxYBQ5vJIdrTQbIP6GfUAzitwDRfP6FwZmpkT+Gm
X-Google-Smtp-Source: AGHT+IFrOEgn2sLNc0d61WpIO9wZGaBK1cdMn0rPjsa2MBX+KCqZ7pFkGa07RP4vK6dSCwRJrb8JBg==
X-Received: by 2002:a05:6808:b06:b0:3c8:4dcb:3d34 with SMTP id 5614622812f47-3d1e347668amr3484293b6e.7.1717210553073;
        Fri, 31 May 2024 19:55:53 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70242b2effbsm2035817b3a.206.2024.05.31.19.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 19:55:52 -0700 (PDT)
From: Jung-JaeJoon <rgbi3307@gmail.com>
X-Google-Original-From: Jung-JaeJoon <rgbi3307@naver.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Jung-JaeJoon <rgbi3307@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] maple_tree: add mas_node_count() before going to slow_path in mas_wr_modify()
Date: Sat,  1 Jun 2024 11:55:36 +0900
Message-Id: <20240601025536.25682-1-rgbi3307@naver.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Jung-JaeJoon <rgbi3307@gmail.com>

If there are not enough nodes, mas_node_count() set an error state via mas_set_err()
and return control flow to the beginning.

In the return flow, mas_nomem() checks the error status, allocates new nodes,
and resumes execution again.

In particular,
if this happens in mas_split() in the slow_path section executed in mas_wr_modify(),
unnecessary work is repeated, causing a slowdown in speed as below flow:

_begin:
mas_wr_modify() --> if (new_end >= mt_slots[wr_mas->type]) --> goto slow_path
slow_path:
    --> mas_wr_bnode() --> mas_store_b_node() --> mas_commit_b_node() --> mas_split()
    --> mas_node_count() return to _begin

But, in the above flow, if mas_node_count() is executed before entering slow_path,
execution efficiency is improved by allocating nodes without entering slow_path repeatedly.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 lib/maple_tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..8ffabd73619f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4176,8 +4176,13 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	 * path.
 	 */
 	new_end = mas_wr_new_end(wr_mas);
-	if (new_end >= mt_slots[wr_mas->type])
+	if (new_end >= mt_slots[wr_mas->type]) {
+                mas->depth = mas_mt_height(mas);
+                mas_node_count(mas, 1 + mas->depth * 2);
+                if (mas_is_err(mas))
+                        return;
 		goto slow_path;
+        }
 
 	/* Attempt to append */
 	if (mas_wr_append(wr_mas, new_end))
-- 
2.17.1


