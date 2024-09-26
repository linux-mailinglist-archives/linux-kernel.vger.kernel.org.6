Return-Path: <linux-kernel+bounces-340405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D59872EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888861F25BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209315696E;
	Thu, 26 Sep 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0lMH6yYG"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69B347B4;
	Thu, 26 Sep 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350634; cv=none; b=BeNiV2pmr2ekI711YCtJFNwHK452l8roje4qkaeUBpvZJdyhzHTSJF8ffhkGdy6vnSs2lFQNNrUFwMVeNDkwTsZUDNT2b+v54UiUFNAqrHy/FHL3kG+BpZ25ikZIs1WIy20lB9EcR9y9Fe5Kqrw0dd+RlZP4WTPDNr9vvAGYxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350634; c=relaxed/simple;
	bh=27So1y0Tw3n5pcBmG73qYguDZqInIea/FrfW7bNIYYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=spm7cnYsrXV8B3bojxoEyTBlt7A6FB+vG3F0zlotvOFtPdfNByuEp871531ThqBc5aYiZacfnfNRvfEHo9zzpznNAhfvfEA6kT9IpCT8uXDiNKBBDe7lPoTlP92lnwUrReQLVLPlHlYJyWvSJjF7H8IT1vIWzUoRKnLOyL2O2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0lMH6yYG; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=27So1y0Tw3n5pcBmG73qYguDZqInIea/FrfW7bNIYYQ=; b=0lMH6yYGufwT291GnfQL9ss0KO
	Ko9M/L3VppDmvWSJOCi6U0wb0t/4WtNModopiUMIuylJdZZsuI+5Bz5P08MqU9ik4s8L3sEf0ql5B
	PymFOYnc+XoVRI3s7KvGaEvItySpmBkHSjA62c/O7TIVRBrmOdwQL/gUKcbqUW5vYlxopfhH8vwvn
	SEsAloNZWjj8HIsNV0fCwcTIbFLHVPDxjbFND8HdsSjUh73d0bbvAiP3aY+wH8zaJck4HN9vDv+fE
	UdamI+O2YqEoyB12DV2+e0M5hrdQiseBSLdjVcjlYdTc2+T6LefCwMUhIy36PGowOidog3nNADZpC
	5cddSqyg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stmnz-000AQH-NR; Thu, 26 Sep 2024 13:37:07 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stmnz-0005VT-1r;
	Thu, 26 Sep 2024 13:37:06 +0200
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
In-Reply-To: <CANeKEMMcZ+Y-f8Kty_4Nk-kRu+F7ZXBbxpAG1Bd_P1vcju1mUA@mail.gmail.com>
	(Erez's message of "Thu, 26 Sep 2024 13:08:59 +0200")
References: <20240920181231.20542-1-erezgeva@nwtime.org>
	<20240920181231.20542-2-erezgeva@nwtime.org>
	<4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
	<CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
	<D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
	<CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
	<D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
	<CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
	<87y13ehn6y.fsf@geanix.com>
	<CANeKEMMcZ+Y-f8Kty_4Nk-kRu+F7ZXBbxpAG1Bd_P1vcju1mUA@mail.gmail.com>
Date: Thu, 26 Sep 2024 13:37:06 +0200
Message-ID: <8734lmhcil.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27410/Thu Sep 26 11:30:46 2024)

Erez <erezgeva2@gmail.com> writes:

> On Thu, 26 Sept 2024 at 09:46, Esben Haabendal <esben@geanix.com> wrote:
>>
>> Erez <erezgeva2@gmail.com> writes:
>>
>> > On Mon, 23 Sept 2024 at 18:19, Michael Walle <mwalle@kernel.org> wrote:
>> >>
>> >> > > > I would gladly remove the obsolete mx25l12805d.
>> >> > > Why? I don't see any need for that.
>> >> > Maybe because we do not want compatibility table?
>> >>
>> >> I don't get this? Anyway, we do not remove support for older
>> >> flashes for no reason.
>> >
>> > I did not insist, you asked.
>> > Macronix stopped selling these chips 15 year ago.
>> > How long do you want to support old chips?
>>
>> It is not unusual for embedded products to have a support span of more
>> than 20 years. And chips such as these flashes might not be entirely new
>> when the product is introduced. So dropping support for SPI-NOR flashes
>> that are newer than 25-30 years is definitely a risk. Somebody out there
>> might not be able to upgrade to latest kernel versions anymore, which is
>> not a position we should put anyone in. With the increasing pressure to
>> upgrade product for better security, we definitely should not make it
>> more difficult to run newer kernel versions than absolutely necessary.
>
> I do not insist. Nor send any patch in this direction.

I did not say or imply that you did any such thing.

You asked an open question, and I gave my response. Nothing more,
nothing less.

> Each project can define the extent of backward compatibility.
> In terms of compilers, linkers and tools, i.e. build environment.
> In terms of standards like the C standard we use.
> In terms of network protocols.
> And also what Hardware do we support.
>
> There is no harm in asking where the boundaries are.
> All projects move their boundaries all the time.
> The Linux kernel is no exception.

