Return-Path: <linux-kernel+bounces-433013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9729E52EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC801883D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD71DC04A;
	Thu,  5 Dec 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PF9Y9Fod"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374D1D7E35
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395729; cv=none; b=YG0nkhyWXfSRcopKlcTDzlJhX8dGESPsweNp8Nlq2lqezedOjC4/y53M13Wyj6MjVgitjUafvdA2P90Bm/zP2V7TjeAbON2hlIn0oujX6hDcBN5+kRtkZKH4h3fLr/K3m3LIeAsCtZcUO2B3IAcaH6dgov11ZHvIOhUW3iwKOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395729; c=relaxed/simple;
	bh=vzXQjICMuoPOyTM60OHH8vNdn2RJrSYEWLd6HwtWudw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz+Shr/gbGSPd3mxER5JNPsv0qIGnHt5+x3WkVWDNFYd9MUlAl36R8xZU2gmJLnPBGAeNsk/+7ybuYzK+W3r9ukJXYryWor/Dr0mYCrQ/z9sJBwoYSpK9v+MLMzjjyKdF0XbKyVZEjRUerlZ16qPao48mzkjO6HMfWpFggftoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PF9Y9Fod; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e5b43350so28330f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733395726; x=1734000526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+AL33YYB9tp8ze1zSblC79yxMnHDSWw4amoRXEM9yc=;
        b=PF9Y9FodSMHplDd4dMJgsLmdXjs2nlrRLm+vpS6E7r2D5KkoAiGABCLAosmOYUxdaZ
         3a7uySBpeSANuYTVcQw+n6qiZQJN0eqnAo+1xoELRQXwAfeCiTlWOU+H036JoMdVaXAN
         KIXNSuqgGQmL9CLmXLQyN2ZJtNEenxsbyUTy8PNCDaP9CrCtamBhWe5AN7yi1+V5MwkF
         B3ftO9wiSe11VM9xD1pxp8lfWtft/ER72E+kn3Lkn2TY2wMCepH0GZiiqZUdSQUHB8NK
         83+B58uk9q19lznSdEeWQ4nIaUKrudepDYfmNnXnlGW1kJbMG8I9/+PyspcIV0f0Z6dT
         cZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395726; x=1734000526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+AL33YYB9tp8ze1zSblC79yxMnHDSWw4amoRXEM9yc=;
        b=pxDo++yrkDmmcaz0IeBicoL+SDRvL9peSz5vbK7wL6TpJvYuIuiD8wINFUG6EeWOyQ
         170vKc02+dB6RoAI8hs4xQ2ezdV0kWeCvrgN2j1ikznQpUi2s8QICwciLUipCZf0H76z
         rHn8Fskx9jPFhTW4k0/JTftCECmoe8p7PvMb73EK/xUJFH+fuWRUsO0YmT39U67zdlPX
         /YAWDB0Iy72s7qGYYEA4iz9OCoO65mi0Phe77TEbL1K046PFHeqWpkXMVAqGx34fs6YA
         L2fuoUNJw6f8L6JWTviqaPt3KWIJAAXMIwNCAxicXQYCx0EI8iA9xPP5Xg2vj7XjuLbg
         vPFg==
X-Forwarded-Encrypted: i=1; AJvYcCUAnpCJhjjU/4P6p0RhMYp9MPefBEP8EiWDc5kKYnUVWCIo0UlWj+UFtlc7P+WKV68M5IIuhqZkERFWs10=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVaB/rHniIzGP0wCxCxxF4mv6E9qp2Uhsw3nX78kqZ6fci61r
	EugG1fjnaxgoaGYfBGH3NLsHPtwXs0rq8zUlpu+/FAJCqAjoteZURQMQ6a4IT5w=
X-Gm-Gg: ASbGncumaAH5PbdbmmzHl3KUIx4pYowIRgF40/fuTdq+Kp6SllO1nGxwq5bpOxd79ww
	13M3qplnc8TzYyxAQwG+1i6a+tdr3QWJht8TppHc2nnKeNSL4d0SBBArfA8z50sn9Hd7ZLaudYk
	Qq2AF6PdozDreqDXQP2Ayx66tDa9BdnwWQ2nzUQtDzDGrANT0Yxvox8UOj0bNGjm4QtQJ8VTq1k
	TRr+gyrHjApk23BtODgFj5O1ZL3e2lLcX/ovcil7U3bPHBSVJUZp/66MUmMohYS
X-Google-Smtp-Source: AGHT+IGZYAkOMvEL8MelgV6Xeu7o3AlbkP/lwHtkE2elo0pACurI3cxRhl7VprMICDBndNqUFWtCTg==
X-Received: by 2002:a05:6000:1846:b0:385:e374:bee with SMTP id ffacd0b85a97d-385fd3c9b4cmr2918870f8f.4.1733395726268;
        Thu, 05 Dec 2024 02:48:46 -0800 (PST)
Received: from localhost.localdomain ([114.254.73.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d14fsm1081629a91.45.2024.12.05.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:48:45 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ocfs2: fix the space leak in LA when releasing LA
Date: Thu,  5 Dec 2024 18:48:33 +0800
Message-ID: <20241205104835.18223-3-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205104835.18223-1-heming.zhao@suse.com>
References: <20241205104835.18223-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
introduced an issue, the ocfs2_sync_local_to_main() ignores the last
contiguous free bits, which causes an OCFS2 volume to lose the last free
clusters of LA window during the release routine.

Please note, because commit dfe6c5692fb5 ("ocfs2: fix the la space leak
when unmounting an ocfs2 volume") was reverted, this commit is a
replacement fix for commit dfe6c5692fb5.

Fixes: 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/localalloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 5df34561c551..d1aa04a5af1b 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -971,9 +971,9 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 	start = count = 0;
 	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
 
-	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
-	       left) {
-		if (bit_off == start) {
+	while (1) {
+		bit_off = ocfs2_find_next_zero_bit(bitmap, left, start);
+		if ((bit_off < left) && (bit_off == start)) {
 			count++;
 			start++;
 			continue;
@@ -998,6 +998,8 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 			}
 		}
 
+		if (bit_off >= left)
+			break;
 		count = 1;
 		start = bit_off + 1;
 	}
-- 
2.43.0


