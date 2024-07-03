Return-Path: <linux-kernel+bounces-238993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED492549E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A3284AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0D1369A0;
	Wed,  3 Jul 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PKCFTvpw"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49C131BDD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991794; cv=none; b=fmw0Ue0n2ezRlup2UvmNotakAqskQRuJGOnWIPvA3A3DR5Vsc4tSSxFK6bcLK//9GcPpqcoa4B/gigIlWSoePzhL/YEoKtgSpqAdkjyU1ofKlsZyZyhG5eyuD/vmRKkGwSvHXoCzjJMYLjh/Xy9QHyMFmjwwcHGqQqZkv1pw3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991794; c=relaxed/simple;
	bh=ZgpTGg7ZhLUOVu5lLH9uwx5tIQp5zc/pXJ0uUfZM2Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPcEYT5njcXsRt+IWnFc+uXk6fJLGW/4E8OXuNf3ySEdgcpl2WxOwBzJHducErkSPzLoCGq5NbF45iMsg0MDC5QDzrOjppldSRGPvCNy+rGJKKUo42TAGimjyoK/O6S+cSo1DxogENLP4T8QRhdwdUEWnFmcKqDl/P7DkoratDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PKCFTvpw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066c9741fbso4316198b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719991792; x=1720596592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyHOv+1TQs3NJgyrsK3G70btEgM4PBOJQcOuP6+/cTo=;
        b=PKCFTvpw5bXb4OQexhnk1hkKHZIMmU2RAbXxjNTzeM6Ni4DtgG7gwv1JntMkmQmm0B
         rYLKZs3SYy+meTYY+sShbVkhj0Ewtm48EF8hvfPmJeL5lOtidw830HCjnLGQO9dCGu9q
         wLWkr81aYV9OxbZWUNIGF2UKr9eQmFwZTzUy+sAA7pN6qGiYJPhwNr+gDcxGSCteuvWD
         maRilwBFMp244KZpv+9vvX7vwrCq/dRXwZdGKECpX4GphxnGB8r3/To4mnj7L84zNsHN
         3axF/jx6f83zLGwkTTgHJmFWmmUDQ+yC0ERm1xsYZGrmZKuvR4e8WCk79uEwS1VCsj0B
         eyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991792; x=1720596592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyHOv+1TQs3NJgyrsK3G70btEgM4PBOJQcOuP6+/cTo=;
        b=Vad3fguEVkW/RooIG6TfKsEqtnNZp93TjBBSxPDYp0il5ST9TLzAq0aq0VCU955cAi
         wIh5E08tZzOjo3t9FQjIUr37r2FzirMMGYBLGOAkqrIzod0b2uolDl3GJmnparunt/Qs
         2Xreo4wfxdYU8paQxbxgpnZIkCN45rYFNRnZMeAuzhfdz/YXezZy07T/gQ9Z2eIhShWm
         0CLkmMTpRvjBm5kkZ3GixBC2vBvEaGHOCkOxaFjcHns8jIhWarlhbv7VCp5R927WsCxj
         UpLq+q2JpV1P3mbTi7YhMhlDJtfmIuQVWQLHG6zBSJQ7Wclrwor8EHweGbVU0HfrM5OK
         DgTg==
X-Forwarded-Encrypted: i=1; AJvYcCUzN7drBMWzoh5OUoVd1ZHrIFrNctd7NCncJe/v9KUmMxgRRiUzzFa2+NFICNEi6F3EYVTmyQcbiwRT9z9EkgFyzCnRnsHSyVrXdeu+
X-Gm-Message-State: AOJu0YySS50wwIvl4jneVEDIwr/boD51+g6r9xFhWwHAdDeWVJm0Ymkp
	atehpvT8DJLFZTsaEhrnNqWTNCeZ6og5mziKrGnjjetCzA+PID1OgvQiW2OYF20=
X-Google-Smtp-Source: AGHT+IF/2q2bYv+AW1oYPuOUB0yCXXmEAlApl3JeOfwhHA84IKB4Vo8dFV5LyPLNM+Hvub3oz8ssbw==
X-Received: by 2002:a05:6a00:194a:b0:706:759a:70bc with SMTP id d2e1a72fcca58-70aaaf32f24mr14483206b3a.29.1719991792618;
        Wed, 03 Jul 2024 00:29:52 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802959d41sm9993502b3a.96.2024.07.03.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:29:52 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: ogabbay@kernel.org
Cc: ttayar@habana.ai,
	obitton@habana.ai,
	fkassabri@habana.ai,
	dliberman@habana.ai,
	quic_carlv@quicinc.com,
	dhirschfeld@habana.ai,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvcalloc()
Date: Wed,  3 Jul 2024 09:24:39 +0200
Message-ID: <20240703072438.725114-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kvfree() to fix the following Coccinelle/coccicheck warning reported
by kfree_mismatch.cocci:

	WARNING kvmalloc is used to allocate this memory at line 10398

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index fa1c4feb9f89..8024047962ec 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10489,7 +10489,7 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 				(u64 *)(lin_dma_pkts_arr), DEBUGFS_WRITE64);
 	WREG32(sob_addr, 0);
 
-	kfree(lin_dma_pkts_arr);
+	kvfree(lin_dma_pkts_arr);
 
 	return rc;
 }
-- 
2.45.2


