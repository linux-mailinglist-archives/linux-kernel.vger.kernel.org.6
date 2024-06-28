Return-Path: <linux-kernel+bounces-234141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB2D91C2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA602281D29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989171C232A;
	Fri, 28 Jun 2024 15:36:59 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBCD1DFFB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589019; cv=none; b=d5M5cFSoApopPye1VFUQ6CQvKP6QusQ70bF8muFCUWIBMkifGpYXO0J3azoe72vtRhvCfOEz7D+gPSd6FNS2JQZlThrki8eC5vtjfYVj5crl2DOGvRevKKcXVmTFPMWt4JKsBVxw+eYVNfdQHAEG27Q3lk5O/zXl8kINof3+ZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589019; c=relaxed/simple;
	bh=otOPKDtW6h923+99umTlHrWcezjQ/e+aSNu2saC+mI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Ik0CA4mG8oX4rtS0rTHGZHwr3jX7YzsyV7xhrzKbzrptsqQcQUasyCVisB5hgVsZHTLv622867t/2VkZOjyOHxu0HTToNMR2o3KszmpelbtBlEL3XoKp0clMZWE9zz5QMZXrUnu9v6DUahOxwhBzPhrmMzZ8rDv+1exdQn7bO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-OFRDPytDPtSGaHTmtLLdBQ-1; Fri, 28 Jun 2024 16:36:54 +0100
X-MC-Unique: OFRDPytDPtSGaHTmtLLdBQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jun
 2024 16:36:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jun 2024 16:36:17 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Jisheng Zhang <jszhang@kernel.org>,
	Andreas Schwab <schwab@suse.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
Thread-Topic: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
Thread-Index: AQHax9S0vgwFN0Wui0OMQ/evgIcCmrHdT9IA
Date: Fri, 28 Jun 2024 15:36:17 +0000
Message-ID: <b4d15c17ed684f5ab3cf89fda9f73618@AcuMS.aculab.com>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org> <mvmikxvonjh.fsf@suse.de>
 <ZnwTwnSsnZ8Td9GZ@xhacker>
 <dcf9574a-0f1b-4131-befd-39f47d4f9002@app.fastmail.com>
In-Reply-To: <dcf9574a-0f1b-4131-befd-39f47d4f9002@app.fastmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Arnd Bergmann
> Sent: 26 June 2024 15:25
...
> If you just copy from the arm64 version that uses an
> "r"(address) constraint instead of the "m"(*address)
> version, it should be fine for any user space access.

Arm certainly has 'reg+offset' addressing and I'd have thought
the RISC-V would have it as well.

I'd guess that the compiler also knows when the offset is too big.

Probably noticeable when code is accessing structures in user memory.

OTOH I can't remember if "m" implies a memory clobber?
For user copies the memory clobber isn't needed and not having it
may well allow better instruction scheduling.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


