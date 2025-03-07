Return-Path: <linux-kernel+bounces-550656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EAA56281
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB55177265
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9C1ACED9;
	Fri,  7 Mar 2025 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d7TLp2+t"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E179186607
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335764; cv=none; b=pXC2Q7BOP86IeQjQTU6pg79la95SVehmq/JatWin6+PEBcinOM5w8+33eRgKuayB7Rym6/40lRrc3Gh+xdHyE5CGhLJjvsUFSP07MdLzn9Ji7OgcwzFaJfZDoTr6gzgKQc0jbXqjQHykaHHuX/zaFAZIcwjB4CNQvjKSlWkF+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335764; c=relaxed/simple;
	bh=WwokADQwoB6/27mEXv+drkcP5cM8HPpvh5R2RnDMhSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MRss5QbpGpbiI9TZm1BaRORH/3MmfHXoo73llb6JtuMVAodEPzuO4NDG80c+GqH2Rb5tVjW5VEkA7KklWtSG14QFbjyxyw5DgCYhUbOwNeKJZcBo5YVz4LgP2TYlBafIO3v3sBQOsCRYrAdNlvWZhYPNVwQ1vM008YlrXpjDjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d7TLp2+t; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C98D443C4;
	Fri,  7 Mar 2025 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741335760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwokADQwoB6/27mEXv+drkcP5cM8HPpvh5R2RnDMhSU=;
	b=d7TLp2+tZrbmUG2iBgUYdDsQSDHPhwgBK9RLv48OoZ1h8hiPBfZS5WEwQyYxyVj49nD7wc
	mgOWOTVAmjDrYTW4nYK/J02zA0zaQhTfSj8wIz7O92CtJpX6OTXvkRFdwr5wYwiRjUErVi
	8GteliTw+2v0BwKNRBM2eHSlZQv+MEM3ejrX6IYmLznGCFKZWOOJkQ01/zNr+rWOzWyQcP
	+JIQoqGsMpXAavJUZ+iqrsuln+zCjBjeSEWDrFb6B7qox5exjuuM1C2y0UpxsUmjD+3RPZ
	b2yqctP6/+4LfRmoI8EmquCw8EpWyLCtkYBY19G5eU/Ebck92iiXj6YKpvel0w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: explicitly include
 <linux/mod_devicetable.h>
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-2-c186a9511c1e@linaro.org>
	(Tudor Ambarus's message of "Fri, 07 Mar 2025 09:09:06 +0200")
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
	<20250307-spi-nor-headers-cleanup-v1-2-c186a9511c1e@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 09:22:37 +0100
Message-ID: <875xkltfle.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddujeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Tudor,

On 07/03/2025 at 09:09:06 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> The core driver is using 'struct of_device_id' and relies on implicit
> inclusion of <linux/mod_devicetable.h>, which comes from
> <linux/of_platform.h>.

It is actually included from of.h now (since patch 1) and I wonder
whether there is a need for it to be included explicitly. As a user it
feels like "of.h" should already include whatever is needed for us (and
it's the case). Looking at the numbers, about 25% of the drivers do
include it explicitly. But either ways I'm fine.

Thanks,
Miqu=C3=A8l

