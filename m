Return-Path: <linux-kernel+bounces-361918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8499AEDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D891C20C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4041DB55C;
	Fri, 11 Oct 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="exgFWDW4"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DA322E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687160; cv=none; b=LvDHQSNKO5KDz5J/KoVOXmNCUNv0c/r2rBpp79eME9Ce1dGW8/zpyo2C9SNFqDkkTUmX5kKIcSsecIOgvO5/MC4wyTrvP9dE+3rqPK3Htr4EMfSjgY+b+Y27BjJvmhynMADSln9a88x4uuHnnCVuYojkJKwuBQKs+IvFBSlS5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687160; c=relaxed/simple;
	bh=FrmoP9Ed/0xHdCOjxPfpYE1fnJPHcZ9VyDlNJrx0xOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iEuewn1cXUHa5ZdoQri3R46zrpINnBRlgYZxjW3gy0vEFPdwaBpOb6lwKUJ9teoA9OmipttrdDoKPaRRKre2eNDKxXts4EsqdpX2fYW7cpOx0sq+B3A9mjz6e+Nu1iEUISLX4CVG07fMQhjB/98ClIVVebB0kxsEswJz/oMq+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=exgFWDW4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8354851fbfaso105671339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728687158; x=1729291958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHvOYGmkNtiMafvweHa2MYiOrTtCap+64e/z74z9Aac=;
        b=exgFWDW425keee9x/J+zz8Vg80T9qEHvz9RtgC4rkmfWUGKIO0z/fA+EKIwfI8bOCA
         2TIf0i81gSKcjU+Qe1w08T8ap4QSe/0U1D+RnY1pGpSd5DwpjYTdxOahIAyTV3rSGFoi
         lDxbBRhYP/HepQ+y+7qcRXmED7bkKPVTkgwMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687158; x=1729291958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHvOYGmkNtiMafvweHa2MYiOrTtCap+64e/z74z9Aac=;
        b=L7KV+kAWqUe7BnD4adzu6VfIDrIcd9JXzlMGpgVJOfjvQ8fMybkkuEIDXb7dYstpSm
         9UcwRXDeAjshPzWAQDSgRg1zKsnYkggF+5jsRgc8t2eXrPSBKcvlLmzHW84eJ/wU3BWQ
         eDXiajgy6eHuLMK97yGe/LElC1/ADA8kRDWuRq/CiDYXXuKEkf9yIpn+nh0CyYA5wzM/
         /OGOiIhUTS12TtI1ISD4B+epSiCXYCPuDv9veMQTpO33XAmrtnr/GMiiqhzKijz43zPw
         2kcaBND+4pC2KZU/7YNBSq3oyNg7xFZ0oj+eXODg2+YBcTJRHVcrbbo1Nv7ObQMdwg9X
         Slkg==
X-Forwarded-Encrypted: i=1; AJvYcCXRon5EJ884AdnYUG65dsPg6/XghjmsD7E7Dy1ZHuLDqi5e1n02DjtI+SXCDB/y57Omdp9YGdjU948rsQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWI1BcU4r2qxBE3F3rEx1AcD5Z42XIplCnJPdVcNnYcNv8wmu
	dZ1XR+frL9My6CmHrZt3Gt29+NUiGRxuSwMbrJygNm6OyVZ12fU3ToXwHmOAb7I=
X-Google-Smtp-Source: AGHT+IFPB5LLtlXbCaUvRUaYLr8NPV+I1sH3Stoe46Nibovcut1qLH9zNw7G1bxSjBonUQGEhBI0Xw==
X-Received: by 2002:a05:6e02:194d:b0:3a0:480c:6ac4 with SMTP id e9e14a558f8ab-3a3b5fc413cmr41875825ab.22.1728687158059;
        Fri, 11 Oct 2024 15:52:38 -0700 (PDT)
Received: from shuah-tx13.internal ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa9495sm809193173.135.2024.10.11.15.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:52:37 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests:timers: remove local CLOCKID defines
Date: Fri, 11 Oct 2024 16:52:36 -0600
Message-Id: <20241011225236.27677-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timers tests defines CLOCKIDs locally. Remove all local CLOCKIDs except
CLOCK_HWSPECIFIC and use defines from time.h header file.

