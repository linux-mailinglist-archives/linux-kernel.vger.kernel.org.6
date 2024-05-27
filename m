Return-Path: <linux-kernel+bounces-191391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302338D0E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70D11F22236
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58ED1667C5;
	Mon, 27 May 2024 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZv07vSk"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA216133E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841824; cv=none; b=ndiy7L1mhK99HCKy8lqomfHQ2aRTcRTl1oc/OCG5wQh1qEqXMQDIzqD2ka/c+6igP3cQndsYJoWkQxWLtIWTy4GAHMaptR/sb8f0RGzEHW8kFEWqSN0zIrlkZtqABIsHZ5KH/7IUTSznyzVTRYYNOQPSmHWuSrg6xPFzyL4oG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841824; c=relaxed/simple;
	bh=miz7CyMIADUVHaJwVFLRC9ZGG4NWk6IFWm7j6D/ics0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apTqPl9crRu4tLXXGBTjJMgBUWlA572EUfs21RXnm+cb7BW0XcOZ8+6j75Oslc5G/i7GENmAJ/LjGvsASGGsGpb1QKLISvEvIzilbnC8HVPUXrexzuLHMcm+7DekMti4Gv5I7LTSyHh48gOKjSP3GyHLO02zig2iryKViSCFzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZv07vSk; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36daacdbf21so59635ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716841822; x=1717446622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i004hZB22bqjMNJFc+n67bTnhzWYs+D5uA7aOWn+Ye4=;
        b=lZv07vSkEuMmlhG6U3SwC0gTcyLGFXh1sFrkRvrjxV6h0H7asYyGV69xG1za02kEKX
         swmt5GDnji64tmYFUvgQDXN97qLUee2xAczOd+6iI9F7QpVHjV6JQNUUj9p4uHLhQHaH
         Hmnk6fpwO/EbNBaCy/Ch1LFib1K3WAWvpUb9McPSDs6W89KhOd+bGfdI5AZ2jWT24af3
         fbBQHjXBo0vD9jN4nLQK7J3S3DVMGDyfqlG+Tut8nnGlWnVz3ccjhlhdC51rlm/YPK4+
         yR7wlMtJiqhYVYttma412PkaGupI9TWmPIdlLK0pexn2xMMkakxH3DtQZ7WucO50tOWM
         3sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841822; x=1717446622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i004hZB22bqjMNJFc+n67bTnhzWYs+D5uA7aOWn+Ye4=;
        b=N/LSW2XZjpjhu7Bqr1rszC23XOyFxkFIksfIV2LggO8zmWGd1X6fDxb2NU1nFtuLlB
         VbdyNeXkKbQLbTpxjf40A/MPvgpvMfguarh6lfPI/zZvQTlknPWx3EMxxpY/2gPwvM1U
         U1esNByjSKLpG33f9dN1JWvGLl2gVYyPg1q9H5cTCy8ya1cADCCOp8CT578IazF9THWw
         aDRiBlgGjQmO8vQXyxAIYubFFd2E+Om6U8qYp+C8mHvzCe5e9GX/YbiKpAScHwLuhO2l
         8ehEPfWbRde0XiQYMGk5V+aEvvPp6Lqzrr9aHTZ6Q1yOZo85/8CtYroKfG470vVpBsk4
         ZkiA==
X-Forwarded-Encrypted: i=1; AJvYcCVDB/NrrMdFIHLsRDk3k0XiOCDdNnMadMeIkiPt88mVzP0WH90tcsU1BjAjxt4A5flpGQpT0Sv9yCd8TncLhX53xNEnqsddUg/IF0Hk
X-Gm-Message-State: AOJu0Yx8/Rq530mUF+1urA/bY0SL0SlXFzNNuxiqS1JjmhWaZmd5BwmD
	BhuihUXs3RgQeiW22AFdy3OnM3zd4N280tf77rWJdYlOZ7NbcicB
X-Google-Smtp-Source: AGHT+IEeDtdDFbyG/VbCJB+hOYKSqRLvSuvYTT9GOjcWHVn/us0YWPRGyIqHjDl2WGfON48XahWsFw==
X-Received: by 2002:a05:6e02:1d83:b0:36d:96ab:f4a with SMTP id e9e14a558f8ab-3737b2e3524mr110040075ab.1.1716841821738;
        Mon, 27 May 2024 13:30:21 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092a678sm5324279a12.11.2024.05.27.13.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:30:21 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/4] lib/sort: Fix outdated comment regarding glibc qsort()
Date: Tue, 28 May 2024 04:30:09 +0800
Message-Id: <20240527203011.1644280-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203011.1644280-1-visitorckw@gmail.com>
References: <20240527203011.1644280-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing comment in lib/sort refers to glibc qsort() using
quicksort. However, glibc qsort() no longer uses quicksort; it now uses
mergesort and falls back to heapsort if memory allocation for mergesort
fails. This makes the comment outdated and incorrect.

Update the comment to refer to quicksort in general rather than glibc's
implementation to provide accurate information about the comparisons
and trade-offs without implying an outdated implementation.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sort.c b/lib/sort.c
index 651b73205f6d..b918ae15302d 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -5,7 +5,7 @@
  * This performs n*log2(n) + 0.37*n + o(n) comparisons on average,
  * and 1.5*n*log2(n) + O(n) in the (very contrived) worst case.
  *
- * Glibc qsort() manages n*log2(n) - 1.26*n for random inputs (1.63*n
+ * Quicksort manages n*log2(n) - 1.26*n for random inputs (1.63*n
  * better) at the expense of stack usage and much larger code to avoid
  * quicksort's O(n^2) worst case.
  */
-- 
2.34.1


