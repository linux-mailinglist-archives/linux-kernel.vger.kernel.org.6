Return-Path: <linux-kernel+bounces-550647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBFA56268
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3233AD5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF81A3A80;
	Fri,  7 Mar 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TWmxoDHY"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52718DF65
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335330; cv=none; b=rpcAcwVWjQVOYJqfTdaTZcm9qGg0kcG3TnfsIR7ISBEADG+iu/s7WOxkl7+XO7DNi0uB8eKjw9RZP9/hbsVv3dPswqNQCzoqVgwTr0kDWtBLZMTv76Iqw4ml5jyHozryaVhLyLoeyXdHn9j+DzsMPtIgL0jCM+m3emcvoTxd47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335330; c=relaxed/simple;
	bh=mhovoKIZAZPa2Ihi5jgodUoSJmwl/x0XqcCmjbBCeMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u3OrHIML0QsrWOxV1X1y+PvNHvAIdysV2UcFbQ6NB+GKLmvjnFy5lpY57JSi0HJGplT0x3rDLwbsF1hRiqFJnQE0YK2dMhwgzSkK6q3hIP1xpxIk7jJLV+WyeulP/JKAIEXVVbTSLHbvXbysSdhzt0ih4EqNL8ZueZeNFK1Z6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TWmxoDHY; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26EBA443B2;
	Fri,  7 Mar 2025 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741335320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhovoKIZAZPa2Ihi5jgodUoSJmwl/x0XqcCmjbBCeMA=;
	b=TWmxoDHYFCMe5SUC96zeS3sEwBTpgf39BGVhOXfxxbE81MFy1ZjIGBd8wzvxPrx9nCmYDd
	7pYplwxP7Dl0qjN5KkB6hWznpxpvd6DAzrKRo9EhTL5T2NXW5dfGyMXFX2WNs5JwJB+dEe
	Srhz+yL/jHMtWpgdoZ7Wl3D7bmQQQt4PGj8bzoLWlktUYLoAXcGkCx0Pj0mU4YfuN5PaGN
	D6pgQAjDujajQxxNfriVEjEg+jf+Vh63v8USFl19wUBEIKtcZNBtBZvT1tm1B7H155ReH8
	KuvtzKjy4KoRaRqTrYXlQf97TFTXQ8wYMnQTZuPb19BnVTQHKiR0A4CBAsffmQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: spi-nor: explicitly include <linux/of.h>
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-1-c186a9511c1e@linaro.org>
	(Tudor Ambarus's message of "Fri, 07 Mar 2025 09:09:05 +0200")
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
	<20250307-spi-nor-headers-cleanup-v1-1-c186a9511c1e@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 09:15:18 +0100
Message-ID: <87h645tfxl.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddujeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On 07/03/2025 at 09:09:05 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> The core driver is using of_property_read_bool() and relies on implicit
> inclusion of <linux/of.h>, which comes from <linux/mtd/mtd.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

