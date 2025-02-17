Return-Path: <linux-kernel+bounces-515559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43372A3663C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D6D1705CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAF1A83F9;
	Fri, 14 Feb 2025 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C8ZBE9hY"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1A19415E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561835; cv=none; b=rU2dBPYeIv7Ms7pG0kT2bdKglNx1NKPZPSpab809ckfMXytMN9XiFqcMfXg5+2YPwnXQ5ut8eRAaBL3Jl+ozkf+0C/MeQn/QWHy3Ex08S72ArgjyLQrzNO+RIxNgsfWMh3Z1ie3MoIsPjSdaJE7PKmQSF9CWp+TM4wbYjTmnIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561835; c=relaxed/simple;
	bh=Zw8fVH1WcB+5h7HCP2U1mCvuqvls339v/KOwSva9M24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6WsTLmAFEuyX32DyYXjDZpCP6BBIw6gwFzOFsmyL0F08uEbslLxUWkgn4L/KG5YbQGl5Dh29WzWXCVYy5Ac5xY0v0tdC8HqaZeKiPsF/rx5xYcGkKcOxSS69xiEJxtRCwz1u4On7iUPGpSfjqVJVYDORpUh6/1PrknmQg+l4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C8ZBE9hY; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-220c895af63so5936225ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739561833; x=1740166633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MiZRBvxt5S9Js+ZxnDREGY7+r5/qQJ1U6FvxMi2vX7w=;
        b=C8ZBE9hYODtbDAO07MiVOCbgt5hFhvuHmgcSZSN9aVYkl2xqOAXOfrFW0EdB8KA+Lq
         8ikmsx5z/EGtT8/kY02CH+ZDVMn0yBIN89Ez4axX/Cm1IuEuD2MBu062GGPpmLq5BT9H
         beXEUhii4kDlgZUK4YiQqm5u+9PSmACv0ZfInO7J69qAad4ckHUCx/v3nqu32ptJ53yG
         wrY+qh4UN4meh49f39oV2KJZ2NBHK+u9HsL17IsUhLUBxqOgCPdW5ofGAyw5Jba2PxgQ
         zesVmj6anRF56eDoF2echnltFwid0WCmTMRhRmGTUWz0y5vPkDf89GXbHofXXFVnoe5h
         pcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739561833; x=1740166633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiZRBvxt5S9Js+ZxnDREGY7+r5/qQJ1U6FvxMi2vX7w=;
        b=PcmDNKOMJiFc7F0/qWBQxEUokJcZlUvWdoHF2EmzIXXWwEc6/WKFZrPPlhdnYyZ7ok
         MHZ7CkVdVO/zb/qjg/bFhrkEWV4dVmM9ZYcAAeUfW9KhtIlYpcXgNGS1aEx1l6zTbnAu
         VvCrzdHYIm8+K6636oBABzknqDdqN3UX3SmVWmZW7SXQpxtDmQAto+pk+agpnceRuouk
         ei5a7blMuFPQyb+2sTfdJlUgPk0b5TN5GhVy8kQjDFIXHNuJZ+6mTuQRQRMFFs3PDWmS
         png4xQCbnhIqR0WNe02tLCKw0tPGXx8l9AlPcY+eLt8G43BJE//eZhN6izx91CrbA54R
         Nz0w==
X-Forwarded-Encrypted: i=1; AJvYcCXiLyH1ammD9puYaXUQStx9AZ6b21LB0Huf3gZT6L3fAASVw+KBnxP0PXqdXsoglDbah6UU+1kHA0u9HZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hJFKBBbzUjI/LQ57aaH1qCDAQNjnFBjffv+orHzr0oAC6FIV
	rE0ocbragzbpaudV0+hBx1WqcffjmSUaHl88rc+UxH+strpBC9vYrjId0v23tjLWgXLvZEyYO4q
	eC/bX/u/xMJpSg14fchfqQRqSM6vOgVnjD8DRovcoc4QWePFF
X-Gm-Gg: ASbGncu3mb4JQrHv+d58NF7XWq4uz1HnJYm0NmApsJSsaIx0ZOmnKFGAHPyhqr/FHVQ
	9JwESCdWUHhW68/CMzvqdmNbr2XTQX/LG41dR1mozMVHvNZAvu/bn4/G4kuSwjvELG+U1NVTpEI
	y7s0FQzfu9xBiLKrCZGsDtNFE0I3YCsYQNh4RL6aQ9YWUDz9CfdP9NERoKUVTIt9VzV6NSLEdfx
	Cb+yaO1+WEWGtibp4v3e3M0NX8ainobXKxQIdhdakCY/unVYEvhRQmSHL7fXFzrtyefPuA6lyYg
	5XdN4ea0nIDJ3jRME6D7dzc=
X-Google-Smtp-Source: AGHT+IGRy9lI88MlsO1rt1VcX8D1MfrHF+0m3UpVY7cGQ1j81V4UsKB1OQv4wjqUF8qSIY2H/zi664EtIIZB
X-Received: by 2002:a17:902:f684:b0:216:3083:d043 with SMTP id d9443c01a7336-22104087dc2mr2871285ad.12.1739561833430;
        Fri, 14 Feb 2025 11:37:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220d542f770sm2075185ad.115.2025.02.14.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:37:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C13163403B9;
	Fri, 14 Feb 2025 12:37:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AF23EE416E5; Fri, 14 Feb 2025 12:36:42 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block/merge: remove unnecessary min() with UINT_MAX
Date: Fri, 14 Feb 2025 12:36:36 -0700
Message-ID: <20250214193637.234702-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bvec_split_segs(), max_bytes is an unsigned, so it must be less than
or equal to UINT_MAX. Remove the unnecessary min().

Prior to commit 67927d220150 ("block/merge: count bytes instead of
sectors"), the min() was with UINT_MAX >> 9, so it did have an effect.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..39b738c0e4c9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -268,11 +268,11 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
  */
 static bool bvec_split_segs(const struct queue_limits *lim,
 		const struct bio_vec *bv, unsigned *nsegs, unsigned *bytes,
 		unsigned max_segs, unsigned max_bytes)
 {
-	unsigned max_len = min(max_bytes, UINT_MAX) - *bytes;
+	unsigned max_len = max_bytes - *bytes;
 	unsigned len = min(bv->bv_len, max_len);
 	unsigned total_len = 0;
 	unsigned seg_size = 0;
 
 	while (len && *nsegs < max_segs) {
-- 
2.45.2


