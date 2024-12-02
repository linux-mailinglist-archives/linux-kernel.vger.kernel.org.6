Return-Path: <linux-kernel+bounces-428189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA789E0B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF26282692
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E21DE4CC;
	Mon,  2 Dec 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn6DZHe3"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EF1DE3AE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164934; cv=none; b=o1msoLf5NgPxbISg0uhlBe0QDd+NBMHH4ApxzZJvy6PBdJHRf+0RYqqAeMt7vg6pB2agxAsX2x8sNxPtt/jxjLGhwMPONdeCk0Inw9XGeqwqcvuq9Uep1HFST3B5KhQxoFo90ksSsO1hBs2RwaQFMIIUo/o98V4Ga3/HlUYzFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164934; c=relaxed/simple;
	bh=c8ZDldLXg0Q+M0U0cvWmOKA0bxBuSKo/xc83hM0pd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohf21h1hC+EYATNSZSUyYZQlAo/ghOGeI4OWyOe35Tmjb+QbMYsCeMieV3QdBuj7CRm3KYeIvxmCZEFheS4oAsGUi7UyTJKbr+1RBEX/I5RewJzpePnMdpZ9zIE+j9v598JEEgDwC5/WaKIr9TzYSYKdRNwyjiChzPVTXauc1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn6DZHe3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so3390779a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164932; x=1733769732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPi/40j9fg7YjPYY/QjOr+/MPbDnr/kKPaDCNQF5gDU=;
        b=hn6DZHe3bXWyhjZBsB9Un6UIXx2rVpx58rlKiSRyz1kB2cD2BT1RwTSKvz3X5KjXzH
         +5JtxtXjrawMNGPpFsshLEUzIfC/pli3bCTquRfKsbwk/SBPTL8/dOHrLqGgy2ib3xI0
         e8n2nVTe8KZ2jzHiFpazhwu8JXW/+t3ZwC0+Ztg3OgpwIDJd4671vmQUOaYEdKpGxuNi
         jRuRFSDQubAP4rrtzl2p5NBkxHKBozImkMGsAyt+K/MJQ3TTGxcC5rQxf6chKBQCokE2
         BHQWXmv+U87NUft72EUgdW5aEEkGbEWccbbPTVhlRXrQoLl3ikFANCBPhGG6VT3sGOEY
         jIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164932; x=1733769732;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPi/40j9fg7YjPYY/QjOr+/MPbDnr/kKPaDCNQF5gDU=;
        b=vTlGm2a6CHqGoYYY4leaFScqguX4PGym5DPni2w9U9xGu5R/h/mkbZq8+iTHfVp8C+
         cRlC1nXz/gISR6wx1gEazuCOhy/WQS7LHcaqMJmGyqN42KPxaYKsVn7l8WM1rZuYv2Qj
         xFbMlB/alyVkN9v7UBb7wTw5P2VC4VwsgX9WRWpWodPiIQL/VelXSRzM8aqoNVpNZbru
         AsN1zF2jZ6g9KV2UBoHPbM7ckNN8+mDxHRPYnpLHlT9SuzsAwafxd0+mEZ+Jbn1Tcjvd
         4UPxLYOn0imoIB/5dC4cbGcZKokmnove4ZoQqYlDFHRLFlp2RkywXTbUU03KfR9pLfey
         uX0A==
X-Forwarded-Encrypted: i=1; AJvYcCWptr7/s/1nuWhpqho1ziXwFKOpyKcIwpqDqZNRyCfSQxHQpxxfTF2kk+wOvwzbAfjd4iXCDzPPps9RT1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPvY5NPcHXB2nOm4A8vx7CRQwthEE9r+mDJYLoTntOoQCz20L
	zqsrZLw9WLWTMNFe1n8/zSSdMawyiiSQuYgNq77w1A6QEzEcrWoE
X-Gm-Gg: ASbGncvakUCyd18eARIVqSU3pmLZaPIZevxbma/SY7cGfKdTmmmeAUJIzI11GkaHpXe
	b7TGsWtz2ulSaV/plRdK3TZU1lDjOt626LqH3ZtKE+4AhVmNsaruXvUhSl5+H2oX7IkA/STEnma
	A6bD4gJHJH1Efv+jk1pvDlEQrde1PyLg2/F79xrdkseWdWlErYXI7VW604DpCL6ylSvXLO9Qyx9
	6oBJe2/3QCaZUXj42fCxhUK0tVrNnGWL/J0YbBHjxSEl+wiI4YYN7pDLGYoa2Wohc6N9UY=
X-Google-Smtp-Source: AGHT+IE35vF16FjRydL5iBcJInocVBicSo1ZjyULb2W4jf/KJQsy63zCROjVa8zaUbfc3UsLb+zrGQ==
X-Received: by 2002:a05:6a20:7350:b0:1e0:c378:6f5b with SMTP id adf61e73a8af0-1e0e0b71f30mr31209157637.38.1733164931986;
        Mon, 02 Dec 2024 10:42:11 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7d5sm8849781b3a.94.2024.12.02.10.42.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 10:42:11 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
Date: Tue,  3 Dec 2024 02:41:51 +0800
Message-ID: <20241202184154.19321-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202184154.19321-1-ryncsn@gmail.com>
References: <20241202184154.19321-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
which is already checked by the caller here. Skip it by calling
__mem_cgroup_uncharge_swap() directly.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..d3d1eb506eee 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4615,7 +4615,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, nr_pages);
+		__mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
 }
 
-- 
2.47.0


