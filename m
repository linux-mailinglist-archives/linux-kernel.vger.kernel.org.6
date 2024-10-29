Return-Path: <linux-kernel+bounces-387054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9C9B4B36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881921F23E80
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27920696C;
	Tue, 29 Oct 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eTXqQqb7"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCD20695C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209688; cv=none; b=OsyMIg6qlQFbIsk/F3LYx9M43xgSABoz7ZYw4KUOgkwRyA/UVVrGSDZ5gtKI7vHOk17/vDezr/C5PUu2DbAhjB1IVpqcWoGMYPd+NJbj8UFCdlDZ1ufdQR/aiwCE7fecdk3JFX4lQi2ohFSA+1bKkY4fdcpOakFTfm1okrTBMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209688; c=relaxed/simple;
	bh=JLDvZFBK7WSrhlU9H2wgwxSGWriri+n1HXIbIOmRZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcyiLyXhP85vYmSBUAFtpvq54zAdrfMBmII+B6rYaDB0joxstgec623TjvuEeXTPPDJgQrEdfxy6dQj3qvmX04RjPPP5YWH4gMZX60fd2qVtAgOv7zsA7Id1LjcrB5KWz0hUQ3RKBfuIVbgCLVgEVaWKbFxhCoOXoPJ3e9/2jfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eTXqQqb7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbceb321b3so38956506d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730209685; x=1730814485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJhl9wZ9AWL6CVmzuzH8pXHXn+O89YeyWJRs5ZMr8IU=;
        b=eTXqQqb7uo7SQb/wHf6aQU+jZQ4LLQur/5VaLaMXB7SOi4iYZP26dSB5l4BjerMfsO
         kx0nOVLVDYl+LjHPSCxruhQY4JLQFTUvS8qsN5vo1pCaJMhCnVSwJRMw2CnC5vsq7nBY
         9AClc9rBliN9F3WeUwA2HlclTM2o141p2aY1mZ9gscrW9Jyh4DsKku9KZx7l35kXEO9W
         LXmKj30IZenbDmGxsq9YFuSUEAcMpM+BtsCfyjYS/XBZxob4sPcgN9MiOEgbLPXljiyy
         FtGhwQsZDvtopsJLmMxhneIHt+9PfhbXC4ViS1YErYw8WKhx1rriZlDhBewDrXHCwMw+
         9YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209685; x=1730814485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJhl9wZ9AWL6CVmzuzH8pXHXn+O89YeyWJRs5ZMr8IU=;
        b=KL/5luot5CxN3aSKA1X5jVxPA/IXRHLdn+O+pArMv82/kUVPbFLTfSdr/CSK9cTBbA
         W1BItTj1HSTQu3fV9B2DIbs6zUk6ZqHMOv0HwlqeqNjF/E+yxOuaQF9FLVwV6UU0hRYU
         geksgt1uy5gxb3Q579wNXqKf7bn8KsHcvDUTnDNHzQBKyUy3eXWPL0WB8Ff8KZnXnv+6
         llP5ItY6W5CSMNTSzBpXP1VvEjXLVGZE35b7MNHtjS1USGNgdFWN3udb1UGdNFY1epRJ
         hHAqcfugtZ4zH8hLw4eB0JknW8D7ovX4Grx80Ckx/V5N/tXiQbk9xIgyWEVovAwEZp3f
         nI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCULo1nlFSUn6+kI0UIqValeXuZb4SAmO1HXHJZnwf2zT9v0cZgGd0xdg9Bvb7T//OTVjCzJNAGiuNXjGss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5bsiKZtadQ9bHaakGsTvNJF676VH2Jdq3ZvCuqaKCIrTSKxS
	2PUopfo7hlPb9+rU+52SPf35zeVP9EVtLSbXWf/l1ljXAGtWxIo+zE5x/4S+HZ0=
X-Google-Smtp-Source: AGHT+IF1lxr/AwWP0mxrxyPW5aOTDNRVI3XBrynYC+n2D6sorX3YTs7nBHGQWhcBFP84eRt0Jrjj8Q==
X-Received: by 2002:a05:6214:5a06:b0:6cd:ef6f:830b with SMTP id 6a1803df08f44-6d1856c45c0mr175242366d6.21.1730209685260;
        Tue, 29 Oct 2024 06:48:05 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991c163sm41438576d6.63.2024.10.29.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:48:04 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:48:09 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-cxl@kvack.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rrichter@amd.com, Terry.Bowman@amd.com, dave.jiang@intel.com,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v3 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <ZyDnmUlXym7gDkCh@PC2K9PVX.TheFacebook.com>
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-3-gourry@gourry.net>
 <07102ea5-ee43-4c11-ab3c-a35cfce9003b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07102ea5-ee43-4c11-ab3c-a35cfce9003b@redhat.com>

On Tue, Oct 29, 2024 at 01:40:38PM +0100, David Hildenbrand wrote:
> On 22.10.24 23:34, Gregory Price wrote:
> > Systems with hotplug may provide an advisement value on what the
> > memblock size should be.  Probe this value when the rest of the
> > configuration values are considered.
> > 
> > The new heuristic is as follows
> > 
> > 1) set_memory_block_size_order value if already set (cmdline param)
> > 2) minimum block size if memory is less than large block limit
> > 3) if no hotplug advice: Max block size if system is bare-metal,
> >     otherwise use end of memory alignment.
> > 4) if hotplug advice: lesser of advice and end of memory alignment.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   arch/x86/mm/init_64.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ff253648706f..93d669f467f7 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1452,13 +1452,17 @@ static unsigned long probe_memory_block_size(void)
> >   	}
> >   	/*
> > -	 * Use max block size to minimize overhead on bare metal, where
> > -	 * alignment for memory hotplug isn't a concern.
> > +	 * When hotplug alignment is not a concern, maximize blocksize
> > +	 * to minimize overhead. Otherwise, align to the lesser of advice
> > +	 * alignment and end of memory alignment.
> >   	 */
> > -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > +	bz = memory_block_probe_max_size();
> > +	if (!bz) {
> >   		bz = MAX_BLOCK_SIZE;
> > -		goto done;
> > -	}
> > +		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > +			goto done;
> > +	} else
> > +		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
> >   	/* Find the largest allowed block size that aligns to memory end */
> >   	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
        ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Will pick this up but wanted to point out the silly bug above.
This version completely ignores the advise lol.

Changing to below

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 93d669f467f7..01876629f21f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1465,7 +1465,7 @@ static unsigned long probe_memory_block_size(void)
                bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);

        /* Find the largest allowed block size that aligns to memory end */
-       for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+       for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
                if (IS_ALIGNED(boot_mem_end, bz))
                        break;
        }

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

