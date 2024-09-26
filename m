Return-Path: <linux-kernel+bounces-340046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE47986DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BC7B2335F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96018FDBE;
	Thu, 26 Sep 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qJ1T80oo"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C65186E47;
	Thu, 26 Sep 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336795; cv=none; b=kmu6FNIhYzHpCZikTVwKUvO4CHAi+/tkNeMlvlM6ZW64Mi5eEWQqWThR3SHlEjr3tnuMLDr7fNjMIllfRGqQI++xJOcA1MIfZ9OZhZSgM/BCjmVzUjsowPzu+yaE7qlwlAV2qdHcci2oerILKHpjY+iv9wNfIJsHKLqtSHaWruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336795; c=relaxed/simple;
	bh=k5daxyw5dgBcLX3lcS28REaQRjV+ba1N+8xCEP6hh7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9kslp2Q7rZSyf1PdfyKifSfQx4C6x3pc1LbUdEJmat9aMZt2gH0MUlY77QXQNunaIYM5TavHDgwrmliQZaLq5547CcLKw9f4gMhxwsYLa0xWZswnYLBo+mD/zf/nLsWozPu5DwPpmYBFyXgCvoHI2C/9ytLEeCgjlt92PPLqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qJ1T80oo; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=k5daxyw5dgBcLX3lcS28REaQRjV+ba1N+8xCEP6hh7U=; b=qJ1T80ooP1ors58dxzYmUWDqVU
	+BgnE9C3YJP5aeFtokGXmaaiSUMxx4p2hycsji/zKjwvXpCvCmpMcWNFAS40k/Ler5dgdKfOx7WS1
	0exRRVt+O0O44XCxY4llRJwjaD2PiPlB04FE9BXQO1CyWzTNgDSjHKY82rzI4LyleTrCnvu2fhOfm
	28FaLj8Nv3xcuct4jRHOrWy69vuWiMy3p4Y0QdSl+gP2isAMVrl4pcBLZ1NrWqm463139oLVWRUqI
	0Y/TmERury7vcQ6EdNiHt+IiNbJeHBFLO03RZaL4AgduMjP71MNd7PGFfMcQDWZEnOsc6OBqx7m0B
	tg1BQO3g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stjCo-000Kzy-Tl; Thu, 26 Sep 2024 09:46:30 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stjCn-0001Ra-2f;
	Thu, 26 Sep 2024 09:46:30 +0200
From: Esben Haabendal <esben@geanix.com>
To: Erez <erezgeva2@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Erez Geva <erezgeva@nwtime.org>,
  linux-mtd@lists.infradead.org,  Pratyush Yadav <pratyush@kernel.org>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  devicetree@vger.kernel.org,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
In-Reply-To: <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
	(Erez's message of "Mon, 23 Sep 2024 18:31:04 +0200")
References: <20240920181231.20542-1-erezgeva@nwtime.org>
	<20240920181231.20542-2-erezgeva@nwtime.org>
	<4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
	<CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
	<D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
	<CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
	<D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
	<CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
Date: Thu, 26 Sep 2024 09:46:29 +0200
Message-ID: <87y13ehn6y.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27409/Wed Sep 25 11:17:07 2024)

Erez <erezgeva2@gmail.com> writes:

> On Mon, 23 Sept 2024 at 18:19, Michael Walle <mwalle@kernel.org> wrote:
>>
>> > > > I would gladly remove the obsolete mx25l12805d.
>> > > Why? I don't see any need for that.
>> > Maybe because we do not want compatibility table?
>>
>> I don't get this? Anyway, we do not remove support for older
>> flashes for no reason.
>
> I did not insist, you asked.
> Macronix stopped selling these chips 15 year ago.
> How long do you want to support old chips?

It is not unusual for embedded products to have a support span of more
than 20 years. And chips such as these flashes might not be entirely new
when the product is introduced. So dropping support for SPI-NOR flashes
that are newer than 25-30 years is definitely a risk. Somebody out there
might not be able to upgrade to latest kernel versions anymore, which is
not a position we should put anyone in. With the increasing pressure to
upgrade product for better security, we definitely should not make it
more difficult to run newer kernel versions than absolutely necessary.

/Esben