CLOCK_HWSPECIFIC and CLOCK_SGI_CYCLE are the same and CLOCK_SGI_CYCLE
is deprecated,

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/timers/adjtick.c      |  2 --
 .../selftests/timers/alarmtimer-suspend.c     | 15 ---------------
 .../selftests/timers/inconsistency-check.c    | 19 ++++---------------
 tools/testing/selftests/timers/nanosleep.c    | 18 ++++--------------
 tools/testing/selftests/timers/nsleep-lat.c   | 19 ++++---------------
 tools/testing/selftests/timers/raw_skew.c     |  2 --
 .../testing/selftests/timers/set-timer-lat.c  | 16 +++-------------
 7 files changed, 15 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index cb9a30f54662..777d9494b683 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -26,8 +26,6 @@
 
 #include "../kselftest.h"
 
-#define CLOCK_MONOTONIC_RAW	4
-
 #define MILLION			1000000
 
 long systick;
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 62da2a3f949e..2da382df5eaa 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -31,21 +31,6 @@
 #include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define CLOCK_REALTIME			0
-#define CLOCK_MONOTONIC			1
-#define CLOCK_PROCESS_CPUTIME_ID	2
-#define CLOCK_THREAD_CPUTIME_ID		3
-#define CLOCK_MONOTONIC_RAW		4
-#define CLOCK_REALTIME_COARSE		5
-#define CLOCK_MONOTONIC_COARSE		6
-#define CLOCK_BOOTTIME			7
-#define CLOCK_REALTIME_ALARM		8
-#define CLOCK_BOOTTIME_ALARM		9
-#define CLOCK_HWSPECIFIC		10
-#define CLOCK_TAI			11
-#define NR_CLOCKIDS			12
-
-
 #define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
 
 #define SUSPEND_SECS 15
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 75650cf0503f..9d1573769d55 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -31,21 +31,10 @@
 #include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define CALLS_PER_LOOP 64
