Return-Path: <linux-kernel+bounces-402129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8359C2445
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1411C25DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885021E109;
	Fri,  8 Nov 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QgTefese"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5321A710
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087921; cv=none; b=fjAm/pg5XpVKbng4YwJzKLaL7r6iew+rrnjTBRzo/nac2at6dSjHnS6WIu7Q3uUFYBgFRTh8vV41R+99e602Vvh6GfTWaLZ6W//nXxP/+mB6sf/oA92sjlXfeOHfHpoI/jbXUmkveg4ia2U3WdqWEBi24JTdI9OMb/Eb2ttpW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087921; c=relaxed/simple;
	bh=SpPgvJ1Ucle7567qSYAlsafWxvPkBXjWNV83/9D5Z3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXYVI+VVzfqIXZbKAGD8kjQweTeehXvxUAxKLD2Xy6GyCuY115NbZtMRW82UejkEyIHuDiD1CN5U66xTEGCKDu91neyAJff9z0Vy3nS+sQBkYFY1DbM2QDbvn5saCiIdwsufVTrFZ49lb+5GsqA7bj9XeQKz68tnIhYRndez38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QgTefese; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e607556c83so1581575b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087919; x=1731692719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPkGwSldMNFXF3cURXd1feXLkclwp0ZCxyEpzT1cPW4=;
        b=QgTefesezjL6yt0YcDXrIafVcZ4En+JuRAc1rdbDoeHUtEYsG4hAg+fHlAjU1yRh6l
         DBcLsznGPacdN/HaFGb1Q+8FAFpfSSEwgeTa+9I4y9MzxrhLZDnb08dLNF2bxn+tBTUC
         FvrklWMXvlCqu7sNkjdnZFPYynBTicRuaMDrEiFBUDGo/e6H1JW93kTp4HhExkdn9owJ
         9XIC+pMxrHDuhrHB1U65vagZkZuj66cehY+oe/X1jT43H7nLKwOkq0+v1G/NqKqjRO0b
         bjUmdL01IHwCcRUsv/e3MjA3YeBnLL85v+NneWmbFIiLdmmmGD0/LK/P6BCfsHVASwvQ
         GFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087919; x=1731692719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPkGwSldMNFXF3cURXd1feXLkclwp0ZCxyEpzT1cPW4=;
        b=JFbSnc4D0qUKz5nTL1k4V3ITk3CXFPq5FJkF3AhrCafdWUp/uaT4IkOUDnsfaPvhqA
         tw/zbmnPJL082g2VKICU5bOrFPRjrklGNXisKk5NpqAhbzT7efh7NiPKw8LNp67+G4In
         0InoBIFmBYiPR0s13luRIhWGHjcLwWqCgjpRTfuLzgwnUDu9d3y5nVDLm3lUzXCG4TpL
         pK6ZMsXgWD/Dqn691Nz0OhKAhKhY0uU+SaLMLqt2boFlkCCsd/3qEslx0wvqRH75GaZ0
         FjqVmaKY+DMkhGwVJYE+a3KCJceOZakqPd2BGnCCgAfuYfnMKykXDViEuQ27F2Eg3AJJ
         N1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGFMAgzYdnr7HhjQNfIg216YSF1ZHNkuuWbLHJPmLs4U0T374pW9CJIxNV4NwwU2gcq4aucmob3ZjZHjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5xmrP12ZHVbWWWZqFGzYUI7xIAQ8PUfj5PtuqSfzzswuPk8c
	qbDZ+wtbZ0jBjfaS8+LAhHPIO4lJ5j9JP3UyROyuElUhrjnWt9chrsNfklS0U/U=
X-Google-Smtp-Source: AGHT+IF9qnEH6iAmuqzMOZRDZm41rR73Vxyg2vpcvzcsSJsHVKcaTPsimGzR6K5FioRiJT7HzzWlGw==
X-Received: by 2002:a05:6808:2119:b0:3e6:134e:3b90 with SMTP id 5614622812f47-3e79470a347mr4589807b6e.30.1731087919330;
        Fri, 08 Nov 2024 09:45:19 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/13] mm/readahead: add readahead_control->uncached member
Date: Fri,  8 Nov 2024 10:43:27 -0700
Message-ID: <20241108174505.1214230-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->uncached is set to true, then folios created are marked as
uncached as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..8afacb7520d4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1350,6 +1350,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool uncached;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 003cfe79880d..09cddbbfe28f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->uncached)
+		folio_set_uncached(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


