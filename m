Return-Path: <linux-kernel+bounces-526447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666EAA3FECC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FEB3A71A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB75253F32;
	Fri, 21 Feb 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lW/+39Rw"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9197253B76
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162364; cv=none; b=DKJMDYNBQNHPyfXf51F0Ya39V36zx4puWGFTpykGQyGlwWsdAxnmHIeel0HX0QRneed01YYWJbIb2RGTbN8F7xJ1TbWhjdefD2Rlk5ou8HhSAh0oywEOqDP6wwE/VWDaOVSrk1ac2e6ODmajac2Zd/YG9bFCk4XZ8fgNuv6uSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162364; c=relaxed/simple;
	bh=0ixIkjkOL34y3eG+6JnRx3HpyEoFjaPmFiUpYG0o8X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLR27mqDhq/p0UnNllhKOTNqHdE5LgPQzBn7Os9NYCb4dhepFw2gKkCyT8xn2aZkfDna7emYwRvwTKyXy4sXFvXfbQVizjfv9mgdyfgTlfcupylrPoighMJt7pEX7bM7eWLJ0Ipu7eRIeLE1ctUvk8Qefh84xjnhzcHhOrCwBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lW/+39Rw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso13332285e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162361; x=1740767161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUbh6bo0YX556uViMnNFSN2+o8CrzMcR/+eYIWbI+KE=;
        b=lW/+39Rwy1ke3rWDcfzNUyW1cwycG4QN0VX6u+4JIsKdtVtZ4dZyj9I9CDFgBwu07D
         K0pP44YLDMgEEt59VAXG+9SOR+cSGYf2QRNNCkOuG+MyoOCqf5C/G2IQRedJzjdjS7rM
         5gAi8fjbkNaBWXz06d/Y8E9gPYNJpmCQoGbM26OlIkUSnVzzwbIwRuC2ePmx7Smit4aR
         3X0tZnumkcUryInGwbLLZKLluFZ2+0lXxvoEjXS853DWoU8VeiPmOm0ky9Nwh5BhBCY1
         EEioXpM9XVVXcQMmLc4ZPOVfoC/1stS0w/aiHIC/Ik6G2qz7L4DlthIF4TdW8uh0bnWy
         jLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162361; x=1740767161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUbh6bo0YX556uViMnNFSN2+o8CrzMcR/+eYIWbI+KE=;
        b=GiDCDjiPGvH7XA1rwH9xebSjeYHLere03CDPS+1my2vC8ymYhhDZ5vWuM6v7XsC809
         hE22EUOvO/PGXTBSWx0mMW4xCAIptIZHeRy2mrj8/XTZefDMJf+8aOrxve5qz4aZHKBn
         mms7vo/lsa4ipOzGYU1OgJUb0SE7pv2jSjYlmmvgaZuPwCjc9H+gJgWHPLMmGanclWsv
         ZeWB2st1sbX5EHyVCNwoZqa72mUzFifIoWQHfHGja/Rxhc8CzkSpRMAX9L6XiN8YZIWB
         nrsMOD/W/MbPM1cqBDHbTURP+Tyfz3KFlQkL3BVyVg9snf+R1BxfeHlLoUQ16KLx9yLV
         wt0w==
X-Forwarded-Encrypted: i=1; AJvYcCXiYfa0x27G+D7uDc6fYbZfHkrISLYT/QJn4XAboFXduiEB20A5HptEDz8hLukuP1gQvMa4JL/fqCFzamo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5YBroNt0se0LVAYq2bXwnpJ55yxATMpgyQv96SiqD3n5SAdu
	aEhyezsLjlEmfWMfN80kj0OmOQLzd8chp3G4tgDOHEJDQZfNhz6H6uMQZ4xw2dOqGn9ykA+CSEo
	ynZOQb2nRzA==
X-Google-Smtp-Source: AGHT+IE/bG8bUxR8y1P5xtIPuQD4Hhm3QWPdc3EgR4sjxsIVd86HrK8cKBFQtHlEYVxpNKR3bI3d8S9EnfxaWg==
X-Received: from wmgg25.prod.google.com ([2002:a05:600d:19:b0:439:997a:8b94])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:584b:0:b0:38f:3b41:c952 with SMTP id ffacd0b85a97d-38f6e754b82mr3343613f8f.4.1740162361345;
 Fri, 21 Feb 2025 10:26:01 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:46 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-7-28c4d66383c5@google.com>
Subject: [PATCH v2 7/9] selftests/mm: Don't fail uffd-stress if too many CPUs
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="utf-8"

This calculation divides a fixed parameter by an environment-dependent
parameter i.e. the number of CPUs.

The simple way to avoid machine-specific failures here is to just put a
cap on the max value of the latter.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index be0c93f24fccd618f52d54ff36d9a5540f420e46..cfadac801ed43e8b6dc331b343b6dc4030048f9b 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -434,6 +434,7 @@ static void sigalrm(int sig)
 
 int main(int argc, char **argv)
 {
+	unsigned long nr_cpus;
 	size_t bytes;
 
 	if (argc < 4)
@@ -452,7 +453,15 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
+	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus > 32) {
+		/* Don't let calculation below go to zero. */
+		ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
+			       nr_cpus);
+		nr_threads = 32;
+	} else {
+		nr_cpus = nr_threads;
+	}
 
 	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {

-- 
2.48.1.601.g30ceb7b040-goog


