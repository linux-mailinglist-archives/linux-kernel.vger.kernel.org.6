Return-Path: <linux-kernel+bounces-433922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0129E5EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CAE188591C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A022E3EC;
	Thu,  5 Dec 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWqlYxWS"
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492022E3EE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426989; cv=none; b=HpRXnhWEOGFra8Xv/Kg1xDDjcLoz4e89Epl7ZZVpc0jx6y0bi4t/HeghwuP21x9sJWuapAH3EJ4kYb2dmoDWrU3b/6soVUwuVZ3wf3bObEPP1A2G56fbJ7Q0XcXuFZ/RN41o+iol76uK5kXjil1dDtqDtKlztF7ngdeFoKkRnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426989; c=relaxed/simple;
	bh=1rpVFzA3SJOg7MFMrYv4VbWxcKZZgBebzXAb2IoxxmA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rXlVnAO3FqG/kU095UtwFL9qw9WLPeijBufO5sJcIVVpueoM3x2KCSQBKjhaK4RbgFCXjtxaAxkkp7wGHbpY6DTBM/1j6cr0y8NP/QJ31Dh/TJtxZWvwQfyWFoOE61QgvfDovlPll3NIHX5S+ffxnLPqISh6gI55w9F2jozrgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWqlYxWS; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5f1eaea9bbaso1156797eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733426987; x=1734031787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtD1DAyRTNy4R3+LwelWToNS6r4To5espgkjbhqaG0Q=;
        b=vWqlYxWSWLXiOE/n8zHHosAbAnOg8rGLe2WKmvAsYsJAlFr/J0hY//vAMlAMarWLd/
         Fp3vbHQsQlz92XAxTr0rYGXKVPhCTiUEooRlmPwarposS8Aob2EIqvxBC+mV7YNVg+Wm
         vNMknhtXM1voYuSXM3cdmZBQ9Uw9spAeW/WVVCYWJPlWf5i67Di6rT51R0I5KF9KLSbh
         +E4YliBOnVmO2L+VlR8o7lGxl2ICkYdxK8wsvLDlYYnx9olhRr1NF5WxUPQuVY4DObsD
         Oz54Z+CJ3tTpgk0Wg9E0Pyeyln14xRc44s0BjL4Qv/cSfiO6P1HDaqLncuU9ayz4UB/S
         NJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426987; x=1734031787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtD1DAyRTNy4R3+LwelWToNS6r4To5espgkjbhqaG0Q=;
        b=Z4MvT9If6GJRbjbYe+xOLiCJQa1jbuamUjBED1KMQ96RhGbhI9HDLEaUgrPseqKWgu
         +M3jMUMttBYRkK5xqYS4BTMM2IX/YoS2fSCZ9/ksm+/dySnocodzwThrosLx3eBhD4mI
         Empxvy6/BAXW+czSm6O8akUAHKIch8A4Pu2SYu8leOMLHPE5jfwcCnmNCmBCUSv9zeFL
         AEyIQLG8nqNQ6ZJzaMxJde9AzWdaVEHQkEjQqgBZOvk28folDG8zIhJJXfxmAK6IRRZY
         Vy4posdW2zSVbMUgUgfa0jUsMblYkur/lydNR7Ls5USLDs+iuuCAGtJj/GfYqEGYoZRf
         xCog==
X-Forwarded-Encrypted: i=1; AJvYcCWmixRlWKnKGEmOH0lkEiRnfcKnatb/CNLYuh81Fm9JIOQgXzVCeZj+fZzwTPSFtOc9H3QyqTDdk7mNg+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2wVrv/2yL5itFNlohwOrsylEhtFua457qyn+LomkVVv5Qoxy
	ADZiXctllRVfkX7AC5nwnn2mXZUZd6HfWMI+eCvnFA8/MHQXiwQiy6AYyuFhrLLdUOAicZro985
	64JnHDgHstnPK/0ci23nMMX/YDO6a99wxWQ==
X-Google-Smtp-Source: AGHT+IEU4C9poX85uHUYauiRDOSDQ0o+pV3iCcYXqrVxsClJoroS19kcGU7fddUYxAs/XI0wKLJeXDPjvhkBFLkRLH76fA==
X-Received: from oacpy6.prod.google.com ([2002:a05:6871:e406:b0:29d:c4b7:250d])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:b1f:b0:29e:60c9:9dcc with SMTP id 586e51a60fabf-29f735d63c5mr142155fac.42.1733426986891;
 Thu, 05 Dec 2024 11:29:46 -0800 (PST)
Date: Thu,  5 Dec 2024 11:29:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205192943.3228757-1-isaacmanjarres@google.com>
Subject: [PATCH v1] selftests/memfd: Run sysctl tests when PID namespace
 support is enabled
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Daniel Verkamp <dverkamp@chromium.org>, 
	Kees Cook <kees@kernel.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, stable@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sysctl tests for vm.memfd_noexec rely on the kernel to support PID
namespaces (i.e. the kernel is built with CONFIG_PID_NS=y). If the
kernel the test runs on does not support PID namespaces, the first
sysctl test will fail when attempting to spawn a new thread in a new
PID namespace, abort the test, preventing the remaining tests from
being run.

This is not desirable, as not all kernels need PID namespaces, but can
still use the other features provided by memfd. Therefore, only run the
sysctl tests if the kernel supports PID namespaces. Otherwise, skip
those tests and emit an informative message to let the user know why
the sysctl tests are not being run.

Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
Cc: stable@vger.kernel.org # v6.6+
Cc: Jeff Xu <jeffxu@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..0a0b55516028 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
@@ -1557,6 +1558,11 @@ static void test_share_fork(char *banner, char *b_suffix)
 	close(fd);
 }
 
+static bool pid_ns_supported(void)
+{
+	return access("/proc/self/ns/pid", F_OK) == 0;
+}
+
 int main(int argc, char **argv)
 {
 	pid_t pid;
@@ -1591,8 +1597,12 @@ int main(int argc, char **argv)
 	test_seal_grow();
 	test_seal_resize();
 
-	test_sysctl_simple();
-	test_sysctl_nested();
+	if (pid_ns_supported()) {
+		test_sysctl_simple();
+		test_sysctl_nested();
+	} else {
+		printf("PID namespaces are not supported; skipping sysctl tests\n");
+	}
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
-- 
2.47.0.338.g60cca15819-goog


