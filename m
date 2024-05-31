Return-Path: <linux-kernel+bounces-197116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC08D6668
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F741F262F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A96158D8D;
	Fri, 31 May 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/LLZrdU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3354784
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171990; cv=none; b=ONlrOghPwbvpBtSXC6jSDPHWiKgTgmJmFdN0+RuskC3IronlXcrgiRDfIDwnxVXZ2wE4OGz7hiwv9yDPJ7iVQi8XZruHGGnoR97nq3PNp0QzZduxs7HELbt6T34B3UTaSpTA0MI6YTNG9l4LNxWGjO9h4bCudReUSN1bXv2ko0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171990; c=relaxed/simple;
	bh=7T8wP/o3cgJtL1+OvLDrTpH/pVY43kVpMfxcGleEXLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXeIGMq2rXcvdNBkShzZXIY5uqWvmxjqogL1kQ8u7uqj3b1E+pex8q7MN8GzAz7Az3fVVbsSa+rYUUA9yjkKRQ2b16BBNpKw/mVSwlZsdbMQo9JVgZhMpQlsJGJdnf0CpuVHxN2Wq4O8ETNN6D5yjciKZytDJVdpnrfO3Gq/tpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/LLZrdU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717171989; x=1748707989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7T8wP/o3cgJtL1+OvLDrTpH/pVY43kVpMfxcGleEXLE=;
  b=I/LLZrdUpqsDCHcdWjPgqXCvoFKP2thpiyUKncxNzZCi8hySyO5C8Q6K
   bliXJxRmcXVwWrToQeT1wwjQM/4TUXTzx2q0cWuPp9VnQ9/rgoS+T97y1
   H1Fesk+l3Jlh2u6hfCmFLog7I/asv5FJEwAPUVB2OlyWzL/E4f16kQCm3
   4nJ+8DikJyy7wpom3P0w3VSU9aHlIwpB/bG9u3UsUlnYWxPilCj2Zwu2g
   UzD6XpiTvdcRp2cyiF9GL8d4rqe88PBaNuIv6bwv2le5drcrrf/qSBro2
   kf9CBinIvTja8+lRWB2nbYFqduB0+6ZzXzZedw6eEEW96ltIBVKdEYDxz
   A==;
X-CSE-ConnectionGUID: fgR4e2cBTQOTssMFv4a1aA==
X-CSE-MsgGUID: U1hyGYfXRviidNGCE9RqZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13590273"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13590273"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:12:43 -0700
X-CSE-ConnectionGUID: btdZbbZcSEKI3pzJF3+3JQ==
X-CSE-MsgGUID: hWvexQpLSeak9c2RRXYCzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="59384503"
Received: from uaeoff-desk1.amr.corp.intel.com (HELO [10.125.108.48]) ([10.125.108.48])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:12:43 -0700
Message-ID: <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
Date: Fri, 31 May 2024 09:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, david@redhat.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240531092001.30428-10-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 02:19, Byungchul Park wrote:
..
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..03683bf66031 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2872,6 +2872,12 @@ static inline void file_end_write(struct file *file)
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
>  	sb_end_write(file_inode(file)->i_sb);
> +
> +	/*
> +	 * XXX: If needed, can be optimized by avoiding luf_flush() if
> +	 * the address space of the file has never been involved by luf.
> +	 */
> +	luf_flush();
>  }
..
> +void luf_flush(void)
> +{
> +	unsigned long flags;
> +	unsigned short int ugen;
> +
> +	/*
> +	 * Obtain the latest ugen number.
> +	 */
> +	spin_lock_irqsave(&luf_lock, flags);
> +	ugen = luf_gen;
> +	spin_unlock_irqrestore(&luf_lock, flags);
> +
> +	check_luf_flush(ugen);
> +}

Am I reading this right?  There's now an unconditional global spinlock
acquired in the sys_write() path?  How can this possibly scale?

So, yeah, I think an optimization is absolutely needed.  But, on a more
fundamental level, I just don't believe these patches are being tested.
Even a simple microbenchmark should show a pretty nasty regression on
any decently large system:

> https://github.com/antonblanchard/will-it-scale/blob/master/tests/write1.c

Second, I was just pointing out sys_write() as an example of how the
page cache could change.  Couldn't a separate, read/write mmap() of the
file do the same thing and *not* go through sb_end_write()?

So:

	fd = open("foo");
	ptr1 = mmap(fd, PROT_READ);
	ptr2 = mmap(fd, PROT_READ|PROT_WRITE);

	foo = *ptr1; // populate the page cache
	... page cache page is reclaimed and LUF'd
	*ptr2 = bar; // new page cache page is allocated and written to

	printk("*ptr1: %d\n", *ptr1);

Doesn't the printk() see stale data?

I think tglx would call all of this "tinkering".  The approach to this
series is to "fix" narrow, specific cases that reviewers point out, make
it compile, then send it out again, hoping someone will apply it.

So, for me, until the approach to this series changes: NAK, for x86.
Andrew, please don't take this series.  Or, if you do, please drop the
patch enabling it on x86.

I also have the feeling our VFS friends won't take kindly to having
random luf_foo() hooks in their hot paths, optimized or not.  I don't
see any of them on cc.

