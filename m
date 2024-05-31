Return-Path: <linux-kernel+bounces-196296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A238D59EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728301F25F49
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77378C73;
	Fri, 31 May 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqpZ5Tpt"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4C3F9D5
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717133839; cv=none; b=Jk2u1mi6N7fzJToQabayoWQP0mgKy6b/8vypF24QRW9cDtbv0mT47bNo2/aSMtRhA+rf4g7uqYQdB4emLAVvukoxJkIFu3+iBAEpb+pUID/SO6itevzKzXnGCfq48fogT+A1IdfvVyDLaSj4lAmWEIK9jnbdnpMHuo8PpCveoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717133839; c=relaxed/simple;
	bh=PlXcugmzY4/acFKOYOhapd/mrT9JChqR3eTtQYVFMPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RDnwTioTVboqDFGhg35JTVgydA1d0URk8EjvGHXxaz5z+ecHl+MuAnc8At33zM6vbERUm9KvSEl7PYy6vm8gZghK6vYfw03IFltQpUs/3r0NlPoT2TrENDdZ5ePb6K9JkLzoxXrwPz39m/NjDaeswQGLH3W+JX7nPauyKhxhD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqpZ5Tpt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-68053bd4533so142334a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717133837; x=1717738637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJufM3OWltI8mpwlNCJTQQKHrwOunQwLsFta6I0Ngzs=;
        b=jqpZ5TptQbA1/B0e5at0641XNSeUuLQiTm6XtUaJ3c/1Yn+PmJ6cBgHrHpGWgiaM5Y
         S80ajwrrvWX06AoYE4G4WaAeAhytj+jYH2ePTThV+HhDlh2ks224SntmUf3UJQB8++7Q
         zezM+2g9wXBdMQiBnT4lfoWZv8pQDmo/EH0bP4KZzF2XcX3AeObPTGLqhbs3jMY9JQnu
         eNVQBr7PJVQwxGHypE3Uagx9q0XmzZydeUglo4laowx9nqw6atDTv1IFPK0F+6deRI3K
         m/FnzshncEJDY83+laN/OmhNvjMtnV+gLuFdo0msuaxx/nnHFTAIMsnRQW8K81HExHmQ
         bHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717133837; x=1717738637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJufM3OWltI8mpwlNCJTQQKHrwOunQwLsFta6I0Ngzs=;
        b=m4ceQtJ3k3rdReoCr4/6NcZw8Ji3dnBENpsI5bHtirJNj5piGDCr+fyXJuASb2N8qZ
         GhR4/wVe4/Ad+H093eVrsEbIqR6muqdtFH1n/1cq+TmnAdUnou2KvEAo3VOSf6KGih3f
         fr9TgLJb5BRA7Px4tXj+dUHKCchj6aNaVzESrfzrlgKFVpyeCTGkiTVCHVWkcNa+63/J
         FiVzFV/i/n5bjSXjhEcDbbdfvpzEr4jXcCYYtomP+oQl8rwRRCVodfpmP+BLwqNMiFA+
         1gVYIOr3aeWo3Fg9mTMj1dHWiGaJdgCrGayuExJYniP9KFpjLlI4mx4Q+lB/YaEtYORj
         yf3A==
X-Forwarded-Encrypted: i=1; AJvYcCW5HAGcRGfSDkjToiWjxpNgank1wBsprsJPyaW0iVn4zQatilctjCszBJzqh65keAPfmrxm5+O6Zuk0hJ+N+VPI0faCKHr5NNc6ODaI
X-Gm-Message-State: AOJu0YzHpMJPhMNkuN71sFyODiilCfz/qU8LhVIM4VWPYgjf7YhfFa86
	ietFKAoFyMc09Odq08kELXs/2p80efOLOvE407+aspR1IALm/nVO
X-Google-Smtp-Source: AGHT+IFBMaomj0TXwp+xtjmffEkMI5PzoWIzCbbgBBedH2imbGs3hJMYxPuDO+WC421BLo7Spt3uHQ==
X-Received: by 2002:a05:6a21:197:b0:1af:a5e8:d184 with SMTP id adf61e73a8af0-1b26f3668d1mr1097543637.5.1717133837237;
        Thu, 30 May 2024 22:37:17 -0700 (PDT)
Received: from localhost (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dcb6sm7417795ad.61.2024.05.30.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 22:37:16 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com,
	alexander.deucher@amd.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/resource: optimize find_next_iomem_res
Date: Thu, 30 May 2024 22:36:57 -0700
Message-ID: <20240531053704.2009827-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can skip children resources when the parent resource does not cover
the range.

This should help vmf_insert_* users on x86, such as several DRM drivers.
On my AMD Ryzen 5 7520C, when streaming data from cpu memory into amdgpu
bo, the throughput goes from 5.1GB/s to 6.6GB/s.  perf report says

  34.69%--__do_fault
  34.60%--amdgpu_gem_fault
  34.00%--ttm_bo_vm_fault_reserved
  32.95%--vmf_insert_pfn_prot
  25.89%--track_pfn_insert
  24.35%--lookup_memtype
  21.77%--pat_pagerange_is_ram
  20.80%--walk_system_ram_range
  17.42%--find_next_iomem_res

before this change, and

  26.67%--__do_fault
  26.57%--amdgpu_gem_fault
  25.83%--ttm_bo_vm_fault_reserved
  24.40%--vmf_insert_pfn_prot
  14.30%--track_pfn_insert
  12.20%--lookup_memtype
  9.34%--pat_pagerange_is_ram
  8.22%--walk_system_ram_range
  5.09%--find_next_iomem_res

after.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 kernel/resource.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index fcbca39dbc450..19b84b4f9a577 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -326,6 +326,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
 			       struct resource *res)
 {
+	bool skip_children = false;
 	struct resource *p;
 
 	if (!res)
@@ -336,7 +337,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for_each_resource(&iomem_resource, p, false) {
+	for_each_resource(&iomem_resource, p, skip_children) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -344,8 +345,11 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		}
 
 		/* Skip until we find a range that matches what we look for */
-		if (p->end < start)
+		if (p->end < start) {
+			skip_children = true;
 			continue;
+		}
+		skip_children = false;
 
 		if ((p->flags & flags) != flags)
 			continue;
-- 
2.45.1.288.g0e0cd299f1-goog


