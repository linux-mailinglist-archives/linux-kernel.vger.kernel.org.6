Return-Path: <linux-kernel+bounces-188268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E68CDFE1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B951C22233
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A738F98;
	Fri, 24 May 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EAnFq72n"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F1383B0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521992; cv=none; b=g3ZGItE4oEZZ05qG5w2PSS3VxJPU8BIX3IVNmhhQzmNTrDYh2qT4TF4Mp6J3PAKBWo7TGmyEV7WjtnfUAokIBMedqtnOH/lXKCP+IVg/a4uwC7lBRmXrp2PKl6v03GABHef8f9IC7Q3rHdgdkhtGalmJOauD3b/FXrcIfMNZXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521992; c=relaxed/simple;
	bh=23moA4iMJXSgtkxujKg/JAxWm3k0ziZQHmIoopuyc70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvzuMJMCt6UHMOBEAUD1VZM7fdkstlcfyoe5o0vCEbp8ggAFwwLvh+U5fpUYKL6Gm+6lruUlTTifzWu5GervsFDFpzLN3VW/zi9BkYdlOiTfC2ZcwONo9/2+rU/URhTZNsr16lgw3eHK5duARkOcPzyP8MOeL8xCsYPxVL131Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EAnFq72n; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f0f728d373so3838002a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521990; x=1717126790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6jr022mlOQVdTQNdYCM0jmCCOa9PK9T8m0GA7PmwSw=;
        b=EAnFq72nP3DWnIENBt6bak1yK0hRnCHettp4QHJW+TniqVP1Ukusn/rGWO15BP6o8N
         TOUI3uMjvlZPtbD7OzxanVlYjZEK0W5yfgZkGmQ948JLY+b3nT19tnfQ7pNKh/C5vpbP
         gN5bljzjnZpklV4Yw0rmR1uTSkuavL9c8c9Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521990; x=1717126790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6jr022mlOQVdTQNdYCM0jmCCOa9PK9T8m0GA7PmwSw=;
        b=f5foWUeXEaxrDy6U/RabrhBvClgGHk+gcGeX7nJbiH/3ky7P9EipMBRixiTtWIpGKc
         0Yg35SpHXOLeiS61k4GTKG2hyidpqV9ltM/RvrQiAXtqEUWQCxJxH1VIMT6uGUORBHAp
         UxMJBxQrVYSZc9owen4PMo0nKmc+48LD2IAcMi23ufJzmXx2IOXzYIo6SedOi5+QsrbP
         OyydPtiqHPqObYcTZ8yaYKgekZCShlDx3x3ZO8tgIUFCGb3UzLKqBc9AoyEipF5QGo1t
         +4SZp7hNUDyjLHugEkYGO3a5x4ewC5zcVotEIzgXUdD2XVN0PT7LeRN36eLEiqv1qDUK
         R/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXwbc2CjSARCy2l50ZzXIJ6WmGF5qHQWCpykStTj9Tux6+DlHuin7UZ301g5//37Rv3QLtcVtY/YohSWDp0Y8Nd7j2iTyJnp0G812Vi
X-Gm-Message-State: AOJu0Yx8eCR+TPKkD9VBdLasVhN93P7lUI5nmv0otuA39aVrSf8K0CkN
	zq/hVpF/bUVQCGi4/7WAtUvJI9mM2+iF83jMAD/WeD4XtOofO9JyZGTbi3AEDA==
X-Google-Smtp-Source: AGHT+IHZf+jr2XVCdIxoQjdDZnqMqm+D003gUslsBjdQqg0R++wGRM0qaMzD5yCdbM2LCfnRng/Tyg==
X-Received: by 2002:a05:6870:1492:b0:24c:6198:5ff8 with SMTP id 586e51a60fabf-24ca105306amr1500902fac.4.1716521990321;
        Thu, 23 May 2024 20:39:50 -0700 (PDT)
Received: from localhost (197.59.83.34.bc.googleusercontent.com. [34.83.59.197])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-6f8fcbeb674sm315258b3a.122.2024.05.23.20.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:39:50 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@google.com
Cc: jeffxu@chromium.org,
	akpm@linux-foundation.org,
	cyphar@cyphar.com,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
Date: Fri, 24 May 2024 03:39:30 +0000
Message-ID: <20240524033933.135049-2-jeffxu@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240524033933.135049-1-jeffxu@google.com>
References: <20240524033933.135049-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

By default, memfd_create() creates a non-sealable MFD, unless the
MFD_ALLOW_SEALING flag is set.

When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
unless MFD_ALLOW_SEALING is explicitly set.

This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
is new, we expect not many applications will rely on the nature of
MFD_NOEXEC_SEAL being sealable. In most cases, the application already
sets MFD_ALLOW_SEALING if they need a sealable MFD.

Additionally, this enhances the useability of  pid namespace sysctl
vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
to be sealable. This means, any application that does not desire this
behavior will be unable to utilize vm.memfd_noexec = 1 or 2 to
migrate/enforce non-executable MFD. This adjustment ensures that
applications can anticipate that the sealable characteristic will
remain unmodified by vm.memfd_noexec.

This patch was initially developed by Barnabás Pőcze, and Barnabás
used Debian Code Search and GitHub to try to find potential breakages
and could only find a single one. Dbus-broker's memfd_create() wrapper
is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
work around it [1]. This workaround will break. Luckily, this only
affects the test suite, it does not affect
the normal operations of dbus-broker. There is a PR with a fix[2]. In
addition, David Rheinsberg also raised similar fix in [3]

[1]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f267d4a8784cb/src/util/misc.c#L114
[2]: https://github.com/bus1/dbus-broker/pull/366
[3]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/

Cc: stable@vger.kernel.org
Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: David Rheinsberg <david@readahead.eu>
---
 mm/memfd.c                                 |  9 ++++----
 tools/testing/selftests/memfd/memfd_test.c | 26 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 7d8d3ab3fa37..8b7f6afee21d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
 
 		inode->i_mode &= ~0111;
 		file_seals = memfd_file_seals_ptr(file);
-		if (file_seals) {
-			*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
 			*file_seals |= F_SEAL_EXEC;
-		}
-	} else if (flags & MFD_ALLOW_SEALING) {
-		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
+	}
+
+	if (flags & MFD_ALLOW_SEALING) {
 		file_seals = memfd_file_seals_ptr(file);
 		if (file_seals)
 			*file_seals &= ~F_SEAL_SEAL;
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..8579a93d006b 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
 	mfd_assert_mode(fd, 0666);
-	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
 }
@@ -1169,6 +1169,14 @@ static void test_sysctl_sysctl0(void)
 	mfd_assert_has_seals(fd, 0);
 	mfd_assert_chmod(fd, 0644);
 	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_0_dfl",
+			    mfd_def_size,
+			    MFD_CLOEXEC);
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, F_SEAL_SEAL);
+	mfd_assert_chmod(fd, 0644);
+	close(fd);
 }
 
 static void test_sysctl_set_sysctl0(void)
@@ -1206,6 +1214,14 @@ static void test_sysctl_sysctl1(void)
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_1_noexec_nosealable",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
 }
 
 static void test_sysctl_set_sysctl1(void)
@@ -1238,6 +1254,14 @@ static void test_sysctl_sysctl2(void)
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_noexec_notsealable",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
 }
 
 static void test_sysctl_set_sysctl2(void)
-- 
2.45.1.288.g0e0cd299f1-goog


