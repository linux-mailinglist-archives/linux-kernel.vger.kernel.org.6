Return-Path: <linux-kernel+bounces-325118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E022975537
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B226B23838
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882E19F111;
	Wed, 11 Sep 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lk+UZNi9"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6E19E97C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064708; cv=none; b=aRTZ3wsYkNL33cLbf4HJu1HhCXqg5M4MypZS6FGb2vcNo39BzWJJ9YG22kigxUouN2NBdb3YlbzBeeNJwvEBvnoZt4j4ipmV/8VO+ok9bKKlUhRHLARs/EiMZnH8/+KktSqVMW0hKh86fB/RcjzSZhoXgBqV4Hq2KKOAyGgN10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064708; c=relaxed/simple;
	bh=rJkqHF3kgSTh8lTIZH69C0PI4ooOuBYjzOz14AO1wwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIjrCP3uONkT/3QFRu/UAEklXa/HooEBc5z7FywQTzg4UwDsmX6u/rAjr/8nLUxMxOSwP/M1UDUTpOyr7X10N2kypUOV7G7fXdv1Kwoj/Kve+Y/Kz3Q7pIoch77B2O+9ayhLmCDowEF++NyFtwLtpGT5q5aMHophTFcjyeop4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lk+UZNi9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so6102459f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1726064703; x=1726669503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZWhUioBFQ3JU3K07edzA7pFIadgF1M47jgivmCV/Sc=;
        b=Lk+UZNi9wEwhymDaSkvVK0Nrl/ZSBn4cjE5uyFrV544OvZq7t0Hig+1C9xvXCSsuK6
         6D0JKkFu1arS92B12kdzZPdKxllBTyVq/8wcW01Nw6r4DgK9wmdNfZ3w7BdL7l3wxG9j
         ZWVoyF0yGBk/ueGeuwsCMDh2VXvooCPzLEXGmX+vvIlCAIMamuw9XIYBxbgNY4pvJQwn
         cWHFINtv8n8oR4Votdf4jbPLgLa/I3YmmTEK7D46ifWsA0MxTIprJiywLXg0VwuSKkpO
         wrcCxWg5WCqArKSuUGKJ/QyBdyhIvnuMkjjIxL/e2cDL4rapZ92C/CpIIy8v7VFqBxqv
         jsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064703; x=1726669503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZWhUioBFQ3JU3K07edzA7pFIadgF1M47jgivmCV/Sc=;
        b=RJRd8+GIBIhGmhXR5QClSLEOu8J9kvEbn8gJpHIIaGlqjs7pFFlCm1BvFccQp4e/5M
         iI5f29Jk5o90BzS/o9DoR7TzL/ZPqXmYiFViNcP5WQzqtJ0SuLlFAcWhqaHjPGvGSHLc
         2bItsSnmkYXnj4hHh8SZCVOfsmCahbKF3nfgy7bzR+YhIB4t/ZMerJ/8f8uouS88wfvt
         EBZ8UilYITwC4ZndXeqqlQvAtT8nx+61hITuQBPjvoWJ5xu3dX03prx4i6w4U/8y0xQI
         5juICzpz2fQHBck+fafrZZ7NoppbAGq9u2q53tnfcvC4svy2lc3cc/WwDDuJpAvFhvED
         z3Dw==
X-Gm-Message-State: AOJu0YyuNHsXL5ggqVh58CvTI+3kGR/5tkRklC5lgCdiKmI9z+NQ1AMU
	mDHmPimyZ5oAu8c6cRqpMiNCnvB9sIsb/pUBBC4dL8KNX9gggbgKF3Qg37DTHsU=
X-Google-Smtp-Source: AGHT+IED/DWYZSVkeDvPUoWGGZh5nk4+13ski44tln3BTTKPffV0K2R6735Rj+dUclNsjidwSkEtfg==
X-Received: by 2002:adf:e949:0:b0:374:bd48:fae8 with SMTP id ffacd0b85a97d-378922b691amr12097174f8f.25.1726064702614;
        Wed, 11 Sep 2024 07:25:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f17fa00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f17:fa00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259c76e2sm617027866b.79.2024.09.11.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:25:02 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] fs/ceph/quota: ignore quota with CAP_SYS_RESOURCE
Date: Wed, 11 Sep 2024 16:24:51 +0200
Message-ID: <20240911142452.4110190-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com>
References: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP_SYS_RESOURCE allows users to "override disk quota limits".  Most
filesystems have a CAP_SYS_RESOURCE check in all quota check code
paths, but Ceph currently does not.  This patch implements the
feature.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2: moved capable check to check_quota_exceeded()
---
 fs/ceph/quota.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 06ee397e0c3a..c428dc8e8f23 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -334,6 +334,9 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	u64 max, rvalue;
 	bool exceeded = false;
 
+	if (capable(CAP_SYS_RESOURCE))
+		return false;
+
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return false;
 
-- 
2.45.2


