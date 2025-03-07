Return-Path: <linux-kernel+bounces-551446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7FA56C92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950A97A2CC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0539021D3D1;
	Fri,  7 Mar 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cc0On2EA"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDB194C78
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362595; cv=none; b=PmV086nsl6F4wYB8qjAryakWeB0vcLS8SKjxzqWZMv6/kZAH7Z/tNrlRlm5D2dFNiuK9LDTjJugkxY0Mv/T4+SlUVy7N3D1lGPljjeipztMnx2MIO+Dr+Up9TeYCxWEGkqWfsFkhWWf1odg4z3cJafHBbKnbpN0sbminPTGq05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362595; c=relaxed/simple;
	bh=PbXXM9Y5vHm4WqljvkqdM59Ugf65JX9khBfeZrQLzw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Df+nmHo79U6jTkmK2OnEY23HMWbu4JaeV1d9RAo5G6taSnpbhsK4oFxZQ4UbDJAIttPZgBTqlgVhXKN54qtNeL6JgGeSAJs6YV13fCAts27637dRmWg6i4Ag9/9Y6pDPeo9JzaP3M6CxHsDHw9/4dUTn6qUR/wQs/0V4lfzKCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cc0On2EA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40A98443B6;
	Fri,  7 Mar 2025 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741362586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtL6eoYzvzBLjULBoBQyAiTAY2Kt7SvuQGNIxrXTK3A=;
	b=Cc0On2EA9eTB1jEVIhHE9+rFfERJFTWUYrnL7O+IIJsSjjapNhZE7P6AqYNCl2ExsAUAcS
	sRPKv30gNFtzBVa/5QC9+3+gNs3r3J1nd4qPmC59nLQGrrNDW+sCoZE9UG7m53pZ274ZNh
	LhEZoUsvRp5AVsATntS67Tg94dpqg9wnDznBP6qWTKqLHQhYUweEbI/L2Dtq18tvxDsSs4
	jSKs3Iwf6FoMONGNpQRYM+u5OS303TqUesgR4Hyt2kqKjWvVjF17H/Ix7l8rOVbNZBWXLx
	QbT4+z7If/qJMxQZJ3YxaRJBDtqDpx48kcCdHq67/aOxsl0yP7KDHqLvXY+vVQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/21] mtd: spinand: Use more specific naming for the
 write enable/disable op
In-Reply-To: <80da4df1-cd35-469b-a636-8f405358ef00@linaro.org> (Tudor
	Ambarus's message of "Fri, 7 Mar 2025 15:39:43 +0000")
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
	<20250307-winbond-6-14-rc1-octal-v1-2-45c1e074ad74@bootlin.com>
	<80da4df1-cd35-469b-a636-8f405358ef00@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 16:49:39 +0100
Message-ID: <87jz90rgbw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfelkedvveffleeuhfeigfdvvefhgfejgffghfeiteegteeiudegfedtjeehkeefnecukfhppeelvddrudekgedruddtkedrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrudejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehsqdhkieesthhirdgtohhmpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdpr
 hgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsthhlihhnvdesfihinhgsohhnugdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 07/03/2025 at 15:39:43 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

> On 3/7/25 3:08 PM, Miquel Raynal wrote:
>> -#define SPINAND_WR_EN_DIS_OP(enable)					\
>> +#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)				\
>>  	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
>>  		   SPI_MEM_OP_NO_ADDR,					\
>>  		   SPI_MEM_OP_NO_DUMMY,					\
>
> here too, I lean towards keeping the name as it was, but maybe others
> can jump in.

These are indeed the three commands with just a command cycle. But then
we have eg. page data reads which have no data: 1s-1s-0 (or 8d-8d-0)
makes sense to me because it is clear that there is no data cycle. Or
even worse, a read ID instruction can be 1s-0-1s (or, again,
8d-0-8d). Removing the 0 in the middle would definitely not make sense,
and to keep something clear I would actually prefer to keep these three
members for clarity, even though in this case they will remain 0.