-
-#define CLOCK_REALTIME			0
-#define CLOCK_MONOTONIC			1
-#define CLOCK_PROCESS_CPUTIME_ID	2
-#define CLOCK_THREAD_CPUTIME_ID		3
-#define CLOCK_MONOTONIC_RAW		4
-#define CLOCK_REALTIME_COARSE		5
-#define CLOCK_MONOTONIC_COARSE		6
-#define CLOCK_BOOTTIME			7
-#define CLOCK_REALTIME_ALARM		8
-#define CLOCK_BOOTTIME_ALARM		9
+/* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
-#define CLOCK_TAI			11
-#define NR_CLOCKIDS			12
+
+#define CALLS_PER_LOOP 64
 
 char *clockstring(int clockid)
 {
@@ -152,7 +141,7 @@ int main(int argc, char *argv[])
 {
 	int clockid, opt;
 	int userclock = CLOCK_REALTIME;
-	int maxclocks = NR_CLOCKIDS;
+	int maxclocks = CLOCK_TAI + 1;
 	int runtime = 10;
 	struct timespec ts;
 
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 9a354e38a569..252c6308c569 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -30,19 +30,8 @@
 #include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define CLOCK_REALTIME			0
-#define CLOCK_MONOTONIC			1
-#define CLOCK_PROCESS_CPUTIME_ID	2
-#define CLOCK_THREAD_CPUTIME_ID		3
-#define CLOCK_MONOTONIC_RAW		4
-#define CLOCK_REALTIME_COARSE		5
-#define CLOCK_MONOTONIC_COARSE		6
-#define CLOCK_BOOTTIME			7
-#define CLOCK_REALTIME_ALARM		8
-#define CLOCK_BOOTTIME_ALARM		9
+/* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
-#define CLOCK_TAI			11
-#define NR_CLOCKIDS			12
 
 #define UNSUPPORTED 0xf00f
 
@@ -131,11 +120,12 @@ int main(int argc, char **argv)
 {
 	long long length;
 	int clockid, ret;
+	int max_clocks = CLOCK_TAI + 1;
 
 	ksft_print_header();
-	ksft_set_plan(NR_CLOCKIDS);
+	ksft_set_plan(max_clocks);
 
-	for (clockid = CLOCK_REALTIME; clockid < NR_CLOCKIDS; clockid++) {
+	for (clockid = CLOCK_REALTIME; clockid < max_clocks; clockid++) {
 
 		/* Skip cputime clockids since nanosleep won't increment cputime */
 		if (clockid == CLOCK_PROCESS_CPUTIME_ID ||
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index f6a99490b291..de23dc0c9f97 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -29,20 +29,8 @@
 
 #define UNRESONABLE_LATENCY 40000000 /* 40ms in nanosecs */
 
-
-#define CLOCK_REALTIME			0
-#define CLOCK_MONOTONIC			1
-#define CLOCK_PROCESS_CPUTIME_ID	2
-#define CLOCK_THREAD_CPUTIME_ID		3
-#define CLOCK_MONOTONIC_RAW		4
-#define CLOCK_REALTIME_COARSE		5
-#define CLOCK_MONOTONIC_COARSE		6
-#define CLOCK_BOOTTIME			7
-#define CLOCK_REALTIME_ALARM		8
-#define CLOCK_BOOTTIME_ALARM		9
+/* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
-#define CLOCK_TAI			11
-#define NR_CLOCKIDS			12
 
 #define UNSUPPORTED 0xf00f
 
@@ -144,11 +132,12 @@ int main(int argc, char **argv)
 {
 	long long length;
 	int clockid, ret;
+	int max_clocks = CLOCK_TAI + 1;
 
 	ksft_print_header();
-	ksft_set_plan(NR_CLOCKIDS - CLOCK_REALTIME - SKIPPED_CLOCK_COUNT);
+	ksft_set_plan(max_clocks - CLOCK_REALTIME - SKIPPED_CLOCK_COUNT);
 
-	for (clockid = CLOCK_REALTIME; clockid < NR_CLOCKIDS; clockid++) {
+	for (clockid = CLOCK_REALTIME; clockid < max_clocks; clockid++) {
 
 		/* Skip cputime clockids since nanosleep won't increment cputime */
 		if (clockid == CLOCK_PROCESS_CPUTIME_ID ||
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index ea50e4efc422..957f7cd29cb1 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -28,8 +28,6 @@
 #include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define CLOCK_MONOTONIC_RAW		4
-
 #define shift_right(x, s) ({		\
 	__typeof__(x) __x = (x);	\
 	__typeof__(s) __s = (s);	\
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 5365e9ae61c3..4574f8f04542 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -31,19 +31,8 @@
 #include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define CLOCK_REALTIME			0
-#define CLOCK_MONOTONIC			1
-#define CLOCK_PROCESS_CPUTIME_ID	2
-#define CLOCK_THREAD_CPUTIME_ID		3
-#define CLOCK_MONOTONIC_RAW		4
-#define CLOCK_REALTIME_COARSE		5
-#define CLOCK_MONOTONIC_COARSE		6
-#define CLOCK_BOOTTIME			7
-#define CLOCK_REALTIME_ALARM		8
-#define CLOCK_BOOTTIME_ALARM		9
+/* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
-#define CLOCK_TAI			11
-#define NR_CLOCKIDS			12
 
 #define UNRESONABLE_LATENCY 40000000 /* 40ms in nanosecs */
 
@@ -253,6 +242,7 @@ int main(void)
 	struct sigaction act;
 	int signum = SIGRTMAX;
 	int ret = 0;
+	int max_clocks = CLOCK_TAI + 1;
 
 	/* Set up signal handler: */
 	sigfillset(&act.sa_mask);
@@ -261,7 +251,7 @@ int main(void)
 	sigaction(signum, &act, NULL);
 
 	printf("Setting timers for every %i seconds\n", TIMER_SECS);
-	for (clock_id = 0; clock_id < NR_CLOCKIDS; clock_id++) {
+	for (clock_id = 0; clock_id < max_clocks; clock_id++) {
 
 		if ((clock_id == CLOCK_PROCESS_CPUTIME_ID) ||
 				(clock_id == CLOCK_THREAD_CPUTIME_ID) ||
-- 
2.40.1


