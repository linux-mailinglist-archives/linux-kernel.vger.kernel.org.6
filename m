Return-Path: <linux-kernel+bounces-403259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1419C3333
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DCB20DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C77D1586DB;
	Sun, 10 Nov 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jpxkdGSA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46738157495
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252569; cv=none; b=r2mZP7l6PckF2uO1c8GtxXCyodJBselXFr7lgeQKLao0wIkI8Bsru0xLETiy+DlPrrTgV25Y16FQwoz4nq08jGsH9hVeqNUo2lcklewNTLQJJOejBUnWdhEROVfHOYFo3qmD4peIHUHgf0/MPUzgbsWdmC0vJyjU55txi//IbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252569; c=relaxed/simple;
	bh=AKt+S745U93BEmbA6t/wcRBIgQj/soY+rT3nJS7qXJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD4RIP+zzSqoN3B2FslaPh4xMUKPnPkufEjX5gwVsf02GV5R02GXbLhe6v9Pz58g0JjWzCc6N2VL/HPsybsmieSAHpTsmo5qUU2pU9iBOCUk0S1D10htoY5iFC0l4tmH+wziG+e/wRFVt6vZ7RJiee0BJq+k9k//w3XsIKSsGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jpxkdGSA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c9978a221so42261175ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252566; x=1731857366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtqsp3FpRWE9h3nra5m9D1cpUkXI8hkSCKuFCrWSblw=;
        b=jpxkdGSACE2RIfxZR30I6RLxlbnIVcV8CQP+caD3TJTf9MGEGC2rENCIMrdqFSyPRW
         sximQLDX7ngw6JwKo6AoBMqN06YroHpC69obYTg9zcR5TfthsZZKuRbYrE4DxXnDpU+W
         yNp+1ynCzu3wN3TExVe/C0PsKAYsSkZusARdnCjiszGVukDMpprVY8wcpxSJn8tJNM/A
         DojcecxZxsAZafCdfcjlenpPY0f1UhUBl2p0KFkYWWdxG3LXKTHoTUbrm22m5NvlpL9D
         tfYK5FwXHhCl7N+++ecZbUuTVnkhOQeBJHYZ0QrL8yM7tLJY1HQ1KkcNb8WwDQTc8uV+
         pAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252566; x=1731857366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtqsp3FpRWE9h3nra5m9D1cpUkXI8hkSCKuFCrWSblw=;
        b=c/J9HfKj0Zz4nLmb2lkZGl2BCKcbfiO/U1zLLyR8gjwQWsyQHfhVIlQph8ceRWj6Yo
         zIpSgR2Un1m9xjDKVvjL+TBc6t0f6zNGGDAwRqJktLpNwE12XQSykGDag7+suPIF1TYb
         VF+5gZzm9Bx6xHETFCPifnPwQk1pKpVWy2quQUrGRp/rGhnFP5XL1wmkyIkKbI3t16SB
         pOS+ZtynNgfeO3ORjj693yRDSPBsHw/PKQVRWOlMrsVDpyhvNVsuYipVQ12UBgkq39dp
         GoVDIyTaJpcCGYnuHylZw0fAD9epF7MOMyElTlAJaTmj8bS8iqC3/QVda7Mo7LMfc8pZ
         pP3w==
X-Forwarded-Encrypted: i=1; AJvYcCWFW7s0rMQpjICmIPl9DFfMUoIGEIzNGrQFNgMnOQgMtSFlPnWWOMFe4TeR67bmLour5o8gGb4xh6YOMv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWy/reIqrfJjqdKR5f+WTm0pMAfC8k+5krfbFKM3s+zBHNkVCz
	iuImEQjfPUG/RXg+JjzaF1AIQAu1LQLWEP23uxnEUhlpFAdEX5GiVeGSotxCFP4=
X-Google-Smtp-Source: AGHT+IF5qTNuztLawL22nFdoWM3hBa8g+iEMn3AucUKZX2m0zot7CflQJgWfjjOvLTZBT0mpwh+/bA==
X-Received: by 2002:a17:902:cf02:b0:20c:af07:a816 with SMTP id d9443c01a7336-21183d087c7mr129753345ad.31.1731252566678;
        Sun, 10 Nov 2024 07:29:26 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/15] mm/filemap: drop uncached pages when writeback completes
Date: Sun, 10 Nov 2024 08:28:01 -0700
Message-ID: <20241110152906.1747545-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio is marked as uncached, drop pages when writeback completes.
Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index bd698340ef24..efd02b047541 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1600,6 +1600,23 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * If folio was marked as uncached, then pages should be dropped when writeback
+ * completes. Do that now. If we fail, it's likely because of a big folio -
+ * just reset uncached for that case and latter completions should invalidate.
+ */
+static void folio_end_uncached(struct folio *folio)
+{
+	bool reset = true;
+
+	if (folio_trylock(folio)) {
+		reset = !invalidate_complete_folio2(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+	if (reset)
+		folio_set_uncached(folio);
+}
+
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
@@ -1610,6 +1627,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_uncached;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1631,9 +1650,13 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	folio_uncached = folio_test_clear_uncached(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	if (folio_uncached)
+		folio_end_uncached(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


