Return-Path: <linux-kernel+bounces-376193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2689AA15A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F37B22D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CAB19D08A;
	Tue, 22 Oct 2024 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka+z0jPY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1519AA5F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597700; cv=none; b=WF/N0qibnuw9QimSzhwfQCqUJ3FXvbRaOTBkP7QT4BO84r9GHEWEVpzFMTDAKpqM8LQ44GMuS15k3g742apbf/V/TNGGjPz8cV+vFEkRdugCxmPznqmc08J6BhASG1sYM6qqKQ0+HuyTd2+XLOxGPkmKCQDeeRpxwVAWNLpSce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597700; c=relaxed/simple;
	bh=D/ynVHYmqi2Ckh7aFWJwqCLmolJOnpYqtWvCpDp09O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYalKjpaNkQ2On32w9y/TZQVP9IZrakV8e3s3jEp9TwHzJrkf9osnjIVhpFK45v1EIHFiUOa7bfAyq1GDcwAIAYyMekIKsI6lJ+htGQpA/41OrBVoOaaQndz7n0+aYdZjDDySjWq+bUZV0IQkDsd3P5KFjni4n7Dew43CjXgLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka+z0jPY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c693b68f5so58780845ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597699; x=1730202499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAlFXpVPV8uFWMmnJmNJ4B3bgnH5ueF+92q0u74/c1Q=;
        b=ka+z0jPYwXn8wuxQFGqkueMPImjbSiseU9vdxhROsJMltZDxPTJ+sHk+j/Izt1EZQW
         RpkCsoYUGcG+f/EPdKyAYCneIEW7S8Wu3pDGLQmuWXaxC07l2W1/HJOWLhbmZa01tD6V
         viDniqCIJIFvgMdjI5IugKPbZvnbksdPRiUyiR4vJAxeNqyRYvKcRg5djkSr4Q8mywD1
         o+znp0ljGOyl7MIJXoaja4EAm9uld/SCG8WCls+t/5VoivWusflN6ul9mWHGu3Ks2pd6
         KKC8MS17BBM9/W861ALmVFgdIsN2xyRj16zYXLC65Gnoa9yUTH+8RaNMuG811F4GIZ3G
         jnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597699; x=1730202499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAlFXpVPV8uFWMmnJmNJ4B3bgnH5ueF+92q0u74/c1Q=;
        b=H3eDoKH31/ahRNNznHswD/4M/PzfdCkLbOz9X5qhnPxGbkSZ/Lq31KcmlaM/LMFzse
         iEI9SU5NSckjrIyXOLTSmkUbQaDwmcl2KPFcX0pbiC65xIfsehsU6m/M1pJclwGE5YPr
         zfVAG3Ev+zmv7kQv0zO8sNj0raLAVKqgwLiNFXUOh6QHHLGUM3apijA0Vuq3im5/ZnYa
         LLZumTX4b/ZNQQr7urOf5rtc7rZiQo5i2ESMHsXjXRyfSXrsOJ5prEujTmtzLchnMXQ/
         CUC2oVOrzvuWn+EUi/4DPGF9/nRuIdKjzJCrzceqW7V0CeKKG6Po5zsTJkesHxYfrGb+
         YSaA==
X-Forwarded-Encrypted: i=1; AJvYcCW+So5L5m+Cb7ExyzEHy6Eq3j7/kDINSnqxOfaItqVFGuuslqLiXzlHOFypcucpUn7gmecvU4xHUQeMnaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArRs4D8K4s1XTIVhiStjxrsHzoNbT1+RfXH/hVSU7y7iliZTj
	j490XonBxkMiVEStKhClmnNTw+NGtHWJjhT/P5uBJLZq13qucE5lDWVWcA==
X-Google-Smtp-Source: AGHT+IG0hzVA6fwCTy7pJ9a3mstX945h4KMDaq2ak8MlWEnvH6gaqUQZykyWc+97P6hdZN/L/wWRag==
X-Received: by 2002:a17:903:2344:b0:20b:5439:f194 with SMTP id d9443c01a7336-20e984706f9mr31355125ad.16.1729597698507;
        Tue, 22 Oct 2024 04:48:18 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0e13bsm41147145ad.65.2024.10.22.04.48.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 04:48:18 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: cunhuang@tencent.com,
	leonylgao@tencent.com,
	j.granados@samsung.com,
	jsiddle@redhat.com,
	kent.overstreet@linux.dev,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH 2/2] hung_task: add docs for hung_task_detect_count
Date: Tue, 22 Oct 2024 19:47:36 +0800
Message-ID: <20241022114736.83285-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022114736.83285-1-ioworker0@gmail.com>
References: <20241022114736.83285-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces documentation for hung_task_detect_count in
kernel.rst.

Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f8bc1630eba0..b2b36d0c3094 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -401,6 +401,15 @@ The upper bound on the number of tasks that are checked.
 This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
 
+hung_task_detect_count
+======================
+
+Indicates the total number of tasks that have been detected as hung since
+the system boot.
+
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
+
+
 hung_task_timeout_secs
 ======================
 
-- 
2.45.2


