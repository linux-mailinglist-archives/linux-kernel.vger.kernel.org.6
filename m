Return-Path: <linux-kernel+bounces-316204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8596CC8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EA5287693
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17A14659A;
	Thu,  5 Sep 2024 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4l1Qs1H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6913D297
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502783; cv=none; b=bQPvAvljFbkCu0tuUDVr+socUXfMSMi9QTsZ8ePHGUE/k4wW3fY2tVl3zDtMFWm7IyM5g//85K/9JoxIuYvFXxi6Mue2RTPMhqkFBaXRp6P1Ps2+gqj5UMe8j9C6TBcO24fE86SVJ66+BcdfWNDgl91Ie/ZvchX0JOodCZYEVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502783; c=relaxed/simple;
	bh=0JZp6F7jXSJoimpiUanwdTLHTrfCIMCDBYBHZ2Za8jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyaOpOdl0WC5nidtF/K0xpuksglQ3JAjoPJU92n3W3mtb2NIW0/P0IMAZzqV4FC9JQJPHi7bITCcX7DhVelXZGAW4sxztRoaexFOp/Uef6b7SgKneEPGwtig2AnmCh7ruG5vKlDrlfkFANO38IaJTNX+vDBedcWf9pHIQSuHv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4l1Qs1H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beVLnoDxWzvoQew2okb3by/wDJsJF7xaNIcc2Q2qxxw=;
	b=E4l1Qs1Hfo0il8qYsJYXpPcxW4GO8HQV+jrKxReVc5FTV75s95tocJa9bk0R43f0ugValV
	8v2I/XbNCfm528twLSg3lXQK9vcDBhQKXUQ1GXxMMeJfP0vTouigOXvzIkQl+6O73QKvZG
	KEPdJea83KpoHRjYuuzWlwu/T5ZpX5U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-2cK5fkvhNzGDgazfPDvCBA-1; Wed, 04 Sep 2024 22:19:40 -0400
X-MC-Unique: 2cK5fkvhNzGDgazfPDvCBA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-457de9445f2so3399641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502779; x=1726107579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beVLnoDxWzvoQew2okb3by/wDJsJF7xaNIcc2Q2qxxw=;
        b=VLskk5g5K9MNpkj6iycYl7peVkOIms/vQ3QuvG1ylAbieR8r+DQCuWZocXOOYQWmmO
         NQTWNSoT1ef1+o6mpoZUSf9dTQb44M/3ON3y4GY6NmarrIUIaJ31h3KZe03p55VY+6Wj
         yqxyuA9/Q6dywPDXhbm1djfplsx0aHf+0xMEtSZ42qnR5Q4+OAffHGHxsnt+bBmsO3S+
         udyeUTjPrR2QTOZ9RomVjFhFEaFGHfw6aAkSccjXf0X6nvK4UCm9+7wbrvKi8HLKk8Ni
         cke0m+xyRKqsxYa1+To1k7TK9cCIVPJT3dhp6pLKgqsGAfi7cOzCpyOjo8g9ZzD/ydpU
         r9JA==
X-Forwarded-Encrypted: i=1; AJvYcCVBhK8Y7XzL3l976ctgRi+Ar2FBIYA+AZqkP0YbskQF7FelGdQXy6FfQAyA12PKnbKNphH/Lmn8Jy7sCtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZfHmDwjEDSEgnpBKFeknQi5CBB2HnK8itiQoZ84lhqZ2Q/uY
	Hz2zzcprAPspABgrmCAGfuxZMFyxLe5cceAnFjfcKjUvoN7BjANcgJmkOYqWzWaH/pxK6ut4bOP
	rsEZInnMvSxc6k5O3DMhA9m1gxTWMzMLjIdZLemtm2eDMb7JyWot7fDMCMSCATw==
X-Received: by 2002:ac8:73c9:0:b0:456:8080:df14 with SMTP id d75a77b69052e-4568080f696mr201923191cf.5.1725502779442;
        Wed, 04 Sep 2024 19:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnVAKYcljkHf9Pw9I0bXS8vwDTxO2Rebu6KULzSRIp3ra+aRj2o1z/JmNgPBf8gKe1PnRaCQ==
X-Received: by 2002:ac8:73c9:0:b0:456:8080:df14 with SMTP id d75a77b69052e-4568080f696mr201923001cf.5.1725502779095;
        Wed, 04 Sep 2024 19:19:39 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:38 -0700 (PDT)
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
Subject: [PATCH v3 4/4] MAINTAINERS: Add Maintainers for SWIG Python bindings
Date: Wed,  4 Sep 2024 22:19:11 -0400
Message-ID: <20240905021916.15938-5-jwyatt@redhat.com>
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

Adding myself as the primary maintainer and John Kacur as the backup
maintainer for the libcpupower SWIG generated Python bindings.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v3:
	- Added Rafael to Cc.

Changes in v2:
	- Added as requested.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62a00f9471c1..1b2bbc8c5adb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5821,6 +5821,9 @@ CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
 M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+M:	John B. Wyatt IV <jwyatt@redhat.com>
+M:	John B. Wyatt IV <sageofredondo@gmail.com>
+M:	John Kacur <jkacur@redhat.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	tools/power/cpupower/
-- 
2.46.0


