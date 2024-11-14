Return-Path: <linux-kernel+bounces-409528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980779C8EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D49B31A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CB18C935;
	Thu, 14 Nov 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="arnRiepF"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E94187870
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598090; cv=none; b=B/6SLtzvO6ZLp3acqpJrWHhUhwRE0Q+zfOkw6S06ji5QxRjuXakafT3sWRn4POvHIjdq42pkdGV7p4FuY/XIqKUwH1RNrcWNTSuZnWeRuTxnx6qKjNG7MEn1Yw7UHUbfORm8CaL4uGmW5di5pz9SWOyo7IsICKiI0hR36U5try4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598090; c=relaxed/simple;
	bh=AFLrZl3fH+/hMhwZTjgZ0OWM0ndgzDi220n1zUDQffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/HmA3rYuZKGzYFz3ND+oSN+N/J1MrYBPUxtbOx7ZmlGq9U6BbhTSRzWxJIazBOTOMEsh2ABn7KLJIrd1FsbDNZ39+4d90uZ0zhVAjz8a884h8A0XHqSv96xSGxNfTDxB1kYOJaoTHBRMWT5A1V4WKkpj0eOS8WEncd1yCv6d3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=arnRiepF; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee645cf74fso364374eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598087; x=1732202887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=arnRiepFOtCGKagziS6xtO4Vv/Jf+8LAVE0J8ryI70wI6+zLwxYTiedTsJ537HC4a2
         LNlkH6zA2veKrY6gC1AV/soymGZv4dcjTFrRd401ey51Z2ZRNhbCWz1MrRG2VaHDZzZU
         CtXa6Q7kxE3rM7/IfGcF6ekYH/Sf/DSYhadei8uNuwK+yUUDnHirrUBAfcWJ607o30su
         d6FeQ+b3xv7erZkoT8Tz+ZkoIVPCu/Hde48Xczj9XrRav8FokUakSv8Xe5BFKkhjJUpF
         y0R/VAeybRFMVsO0vmqjYr9OX8GJ++AAgoqqGbbxdip/H442BYrrkZHwQK0MuurJgjD/
         r0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598087; x=1732202887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=tDwc3VkmQE0gkPvn8GwAydszBYM/Sucik3NYrp0JmWMzIIUGjiHDtwXD2Xy8r85ykS
         4NdDr6i8LaWa7sdvYmIDpsPYCubBQjP5d1rNrf2kD8+xqQIoNEHyqLdPuDMaO3LbuyLe
         ziS4Edubp3XrJCF2JfuyvTeCIiIZEu7Yiq4q3OZp8qA3iBfbwDzf0ZuCtOS9Xb92ik5o
         uPAqpkJKQHzim5CZqd+LOqCxAkDvx6vskR/n3YgMBZzECgihhadnieQI5ZN3pdU4OPAX
         x+hCn0LewDkgFFOfzOZKIBlWgQpMHTgnk6yJN1MRcOZBKVbsdIOAZp9aUypOtc7UyHcq
         E43A==
X-Forwarded-Encrypted: i=1; AJvYcCXtcyawVX0xlLLhXRvT8JmvKj4g2XhOEW1Od/BssdzdXeiLHM6jasd8/CDzuYmcUqEos3qgr6iONmBGFr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64qltjF6/RhFkzMQ+zcQ0hAmaQI7MHS8PG9BTJsysO//a0nn8
	D9u+0zcnDUMO2BLlz1cnkvfKTgBRZ1PyduvHurxKvA9NxgnwfaODFTjBDINctF0=
X-Google-Smtp-Source: AGHT+IH7eepGaxoKX7XFVQSCKcZ5tiiQfUtPjwDWCbNdm4JNlvZQy9y+41dOTUM8EVcPpq30RA+88A==
X-Received: by 2002:a05:6820:278c:b0:5ee:710:83fa with SMTP id 006d021491bc7-5ee922a81aemr6235784eaf.8.1731598087197;
        Thu, 14 Nov 2024 07:28:07 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/17] mm/readahead: add readahead_control->uncached member
Date: Thu, 14 Nov 2024 08:25:08 -0700
Message-ID: <20241114152743.2381672-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
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
index 003cfe79880d..8dbeab9bc1f0 100644
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
+		__folio_set_uncached(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


