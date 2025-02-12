Return-Path: <linux-kernel+bounces-511378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C681FA32A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D8D166AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67338211479;
	Wed, 12 Feb 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A44NwY/p"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EB20458B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374572; cv=none; b=N/qG8Qfc92sV1zp9Od4bzYd2mqEgjslrZ4C5j7AMcjCe233iCQd5LYk7P7RkyZ2NuCoRzfi8VA9WCjJ6R0MQJ5EvF1KhksenKYd0blHEAxlMl/6jZKXME8RbZ9XexMZGp+/YF8u4f6KBEVVhF9R8OuQlmqV5FgUEi1u/Mg2wk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374572; c=relaxed/simple;
	bh=+Tzx4+KyqshAIUUjHQSlcoeIY23ROGdp3acnNuX+0WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHamCmpbZNOkRj7CjRHstNtUd/9D4sQ3CtXLFEJI3m+rIqXnPWKnDzHyh9XQkgX5RKIhR0OANNXii8liQdbHgqJDVoGPHvx0qmyAU0r5fTIUXk8YJHbTW6RlsOJgm3idFMX1Mt+Ps1j6H/t79FwkSBPGJiPH/pk3S3AfpWAVLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A44NwY/p; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Feb 2025 15:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739374566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Unmtqq3rbJGV4I/h1riYDozrdTcvq+CZZyEIdT7M0DY=;
	b=A44NwY/phhv2iAkDHNJxCRG3J2jgmc0nEfYGep4VdQA0wFOE3jUri8IMVCArvBlhRHFcmv
	nNtWdGEilhtXX80TGd/erLK39H0KQ3Ti5d1ImN0++SPGn8NYqpGkVVvH3C9HtJJFqE/Wcb
	9QEsS4nty91DxsWTr0JFJTyhmWaC13s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <Z6y_3xS_8pmZ2bCz@google.com>
References: <Z6Ew9AWNHacRIfhA@google.com>
 <lxottj72e7jcqw634qwudpsyqckfrvpmlhra43en4zlrlz4cip@erufv6w4n5j6>
 <Z6JMIKlO9U5P-5gE@google.com>
 <6vtpamir4bvn3snlj36tfmnmpcbd6ks6m3sdn7ewmoles7jhau@nbezqbnoukzv>
 <Z6O2oPP7lyRGXer_@google.com>
 <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 02:00:26PM +0900, Sergey Senozhatsky wrote:
> On (25/02/07 21:09), Yosry Ahmed wrote:
> > Can we do some perf testing to make sure this custom locking is not
> > regressing performance (selfishly I'd like some zswap testing too)?
> 
> So for zsmalloc I (usually) write some simple testing code which is
> triggered via sysfs (device attr) and that is completely reproducible,
> so that I compares apples to apples.  In this particular case I just
> have a loop that creates objects (we don't need to compress or decompress
> anything, zsmalloc doesn't really care)
> 
> -	echo 1 > /sys/ ... / test_prepare
> 
> 	for (sz = 32; sz < PAGE_SIZE; sz += 64) {
> 		for (i = 0; i < 4096; i++) {
> 			ent->handle = zs_malloc(zram->mem_pool, sz)
> 			list_add(ent)
> 		}
> 	}
> 
> 
> And now I just `perf stat` writes:
> 
> -	perf stat echo 1 > /sys/ ... / test_exec_old
> 
> 	list_for_each_entry
> 		zs_map_object(ent->handle, ZS_MM_RO);
> 		zs_unmap_object(ent->handle)
> 
> 	list_for_each_entry
> 		dst = zs_map_object(ent->handle, ZS_MM_WO);
> 		memcpy(dst, tmpbuf, ent->sz)
> 		zs_unmap_object(ent->handle)
> 
> 
> 
> -	perf stat echo 1 > /sys/ ... / test_exec_new
> 
> 	list_for_each_entry
> 		dst = zs_obj_read_begin(ent->handle, loc);
> 		zs_obj_read_end(ent->handle, dst);
> 
> 	list_for_each_entry
> 		zs_obj_write(ent->handle, tmpbuf, ent->sz);
> 
> 
> -	echo 1 > /sys/ ... / test_finish
> 
> 	free all handles and ent-s
> 
> 
> The nice part is that we don't depend on any of the upper layers, we
> don't even need to compress/decompress anything; we allocate objects
> of required sizes and memcpy static data there (zsmalloc doesn't have
> any opinion on that) and that's pretty much it.
> 
> 
> OLD API
> =======
> 
> 10 runs
> 
>        369,205,778      instructions                     #    0.80  insn per cycle            
>         40,467,926      branches                         #  113.732 M/sec                     
> 
>        369,002,122      instructions                     #    0.62  insn per cycle            
>         40,426,145      branches                         #  189.361 M/sec                     
> 
>        369,051,170      instructions                     #    0.45  insn per cycle            
>         40,434,677      branches                         #  157.574 M/sec                     
> 
>        369,014,522      instructions                     #    0.63  insn per cycle            
>         40,427,754      branches                         #  201.464 M/sec                     
> 
>        369,019,179      instructions                     #    0.64  insn per cycle            
>         40,429,327      branches                         #  198.321 M/sec                     
> 
>        368,973,095      instructions                     #    0.64  insn per cycle            
>         40,419,245      branches                         #  234.210 M/sec                     
> 
>        368,950,705      instructions                     #    0.64  insn per cycle            
>         40,414,305      branches                         #  231.460 M/sec                     
> 
>        369,041,288      instructions                     #    0.46  insn per cycle            
>         40,432,599      branches                         #  155.576 M/sec                     
> 
>        368,964,080      instructions                     #    0.67  insn per cycle            
>         40,417,025      branches                         #  245.665 M/sec                     
> 
>        369,036,706      instructions                     #    0.63  insn per cycle            
>         40,430,860      branches                         #  204.105 M/sec                     
> 
> 
> NEW API
> =======
> 
> 10 runs
> 
>        265,799,293      instructions                     #    0.51  insn per cycle            
>         29,834,567      branches                         #  170.281 M/sec                     
> 
>        265,765,970      instructions                     #    0.55  insn per cycle            
>         29,829,019      branches                         #  161.602 M/sec                     
> 
>        265,764,702      instructions                     #    0.51  insn per cycle            
>         29,828,015      branches                         #  189.677 M/sec                     
> 
>        265,836,506      instructions                     #    0.38  insn per cycle            
>         29,840,650      branches                         #  124.237 M/sec                     
> 
>        265,836,061      instructions                     #    0.36  insn per cycle            
>         29,842,285      branches                         #  137.670 M/sec                     
> 
>        265,887,080      instructions                     #    0.37  insn per cycle            
>         29,852,881      branches                         #  126.060 M/sec                     
> 
>        265,769,869      instructions                     #    0.57  insn per cycle            
>         29,829,873      branches                         #  210.157 M/sec                     
> 
>        265,803,732      instructions                     #    0.58  insn per cycle            
>         29,835,391      branches                         #  186.940 M/sec                     
> 
>        265,766,624      instructions                     #    0.58  insn per cycle            
>         29,827,537      branches                         #  212.609 M/sec                     
> 
>        265,843,597      instructions                     #    0.57  insn per cycle            
>         29,843,650      branches                         #  171.877 M/sec                     
> 
> 
> x old-api-insn
> + new-api-insn
> +-------------------------------------------------------------------------------------+
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |+                                                                                   x|
> |A                                                                                   A|
> +-------------------------------------------------------------------------------------+
>     N           Min           Max        Median           Avg        Stddev
> x  10  3.689507e+08 3.6920578e+08 3.6901918e+08 3.6902586e+08     71765.519
> +  10  2.657647e+08 2.6588708e+08 2.6580373e+08 2.6580734e+08     42187.024
> Difference at 95.0% confidence
> 	-1.03219e+08 +/- 55308.7
> 	-27.9705% +/- 0.0149878%
> 	(Student's t, pooled s = 58864.4)

Thanks for sharing these results, but I wonder if this will capture
regressions from locking changes (e.g. a lock being preemtible)? IIUC
this is counting the instructions executed in these paths, and that
won't change if the task gets preempted. Lock contention may be captured
as extra instructions, but I am not sure we'll directly see its effect
in terms of serialization and delays.

I think we also need some high level testing (e.g. concurrent
swapins/swapouts) to find that out. I think that's what Kairui's testing
covers.

