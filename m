Return-Path: <linux-kernel+bounces-334806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A480C97DC63
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DAF1F21DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1514F9D0;
	Sat, 21 Sep 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cQuMxJNl"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327D5475C
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911035; cv=none; b=jNOqJPMX1M6911XXzHUv6+Pd8ui9f29Vj4UroxiCnj98aHJcIeSAhwDqlp0Id6WkHOXNw8rQksBGiFgk9fGHOikfTkGCIBkiDnr08JdxVCGrr/uoJTQd9CMAfiTm0zH/QOg7/TgG7/91GvSalCIMRZDaRJzDCRIhJXPPhNpJN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911035; c=relaxed/simple;
	bh=VSwYmmRllaGfKmgy6RkKpslv6rcBiRNq66PAKWtmVk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XluOCp64/u64ZGhKG9osw6indy1VPSs5G4LRdFr1iCgWlqNqvRr47H7pjRT7cIvEaKkQMJzYsD4iQ5EfY7PhboIL09Or6TewD9MPNq30BKGNv5bumlA/HJ7NQJ9enJdKlXQ2iXuCeFoX40g5boYG3ZGeRcHmeDYLlYmLxDiSWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cQuMxJNl; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726911029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/4aFPjYLzjqcPMu1zb7OJdbSkFGLthJiczRI9uqj4Q=;
	b=cQuMxJNlTi3Gx7Yy97hcn22MGfrxWlD1PsDWDA4nxuImgHEmIljQR/HLsgJHa9vM6N2FBY
	F2DXJUOl4+xeHqLTxF71PrDzdZVMna4/hocIxm/NyXh3ty5cJtqmKZ+bgmA6hw+f2OxJuH
	INvb6lfZ3gz1vupehCQIWX4vIkflxug=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 3/5] sysctl: add kunit test code to check the min/max encoding of sysctl table entries
Date: Sat, 21 Sep 2024 17:29:02 +0800
Message-Id: <43cdd38ef6dc22a07411567f525a1b9b13cbba62.1726910671.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726910671.git.wen.yang@linux.dev>
References: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add kunit test code to check the impact of encoding the min/max values
directly in table entries on functions such as proc_rointvec,
proc_rou8vectminmax, proc_rouintvectminmax, and proc_roulongvectminmax,
including basic parsing testing and min/max overflow testing.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Thomas Weißschuh <thomas@t-8ch.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sysctl-test.c | 581 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 581 insertions(+)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 3ac98bb7fb82..23439ce85f2d 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -415,6 +415,575 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
 	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
 }
 
