Return-Path: <linux-kernel+bounces-559389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81987A5F32B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273413BEE27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6CB2698AE;
	Thu, 13 Mar 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDT8Ld3i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DC267F57
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866283; cv=none; b=LAnc+tIAVQZenaN0QVhit0oYeplI2q37Oc2fuJEVPYpCnZ3NG1QaDvi0qUfa7YI58/QYYcMoOrFzDYeSlWHoa0zoyz6nNbDM9p6rwuKqpJn7hLpP++02sbaWPKu4PohLmmwBrG0W37md+7om7/LzU2gSJzoTy4MXUsFUF4EEaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866283; c=relaxed/simple;
	bh=k/QW8yyThWQYD06PZzn8avBbFa43Ro0Rb4YCVVYWNuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=n7umEiwgBPaw0OaXymapvniREZwx3dsh+Inu7Ewo6PlQ7VRIHQfeoL41xMA5DVdqkz07CbrmcBfR4rYXdWVcUNrc+T6COMw8lePrp8M6XRWvjw28MFfSCNVL6KRPC2c5GznKaboQzVxmXGWcjKxWjDA2uw6kXD6l4QwjFx9CCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDT8Ld3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piebsVU5QZFL/FeYXj8vMs1AI4HP2ZYK+Wi3o0pUrOA=;
	b=dDT8Ld3iMDbNLuPtKnwtwxnk1TH7HtnkGAXjEqLyEFPK4LmprwWoFs2HMl3iFWS/OzYfZy
	1KoI4jEU/cc6j4SlnWN7bldVylm68N2CsIW9kLnt+jVvPKmxLdv1Opp/oBmmeU9nRj5h2/
	yv4gscgc9EPIoUYRBU0w/db5+FyLpMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-r_OyJtXuNNK5UhmBZC-tWw-1; Thu, 13 Mar 2025 07:44:39 -0400
X-MC-Unique: r_OyJtXuNNK5UhmBZC-tWw-1
X-Mimecast-MFC-AGG-ID: r_OyJtXuNNK5UhmBZC-tWw_1741866278
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39135d31ca4so448464f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866278; x=1742471078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piebsVU5QZFL/FeYXj8vMs1AI4HP2ZYK+Wi3o0pUrOA=;
        b=O/qQ4SUnanZpz4fAcPzXb2Mj0F6pbBhuMSwJzToxWjrIXUl/SUpogU+Ulnh/Wgn+4n
         F/ASPISAUD2gOs/ysn1yJnHQffY4+VNrNUXTcXl9rvKO+Yhl3kQ98Tgid4qwYN7Uh7cD
         Y5lUKl8CXXEPPrhkGpKOMGz0cqkztW4oXSuEFA31QPYG3PZfbhzkrOg+KUXxyJZ0GHeo
         n7Ia/TCp7zHmu3CeCkbneJ+WUcjzkdi6noQqeRLZ7FACFhw+ERSnnF2AbAKVkGcy2K32
         orMJ0OtU7WzkEFgyCxvmxI257RgtaDcw6jJmAY9Ydjw37VUAbMYILLYXGLM2E+gysV0r
         2prg==
X-Forwarded-Encrypted: i=1; AJvYcCU2hCTQkqoUgA+pg2YQNjgFciTwA9EovTPfaT45lxLzJjNPUmeVyjbHuAGKmy+iuCthg99iwk01pHAOmz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55ZW5THfWMzq1WD5WwB3QhiOe38O9+705TLr+hkuCxYg5DfmH
	1DDtbdLNNn7pRT2KzosQTdxfG2TG72wQkhgZWhtNYKBP/nna/no03WMQGG8/R5vZR6FVE6VVZyP
	zclWkzt4U9I8afhHIfPhQK9EjQLnG2z8W+5rrodPBnAOUlxoIL1i9Fk/oPvwX8A==
X-Gm-Gg: ASbGnctlCCf6e495a4jIij56ru3H3xmXY24zXQITN37CWTWVwVvKhnQOn2J4EJDxHVC
	l3HV9i0NcKcPf7ivjVjRkclndgPP2hegcsywfTQAmKtf1b4n/22XzrfWMYQBo+zCfd0vbTdMIb/
	ZYTZ0Fn1tbbEtsTniFHs9EYGFvZuy8JOk1pZGnQjyW6do2LaJmdJ9F1an+1eC5uwTgX9HEnn2BA
	c5/EMtWb3aKc+DfIUls6yOwBsJAGeqFIJo24ND4D2hAkAYA9PKZN5SKNdXd9/lFAFc+56Eh7pg7
	3U6ImEP17Vg9vN6efX21
X-Received: by 2002:a05:6000:1fa9:b0:390:f025:9e85 with SMTP id ffacd0b85a97d-395b954eeeamr1447638f8f.21.1741866277756;
        Thu, 13 Mar 2025 04:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPsIsJrLJpu/wcDWacnMw+4SNJEtb8GetI5Mzi5kv4VuMQGkXurfVfuA8bqNlB7JY189Yj3A==
X-Received: by 2002:a05:6000:1fa9:b0:390:f025:9e85 with SMTP id ffacd0b85a97d-395b954eeeamr1447604f8f.21.1741866277398;
        Thu, 13 Mar 2025 04:44:37 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:36 -0700 (PDT)
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
Subject: [PATCH v4 04/14] kunit: Add documentation for warning backtrace suppression API
Date: Thu, 13 Mar 2025 11:43:19 +0000
Message-Id: <20250313114329.284104-5-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Document API functions for suppressing warning backtraces.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 Documentation/dev-tools/kunit/usage.rst | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22955d56b379..b2f1e56d53b4 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -157,6 +157,34 @@ Alternatively, one can take full control over the error message by using
 	if (some_setup_function())
 		KUNIT_FAIL(test, "Failed to setup thing for testing");
 
+Suppressing warning backtraces
+------------------------------
+
+Some unit tests trigger warning backtraces either intentionally or as side
+effect. Such backtraces are normally undesirable since they distract from
+the actual test and may result in the impression that there is a problem.
+
+Such backtraces can be suppressed. To suppress a backtrace in some_function(),
+use the following code.
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		DEFINE_SUPPRESSED_WARNING(some_function);
+
+		KUNIT_START_SUPPRESSED_WARNING(some_function);
+		trigger_backtrace();
+		KUNIT_END_SUPPRESSED_WARNING(some_function);
+	}
+
+SUPPRESSED_WARNING_COUNT() returns the number of suppressed backtraces. If the
+suppressed backtrace was triggered on purpose, this can be used to check if
+the backtrace was actually triggered.
+
+.. code-block:: c
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(some_function), 1);
 
 Test Suites
 ~~~~~~~~~~~
@@ -857,4 +885,4 @@ For example:
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
 
 		// Everything is cleaned up automatically when the test ends.
-	}
\ No newline at end of file
+	}
-- 
2.34.1


