Return-Path: <linux-kernel+bounces-435522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CD9E7901
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58552162673
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAE1F37CA;
	Fri,  6 Dec 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WIaj01zc"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360C1D63C0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513594; cv=none; b=ri0W/0OAtlZYtfgOHL/EyfJffpp4UFgREavWZmHoTRG36fTcL7V4vOe6y3uDAJtZkwOWHpmQB0+Wtl7ZvonfdB7LXfHVErkR95Gi/yk5svPvOJXSypyOm/RwG6JuDyOJVJ62c5MM5ifAHOq5ymtQKFX7NDYvb90SB7jiJHLiHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513594; c=relaxed/simple;
	bh=kmwXrDdVSFzX1RWQbypl4/vyclBnjb9SVqQFwYrXRpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF5OT881U90H+/2ggL/2yfGGGvYYYtax//WetKpQa8jPP1o1rgemdGlDPB+ooAeoVlhgacwZ5IabH/Z1slWBj81rVio2YoseqG9dXeT0FfwvSLjBSwBM3K8C2xqqSmDpPDhClNojZH3PXCUarO/1zOH79ruirz7dSSJL0qEqiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WIaj01zc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7eab7600800so206447a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733513591; x=1734118391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HltmlFi5Mtjm1w1ygcJnz7XyQYUTr+uzffhTeU486Yg=;
        b=WIaj01zcjV8N03KzoeHjvsmbHEY1uFBaCtqQrd3ctCp5lXwCtJZ5Qf3u6srdCL7dx4
         O2BbsdhG9YudyWBvaLZFzs1Gg6IB0Wer91bdMqNkl+Ew9MlXXS+TAyzkb3czxiB+6E3e
         y+GNMnPvh/446pxiRm3eWa3lixq5Ag1a4pLQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733513591; x=1734118391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HltmlFi5Mtjm1w1ygcJnz7XyQYUTr+uzffhTeU486Yg=;
        b=KSly+rHukbEUskljykfIgFNCdEzu7V10A/dIehOrRNuhG38ljl7bsl3M19XMeH4h/G
         GUnd9rWOCzCjU4v3W2eaFfV0TD5RNXMCjgDxKyjBZ6ONa1fInr66V2do9OtWfN9bPvUU
         3GoM6qPfaPPPH1S5zhUmK/eToO4b75t10iDIZKPm6SBFanlkfWPcVRKUAHLQx01/JgqS
         9fABHFbwMqm9v3baV4PuMe4TCpOK5g50u15jvkgSlyomQjighHwFL6UtvSTDdD040ndO
         9kkRHjXS298E7dsAV6D2jrONFEnnp1V0GyMwccvpgmAJVnsj6gexxJFJCQAH/HfKrdVc
         gWAw==
X-Gm-Message-State: AOJu0Ywu0rbIcSYrE2zSPCMyGlWO6ffBoCkxS3ng2vk3ISNzNoACZHW8
	LUwWWNMqwegO1WeZsQtUseeaF5YMFYsaKmkfHjO9/dRUQ/VhKuZreRQ3BpIiag==
X-Gm-Gg: ASbGncuScJ43mlJUAdKnLm4AO5McFU2Pu7R3zI9PZpqxSn7Kb17qQo23K9yFkEM2B60
	jxhb9IkgvNTBuk7JjcoWOVqA/Akr7o9ZnvLfMC98C+Ud3oVttleVt5DerwOTBvT++aleOGkDHQo
	KiTKifo940Sf1LN7zYdbZVlB1l+cfbdlnfQwv7IBLOFPmyXNP/nIf52q+F4I0l/4qUzNN5NTZF6
	uFLOTTdYhUtSjHVA5fQarI2rDZDa6SB1lyaxz+evXyufK2Xwhrt8Tbj+lFuk+zyrRvcsklSScYD
	1mmlPJpxzpE=
X-Google-Smtp-Source: AGHT+IFyvwmM7rvSPgBh5Lg1uIbAIveZitsJmrI0lGdli31hAiDag50aHX/3xBKsUCxKFfbxFCRvHA==
X-Received: by 2002:a05:6a20:918d:b0:1d8:a203:95a4 with SMTP id adf61e73a8af0-1e1870b9329mr2877161637.5.1733513591343;
        Fri, 06 Dec 2024 11:33:11 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd156b7964sm2997645a12.18.2024.12.06.11.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:33:10 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@google.com>
Subject: [PATCH] mseal: remove can_do_mseal
Date: Fri,  6 Dec 2024 19:33:09 +0000
Message-ID: <20241206193309.3026213-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
References: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

Hi Andrew,

Is that possible to squash this change on top of 
"mseal: move can_do_mseal to mseal.c" on the mm-unstable ?

This is the first time I m doing this, because I saw dev did this before,
and saying this is the prefered approach.

I could also send v2 which is what I usually do.

Thanks
-Jeff

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mseal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index e167220a0bf0..08e6f328d9c7 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -225,9 +225,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	unsigned long end;
 	struct mm_struct *mm = current->mm;
 
-	ret = can_do_mseal(flags);
-	if (ret)
-		return ret;
+	/* Verify flags not set. */
+	if (flags)
+		return -EINVAL;
 
 	start = untagged_addr(start);
 	if (!PAGE_ALIGNED(start))
-- 
2.47.0.338.g60cca15819-goog


