Return-Path: <linux-kernel+bounces-340076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF282986E55
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F4281338
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31AD18C930;
	Thu, 26 Sep 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MnkqGAyu"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B8158DC0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337409; cv=none; b=lz6Vk9R03T/15+fkzFUVI3fKpaQa0Ge7bhukPOLunuiEMUHXQNE1gW4vIck762GEhWG5GFKjdAZ69UQd6b/ddwITRZBFtYEPjw+DmBpOP4Nc7aBfJZ60HslO6p3yo9nzMBh7gOgepSr1GupXnqaQZilPU4qSx4f5Yr6Kh/GPoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337409; c=relaxed/simple;
	bh=6R/Ua2GrAH615KyDfF7MwLoRuy3a4TAVfGfL7whhFyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q1O+iJv4L44mGQt1Jg2H3oqvP/iEBLP1DTNuTm29ItaNmEHexto2j8AVkbrruQkEDE4hjWD+nJYnaTQPpQLZebzHpqxdYNPtDjg71HYJQsdtBZkE6SK+FwqJZmm31L2QGAEFSHPJErKdrX1NzNP4oMGqkemFoNPZXQXVNLfebns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MnkqGAyu; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6R/Ua2GrAH615KyDfF7MwLoRuy3a4TAVfGfL7whhFyg=; b=MnkqGAyuZlHNMUlIqkgnqBiJtG
	yZW1ZzdcumkCvskeg/4C1dXQHkE5C/KV6LQfkP1ZE4QuT5/0bpCNgDUu9OH4ACw2vt1xbXsraDl38
	vDPX8/vxhbmFYGjoz5YkkRxR/B9+EhGArLBY4PNNcFuAr+aZ3W+Vn3RDFnPnDSIxVQULQeYWQ+EN/
	xE74VNtlLzuXG886XZd0c8mjhykb0gaEWFoG9tCgvvCfCqdYRhZSZo08vYfyboDTUeDhGbFtM2Lx7
	zlpjPMXDGSaoBbj4nfgDQJbASLJ6kPInXaGlCILvC/M9kZMVdsWXIaKO52Px8rkZLuBNsrUsAWOp1
	kAo0HSlg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stjMf-000MkB-63; Thu, 26 Sep 2024 09:56:41 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stjMe-000MMl-0M;
	Thu, 26 Sep 2024 09:56:40 +0200
From: Esben Haabendal <esben@geanix.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  "Nicolas Ferre" <nicolas.ferre@microchip.com>,
  "Alexandre Belloni" <alexandre.belloni@bootlin.com>,  "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>,  <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device
 id re-use
In-Reply-To: <D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org> (Michael Walle's message
	of "Fri, 12 Jul 2024 11:55:08 +0200")
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
	<D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org>
Date: Thu, 26 Sep 2024 09:56:39 +0200
Message-ID: <87tte2hmq0.fsf@geanix.com>
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

"Michael Walle" <mwalle@kernel.org> writes:

> Hi,
>
> On Thu Jul 11, 2024 at 3:00 PM CEST, Esben Haabendal wrote:
>> As a consequence, the SPI_NOR_SKIP_SFDP flag is no more, and all
>> drivers that have been doing optional SFDP is now marked explicitly to
>> do that using the SPI_NOR_TRY_SFDP.
>
> First, I haven't looked at your patchset at the moment. But I'd like
> to take the opportunity to discuss the following (and excuse me that
> I didn't had this idea before all your work on this).
>
> First, I'd like to see it the other way around, that is, doing SFDP
> by default and let the driver opt-out instead of opt-in. This will
> also align with the current "SFDP only driver", i.e. if a flash is
> not known we try SFDP anyway. Going forward, I'd say this is also
> the sane behavior and we don't have to add any flags if someone want
> to add support for an (older) flash with the same ID but without
> SFDP. With the current approach, we'd have to add the TRY_SFDP flag.
>
> Now we might play it safe and add that SPI_NOR_SKIP_SFDP to any
> flash which doesn't do the SFDP parsing (because it has size != 0
> and not any of the magic flags set) - or we might just go ahead and
> do the probing first for *any* flashes. Yes we might issue an
> unsupported opcode, but we already do that with the generic SFDP
> flash driver. So no big deal maybe (?). Vendors where we know for a
> fact that they don't have any SFDP (Everspin I'm looking at you),
> would of course set the SKIP_SFDP flag.

I like your idea.

Did you discuss this with Tudor?

On 9/23/24 7:04 PM, Tudor Ambarus wrote:
>>> * Always read Macronix chips SFDP, as Macronix replaced all old chips
>>> in the Manufacture table.
>>
>> I'll NACK it unless you prove that the old flavors of flashes are not
>> used anymore in the kernel.
>
> Even if you can prove that the older flashes are not used in the kernel
> anymore, we can't just switch to parsing SFDP, because we have seen in
> the past flashes with wrong SFDP data that made the flashes misbehave.
> The recommended way is to update just the flashes that you can test.

Does it make sense if I work on a patch implementing the proposal you
put forward, or is it possible to discuss it further before doing that
work?

If it will certainly be NACK'ed, I might as well try to find a different
approach.

/Esben

