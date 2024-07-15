Return-Path: <linux-kernel+bounces-252712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54593172D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCB31F222B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030818F2D5;
	Mon, 15 Jul 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHc6eCL9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3318EFE5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054915; cv=none; b=jD2H+wI/WRhLqCmn1PE3Wf3swetFLiYEOjLYFQWDJ1SmZ7UxmxjFTBTYYRM5wFPLqf9QM90lNHjE66Xa2aNq33w00J+1nb1HJepWQ7takWeYCdxVHIzS1ucFZIJEinmOhoZoirrIW/qJgp2W1eSp9yiOGYh00FyrQ4zy+kf+v3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054915; c=relaxed/simple;
	bh=Y310MIHKzUnTrGEZYEmMGgXs7+z8zU0zgJp+odjsnBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDI677/1c0tIv+ojpE+ED8L+a+csgoffqe3Rja3tr6XcvKx9+rmZqaasLZ7Ag7CCyMUwWJywe/Al/G9utBoNMbtvM5y95LJQWq28dhvMii3TxVcMCWn5Nu3lrD8/gLhfI7xSZnLeiSK0FmjMynYoPpJHN5tfmOaxl1akDscYD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHc6eCL9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721054912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkASY8k41Yge7TlrZ3/2PBxoq4fiGL0DmL3P/8JkIRs=;
	b=jHc6eCL9m3soWtisxxjLyUR3IYBdsG1EOCoKGdQhv2P//pxMOHt0bAGUX/72wt6gBSB14J
	n5ip/q2g+WU32ClI3+b1vVmfMNjce3H01XosZGRUNZgmFD2e9b4v5IUvf8X7qmpGsVcHmm
	ClHdYr2noYQQNQqX+KGhjXpdaUw0DwI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-ZGslQ6mQM6mpsMimRaGtXw-1; Mon,
 15 Jul 2024 10:48:28 -0400
X-MC-Unique: ZGslQ6mQM6mpsMimRaGtXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92F9A1944B2A;
	Mon, 15 Jul 2024 14:48:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 911801955F3B;
	Mon, 15 Jul 2024 14:48:16 +0000 (UTC)
Date: Mon, 15 Jul 2024 22:48:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, akpm@linux-foundation.org
Cc: vgoyal@redhat.com, dyoung@redhat.com, austindh.kim@gmail.com,
	rmk+kernel@armlinux.org.uk, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Message-ID: <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713014808.1689915-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/13/24 at 09:48am, Jinjie Ruan wrote:
> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> as below:
> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> 
> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
> is also ok as below:
> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
> 
> The cause is that the crash_size is parsed and printed with "unsigned long
> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> which is 4 bytes in memblock_phys_alloc_range().
> 
> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
> input size.

I am not sure if this is a good idea. Shouldn't we handle this in
arch_reserve_crashkernel() to check the system RAM size?

With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
kernel cmdline, then you will reserve 256M crashkernel in system, don't
you think that is confusing?

By the way, I am considering changing code to apply generic crashkernel
reservation to 32bit system. Maybe below draft code can prevent
crashkernel=,high from being parsed successfully on 32bit system.

What do you think?

diff --git a/arch/arm64/include/asm/crash_reserve.h b/arch/arm64/include/asm/crash_reserve.h
index 4afe027a4e7b..bf362c1a612f 100644
--- a/arch/arm64/include/asm/crash_reserve.h
+++ b/arch/arm64/include/asm/crash_reserve.h
@@ -7,4 +7,6 @@
 
 #define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
+
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 #endif
diff --git a/arch/riscv/include/asm/crash_reserve.h b/arch/riscv/include/asm/crash_reserve.h
index 013962e63587..8d7a8fc1d459 100644
--- a/arch/riscv/include/asm/crash_reserve.h
+++ b/arch/riscv/include/asm/crash_reserve.h
@@ -7,5 +7,7 @@
 #define CRASH_ADDR_LOW_MAX		dma32_phys_limit
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
+
 extern phys_addr_t memblock_end_of_DRAM(void);
 #endif
diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 7835b2cdff04..24c2327f9a16 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -26,6 +26,7 @@ extern unsigned long swiotlb_size_or_default(void);
 #else
 # define CRASH_ADDR_LOW_MAX     SZ_4G
 # define CRASH_ADDR_HIGH_MAX    SZ_64T
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 #endif
 
 # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..c5213f123e19 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -306,7 +306,7 @@ int __init parse_crashkernel(char *cmdline,
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
 				crash_base, NULL);
-#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 	/*
 	 * If non-NULL 'high' passed in and no normal crashkernel
 	 * setting detected, try parsing crashkernel=,high|low.


