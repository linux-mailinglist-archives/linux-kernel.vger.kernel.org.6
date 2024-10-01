Return-Path: <linux-kernel+bounces-345576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A198B7AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9C1C228AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F719C568;
	Tue,  1 Oct 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="I0KfW6Hp"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331E19CC01
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772972; cv=none; b=oTyWQNfJKV/lws4aF7gZL5gFzReqrmRQCW8Kwg5QAgqwSR5+Q2b1WX2QOZfaafiwSE12RpzOLV8tqfLSbB6dmAqtih4rJgpLjqcEQXp5dx7l8fvDMcgtNyShXZLiVCjQwye8211S5iQp6snSX1upXFDV97rrPTprMOm9NOl+Mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772972; c=relaxed/simple;
	bh=tVv2ClH1fRs9RHxNXTRsm3ta+zB688zvoqlYfxP9EjE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GqP/NOOOBIRR6jyCsrzTODkQjeuDH9XsKwvISGPYVO6fNA8BRpCWUVIpUYJb5kxBLrMRZVzR2Ne6FW2tgLefn3bIPeBumfsq3LzGAmCQOHVQijJe05tem/HZu2aTq5Nj82WA6hlfLKIVAgq/VGFQPP53sq9Qin6FjVz5eQ4aLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=I0KfW6Hp; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727772953; x=1728377753; i=spasswolf@web.de;
	bh=IQ8aAOXVvPG2w6pGbPO+lHRFmDxKvrde6ZxtX3udcag=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I0KfW6Hp6n6aiimTqR0dMUE8OzBh7wMhHxIINcDJEo3OUDtYVwfYfI/zC3jVlMa3
	 flRT88iM7TQo1YG9I8sVRZFyBke1oQIBbC5TaQKhz5DW+deqcJLF6GV5z/kjHTT+i
	 +k7lZ5imSt7Jcsab5ocsro67ZzzpbtN+JVVQETn8SR6OQyMRHxnfA1+K4arK0rI3H
	 hNwnWMa7PDPSuxr9i5FMTtjEnpMoZW1+SEftr/8ZdGLGQPQPAwoPHge+ZBeYbsMCk
	 5PhQXCdtKWl1m7NN7wUpKcx6IihMKxWL3b7qrup4uWop/dSWj4qcN7qvGLO7E59+T
	 u+oCh44JZhLf5yYLkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1sN3Ge0IY1-00dJOI; Tue, 01
 Oct 2024 10:55:53 +0200
Message-ID: <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Tue, 01 Oct 2024 10:55:50 +0200
In-Reply-To: <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
	 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
	 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
	 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TyPoOD1ixR1UtfwWhB/aWiK41JgsCtNfNB4l3EHMZSfqUbs7fT8
 tfLHg5SCgYvfbtuXGesW2uWwQkYjOyxNzBShZv43YZmfQGW7cbkktJUXYCeZXkro07FnsG5
 EZa9pSccAqg30+ZUAFD4iFdlJoJ36Wqu8UDEi5cLwCgOLIQ6QVDBN2ZgTnQ2vJF2zbxPuWo
 sDrTGZr9Fljy5mQ5ViChw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fi1c9mVIolM=;+B4n6D1kUiMk+q9Thqa9/7/ZkfF
 hSRFyUewHeMl/6SKQ2CzLa94n4yR7FGmkXwpnGbL+GL1o/FUpZcr6ekc36wLwPZc/evfHAU80
 F8gImp4XWKEhkrD5Q/Fm89Af3AR7IwXFaBTbEqfIqYU5K4vuwJUrBwEf1ZZMtRr+1FrYNenjp
 XDTNu3AGHs2ysQi4dSeskJS4ygW8tqJ2qCiMS5Vp3cuI/X5ZMuyx7a0qTy7/FV2K5fto1bIVp
 HBsjsIxYMu5lqOXOr4LE6kUM5nOSXvNcpNymsaC0164uX74+04jFERiB1EZUZwspC9bV+pGN8
 GO6nCtb7W7hAvn/gha/PL7Rxdw+f5jdFdvAvbMQMyFTRsGaHqGCJClKkkcySW8vwihjhPcZzM
 XdQk0kbEnKB2cil8gS0nYMfZDSR/lBf6vmnPPGknkGwDBd5Uv7LB1gWkjvQiDyd45q2sJTwNd
 2vchW+Vi6j8z0Y8ms/wLmsvW3/WaCBzLQKVgv3dqSUP3WDUp7NARPyTlvM2r4HBCIOYCvfHUr
 vUwnodD6aul8FCiB22+1A5I5TaB9NbVp4sIYYYH+o/1jmykEjewCBkSkLx94y3aJC44EOmwPM
 LFJWN9KItwiE4R7s43CUZW537LNJ6czwMPKTLj/iGtUt2GvEycCaiwY2tQXnanULBffS6MefG
 TE31/hizPJDxMBLiI3mZJtskxNV5cmEwHuea31aVYSugW3yjOcorU8MjBMrwiqvbs4MPQo6Ji
 IwDRkKg6A4y/kaPXknlsK7fEVxFsMcKdg2ApHLxVGRLdqPPK5el7UOC2iL8RPkWuduhugTKM1
 tasljKfE/JfP7dTHerMyQe0w==

Am Dienstag, dem 01.10.2024 um 09:49 +0100 schrieb Lorenzo Stoakes:
> On Tue, Oct 01, 2024 at 10:38:35AM GMT, Bert Karwatzki wrote:
> > Am Dienstag, dem 01.10.2024 um 09:02 +0100 schrieb Lorenzo Stoakes:
> > > On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > > > I just noticed (via a bisect between v6.11 and v6.12-rc1) that thi=
s patch
> > > > (commit f8d112a4e657 in linux-next tree) leads to a severe memory =
corruption
> > > > error under these (rather rare) circumstances:
> > > > 1. Start a 32bit windows game via steam (which uses proton, steam'=
s version of wine)
> > > > 2. When starting the game you the proton version used has to be up=
dated
> > >
> > > Yikes. Thanks for the report, very very much appreciated. Will look =
into
> > > this as Liam is out until next week.
> > >
> > > How repro is this? Is it consistent?
> >
> > Reproducability is 100%, only the method is weird, you have to switch =
to an
> > older version of proton in the steam settings of the game, start the g=
ame and
> > then switch back to the new version and start the game again.
> >  It might also be possible using standard wine and repeatedly upgradin=
g and
> > downgrading wine and (I have not tried this, yet ...)
> >
>
> OK that's good.
>
> Actually a quick one if you have a sec - could you try the same thing wi=
th tip
> of Linus's tree?
>
> This will help eliminate any other possible cause.
>
> Thanks!
>
> >
I first noticed the bug unsing linux-next-20240926, it's also present in v=
6.12-
rc1 (hence the bisection), but I can try linux-next or linux-torvald maste=
r,
too.

Bert Karwatzki

