Return-Path: <linux-kernel+bounces-371513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB399A3C21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903D7B26B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1E2036F4;
	Fri, 18 Oct 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPggVCIW"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FB2022FF;
	Fri, 18 Oct 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248643; cv=none; b=dkeftwkO2kKRmgAzgxhXXdltagKUEwMbM7D96Z3YQorNV1Fj3f4GyOXsppbje+Y4fTmDiHGeS166j63KoO1U2XfacXKIrNUGP8VsgrgtUFsogdXyvJvQV2vC8EiwDlBiasAicgi2i59HfgVy6HC96mcTVpieilMWQkGzeu6hEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248643; c=relaxed/simple;
	bh=roDKo5mLa5+BltAeauP7H9mSyQFvpn2sS3LkpgtI95E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaTQXXB+abdTkrMSVoguiW5YckR8K4L2msnPWScT3p6g5NPDdPrifz0mdfvYefnLHTHqvFr4IRkmYcHXpn2Gk3Gz/LR6AkRYLHs5q/yBBGPalKHAe1Na3J9YGrkH74Up0eP6b6DRi/RlkvFdEKcq9944gOgWS/onDBjC5PYaqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPggVCIW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460ad98b043so5647341cf.1;
        Fri, 18 Oct 2024 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248641; x=1729853441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0lh5Dj84nRQ80twxUOjXO55WZ5GvafoDcM5bsLvOt8=;
        b=lPggVCIWeD0GE3Nrt5pW4H0+iPx+j5EnaoXzpHGqTHyl07WBTEubVDUxoVpWgarYmF
         KyjVQHSN7F7afJfQXfZ81CJwhRT9QhvGuA90QAQcgunNI8Mq1GnsFFRGvfNMI95ptoJb
         HXl2kvytF38jSd+G6S0ksLf1vTYbnAMhY9CZaKXMK6U/lDzb75biUb0LT5QEAHzav+ZI
         9rCUUnyNuJrEUAbzYMLj0KqdzvaK1AENA3tA1Sqtk+DUlmwLlnOsIq6igI8b6AdhizXk
         TJcprysyfR1Ad2qNJyy0iywXWKHCnB1XSD5vVjQ8kKmKeWGh4vbT5zdr5zRxf6SpB9D8
         QQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248641; x=1729853441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0lh5Dj84nRQ80twxUOjXO55WZ5GvafoDcM5bsLvOt8=;
        b=pB49Jkdly4F4IK/cHRlXPRN53M2l0qMz3CSIZZjy/2vTVOJ7nw5Z53DaMpF2DJ0bNf
         6R/RQItCjQWNk7HwgghScFaOw6TffF7fUNn7wh3nfwGh/N1OideiCq/pZMNv9h4YhF8p
         QpHdef22txwZE33F7vUhfz82mtKUVc+BuvtrHszmaH1wRjpjkQ0Y6Vd2nWTBk4/DrDr6
         KPjNFvBSvyN+qNVLAUktXyckvXqjYZ7XTrsdEHFOFCE6x0msX9RCtGql7Z0810zO9n5S
         H26FP6RfK83GtNZuDSQ3xm+7/hcmBUyeeoFmOKmMHSjGn+1DV8YbcCWNoovLp7n+6Nyl
         cSNw==
X-Forwarded-Encrypted: i=1; AJvYcCWEyzJYSEyLX2GuvLXTF9PWtAcketJ5OPgO+wz/pwz5nv1YOHH6CzRMLEyIFiHXQIFwt3fgiHhqZI5xMFRR@vger.kernel.org, AJvYcCXZimtBwqKorzp+viIKMqpdXFRUzFDbXNvRcrfaXY8f1RcZ/kB1zoPHVLoptLx47WOpBE1bb/WHPKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU0M6j4WL2JtLCI5JYgEPz0o2emRiDBbdWCS+o+vSHOyILux9
	J1zfVJxcjukxz8P0XkS7t5WRs91Lk1GXx1+AfoNTmBa0QqUIzyHU
X-Google-Smtp-Source: AGHT+IES+vksoooguMP9yHq2t67dioxSjxiMZLvUVEe1xr8iSRA7X5ppyMkALt+mUyKvRjjB7jAf4A==
X-Received: by 2002:ac8:5e0f:0:b0:460:38f5:8753 with SMTP id d75a77b69052e-460af182969mr26970431cf.26.1729248641313;
        Fri, 18 Oct 2024 03:50:41 -0700 (PDT)
Received: from localhost (fwdproxy-ash-018.fbsv.net. [2a03:2880:20ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae96d3ccsm6189371cf.32.2024.10.18.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:50:40 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	david@redhat.com,
	willy@infradead.org,
	kanchana.p.sridhar@intel.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 2/4] mm/zswap: modify zswap_decompress to accept page instead of folio
Date: Fri, 18 Oct 2024 11:48:40 +0100
Message-ID: <20241018105026.2521366-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241018105026.2521366-1-usamaarif642@gmail.com>
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a prerequisite for zswap_load to be able to decompress
large folios. zswap_load will iterate through each page in a folio
and decompress into it.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/zswap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f4b03071b2fb..9cc91ae31116 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -953,7 +953,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
+static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 {
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
@@ -982,7 +982,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
-	sg_set_folio(&output, folio, PAGE_SIZE, 0);
+	sg_set_page(&output, page, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
@@ -1055,7 +1055,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -ENOMEM;
 	}
 
-	zswap_decompress(entry, folio);
+	zswap_decompress(entry, &folio->page);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1666,7 +1666,7 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
 
-	zswap_decompress(entry, folio);
+	zswap_decompress(entry, &folio->page);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
-- 
2.43.5