+static void sysctl_test_api_dointvec_write_with_minmax(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_dointvec_minmax,
+		.min		= -1,
+		.max		= 100,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "10";
+	char input2[] = "-5";
+	char input3[] = "200";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+}
+
+static void sysctl_test_api_dointvec_write_with_min(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644 | SYSCTL_FLAG_MIN,
+		.proc_handler	= proc_dointvec_minmax,
+		.min		= -1,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "10";
+	char input2[] = "-5";
+	char input3[] = "2147483647";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input3) - 1, len);
+	KUNIT_EXPECT_EQ(test, 2147483647, *((int *)table.data));
+}
+
+static void sysctl_test_api_dointvec_write_with_max(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644 | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_dointvec_minmax,
+		.max		= 100,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "10";
+	char input2[] = "2147483647";
+	char input3[] = "-2147483648";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 10, *((int *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input3) - 1, len);
+	KUNIT_EXPECT_EQ(test, -2147483648, *((int *)table.data));
+}
+
+static void sysctl_test_api_douintvec_write_with_minmax(
+		struct kunit *test)
+{
+	unsigned int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_douintvec_minmax,
+		.min		= 4,
+		.max		= 200,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "100";
+	char input2[] = "3";
+	char input3[] = "1000";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 100, *((unsigned int *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 100, *((unsigned int *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 100, *((unsigned int *)table.data));
+}
+
+static void sysctl_test_api_douintvec_write_with_min(
+		struct kunit *test)
+{
+	unsigned int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644 | SYSCTL_FLAG_MIN,
+		.proc_handler	= proc_douintvec_minmax,
+		.min		= 4,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "100";
+	char input2[] = "3";
+	char input3[] = "4294967295";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 100, *((unsigned int *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 100, *((unsigned int *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input3) - 1, len);
+	KUNIT_EXPECT_EQ(test, 4294967295, *((unsigned int *)table.data));
+}
+
+static void sysctl_test_api_douintvec_write_with_max(
+		struct kunit *test)
+{
+	unsigned int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644 | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_douintvec_minmax,
+		.max		= 1000,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "900";
+	char input2[] = "10000";
+	char input3[] = "0";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 900, *((unsigned int *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 900, *((unsigned int *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input3) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *((unsigned int *)table.data));
+}
+
+static void sysctl_test_api_dou8vec_write_with_minmax(
+		struct kunit *test)
+{
+	unsigned char data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(unsigned char),
+		.mode		= 0644 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 3,
+		.max		= 100,
+	};
+	size_t max_len = 8, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "32";
+	char input2[] = "1";
+	char input3[] = "200";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 32, *((unsigned char *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 32, *((unsigned char *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 32, *((unsigned char *)table.data));
+}
+
+static void sysctl_test_api_dou8vec_write_with_min(
+		struct kunit *test)
+{
+	unsigned char data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(unsigned char),
+		.mode		= 0644 | SYSCTL_FLAG_MIN,
+		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 3,
+	};
+	size_t max_len = 8, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "32";
+	char input2[] = "1";
+	char input3[] = "255";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 32, *((unsigned char *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 32, *((unsigned char *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input3) - 1, len);
+	KUNIT_EXPECT_EQ(test, 255, *((unsigned char *)table.data));
+}
+
+static void sysctl_test_api_dou8vec_write_with_max(
+		struct kunit *test)
+{
+	unsigned char data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(unsigned char),
+		.mode		= 0644 | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_dou8vec_minmax,
+		.max		= 200,
+	};
+	size_t max_len = 8, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "32";
+	char input2[] = "0";
+	char input3[] = "255";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 32, *((unsigned char *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input2) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *((unsigned char *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dou8vec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 0, *((unsigned char *)table.data));
+}
+
+static void sysctl_test_api_doulongvec_write_with_minmax(
+		struct kunit *test)
+{
+	unsigned long data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 1000,
+		.max		= 3000,
+	};
+	size_t max_len = 64, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "1024";
+	char input2[] = "100";
+	char input3[] = "4096";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 1024, *((unsigned long *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 1024, *((unsigned long *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+				user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 1024, *((unsigned long *)table.data));
+}
+
+static void sysctl_test_api_doulongvec_write_with_min(
+		struct kunit *test)
+{
+	unsigned long data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644 | SYSCTL_FLAG_MIN,
+		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 1000,
+	};
+	size_t max_len = 64, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "1000";
+	char input2[] = "10";
+	char input3[64] = {0};
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 1000, *((unsigned long *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 1000, *((unsigned long *)table.data));
+
+	// test for input3
+	snprintf(input3, sizeof(input3), "%lu", ULONG_MAX);
+	len = strlen(input3);
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, strlen(input3), len);
+	KUNIT_EXPECT_EQ(test, ULONG_MAX, *((unsigned long *)table.data));
+}
+
+static void sysctl_test_api_doulongvec_write_with_max(
+		struct kunit *test)
+{
+	unsigned long data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644 | SYSCTL_FLAG_MAX,
+		.proc_handler	= proc_doulongvec_minmax,
+		.max		= 3000,
+	};
+	size_t max_len = 64, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	char input1[] = "1024";
+	char input2[] = "4096";
+	char input3[] = "0";
+
+	// test for input1
+	len = sizeof(input1) - 1;
+	memcpy(buffer, input1, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input1) - 1, len);
+	KUNIT_EXPECT_EQ(test, 1024, *((unsigned long *)table.data));
+
+	// test for input2
+	len = sizeof(input2) - 1;
+	pos = 0;
+	memcpy(buffer, input2, len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, pos);
+	KUNIT_EXPECT_EQ(test, 1024, *((unsigned long *)table.data));
+
+	// test for input3
+	len = sizeof(input3) - 1;
+	pos = 0;
+	memcpy(buffer, input3, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_doulongvec_minmax(&table, KUNIT_PROC_WRITE,
+			user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input3) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *((unsigned long *)table.data));
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -427,6 +996,18 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
 	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_with_minmax),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_with_min),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_with_max),
+	KUNIT_CASE(sysctl_test_api_douintvec_write_with_minmax),
+	KUNIT_CASE(sysctl_test_api_douintvec_write_with_min),
+	KUNIT_CASE(sysctl_test_api_douintvec_write_with_max),
+	KUNIT_CASE(sysctl_test_api_dou8vec_write_with_minmax),
+	KUNIT_CASE(sysctl_test_api_dou8vec_write_with_min),
+	KUNIT_CASE(sysctl_test_api_dou8vec_write_with_max),
+	KUNIT_CASE(sysctl_test_api_doulongvec_write_with_minmax),
+	KUNIT_CASE(sysctl_test_api_doulongvec_write_with_min),
+	KUNIT_CASE(sysctl_test_api_doulongvec_write_with_max),
 	{}
 };
 
-- 
2.25.1


