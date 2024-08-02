Return-Path: <linux-kernel+bounces-272763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360059460B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E520F282C42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE311537C7;
	Fri,  2 Aug 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAytbY8O"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922213632A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613396; cv=none; b=Sajvd/0p4Q7g9sy4cghqBqZF2jcdOPNNq8Kq4deBOnf1lYn5KQm+Ku0LfG1bYJXeX9fye9IWV0jZV3Wd/jTZ7B7NknrhDAcLwEOKydYxeqrEjD5GzR0Uub9sV0sRUTsafBwjyCAhxXpmuI6Q9k3bxaZcbakJ26WKEPwiWG8Z//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613396; c=relaxed/simple;
	bh=2mZkSD/b1zWtOb8eQrCXGIHfycFpYwTykn18LF5IDCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2PE6evvQ6cNb8ZOypZDy9UmRlL+uBbz2ABULbVivem4jpdCDxekFHMzGyTWiDMN4o6WcWnhMdKbOZYRyOjsk2c+ItPVMue6CKb5mItgnHaURdbGx4Xgh4dRlNTJV7MnydQlpSnzrObUBfdd8A+484Wjt1/HkrpcPEt+VQ33CEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAytbY8O; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01993090so12029213e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722613393; x=1723218193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4P6x2FIRDeNfyIxkIdImCW2VyhK1FVBufpOQAJu8qM=;
        b=OAytbY8OKarwwpm62ls8t8IZySkz8UV/sBl492FXmRxfyGZEeJz9gY2GD5wtCFttHf
         2W4D3RLz1BN70sdAroDcr2XT8fqtGXT8NpjtSathlVQBpNgnDfcRM/ncNU/sFac8EK3t
         xVQWECr38qEfp226TEXtovo35Ak3bOoibddvbjIBnxhPPUgGX2HvRnx3n/yBp+xWIN84
         FQs2JMaDPx3QhUol0VahgBWppimalPg4vJZM1W+z1l/XdEkZ6ML4DpuFBSjxInmkNH+x
         bEcqG9bjIm+ci09sDGAGA99EgV6ipjajAPhGgbUYuJqQQQ0TCwFsGxV3/ouBLJFRX62n
         sfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613393; x=1723218193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4P6x2FIRDeNfyIxkIdImCW2VyhK1FVBufpOQAJu8qM=;
        b=XyjRUjG21/s+ryN0DEpiOww4v4wyUKC+4Y2AD9GIGJLM+VAIbfwYVyVRIOrJfy6O5p
         T2fPcLbB1jaDQxqbXvJyfpPCAjHIaC+dWfCXxIdeQYAvNtaFohG/EeY9Ao6Afqom3rXh
         FFP0ilhq4XZ5DrBbdqatwaSqUR7IRUcBgA3zQb6MwkLdfEcRktyQEGisqTETVu4YnvLX
         D1OlX78L6yB7aYI/HLbBaVW0zqUr64N+mHEgqxXWAZBxJyKmOEp6k1runz3zgpei6/J9
         cN8z2jpvSP7AACG125f4sy/X5ol/qaPS/iWABa9LEba2sii1hvVzFHNSLJlXFFg6ZX3N
         lajg==
X-Forwarded-Encrypted: i=1; AJvYcCW81eTUDw/bh+9dD2+RBvP7F08CMKDJ0TFc6W1inR0dpB98uAHue+igxhoB/8foTQQ8bx5NpLoBmohd/5cTD9czhqgC54E4tDvWEJgW
X-Gm-Message-State: AOJu0YxPoGgsOYGz80e7JUAZb7yfHCmIjkX9GSQeftzc3KxkBW5aoysc
	68Xzhg+GvlH5aZ23XhC8uEDNQkfU9eMa8L0DHNloEfE3XFSd8xQ=
X-Google-Smtp-Source: AGHT+IFO4cbdO7G1wIuwaWMf2aVKTHF3PfYeeFz5SotiPK5UUuaNfq7tSuTMqkh0QB4LG/wjxKkIog==
X-Received: by 2002:a05:6512:ba7:b0:52c:9e82:a971 with SMTP id 2adb3069b0e04-530bb36640fmr2731247e87.7.1722613392936;
        Fri, 02 Aug 2024 08:43:12 -0700 (PDT)
Received: from p183.Dlink ([46.53.254.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b723e6dsm1239492a12.65.2024.08.02.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:43:12 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: jgross@suse.com,
	boris.ostrovsky@oracle.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	hpa@zytor.com
Subject: [PATCH 2/3] x86/cpu: fix unbootable VMs by inlining memcmp() in hypervisor_cpuid_base()
Date: Fri,  2 Aug 2024 18:42:52 +0300
Message-ID: <20240802154253.482658-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240802154253.482658-1-adobriyan@gmail.com>
References: <20240802154253.482658-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this memcmp() is not inlined then PVH early boot code can call
into KASAN-instrumented memcmp() which results in unbootable VMs:

	pvh_start_xen
	xen_prepare_pvh
	xen_cpuid_base
	hypervisor_cpuid_base
	memcmp

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/cpuid.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 6b122a31da06..80cc6386d7b1 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -196,7 +196,12 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 	for_each_possible_hypervisor_cpuid_base(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
 
-		if (!memcmp(sig, signature, 12) &&
+		/*
+		 * This must not compile to "call memcmp" because it's called
+		 * from PVH early boot code before instrumentation is set up
+		 * and memcmp() itself may be instrumented.
+		 */
+		if (!__builtin_memcmp(sig, signature, 12) &&
 		    (leaves == 0 || ((eax - base) >= leaves)))
 			return base;
 	}
-- 
2.45.0


