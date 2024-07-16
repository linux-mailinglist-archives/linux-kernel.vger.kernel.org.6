Return-Path: <linux-kernel+bounces-254462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C1933386
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EC3283474
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2ED8121B;
	Tue, 16 Jul 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWxQ+ofT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7755894
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165145; cv=none; b=TfaQd4doCzLjc2A9mFXquaMNOe8S+knKIpW8VPZM3wUa8I+Id9mPwRIlsc8IvjSx0pz5+CIvoxriafFwNKlsNwiErP7khhW+yYH0Nn2R5vPSuR6gAaowjfFKO+7YCSPXvGiGa1QDEs3dSs6iW1mtOP1ySK3koHziterFuUbUzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165145; c=relaxed/simple;
	bh=dxKUl0LE8GC6ln6r73zcd+n7L3K8PYBZj3/wJG+sflU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uIYqxZjxsjs/tstui13MQ2BxvU+Vs+Y0YGugIMTx1jvBnUnSdy1YWbCC/n1KBlMdF32MDvxDFcwUjmhxx+rUEALwUHCHWG/WkmpH3wA7qJKaG5Oz6xLmwMEOUPMeGr8ILccC7StMrunZ7ySTonVeSxTuY6e9hMNxQziXmlUV4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWxQ+ofT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e036150efc6so10462825276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721165142; x=1721769942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hW7r7fMrBo0Bh6v0NShpaVL56BDK32NHibV5Yy51e2A=;
        b=QWxQ+ofTbL0E8cMNEgF3QVzxVQfxcVywyTQx08OVRlMkIvmPHhO/6x0/mnj+7XvbCO
         AU2030MDZa5oe4nQcD180pY5VrISwEVLcaInZ9aqMZuUacLGOyGW5vNuvqkPBzM7wVa/
         +lGYNe29ttw3Z3wTaK7pcSW8JyaJY66Svc0MpIdb7j5+y0cymAuQpSO099GT0ufZ6gc5
         26gKzZFBYbBuKx6RVUuv+Aho8QWopTn3ltn8MTVuLwhyS3OfpF/qWfIXomGx7iCSsFH9
         /durh4pIV0+tAB00rOTreYH9whcWtKckq2sGNJubWhwjnI8YwKa5AbYVYSxH9Q62nolp
         L4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721165142; x=1721769942;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hW7r7fMrBo0Bh6v0NShpaVL56BDK32NHibV5Yy51e2A=;
        b=qcyOMRVJ5sRQx7gXL0Rw5aUKwup/cNZwK8fYrQQtspSyBuUuujmNLrQEZXQ5ehXW5t
         lpOC8t9oVV7yrA/VQ+g4Y66rg1ejOL2rzrFxxCUKbAKa6TAB+qDm+TsQqkHArq6QHgNt
         o/1vmVA05MDAQO2rvPxZbVhhoy69+eY7PcJ2M09Y0YpLpytN8K6h3nVG2TpN9pirtyjo
         qmiyiK6HayfEnz2TuWiTDbVmVpWw8qXBjcBLfJdzlDZEN4Na9wmRMcUbOYcHNUwMMb9w
         Nw+USmnqWdYZ/+BHmjSUwYP1dpRSPvS/bY8xfqK68akVedeZ+ItqJrKPXHqgApBGduDY
         iczg==
X-Forwarded-Encrypted: i=1; AJvYcCUGmv8JLbISsK6ur051zFzO03BqYOGgf756Btter/KB0i+2EgLIaL2cuU+8YkNFcoklT8ZVK6Lz+ra8x94mjVnVTnKgDqFtM+9teLxE
X-Gm-Message-State: AOJu0YyLM8ctWQaNmeSptWmoj0tYnvvvcS4HpXj3VrpQ3cksszrDgQKn
	q59ZuCq3TGXZrkN1KH1GBswVcJBl6XXWkDAQLp6XWWNHW9tCklZdimm8MpqcDAs0hVleuIOzKQ=
	=
X-Google-Smtp-Source: AGHT+IE3+EORzqa1AKq4gwHc5gW8KHxrlRPiRlpcdmONZNfxCwqZxpIpSt2aw+tA+p/cpIRu4uKaXbIc/w==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:2492:b0:dfb:fb2:ebd with SMTP id
 3f1490d57ef6-e05d57b536cmr5647276.8.1721165142154; Tue, 16 Jul 2024 14:25:42
 -0700 (PDT)
