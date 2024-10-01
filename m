Return-Path: <linux-kernel+bounces-345696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E798B9E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063FD1F23754
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2981A0B09;
	Tue,  1 Oct 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="u5NwNnAu"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723241A071F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779366; cv=none; b=B8LQ0K3oGP5B9TFpOzMl7PvKXiTxbuyndv6OTO1klOoE0evj/nQBf/3t6+ADEnwAHrrMzhDSDAa84UWTzhAV2D0NScltsIl0qaoBV7P12UmL/IXNcFQXbsU3aQXJNcmOzEqnM7GoZl4R8jkwsFwJlWU4VRb5ab9HfYsOWWAxkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779366; c=relaxed/simple;
	bh=nKxeZAW61llLUgTTk+EqQlCkMBf2Rfu2A0YoNb970Eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8xPkcBBSTTgaxfCzIrPVLBb8dTy1WIyFGApzGPI7NTz43TQOi04GFBivYrHGva101x7rz4rxlAmqF0jQi0j4mzA6V7kPSmusKn3E9wJrLkOdrFZf0hoKsk5zO5TqyKQqos3y1My6LAK7aooN2flkVonQzBt7iHs0QK+LN9VYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=u5NwNnAu; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727779354; x=1728384154; i=spasswolf@web.de;
	bh=nKxeZAW61llLUgTTk+EqQlCkMBf2Rfu2A0YoNb970Eo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u5NwNnAurXP9xuTp68I5E8JoY/C/Ac00FLrDMtjWVX0+knDpHn3BjSXjcbQSH9ct
	 Y2PcpIRSVCwl2DouEL3kaDwrMx4FzIHca+6rzhJlbpl7vquU9/pWKO6dxNAUJDH5z
	 vipoTCY4Ox1DUUelUAJ3z8R4mMIshcQjqJ427ptGg3Sf4sIVqim2mDhz0+3hQ1wZ6
	 YtUoBZ5S5h8A28Y7YE8CG/kc+JdYpzBSU8JIqpazMxrU76ULWX0sbe2AvN66YcUxE
	 AhmkqNDGfQwXJ9CXZuGpAjt9cTh/ERrcQwZCFtzkFXe9jLN+mDJQjOL893XarRIFj
	 eqCp5d1u1MC4zQXlQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1rqqhU0EJW-017Y55; Tue, 01
 Oct 2024 12:42:34 +0200
Message-ID: <2933d931be9904d2e63cb419d190d2b3d17ff27b.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Tue, 01 Oct 2024 12:42:33 +0200
In-Reply-To: <ff1c8321-3830-41a3-abe3-6b32a4f72238@lucifer.local>
References: <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
	 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
	 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
	 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
	 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
	 <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
	 <386f485c-5dec-4c7c-81f8-a23aa98a72e7@lucifer.local>
	 <0e9eb75f6342a7aaa1fd0eee3dcbbb15fb1f6539.camel@web.de>
	 <81235f36-7266-4ce0-8175-7c4d0e6ae3de@lucifer.local>
	 <dac4dd705b0c5084cdc15b3bae4d363bc6448544.camel@web.de>
	 <ff1c8321-3830-41a3-abe3-6b32a4f72238@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tZb+NWKziPJmZbyL0E6utr9R/zY6piDjZEeAQuuezbwxI4u2R8d
 R7AyElP4hoHpLAqHJTkXxZkG9dsgy3DahFWHQPRyvnk2lg4Fx0yPkEWYTDPIDGSVvr5IX66
 B3I+4oZO4rLPsvtMglBSNoeOSC0iJUsA2Da4qZTGfKBSsD3B6uccrEhSjoo954i+IfxjDTT
 ioEkRJSHSrrkbjKgpEWHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oj6RZCMAgOs=;PzrhoXs/ohZLHXdAoaMgzH1inMj
 Q1buLZD/q/MNJseZcXQo2gMwydsjH+iyByTrvWm7HAAo5DAmn9qXgY24kw5TAj24+8QNnyNUy
 RA3GVtEYFqsxToOkXI2qlmZLRoJHtJ8O3osMmEaELTulci2/eaXsZ0hXtJBYyDMyEJOVn90QI
 +23huaLV0ScIXb0XjDUcMpwufBCIP+g16KMzu9F9kaQCYnJkvITPQX/kUhfwCcdR98iKwkVhz
 8/+BLhfAY31av6j8vi+yVxJ/yuVsyiRtpriPhCPsquYpcMf3mpEBAGmADXAVfapbM9813NLem
 T5dJGIEkLgvsueg5L3hp+g5btphyeEN/nIC4/M+3VNfC7EOfaPNxfiMLGUv9T46ehIkpFaEuG
 aR2VS+2PsBNqjkDpZVbWZen2bs2pVb3cBHm8x7u3jbsu7ixoJX07BZrk6FKySW/25LgWG/cC2
 1FBuKHwrMClU3+6bT3bKfBr6oFs9CaMIw538Bx7cYVdRdgWAsJObgf0g6Wsx+enbYq4iUaNeE
 Ysf3OCpbaAdfXpeDNhf2GLFIoUGBL+AbG9Ap1K8irv4m2uNrxl6XnOelChaELQe0736tCntfb
 GFLwy4AFyE839JL8IibsBxsQfm5LBbvzrzp0QMZczqOvjfrK7mSqxUNXLHBTAIvpIaKXPjf9j
 to70fj7BQhiXGlA081kZzK7RZfGUcV9Os05s9FHGfOFqflIlxKeO7hkgYGFUBgy1AMfIiX25k
 +nIiR2SDPofEnL/Zozob5eg5tlIB2fhvoDP7t4GXWSM6fY7apz8gl335+K0mArWoZ/BQssG73
 leF4o6bmy/c37B5l3Vir3TMQ==

Am Dienstag, dem 01.10.2024 um 11:33 +0100 schrieb Lorenzo Stoakes:
>
>
> OK so what is less perfect is this looks very genuine and present in rc1=
 so
> yeah.
>
> Thanks so much for helping out here - I may ask you to try some patches =
if
> that's ok at some point?
>
> Cheers, Lorenzo
>
Yes, that would be ok. As a sidenote, when I first got this bug I conducte=
d an
internet search and found this vaguely similar report:
https://lkml.org/lkml/2024/8/28/1558
The report says its from 6.10.0, that would be not related, but at least f=
rom
the date it's possible that it could have tested the v7 patchset.

Bert Karwatzki
>

