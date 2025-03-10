Return-Path: <linux-kernel+bounces-554640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF49A59AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22923A3A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52722FDF9;
	Mon, 10 Mar 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="X13QNl68"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927A22B8A0;
	Mon, 10 Mar 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623634; cv=none; b=WLT9IxeBe3HQa/5k96HFIdrueriLmMERR8TCpofj0bD3wZfG0DjOH2Sz26T5cg+yLK4bfqSWqdBaBfUtCPjQTYF38rH1NKqf+NYbSuEVaPgkX0uRz3U1N1QnK3K4b3qCcMQJIyFt19HWos8fJW/k+2w6g+BWZau05QFJwbBCiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623634; c=relaxed/simple;
	bh=1v3xRWteGrI67pFecY5ifRB8yjRjr4Q9dY4h7fCYqW0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DoPrz7MURzYx2DuKDsh5jeYw/bWCKfwnWXD5knGeiHFhOtMV771YK+/XUy2hjY4/vWim17VjPjFohOiHlkTLk5RjXvRkttxD3n1O0LEJusGuSzbi/tsDn9vSDTK6GTTZwmzOhqrEIOyLwJtgFoul/MzhPYpUU1UTeggVLWYAVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=X13QNl68; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741623630; x=1773159630;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kua1+P7pBuS50I7egTYFseHRI4Y7N92xh/jBVSs2A1g=;
  b=X13QNl68/Tb2qC/W+0Ysu9lx4YStKf4N+gncnZq05VNfwahDnuDniqV+
   jn7VLFRKL8HIBdva5GqTUChzeeHkVx62HfSxxBW+rzUDDKNW8TMllgu2B
   y8IwY+iRElmpZ2TrGWMNTxctgJi7CN7mK67+rul63ob5+8YYmX4sX1uyF
   A=;
X-IronPort-AV: E=Sophos;i="6.14,236,1736812800"; 
   d="scan'208";a="30459260"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 16:20:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:25065]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id 4286f8c0-5c5d-4095-b20b-85582cfebec2; Mon, 10 Mar 2025 16:20:18 +0000 (UTC)
X-Farcaster-Flow-ID: 4286f8c0-5c5d-4095-b20b-85582cfebec2
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Mar 2025 16:20:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Mar 2025 16:20:02 +0000
Received: from email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 16:20:02 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com (Postfix) with ESMTP id 1694FA04AA;
	Mon, 10 Mar 2025 16:20:02 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id A154B6221; Mon, 10 Mar 2025 16:20:01 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Graf <graf@amazon.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David
 Woodhouse" <dwmw2@infradead.org>, Eric Biederman <ebiederm@xmission.com>,
	"Ingo Molnar" <mingo@redhat.com>, James Gowans <jgowans@amazon.com>, Jonathan
 Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "Stanislav
 Kinsburskii" <skinsburskii@linux.microsoft.com>, Steven Rostedt
	<rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, Usama Arif <usama.arif@bytedance.com>, Will Deacon
	<will@kernel.org>, <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v4 06/14] kexec: Add KHO parsing support
In-Reply-To: <20250206132754.2596694-7-rppt@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
	<20250206132754.2596694-7-rppt@kernel.org>
Date: Mon, 10 Mar 2025 16:20:01 +0000
Message-ID: <mafs0zfhs97ta.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Thu, Feb 06 2025, Mike Rapoport wrote:
[...]
> @@ -444,7 +576,141 @@ static void kho_reserve_scratch(void)
>  	kho_enable = false;
>  }
>  
> +/*
> + * Scan the DT for any memory ranges and make sure they are reserved in
> + * memblock, otherwise they will end up in a weird state on free lists.
> + */
> +static void kho_init_reserved_pages(void)
> +{
> +	const void *fdt = kho_get_fdt();
> +	int offset = 0, depth = 0, initial_depth = 0, len;
> +
> +	if (!fdt)
> +		return;
> +
> +	/* Go through the mem list and add 1 for each reference */
> +	for (offset = 0;
> +	     offset >= 0 && depth >= initial_depth;
> +	     offset = fdt_next_node(fdt, offset, &depth)) {
> +		const struct kho_mem *mems;
> +		u32 i;
> +
> +		mems = fdt_getprop(fdt, offset, "mem", &len);
> +		if (!mems || len & (sizeof(*mems) - 1))
> +			continue;
> +
> +		for (i = 0; i < len; i += sizeof(*mems)) {
> +			const struct kho_mem *mem = &mems[i];

i goes from 0 to len in steps of 16, but you use it to dereference an
array of type struct kho_mem. So you end up only looking at only one of
every 16 mems and do an out of bounds access. I found this when testing
the memfd patches and any time the file was more than 1 page, it started
to crash randomly.

Below patch should fix that:

---- 8< ----
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c26753d613cbc..40d1d8ac68d44 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -685,13 +685,15 @@ static void kho_init_reserved_pages(void)
             offset >= 0 && depth >= initial_depth;
             offset = fdt_next_node(fdt, offset, &depth)) {
                const struct kho_mem *mems;
-               u32 i;
+               u32 i, nr_mems;
 
                mems = fdt_getprop(fdt, offset, "mem", &len);
                if (!mems || len & (sizeof(*mems) - 1))
                        continue;
 
-               for (i = 0; i < len; i += sizeof(*mems)) {
+               nr_mems = len / sizeof(*mems);
+
+               for (i = 0; i < nr_mems; i++) {
                        const struct kho_mem *mem = &mems[i];
 
                        memblock_reserve(mem->addr, mem->size);
---- >8 ----
[...]

-- 
Regards,
Pratyush Yadav

