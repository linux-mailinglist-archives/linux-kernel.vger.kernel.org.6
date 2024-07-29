Return-Path: <linux-kernel+bounces-264968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AAF93EAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604BC1F21D17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366377F1B;
	Mon, 29 Jul 2024 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8Up7+78"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130014293;
	Mon, 29 Jul 2024 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217611; cv=none; b=gO3xLemKTczONTS+FN78sgtyR7Ur83AK3SjykBKrSwCB+KiJP+deRbo9JxZ7ny4OKwiG68DhAkvJAyyWJBb+iIzyVyxXHRwfMTCglvHz6UBeepV+0ynbVjjAgXfnCMA8tIf5YHOQw4w2AsF2I90kZWvKvUnhZ4oR7ehaBJfWQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217611; c=relaxed/simple;
	bh=lZuGlOIc3eRYuViK94AAOvBgXPuSdxIjwVbfAN91LpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVo+FlPzMNR3sM/vfTScOkJvRf6/J8h1uZYV59X8c0o+R4lGUCTrqxRcZzdjY5nyjiSf8UmXRkFwzUQ65Z/Pkq3+OLF2VWjrsOIp2SSf9gJ4i5StRAWVYdc7EDkWN5WKfRdW8edfs8V26kechPW0FILAoY2gWzeMTR0/KHIP+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y8Up7+78; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722217607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iniOVG3gmXmMx4OmearIZzDrv6mcb+oZJZnr0nrBNk=;
	b=Y8Up7+78RpdUjqbjHPIQbw7hf77OpaqpA9PDUsezW/ro4XhuCufC4VK4aP2RwSJRPwTwsC
	S/vrbNHe1FA73FXDSpRwZ66++fonyUl1SSO3Qm6B5fDoDpGdfIU66/JbZwbvQch5bcs38D
	+kQgibNyS71FQyvlL8ltJ5K88WOu72Y=
Date: Mon, 29 Jul 2024 09:46:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
To: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
 David Sterba <dsterba@suse.cz>, Arnd Bergmann <arnd@arndb.de>
Cc: kreijack@inwind.it, Luis Chamberlain <mcgrof@kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Youling Tang <tangyouling@kylinos.cn>
References: <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org> <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu> <ZqPmPufwqbGOTyGI@infradead.org>
 <20240727145232.GA377174@mit.edu>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20240727145232.GA377174@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 27/07/2024 22:52, Theodore Ts'o wrote:
> On Fri, Jul 26, 2024 at 11:09:02AM -0700, Christoph Hellwig wrote:
>> On Fri, Jul 26, 2024 at 01:58:00PM -0400, Theodore Ts'o wrote:
>>> Yeah, that's my reaction as well.  This only saves 50 lines of code in
>>> ext4, and that includes unrelated changes such as getting rid of "int
>>> i" and putting the declaration into the for loop --- "for (int i =
>>> ...").  Sure, that saves two lines of code, but yay?
>>>
>>> If the ordering how the functions gets called is based on the magic
>>> ordering in the Makefile, I'm not sure this actually makes the code
>>> clearer, more robust, and easier to maintain for the long term.
>> So you two object to kernel initcalls for the same reason and would
>> rather go back to calling everything explicitly?
> I don't oject to kernel initcalls which don't have any
> interdependencies and where ordering doesn't matter.
1. Previous version implementation: array mode (see link 1) :
    Advantages:
    - Few changes, simple principle, easy to understand code.
    Disadvantages:
    - Each modified module needs to maintain an array, more code.

2. Current implementation: explicit call subinit in initcall (see link 2) :
    Advantages:
    - Direct use of helpes macros, the subinit call sequence is
      intuitive, and the implementation is relatively simple.
    Disadvantages:
    - helper macros need to be implemented compared to array mode.

3. Only one module_subinit per file (not implemented, see link 3) :
    Advantage:
    - No need to display to call subinit.
    Disadvantages:
    - Magic order based on Makefile makes code more fragile,
    - Make sure that each file has only one module_subinit,
    - It is not intuitive to know which subinits the module needs
      and in what order (grep and Makefile are required),
    - With multiple subinits per module, it would be difficult to
      define module_{subinit, subexit} by MODULE, and difficult to
      rollback when initialization fails (I haven't found a good way
      to do this yet).


Personally, I prefer the implementation of method two.

Links:
[1]: 
https://lore.kernel.org/all/20240711074859.366088-4-youling.tang@linux.dev/
[2]: 
https://lore.kernel.org/all/20240723083239.41533-2-youling.tang@linux.dev/
[3]: https://lore.kernel.org/all/ZqKreStOD-eRkKZU@infradead.org/

Thanks,
Youling.

