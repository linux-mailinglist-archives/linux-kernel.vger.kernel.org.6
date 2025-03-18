Return-Path: <linux-kernel+bounces-566405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA3FA6778F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390E53AA822
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD120E71F;
	Tue, 18 Mar 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ3j7bxy"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0720E6E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311047; cv=none; b=Vaw9XfHSYmhnFPzWY02bE4OuH6oyDYsuN/QDJb6YNMsC2ztY0OWaRDb+HbkoCgdgkGiZy2vmZ5vfB6oFf5bZFHBwxQHAsdXJhS1xYXQMIIxw3rh5T9kWHfb/mCLZIKCFUJ4YLg1eBM2qQVcixVX4SZkptpqwsW86jug3ILAQk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311047; c=relaxed/simple;
	bh=qLj6QijfPDPFIocxmzeaBvK7OEDloNxsZviCdn0bJIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LPgiClvD96JLjx/Som42oDcQVFAQrOay7tAckZHxNMdeX89MrwWY2uKE1r5ulRxJ49tS2EPG+smhDAHcKzJmE6+hYeZawGSJHxLnPiamR7R9A5PmvybZh64QOyf/SN6iAp82US3ATxKbCMQBHJbMGFUJkW137O+swFlGQdMqpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ3j7bxy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30155bbbeaeso4719608a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311041; x=1742915841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5xbk2RW4olAIIgppxlquoOWUJxss7kh40dJtVRvC3o=;
        b=OJ3j7bxynfvrC0J0Y+I6Riktwt07488wfDN06GepZmWROmRHdPicPdHUB+Yr3wG8iu
         qv9+FHtf/dUAC0YPvT3/opAa25R+3b3xjPqb202jodkGnmPOyuvpzS28D/KupuOmIBQ7
         iNf5g8DXWfbKEWPqlSbZVoEAm5rbENPp4A0Hpy6Pw9w6T36BX+Ap+dNxPjEkAw5ef8Hq
         ALzI/JsDk3X4WQkIoq+Z6Gc71Hn0GtJPuOoZJlsS5glxV4yDvFc1GytPRxHZmMkh3b56
         ilWzF/JLlCeoFmH84NpLX53oIQPbqaE6mbLmgDBhuSDxZqIguRMQQjakLA9AMCdRoGGf
         jxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311041; x=1742915841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5xbk2RW4olAIIgppxlquoOWUJxss7kh40dJtVRvC3o=;
        b=Oj1l4d7/qh0I90P2QlJ7mMyfAf1rgw3DBymjnI3h5dHVS2lUPSMh2tlsh79Fv/pnjl
         cCikTjRsbiMuIV1b24NRYU6BFhB6ny/sr5iybeZLF2SnF+thsdaZ9msr94qFNlogKOKT
         3h4Bvc/ooF4V/YR4BNjr2gwhND7NaDDwmRBSgLpHu7oOmjaUCt5/Bpwzop307cvwOeIC
         szWeeXPDE4kPqavN0JwP66rvZRSmtOt6xJ83hNqeieFYC+gKSBRrTiBRId/3SvdHyMxO
         WEjY/jM6jXEgI/uCc87XYMna0vii6f5KHmOSWiRS7uYX2K6IOeM1iQTbQ0MfLw1jSl93
         SowQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqL/99W9vB3np0mjM/t7Wi7OgDpSd1jtVZBlkQQJdOI7pGBg321b3ObHSPwDy8jk2SVc/vRmoKHZyHqys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgZhxcx6/YiRnxNY1dCoC+OViU9p7R6/e4d54ioDt7WCIQW4P
	iRuqK2HrHEJnaaDJiwHF8DJ+HNbN+7/0cE/QG/k0J1crxd1VNjE2
X-Gm-Gg: ASbGncvCh+hjTslL3FsBAFMTiJBWFgaCuVNvuJn2TFZF43Zcy/hvhcJ2EWfjmN/uDrz
	J1yMQPgshnNYtRecyH8rZ4WBt9Yrhrg5AV91xtZHe7ji4lEzZ+WvYhZfGY6g3rLyeognf8vQraj
	M0CI1OhJaqbuFKYm29KLEdWCvcV7n8i9d294R23QdHUBqkon1lTbjB3c5Exavr7R8FoL31nTKxv
	muiq8CkSajLQAeVfr/NykaBRtGhR415a4fXYbBwVp5zZLzckcxsGweta1Tn91aYRR2QQ6p6OL8H
	ArK1/UW2vbWPNJNF8QZQLcRF+8fOy4lR0ITx0pjzXDrwrgoN1zPL7YO8jLxz20a6BNY4
X-Google-Smtp-Source: AGHT+IHuoxBUztaTeqHFIy/VGlIjdHOHmiLn3CiwQpMF9dTHHGz6y07JQa9M941BIToVz2CH09aJFw==
X-Received: by 2002:a05:6a20:d806:b0:1f5:55b7:1bb2 with SMTP id adf61e73a8af0-1f5c11277a4mr27050144637.6.1742311041187;
        Tue, 18 Mar 2025 08:17:21 -0700 (PDT)
Received: from localhost.localdomain ([183.242.254.176])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-af56e9e3a29sm9095899a12.30.2025.03.18.08.17.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 08:17:20 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] firmware: psci: Fix refcount leak in psci_dt_init
Date: Tue, 18 Mar 2025 23:17:12 +0800
Message-Id: <20250318151712.28763-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a reference counter leak in psci_dt_init() where of_node_put(np) was
missing after of_find_matching_node_and_match() when np is unavailable.

Fixes: bff60792f994 ("arm64: psci: factor invocation code to drivers")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/psci/psci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index a1ebbe9b73b1..38ca190d4a22 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -804,8 +804,10 @@ int __init psci_dt_init(void)
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
-	if (!np || !of_device_is_available(np))
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	init_fn = (psci_initcall_t)matched_np->data;
 	ret = init_fn(np);
-- 
2.39.5 (Apple Git-154)


