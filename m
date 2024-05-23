Return-Path: <linux-kernel+bounces-186994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AB8CCBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9DB1F22C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B813BADF;
	Thu, 23 May 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UugR7HhO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C64213BAD5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440724; cv=none; b=Q5tgiPpxQmbus4hxPVDmo0y9nNH8UFsI7xhXSzSzctI+Xh3CziWoRZM0kbCABay7qlvfRtv7fKjoEas2ZV2bB5B+F4vF+rJ4BaAX+3E+LW11e5vgi9IOwdC3Fk8b0LvDwjtTGb+vgMQd7RH3FSqSAMIr7NBgD36VhF+I0xPkn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440724; c=relaxed/simple;
	bh=KrGpaMekyTRuOSDlmtTjCMBOb9Ydu/BZISecKqMIkbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/QjR9J4eYSMjFK8i1AyU1a8DCM5bGtfkoa0FGq7b+EP4+9Y4FQtUhKfGhD9UfEQBs0FcQjKm4tsZTJDelGEkZOcQmvNGApavwARNQC/WRHsmW7UtUAhV/CuvUOTl++dw1CoYABGHeGPE7gRTKT71qe7SByC39MJHTGRO7sid8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UugR7HhO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXqG8tM8YcaI9rGWt1KJ0lfMUtcaUoa1T7IYtFP1N5A=;
	b=UugR7HhOJ9XUY6AbI+hmgEdo2rlQfNGuHsxNQn11PmmUfSdnzrx4ojzD1/yA8/d1y5s1U7
	m0qIKoLsuUONFeGCuBJRy5IJVEn0HWau7nZMe3zVb472m82/mBS0mXcSrIy8NZeGPx3QJl
	4TFvxGjGhqp4LHiTn/tnrCRC+eWtP60=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-fn22c9HnMG63SF5ut5hIjw-1; Thu, 23 May 2024 01:05:20 -0400
X-MC-Unique: fn22c9HnMG63SF5ut5hIjw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f0ff1a4fddso955448a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440719; x=1717045519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXqG8tM8YcaI9rGWt1KJ0lfMUtcaUoa1T7IYtFP1N5A=;
        b=uFIY+kXCHxl5xLO1TX8D4+KHBjh+QFtfwX5GXZyjy6OMIx04Suz3+ZMYB8rV5NTi2T
         XokFB7TmQYVkgn4p5qZ+SyPa+5KPHhfWsgEynpjLOq6CNjgZI6Gt69pJw4GRmFiPR6xv
         p+y/jJaSEWcPizQ0N3078/QQshIbzMLv8L3fN19zbcut+XyMzftqp8cdVUeKHz/ymC6e
         ggQ/xC1zbFG5HkJGMmmqXAxcv2lZJPNNJcs+E9Mt3EX/4x/z9Y2cKnmM0Fhgj8w6jzjq
         UUvf6ZZ9/s2U4u3xNdZEuYINsmZ5+F8HnPw06I0TFwzBawbUftXKSbfS1IIKHLg/6156
         lazg==
X-Forwarded-Encrypted: i=1; AJvYcCWMC3LT8k3hUqMzLB8wldBeuCGfLrSYhpJtpHMVF7eImKVaqAKv+HIyewXRLiFbxvdpfXhYDsE8nZRP1M7eruvEoJ6eRi7LT41N+YI+
X-Gm-Message-State: AOJu0YwmxPH13qDSw/Pbj7ejz67F4VV3J8fAZoZ1l/8L+XIktX0Yhkn9
	J0QKYrElXS2OxQYQhuT5ERepKPbT9x90NWmoERIly5aJMcQAABUCLD+S4nM9P9M2uE3MfcaO/KZ
	qrFgmwGcXEFHifsZ83vpIktPZ3Kai7jFWqiarv2V1RsKEQc5VrRneH8IP2+8Htg==
X-Received: by 2002:a05:6830:10cd:b0:6f0:bf65:9c42 with SMTP id 46e09a7af769-6f666f7914bmr3888022a34.15.1716440719371;
        Wed, 22 May 2024 22:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQA1xavODDuyHNmo2P3AvBsnEdbuteghicukf23qUMHJD1rGUHnEt8+t2eLKuyEOwcoEKaA==
X-Received: by 2002:a05:6830:10cd:b0:6f0:bf65:9c42 with SMTP id 46e09a7af769-6f666f7914bmr3888000a34.15.1716440718826;
        Wed, 22 May 2024 22:05:18 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63a917264d6sm20539102a12.73.2024.05.22.22.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:18 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Thu, 23 May 2024 13:04:47 +0800
Message-ID: <20240523050451.788754-7-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1st kernel will build up the kernel command parameter dmcryptkeys as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/crash.c           | 15 ++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f06501445cd9..74b3844ae53c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude dm crypt keys region */
+	if (image->dm_crypt_keys_addr) {
+		start = image->dm_crypt_keys_addr;
+		end = start + image->dm_crypt_keys_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..9c94428927bd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->dm_crypt_keys_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
 	}
 #endif
 
-- 
2.45.0


