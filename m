Return-Path: <linux-kernel+bounces-272324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B52945A47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B00828123E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A51C378A;
	Fri,  2 Aug 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzVVbitw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD01BF30D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588655; cv=none; b=p8xjUObOgylRe/eCbkIo/hwxZDYXxFOROn116N6Dh51oh3+JhCbLdsPpiYVt/0RfcE+4Wm5rL7FOxAuYJh/E8Zy5NZUt5wq11fsILn+aZrkWDZ93Oyi1m11HEaIV2qOVoiR7OLslGu4GygZJmR7BCHUTWJ9GIwSPPbCLFhyEG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588655; c=relaxed/simple;
	bh=LkBh8vdvqP2dd00qEVU2mo2FRpOr4+KJxzPZYkqccc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhofWajq/8z3UoAIimshVfD1GdtF6v13PeNb289hgWhqlwTmz98QaPqoUiKEyDQMmruClUBi6RXJxliExq1oay9Uxd/cwE1L0SN0xOcsO7VyWWGmGy70tZCopZokYHdwA4JBqrPs8EwIhbUM3g0oYbyjDDtuKqInXCvIHk/YObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzVVbitw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso737124266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722588652; x=1723193452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYmXBmScurZjis0yN5U9wEBN6bdZcv2HfflbnZA48t8=;
        b=IzVVbitw0t2vAp7uy5NLb9q4ABlYG1FFHTkf5NND1PeiceF51sGBy0pJpzqy74jvdP
         QO0CGJ8h4aQ0G48KabQakIgIqupPKZgU0Eqs+a+CN6344ksLTNiFEwyYhSM436dRKuqw
         ZpjqRqSBF/UCAtkhnIpRstFuOvAo3lW6LpFbgB1vSAPRZOBm0khuozKKZukwO3Z4zV9P
         UpjywSSuCVF/gdK3kxgC4mjBu59BNvAt5aTblceISbug0QvlU++roxYVf+8/kqIdpAR0
         4wEqcX7FvbkiItcDF9xcKlD9fxCdEl4U8ngoo1v7WmkHE4/+r2xv21qJXZGeS9t3YCi9
         ibWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722588652; x=1723193452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYmXBmScurZjis0yN5U9wEBN6bdZcv2HfflbnZA48t8=;
        b=KsaIr/u1zjGoUoN7WdsPetnpNaSLOdoVNLVO2Ylgj8cKOO/tQScMhyhj4hjsouEyTa
         k8nq9euMTo7e+WIayhvCkaonfdNNmEXROI1uIJEeY9yIjz3vW1VSds+H3Dd9VMncyQQM
         ljYvWHZn4wOWrFyZY1ZYBAdEYWVIUzy5K6SE87E7+3TlNfgncy5HkC0FddRTRyDb2GY6
         rlrGTPOS1qFjwarOjhtOE0tt3fEpq4Ka0wdshGTADd19baNpf0BAahhJnjLy7qNkglJu
         Jmio4dgAdShPxnPm1DCc+fnmR7rwwVY9pFg4sAE2A5dd+nSyq7C7v1h4MEW4SHZ67HFo
         +lcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQbphBxckR6AO+fujIwBx4F5q/Kxw2DsyckWkK5DumbVf1yoNFzuFyx/NPk81NpzHA/Gbn8rzMIpWO5peaMbnePwj8sXV7WoXjOVDI
X-Gm-Message-State: AOJu0Yyr5mv5vtGAQWiX39wwhJeMK4XUGe2k0hqS8dHsRQdDFlejM2DJ
	d7cXuEi3B57Z/y0eK2CQTeGgjdRTRs5vUfqaK/i5qHE1nb7cWmo=
X-Google-Smtp-Source: AGHT+IFvK4orbI6LNsELu/xB64uvyazNJRbDa2ZxQyhuby6J4ozn+wdc3m9XD6dtz9mA9DlnIRxaMQ==
X-Received: by 2002:a17:907:94c5:b0:a77:f2c5:84b3 with SMTP id a640c23a62f3a-a7dc4e5a4edmr205120666b.22.1722588652017;
        Fri, 02 Aug 2024 01:50:52 -0700 (PDT)
Received: from p183 ([46.53.254.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3c7asm75265566b.14.2024.08.02.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:50:51 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:50:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 2/3] x86/cpu: fix unbootable VMs by inlining memcmp in
 hypervisor_cpuid_base
Message-ID: <304592cf-e4a7-4ba1-baa6-4941c60f0e3c@p183>
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>

If this memcmp() is not inlined then PVH early boot code can call
into KASAN-instrumented memcmp() which results in unbootable VMs:

	pvh_start_xen
	xen_prepare_pvh
	xen_cpuid_base
	hypervisor_cpuid_base
	memcmp

Ubuntu's gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04) inlines
memcmp with patch and the bug is partially fixed.

Leave FIXME just in case someone cares enough to compare 3 pairs of
integers like 3 pairs of integers.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/cpuid.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 6b122a31da06..3eca7824430e 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -196,7 +196,20 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 	for_each_possible_hypervisor_cpuid_base(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
 
-		if (!memcmp(sig, signature, 12) &&
+		/*
+		 * FIXME rewrite cpuid comparators to accept uint32_t[3].
+		 *
+		 * This memcmp()
+		 * a) is called from PVH early boot code
+		 *    before instrumentation is set up,
+		 * b) may be compiled to "call memcmp" (not inlined),
+		 * c) memcmp() itself may be instrumented.
+		 *
+		 * Any combination of 2 is fine, but all 3 aren't.
+		 *
+		 * Force inline this function call.
+		 */
+		if (!__builtin_memcmp(sig, signature, 12) &&
 		    (leaves == 0 || ((eax - base) >= leaves)))
 			return base;
 	}

