Return-Path: <linux-kernel+bounces-559391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FE3A5F33D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBFC3BE112
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D54269CFA;
	Thu, 13 Mar 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHSL+vfK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039E269CEC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866288; cv=none; b=fM1kYcMZ+5k6PqFwbu0PQ/gGtr1Qkssvg7J5K7TeI922A1cOd2KYeDA7KCWJjTqq+bEEGL27VXtFs66IsBddqudRn1SdwrEduUEYrXlluW91OiyAph4iWW0LjyCg40SBVxzZ8b8NEVRmHxEKZuCehdRpueI1S4ue8nqnZ2z26lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866288; c=relaxed/simple;
	bh=0zAXw8Fu4pWyrls3J/qZaqJC0Q8LMMCdN0t5bJavxBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=uRAgEE4Ra5RLt+HP+Clidvigr5W+tklVYKP60JxT4wIx4ZrdvZalyvExy+qlB2VsE41MvX7vKIBEjUN05xQCUi1sG9elZ0GBZj6WCZNCWbFtH4v/obK+b/YvtH2Su1nOHxuzUEbSaUgeUsFVRRNmp2dQjvY/OPecVXDrfuX+45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHSL+vfK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3r2g39Wllme+8/IppJMHdqpnHPlgxpExHUFAvvaA/g=;
	b=ZHSL+vfKt0sVNZXDS/k36fBMXjANGlfYle/T77jd9VMt/ub0PPZSz6yVHQphRQJcuoH0kK
	4/kw5PVUoMSHNU8NJOtgEMXXjqva5YHKZuu6SkBvxDmoodP5KybUv5Id8XDXE62R/Yvtng
	/ZPrI6Txcc4Xv89EOzihbVdp8SHKnF8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-R--sqC3uNEKXKKgyIV1qYw-1; Thu, 13 Mar 2025 07:44:42 -0400
X-MC-Unique: R--sqC3uNEKXKKgyIV1qYw-1
X-Mimecast-MFC-AGG-ID: R--sqC3uNEKXKKgyIV1qYw_1741866280
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471ddso503908f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866280; x=1742471080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3r2g39Wllme+8/IppJMHdqpnHPlgxpExHUFAvvaA/g=;
        b=YCDORSqDEISb0XboCYiB1uXmW5dD6lHRHrtv2ITUykUVGRj2uEMYB2nLBkKMK3Y4HD
         T3z/Q/2p4XmnVXbNxqwH2L0gCKoKNu+5+L5uY+1BX18weN4t4ZamsKDJVor7TX4ze+JN
         gkInG61W49bpTphyrbEGx5fOEbpU+73wy6FzJAy7D7HgqQNh7w+Ht8jo95Lm/iP5bj8Y
         RisAOnhhqntQcDNy8Hr9js9xyalXSnVsr1VCw0BZAetBCuNCqQnte1yshMIGrffjUjj8
         GO8OT1rZOz5BvCrIdAL0SKT9bIyf5yropdW6aq6an+I7hmKLgKqlB3VS0J0I/8kL4nvT
         iJow==
X-Forwarded-Encrypted: i=1; AJvYcCXF7y+Vq6LN6HMh44XQ1KOtepUgwbjZ9LG7SyL9KH/EhbQb5STsMRU7oxp8yCRmm6D/CkCHpiUq/Mfs0Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUy8jMXRjys+tNlh6VO1zwZSbSSyjDHvTwDdwEpPYw344dmpbj
	7cr0Mqj2iKTBd4qtYWDNTTHRmaE1s0FV/DMJSXLqno5ysaw3xmauGv65OaxmHEf1xBbVsdd87vL
	7lXO0EpvC5qeMdJjJ/i9wkg1rcJ0+VITk6ST4aiBJKJdLzop+h4AlbqI+aySXeQ==
X-Gm-Gg: ASbGncu55gD5sWvbGAhD7TtuaMMBNC/oJhytMz1M27jHa8bVcOwYDE5GajzLabwpGXX
	ZfsSJmxklO8wl2EDg9NMm1uXExRnuzSp4OnFDFq3GvOGFblHYLKLFNAy9iJDWz1BCJwlxe2gVnC
	l0W4t7v5TsWqvyZiZTE8yzvVIZyi9lnTTFEF+1JMPcVTSwDYJ3ezfJuOAv9S2nDjK/2cWWvjxKz
	rUwE/cHG3hj6R0xn9NQsZtPB8SuVCTT8w/gzqtxaIW7m3eL1ld77ce+Cvb2VRP/PIfiGI5WANlN
	PTSL5SmcDAxYr4HiFCW5
X-Received: by 2002:a05:6000:402a:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-39132db1bdcmr22489011f8f.47.1741866280387;
        Thu, 13 Mar 2025 04:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX54DwhuuXuiX517uvSUEgVEhgO3UBbgNo/IaPOPi6DbNC92jX9q/7SC3qQwivycyOtbvIkA==
X-Received: by 2002:a05:6000:402a:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-39132db1bdcmr22488963f8f.47.1741866280013;
        Thu, 13 Mar 2025 04:44:40 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:38 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 05/14] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Thu, 13 Mar 2025 11:43:20 +0000
Message-Id: <20250313114329.284104-6-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maíra Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b7610..e8d707b4a101 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -406,22 +406,38 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
 
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
-- 
2.34.1


