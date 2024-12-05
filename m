Return-Path: <linux-kernel+bounces-432823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6F9E50B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFAB1882E84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1861D63DF;
	Thu,  5 Dec 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxtx0nw4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824481D5CFE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389523; cv=none; b=AK3mEqamiwEeaXZlh+rxI1LORY3MyfUlLKD2LOjw89VBwoe5VFM1RwB1KGAXbt68dAgli+ySAEUkdEnQy+WC74lP6zDVrQB5Ep47W4IWmNRqh9KmSWsTLrK9+pCzi1CbxzI/c2YTp0maTyrMHn+Z/ji7HgzpTTaT5mX9X0r1RGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389523; c=relaxed/simple;
	bh=IujUqxIIz9or27UE5qj0dIk5ibqYWO46P31Yzdy8bcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si0l38WVuJCnYNTTiahS/fdGFLEPPz9YN3jHL2mdqOPbhYETJ9xCgHKTEfrnZ/yRRNoZJ9WwFDuTM+xXAlb4AvvPtgunaIJHseyM782kEU1Ai8nIoLvoWERqKuQ53vitDSfQKZDeVeBZoLZM841+aqeIzpcSP/JbNHzL4YYHp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxtx0nw4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733389518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/0LS59BHWZxT7JElUljbxSyn36zBZn8FjqEt24DcDM=;
	b=Kxtx0nw40MwZ6/ais+woHabpmiwd+cevcP7g7ys3VoTj/Vfu8PfQ0sRX6pKUEJLc4zxZhF
	nI5vfPp1BExRjJhNQC+DWbhgQ3Za70w26kpYXVqvMz4luTmE/j8vuRtdVMn46BMNlzUuy9
	Ys74D98QIZUKwVtbk/TQhpZSFJgduQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Y7OqToRAPr6Nb_9hEOSxCA-1; Thu, 05 Dec 2024 04:05:17 -0500
X-MC-Unique: Y7OqToRAPr6Nb_9hEOSxCA-1
X-Mimecast-MFC-AGG-ID: Y7OqToRAPr6Nb_9hEOSxCA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a4ad4798so4044785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389516; x=1733994316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/0LS59BHWZxT7JElUljbxSyn36zBZn8FjqEt24DcDM=;
        b=Lf2HajWKd3Ict9Dhns2TQaYbJRn0dOPKiFE9X5AjfzsQeqcwgIVOaLzAspnnQ8LJcs
         ZH/QcpgWaDzicr2OQIbh3i4TnUI+X7jJpvRIhUYZzOgb+Js3DYusVdruikMsEhRD9dT6
         i1ikLNgP2UizTnkt4sGZOLYi7TzDvI6VnhiA2/mk5FBuG18nDML+StDRWrdEeOCuJUsh
         +tWeChT+JTDg9ZAuM9jLB7IP7vznbA8wQ1YhyDWv6vSvPE/T0SojEMgW/JkNfKRMCtpX
         jeS94WwXcYGQulYR/udT/5dhFQeZH5uR94jUuEi6wf4n3Z2p9fI94rjndPPOivazej1e
         iKaQ==
X-Gm-Message-State: AOJu0Yxee24BUAMKw+KfDQ6ytVxUkWB91Ut+r5Uvz513FAInpYVR8FwA
	aeXbg6dYyG/q4q9ldnN2ghXcpSk3HHYn2byCDM4QNymMfoaVVjY4w/VMkx8xZRDX09/2CapMtdw
	zpW+hXbzg3zrsp4VtJvQnkH4obN8ps6DZMNvIUWNwxhToUkrMSgCWmw14bRflk1Hj4blPntiVZr
	BYRvC+Q3yHECljZmh+a5pqz+fyze/E/IzeJMwMiKqr/Q==
X-Gm-Gg: ASbGncs6v19Wid/v+rbwIGMueAHYWs63gQ2VXrPSXqG6T7G7tOsM9cqoCyQEHe66LB/
	BdICuir7+VR2hSdawuKKdtajHP4z7DPODTWgu/K3PEE39jRrx5Iy35KImAO0IUumM1oPilPCjaj
	lBJAzEbpZ+CdqzE1q5o8/Fy3ea9/q7ad9/DuWyaHFnxu9jY8L2SX9skWwju9kPeDOaU4vOz1xlD
	g60VMt2xiM1mCUfzs14sRd1jynx1iysZxirHTuFm85v8499R7nLG2s+9TjZ3Q1LGJvt8fdO6iW5
	AUXP8GO+q4pa4aAupanaEN1S712dCPSuMmM=
X-Received: by 2002:a05:600c:35cf:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-434d0a05539mr70033215e9.26.1733389516189;
        Thu, 05 Dec 2024 01:05:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQqVLYjIJ1d4o17MERRj4yqcyMU0hiG8tJDOLp6qs8yInZknFYNU+tG/5AZ6N4sYAJeUosgw==
X-Received: by 2002:a05:600c:35cf:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-434d0a05539mr70032885e9.26.1733389515758;
        Thu, 05 Dec 2024 01:05:15 -0800 (PST)
Received: from localhost (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d526ac03sm55521585e9.4.2024.12.05.01.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:05:15 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RESEND v1 2/2] mm/memory_hotplug: don't use __GFP_HARDWALL when migrating pages via memory offlining
Date: Thu,  5 Dec 2024 10:05:08 +0100
Message-ID: <20241205090508.2095225-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205090508.2095225-1-david@redhat.com>
References: <20241205090508.2095225-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll migrate pages allocated by other context; respecting the cpuset of
the memory offlining context when allocating a migration target does not
make sense.

Drop the __GFP_HARDWALL by using GFP_KERNEL.

Note that in an ideal world, migration code could figure out the cpuset
of the original context and take that into consideration.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5f497ccf473d..3b6f93962481 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1838,7 +1838,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		nodemask_t nmask = node_states[N_MEMORY];
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
-			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+			.gfp_mask = GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 			.reason = MR_MEMORY_HOTPLUG,
 		};
 		int ret;
-- 
2.47.1


