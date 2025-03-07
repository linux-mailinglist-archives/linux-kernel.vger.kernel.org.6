Return-Path: <linux-kernel+bounces-552141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE41A57623
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF38188F4D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72721DC99A;
	Fri,  7 Mar 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmJRIvCO"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC733DF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390466; cv=none; b=S7/+/jF+Q94a+YyFkzuPjAZ1/mSmsB/mr4AkOPKUNbOYv3IIzJpnQMIpJmmqCR2dvv/88okPhGbZD8uSzaNq77UmGJFAwL6o4w+n1ToEijltnS/ivvfhILgW9WKgnrG6VBcOf1T9i1GIuiFzSc1ETWv8YYDnV7r/SkpmZmF9OSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390466; c=relaxed/simple;
	bh=khm0+qfbUHp7BUp6ZvQjgUSVNMxzi2iLOG32cMl9I+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxw7Bl1lA5BjgS0A3Z/1NZcIPCXG5TspFnC+zo/+sf8B2rPmk6lKkGTtUpRmnPv3GtHuyKQm2R2KsFoVV3ExkMr1HiY7ceMGvFpd6oLGd9JnLyVXHD5yNaKR0aagx8XmDzvkqieEVV+BgZM/GUjjZQzR6nVjkVWI8MtC+3jq5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmJRIvCO; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2088401276.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390463; x=1741995263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItUIUWSkaBDo4gvOHQAaaSasVOjEOP8U9MmMhIViMDk=;
        b=OmJRIvCO4DFzcJsTfGSkCUTQ70Ww+GGQnJyh4LsIS8WMmnGf7K74CHTyooriX1lvRm
         R6cqJxhDX/Rju3j+BzVWve0ykx0FOpX9sMYVj2NQte1fmYQVKBSlqj5eFwGpqlRwvtY6
         9qY9la2zHJXsgjuUQxW9lMEVcFsBRvAcer0o18iI1IDd7WVEn6yL1kzcFRO4vsuJGZWr
         YWww+MbZ0HgaOKNIRCHrAxKdtW2IxOsMiMFm/96dBWcJfYJPj7tNLpNPWQidm0ZdJZSE
         mDAROlLPhyOioqleAE/dLejXO12yplywpR4X3D78TfPoaWWliw6EqQ2uFQSXalVw/Uxk
         l/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390463; x=1741995263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItUIUWSkaBDo4gvOHQAaaSasVOjEOP8U9MmMhIViMDk=;
        b=izrYDe8x/J/9dFqoBl56xgW9wtOVceegPr/0C6FPnliaCPrp1LDjfDG13fZF69KC8u
         eeQi5LYs+0RxGqw8aLZLwJS6Nt8SsIs/8IbQIHOMo41G2Mv/RDot45LDY9Fs7S5Xi9Ws
         fTmOpD3c+Rb+92jimrJJPlw8+9mHH8+qM+3kkFsbXuiZ5+oW9rV0jErOPI//lGu06peA
         V3mOMO1J0q+4XUZ4qlMKpnxowPqNX2AtuQUqv7mXpWorrXqqmHpKQRGZKFacF72nov6w
         s25XF1MItxuwGcSwsRiylPxBFUMEzs9Gl5NTXizvZHwJ7ztI0fG8nOiTkjhC8lY8F7YN
         TU1A==
X-Forwarded-Encrypted: i=1; AJvYcCWqS6g6bL6qihgqb+K9r8LOtxLYk/gMLwLvjxylRWNmkZkcICm7ig6oRIADmArbzMTeQDzb+FuBd1BmFvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnpCinceDp0tXd/7s0Ts1XuP4XHWhU7Zyp25WL8T9lYXZt8HS
	Ojka1NWSeu6K10p61MnTbmdYvJzPrbGakcLmfkiFx9zY0w3BPdVq+uTaGA==
X-Gm-Gg: ASbGnctLjPmJ/wvGToc9xfsJWKK0P/jnh1w4QWpUOvlW+9kef3nqn3/1hTf9+zG+H7f
	gBiL5ZQYGNnbE0CR3BOT/YS8UInA6t3/FAWK87P7lEJj4JxZyBRhBna5ZyWdThXJYVMntbX9naC
	OzUXZFMO5/8VfrurEDzwrpAcNU4fEWVfrywHPtir9dBSBSx+hDwF7Zd7Fbk/ReEmEuD+zAPhB9P
	jdYfCnDDJ13fgIQCiIy6EbuKgyvzSh1EhkHDjtnXPV1WPLEMIagqVGbAte5wDWb2djTHLmGc/R4
	JMZhsRRMnbZcUR4O3x7PnOpPR9Odgr4soAg=
X-Google-Smtp-Source: AGHT+IGtiAG5HzVRcSvrO3fKhko8Jdkv2p32kH0pPlw0M3D/fuxVWpiVLIKS8UEHrS2CiYvlw8wsGg==
X-Received: by 2002:a05:6902:238a:b0:e63:41cf:b600 with SMTP id 3f1490d57ef6-e636f818e5fmr2142208276.24.1741390463532;
        Fri, 07 Mar 2025 15:34:23 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b8e8ff1sm1049120276.40.2025.03.07.15.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:34:23 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] page_io: return proper error codes for swap_read_folio_zeromap() (fix)
Date: Fri,  7 Mar 2025 15:34:22 -0800
Message-ID: <20250307233422.658954-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250306230015.1456794-1-nphamcs@gmail.com>
References: <20250306230015.1456794-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the comments for swap_read_folio_zeromap().

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/page_io.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 48ed1e810392..30ec132c801b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -521,9 +521,8 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
  *
  *  -ENOENT: the folio is entirely not zeromapped. The folio remains locked.
  *
- *  -EINVAL: some of the subpages in the folio are zeromaped, but not all of
- *  them. This is an error because we don't currently support a large folio
- *  that is partially in the zeromap. The folio is unlocked, but NOT marked
+ *  -EINVAL: The folio is partially in the zeromap, which is not
+ *  currently supported. The folio is unlocked, but NOT marked
  *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
  *  sigbus).
  */
@@ -533,11 +532,6 @@ static int swap_read_folio_zeromap(struct folio *folio)
 	struct obj_cgroup *objcg;
 	bool is_zeromap;
 
-	/*
-	 * Swapping in a large folio that is partially in the zeromap is not
-	 * currently handled. Return -EINVAL without marking the folio uptodate so
-	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
-	 */
 	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
 			&is_zeromap) != nr_pages)) {
 		folio_unlock(folio);
-- 
2.43.5


