Return-Path: <linux-kernel+bounces-232370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7891A7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A311C21095
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C27193099;
	Thu, 27 Jun 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bG7UAH9i"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8119306C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494866; cv=none; b=uwgyfZDVaSw5B9ePAoAhRuUMWfgg9vZkQx+PhQ/vFpzyBHH6J6oVcRME5zkL14Im0yUep3SrMr1Jwpo71bIFuXsPZhbjoqFRJZVzqx48XowXwnapctLAmCNoryWwqafz/uIa/UyM0MCi6zca1AAq/l2lW2vPTEgCuUlDO0o3rjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494866; c=relaxed/simple;
	bh=kX06knfCv/gt6mT0oVUy3WEeTxvHC7XIgKXJKIQTdbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZKFK+H2S3nUo/Kd5dvDFCk8o7DMhuNXTY0udOmPl+jQcF2iKPrW8qlmFHKJ4TqH+h8v1JNHHh2GUv/0qQYCSquFJBnPSKpCyR/iX7+vcuPwIJxEqPM+76JmODfanowh+cL+SnvX2rJ5+eB+4D7TbG/pVW9mJ8gR0yEE1LV2nI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bG7UAH9i; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45RDRRag003255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719494849; bh=uZGLgZhwM9jtPm0KxRYxzQQrAUIqexvgqygxsXy4rRU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bG7UAH9iIafu2ddZWZANjGFCObtveCTL6HwU6G1aRrSOwbHZkfz8CNDf3UkIiWGfr
	 f7VsVEatkYpU+oVcEu6GXEwP3WlNARSZs+06Pt/lodnOYBQ69bO9m5cb+y7yd10eL3
	 ahN5M6NqKWPPl4Wd6F/BuwFyu+ivqjjthvVNCZEIe/Kxfo49G8bTeuBERXHg3/+AAd
	 UwaMoA/JTH43wsx5zATm0vsbngmtQgMqYErPkvf6nSVvQcOvFiuGKEDn3i/zRYoNLs
	 KnVUz2Q6j4Ocj/rKboTOX8yeuc++NlCWAPC4vqRbomzScboucnLkzgU7AbbwiM+Eb5
	 enrd8cTJ9mIJA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 690DC15C626C; Thu, 27 Jun 2024 09:27:27 -0400 (EDT)
Date: Thu, 27 Jun 2024 09:27:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Henrik Weinstock <jan@mwa.re>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@mwa.re, simon@mwa.re
Subject: Re: [PATCH] ext4: fix kernel segfault after iterator overflow
Message-ID: <20240627132727.GB412555@mit.edu>
References: <20240627085601.24321-1-jan@mwa.re>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627085601.24321-1-jan@mwa.re>

On Thu, Jun 27, 2024 at 10:56:01AM +0200, Jan Henrik Weinstock wrote:
> When search_buf gets placed at the end of the virtual address space
>         de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
> might overflow to zero and a subsequent loop iteration will crash.
> 
> Observed on a simulated riscv32 system using 2GB of memory and a rootfs
> on MMC.
> 
> Signed-off-by: Jan Henrik Weinstock <jan@mwa.re>

This is discussed earlier and the conclusion that it is a bug that on
RiscV architectures the kernel can hand out the last 4k page in the 
address space.  As Al Viro pointed out on this thread[1]:

>On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
>>
>> As to whether the 0xfffff000 address itself is valid for riscv32 is
>> outside my realm, but given that RAM is cheap it doesn't seem unlikely
>> to have 4GB+ of RAM and want to use it all.  The riscv32 might consider
>> reserving this page address from allocation to avoid similar issues in
>> other parts of the code, as is done with the NULL/0 page address.
>
>Not a chance.  *Any* page mapped there is a serious bug on any 32bit
>box.  Recall what ERR_PTR() is...
>
>On any architecture the virtual addresses in range (unsigned long)-512..
>(unsigned long)-1 must never resolve to valid kernel objects.
>In other words, any kind of wraparound here is asking for an oops on
>attempts to access the elements of buffer - kernel dereference of
>(char *)0xfffff000 on a 32bit box is already a bug.

[1] https://lore.kernel.org/all/878r1ibpdn.fsf@all.your.base.are.belong.to.us/

In any case, if on the RiscV platform the mm layer hands out a page at
the very end of the address space, there will be **all** sorts of
failures, not just in this particular ext4 codepath.  So this needs to
be fixed for RiscV in the mm layer.

Cheers,

					- Ted

