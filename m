Return-Path: <linux-kernel+bounces-521857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4BA3C335
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFFA16FAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6ED1F416B;
	Wed, 19 Feb 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFtf5HMB"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6E1DE4FA;
	Wed, 19 Feb 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977822; cv=none; b=OgD4LJswco+BqfLiKITkjPZm4RcxBLytIcPYhuNe06V7ZIF2wb7G1MNKSCeonTG2UYAXIBs81wpZTggdHeYrMV4Cjw4r7488GXmBy+DWxTpN3fR9bB48WbOEFn6S7vNYLUUTkcZL4aiq4qT0WUnijSlgxvCMtR2korp0VkTsV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977822; c=relaxed/simple;
	bh=Ku/iOh1I+JqIUUJzjGlO83eI66BgPyPPrV2ZatQegEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kWE/luIvPZqHjXkGjNQvkrqTjYLiQc858WkAyJt1UX69/W8FN5cHQFGp0jDYZQRRJ3jUiermjhVutKXsUrAXHtMbiNvsDVTEdbake36m+Z+FzaIrVey28uBpTz3ES8YlWr7/Un/5nRnmB/M+4Boh1qQ+lMWb4qK7nqtCYvwzNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFtf5HMB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0b0ca6742so175782985a.0;
        Wed, 19 Feb 2025 07:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977820; x=1740582620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgXm744upb0XmzQ9hD81TZHuxXyYA2m+MVyAuNGPvsQ=;
        b=XFtf5HMBHy3xvVbjodAxO+FBMwTi3TQ/1fnBcODEW/LWC/EIEMvopCsk1D+yjJ+r0Y
         hUHYaFmQblam6O40cnUVSWlxvbtK9P5wtzzS7CTC7wObOE6thco2dBFGdTdHE1Rlyc6s
         7QhKwiPlQ82ONQY3Xyt96q790WN/4gaw4q9/lTzrinOWYk8+w+iFDSWOMxYtrwNNwTFP
         W5VzbMWy9TyXvgS5j8eVKPs/Vu0gVOHyoTuPUaX+913/hWYbBnV7NvsdoRwc4pPvLwjN
         Xjkstepz3VkiBuUr9G84cWr67RBIueQmpOMxZmV/xjkbfxDsK3N7RRcBo8YFLOaPjL3n
         OOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977820; x=1740582620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgXm744upb0XmzQ9hD81TZHuxXyYA2m+MVyAuNGPvsQ=;
        b=lY/AKie6TQdeIZR7CGoh2W7a+mcpmSQo6HmLpUfj4evwsadh78pYWyllpXKvo4930D
         SJinCepvCvcgy+7vmU/CWuLJuhwxCeSJNQALWVeHTwlnVBsbRHjvHV7PBz1GGewk2Yf7
         bamgF5mfeCfcehMmjaR11kM3Tw/WujYmMFcQwdcXPDPM8k7w3Ox77gTD+RQWzcnx+T3p
         uskGdrEy7BE29XH/PHheNGXllCVkL1HwQWrp5Wf17gx+0NlkZUpnHBNF1GvRKBathWJn
         zvbAMW6TFQLZh/xOwkGgW7C1Q6zOnKeLgToEzxv+cIgpufnnYJTkaYbXwB1GLPMcg6E0
         rLKg==
X-Forwarded-Encrypted: i=1; AJvYcCVT+z3ZlDC+UnJzO7TH0ikETajRsb65W8isLbVt8PgVr4hP7TQxMhBBO7WM3989q8GBY3HvQAUz6e4=@vger.kernel.org, AJvYcCXkBiVgQZmgefBkj1tHjj5G3KvGl2H8QYg/L1kXnNoybYdE3da/aIt52P6IpT7ArXgrS/rVVo2VKiQxMMtl@vger.kernel.org
X-Gm-Message-State: AOJu0YzMb9y/E0u9ABFhXqfqwdOBKKXlbf9AsXENDSq16Zop7IUnHm9M
	dJyroEEEgLPG6WHvVsBl0gzs6Ay3RMeNDHGFPLdHxjZp5ilt90w9
X-Gm-Gg: ASbGncuRHZpNZxY02kS6144PHVjzNKnyhTke54Nq0Ho3UHGiNfON0mQJrVdLtOZiwZH
	QgKzvGvnq/XUYCnN67Y3bjXaOP+3VLaD24Mu8sVQlupSik4DLanuC1jUWIrEK8a2UvWqp+SIOqr
	4ioMEeq+p4FZitZBUxvyGphJXFY8veoZfnn06s6Rgo99Lr5klgdB6TsT6CsnQVa9fHgdup8cmAd
	2XNlMH5S0ImbP2E0L8i46GCtggSVJBhOS5MGA+j+uefefRglcAuxNtBPwr1hZVV9ZN1XtmRnySS
	IghsD+vOROz81v2O5rjRkC4j6OOMspKHpK7/6YFUDu6EPWqFvnOniRWxsw098zmVUDcxsQ1DlmL
	zG9X/JEdQ8jowKDZfcDg+ZRUzJ9Y9KRB+IzI=
X-Google-Smtp-Source: AGHT+IHEV1pVpKuhM+GFSWTF+zPnmfVbsqQvuz95PcOyRuSEElPJ2CFcOfM4zOh9HqcXIy3nsuYPqA==
X-Received: by 2002:a05:620a:454d:b0:7c0:7a0b:3727 with SMTP id af79cd13be357-7c0b521e597mr563994685a.16.1739977820342;
        Wed, 19 Feb 2025 07:10:20 -0800 (PST)
Received: from SystemsProgramming.mynetworksettings.com (pool-100-1-71-214.nwrknj.fios.verizon.net. [100.1.71.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ac61574bsm223982585a.112.2025.02.19.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:10:19 -0800 (PST)
From: Brian Ochoa <brianeochoa@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	corbet@lwn.net,
	x86@kernel.org
Cc: Brian Ochoa <brianeochoa@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: arch/x86/sva: Fix two grammar errors under Background and FAQ
Date: Wed, 19 Feb 2025 10:09:20 -0500
Message-Id: <20250219150920.445802-1-brianeochoa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Correct "in order" to "in order to"
- Append missing quantifier

Signed-off-by: Brian Ochoa <brianeochoa@gmail.com>
---
Changes since v1:
Reworded commit message

 Documentation/arch/x86/sva.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/sva.rst b/Documentation/arch/x86/sva.rst
index 33cb05005982..6a759984d471 100644
--- a/Documentation/arch/x86/sva.rst
+++ b/Documentation/arch/x86/sva.rst
@@ -25,7 +25,7 @@ to cache translations for virtual addresses. The IOMMU driver uses the
 mmu_notifier() support to keep the device TLB cache and the CPU cache in
 sync. When an ATS lookup fails for a virtual address, the device should
 use the PRI in order to request the virtual address to be paged into the
-CPU page tables. The device must use ATS again in order the fetch the
+CPU page tables. The device must use ATS again in order to fetch the
 translation before use.
 
 Shared Hardware Workqueues
@@ -216,7 +216,7 @@ submitting work and processing completions.
 
 Single Root I/O Virtualization (SR-IOV) focuses on providing independent
 hardware interfaces for virtualizing hardware. Hence, it's required to be
-almost fully functional interface to software supporting the traditional
+an almost fully functional interface to software supporting the traditional
 BARs, space for interrupts via MSI-X, its own register layout.
 Virtual Functions (VFs) are assisted by the Physical Function (PF)
 driver.
-- 
2.34.1


