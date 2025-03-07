Return-Path: <linux-kernel+bounces-550604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41637A561E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A1172A7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4631AA1F6;
	Fri,  7 Mar 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfQyf8Ye"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E531A9B34
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332906; cv=none; b=WOqeGTBEIg4koy3daRNTQ89WKXVAgaGXDaVRSS3L0c3zO0DDHf4b19kUT0ypB6vARt4BNDq5zy00SSik7/nXf1lRMI+W9Pq05YQrSJuXSDLe7b2mJFL6Ui7o2RTCP6mQysmEQAI9XxgBXvjnhp6lXAsDWnYKgKTEBPRJtIjOCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332906; c=relaxed/simple;
	bh=fTXXbYfB0BUH1DTF0YolYq7hexyvidsXazu4RK0mlKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGjCtsGai8ac8fA37FjV+TQdPmBmrZdk2v9mE/N1VMHknjZRDS6wuOWWVsAh0yzlmB3ZgqgyPZuIXQ5+6UvnQ9eUWXQpwB9f1S8x1ZuCP+31yMICDRhhgwEU0LHVkPXXSbQDz+OrCihRBk3b8qfub23eB08hFp5QoSUVZLByO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfQyf8Ye; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso2804682a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741332904; x=1741937704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNjPZDPj3mGb5UUG5cx3FWB8PP4SBA0xRr+ffK+aNvI=;
        b=TfQyf8YekiaepaYT0wPmnd82PmbfczzdjD5jKbW2Y3kvQg6D4I75jAts5gXuhbWZc/
         24CQf+C19jWEIZQxnW9do2wKws6dcxXvaZT91KS+woiaBvEhbNBrskWQatAIFIkC6fyh
         mvj7RvEkZlZkP+SKinj5t2VadDL4oZhcZHitFc9C8o3+WeKiveibZITSgS15d4nbO7b9
         DJVxE23maUEbCTUIlC6qQkb9EXOoX7tfVcyvPoHd0sSWqSQo/YJm59O4rD8AI8V+nVLi
         P0mhR3S210GGMGlCDwWHxYJnNQQ/Ijvi+ZuVWBWilNxja4Ka65oMeJILVrtUvv33qmqw
         NmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741332904; x=1741937704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNjPZDPj3mGb5UUG5cx3FWB8PP4SBA0xRr+ffK+aNvI=;
        b=ah2XkaGsKMQVLGK1YLi3InJo5t+QZMuD2c7AfcqEwCfTQ1p9LgI7TBFtKmKZFgkogT
         Jf/7ZWtYB0RUfz62R/0tSYXupBf2QcBpzrOb3roH2bEJfeQy0CHL8jpovVVkgPbQXdCX
         UVW1YFR7Iu4+Uznw8Wz2cvr5SMYMdTGwp929/5CUJ+fQhXzVdjAh8kX6HbDAc0mBVy1V
         xN4SELUuM+mPM+Hkm55Pt1nwG/YLkmcXaeWkPv1wA6RYfYAT3OttODe5kNxqIVtkQQpc
         wA70VzN+0XMJyQfU30U2DWLRzAU6n+PNu5iwFLbbkMlnbZF3wQ25D6/c0unRuYp4UEqf
         h4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWq0e316pS4jFdpHsamIYEvWHnOJTa3K6CiHMSsYvulrKrEZTqCUb0oWQB6i5FKwrGdeNYamuegmFXqWOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/lsFpLnIiuSqB48pZLQpRNeoNDFF2rnwWMzZxQRNYtDtu+IX
	4lrCsRswuCNqjSAo7wMnTH2meAxZLUfRXqh2CKWP5eTtJDETQ9oDkK+c3dAqg1g=
X-Gm-Gg: ASbGncuuwtbZO40A8M+8RIEGrwzyiejY11usdUkVz2ZZ2qbDMRInQ5ltrm7ZZzz8JNv
	H7xZSdWOZVX0SS3CPNtmSd82Qw27fZ18dsXV+5BvQAQv0oSU7e61kxlWpJABMlOJKyq+WxuL+KW
	8h3Pj1iC+MZ5nnMgf18ARXtj5lyzCTChFzqdOxbYtoAzxoBQpAVgL3FSNgvzu00QoMge0/l0Mlh
	V94S1wHGWypWrRvkQcaT9udNZa/KYdxF7hAGuAGSaBx3/vdiG9XHXN+YGAcBf2MFkteloihv5O2
	gtydGpMiaiQjGAZzlwB0TCsnZvzXC7EpXnNQgxZpvlIJdQ==
X-Google-Smtp-Source: AGHT+IELLQymfxCOfXAQsArNa5EtDTkaOw7sWZqUBknBo6zO+r6U5BuBGVSheMI+bVvvCeDVppbhlA==
X-Received: by 2002:a05:6a21:78a8:b0:1ee:d87c:8051 with SMTP id adf61e73a8af0-1f544af83d7mr4983169637.13.1741332903923;
        Thu, 06 Mar 2025 23:35:03 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281093128sm2037888a12.22.2025.03.06.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:35:03 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] docs: core-api: Update kernel-api.rst to include cpumask.h
Date: Fri,  7 Mar 2025 13:04:52 +0530
Message-Id: <1612cd8c37245a9f1b25d470d9889a22ca9aec9a.1741332579.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1741332579.git.viresh.kumar@linaro.org>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated Documentation/core-api/kernel-api.rst to include `cpumask.h`,
providing better reference for CPU mask operations in the kernel API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/core-api/kernel-api.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index ae92a2571388..5817632381f9 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -90,6 +90,12 @@ Bitmap Operations
 .. kernel-doc:: include/linux/bitmap.h
    :internal:
 
+Cpumask Operations
+------------------
+
+.. kernel-doc:: include/linux/cpumask.h
+   :internal:
+
 Command-line Parsing
 --------------------
 
-- 
2.31.1.272.g89b43f80a514


