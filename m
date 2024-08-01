Return-Path: <linux-kernel+bounces-271456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED1944E79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DC6B27067
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA21A7203;
	Thu,  1 Aug 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="ubqlIc4U"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502E198A10
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523817; cv=none; b=GYHNvCMP/HxYgNz133NxpHhuBNHWRVH/+zkRkb+4Sg7mYUDKyBEmt6njcFTfGO+gNzMmDftB21RSDLuBBI9GRsRChSW4Jta8uaBPr93hsxR3r4OFa97jQqf6VoRifSgBKj/eHWvT0gBhgd7kr4+neSk+GI4+gJeFNMzQvKhjYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523817; c=relaxed/simple;
	bh=VsrRe7YD+Y3zi7bzQF4a7Xlz++wdYLqwo77WaEuAhF0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZlpJ2QXn1pUDT4lwV0brV60S9UPp3hM5Py7J38zNeMqbKtjxtGI4SYMVFZnJKpd9fZeT+5fhyTC3WPRofJmNc3sc2xaJgGOhHn4PwzYKVHzIUq9kC7Na7NFFGRCVsw0i8u16yMkYnQhFv9fXpMauWfYe4I7eM35yKrOfeN44pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=ubqlIc4U; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722523812; x=1723128612; i=efault@gmx.de;
	bh=TQIDOm2FYH6dAx8TwTstvaPn9H5OK1NwCxk0rkjXhuY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ubqlIc4UpYQIxH96xGtkCswvcs0SWdEECP2yTdyb5rLyVoy9f8itknleqxIbDLVx
	 j62YAGfBAb1dnR1IvUqJt56jDqNaCsnu+jkrQNmkPY/d3Rh6rcLoKG3/nquNIIMjG
	 k9IQ67ldCCAR3gpuVlnEJAEFoixf/ESADeys+Fpm3tTSkUbIC705VvsvfxcVbgfL2
	 5BB+sVu6KaB7WTeyvcqSK3c7cDVKHZMbg8FbLmO0XnnOOuTFyRQaPAuF7Z8Zb5fPl
	 ctd68BlM7XuAFOF7wuqD+rwxkO8AXcr7rLaKf/lMehJvn7TytDgH4MdafyL1d28s2
	 Ia2gQET9FVtfEaQKPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.248]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1soSic1c78-00YlJ9; Thu, 01
 Aug 2024 16:50:12 +0200
Message-ID: <f3d4b89c752df94407f7becd37b45a3e418d590e.camel@gmx.de>
Subject: Re: Problems with suspend hanging laptop on 6.11-rc1
From: Mike Galbraith <efault@gmx.de>
To: Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Date: Thu, 01 Aug 2024 16:50:11 +0200
In-Reply-To: <CAH2r5mtNqn0i5NQSQvMvbHDdRDJxcNQh7iTj76L=90kEhDA7iw@mail.gmail.com>
References: 
	<CAH2r5mtNqn0i5NQSQvMvbHDdRDJxcNQh7iTj76L=90kEhDA7iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1iq07lUAupeBiROWDdKBZrk7nYbzn3lO5If6FJ+oSZILGcZz33J
 mKAua5RpNPMoBKHIFxff4YFQorEbeXK93SOHL3kbdff1SVrt3JfHi61wbUFjGTEjnag6Ml4
 zCFgGarfV4qQ6nKUVQBbosOGdET3wUqd2Pf74WBTYXuPgd5u0qerG0C4xz6YOfLWgx3o96W
 GIyOoJgvE1cjVlGzEnIug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fg/XZzExNZY=;A/9v2n8JekKiaH3AV/csfoMjLub
 RVUnf+XF6deMT8Xl3xXyfVCLxKFh7oOuKXwDBSxJCFDsjFiejavyUkDVHEZWHh6UrQYX8Xi74
 pt5DROkLu6hGctg3pmSu/apa5k8MNCJiMMOGOpUyxaKkmDeerKPhUebx1TOvqGXsQTlqN4amK
 KcfBDPgAgbyDgGSgjBh08LeVa4O5ghxNpr8Vdc6ajjGEQGwfzbvAjejQCT1TFtMbwcd4Rm7Q2
 uvKVyyBX/N31pkLNRPhsUG8/HZyYJl7COq9jAK71OFYKogNzTgjWWLufdCv8bSX++lc/Ej+ae
 jg3p5RZifH7HqRz+bVOpnxt4lyYpqxK8Ok5B57pgy2ZWjqLaghJIC8gTBZwjHDVebTcTM+E2O
 1uv5dsmhZs4v17O+tQaZdnpa6bhUd4NOb3JPzU50Z+whlhqURTeHcxXz4luzK6zLiyUjE4aQr
 7eiCd8ar1jNmrlR8M0x9CXXBQio+67GivNqBQRLazQ8lSOlHYRUvG1nOzWzdRnzcqnUEbud86
 RIWiRFk6p52XVybjN2WR8ixDs7Errt/gWREUx1sLBdbs/bGTPVlsSbaDLgMx7nwHK7pz+AuC8
 aQQUKOqc2faLpJrkVYUc59iNfshOb5l5nk/cMGOxBEblASQN7RTxp5u35wPJtAZOJhYleuwvl
 DrfFoA6fR/ASYuJcEGMEeaiS+B85bwXQnQyLBTUOgv8t0H12oTky2HEEs+389I5jIKOH9MR/K
 C+6AZLbSMan0GNLmVDN7AcTX0hGIXyZmUO0s1mvvkfU3jhoAdJBJhDVIlrMsBqCOoU7sDyYso
 TIj3Ve7zTQMYodQy3p+sc+3w==

On Tue, 2024-07-30 at 10:11 -0500, Steve French wrote:
> Has anyone else noticed suspend on 6.11-rc1 hanging the system?

Yup, my Nvidia GM204 infested desktop box (using nouveau) has it too.
Bisection wandered off into lala-land unfortunately.  I'll try that
again when I find a round-tuit.

	-Mike

