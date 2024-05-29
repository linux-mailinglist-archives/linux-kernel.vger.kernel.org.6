Return-Path: <linux-kernel+bounces-193612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8AD8D2E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBBEB24E68
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FB167D95;
	Wed, 29 May 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QgtZ/sCX"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8616729A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968530; cv=none; b=OZBFcAL+Lmza1jNpjRaYay5RHyy5uIoo5YfBE3wkziW0Ax3A1dLQyeeiDVqEfbjMJSg11ELu5wvw8GRURREpS0BNIk+ZpJo0zyjfaM04gh620Nfj1WYLfminzVlgiQAjgAkPtsFOJL3d5Hk7DyUi1yDhpr9MGeZsn3ryKRNRlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968530; c=relaxed/simple;
	bh=KGKUTt+odp8pca+QtVVvg5n8WFGES2JNOcq2ojQphMY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ptLNi6g6CJVZNCJRS4yEo01mwUIQiD8LznaVZSxD1t866hoHAdWzHvq+68yGgorn7Y9QWUvlEmakaEbMv06v3SkvhlaKH+sFakasaZa15igXNIBrw8D8LIWDEs87xkdbSQmADmBO8lM7KdvIg2hWFgz0ejirfm6oDwQrGJHhxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QgtZ/sCX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so2043320a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716968527; x=1717573327; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLb6wVO4FNYW78qk5Ri+Q41XlxUyVpzUts6/uBkmljc=;
        b=QgtZ/sCXxys4xJmqkNgjKSiTNeV9alh6uPQ/LnmAd95KMQn9Wylr8PnglP0kNGqKkc
         QiXfCaKptc9Mu2PbkqUutRJcrNW6e+7kieVE2/UIl9oGh7d0GKCF1pJloaqDGW5wOQz0
         zrH+1LOI6aKkk+1MfcP5UWvFUCm7JR+xT1DIulH2H+gPqfjo7wG3edewtfsAVJ1tMvpj
         SjcTwdU0GCNMc6u7xDgsh2p38syyVHC/hyiUd+sIGKbIFtMftzGG9kFg1bBryJrL/Wbs
         A45dYWw3xH5CE4WNynHtbq4PNrQD5h5UGtnQ8raTC4rzDiX+hF10E3pH9FpzVpbw24+G
         aaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968527; x=1717573327;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLb6wVO4FNYW78qk5Ri+Q41XlxUyVpzUts6/uBkmljc=;
        b=E/z7BaOiuxkkc4+a+Zac8Tqrlty26oYOLxE7JT1KtYqEFc80ckSXlvwnWS/s/reWxo
         pX/L0RhLw06bNoUwvdlNOQCKuNiTHjoPKGdvUdK6ABzzfmvrpF584ETi8FzGUYfNAYXM
         iLFBsmPRK0nUU9q+4Ic/y15/fgBTdqhQEY454sK8UBauVcj/Qaco1i+c7WHtxt1WZZKA
         y45Ils0BywmTx4HbE+mFnSnyTc0yIUEiYw0eHFWqUfLj/wBwDKKsf/r+DJs+rVvHcwTm
         o29Y17IE7jZ1qlemVYJSqZEmcOVHr73NdROrcL9e5Rvdw7G+/Q59EgI8J7RtOF54/uIh
         jodA==
X-Gm-Message-State: AOJu0YwCoVTlG4orudpOoMUWGKT8YZ9I5hhsto6gYZgQlTdf5wFVRypa
	RcnWo2aTildeEVz5rzFIaiq1yrGdkKv0ttCraOBQMcxOVSKfu4Xmljn/luUEbrrYq0zmoenMYLo
	=
X-Google-Smtp-Source: AGHT+IG0fRCTFFm6Nk4pktHDyy19D7WeawaMN3w/upi8ck7FnuV6JHUPlxA/dX531JcJfvLf8QfmZA==
X-Received: by 2002:a50:a447:0:b0:566:4aa9:7143 with SMTP id 4fb4d7f45d1cf-5785192c696mr8972551a12.14.1716968527045;
        Wed, 29 May 2024 00:42:07 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57967499969sm5575082a12.22.2024.05.29.00.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 00:42:06 -0700 (PDT)
Message-ID: <abadb736-a239-49e4-ab42-ace7acdd4278@suse.com>
Date: Wed, 29 May 2024 09:42:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lkml <linux-kernel@vger.kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
From: Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/NUMA: don't pass MAX_NUMNODES to memblock_set_node()
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On an (old) x86 system with SRAT just covering space above 4Gb:

    ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xfffffffff] hotplug

the commit referenced below leads to this NUMA configuration no longer
being refused by a CONFIG_NUMA=y kernel (previously

    NUMA: nodes only cover 6144MB of your 8185MB e820 RAM. Not used.
    No NUMA configuration found
    Faking a node at [mem 0x0000000000000000-0x000000027fffffff]

was seen in the log directly after the message quoted above), because of
memblock_validate_numa_coverage() checking for NUMA_NO_NODE (only). This
in turn led to memblock_alloc_range_nid()'s warning about MAX_NUMNODES
triggering, followed by a NULL deref in memmap_init() when trying to
access node 64's (NODE_SHIFT=6) node data.

To compensate said change, avoid passing MAX_NUMNODES to
memblock_set_node(). In turn numa_clear_kernel_node_hotplug()'s check
then also needs adjusting.

Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node id assigned by firmware")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
---
This still leaves MAX_NUMNODES uses in various other places in
mm/memblock.c. Interestingly
https://lore.kernel.org/lkml/20170309034415.GA16588@WeideMacBook-Pro.local/T/#t
was a more complete patch which, for an unclear reason, looks to never
have made it anywhere.

--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -493,7 +493,7 @@ static void __init numa_clear_kernel_nod
 	for_each_reserved_mem_region(mb_region) {
 		int nid = memblock_get_region_node(mb_region);
 
-		if (nid != MAX_NUMNODES)
+		if (nid != NUMA_NO_NODE)
 			node_set(nid, reserved_nodemask);
 	}
 
@@ -614,9 +614,9 @@ static int __init numa_init(int (*init_f
 	nodes_clear(node_online_map);
 	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
 	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
-				  MAX_NUMNODES));
+				  NUMA_NO_NODE));
 	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.reserved,
-				  MAX_NUMNODES));
+				  NUMA_NO_NODE));
 	/* In case that parsing SRAT failed. */
 	WARN_ON(memblock_clear_hotplug(0, ULLONG_MAX));
 	numa_reset_distance();

