Return-Path: <linux-kernel+bounces-522236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3309A3C7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A32E1895402
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327CA21506C;
	Wed, 19 Feb 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/1AACFr"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C856215040
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989936; cv=none; b=jx+lCiw+u0uaMGFoCLQkX2pJ2/zAabmAf7EFVYyKNk7LbWrIbMkD4EYuti/GRNAEsp/ILoKlIUuXLQdks0Tpct2TmenBlCaDKjcbPHyEAo9CbYmbaF4rJTStDBXau7uSPsm/XOLjNwC4sPOhgy/A64iCnQvWAyjEZc8inPu2nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989936; c=relaxed/simple;
	bh=QfyKjw4MDCgZaOxGfN2uwVxtfrJyJLTRioCkL2n1c34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQ9LpJeTM+/L9Knaa7PvzIvNaIwRDOlgxKr2WdjRNuKQB+me7AZQfJxOgTpX0jFtkb3DLUU4cgLlqe9WI90cHW0uwxQEFI3Bx7C3sVDeb5T/uZ1UVDV+Ur8J3BGZKrsVAIcrBvSgJ3XomabE4rQyTTvBZnISrN4hF4CwThxsTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/1AACFr; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-221057b6ac4so427995ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989934; x=1740594734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55B5QwxESijKOi7V8xRhvFTRJ/sEBfufvBcf3pQsyzE=;
        b=H/1AACFrSUKXSOp5WfrhQJc0oN51n5lNWG+uU1XOZFaTv4QcWuRYplAvO18ocVIgj5
         3Ew5nwM8ShsIDib0kj7negpbNlQskjIpa+eRuR8Y1V1nR8PXn/NDGoUmObMXr0USAHDl
         hNGyIbTeh9IauUq4/qkCg4vdIqA1CySci8z9hJJ//FS+N6r1bbnC6UqAa5VfxI+3/Q4H
         RD7Fua5Tj2f1kgjjlXAUkEWAfV2CRGFukR45qQ/tmFaGkofirN4Tuext1CLOpudQ35eI
         VjeNw5920EK39EKMrXKQJHGmpkoRF+VVZReGuqQmUc1/IzAL5dAkpmjLQVb1zotE2dbN
         +oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989934; x=1740594734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55B5QwxESijKOi7V8xRhvFTRJ/sEBfufvBcf3pQsyzE=;
        b=K8/P62LadLPpdvrKgRSSh0Efhe8Z25xzXUADEUw9l4cOOkHCwpDp0iwB9omKVHZdIl
         APGTIP9Q2rsatBO0sauT0OBTVqhfudFRrbmY+96YYFWfVtQ4CM3bDHgJGpIjsN8cRJVa
         AI8Vw3ZCMliTEKhCQcrGojQRdCibO1qjmEQ0tYt+ld+AVri4H3mkn2OxUCzLkfrCkA7l
         qwUYLwxKZQkieMxlqlIY24t/JJtFMMInqiSEFO6vNdtBtj2F8nZrhutUc+fmFyl8otMn
         vGpXk13fNT3tHLXAlbeVpAoC5MiBZKciKExQLY+3bOPkI65zwpibMyNRX5RJU4LNM6jH
         OSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmkV0J6kmiutK0k+5XftVNHpWzpmIT5xHoe4wXVBkDu2RTA/8y1QmzcTf4RgOBHErDA5zEm0Gt4IQbDPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IihhMNIo31t/MLP3BtMAlppKdgt6F5IJsswGYmIevi7aBfhY
	CoURNnhiupM80b/r//jq7vvUwtQbFrSeMTCu8s3//gkZYznaehfW
X-Gm-Gg: ASbGncuH8MUdkXOS8HKHflbfBR2ZQmzwTdgLKo3VZR48lbj2rfZWbBBgtdfw13/Fhgq
	kOX+Sfr+s/Q5jsmGjFP8SnBZMYYBxBh/DMsheatBM6N5uJYxzR2vpNgFjirZUWaJOoqJ71IqRJV
	Y4STcgpOQ4v/1gCj1UA3uC5qwEtOcbhBP+C3HuUebwQkhAsje92ECPGnh5HcSyca7YjMagweCmF
	MrYJnyqG51fhh4tQLOmReuIm1/dmNiZThtAH3mVq3sW9t+Lzz+sBy+qpk32ko3Q9OOP9wqoeSCa
	SE13MQs5J7hLAQWhMFpZ
X-Google-Smtp-Source: AGHT+IFBHN6lLZxWjiYIJ+WMNnGCRA7mLu8siipLcS72M4Pd5NoxJqK72OpswCHL8Xh4vhLqsV6Xww==
X-Received: by 2002:a05:6a20:a11c:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1ee8cbe3aeamr30297976637.33.1739989934287;
        Wed, 19 Feb 2025 10:32:14 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:e1bd:18fd:9875:3b67])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adf06b0ada5sm5567513a12.19.2025.02.19.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:32:13 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH] staging: most: Remove unused mutex from most_video_dev
Date: Thu, 20 Feb 2025 00:01:51 +0530
Message-ID: <20250219183152.176679-2-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219183152.176679-1-kumarkairiravi@gmail.com>
References: <20250219183152.176679-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

The `lock` field in struct most_video_dev is never used anywhere in
the codebase. Since it serves no purpose, remove it to clean up the
structure.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/most/video/video.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 2b3cdb1ce1..bd51125698 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -40,8 +40,6 @@ struct most_video_dev {
 	struct video_device *vdev;
 	unsigned int ctrl_input;
 
-	struct mutex lock;
-
 	wait_queue_head_t wait_data;
 };
 
-- 
2.48.1


