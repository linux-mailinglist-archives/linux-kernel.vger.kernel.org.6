Return-Path: <linux-kernel+bounces-557212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D95A5D524
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE67F1789DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DAD1DC9B5;
	Wed, 12 Mar 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G43A6D3Y"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136F1553A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741754826; cv=none; b=c/G0jVVgIPCQUHdc3QYKp27WgMBxzodbI7bcqZTbCHYYM2t/sgkewiDpEN0XYx0DlUo584Yr4vMTfnkHRaGo69XhVALLc0ADtIZl0AHXOOsp13uOibAHWcain9DnA9IXSWVwpwzHKFayaliFfUcLqgiIHWXpwl1/Kn+hzgbDQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741754826; c=relaxed/simple;
	bh=P5+1ZmkAJH40Ohd12iorBbKIVuHQUB06k/hR10m8oos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIY4pjsYKFwAJgL/fWRjBm/3PVVsCinNfCV7xu8vaz0fss6U3FjBNbZ2Gu3ZqsJgDI0NjVDF6RLqnfRIM9P6acD3gfPDrCJR1GEVyGGf2jt2ci1k4HYZECltg7ubJRvDkdH0wrLDIcxJXqtr/F5ETDdzsYvQQIxRb1DfIHh93bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=G43A6D3Y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224191d92e4so109900775ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741754824; x=1742359624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwa33pPskkPQ/NBZ1X9elFhYdOgnrg8vQ/GWrL0WjB8=;
        b=G43A6D3YCshWzpMXk337aACPj0Cbqip+j/OW+3HeF3RO3p6/ofHMSmoV7Ssjx26wvu
         lw1E9TLksEhKdMOivWSurT4kKqapkkahM7D1WbMtZ1TP3CUYkte9QHlchHWL7XEM9bDZ
         Dlt5m2Ls66sfa+Ntu5GOhKicXd34gWxN4F/Sb64UgtPFfw0h3mlhiRhiZ5jIAOkzYm6W
         v/8+3PnPtaqYmXyJAkq96aBbFrv5Yr5PqzvGeviV1jlN87qA/8PwYZkD07cqAYpDzXSS
         DM0lfXCm2fV0isSXhEuiRBrgoFg58EEQHzcidzMo40yNabgptdtlIHnCT1TaG8ymRraz
         /ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741754824; x=1742359624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwa33pPskkPQ/NBZ1X9elFhYdOgnrg8vQ/GWrL0WjB8=;
        b=n5Pb1AyZyCA+Q6ED+5ZFV4YSI1MaqYfvyx3eGohOfEWocAHZa775hPb2k/hPPo83UB
         oSNfwyj9MoKJKMI6boMYdzidS/7FkVAS+kwrlCllcS2VwqPvqcspq6/NvW44LUjCAQwp
         pRF145IqHpx1X0gUsbSzW67NvnITbmbZpN3l0BvJm7ZDyth3asINw8ndtG7TTvWV1KZN
         aduE4deryNhl08w10y/lIBDfevndHcY3Xbu9VempsONvzcZfYI72UAjiuzStF0RtRPHd
         suOM8itFI438rohegVmvoIVeF5iMVuUuoLNgopDI5a/9clajBPPHfumwTfejugkmuIs+
         V/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVftWikfGtKDKUHAQZvPLrvgpF95VVOdo015/p7qY7c9sqnhAeWYo+AnhPhBJuG8v5mzSs1JC7+qUBcYr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWP+6k74r+Jyk5fweUrvpy3o/eylbrZyLN2PUpNsW/u0JhGLrh
	GOZ+MJXCNiXv8Bm9DW3K5ulgo0/zauLGCCb1JQlGgBHbb0oO6bJM8szqUYU/MKE=
X-Gm-Gg: ASbGncvddVwpXXgyXq9wMAEZXyp2jE1MilLvTqQcrhOdvLrYaU1oXf6hP0i5E5+LL46
	bG6Ufj7MK3KkMLDW7HIFl3/Iv8ZxlOXUYxPFFHrDTGbx61VX2SkphCxlRRtsHKQsFzG2p9Iazhu
	05T0WVxZOIEbuQXcvzDkBCdFGeTLxtHXdANrKhjPiNvQ5DehDqZ+vodxSVuya2LE6CUDN8mvWiQ
	38c4cWAw9hvruN8tBgGp2iH+fGE7fFdd/3ylWoswsK3Q73axXaoeBoloOiPi2zFejWrDIsrwMNy
	BVhLffJeFr0A3mPdXGVEzpWiPWM4hJCFsYiw07uRsuqMHajOZq5pWi1jmsYfKPluiqtEwO7J1ag
	tfORr
X-Google-Smtp-Source: AGHT+IF3ZBeGX2GfMM873P0fcWHOC3RzkGYeWIUjoqHWJC+KJVsYNJNwu8mnTlo5rpp3HjcIEAPL+w==
X-Received: by 2002:a17:903:40cb:b0:224:584:6eef with SMTP id d9443c01a7336-22428c057a6mr340406095ad.41.1741754824241;
        Tue, 11 Mar 2025 21:47:04 -0700 (PDT)
Received: from cyan-mbp.internal.sifive.com ([136.226.240.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7d6sm106476065ad.107.2025.03.11.21.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 21:47:03 -0700 (PDT)
From: Cyan Yang <cyan.yang@sifive.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cyan Yang <cyan.yang@sifive.com>
Subject: [PATCH v2] selftests/mm/cow: Fix the incorrect error handling
Date: Wed, 12 Mar 2025 12:38:40 +0800
Message-Id: <20250312043840.71799-1-cyan.yang@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an error handling did not check the correct return value.
This patch will fix it.

Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
---
 tools/testing/selftests/mm/cow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 9446673645eb..f0cb14ea8608 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -876,7 +876,7 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		mremap_size = thpsize / 2;
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (mem == MAP_FAILED) {
+		if (mremap_mem == MAP_FAILED) {
 			ksft_test_result_fail("mmap() failed\n");
 			goto munmap;
 		}
-- 
2.39.5 (Apple Git-154)


