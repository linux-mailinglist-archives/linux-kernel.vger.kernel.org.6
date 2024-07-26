Return-Path: <linux-kernel+bounces-263294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D2793D3EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDC11C234E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D2F17BB3A;
	Fri, 26 Jul 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ig8CGHxq"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB01791F2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999648; cv=none; b=rp6N5Ab+Y31FtwpYHGUUudNKhIHR8FqxUP/4rcPBL3+6lwdGD5hcOfp0nIgaFAM/vVSmfAXgVbU7EagQppc7eqtiMCQ0bvfh6/zmRDx+J71q/oSviAFFuxezildtEpRdbWou8UoX8uDS8yrt7ChWYUJD1/N57JzEwQbHDrJvaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999648; c=relaxed/simple;
	bh=zKRonel3dcABAYymNbSFeeIxfDkMMBCHYpk+c9VI+ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QLjGQlRg4jjca8FEOZACnnqwifZ+s2VD3lxxGHo7ZH4OyhX4zdiE0oWOwEbwBSd0UUNyKHsn6/oHOv2sug1zhB6jyfIt+G9GJ6jZLk+BDZQECZE53VsX0lHcsRZwXFOgioHUwHGSx7EWFuqFen9aDmFHR892+EDZHjxuZg5GS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ig8CGHxq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a94478a4eso292231366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1721999644; x=1722604444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXvHPyArhhjIiorN2yza9XJ2TO3FtK4S2TKnt6WqquQ=;
        b=ig8CGHxq7KA7KCDuTmNEFh+hvPHVEjHSQA4V89IWc/L/mHmzH1oO1G5MKrGZ7Ge28q
         luOStIAwUWmXeePrnud+AyVYjpqlN03lIGSO6hXdhJQoYTUYA/XLpfbAbmgPCVPsxy9t
         ebjFtCjOzdAXYzVoVtcnZTDaPLdBUWWf92Kss1XeTSr++xvleTeC9N0I9Ers4SJRt/Tm
         vot/VAxlxBnhF47bGnkY9LipQjsY4B59FnReo7aVAwyFILPZ40lc+4JGOulwvSOK2MEF
         +zTxYN8WnEhEvbk1psHA3WJ+538mvIXEa/a1vRC/kJoNLDq6H1OCSsTQ8B0xZuqsS7Hj
         MZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999644; x=1722604444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXvHPyArhhjIiorN2yza9XJ2TO3FtK4S2TKnt6WqquQ=;
        b=evuJe++E+fn7pRizgMiE3gcE2n8idPwya/oapkLN14j8BY5lsEa6/a8f2ZNerGvGjA
         NekhhX4TaZcvbvkIb4pZ2Je7Zv0cMqupHQHkDhq/edtRQMSnj/6w8vukqzJBHBvI4yDz
         0YAiiVql+24YKzq3acGn/RU8r/seXhvHG4yyEVKPhRGjqma4yYLOR+rZwsvno71Dcnt1
         IG0zpzvlVHEfKZSt9HyK0KcfLudWjZC5toS4+AqfDmcak8wgc4G70ZPP94YH9+iMFEEE
         yzW5RT0zw7kmZ9wvFtmBeLSnboNzj+mbDr26XfR5mBqMokU5Bf+NGjn2tt+RHXiBL4rC
         xvWg==
X-Forwarded-Encrypted: i=1; AJvYcCW/f6eHfCriRrkIay0mpOfTwZKKlBS58eZCzhFf5H1b96etUrouHREyrw0bA8iqloG8rNkS86zrG9j427yEwN0K48r6LqUbTQHQ5bPj
X-Gm-Message-State: AOJu0Yz/RY1BNb23hMHVOOCEg84rqXQ/XRPoliDP2cl5m5waDLauXAng
	wR4PZ+4r3ZeKzingN0DHCeswGgnXhFtbiT23ljNythHhq/g3AFLAXOuRdcrFFyM=
X-Google-Smtp-Source: AGHT+IG0Nli3WfDVUKwHoHrSXGJEPJa8EUIBOFiGNkEt4JJV+jZjXHa4eTmpvqc3vrhYSG+9tGp+cw==
X-Received: by 2002:a17:906:a887:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a7ac4691c06mr484862466b.22.1721999644387;
        Fri, 26 Jul 2024 06:14:04 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9a12sm173319366b.213.2024.07.26.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:14:03 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jglisse@redhat.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] lib: test_hmm: Use min() to improve dmirror_exclusive()
Date: Fri, 26 Jul 2024 15:12:46 +0200
Message-Id: <20240726131245.161695-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use min() to simplify the dmirror_exclusive() function and improve its
readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 lib/test_hmm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index ee20e1f9bae9..056f2e411d7b 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -799,10 +799,7 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 		unsigned long mapped = 0;
 		int i;
 
-		if (end < addr + (ARRAY_SIZE(pages) << PAGE_SHIFT))
-			next = end;
-		else
-			next = addr + (ARRAY_SIZE(pages) << PAGE_SHIFT);
+		next = min(end, addr + (ARRAY_SIZE(pages) << PAGE_SHIFT));
 
 		ret = make_device_exclusive_range(mm, addr, next, pages, NULL);
 		/*
-- 
2.39.2


