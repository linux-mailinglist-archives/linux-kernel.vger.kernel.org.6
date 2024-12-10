Return-Path: <linux-kernel+bounces-440341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D49EBBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44B8284549
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6BF238721;
	Tue, 10 Dec 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FJ9oKrwM"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEC23872F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866695; cv=none; b=Fjc6ITIAbM0GNk7afa4/pBcc3/9xhR95bVVa3Zc3fwqegk9tllt7M9G/B+0TvhqDmxYNGkISuRh4N2v6kUJ/Gw+cnH6RJfS7e+cCu+AK7sXQAINhujj71PcLncJlmAVKN0y+9IJmlEfFUsoFdTqzH5o8tXvhWl6OVJeuN0KJiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866695; c=relaxed/simple;
	bh=blwGRn4D8exPkZTkDVFRUh0NPIGr3Pmq8/aaGVNtNe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeNpG9bCNjjuJdx4dlHWKcJO+8jY3FIQfqNRjRzkC7RmcoLKTDJNcCsGraEy2i5jfz0I+IgOsXJH8YnVT2vyigg5I+m+mE0s2Nf5ydSG9X+ioGUMxVjfBNyAmQBAmJxTmmtBls9U90sMIyEx631IgrpLtLUxXZ9S0KaxfzJVFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FJ9oKrwM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6e9db19c8so43419085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733866693; x=1734471493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SLO2zP3WSxmf0tbBTHWC3uKgLqzLgdzgwGcqHy1nF8=;
        b=FJ9oKrwM/IKwLA2PqTrVyEl0QOWc74PuHB2XTuNmPiRK0P+3wJGMHsbe2mPg0tLt0/
         uaKv5lnIHXLFrwXOKEEHE4HLzGSTA4e8X3XBawo5A4LG1OeQk0rId1DSVcmGt6CtQwGw
         q0MnxkmsAZdYqOqTxd47DdU7G6wP06oVqNEk5pgRBMnVU11knJgxOZIuKhUAWLyVAmaP
         vHpCBXa5Y41Qv/MtlwGZhgL1LNoCmlKGvsJ4U4H6fUzgpXQLltjo2qkiayk8tXXkdlhu
         1le1Tp1ywAuBkwLOyYyhKQSXaFcK0pOnyLM96MdhCgms5HwQByB9Gi8xWLGVDIJymfPv
         ydnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866693; x=1734471493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SLO2zP3WSxmf0tbBTHWC3uKgLqzLgdzgwGcqHy1nF8=;
        b=Ey5lumjVJQukWLEETLdqz4jdbYnmfZDadEAd3t9U9gYEYm20vhLvBAoPJqHXRTokZi
         AjrUXANGgjbbjU/PmOXMfAFbqLkorv6NPYPPtAVuBiWI7seYDWcz+XuUYIoC5ke2R/cY
         6JFT+UR2w83VNkwdGY/VZMoDNaQ+gxcWUuxlTFTPma/9hegUFfgLvVtpiLwfht39GiBp
         zOqGyE5QMzb/MWmQLJp0W8FVgE91bX67vW3035zQviME1KBPSSAqJwZh4oDISfDeSBbt
         CfZ/9FBxD60sXsOQlLvceRROIbBDWwUnPSIR03K72hEGrUpyXfwxQnuVEN+6tQQdwEZZ
         okqA==
X-Gm-Message-State: AOJu0YzdoNPy34Zqpt49uCPLK2kW/i8QieBkuqzZuKVbvZN2R+aA3BDa
	GjC09D5iOtWyntIOIdNaWZvNB7x+lZNvjF/v09znwYUIsX0GF1SUqiS9I/zWam4=
X-Gm-Gg: ASbGncvFMQFoKKonMqia3GZgru5nAz25KsstAKGjDyU7N9hJHwxnd93QCo7fRNdP5qo
	vVPSMcSBpdmaV1UJl5e0KMwxbUMDAm+QXQtXkKpnBmVtWCFFAGNZnLy+Jlsfaw51qdkC0lCukw+
	z0GaMFX8mfO/I57OM4Sskaa0C4ncvEICL0HbZAmkN10qWyM19oqK4kSxK61I+eEOjVxLwKzrmXR
	HUPIjX3QPVp+sp1ltVZnrDBgD1Rf4vhSS9NjofKHWpuTOtKYl32UVai9SvBOpE6v6/GCFG6UzsO
	K5Lq1VB9Yrx8BdcOeei8VRcubVgXPKZjPt55oSo=
X-Google-Smtp-Source: AGHT+IGR91VwyQ9Xd3L5CFowo5m6Bq9C98LuxwXRSibAvLZ+jNUO5jNdqjrNPT9txkkOjxePaZAJ4Q==
X-Received: by 2002:a05:620a:4014:b0:7b6:d3b3:575e with SMTP id af79cd13be357-7b6eb4d1730mr126961285a.47.1733866693178;
        Tue, 10 Dec 2024 13:38:13 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f61f6sm65978991cf.43.2024.12.10.13.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:38:12 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	kbusch@meta.com,
	ying.huang@linux.alibaba.com
Subject: [RFC v2 PATCH 2/5] memory: move conditionally defined enums use inside ifdef tags
Date: Tue, 10 Dec 2024 16:37:41 -0500
Message-ID: <20241210213744.2968-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210213744.2968-1-gourry@gourry.net>
References: <20241210213744.2968-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NUMA_HINT_FAULTS and NUMA_HINT_FAULTS_LOCAL are only defined if
CONFIG_NUMA_BALANCING is defined, but are used outside the tags in
numa_migrate_check().  Fix this.

TNF_SHARED is only used if CONFIG_NUMA_BALANCING is enabled, so
moving this line inside the ifdef is also safe - despite use of TNF_*
elsewhere in the function.  TNF_* are not conditionally defined.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 83fd35c034d7..6ad7616918c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5573,14 +5573,14 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
 
-	count_vm_numa_event(NUMA_HINT_FAULTS);
 #ifdef CONFIG_NUMA_BALANCING
+	count_vm_numa_event(NUMA_HINT_FAULTS);
 	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
-#endif
 	if (folio_nid(folio) == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |= TNF_FAULT_LOCAL;
 	}
+#endif
 
 	return mpol_misplaced(folio, vmf, addr);
 }
-- 
2.43.0