Date: Tue, 16 Jul 2024 21:25:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716212530.603924-1-rmoar@google.com>
Subject: [PATCH] kunit: add test duration attribute
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new test duration attribute to print the duration of a test run.

Example:
 KTAP version 1
    # Subtest: memcpy
    # module: memcpy_kunit
    1..4
    # memcpy_large_test.speed: slow
    # memcpy_large_test.duration: 1.134787584s
    ok 1 memcpy_large_test
    ...

This attribute is printed for each test (excluding parameterized tests).

Add documentation for this new attribute to KUnit docs.

In order to save the timespec64 object, add the ability to save a memory
allocated object to the attributes framework.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 .../dev-tools/kunit/running_tips.rst          |  7 +++
 include/kunit/attributes.h                    |  5 ++
 include/kunit/test.h                          |  1 +
 lib/kunit/attributes.c                        | 61 ++++++++++++++++++-
 lib/kunit/test.c                              | 25 ++++++--
 5 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index bd689db6fdd2..a528d92e5d8f 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -446,3 +446,10 @@ This attribute indicates whether the test uses init data or functions.
 
 This attribute is automatically saved as a boolean and tests can also be
 filtered using this attribute.
+
+``duration``
+
+This attribute indicates the length of time in seconds of the test execution.
+
+This attribute is automatically saved as a timespec64 and printed for each test
+(excluding parameterized tests).
diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
index bc76a0b786d2..89ca54ef380d 100644
--- a/include/kunit/attributes.h
+++ b/include/kunit/attributes.h
@@ -18,6 +18,11 @@ struct kunit_attr_filter {
 	char *input;
 };
 
+/*
+ * Frees all of a test's allocated attributes.
+ */
+void kunit_free_attr(void *test_or_suite, bool is_test);
+
 /*
  * Returns the name of the filter's attribute.
  */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index ec61cad6b71d..dca78d9bd3f6 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -82,6 +82,7 @@ enum kunit_speed {
 /* Holds attributes for each test case and suite */
 struct kunit_attributes {
 	enum kunit_speed speed;
+	struct timespec64 *duration;
 };
 
 /**
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 2cf04cc09372..b9fd6c686d65 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -40,6 +40,7 @@ struct kunit_attr {
 	int (*filter)(void *attr, const char *input, int *err);
 	void *attr_default;
 	enum print_ops print;
+	bool to_free;
 };
 
 /* String Lists for enum Attributes */
@@ -79,8 +80,29 @@ static const char *attr_string_to_string(void *attr, bool *to_free)
 	return (char *) attr;
 }
 
+static const char *attr_duration_to_string(void *attr, bool *to_free)
+{
+	int string_max_len = 20;
+	char *str = kmalloc(string_max_len, GFP_KERNEL);
+	struct timespec64 *val = (struct timespec64 *)attr;
+
+	*to_free = true;
+
+	/* Check if duration will overflow string */
+	if (val->tv_sec >= 1000000)
+		str = "Greater than or equal to 1000000s";
+	else
+		sprintf(str, "%lld.%09lds", val->tv_sec, val->tv_nsec);
+	return str;
+}
+
 /* Filter Methods */
 
+static int attr_default_filter(void *attr, const char *input, int *err)
+{
+	return false;
+}
+
 static const char op_list[] = "<>!=";
 
 /*
@@ -246,8 +268,20 @@ static void *attr_is_init_get(void *test_or_suite, bool is_test)
 		return ((void *) suite->is_init);
 }
 
+static void *attr_duration_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	if (test && !test->generate_params)
+		return ((void *) test->attr.duration);
+	else
+		return ((void *) NULL);
+}
+
 /* List of all Test Attributes */
 
