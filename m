Return-Path: <linux-kernel+bounces-316202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908796CC89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AC0B23D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85E13A250;
	Thu,  5 Sep 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6n5+1rV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E112BF02
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502780; cv=none; b=UmGAWYKMI9c1l7pIw0B2eFVXf8thhMZHGzrbzX4GFjStvvUhtZYABeuuyEDKw2uRIOXDDF4cBVMh4LnFG4aT75XyuX9Crww0BKEoAsCN0v1MKuozPlRhRwXwVOzdarBHJZNrD77tcmIDtDaAuuYYOuTle1Mmrly7V6gK/ujsv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502780; c=relaxed/simple;
	bh=6rt/Ua2bCTlaRDGfKmgzk1tmRKl373FsbSHmxOuv2Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ8mOATIQ52J3wwkqrJL2/kn2TKmz8cXv1FnWCn7RL034H9Yio93Mv2xmi49L7LAN6nyA+P1lNjJ3UTEuSZi2XSh+CLJ8ARclHltxfuyrgqUs0W/lNTK1gt4DP4ySO9KOoN3ArwRJF4hNX3y4qWfRuXnvZnWzQMjWzw2QxdvA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6n5+1rV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EKP/9IUn+VeZzi5LY6w0YXTYw3bCOdthXlaT1zlipg=;
	b=R6n5+1rVRB9tDsRCr+ZzYDgqpP5eARP9Y+jj3mlte9a5GT3EHftn9cGtATXnzYsfikHKmY
	Rxjri0vRgyKh0wgVJy9fBTh3W8BwxeM/p01FPKc42wWQFiq62bQzC8lRCl3IX15hsTDxh3
	EbDJ/x7K3QgqezFr0pww1TULC8lGpM4=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-KxowvEXiMIm6Lb0x6noVwQ-1; Wed, 04 Sep 2024 22:19:36 -0400
X-MC-Unique: KxowvEXiMIm6Lb0x6noVwQ-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4fcf8ce00f5so106343e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502776; x=1726107576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EKP/9IUn+VeZzi5LY6w0YXTYw3bCOdthXlaT1zlipg=;
        b=E84/7OfQh/bDwS5O2y4slEFF0O2Cf2CDG/bbyvJFSCSwGa3Eu1hP6P0UIZIJ0Hv2FY
         prGHv+k5A66WQhIIM5Hl+0GjXlZk8Ju4ZAJfAYuzMaNq6yjrh8OpJqdnY/F2tA2+TJeB
         1a74RRarkWeS2vR2M6kCokA2szUaLpuRcJNskFE8Rzj/4zzMl7Ow36q7+5Xdcv5bsGtH
         kRLuoCE3LUKpLTLtRS/ldREj2yR614lK0a9Q42haI/eLKsfLjnnxClxveC8UUJAPGqBC
         qQRxkbNYV9yglwSP4R75UAO6+2cGUSREb1c9GKgVLhl6RUZhorwUs3Y7GjXDrOtu0tGJ
         bWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqHXGjhYxG8chb0o3Z159Bh/tFjshMtTB8dh7TYsIXzW1W5AJ71zMl6sHt44qjtjV/QLYVKPGd9ljIvWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZ8kVAKqoA4+3pXLlsgVi5m4mVvBDRPfS1nfY5QTOoHzAVq3H
	Gv39jFNdA/EhkVgOpo4loMWHE3L2pJ1Jck8T7Y91lkbEi8vEbgI01oseQc3s/NtgFIfO9O0BVDQ
	ERFGeaa5EU3FUzh1HadsavxnYzWjZmTyw0FG1ScN/KIdeQCnCLjDKw7My5KvaFw==
X-Received: by 2002:a05:6122:7c9:b0:4f2:f1f1:a9f2 with SMTP id 71dfb90a1353d-4ffe4a7d39dmr25535595e0c.4.1725502776288;
        Wed, 04 Sep 2024 19:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZbGFUJCYKiucGl1DslAq9mOBBURUKRyE/cFlJqj1Sd8Nknw5XQxplsW9m1H5Rk+rJ0f31hw==
X-Received: by 2002:a05:6122:7c9:b0:4f2:f1f1:a9f2 with SMTP id 71dfb90a1353d-4ffe4a7d39dmr25535578e0c.4.1725502775894;
        Wed, 04 Sep 2024 19:19:35 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:35 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 1/4] pm:cpupower: Add missing powercap_set_enabled() stub function
Date: Wed,  4 Sep 2024 22:19:08 -0400
Message-ID: <20240905021916.15938-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905021916.15938-1-jwyatt@redhat.com>
References: <20240905021916.15938-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a symbol listed in the powercap.h file that was not implemented.
Implement it with a stub return of 0.

Programs like SWIG require that functions that are defined in the
headers be implemented.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v3:
	- Renamed commit header, moved commit to be the first in the
	  patchset as requested by Shuah Khan. Adjusted commit message
	  body to match.
	- Added pm:cpupower prefix to header and Rafael to Cc

Changes in v2:
	- Implemented the function so SWIG will accept the header
	  definition
---
 tools/power/cpupower/lib/powercap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index a7a59c6bacda..94a0c69e55ef 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -77,6 +77,14 @@ int powercap_get_enabled(int *mode)
 	return sysfs_get_enabled(path, mode);
 }
 
+/*
+ * TODO: implement function. Returns dummy 0 for now.
+ */
+int powercap_set_enabled(int mode)
+{
+	return 0;
+}
+
 /*
  * Hardcoded, because rapl is the only powercap implementation
 - * this needs to get more generic if more powercap implementations
-- 
2.46.0


