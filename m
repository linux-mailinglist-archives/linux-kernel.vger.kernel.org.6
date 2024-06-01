Return-Path: <linux-kernel+bounces-197651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09398D6D84
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077622832E2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A86FBE;
	Sat,  1 Jun 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCKjWnus"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBA6FA8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717209480; cv=none; b=jXmnR3JF0A4E3brPbolF8DJUsbOp6zeQv2FrqRxeNLpFGFaisOW8RsBvWQ5fSvV+et16aSG3k9gHiEv/kxreHg5WDMoArwNr54Zqmmy/x70qDqnt9kRuEg9fDSEK27WXKRj7mGCS4CFaUvPSCsBJe4Z58fli9pnnKAwFjc+W2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717209480; c=relaxed/simple;
	bh=h0vhYBVZVGaI8yXhnl7nr0T+/KncbGl3OwsuldQ0xMU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iWMBacsO9e7GwNPOlaE+7rtPwaVO/FGx3D14Ldjjk9e0xXwDrorrWYeAnKv4I71QeeJgp+YIUzdCXzicCVCU8kFknL7eLWus4zT4GNJ1H0vsns1luazKjVTKOY7roZDiCW4r+3NUVudc98YeUO+VqBQx54/0sw4DiX8ITViFkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCKjWnus; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2070e1579so32474a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717209479; x=1717814279; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDNMabYW2abbHXnVWwFSqG9v75QNgOfpcXzt7NGTMHM=;
        b=NCKjWnusnjb1YU95QJbcqTGpl4On552N4RJ/9ydF7zoxfHH8tJZ5/9ngD92l842sbW
         iU7PlO3wutFMpo7ty8e8hc9iW+nyf4vVY0Re4TQ51JBylfEizcEcZVgAz+YEn/QGusiK
         4qVgU3C7s5ca3YErxXAyNSGkno+9EHyHShLmrGOr/tfA35J1vjV4W63yO0zk9FFGTAIy
         UjsYGYj8a2o28j1XVgjGT1pWSKuiTNowmX0sqjG8eMxjKsj6C9d0r8C2LyX+gTJBpyS4
         WVan25LPjmd9xH86ct27pKLLIfsEnhWvsfMPnarbvDF+r+t+P1FeMa1qzqdEPP6UKoYG
         ev0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717209479; x=1717814279;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDNMabYW2abbHXnVWwFSqG9v75QNgOfpcXzt7NGTMHM=;
        b=izHbDMg/Og+RUqaOW9MBiyrZebCz11y2WiVVrjDvOqx3uyZxPpC2puuQezlhnFLR6n
         5LT/jvUo3BnBYFW0zUiMH0n7jNF6SFrvm6FICQFxO6MJUaQHPME4RjnAJa0PWgyOSyn3
         UYSBNf3C8fLn8RUobzgqIuct44mvz5AzX90hFu7HUVPpeO1XBLrjMdfh4n4PCSDiQOwo
         fvaSX8h4h47IYgqrkMjFnq9XYLjKmMq2yB6iX8Pjcn5ar9Rz/I32f/Z+JYogetZ7OQiG
         QR7pMv8BVWSFpwFzvCMPsQQZNH0cGu95F2yZ7ApgL2qmH8xwR4OvRm0pVgwQ30kYzEHr
         3dAw==
X-Forwarded-Encrypted: i=1; AJvYcCUtsJUy1y4DLQe6Nw6T5154Ci14SHyVpdrN7cqK4/wNiCGWs96zvJG/NUjJBMyR9jjpB5eCbdiV8ujDQkVdk7Vofl8e15PfxtVb0H8N
X-Gm-Message-State: AOJu0YwtRL0NY5AfVTtTSrzskBhakveVz4n+h4E860k+dcnf+TXDbVW2
	xNX0hmP0uayXHHHEF8LPU6ATEfMW5jmH/19YOsxekxsRMY1qrWg9U9T52mLj
X-Google-Smtp-Source: AGHT+IH2wOZUIqhqnHNNRFHyANOJ24cAQXOX5kwZsG73ukdlpI/et6EBALcb1YP8OMfEowxVwr8O2w==
X-Received: by 2002:a17:90b:19d2:b0:2c1:948b:6f2e with SMTP id 98e67ed59e1d1-2c1dc5d5698mr3162951a91.44.1717209478737;
        Fri, 31 May 2024 19:37:58 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c1c2831639sm2399858a91.35.2024.05.31.19.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 19:37:58 -0700 (PDT)
From: Jung-JaeJoon <rgbi3307@gmail.com>
X-Google-Original-From: Jung-JaeJoon <rgbi3307@naver.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Jung-JaeJoon <rgbi3307@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] maple_tree: add mas_node_count() before going to slow_path in mas_wr_modify()
Date: Sat,  1 Jun 2024 11:37:14 +0900
Message-Id: <20240601023714.21226-1-rgbi3307@naver.com>
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
index 2d7d27e6ae3c..b42a4e70d229 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4176,8 +4176,13 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	 * path.
 	 */
 	new_end = mas_wr_new_end(wr_mas);
-	if (new_end >= mt_slots[wr_mas->type])
+	if (new_end >= mt_slots[wr_mas->type]) }
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


