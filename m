Return-Path: <linux-kernel+bounces-233916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C991BF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709181C236C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4271BE86A;
	Fri, 28 Jun 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQRJUbIy"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BF1BE866
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580157; cv=none; b=CDtQcs28ySKorwqHIXNdnr+4iEiofnw3YROSBd/9KzjHBTl8CVJ9ffe74oN/QHpPTKbCvk0//Kv4MWmfkKCubvDY9KFmrfI+yoJpThccxPdAmqVSCnRByQ6G1ojInp9u47Fzt7T9SaAshxJcFWLO3IpBFsGXtPSOl4fjg4QTQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580157; c=relaxed/simple;
	bh=P34R1pB8XobSuo2X2BneX9FQBqPF9KFTDzMIUatwRB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWTzB/rCWe8ZM3qfUi8VZ2L72d4DoucgIFSNK0JiZ4EOpIGbGg1GngI5hlmrTTTMtj1NUJAbnESpO+lSwd22rF975Ui+eQc2Q0K0JdPxeODGgj8pB4sl6KmwOmj2bnf3KRsPPw8z7CgDv4HVik+dUqbPdeT6AheQ4FPcv7nwt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQRJUbIy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7024d571d8eso489234b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719580155; x=1720184955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fwqZttwC+ZbW8FD7nFrsLap1fPEL7EKx4IYhcmZWAQ=;
        b=QQRJUbIyWLf+LdxRolTGPmbBXwkWa/Oge0yztewenVuzARcynjlcFC4WO5P2PKPxfK
         1Cc8Hux6hvOQxuQLSOgC9iiFatRs1RnoYqlPfEdsWKz0dXjWwy0KhPKYboM7No7SZXzT
         udzhMTRdF3ucLlHhtZnSPU2iNZbhsvA3gVm+o5jl2OwmiZPHCcY3VD5GS9WPkdt7gXL9
         WrFIu5ATrHXxTETL0zLFx0G6pOImF0yDuOZR7MEYcR8AiiDjfpoocEGjVoVQCRg2sWFE
         sCHD3x6gdpWAYfsHu6wuMBQ/E1e3cVZ1fjmCkU5oRHh6HAll7vZfbXVIRg71bcl/bxXO
         nKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719580155; x=1720184955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fwqZttwC+ZbW8FD7nFrsLap1fPEL7EKx4IYhcmZWAQ=;
        b=fiD8b4m7tGst98jjXRaZ6xkhlf6gqRHhuTYBAe8RMK/gglEo327qtr858gZciY+bqb
         4VulfaPt5a6dSVPl+9TB873ZHsdUgxnbOVt4rfXw20nDqAO9jU5YwTHkeG062X/4PBoI
         BZ/ZfbmwbPShmhWLqjSe9tsTTe3uK6iTKkQJHps5kznMPXL9DH2Urjh5VmV5+wJ8xv5c
         ZvDtODxKX0nhRJ8oymgf5Gt+oVc+Rc88IY+P27recBJsOA4BkbFVQihL/at0TOsP8NBZ
         wnQE0uWRmlC/esWWMRh4nLedjAEWwxFRkvdNfMDwQk6uVLT4dvwFEQ/rZE+mD+5CXC05
         LrHw==
X-Forwarded-Encrypted: i=1; AJvYcCXoClhiXT507gSeSPExMh9I214nYm2EeDWQjXLAQwq7UOBFQMNlBwYnJ29F55Wflj7SSwWFBkg26xVmuQCcEXmpxfK3DGBWE8Zhsvi8
X-Gm-Message-State: AOJu0YxLt0hfaWxPuO8ogdi7UiKEV6WjaGO3rDQL3ydTuEN6MH8/OlSz
	peBdZq9WKihQIGRoIIDPy0VhJbUBrzULUT+8O+coUd5e9HFtgAtPOSiL9fPt
X-Google-Smtp-Source: AGHT+IGn9DD50DNkYgejYoYqzKV81yY1R9ssvw1Q4pWXXVQ+kRqODZU3f60f4qTWaKwYCs6Dn2f3Ww==
X-Received: by 2002:a05:6a00:3c94:b0:704:23dc:6473 with SMTP id d2e1a72fcca58-7067474dc86mr23147585b3a.30.1719580154982;
        Fri, 28 Jun 2024 06:09:14 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498946bsm1526102b3a.200.2024.06.28.06.09.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 06:09:14 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v2 2/2] mm: add docs for per-order mTHP split counters
Date: Fri, 28 Jun 2024 21:07:50 +0800
Message-ID: <20240628130750.73097-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628130750.73097-1-ioworker0@gmail.com>
References: <20240628130750.73097-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces documentation for mTHP split counters in
transhuge.rst.

Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1f72b00af5d3..709fe10b60f4 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -514,6 +514,22 @@ file_fallback_charge
 	falls back to using small pages even though the allocation was
 	successful.
 
+split
+	is incremented every time a huge page is successfully split into
+	base pages. This can happen for a variety of reasons but a common
+	reason is that a huge page is old and is being reclaimed.
+	This action implies splitting any block mappings into PTEs.
+
+split_failed
+	is incremented if kernel fails to split huge
+	page. This can happen if the page was pinned by somebody.
+
+split_deferred
+	is incremented when a huge page is put onto split
+	queue. This happens when a huge page is partially unmapped and
+	splitting it would free up some memory. Pages on split queue are
+	going to be split under memory pressure.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
-- 
2.45.2


