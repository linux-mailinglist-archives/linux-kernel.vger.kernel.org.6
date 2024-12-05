Return-Path: <linux-kernel+bounces-433945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B19E5F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E6D18859E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B0227BB5;
	Thu,  5 Dec 2024 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZEhP3P/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1041B218F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428116; cv=none; b=DO+4ykPRGLAwabU5JU114/s7+eFv0gJ5XK4eK3dVDnFQmL5fxP2pW9eHaqgXe6pom6MYxTIKwfFN7SdSgGRsFDW+DwhZBxaR1pQcegO3N0ORTkLPkJNFaJJy2My2E6ecQuAGZjktKMYLnpCll6lv5fVsTfT0jACvywejmQ6BloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428116; c=relaxed/simple;
	bh=eX5VrkAkMeuEKZF4+uEhcM3YstJ2pCcD9YjxdfPOzI4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DWNkUuiJPeElIwVTD7iPWQTvyB1Nn5PXEUyyCnFiCZ0wVh0ggubQXbw7KbDHaI2dFvVFUAfYbmAJRGezQqspEIS5ceK4rwrRnX0mLe9VQVDrcXmrku91LeCCmvNEpPrA0wfosArb6P1KsEVFs0eSUiIjcyx4Czhp3IqPriwgiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZEhP3P/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ee3c2a2188so1047132a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733428114; x=1734032914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yc3E7o/SbjIhWXX/dUDW6jjztM4wmXPsliGgXmNMSL0=;
        b=xZEhP3P/c5Nv1EG2BJxCMmmmm4jMG/0gdY/8XSKRwvVT9N0pb3BjM9cGz7Aw5dKus6
         tCnCXQqzSxT/oUdSa1D2Mv/UAdh72ergPvZ4pX3sGssTwqcH6PhnyIK9g4EF2qpCxG3O
         C7tfzEWdJrkYs94+LfiV+8LJogXlLJ1+lwosJSCfIHjhvIegDr2gz2coSX3n0KYz5QA5
         rmRfb2bvdSm/kVgNh+fCjcPmlDpoqXYTUf/YrGwboaupTmxUn8CgQ30nqjBzMNj/c2aW
         QfSKSsdXCiGM7AYPp2fvWqOQVEjsSWRRZEKNSxCwTAOXLV+idC9PuF4vsfc/WKanTucR
         cmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733428114; x=1734032914;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yc3E7o/SbjIhWXX/dUDW6jjztM4wmXPsliGgXmNMSL0=;
        b=GEQr1vr9AdNQEJDrdHFq0aEKTbinl51Jf++/7DHXwsrqvvyFMrVgQqCLs/t5S6yAMx
         LkbQJdFLYnLueSnbh30HgKSsxlNXOwRqiCPMWKQOZEn9ltdb7BsJl7g1X1SIimdWeid8
         etB3zFJGV4pLnU36qmj+NUO5YcpXeZlMg5HrygeX0JlUyNbCIGz2XGjB3C0WkP21fcIp
         vDU7G7KsCEvRxYjUtFL78T1ZFGyuh3yzwtwmpi6QiVxyAblI1JZMum2eh6RnVjPJkoJN
         /QRwWtN0nh/mBwXD/MfK85OOclxIdnxgAhSB89XQuTcu/facfRCvWT/yAfQN6Qj36RbX
         mY7g==
X-Gm-Message-State: AOJu0YxBbzv7eMpWJ+xdaZSm5y3q7AS2jjmCp2kmPJq4w+ETLPLlBlj2
	rJcwhgfRkAmzk1UBvvI1W5eqQfXAnyXTqNdVuJDBueUVPsotr7/JomMLd6jletNYKy5r94WXB2m
	mS04odyDfeg==
X-Google-Smtp-Source: AGHT+IFsMkOvDaS2c2ZtWyraPUP71Svpov2zZ8HVC9bTVPzaamEd3JOMrlagvf38/bMsZVoVKbSI/TrXEsJqxA==
X-Received: from pfbbs9.prod.google.com ([2002:a05:6a00:4449:b0:725:9e76:b700])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2583:b0:1e0:ca95:2de8 with SMTP id adf61e73a8af0-1e18717208emr242968637.46.1733428114627;
 Thu, 05 Dec 2024 11:48:34 -0800 (PST)
Date: Thu,  5 Dec 2024 19:48:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205194829.3449669-1-cmllamas@google.com>
Subject: [PATCH] selftest: media_tests: fix trivial UAF typo
From: Carlos Llamas <cmllamas@google.com>
To: Shuah Khan <shuah@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Stumbled upon this typo while looking for something else.

Cc: Shuah Khan <shuah@kernel.org>
Fixes: fe8777a8a0a1 ("selftests: add media controller regression test scripts and document")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 tools/testing/selftests/media_tests/regression_test.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/media_tests/regression_test.txt b/tools/testing/selftests/media_tests/regression_test.txt
index 2627367681f7..9d0fcd98c085 100644
--- a/tools/testing/selftests/media_tests/regression_test.txt
+++ b/tools/testing/selftests/media_tests/regression_test.txt
@@ -1,5 +1,5 @@
 Testing for regressions in Media Controller API register, ioctl, syscall,
-and unregister paths. There have a few problems that result in user-after
+and unregister paths. There have a few problems that result in use-after
 free on media_device, media_devnode, and cdev pointers when the driver is
 unbound while ioctl is in progress.
 
@@ -15,11 +15,11 @@ Build media_device_test
 cd tools/testing/selftests/media_tests
 make
 
-Regressions test for cdev user-after free error on /dev/mediaX when driver
+Regressions test for cdev use-after-free error on /dev/mediaX when driver
 is unbound:
 
 Start media_device_test to regression test media devnode dynamic alloc
-and cdev user-after-free fixes. This opens media dev files and sits in
+and cdev use-after-free fixes. This opens media dev files and sits in
 a loop running media ioctl MEDIA_IOC_DEVICE_INFO command once every 10
 seconds. The idea is when device file goes away, media devnode and cdev
 should stick around until this test exits.
@@ -40,4 +40,4 @@ keep ioctls going while bind/unbind runs.
 Copy bind_unbind_sample.txt and make changes to specify the driver name
 and number to run bind and unbind. Start the bind_unbind.sh
 
-Run dmesg looking for any user-after free errors or mutex lock errors.
+Run dmesg looking for any use-after-free errors or mutex lock errors.
-- 
2.47.0.338.g60cca15819-goog


