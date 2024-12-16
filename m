Return-Path: <linux-kernel+bounces-446801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47B9F294A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F716460E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5561885AD;
	Mon, 16 Dec 2024 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG6F4c4o"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340501804E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734323290; cv=none; b=DA11ZmMR260idOOKZj5qqRlXgCUi0s7Yrqa6umpt/gQpoNm8Yg1laA4J71/R4JWJhXxda56FkZonAVTAHh/AwQ5W1ldnnas2d+iwLLHUnk8EFp0XbvYM5Hjo7mBYhUcLxiIFsXvYk5jslny+BJ5309tvXa3jp4Bq1s5hzS7BjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734323290; c=relaxed/simple;
	bh=ztldS0Pgnfz7Jj+8jrbP74NKwluWhA/V4RxtO5YSeDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELNiUA7Yi8z80M/4IauONyQ1r1PgEjhndGyCr07ccW9hUWL554DXCPl4POIxJql7tq84ORiBdVy2ThytZGPXEkRUmCTbPNwNym0fqGwpCFrBf9L2isXdepYBvS17t9dYfl80GKog+Tc8gw9r9l8/nQiRN0yQO8mxh0tbG9/4gCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG6F4c4o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728e78c4d7bso2573243b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734323288; x=1734928088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8PAyjFcZGByeGgroFAmAlnKKULPV8OwTO0JUO/nkbU=;
        b=AG6F4c4o4AKN7lqNnSxs4TdHyKG8kMfTvQ96VkAhnURbzTPdmK7HaAQmE3BU5Hn29h
         +OBQK8ASEaA7Pby06a0Kx4+uI3Tm6KqC27peaPZgO2Ly3F1DgskYqpFG6OjzA6Sm9Rxk
         1RyKqdgtZi05O0BShwIREPlph8ywYf0izQjht1sCPuw+bSXm8AuBE6Uskh5eTRI5lilp
         1y3N7zpVakBLBO75e2TQv8vh1Y/FmftNEt3l+qrauSCrC4nLxn7QR6uicDJaIMmxGOU8
         M4g01kxyyMpc70dtGjBlegpSsMbAvcEnhEEeHiQK0jEOd4BbhRBudvQ8ID76F+5L3yvA
         J+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734323288; x=1734928088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8PAyjFcZGByeGgroFAmAlnKKULPV8OwTO0JUO/nkbU=;
        b=hc5rY1C5ZMrD73kfh7AGbojTF2/VRkCGJ/VEonJtfhlPtXWc+Dy8ik2kt1AsFmgbvh
         9xf5SglWyY/UcFasl5HsjEN4D/m9tVH5XCiVYUoZN6wlF2I61uMb3Do3X6/4Tb4irybV
         PMHpFCU9er0HBecAM2XwOdmNMVv5WbRndpr6b2WLh2eMRXmkwDZ8Urj/+80JhFWdDhV3
         Ake42qupN9So9cGtyOwu5ZTg4h6k9QLeQHV+eXCOEZojfhpOObQGa9lm/M3m8qE9jQbF
         fhovTgbwa0gS9K8pvQWLW2ZtlwllIiDUUKdDEoAfKDRsyzraj8TFFhfBiCQXBXzHdQTW
         Ao6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjrelADDI0/h8GM0E1Ud54pQVaXNkSYDbzrPpLnn26ZE7G5O/cLEvynWVgFEHCVWSvPKDeoDLho0Hpp9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRekyqTIOpn/CQ6b93N5VIDk/cbpbY9zpLoo2QlDrfKCLSqq3Q
	by1GuahSj5IpxMd/ClHxBKqrBy5wpGWquoHn1FDcb5FlCX2s57aD
X-Gm-Gg: ASbGncud32nz6nk5uZEJzJsoh4GH39AmAi1/wLOLDZShorgjTRUXIe9T1qCHbg/H4XN
	si0DPVJ4FGuifDFPBDZVT5ZK4iPORbB5GamVq+1p4tR6BkA5kaqNbNsio0wM2ttcDRjJ4UrXbFr
	VGmcmr3k89K3gbvLrSe9WgFOm3ggM+IKfK27f2PzrAdV7NNOv2RseUYkrm4K2DZnOX8Xrfu52Nj
	2b5hvq3CsZz2fVc6oO0zHLZW4m+Oe8iaU6PCPqYz4AF7ZtBpt+/6U+YUAIbMaiW5FzAA0VP
X-Google-Smtp-Source: AGHT+IGjPyHsxQ2p9c3zKUXvfwTUxeawyLtiZdMgNQsxxMtHwGqczElpqkW4otHVm3mrSHUR0YRM2w==
X-Received: by 2002:a05:6a20:c99a:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1e1dfdcf315mr16186945637.0.1734323288372;
        Sun, 15 Dec 2024 20:28:08 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:d782:c275:5ae5:7e7b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918baf6c0sm3731852b3a.166.2024.12.15.20.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:28:08 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+8a3da2f1bbf59227c289@syzkaller.appspotmail.com
Cc: Leo Stone <leocstone@gmail.com>,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] mm: huge_memory: Handle strsep not finding delimiter
Date: Sun, 15 Dec 2024 20:27:51 -0800
Message-ID: <20241216042752.257090-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675fa124.050a0220.37aaf.0113.GAE@google.com>
References: <675fa124.050a0220.37aaf.0113.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

split_huge_pages_write does not handle the case where strsep finds no
delimiter in the given string and sets the input buffer to NULL,
which allows this reproducer to trigger a protection fault.

Reported-by: syzbot+8a3da2f1bbf59227c289@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8a3da2f1bbf59227c289
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..361319f749f0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4168,7 +4168,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 		size_t input_len = strlen(input_buf);
 
 		tok = strsep(&buf, ",");
-		if (tok) {
+		if (tok && buf) {
 			strscpy(file_path, tok);
 		} else {
 			ret = -EINVAL;
-- 
2.43.0


