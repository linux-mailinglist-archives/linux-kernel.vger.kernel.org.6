Return-Path: <linux-kernel+bounces-444715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A165F9F0B78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18BB1888204
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64C1DEFE6;
	Fri, 13 Dec 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kYv6stWD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE651E493
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090163; cv=none; b=BP54FY97XeEBQpPqn2wa1s2aXznn/y38Gtdvla+4RcKHLCSw2vLBjHTGo1fB/Wpjr7d37kygOhMnYMkJaF7rhkSqEVCcuhJY9vC2KlfCE23A7CK7+DH0tZ41AoXIWetwYkRO5RcSyGc4SBGBg1u+DE8QNopsKmD6O8ZyH10iVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090163; c=relaxed/simple;
	bh=Pb2YgkOdQMDZcJTZ8cIhDQA2BpIh5wWYX+Jk41AvJH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClLyBcdLgQsWs+Jrm0M8DyidxbZ7G0tADQUkp6pOz+hFrcPM4ceue45ZJnNhoPh0VYcTXIRp2B+W58l6yQbo0vYIZZpPpASzL5n7wIvKL1UBylPlYN74mkttDBXmaNAbEC6nmQQNJiKF+r9ItBhihk/+LGM0M5s0V8vqoJfFFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kYv6stWD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216728b1836so14170905ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734090161; x=1734694961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTsjvIwHw8YHk0rJJ//aPZPqn72/a9IGLI3RpxKSRN4=;
        b=kYv6stWDdvSyw0+7PU6bT0n3hgSgxo5Ww4vQhAZXIK7Y9dcRqB8Gxz/1PviIVwCAsS
         jvFxffiwFEmd70j1gju37Oa/S8GgUKTUlspDGYB68mXxFfAIUAy47qKWF479mJgRt7c3
         vLhBB48WWrc0ZjyUbhKQg7TgchE11yUvlg4vC/gP6fq58uzmRGaDzZGbIdU3wW5C6Xqd
         gTP/yGxdf6XqlbFZ7dnPu7RpTuN+Ezy89fcrytOfGT4J5mjKyaX9YdMjes2DEdIN1ktt
         5vvk1uX2s0ekYbNw5HQmK2suH6U4NJgiii0wooMbvZW8ry0BBXKeSHqypOjWV6IL7UZM
         Rzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090161; x=1734694961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTsjvIwHw8YHk0rJJ//aPZPqn72/a9IGLI3RpxKSRN4=;
        b=HI3lmZpttPTk8cSmuMTplY7r3IXLHErWCxiTBUX3Mr6YyopdUnViMvMd2DY4cwKYZK
         AGq+XfkpGtw4XdYIGRR2+8N6p31mW1cxvG8fEIaMM+mV2UOAEmuBlYJ9f0B/jhEi75T5
         Q4b4B7fTrayntMXiuVHgTjvC3Pw1Psh3bre9WGfXBIhuPJfOQWJcDrGRB5O0kP1uY5vB
         nEzuN6dBPegcJfiqCsOU8x3DeMcEaLLkio36wGhCsBeTwFWeru6OQ6kWbLRc4Uu/XDKO
         Eod92ekG9ZvC3b2/EXt+DXGujdpmBel62suARJ+I1b7kauYhZUCOHHCkYo1IvcIHHlZj
         5irQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuDV793/Z84dWnOWmbTqi7yk2EXSotgqdVEiovaf9XJK9++0XaEBfHtP8Txk9+3RL7z8h2+SO4EksMc7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZjxZg2tnHAeBmj/Lcfs2OiXLCaMGq28xILnHsTpQMFvL0tRL0
	XxNpolaXvxABh04EKw0epdqoZRAzXlkzfaDudPfasAjYF/rJ4WPoWmXrCEt7f9MZlbfVjCBDecT
	EWcE=
X-Gm-Gg: ASbGncv7yWv3WZLWmrA4E4bYD89NoyEvUesabZSrZorz+MaY+JtLrgcCOZy8vCJ+qVt
	p7mwQIJ5ICD/GA9l/JTKvNqdXTT9/4/viCtHddiACjyY79WCVuTHs/zz7Udn3jW9fd7pXASnjyE
	/BM3U/g0IFf9O1zucQl5MgMpJJCSc0azMJYWK3vCERwcIptzA9ZzQ2CaFpN9MdgpJFhkAGp3re0
	18Vfc9rpKInZdpnLsyzVJ5WlYDCYxygzIDjA/GPgAJxj+zWG+AczE0Ux1+y44WwQI85s69oqsR6
	osAf1rxI+biE2NCK7X1O2tJGUAK2kaOrg2Eg++A=
X-Google-Smtp-Source: AGHT+IGbpctVM14irO1lM9PmxoUUNCWOSEpSnriOkZv8Xxax6HeGkuyn5mnc4XYJ3M/M2cPQ7OWasw==
X-Received: by 2002:a17:902:f549:b0:216:36ff:ba33 with SMTP id d9443c01a7336-218929fd4a7mr34607725ad.26.1734090161177;
        Fri, 13 Dec 2024 03:42:41 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4b961f1asm8666340a12.30.2024.12.13.03.42.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Dec 2024 03:42:40 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	guojinhui.liam@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 0/2] riscv: iommu: Add shutdown callback for kexec
Date: Fri, 13 Dec 2024 19:42:31 +0800
Message-Id: <20241213114233.12388-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After kexec, the newly booted kernel can not initialize iommu driver
successfully as no one resets iommu state before kexec.

This patch series supplies shutdown callback for iommu pmu driver. The
shutdown callback resets necessary registers so that newly booted kernel
can pass riscv_iommu_init_check() after kexec.

Xu Lu (2):
  iommu/riscv: Empty iommu queue before enabling it
  iommu/riscv: Add shutdown function for iommu driver

 drivers/iommu/riscv/iommu-pci.c      |  8 ++++++++
 drivers/iommu/riscv/iommu-platform.c |  6 ++++++
 drivers/iommu/riscv/iommu.c          | 12 ++++++++++--
 drivers/iommu/riscv/iommu.h          |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.20.1


