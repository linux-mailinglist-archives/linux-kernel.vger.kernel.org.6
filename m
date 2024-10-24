Return-Path: <linux-kernel+bounces-379152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821569ADABF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440B9282B56
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BD1EB3D;
	Thu, 24 Oct 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jlymsq68"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835A156F2B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742362; cv=none; b=u/+4FkM6tgEdUpem4v2AbULkLvPHdRBhnAPh8ZwNLs6kvYUNzvEV8AiAlpVu4tqBojN/zXe4RfdbzKEHGHZEDPokBGoo2ssur8MykDHuub1RUg3ottulrPWiOYFPTiYBeq/zrZYuKo2V4Bzam2AE+a8oBuz1Tq8X4td5XepSsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742362; c=relaxed/simple;
	bh=DK9kvLofXnQggoD4zXHgb6qSNT8DNnvHfWY9tb/klE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SaQ5yLHU8FFULYSDvAD9exU4kKcfgbVsCE3MwVMPyFAoVkHifjKtX03mYgKmPjN1tdljzQrgKOTZ2Cg5McgjTASwUpRpLCLfGi9xdPhG6ze8wlRpXg8JQsXBIWL8k+LzYbKgLSZ799Zy9BxGxGGjbnmv3sYUzTb6MshyO+CBamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=jlymsq68; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729742357;
	bh=/jN9f0RDBaZbD5WgikoRAFa/OR5++AgfVdHLbNCGRnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jlymsq68uuihBBn6NHG5RbifQBF5h16Q7Lu6y/VjdtNmIDrZljWgX4NdTWi1xXu5R
	 LBvuPNlstCN6AWl3lM1kfvKPDgt88rkznmwAkkkR6JXdsKo3SIN7oEjsNK2gGo5TWJ
	 iwr7ZS2Txe+ERnxiPFTfxu9dC39Xc1iDAAvUsV97tgXf5AKA1/gEeyAyMJgHRHTzBP
	 x6ytQrB1+95L1QrQb7v+6UxBOWW4fBIa3VijXwQcfnO5s9Mfw7QkR7GpqewHh3zlXF
	 sgSm3kh49VDoUZS1rqZdRBOYL62DEdDLi6Q43mmvpYvS/XMAOFT88dbhHofxVhYOhN
	 OHFn0siSSkidg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYsc419l4z4w2L;
	Thu, 24 Oct 2024 14:59:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
 Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
In-Reply-To: <20241023051914.7f8cf758@rorschach.local.home>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
Date: Thu, 24 Oct 2024 14:59:16 +1100
Message-ID: <8734km2lt7.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:
> On Wed, 23 Oct 2024 10:36:20 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> > To put it this way. The bugs I'm fixing was for code in linux-next
>> > where the bugs were never found. They only appeared when they went into
>> > Linus's tree. So why put the fixes in linux-next, if it didn't catch
>> > the bugs I fixed in the first place?  
>> 
>> Hmmm...
>> 
>> Your arguments sound very similar to those being used in recent
>> discussions about not posting patches for public review...
>> 
>> Please follow the process! ;-)
>
> What process?
>
...
>
> But pushing to linux-next for a day or two, what does that give me?

Several thousand build tests, across pretty much every architecture.

And a few hundred boot tests, lots virtualised, but some on real HW.

A single character typo in an #ifdef your testing doesn't cover can
break the build for lots of people ...

cheers

