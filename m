Return-Path: <linux-kernel+bounces-283355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F7694F15F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7228236C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AD187324;
	Mon, 12 Aug 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IckFS6Y6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1118455D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475379; cv=none; b=p4pNG6PYCwvLqBiiCqk9FaUWW58ubJPZYNbp+lRsp5dwQzfXNdCIxBbdSVyjxYjFinREdYxc2zc+r3cgFExn3J46tX1IldXJ9JypmdM0p2MhiMLYBWoZz6Fa7P/ipJcPZyQLGlHQR5GFJfPKuZZSSo1djF0ti8tEBiqXWwSuGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475379; c=relaxed/simple;
	bh=OnrQKsH/f+X+FV8v/72nNYcXJ5iSQ7oWJ7CUbf/R9QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tIjIi83InlQ+98cYa8tH0Vy9H0bLdk6ZmFaX2vP2JHbHDdSKD/JotRAHEZ/7ltYfUMK/TwohyH2akPSm8jAMIuK6ytkFzCRmX8kmBW+sw5SED9fiofvydWm2KKdSnMscJs0Pw7i0YZwRrmHZcn5ihC8uKqRBMCfaKy7JNna5dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IckFS6Y6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so544720466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723475376; x=1724080176; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wh1aBFZvie0IKOiQ6XvPwrQsbXe5mHEc86qzWg1Om7g=;
        b=IckFS6Y6vUQZZ8nrl9b8NBGKZSAiZgyI23tlmal+vBn+4qsWT3xfGGsYmqULmTEnqB
         8KJrOZ9+8/vfhdEphVb/yRf4aJt9Ws4WtqTP1myf6/zWAM+xk9Ha6XHVYx3L//twI9TW
         hHcU3IFEe3DriXLizBswjYT34hHtcLcZZ/Qx5AzyHimKw4Hn4/oPh4e/lyvJV+SuAmSM
         qJpa1tMQN7wq5S7R8PK8vbqfAPKFY3afvPcUdL4dVFyfA+gFfgxF2FUyRyR62sLiIhov
         fr80L7AfWcsosgKGoCt7Vdbk7palUtWNT37VaT5WDgdd3ehBGAvFy8EcUtRCs6PVn327
         GU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475376; x=1724080176;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh1aBFZvie0IKOiQ6XvPwrQsbXe5mHEc86qzWg1Om7g=;
        b=cu9ICpE/L4WqUyiw5gbznvMBdfSb+oSFErJbE0xo8cpjHObp/Gq3ypG9+7PJzDkeQ9
         DqaG+B9eHyYv5Z0EL2dWaax3XU2AwyLgKS11jDFRGCokOx3BG1R3S9DEmb8jCwvK4Cju
         SX7vUWUlBgO7DPs7UhqnUM4HWk7uBBwiVP/gRXe1a3ztCiIsVxNgiBKelzJHE+FqtXVM
         NYJCA7edZwiRs6XaRLw2hvyuj2rD6goy4f2jpOXhKb0QtsehmSJipC0hDfXnprq2MfnQ
         3w7OL7cr6fhSc7/fUd3hwcrX225psUeJ9JNThyduLCWM44GOcm+g+DE8nI9pDV3g/bP/
         N9MQ==
X-Gm-Message-State: AOJu0YzQEfX4/EnEN9arQ46BeKrO6tJ0829XX5Yeoz4vv3gzKxZZO+wj
	ShfjJ4vwiHQ3a5XeqLzi/xLNqT+Zuq4RiSSuPW3kdozqvT7HwcF4kYG2IQ==
X-Google-Smtp-Source: AGHT+IE7Wq/tDmcbGLjhQ8pc0VF/xIL0RjvEcRZiXVJpYHHrOpgAisKfNFtMYQesi48XpwiTc3wxSQ==
X-Received: by 2002:a17:907:f769:b0:a7a:a06b:eec8 with SMTP id a640c23a62f3a-a80ed24e875mr50426466b.37.1723475375874;
        Mon, 12 Aug 2024 08:09:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb090634sm236759466b.36.2024.08.12.08.09.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2024 08:09:35 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] maple_tree: fix comment typo with corresponding maple_status
Date: Mon, 12 Aug 2024 15:09:25 +0000
Message-Id: <20240812150925.31551-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240812150925.31551-1-richard.weiyang@gmail.com>
References: <20240812150925.31551-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In comment of function mas_start(), we list the return value of
different cases. According to the comment context, tell the maple_status
here is more consistent with others.

Let's correct it with ma_active in the case it's a tree.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 14ff54078f9e..026197c44988 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1347,7 +1347,7 @@ static void mas_node_count(struct ma_state *mas, int count)
  * - If mas->node is an error or not mas_start, return NULL.
  * - If it's an empty tree:     NULL & mas->status == ma_none
  * - If it's a single entry:    The entry & mas->status == ma_root
- * - If it's a tree:            NULL & mas->status == safe root node.
+ * - If it's a tree:            NULL & mas->status == ma_active
  */
 static inline struct maple_enode *mas_start(struct ma_state *mas)
 {
-- 
2.34.1


