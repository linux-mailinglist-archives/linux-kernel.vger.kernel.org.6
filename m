Return-Path: <linux-kernel+bounces-548261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93BA54277
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00553ADDCC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98419D086;
	Thu,  6 Mar 2025 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="anvF/6cV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5917E473
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240537; cv=none; b=sTnXGqI7ZBqQmqBarL8EtVpUX5IjdU9qro26W+dSThbvXGOQHnK5KfPGWMJ4VyUNuTZRHS51DqcXH2VpRKeDRneHVIeyzJg47+tqZfV5byI+6PrKtEU7n7pTrpEvOWQ3R4SZpPJxIrAK4VOiborqM3n5INIfiEV9066e2sgWv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240537; c=relaxed/simple;
	bh=fStPxmsCJIjNv3GU3HTZoAXZLVWt4JfQuG8MDVhJlTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gpBfhLMidfhM2zUoQAD6w0/RZ9hdUqrEv1VwAqFzFPPIq11fGH7jGqX4W/lkdb2hpnyIuD9gZwimM2Q/tYrTnUN5/hY3enoV+BAaCtd02HA9CkEfA3b0dqSkxNDbvWrfczRBdjXQc7BPbnziHtMmZh6D0cLaoLz/YJ7/oByQiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=anvF/6cV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fb0f619dso4153475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 21:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741240534; x=1741845334; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUdx3QRyuZIX7/o+JJ2wds9H9VcUk1U/xmQVPBXai18=;
        b=anvF/6cV9SGBke0ReSodh++QuZwCEU/BnTwRR6j26ZjgYoU1O/KIbl6MgQ53ZnH1Ra
         2IAkvZsNltj0nILEToutdduayMnLHOQtXqzt6wyrn+oceYEMlwutxNCibv1andkrPPq1
         p5mM8rFUk+vRD10BUFTAHVjWZitunFie2prYiOLcyAQMSpJZ6F4hRnLgutOyuSE/RaW/
         /GSWCngVhrUzmgvCgMJP3OW82HB8VN8dbuB5Cyq+AJrS4nv28BXIV9PypGmuZDW6votk
         WEdC4t212ctL99u9sphpgV4M399X/PlaBdYz1Mv1q3cay/UGUHjCbkXGtG/1AvvRi/cZ
         iYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741240534; x=1741845334;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUdx3QRyuZIX7/o+JJ2wds9H9VcUk1U/xmQVPBXai18=;
        b=vVea1DeXitgWTeSF2ac5f9tLclm5DjGkFtVdweN8PS0J2E5HhK6gX/OytXXVyaivxj
         rSSeFa5lDkx9TZFrZ+jOsndkbXpZzYCtcSEpmWQB9Q+oflo0UMina1+LgFgn9j6egsch
         /TvMwvvbSAeYg53Ipp4Dh5QCSJ09F/I8KWBbpPMRgbqhp73Ofvomd64Tw0yshS9H31wT
         djzM4N+KpOL2QyDnK0IAF1MLP1LqLRS9c+kcIuWyJoAbydMoOPYKZl1WvZJqiucwemn1
         7dWppubnNboI95O1wb0kVbcJa7YurWXsc93N36/neL/8bovJMYTf27awsOJcCR8q2eCj
         RYHA==
X-Forwarded-Encrypted: i=1; AJvYcCUWN8DbX4UewXUkRRqKKYGoqpiCX2dDY0NCSAZ5InDzd5KbkmULdO3x0Hzt0NRl3aHEaAAg+JFxvwNMoEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBHNeRKaarMHHVkxMzfyCvnWe+HJceEu0KzWg7BBZtlqGXjTAA
	tVMfFJ/Fhry2tql6O2QyYtifLhrExkj+X0coTWzOHai7rdWcrcmA3UaLg8zLaS7ne1a8FrHBG8R
	i8Dk=
X-Gm-Gg: ASbGncs0tyThP3OEmiWff1YYA5TpGL+GHwNyemsAjiil8hmw9v2PEGcK51c8UooLFI2
	ofFaFdNI786AK2qnxfLkVyxSayjwp3IscsNTOjFSSy0A71dUH4l4/orjD7jnm3IpOVu8dhbqwpC
	bjydJQJZ3IeOSV3GzoDWGe7wWcJANdr3ZWQNkhDkh2XwDvAX5wwpnafeTPYbUOL5Seb129ZZEc0
	xGmF7rd67IOy90w38K4e+42i36VvBvlN57ymPhIPIatfP9iERUdK25Ks6LulFeds93/dl8ineDP
	Ec/6fzOsfnG8ytYoQ3xuO6vaIpTCtugUlZ0rpIIZgx57npOy
X-Google-Smtp-Source: AGHT+IHWmtVby/odXZZF6dFxs4Y5suzRcbfsujqB5xfNftQwM4rblktBoE/1Jwu1suHSRVUrEebhQw==
X-Received: by 2002:a05:6a00:2d1d:b0:736:61c9:f9a6 with SMTP id d2e1a72fcca58-73682b6c31fmr8000931b3a.5.1741240534431;
        Wed, 05 Mar 2025 21:55:34 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698515094sm458717b3a.131.2025.03.05.21.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 21:55:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 14:55:19 +0900
Subject: [PATCH] selftests: Override command line in lib.mk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-lib-v1-1-85692f1a7ce4@daynix.com>
X-B4-Tracking: v=1; b=H4sIAMY4yWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3ZzMJF2TxGRLc0PDZEODRCMloMqCotS0zAqwKdGxtbUAszSkVlU
 AAAA=
X-Change-ID: 20250306-lib-4ac9711c10a2
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Documentation/dev-tools/kselftest.rst says you can use the "TARGETS"
variable on the make command line to run only tests targeted for a
single subsystem:

  $ make TARGETS="size timers" kselftest

A natural way to narrow down further to a particular test in a subsystem
is to specify e.g., TEST_GEN_PROGS:

  $ make TARGETS=net TEST_PROGS= TEST_GEN_PROGS=tun kselftest

However, this does not work well because the following statement in
tools/testing/selftests/lib.mk gets ignored:

  TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))

Add the override directive to make it and similar ones will be effective
even when TEST_GEN_PROGS and similar variables are specified in the
command line.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/lib.mk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be832ddee4c3d34b5ad221e9295f878..68116e51f97d62376c63f727ba3fd1f616c67562 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -93,9 +93,9 @@ TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi
 # TEST_PROGS are for test shell scripts.
 # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
 # and install targets. Common clean doesn't touch them.
-TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
-TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
-TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
+override TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
+override TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
+override TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)

---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20250306-lib-4ac9711c10a2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


