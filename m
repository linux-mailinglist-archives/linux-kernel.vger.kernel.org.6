Return-Path: <linux-kernel+bounces-434345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7D9E6549
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A94A1884987
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1AE19413C;
	Fri,  6 Dec 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrVBQud/"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5018CBFE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458132; cv=none; b=SyFGqMSjdEETnjCs01Hg9qvaNu2H0OUzLIiWmKA/ep3u7YFf0KmQDFFZ8+EL5CCRaZngdNTq0LRdDEJ5aP6RaDW/IeQdnGZ+nXQPAzcDut1OtsFvWMYZwT/BWfVPSCcXElEhMiG/KAga6QAi5a198HtjyF4dfTgai59IBLXQcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458132; c=relaxed/simple;
	bh=mfEM/DG4PNsmSscMrTtijAKM7ewta8wLDkEBOoOqr1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKAO8VuWB1fl5JpbL8bOVu0AXnQqUXPJ6HMKVNlj/mJ4NmNrgGAqNL5Nopr1FL96XY1xXAhSegFRx2ZUaOToORTccaajqJbyXf+Wn3UgwNQCxMB8hSCO9RQ7oB3PcLmQWEE4DLRKpKeASb3gs1fObj+/m0sQpoPFhWvKq279s58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrVBQud/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef1cec0326so219047a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458131; x=1734062931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pycc29BcH8MRwie8Do3jeg7dOfWDOOE59oanfpjCi0o=;
        b=ZrVBQud/OGxzB/B/f18babgbVCORCrWMXfrTAA5dku3BxdfA3gludd3umcMX2hYrXM
         lObEWPSn0Ejcs1XdC+Z7ou9zrityUFjbTGQC2VSrnFYDaQT/0Pmn3wANh5qoRbsSnxK8
         aDsdIf0SXer1f3UFi0jfj913y5GtdbeDJQbxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458131; x=1734062931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pycc29BcH8MRwie8Do3jeg7dOfWDOOE59oanfpjCi0o=;
        b=YWcZhHCEBp14MjghrUOvnuEIpygQVQcXSbB2gqjgfR/ch1d4DLDI1oE3q/lgIT3orL
         nT38keAdERsOgJvkilkCJi+N9Fq5OTEMjeOp5K1umock86g+nzrXfFqCzrsC6InNOB3K
         2eUygqI0OBrgs1o2hLvObGXeUcVSc9Y8+h2mvurYPpi/IxL3Ihuabe8o/phET1EJ9Qe7
         ulVdn7wSNTuWZZas45LpcPSHTMy6hv0upkiS27b0qX03h/qrZRiIkKNFFqWuqDOlo4Mt
         MvS8mjZRIHrHxelrOl8ol2GLfgTSBCL7TaVvrk/ivMl+dtlGpMj5iuwnQBMk2HvCfPWG
         JzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzPyhYja4GmTXOvpDh0wMyH5h8+DjjXGn0P6HKNEaAMV/P1kt2Bl2Ap4HcbxU8Lqbn71XLZUc3/BAzGbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS53o9f4ylOuddP8T27ZPsMWvqFdbCczeEiryNLTq1xBDaxEAe
	6Mo1R0qRf/QBo4dG18mf9SQOb3/wGF8CQYx9qceIwLUU8CZ+goxQiS8JdzzHfA==
X-Gm-Gg: ASbGncverpg3UNgK0dTNmKK5Em9o5iPr/jKvWXq2VIH5NjmKvTpHIhRySnCnBboSvnf
	RJE+JEIKRkMleEF25E7GmaGNAiC2YtyLLxiiDZVDUkNnKFOZJPo62RLiSZLpDfiykhrPNhKPpqj
	5sTTfErdubnYww/UbA3Tx9+JxHT3Ovi5QJ97OxslkqFAaYVDvFKvCRW/w/Amf5ApfzlsAtj0Knl
	VMoEbUbmNkCAKPlNckpcQ6rUx1z8+pbuHlv4Vwgqx+zfpAq1MwLDmnwe2u33U909W8u6RWPWIbr
	8DmOmER+A4pIeDJ1cQ==
X-Google-Smtp-Source: AGHT+IHxgK0uBuqS9VxoHyUeS6mBM9E7ub6R77truPmNtH3VetfzIrO8WGEyYuJM9Zme/SwKoAuxfA==
X-Received: by 2002:a17:902:c402:b0:215:a3fd:61f9 with SMTP id d9443c01a7336-21614dce2fdmr7340275ad.15.1733458130805;
        Thu, 05 Dec 2024 20:08:50 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26ff2sm19920525ad.227.2024.12.05.20.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:08:50 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.6] btrfs: don't BUG_ON on ENOMEM from btrfs_lookuip_extent_info() in walk_down_proc()
Date: Fri,  6 Dec 2024 04:08:46 +0000
Message-Id: <20241206040846.4013310-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a580fb2c3479d993556e1c31b237c9e5be4944a3 ]

We handle errors here properly, ENOMEM isn't fatal, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0d97c8ee6..f53c4d52b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5213,7 +5213,6 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       eb->start, level, 1,
 					       &wc->refs[level],
 					       &wc->flags[level]);
-		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
 		if (unlikely(wc->refs[level] == 0)) {
-- 
2.19.0