+static struct timespec64 duration_default = {0, 0};
+
 static struct kunit_attr kunit_attr_list[] = {
 	{
 		.name = "speed",
@@ -256,6 +290,7 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_speed_filter,
 		.attr_default = (void *)KUNIT_SPEED_NORMAL,
 		.print = PRINT_ALWAYS,
+		.to_free = false,
 	},
 	{
 		.name = "module",
@@ -264,6 +299,7 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_string_filter,
 		.attr_default = (void *)"",
 		.print = PRINT_SUITE,
+		.to_free = false,
 	},
 	{
 		.name = "is_init",
@@ -272,10 +308,33 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_bool_filter,
 		.attr_default = (void *)false,
 		.print = PRINT_SUITE,
+		.to_free = false,
+	},
+	{
+		.name = "duration",
+		.get_attr = attr_duration_get,
+		.to_string = attr_duration_to_string,
+		.filter = attr_default_filter,
+		.attr_default = (void *)(&duration_default),
+		.print = PRINT_ALWAYS,
+		.to_free = true,
 	}
 };
 
-/* Helper Functions to Access Attributes */
+/* Helper Functions to Access/Free Attributes */
+
+void kunit_free_attr(void *test_or_suite, bool is_test)
+{
+	int i;
+	void *attr;
+
+	for (i = 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
+		if (kunit_attr_list[i].to_free) {
+			attr = kunit_attr_list[i].get_attr(test_or_suite, is_test);
+			kfree(attr);
+		}
+	}
+}
 
 const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
 {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e8b1b52a19ab..0d18e4969015 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -376,11 +376,11 @@ static void kunit_run_case_check_speed(struct kunit *test,
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
-static void kunit_run_case_internal(struct kunit *test,
+static struct timespec64 kunit_run_case_internal(struct kunit *test,
 				    struct kunit_suite *suite,
 				    struct kunit_case *test_case)
 {
-	struct timespec64 start, end;
+	struct timespec64 start, end, duration;
 
 	if (suite->init) {
 		int ret;
@@ -389,7 +389,9 @@ static void kunit_run_case_internal(struct kunit *test,
 		if (ret) {
 			kunit_err(test, "failed to initialize: %d\n", ret);
 			kunit_set_failure(test);
-			return;
+			duration.tv_sec = 0;
+			duration.tv_nsec = 0;
+			return duration;
 		}
 	}
 
@@ -399,7 +401,11 @@ static void kunit_run_case_internal(struct kunit *test,
 
 	ktime_get_ts64(&end);
 
-	kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
+	duration = timespec64_sub(end, start);
+
+	kunit_run_case_check_speed(test, test_case, duration);
+
+	return duration;
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
@@ -424,6 +430,7 @@ struct kunit_try_catch_context {
 	struct kunit *test;
 	struct kunit_suite *suite;
 	struct kunit_case *test_case;
+	struct timespec64 duration;
 };
 
 static void kunit_try_run_case(void *data)
@@ -440,7 +447,7 @@ static void kunit_try_run_case(void *data)
 	 * abort will be called, this thread will exit, and finally the parent
 	 * thread will resume control and handle any necessary clean up.
 	 */
-	kunit_run_case_internal(test, suite, test_case);
+	ctx->duration = kunit_run_case_internal(test, suite, test_case);
 }
 
 static void kunit_try_run_case_cleanup(void *data)
@@ -521,6 +528,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 {
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
+	struct timespec64 *duration = kmalloc(sizeof(struct timespec64), GFP_KERNEL);
 
 	try_catch = &test->try_catch;
 
@@ -533,6 +541,10 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
+	duration->tv_sec = context.duration.tv_sec;
+	duration->tv_nsec = context.duration.tv_nsec;
+	test_case->attr.duration = duration;
+
 	/* Now run the cleanup */
 	kunit_try_catch_init(try_catch,
 			     test,
@@ -670,6 +682,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 		}
 
 		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
+		kunit_free_attr((void *)test_case, true);
 
 		kunit_print_test_stats(&test, param_stats);
 
@@ -680,6 +693,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_update_stats(&suite_stats, test_case->status);
 		kunit_accumulate_stats(&total_stats, param_stats);
+
 	}
 
 	if (suite->suite_exit)
@@ -688,6 +702,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_print_suite_stats(suite, suite_stats, total_stats);
 suite_end:
 	kunit_print_suite_end(suite);
+	kunit_free_attr((void *)suite, false);
 
 	return 0;
 }

base-commit: 67c9971cd6d309ecbcb87b942e22ffc194d7a376
-- 
2.45.2.993.g49e7a77208-goog


