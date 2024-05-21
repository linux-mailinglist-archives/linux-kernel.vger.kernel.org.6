Return-Path: <linux-kernel+bounces-184439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4D8CA6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98337280A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363AA6CDBF;
	Tue, 21 May 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Y6th062R"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A665FBB3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261455; cv=none; b=iV/r0NoETuWTp2ZkteblagTAF4AIy1tpwBTmbScI8/slZp+vVKqOeQBONRrt+ze5VH2RNQ9TjcWKADjfJVomIjV+GooHUjRbSF8awoh09TCLah5GSIpRKHcmBl/Z/0CopqqIXwAlYuUYVmnU25E911lND31ciacGlluEXzlbol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261455; c=relaxed/simple;
	bh=Wr81TQ45G30xNhmOkpy6VqywIleSpREFvah2+9mPb8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=By0DD9b0MO9+4zD6PTnQCnqS+m/TpG9J1FIax1B2bOHywhEJoMjYzp3uRGlEChDIdIsA65EBhntz4N1iwaskX8v+jhUoasrLXVyFUO4mRR0s04LUN3qSp1WhiYybfmks7COwRKeZxUoNBg/cLPjv7OyHvRR6edRBrVAkf5dqe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Y6th062R; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f2f566a7c7so64564565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261453; x=1716866253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/beP8h/MyXUke5aaej1RngCGo0SmcFT4Mq28a4Aie08=;
        b=Y6th062RzraJvSW00tXjf8temGuSOhPsWj7XPlg2+KOirfRs0yC+m6K+zydEAlU5zV
         phfbj4DjRtEzBF8EaSxj9RAdJtU1IPpm2yWoaEAHVE2RJCmf4CSlphDrCU09ODM3MXqE
         09cb52NC2/KKIsz5uIU3Yzn4hHR7c0kmILNFtJKB3EOxpVvvBGsO+1UhO7WuoTl/vC8e
         0NqyEG21W7Wk0piXQop7IG/u3KNnBDei6YddnM7NoWEgZ+3d68Bn0S8q6WubrYnVD8TP
         8pZ7ujyv+t0n8au/FvbQ8hAPNmYKK0BgyNUQ6CaxaUghMgQeE0Z5MTGkxwbJ8uGNe68t
         v+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261453; x=1716866253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/beP8h/MyXUke5aaej1RngCGo0SmcFT4Mq28a4Aie08=;
        b=VmnfBYLUjV1vEzvf1p0TzzwRM8JJvIqFgQZDgVtG43TGhrS8LReIekAfH+yb7vVcPB
         fgg1c/k+RF95ZtHhvOZphsQawehxX8Mg/bgWcCs2J0DWVxoSusZdFxWFRqoBUQPAP9PX
         syjzDKB3nlZvK7y+Bf3XhbErbVvtRVQ/nvxQVcKo8Tp4buHmt6vld/0DG2ADo1wE0IGF
         hR/Wyqe8v/gSfDEJPmgwnirQLZl2cR/TiDbgQcWn1cCLlp9HMrjSIxb7suUfzpH2HNSQ
         Jow6/ulLdK5jfetk6LEeDHMyOaCMbBlP9DsIPNRKGk3XqQ1fwzjAcXjSwU+J3d+dwxXg
         LtQw==
X-Forwarded-Encrypted: i=1; AJvYcCWcRIK2eumv4GxqHbs07Lp71lmcekCL6Li3xRFYOik/lQIHRfk7qfIVysiMYspXI+D3488LBaSJ1X9o+vsGCX0b/Kp7kvO8m3F/aJZp
X-Gm-Message-State: AOJu0YwScBbmO9qJ3ezQv+8jJspjdOVBskJQQIYvL0Ket1wilvE5ZStN
	naqR35Eru3gCcHRk0Frn9Xt/AByU+W68JwYFNIR8j85fcN0/JcsiiJ8BeMJ5xnubHLozBVtKwWW
	z
X-Google-Smtp-Source: AGHT+IFwsw9QskOPJMvjYDG8sYTnJv2LmRuTuJ7Nq9SpLDSqhIpvhdsb74byEyxWd/ZN+JYE69wbyA==
X-Received: by 2002:a17:902:7618:b0:1e3:e0a2:4fb8 with SMTP id d9443c01a7336-1ef43d2e1dbmr289158535ad.30.1716261453300;
        Mon, 20 May 2024 20:17:33 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:32 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 15/31] Staging: rtl8192e: Rename variable AddReorderEntry
Date: Mon, 20 May 2024 20:17:02 -0700
Message-Id: <20240521031718.17852-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable AddReorderEntry to add_reorder_entry
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 3afce436a5d8..30bd6f49e915 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -403,7 +403,7 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	return 1;
 }
 
-static bool AddReorderEntry(struct rx_ts_record *ts,
+static bool add_reorder_entry(struct rx_ts_record *ts,
 			    struct rx_reorder_entry *pReorderEntry)
 {
 	struct list_head *pList = &ts->rx_pending_pkt_list;
@@ -610,7 +610,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 			pReorderEntry->SeqNum = SeqNum;
 			pReorderEntry->prxb = prxb;
 
-			if (!AddReorderEntry(ts, pReorderEntry)) {
+			if (!add_reorder_entry(ts, pReorderEntry)) {
 				int i;
 
 				netdev_dbg(ieee->dev,
-- 
2.30.2


