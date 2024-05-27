Return-Path: <linux-kernel+bounces-191390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489BB8D0E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED871F2227C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87AB16132E;
	Mon, 27 May 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du4/i/TF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011B161301
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841821; cv=none; b=MkpACqHqS+kG9Q3iWcS6208CZhYQ8cAYES+4kNwIJLwvucYHipoRF7uE0CFubhBLRz01c0eWCWUrdr/y6gDKcTbfPv543P5s+KfBJscJfdQ1NStSyuoxEmuBQdMCuwxaKt08isDYw7V+bA1TD3vByKJQ+VQNxUJ74eh1B8qjyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841821; c=relaxed/simple;
	bh=6AvePvddep+UiANmWmMBWS7SEkWIUQ1bJKkudQIKeT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjsIOS1rfLUgUSUgNh/juG+ZkiB4TNNzpVZ83aY3TM1WWKZ52/KF6f3HyIO4/cRHqaRvzFNAw8y8POg9AR+ucaIdtQDDjsZTEUP8uupSnKMwFRUyqQ8sJLcN5BQKDAfqIoY2nR24/gFIPP2uOYZ9GDih4hzamfQsN7neVUZ5Xu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du4/i/TF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f8ec1a4fb3so2109b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716841819; x=1717446619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSyU+GhS3C1q4ZjPz7YWQnRjryhy+q7kVdtg3o+JGS0=;
        b=du4/i/TFrmELLnxUnRH79orgbLyRl7hBq8viJkHpqlpW2j3HfoJRUA7MtFpw8EHSYW
         WrBQaeMOYI9Ewfej1G8YfYaQp9v/cW8fRZfQTyNyfhxsH9JdU1AmHtym6Z/QshzCW/xd
         7jqUgfBAQ2RO9T4Xh0CKforUEcgsWkXS4uXWvpioJqbe640aezC2KaygLxWO8I4dbDHk
         QGg7HofFQOpqsHNqNpTgLKlZgsyzBtqhQR5GP3mZvg/m4Wxrd+XdeXTJH5Fmr5nEGJt7
         e36+AGXvDIst7w9A7YuMbgyk9whKT4z+0MKXN9qpVBKXUHanrDJm9taokprtB2V2/Pnz
         EcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841819; x=1717446619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSyU+GhS3C1q4ZjPz7YWQnRjryhy+q7kVdtg3o+JGS0=;
        b=WaKeNSr3IuwN7+trANUXuvoF8EQCSMKB3EI4VyLSCp+x1DgUFzF5mSj+yiYl+0CJsU
         7enHpuloyU7QHjXjeEGqy7r+huG793hVib/6tlX4xm8fPmAjG93dc4dCgnNqTE0d5P5z
         2trdPcp7LtYYlcJMxxO8xh6pYtZjrYp7gCbZVCoZkCoEna0/MUXrYoAnVWWYJCgKl8R9
         /thsi+o+0jh20bcJTMrEenC5kiNkjsvv4RtoeYxb1a+y/w5jBYLALwR4M8HOhtjmKKEX
         z3WaTdC9iy0Lz4oPskrstgSNUEHfcbBE9wJij592LqiI+53r6L/tiRBlBN2UAMKkkHRd
         4Uiw==
X-Forwarded-Encrypted: i=1; AJvYcCXFNMtnX+TccmMNfOSVYNny9lecq/AAO5tJ28FhID6TjDvUn3HyXDHGIhdQqhLVYcb0tIpGwUCPTjC/QRzlxdkLueutml2saXpfTG6y
X-Gm-Message-State: AOJu0Yymgm+5vA6STFy0Pawo+stTDGCoLNF1J73UYzdJLjEVb2bmsHXL
	A3yEItnBkjW8+ueSnPlt7nm6jd2/3X+uPUp9mb93YiUm11qXmlDC
X-Google-Smtp-Source: AGHT+IFAvP1jE8ZmjP699QD1DAnNNLCklYHn4LKspc4oObBHAAA8qbTvDoqBCEfPEGeXn1RSJbj2zg==
X-Received: by 2002:a05:6a20:1054:b0:1af:cf0c:95aa with SMTP id adf61e73a8af0-1b212ce3f7fmr10155297637.2.1716841819017;
        Mon, 27 May 2024 13:30:19 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092a678sm5324279a12.11.2024.05.27.13.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:30:18 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/4] lib/sort: Remove unused pr_fmt macro
Date: Tue, 28 May 2024 04:30:08 +0800
Message-Id: <20240527203011.1644280-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203011.1644280-1-visitorckw@gmail.com>
References: <20240527203011.1644280-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pr_fmt macro is defined but not used in lib/sort.c. Since there are
no pr_* functions printing any messages, the pr_fmt macro is redundant
and can be safely removed.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/sort.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index a0509088f82a..651b73205f6d 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -10,8 +10,6 @@
  * quicksort's O(n^2) worst case.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/sort.h>
-- 
2.34.1


