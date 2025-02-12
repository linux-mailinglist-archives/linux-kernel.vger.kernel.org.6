Return-Path: <linux-kernel+bounces-510719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ABFA32105
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CCF16646F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E18205AB5;
	Wed, 12 Feb 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HfC5z0HQ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D4204F8E;
	Wed, 12 Feb 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348758; cv=none; b=VHHgOOtgruFvMXJmy3cIdPDy4uLDAN17RMFEI3WLHMFEHFbAflzc8+7myKjjbZzPcWt2mcLFmh0QM8i2tKswwJ0p9C6KPqAInf7gA+xsEW5RRQtEIiNizpR38puJyOTYVES+lFEXwWALVAB6MJwNYk5tOpAUL+7Rwvddq5rKH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348758; c=relaxed/simple;
	bh=T5noWuekGcO4TRN2XISrfPnAA/81AD4EC5oVcCNbEiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gvhOifp15lvkvAJiDgQP5zWQHUGbiJj+38q0H8yDwvLjSiWH5HrLNnd5HqZfZNPyBu7lRUy5oBUW/D1+B5H60JJu0rPDkY4/B/xyNfsAFC8iilvYvyqDNtvo51olfkyUW4bVzH63BG+FxU9PyfbE2ASgRozRMKcYELZ5dzL/JDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HfC5z0HQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C0E943201;
	Wed, 12 Feb 2025 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5noWuekGcO4TRN2XISrfPnAA/81AD4EC5oVcCNbEiI=;
	b=HfC5z0HQ2GOPil858ShZzgc2qF7Z/QimMkB0RVsbUAedBhzcU7Ac55BCUvrnHLgFR0PWkF
	t8WeE7GCJ4Df3HBC+3em9OIILTUIszJARx6+BuvZCgpaGRPlN5fCWeBUGsjOc4hWkvLPvX
	atm+E9mzhg3cyAJAS9QvV68HQbjJk0/EnvBrsZScMeFustb615ExWREzOFV6qTzmyWlrMr
	uZBAxN1UCRWXfKJOZVqrDbmJ9Mwi9GaTC5gX3ztM1BRBpsCTL5Gbua26UgF5o8rH36YLc0
	2f4RdvR6nhBLXlX8kMDGLodAyNWvOJNiwGPPbqov+dTKWgcY623VztIfdFZjYQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,  richard@nod.at,
  vigneshr@ti.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  git@amd.com,  amitrkcian2002@gmail.com
Subject: Re: [PATCH v12 1/3] dt-bindings: mtd: Describe MTD partitions
 concatenation
In-Reply-To: <20250211212928.GA1188800-robh@kernel.org> (Rob Herring's message
	of "Tue, 11 Feb 2025 15:29:28 -0600")
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
	<20250205133730.273985-2-amit.kumar-mahapatra@amd.com>
	<20250211212928.GA1188800-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 12 Feb 2025 09:25:53 +0100
Message-ID: <87r043r2lq.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhithdrkhhumhgrrhdqmhgrhhgrphgrthhrrgesrghmugdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

>> The partitions that gets created are
>> part0_0
>> part1_1
>> part0_1-part1_0-concat
>
> 'part-concat' doesn't work if you have multiple sets of partitions you=20
> want to concatenate.
>
> I think you need something like 'prev-partition' or 'next-partition' in=20
> the partition nodes to create a linked list of partitions. Hopefully,=20
> you don't need both properties, but you do have to scan everything to=20
> figure out which ones are concatenated or not. For example, no property=20
> can mean not concatenated or last partition if you use 'next-partition'.=
=20

Out of curiosity, would the chosen node be eligible as a central place
where to look at?

Thanks,
Miqu=C3=A8l

