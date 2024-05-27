Return-Path: <linux-kernel+bounces-191393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838678D0E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F91F221B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6B161308;
	Mon, 27 May 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCWzREyg"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBA1667FC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841828; cv=none; b=FaF4cbKqnRVo/E4CsdrC5Fq8smFJVweoCqXKuk9J3x5ZDfvOQSZDvkO7VzL7b1AL3Vbv12rRgE2GLgnsbThVu3N4++Ktp4dcFvZY8xN7dERqsqaUfoDVg3cllBMgEeCZbfwNuyHNkG3F7Rw+KIJdtK8acVwY5VtnBWr7JvOTHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841828; c=relaxed/simple;
	bh=RKjvan0E7Im/7BRlGrzyeoNxj37ylBgB9GBoKbO6QUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HwDxP3kM1xrJot68o/Bo+C7SpyT0J8ixvHfs+LEZLbpfEYSFAgkd3IsKWukT3Q0WjOnO0Mh/FQfPLyAjWH7Rv3FChuIU2NPjgbXhaJLx+OveUprd9J3YurvXNsfqItrWA9RFSHBF+yp4KyazlcxzcAkl7QljhKZ4Ic0kpTsONGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCWzREyg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-667fbbbf36dso9917a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716841826; x=1717446626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVBlz0vl7yDyH9ZJUwo7OCKU71+Ygf2UNq0ZwoLT7g0=;
        b=CCWzREygNaU3QvnCMwO2kuJDGDFpPrXlDCvIrIThcnAoUL6CJmzUsz23ogv8sVPSR+
         wRA5cFuDLQwO6XV4BkSU2KoFT31oueW+PbkiuXTzLj0DkbIUGoEg+VilA0pQbNnRlB5y
         m6AZx3hDttSkHeyzoN5fVD9kmclsikFlYyILvb7aab4xThEfUx6w/qUBGcg4Ff9OgMaW
         OKuW7uTm2Y3uEEnwqM5YkvrdphtR/iHmEuTIt83+E20fCdUdhrBFuoyTl0uH7nwrnFN0
         YQl8fXwsUwRzlVEsPxpglhGShKcOqDl03qebrvUdrvCEncBKBJa7SOoXo2xE8fuJtjU/
         05Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841826; x=1717446626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVBlz0vl7yDyH9ZJUwo7OCKU71+Ygf2UNq0ZwoLT7g0=;
        b=cj483LK5q5SFpI/yO5+fAJVamVRTEMKpTiep/4KKtSXXgmCkOvxcX0qfHxzqpMosyb
         MJj4A9JbsW2+l0YhWUtKdxSUSkP8aqWC2ntAQIHVXgMoVGjKkIz+UJZ4CAlx98YsQAgS
         Rqjo90xuJjQzoqRo7CEg/oce6YhcMmKKMoSc0i65dRP1ZRWijY3kqHll7n5s1hZotAQw
         Q5R5Mivfdajk0Eu4yT8M5EHPfjEMozDV4xlegBBCEjqUGbHBIjEK3sIUfAXQfaVR2JEk
         iK4u+I85cfhn5MSrAx6m8Y1rdgRaWp+pVzaGxecE6XE5Ju3Y+V8FjLtdpJZhFmHUfJoc
         iEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUxs8uD3m2RwCO0YohMs6JbmaiYMQltTvlvtkB+XLG8qATSFZ6rJgAFlAkSzrrgoOQ7/AMvn8u4GVDn883SWF46CPoRkJHOqs6SKnpE
X-Gm-Message-State: AOJu0Yy7ApLisYcgSAKaOoUAiwNlfsFGvgqre2zu4jHqMjLWJRJIp/5G
	vDvAsLeSIQrxt7wjIsrFTqZRCbvvG+FCAHI29tYtNlV4N+lmGV40
X-Google-Smtp-Source: AGHT+IGOWeM2xnSztaV/irrmiqlYuhiEx8We1Pn8+7m5wsLcukICOnjli3kKbMCoetXsgFNmc4z4Vg==
X-Received: by 2002:a05:6a20:9489:b0:1af:a4a5:a26a with SMTP id adf61e73a8af0-1b212cc65e8mr9715951637.1.1716841826471;
        Mon, 27 May 2024 13:30:26 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092a678sm5324279a12.11.2024.05.27.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:30:25 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/4] lib/test_sort: Add a testcase to ensure code coverage
Date: Tue, 28 May 2024 04:30:11 +0800
Message-Id: <20240527203011.1644280-5-visitorckw@gmail.com>
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

The addition of an if statement in lib/sort to handle the final
unsorted 2 or 3 elements is not covered by existing test cases, leading
to incomplete test coverage. To ensure comprehensive testing and
maintain 100% code coverage, add a new testcase for scenarios where the
if statement is triggered.

Since the if statement is only triggered when the array length is odd
and the first element is greater than the second element, a testcase is
created using an array length of TEST_LEN - 1 and a suitable random
seed to maintain full code coverage.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/test_sort.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/test_sort.c b/lib/test_sort.c
index be02e3a098cf..da4495125097 100644
--- a/lib/test_sort.c
+++ b/lib/test_sort.c
@@ -29,7 +29,19 @@ static void test_sort(struct kunit *test)
 
 	sort(a, TEST_LEN, sizeof(*a), cmpint, NULL);
 
-	for (i = 0; i < TEST_LEN-1; i++)
+	for (i = 0; i < TEST_LEN - 1; i++)
+		KUNIT_ASSERT_LE(test, a[i], a[i + 1]);
+
+	r = 48;
+
+	for (i = 0; i < TEST_LEN - 1; i++) {
+		r = (r * 725861) % 6599;
+		a[i] = r;
+	}
+
+	sort(a, TEST_LEN - 1, sizeof(*a), cmpint, NULL);
+
+	for (i = 0; i < TEST_LEN - 2; i++)
 		KUNIT_ASSERT_LE(test, a[i], a[i + 1]);
 }
 
-- 
2.34.1


