Return-Path: <linux-kernel+bounces-328647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718269786DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2211C221C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819528289E;
	Fri, 13 Sep 2024 17:34:18 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412F6BFC7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248858; cv=none; b=PUNuvWoSaHcjH/ApP8eoOHMrMSOBPLw/vk3ZmqIDCaWHrHvHv/Z2uaRXQbWmCiAOzU0qelMGUmUv1fThE3M/soew2OiQI3e4L+i5F5nv0V01wKgy5Hfv9RFM5x3+QFWy8SfQqpvhHClp8V722eTHkOP3zEf59tSM01PzrboM4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248858; c=relaxed/simple;
	bh=0QnHKOQHLDT/IlY9qNB4cRFWZs0vcUh4fiB2jsIAl1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2nsqh3hN3EUxDTI20ZiG6rdKgLlBHntqd0l4yxv5LW7RZlGMkYEz9X6Nv3dI8L+8edZbvutmdIBk3soH+WTD/MEG31KJPOzrHTZPQ11KvqkXrS1juD6fNNur1IndqN0dTsny6Ym5Xk65V7iy4D6f8MHLpgrHZRwXjlYWQBvCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1spA33-000000000Mg-17Jd;
	Fri, 13 Sep 2024 13:25:33 -0400
Message-ID: <dbed42dc3bc05fa772e11b54e93526a66698401f.camel@surriel.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
From: Rik van Riel <riel@surriel.com>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Omar Sandoval
 <osandov@meta.com>,  linux-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 kernel-team <kernel-team@meta.com>
Date: Fri, 13 Sep 2024 13:25:33 -0400
In-Reply-To: <ZqEY6ZIB7XThgKW3@pathway.suse.cz>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
	 <87plrcqyii.fsf@jogness.linutronix.de>
	 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
	 <87r0brkvqd.fsf@jogness.linutronix.de>
	 <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
	 <877cdilrko.fsf@jogness.linutronix.de> <ZqD54dcZUAirxTYg@pathway.suse.cz>
	 <871q3ix2zp.fsf@jogness.linutronix.de> <ZqEY6ZIB7XThgKW3@pathway.suse.cz>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2024-07-24 at 17:08 +0200, Petr Mladek wrote:
> On Wed 2024-07-24 16:51:46, John Ogness wrote:
>=20
>=20
> I see. I agree that deferring printk on that CPU [0] is the right
> solution.
>=20
> > [0]
> > https://lore.kernel.org/lkml/87plrcqyii.fsf@jogness.linutronix.de
>=20
Hi Petr,

we have been running with John Ogness's fix (from the mail linked
above) for about a month now, and it has reduced the number of
deadlocks in the Linux kernel in our fleet by maybe 90%, comparing
a kernel with the fix, to a kernel without the fix.

Would it be possible to get John Ogness's fix queued up for merging
in the printk tree, and then later to Linus?

--=20
All Rights Reversed.

