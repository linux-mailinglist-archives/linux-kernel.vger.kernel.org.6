Return-Path: <linux-kernel+bounces-399402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863699BFE78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80DC1C211D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E2195B18;
	Thu,  7 Nov 2024 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV3EFoAx"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55402502B1;
	Thu,  7 Nov 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961048; cv=none; b=XYonAjtYGx2Aml5k7wZz59t8f0ipdGT8T6PkNNubMfcMiZLC+dLEwq833F2d2J70KEwurFXGjvuiki9nGqafp5g2ygZXqku0I0HWSisFcAvEfDgEIfBzbFPNZUTDZiFSCZTdzFFLxiBwpwTQ7d9ls6Z2dWXkem0UD8upLFdtT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961048; c=relaxed/simple;
	bh=GgDJgOiNgVI8N8G/EOt8OU1m3SnBYIsSsjBtbkTqLBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqbj3j9MY/7cpPQkOp5bZ54XxImsZsmoGr4gdYV69mJTCkr3r8WLbI0CxPvqaFug/6xuOlWYkNNBjVg2M8nzFWclDOXxEP4L7gQPD6diqaoKRoJDRsBi9hhYUvlSNpBCgxTuMcVcVFdKxEG8HWvk8NHG7iSV5sYM1nGLqry4I3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV3EFoAx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so492238a91.0;
        Wed, 06 Nov 2024 22:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730961046; x=1731565846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owbnmuQZ9HZHq+2PC9PglRkgSxwQfmb/ODC1/woQOnw=;
        b=eV3EFoAxcthLvxTiziJi2Y7pT5m2LivM6z2GR3l+Sg9JaKnSiXJO5izGM2RuU+NZxJ
         ZllBIbUVI+XDBRh02Grmze77hSC3y7f1nciofuVjQ6eFpcfllQImmiXXxnjVRooKU3uN
         SLdmw0fFe3FnU4Tu5roT1iFV1gCTh3Wp3co5FpzinU4K7qFqanRe1ZjOwg8TGbl5BtSC
         AVRMkgWIBBYqogT6WnLMU3/VonMuV3T+FzUwbwbsPXjLouiAQOMIbnDGZJ9ysOLAKu33
         77mscIhNHmzeZa3LCEZl47yCbkeG7jlTJLc30aQRLWb4kD4R8+lUQjx093/lkcpzkINY
         5g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730961046; x=1731565846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owbnmuQZ9HZHq+2PC9PglRkgSxwQfmb/ODC1/woQOnw=;
        b=hI56HEUPOd1gz43WvWg4e9mqzTgk6nq0DRnaNSM992uE5Q+gkxJY23fTuCJAVLx8xc
         ZX1+6bjH7Ga2ndhZ/Y4qNHGsxlWYBwNW48Z8o3yMdI3bbHsYNPMtaz+1n5UPvQ6TcVsJ
         BytGrOAGFtAxb/cPuLWuUlI/ziJ4CQ7/zaZYLqJzsbBmdklF8ZcAR/O/aQYtttJTFsIM
         GQ53gJFDyshg8NqI1Rg6K4H1VFGfVtpITAPQtx3VrEeb2FNDH/adsmnTNWhm3nn4668s
         eLsLlzdxyVlW5ScjjW0SktuL7eYUQUybGA+kuc8ngoZklekPXaOoB5mJ+2SkZQMLFcT1
         hXsw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxSm3Od2O/PtVou0DGlpDOPJ/fAkwNp42gDYn8FfSCsbLQLhiLbjhVVFfuDtcNhoTxNiOnqjBlRc=@vger.kernel.org, AJvYcCX8HyOWF+He+uNbJKYSQC7gtzoa8T3OgF8S3f0Sf42z2/6XihvpcWDclVkEOD9kkS95bdroDiBo3EpnEQVH@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsHoeC248Ma6iWfT1YA07K+0LZFrY+CZtidJpAOgzo9KmlY0W
	Sm11LdctkpYD9QLGrv9uDPE+NNNtOni2L8gBXbLV18TivOaYS3q+
X-Google-Smtp-Source: AGHT+IH5NUn/Vle+lUfKJAyWvt6cNdPb2EL1M58IFWaao2+0AiOU34caE+ttcYy32beMitPvhN5i/A==
X-Received: by 2002:a17:90b:2dd1:b0:2da:7536:2b8c with SMTP id 98e67ed59e1d1-2e9ab0a37bdmr8694a91.36.1730961046515;
        Wed, 06 Nov 2024 22:30:46 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f8f4e2sm725206a91.26.2024.11.06.22.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:30:46 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH 2/2] Documentation/mm: Fix trailing whitespace in page_cache.rst
Date: Wed,  6 Nov 2024 23:30:42 -0700
Message-Id: <20241107063042.106228-2-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107063042.106228-1-xandfury@gmail.com>
References: <20241107063042.106228-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace from page_cache.rst. Fix detected by
checkpatch.pl.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/mm/page_cache.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/page_cache.rst b/Documentation/mm/page_cache.rst
index 138d61f869df..13425fd5c8fb 100644
--- a/Documentation/mm/page_cache.rst
+++ b/Documentation/mm/page_cache.rst
@@ -12,4 +12,4 @@ Folios
 ======
 
 The folio is the unit of memory management within the page cache.
-Operations 
+Operations
-- 
2.34.1


