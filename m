Return-Path: <linux-kernel+bounces-305302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD611962C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F59A287690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8531A38F9;
	Wed, 28 Aug 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfGviRa1"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB68188013
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859654; cv=none; b=K1g0igkycnMlYnoSgJ4L5tIP0mCDzCZkL4FgRoNbvBCYxN2+EpOT7KsHDXc/TV0kIhKNwB2azmS/Tj4mzFBmZdVcJv5OqRKHLV+3lYYnqjQ91HMlXrULwiIQT7f3euXowIPk7NrOmm5PRP0oXf8ZydL+aAqrOiDN/uebgzy7VRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859654; c=relaxed/simple;
	bh=HykGhePu5Waby/uF/gEeTut7MAeUH5w5U+QMGn9p0ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLJkH9ZnCGTpyt1TW+iqChsMG9itUmgRiGPP1vllHekvJ6CLM7uQ3hIY2w72FF6uXBR8g+2hgGn0mqox5bxM79qnVnEDzrZ0BkIPLLUFy/DBXTEAFnnpuQWWGC/BhCsk7u7RBVVxCX+NTz0vDIlNnYivjglGmIbxi3M8qFHj3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfGviRa1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-428207daff2so63304115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724859650; x=1725464450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RM2/YRNqaAKVm5MVIrmJ/pD1AXRYechixdNATzKjho=;
        b=nfGviRa1/x2YHLm/uM0isfWhDIxiyl7xYtnVvqVGt1puOCe9marvxnvxeHemOBTBwy
         bBhFVQLWcZaXV8tJa1wdWYbwO+leIdQ/UjL7AveAt3SiwcThur+DPSHEQMM7//Us8gA0
         MdMQR6yzJJjIce1wJaFi83czloVgRaP0N9cCKkIkm8hHUYeXv3gQL1gP9mUiky0CbhFw
         G31oQaZSkoyOHUwAn+eaZ0MuEigDtVWhFu7bQYzJUx7qIi53GbhdzzWApFpmerTpMbHU
         h+LDpi/VABgAlfw5UuCvF5XaxyUceP7j+jAbTOeEhBxOmiP+EZX9RknLYu9OPKx04Aeq
         B8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859650; x=1725464450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RM2/YRNqaAKVm5MVIrmJ/pD1AXRYechixdNATzKjho=;
        b=J0jLTzAmCXBNMzLzkOkVXGl0V4UXDoE1yY6quA9fGCfFvomwcHcW/sdE8QWSLVXInG
         CQzxqVXTrjwl1/czp8HYGrQvKQZ10e8F2OioUqoynh1kG/pbqqd2p7HH5F8scg4Oy3vb
         uqvyarkNFH+ONyDIdCuUGrLfYQITIqEFG01v/Uweqtcw8v/+0v4GmbftnmCd6k60vNxk
         Tc8nclV2qoyT2cRFD7494CBu0tSP/omLo0Ok0grox/ZMGXgRhCoy01iHPYv6wNQutAVu
         e02X6f2gmypOP1IazBfIAX0iQIqHGWPxFy6HbMf9kNGFAVYD/hVkhWriEqsVSN4GL+Fl
         +Z4w==
X-Forwarded-Encrypted: i=1; AJvYcCXrdMG2QX1pRqoIWWvjCrewtuVH+hIeOgFi2ig/WDYrST6+Y0FnuqfO3Zu49Bvke4KTMGafjTCPzrMqMfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUDyjQIsmnCcZkxFney8B0M9sXVCIuBuhn8CXbIeTXjvmVXDi
	8iUZX6HxZSViWoOUjIwfkFx4VrNark//MXd9ohlegaCO54hituK/aYuFQXsolUEFzGsF8m6bl8L
	UIzos3E69jJbqk6bR8w==
X-Google-Smtp-Source: AGHT+IGJjmP01VW6ffyzn6YF3275GVaOcQu67Zs0O0+IsNi517+lhBzC6eWFquc/CuzjtQVxikHAUoj4S+crJs2T
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:2d08:b0:428:1d50:b9b1 with
 SMTP id 5b1f17b1804b1-42bb023d043mr1825e9.2.1724859649791; Wed, 28 Aug 2024
 08:40:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:40:40 +0100
In-Reply-To: <20240828154040.2803428-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240821115636.3546f684@gandalf.local.home> <20240828154040.2803428-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828154040.2803428-2-vdonnefort@google.com>
Subject: [PATCH 2/2] ring-buffer/selftest: Handle meta-page bigger than the system
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Handle the case where the meta-page content is bigger than the system
page-size. This prepares the ground for extending features covered by
the meta-page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index ba12fd31de87..d10a847130fb 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -92,12 +92,22 @@ int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
 	if (desc->cpu_fd < 0)
 		return -ENODEV;
 
+again:
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 	if (map == MAP_FAILED)
 		return -errno;
 
 	desc->meta = (struct trace_buffer_meta *)map;
 
+	/* the meta-page is bigger than the original mapping */
+	if (page_size < desc->meta->meta_struct_len) {
+		int meta_page_size = desc->meta->meta_page_size;
+
+		munmap(desc->meta, page_size);
+		page_size = meta_page_size;
+		goto again;
+	}
+
 	return 0;
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog


