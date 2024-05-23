Return-Path: <linux-kernel+bounces-187135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97F8CCDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5DF28175B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDBE12AAF0;
	Thu, 23 May 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsbNDiAq"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142907CF39
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451304; cv=none; b=i8svwJGHrpv3oIXuxjK0Iz/tnd0OXrJl05EyvNFbrL1e1LP/wedoRtLi1UzPRyW7G4igkjhwCUBE//qk1Ao8AcpAHyJRqe2xDsum7/z+i9QQl7gNP2ldIbc6FfaVNjENKlw9aFtb7feLfy2Gj7ricfDID8b+y4z+oqm7eP4n0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451304; c=relaxed/simple;
	bh=OngIlb47S3YobCM0VNUm0ihKj9vQJT696KAhiM1x5/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDsD+hl6gxEf1ScmgkPCNiHSKBrU8wZ16BdLY3Fl+lt/x9mEALOAP1/ds26VumY+WDYemxHaeKslaKZVM4aNAatwS808CumR/ritBMmj1H+VHCAoEn0mgZJab17dpeSykSjZCam0F2gP9StMrBTf93kRjMJwhEap9LT/yjMp/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsbNDiAq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e719bab882so57053321fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716451301; x=1717056101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZluRRQ9XyXo20qI6tf/Kv1PIsqdwtqNbch7EYxePXUk=;
        b=bsbNDiAq+QgNMisKI+r1tsB7vYS3rt7oMt0zwUPs88GxPIUpUBZ9xhIqALN9Zf+Da/
         +Lp1HjEep3AxOkPmRAOoXwPNxWCln7wJO26dACtw3Bx4U3t1fH+8LuxQSOT3vdoaur0C
         DOyNrPS4i5PsEcL9KqNcpYU6X2RIU17GE3vsDm5DrUt73DbM1UnFF4Pt9BRA6HJp8Ns5
         IgJvFwVafDaSGRrmYkmvA/VrhEthiJTzC+8yjTEUf7Y00SoR9mpWCQqfR3PBOydlVwa+
         IafSSCiBb1eHa0n5jxe+CdhuSO94m2ZQmaC5WCdqLuEd+QVwYII5X7lNip5Zr7sRloFC
         7WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451301; x=1717056101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZluRRQ9XyXo20qI6tf/Kv1PIsqdwtqNbch7EYxePXUk=;
        b=bs2Nal9nP5HGYhpkB8DdMYnehRYWVDOqMxijw4hJv3N6BwdFLItbNwGbBUnGthOkFa
         vvtgHk6eiGk1LmtHdG19W+1qQr4knK2pFGlQUU5f+CyMEZk+EKepXdibJgy3Li5PtHMv
         LjEwwkIDDjQ1ucQ24QnpCE6IqVuaajBrdsXNf1SNnkE0IwfZSwvkEP23MspzCvEzWBnZ
         fYlm0j5w3WA5rG7nOlyPMWHgz6Ih1EEg4QtLFxJnOXo10QrxtIiOcMF/faFzqFrtAi9r
         hxCF61+k9PaTj+gz76uMq2oBR75YYgsX04qRvNpLV3hN0UHA7VcidxV/dU03TZI0B4+/
         io0A==
X-Forwarded-Encrypted: i=1; AJvYcCXA2YPYAZAGKhilfmZnxPHh9Ur3SNN5kN6OcQhkgM+BHjQZJYcg3dJaFry4xIeGKSNm3vvi9430EelPxy7iEBuD54655Y/9GjUQgPbr
X-Gm-Message-State: AOJu0Yw/y2uSmRbQVuQzjvy+EY4RC/OKMJ3PMV0Gc9+0itXOtlDlf7JI
	3WxgaB+hsXdrYXNuBTZt7jEp9UP4sZUQQIpJTyouR5tZtOICH//h
X-Google-Smtp-Source: AGHT+IEP8QHHLCRarDBboaWu7hRaU4vf5dunldJNtpdKLpOgkI7yExL6vlD475Ef66rcj4+zUc8fIg==
X-Received: by 2002:a2e:850a:0:b0:2d6:c43e:f0b3 with SMTP id 38308e7fff4ca-2e9496ba782mr25884081fa.50.1716451301010;
        Thu, 23 May 2024 01:01:41 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1548bsm17489045e9.11.2024.05.23.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:01:40 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH 1/2] percpu: Add __this_cpu_try_cmpxchg()
Date: Thu, 23 May 2024 10:00:31 +0200
Message-ID: <20240523080136.9863-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __this_cpu_try_cmpxchg() version of the percpu op.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/percpu-defs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index ec3573119923..8efce7414fad 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -475,6 +475,12 @@ do {									\
 	raw_cpu_cmpxchg(pcp, oval, nval);				\
 })
 
+#define __this_cpu_try_cmpxchg(pcp, ovalp, nval)			\
+({									\
+	__this_cpu_preempt_check("try_cmpxchg");			\
+	raw_cpu_try_cmpxchg(pcp, ovalp, nval);				\
+})
+
 #define __this_cpu_sub(pcp, val)	__this_cpu_add(pcp, -(typeof(pcp))(val))
 #define __this_cpu_inc(pcp)		__this_cpu_add(pcp, 1)
 #define __this_cpu_dec(pcp)		__this_cpu_sub(pcp, 1)
-- 
2.45.1


