Return-Path: <linux-kernel+bounces-519816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2DFA3A232
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963CD3A280C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC916C850;
	Tue, 18 Feb 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="lb1FKjCI"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2026E630
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894965; cv=none; b=SH8beTULeA2OvygFGwjIPV4Un1RVFOh5qLy80vRmIx9+yecSHemlY/bDR6F3nG615rbyUjGjnmKZn9rSqrI8Cc83uPiiWPV5YZjWjcxDmtGy3/d5HW0FEsdOLmMCgiZqbcnKyPL1Ws7bqGWsaE5eCZNhO67jEDtOPSkm4PlZs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894965; c=relaxed/simple;
	bh=AOhOsmxZezWbzjTsfDSX8kpBDPtwMyCO8DPaiR7znVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZUiFWFi67HL89EXJA2sHTcRocozhYPx//EV/7kLpiz1Y3ysHg9MgeMZMtO0taHQ1DMjMRtSF93+C4/vUr7tr/wTtkPFNPBMB1fuOSOmEmZG2hkRBnGanAIfN01iggVRgWmvkbaeUvVcj6CWjw/8DF5QNRXgiKwHyk1/vjQmNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=lb1FKjCI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Tue, 18 Feb 2025 11:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739894951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEztrQmMNZf8KxW9it4BP89Ve0C07hVeIKvyoxZfpJA=;
	b=lb1FKjCI/WnYRemUD4eSVsAiqqKAwPZA+IuP1hhdgSp52sjlv2BMqOtqQ6OkTSYFTlGp2D
	VSyjNnweZztIHyNNEDCbT04vjvqC2KTV0HL2y0ml6hgl6K22rQPOOCbxTdOSWVBUrS9Wb1
	+eJuNV0+pB3SeoDtvAGXupFaZNIDISuwEFWJLdlqLWMCdGVB0d420Fyg9krTERTJYeT2OU
	uvJKwMox1fq95/oUZTl84dtLigO0QyM1F99D6nEX/nF/tyo+dViHaYJSEpjY4BfIzbtAPf
	SQJsUb8x+4BIkSft47WDuW3RkOeoV0AcvqACXtnvwujIi86DQcuu/BcY8oX0Bw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Mark Brown <broonie@kernel.org>
Cc: James Calligeros <jcalligeros99@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 13/29] ASoC: tas2770: Export 'die_temp' to sysfs
Message-ID: <Z7Swn3nuGJfOO0Bc@blossom>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-13-932760fd7e07@gmail.com>
 <Z7Slq3BQY7S5REPy@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7Slq3BQY7S5REPy@finisterre.sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

Le Tue, Feb 18, 2025 at 03:22:19PM +0000, Mark Brown a écrit :
> On Tue, Feb 18, 2025 at 06:35:47PM +1000, James Calligeros wrote:
> > From: Martin Povišer <povik+lin@cutebit.org>
> > 
> > Export a file for the readout of die temperature measurements.
> > As per the datasheet, the temperature can be calculated by
> > dividing the register value by 16 and then subtracting 93.
> 
> Please don't ignore review comments, people are generally making them
> for a reason and are likely to have the same concerns if issues remain
> unaddressed.  Having to repeat the same comments can get repetitive and
> make people question the value of time spent reviewing.  If you disagree
> with the review comments that's fine but you need to reply and discuss
> your concerns so that the reviewer can understand your decisions.

Which review comment...? The only thing I could find was about hwmon
exporting, which James added a patch for in v2 ("ASoC: tas2770: expose
die temp to hwmon"). Maybe I missed an email?

