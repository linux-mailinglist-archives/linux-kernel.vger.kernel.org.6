Return-Path: <linux-kernel+bounces-551487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89730A56D16
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBE3B5849
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010502206BC;
	Fri,  7 Mar 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f2Idy/Cx"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9D21D3E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363427; cv=none; b=VXWYIJ72X1RGQUjrMVyzB68iGqHzrfop8G0Wli/7+NIDY8iuAiZzmBZ+FC1etmXU+cvE9v8bFGRlPRvsNsCGW78JbH0DpqTA4oMo2jSDBZjGkKBSunWmEFDSFicWeHdAdDSujbdKu7+ulvK1fFJtpx9lZHR2tP/DDx9iyJKATh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363427; c=relaxed/simple;
	bh=tqNSpD/VzmVqzNzsBmJgam3pWcCCgI2wH+06au4N76E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=omCBnMwPEUXEVar8s1UcK37GxuK456e4HFVGi6OGHq9BWGN4gKOj8vqYv/YsqIqoxLW7I6MWRplb8LC2xhGeOPDlA997lyQfYDcRihgDan8zEdVjCKTZNZNpZfMzsxcXf2W3dy8IfG7LMulk43Mz/sVJJxCQXDqnxvjDmSoKPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f2Idy/Cx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2E0B20454;
	Fri,  7 Mar 2025 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741363422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqNSpD/VzmVqzNzsBmJgam3pWcCCgI2wH+06au4N76E=;
	b=f2Idy/CxV1lx6YSbxmrSN4qQ0N3qz0lY0sb/DTeL4NvLrydB/+gn2edmHrGeo5MV5P1CWw
	4zO2cSJiDJRo90vWU9smQYi9TgRU/UN1MtVRxFkkKcvKFaobnFRgf1bl/AaHSEhNPZ34JF
	h+OIPD8c2XkkwkHQS2vECGdIwytKbKCS2Xs2VRDJq59tE5X1uXkE39gwx8LxoB7ZbUcmxS
	QybDkY4ESlC0keNDk/lj1R54FSgxaB9+Zblf0amHITjKgfGVaNbEBZTUMs8irezKRu2tW1
	w50W04kRItYmyx7uW4pSk8kj94vwE9MzXNAkdX4iOapl3A8Gosc9xNRfH/gjNg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/21] mtd: spinand: Use more specific naming for the
 erase op
In-Reply-To: <48453010-560b-4985-a6e5-31401da24d62@linaro.org> (Tudor
	Ambarus's message of "Fri, 7 Mar 2025 15:45:03 +0000")
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
	<20250307-winbond-6-14-rc1-octal-v1-5-45c1e074ad74@bootlin.com>
	<48453010-560b-4985-a6e5-31401da24d62@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 17:03:40 +0100
Message-ID: <87bjucrfoj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfelkedvveffleeuhfeigfdvvefhgfejgffghfeiteegteeiudegfedtjeehkeefnecukfhppeelvddrudekgedruddtkedrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrudejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehsqdhkieesthhirdgtohhmpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdpr
 hgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsthhlihhnvdesfihinhgsohhnugdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 07/03/2025 at 15:45:03 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

> If there's no chip erase for SPI NANDs, then keeping the name as it was
> makes more sense to me.

There is no chip erase indeed, but my goal is to mostly clarify the bus
topology here. Specifically the 1s-1s-0 vs. 8d-8d-0 operations.

It is true that this series only uses the data-oriented commands because
that is where the time penalty really is, but I figured renaming all ops
would be nicer to keep the harmony among them and prepare for the next
step (octal dtr).

