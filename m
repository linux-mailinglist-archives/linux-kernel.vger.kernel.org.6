Return-Path: <linux-kernel+bounces-287324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F188495266A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE381F2211A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF5A47;
	Thu, 15 Aug 2024 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSbdWmEC"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6133F6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680279; cv=none; b=qBXBDha+E94I3nI28lPJfX8xRAB0WJD7uZv4pU76MWWag5WW+tCH25dm8o4qRHbpZfpJRLbkdDSWSeVBmzzDjmbQc8TQ1cO9Z7iZp9BwQP11T0zG850Leavv8bqbx5Fb9/9GWRtw0xv1XwZZw7WZfIWUdu/PtRObTsEB1Fekuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680279; c=relaxed/simple;
	bh=bHdzoAQ9TpHRc8xnb5B/l3G9z7Cpe4OqQWIqw8Gc81Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dT9W16TGgftig3Ipnf9MmZq7bdQh+cqdExledPZB9Sb6jWQ1R1RWpP5Nz6bNymOg7CIP3y/43/66cW9hD5T0VHT1Pvl4TBZ2VQcZ5DVmAhotkR1+lA26QUfpDl5P7GuaHO343sRcfzpLj50uwt22XQN2BmfKFp28+N8WiLi6Tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSbdWmEC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718291cd6aso52622f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723680276; x=1724285076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oI0xEt04nW9vXke2inRd8VZEohgjA2k6NfhGuvD+VJE=;
        b=GSbdWmECv5din0itFAlqW2VBisk5YX0jHKGRK5WpbQXL7iqQnK4VHrsnoG7MKQ+FFc
         9ccE+ESNoRLODUHgx+hqq6NLMDWir5l1w/xFaLCt9ii4KeJLb83g7dtJNysLZ9UoxqTU
         x4yicxQ07YJ6nJ86jBC0PVQJa659CkfdSFAOmnFMD25VQ6HQRSfPSg9IN/tgydrBWFms
         Wwirstby/1/HWMQbnCL1dDoZe9LJTTJIjQIwHHut7zzdSiZIlM12kHnba9UxQmojiNwS
         wL5qri2qMSXLypk3PlobiYVEBd9wayknjCxCV003F9IFu64RqJifA3HxGVAi9TSoTjAK
         LXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723680276; x=1724285076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI0xEt04nW9vXke2inRd8VZEohgjA2k6NfhGuvD+VJE=;
        b=OAuLUeFqhBp2KCl+IWsSB6CVEtiu1tuo/oWn1du68HRdhzUxKCiucgV38ZhbSQR6Uu
         4vrLUc7nfTNtAmIhbO9b4HgYVDabNWSgv+qc6oYqRjJeTeCRZkG61n1EQrlAINoiXa9t
         C8hnpnBhGdm6sSuRHXW8hD+DKjmNAyUKnMfYfgokDCHmz7083AYn1yD4AUfScAvPf73S
         1xuqn9BewLoq9hZBzcDg/S3HMuu3V3CINKLTJlXGDW+8AtXzz0NQSK0cGEDycl2wiBjc
         6fxhNxhtyx/gbt+vq5R3mSckPAjfyf1SgXL6Hx3h/NKrcczeBWf27mScCf+pibWfkQ1k
         ULJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNpPTyCHFWNuKLPJtlPOIifCs+FHwJti16vnf7AjXmxe6UkAiqRUXL1YKWbeoeoNAXdW9UgTwbg2EIq+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45yMvyY/iX/cOPNLqlzvmhBuqVt8BsVAYlQYICz43USgtSmDJ
	ONVABClA4ZUTGRYPi4+wI5PoLwDcgFk1CaP1ZCTHqB3ntv019eTO
X-Google-Smtp-Source: AGHT+IG+t71s1X4Gof8Idlif5nSP0V2fAIDFRz4YizHFyhhpFs3EW5kKgYXQ5WfiqJBVsrnFSw1l5w==
X-Received: by 2002:a05:600c:4446:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-429dd280266mr18464115e9.5.1723680275274;
        Wed, 14 Aug 2024 17:04:35 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:ce68:853e:d0e2:925f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7bfd917sm4305575e9.8.2024.08.14.17.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:04:34 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: akpm@linux-foundation.org,
	kees@kernel.org,
	davidgow@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	erhard_f@mailbox.org
Subject: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
Date: Thu, 15 Aug 2024 01:04:31 +0100
Message-Id: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'device_name' array doesn't exist out of the
'overflow_allocation_test' function scope. However, it is being used as
a driver name when calling 'kunit_driver_create' from
'kunit_device_register'. It produces the kernel panic with KASAN
enabled.

Since this variable is used in one place only, remove it and pass the
device name into kunit_device_register directly as an ascii string.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/overflow_kunit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index f314a0c15a6d..2abc78367dd1 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -668,7 +668,6 @@ DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
 
 static void overflow_allocation_test(struct kunit *test)
 {
-	const char device_name[] = "overflow-test";
 	struct device *dev;
 	int count = 0;
 
@@ -678,7 +677,7 @@ static void overflow_allocation_test(struct kunit *test)
 } while (0)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
-	dev = kunit_device_register(test, device_name);
+	dev = kunit_device_register(test, "overflow-test");
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
 			       "Cannot register test device\n");
 
-- 
2.34.1


