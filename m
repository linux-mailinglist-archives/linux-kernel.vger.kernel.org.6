Return-Path: <linux-kernel+bounces-440445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092629EBDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB96168992
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E651F1920;
	Tue, 10 Dec 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yekHXpLX"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4C1EE7BE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870680; cv=none; b=tmTpIyqfWTiMscNlnSOn6PUa9qufaqK9yNwkj1AV8SOj2AnITucOpwnIVf6WO4lXFrfcvPrsJpiIN1PFbEhgjJ0TmG/KrajiOYkD2i5wtG1xbndqAFdQGnl+LWK7QviPma4QwU5oXIeQE6tZOUPTSm9GUDItOELwgjyEV2AIR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870680; c=relaxed/simple;
	bh=u9leJh1meIuUaI/1M+S+UmdCfL/JpflDsWChpBlbaQ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lRByAkk8wKrXob+JLIKxhUdOadhGxFpFTIIYYLHUow1c0BNTZT1hijVCyC5NhkOw4eU46IKZ0UygLv1tan8OEsVYCeACSDGHgWDoBrs2N1JMw3y8HTXDM5VhO6bUw2oKICpL4f4MXoGMRy93hBqmp2U4Xnkv1QgCHm9VhurY7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yekHXpLX; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so43232305ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733870678; x=1734475478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qqk+CWWqN5rq/MGB/yHuis8ZQybMADaRH3hk0OV3uFc=;
        b=yekHXpLX+E2jJHHo8MvEQkcunPSy8qjbKcTNBtQErx6td5w0k5BQJOGkPiTDDYFT5Z
         b++cL5CA7hgHl5U0DnU6ENsvXL/iK5lptiXXFVmTJZhb+zvuK2fDMan4CdeEHZVyIwmA
         bnEddXaS7N0X+TbVbVv+Dh0hMTqJwRAEokdCznWiuI3Ly+XTKHPaQH8HtAXrjIAp7i2c
         uW6BqdBC7cHpacBsbziD3qZaEsu8+9q3zU7Z5pud8YYqe/frP49nh8UsVNFAtcPqRoZN
         qYanLMURSLIFIu6v2Fu0ex2Wf0BQzX9GpHUgfAxz1HCr37PbL64GbVOAO5oq+3c/wpmA
         7k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870678; x=1734475478;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqk+CWWqN5rq/MGB/yHuis8ZQybMADaRH3hk0OV3uFc=;
        b=PPWJ6eYoCscw81qmdUB/DjsaWW1KEp2rGRIIntlplOiypO6Z2SsCcAUdcv9SCUcOUj
         /3pZXTmdGalrGh+LDBdjSn5yMaqJllHAUfxOFiDWiXGF+hmP7Q8OBT8kf4+RNxOikOdF
         r9nDAwU0vkQMuXjYTSiobbTHW+3CL44b9WUn2+hgI5qAAbH6k/rGufwjQR3xQ1JJe5w0
         G107RBEMxNXCbDRX8XA/uzi78+nOvty3Jp2lj3XmLhxo9dOCXLvtBlPMzE2I7cx26/1p
         b+uugKqZKtzhmBikDq94EsjcJraasoUZThYRybMs//z3yaoTnhd2G6A9z7Kn0Gtyh0Gs
         GG5g==
X-Forwarded-Encrypted: i=1; AJvYcCXZZgDQhonPMtQsLpNTPeL2+GQpOjpP/FIttiUVjyA+E6vziuFIgMUbZAvBt5RewJakpcgH6BsaqxPNXF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVkA0LGEXb8GPHStAJvJSnt470QSAnpg1HTUXnImIoYdgsl09
	PkwyzTbPJz86T6ZkDgA73tmqs8UXNe1jHqpi7UqjLB1Q5YSjA31wsBe6SGW2FfkfOe8ghBYKOJb
	3KK53oQ==
X-Google-Smtp-Source: AGHT+IET+QW/GxpL9rCtfukOBZmUY2qfXT9xKNqc21i3LI6O4efNul9iMc8xel/3eEjF4fnde26kqvcpA/Uu
X-Received: from ilgm9.prod.google.com ([2002:a92:4b09:0:b0:3a7:cfdb:57d])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:1384:b0:3a7:5cda:2769
 with SMTP id e9e14a558f8ab-3aa06bee07cmr8003405ab.12.1733870677912; Tue, 10
 Dec 2024 14:44:37 -0800 (PST)
Date: Tue, 10 Dec 2024 22:44:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210224435.15206-1-rananta@google.com>
Subject: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
From: Raghavendra Rao Ananta <rananta@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Raghavendra Rao Anata <rananta@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently the rseq constructor, rseq_init(), assumes that glibc always
has the support for rseq symbols (__rseq_size for instance). However,
glibc supports rseq from version 2.35 onwards. As a result, for the
systems that run glibc less than 2.35, the global rseq_size remains
initialized to -1U. When a thread then tries to register for rseq,
get_rseq_min_alloc_size() would end up returning -1U, which is
incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
have the support for rseq symbols.

Cc: stable@vger.kernel.org
Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/rseq/rseq.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 5b9772cdf265..9eb5356f25fa 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -142,6 +142,16 @@ unsigned int get_rseq_kernel_feature_size(void)
 		return ORIG_RSEQ_FEATURE_SIZE;
 }
 
+static void set_default_rseq_size(void)
+{
+	unsigned int rseq_kernel_feature_size = get_rseq_kernel_feature_size();
+
+	if (rseq_kernel_feature_size < ORIG_RSEQ_ALLOC_SIZE)
+		rseq_size = rseq_kernel_feature_size;
+	else
+		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+}
+
 int rseq_register_current_thread(void)
 {
 	int rc;
@@ -219,12 +229,7 @@ void rseq_init(void)
 			fallthrough;
 		case ORIG_RSEQ_ALLOC_SIZE:
 		{
-			unsigned int rseq_kernel_feature_size = get_rseq_kernel_feature_size();
-
-			if (rseq_kernel_feature_size < ORIG_RSEQ_ALLOC_SIZE)
-				rseq_size = rseq_kernel_feature_size;
-			else
-				rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+			set_default_rseq_size();
 			break;
 		}
 		default:
@@ -239,8 +244,10 @@ void rseq_init(void)
 		rseq_size = 0;
 		return;
 	}
+
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
 	rseq_flags = 0;
+	set_default_rseq_size();
 }
 
 static __attribute__((destructor))

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.47.0.338.g60cca15819-goog


