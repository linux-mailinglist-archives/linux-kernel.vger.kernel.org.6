Return-Path: <linux-kernel+bounces-281019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28BC94D1F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E921F21577
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F8196455;
	Fri,  9 Aug 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="W2s0TTia"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C0197A61
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212967; cv=none; b=t46BWOUP2UfBakhgR9wc16P25i0X/GF6rvTusYRiNktoiwys84Z3xvqSK202mF88XwTPr8Q749YQI4XCpuASO8J3ffUXVvoyPIRqB0WP5AEw61gzjgwxtfQ6qAnOWPCEIqOQScN4PAvIOHEgzMBqGvYprL+4hNYJelOqEwkaPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212967; c=relaxed/simple;
	bh=JO1le314EGJaW6qV/MxNj0TNv/5UycN4W5bhvEI0tAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DBD1ZCO0jC8DobgXcW+tVXjz5uyok45JTQpEoHdPNr9lljbFM71dX8dV7RYoL/fJA7b0io2l3ItHvtovW3dmHPpwieBzojVUDX0jv6Sx0Okqc4NP0Q97Trtn6iunS/RtyuqUUGLA2SJ1P6UVhYfa9gK2CfeFWkwDPBM6Ft7iMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=W2s0TTia; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42816ca782dso15622075e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723212962; x=1723817762; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNOi1q4AG7jmNuu18SwGZqvoOJa6h00mk9Z+2xI3EOg=;
        b=W2s0TTiaz/PyYHd7Nru7y/8/S90lMgOP9v9/03TjXycth+DQ8TcD2IuCkcQgOpB2zJ
         hsHDXcclLmoYyS9b1nvymytcmubrc3b+WAuzRmA0Dmb8P+VsHRYVB0kTj0MU8aRBpjPl
         dEnAWHSoZ/8s5FD2FpcRv/TFf7kdDIA8fKLjE/8zL4e3u/NbfYoP17u5Tv8i4N6jHWXA
         /90FhKBxQAffHwMI0fIm2NHIcdCC24z3GKZvQmLYa2l6alAyJkJsbsZR66ZGFXR3HdkH
         GtoSzwbV3ywN3zFPU8emKPHeP3ailI/46KYcy2Beg9cGQpuUbtX0RDEzcucZlbeyJYwO
         /oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212962; x=1723817762;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNOi1q4AG7jmNuu18SwGZqvoOJa6h00mk9Z+2xI3EOg=;
        b=pNGWMTT5fc+clWt/m0CE7yf+/3ty9Wzg91B1LqDXTzcc6HOZXXogSPiWDhNaQSaHtS
         e7ShIwMK/IDMQ02UO0ayhAkjlFv/3lN7e9/jSmqotFj7yQ752RGYF9Av77hmr5Nwe7JP
         q2gmsDl8OHjPgo7coIC3ZMLOapRZq1bUoQthbOlVpOK7lfwQz+x8m5zB70AAXuIb1As+
         9pqsV6hwZ2VDVhZbzMy+hlLQH0oOFtzc/cnBNa+uuscPbwl2Qf6e6viVjeheEcm6HbiG
         tvC2KaNOhxd3wzXZw6zqohTZ6VRVAyRwkddrxSkgESxhZ1QWg8tLQ9a8DUapjRQ30pRY
         bWDg==
X-Gm-Message-State: AOJu0Yx+swj4BXap1ZyKtVHtFe8ULf7L4gwdnigBd2O7tJ9mIS5ExSZR
	Xf7V+z9zufns0LCWjhuhF6+nKRDn5zXzZ/Uc0DoXWmtzbKBvAXXtkDRRQNlAAM0=
X-Google-Smtp-Source: AGHT+IHk04RpOE7FDwCWCw6DCzntLCZdM4SZFFVpj0VZOmJZTt+OYqDYs6FEHNwVz7kOBCT7c55QeA==
X-Received: by 2002:a05:600c:3b09:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-429c3a29bd3mr12929185e9.21.1723212961596;
        Fri, 09 Aug 2024 07:16:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8289:d6d0:e805:3543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e049sm130484035e9.23.2024.08.09.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:16:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] memory: ti-aemif: code shrink
Date: Fri, 09 Aug 2024 16:15:53 +0200
Message-Id: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkktmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNL3ZJM3cTU3Mw03cS0NIMUs0QDcyOjVCWg8oKi1LTMCrBR0bG1tQA
 K+OO7WgAAAA==
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JO1le314EGJaW6qV/MxNj0TNv/5UycN4W5bhvEI0tAQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmtiScTCOrzLbl1bmjZwYIQOjL5nW6vq8eKGHCM
 KIjWOfKlTmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrYknAAKCRARpy6gFHHX
 ckyKD/9fwIkIhIe0VeDEzh9vmtE3b5v61jD+7LTamW14VUDJoUYMrXmz9nsJf6Qvhj+CuSXklL5
 83AU4UWsfni7R1NEoJoKe9vM7uauvpImG9a29AZeuc+d0hBXJ6yzL95OWxOL3HXucYLwUVfzFhD
 WL6l+OrpWAg0PXt+exmV4sLuphtwuat7GM25ZuqFTmONWBxPNKmvQl3cxkWugxCvOhD95GARmro
 u4QBMa6+Hvpcay+1SB0uEclTLjdwPAqEK0OHzyCM6GOtNLi13O/0rHqRwhseAtNX5BudV4PQ0zV
 H0Cyz4+Ll/KMQ7Eb6iSacC5swm6UaOJ9FTU/w6lNHecVrCzNbGcRQuDvQAH29KN6GZCWFA615uS
 5Ixt6yRzD6W4CwK1YnXLX6ioO7nlDSM+6xcOlm9Uiev4xSXQl4ADNj6o+dCevqYgrwU0tcNOMVf
 27XLdeTBRBdrcASvVh+c+IqMY/2sQwevk0dtC7zbG1v9hQ+XxRirIHHEqmT2vGlVTPgbIkuI5Z3
 3CYv6Bt/UzekQ9CUyL2wa0+f8r4bCXDblpwNFrHWULf5ql/p7Ke/tO0NJFNwicmCY5+dBwZj/e6
 IIxduWvPYKyVPDjpcWWH/xOg3mvY5JlhcFPEE5gB0oQlmjwJtdA8lg+0r3zH3gQDx7lhXPsBR4Z
 rscZ4oV+iTAMy3A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here are a couple updates for the aemif driver that result in a significant
code shrink.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      memory: ti-aemif: remove platform data support
      memory: ti-aemif: use devm_clk_get_enabled() and shrink the code
      memory: ti-aemif: don't needlessly iterate over child nodes

 drivers/memory/ti-aemif.c              | 60 +++++-----------------------------
 include/linux/platform_data/ti-aemif.h | 45 -------------------------
 2 files changed, 8 insertions(+), 97 deletions(-)
---
base-commit: 61c01d2e181adfba02fe09764f9fca1de2be0dbe
change-id: 20240809-ti-aemif-aff0d6a0722e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


