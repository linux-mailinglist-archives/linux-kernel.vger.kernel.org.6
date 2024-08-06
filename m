Return-Path: <linux-kernel+bounces-276215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BCA949040
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974621F2241C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8E1D0DD0;
	Tue,  6 Aug 2024 13:09:45 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3951C578C;
	Tue,  6 Aug 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949785; cv=none; b=g8Yc7VjnLve4RHESj8FoCcjK/lyxYGUoF9eKg5e5aTa7fDlFH/d/FReZQ6e3rDbGCCoqU07kphPPOxGmgw7HXLYnDYOlOXp6QvOKaOeL4EYzkARxP4fVbPkQviz4EVA+9EDtOwScJ/26cp8ENlvPHgNsCJzg2OB05G/RObsIXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949785; c=relaxed/simple;
	bh=4/+yfebmcCt+GYD9DilF4pN8420I0xcAx5yduelZnns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t39DXM4039AHi7m8m1/0/zWii8NGPwsZffgy2b/u+vUg0a6gPl/WlOgbi31QoEObRa1UIirRp3cjT6CqYmmI1qk/v+og0dPgMTPepKVO4cpSt3D+kaRw8+EktwNLoLkG93OkeTbzHfffElpJ5BNENtcBpAiA0DUTJ7oUglBwDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D203E68CFE; Tue,  6 Aug 2024 15:09:38 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:09:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
Message-ID: <20240806130938.GA12231@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-3-ansuelsmth@gmail.com> <20240806124312.GB10156@lst.de> <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 06, 2024 at 03:03:24PM +0200, Christian Marangi wrote:
> Well on embedded pure PCIe card most of the time are not a thing...
> Unless it's an enterprise product, everything is integrated in the pcb
> and not detachable for cost saving measure or also if the thing use PCIe
> protocol but it tighlty coupled with the SoC.

Yes, PCIe has a bunch of form factors, including just soldered on BGA
devices, but none of that matters at all for the logical protocol.

> This implementation is already very common for all kind of pcie devices
> like wireless card, gpio expander that are integrated in the PCB and
> require property in DT like calibration data, quirks or GPIO pin
> definitions, i2c...

Do you have a document on that/


