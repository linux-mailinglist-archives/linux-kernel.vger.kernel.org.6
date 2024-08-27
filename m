Return-Path: <linux-kernel+bounces-302658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68E960189
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B34C282C11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF815146A68;
	Tue, 27 Aug 2024 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+YcE3mR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5513D638
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739943; cv=none; b=A5mAW9ZV63cwcEcRj2Z5kx7uum2qZehg6F5aTlBNCkEeJYv63KdemS6vW6U42yuiZDZtzMa3uDsHJN4BeEpjdlTZMd3vTWlaxbl8yNoQDLuA1/D20oyOCpUOPL5VHY5UmL2w3LyDYProztqomdAPyp2qj+Mr2/3aRiIcSA72HqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739943; c=relaxed/simple;
	bh=Paierbr3OnV+UMAsLtNyQkn6GQuqyEdNk3kfd9t1Pbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mtdtv6zueuy72hPWqJmN2NsVHFw7zcIiqdGP1Yrz4+pV/D5JyIIolga8Xn4P3Wp4MlR+1yS9+0hvCq347QrUtSluWVGTvatSADHUc6+yPkIVRqQfXCoPaog3b/3m9sKQ9OCSTGhLJyzdDGYGJ/8uxG3NybQs6qCKSpsGBLEIMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+YcE3mR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvCt7XxbbMqr/ZTectnTYyzcNnevLnwbiS/dEZsdMoE=;
	b=K+YcE3mR1hwTLCg1kQm33PnhNgHnBUDwdv2hTCSxvlavqIsYRT8R9L4XsNGTXdoBZpEJF8
	xSgdHjWLyA4EogHh8+2Mp73uXMT5gc5GrmKMhpIoAK/wKxbwzLAP40RQcwXh1uzhkjZz4q
	wzc77r/C1VV7rmVw/OLSeYFg6MCpFCw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-dpQFdPfIM-CsX16QGMwxzA-1; Tue, 27 Aug 2024 02:25:39 -0400
X-MC-Unique: dpQFdPfIM-CsX16QGMwxzA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d737f940so984407785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739938; x=1725344738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvCt7XxbbMqr/ZTectnTYyzcNnevLnwbiS/dEZsdMoE=;
        b=NMOBXuLHvLorTKNuFE+fCQmgmT1qvYO1uj2YlMUB1PnGWQFphSqr6/jPW7iNrz69s8
         CHXrWT4iaI2YC6dTo7ZDwd2dUl9H1cr15uUJosQvqyBg4LWS5V236/YMH3qeOFo9m3a8
         7KW5JQPaDiyxSciuIK6vYK2vbpOoqsL5R22jcOIyrTqouB6zdnCVT3jvb2sxx9Y9UWJD
         Nc9B2qbPOX9EKn//8kYTRZv6fsZbBHemsn8r2hCBFPIPMn7zRYXlpbf4OEPxv+UgqASy
         F4pvAEx0l6KvqQikYFGByFjbYw8gCAKy4ywikXYd8g5i50Snq8DeHlyl8MG0ufIXfVjg
         dA5g==
X-Forwarded-Encrypted: i=1; AJvYcCUXVNpp6Q661eb5YpcKH4okR6VudQcQ08tyI85T9Kij1Yn4fD/6OSBP5snop90PRLgZbpwYPrbZ8612OSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWA1Bv3Z+R7pRuFsPX4jXhZnDBESHbYqWFJf2K8eoxbhBlP1iv
	ngnRZ6QCZkOEhSH2KKQfBWWOixHAtO1YC6qZMl8YhXM5D7aM+1N+gBYO/KsBGTXpw0iCGHmr067
	ve4PG+deoaTuD//3yRAXVg2IT/cm6VctpdLps88TJSBJQftBD6yFWHY0U2EXF3w==
X-Received: by 2002:a05:620a:19a7:b0:79c:c3d:9c22 with SMTP id af79cd13be357-7a7e4c49e7bmr410979785a.8.1724739938547;
        Mon, 26 Aug 2024 23:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOAGCcdImWIfP0W/sHe5KI872sfiULmCGaWHeUiImsKMuTcEl4A00LgBTxnHTb69xUL9c0FQ==
X-Received: by 2002:a05:620a:19a7:b0:79c:c3d:9c22 with SMTP id af79cd13be357-7a7e4c49e7bmr410977685a.8.1724739938189;
        Mon, 26 Aug 2024 23:25:38 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:37 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 2/4] Implement dummy function for SWIG to accept the full library definitions
Date: Tue, 27 Aug 2024 02:24:34 -0400
Message-ID: <20240827062438.71809-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827062438.71809-1-jwyatt@redhat.com>
References: <20240827062438.71809-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a symbol listed in the powercap.h file that was not implemented
that caused SWIG to give a symbol not found error, despite not being
used.

As suggested, implement a dummy function that returns 0 so SWIG accepts
the .o files.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

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
+ * TODO: implement function. Returns 0 for now.
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


