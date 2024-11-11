Return-Path: <linux-kernel+bounces-404617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B229C45BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A22283A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052B1AB515;
	Mon, 11 Nov 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ml4HaV+x"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426B1A707D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352904; cv=none; b=QNQ3dzKGLb223Y4DaGLk3GA3CT5XrzZJXB4zFuxMBJdEYw+JYdQ3A6NpD80G5DwJ6C2sG3mhrbhSS3CXFs3kZK6YLR3ysiSWUJB1aLRpqByhTqEAOE0OhNbIPHLrLSOcdAT2eDx/ADNFPrwQxLAUwlam9xdctvSxZaKqgvy3m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352904; c=relaxed/simple;
	bh=yshEmQNfo7lf99gQWxM7QIkdoQdSMmzP8GeA7i6xr74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BzwUy1fPyzQpCYfj1cFthpHhPYvsDZ7wHDm6TVHJJGZ8w3oRHmMYq7evfqKdlA5DVkme9Xtnq556GlNUuk9YZF6ebS+BSL8MNK1uSlDQfylf63ZAix1kJ8/RlkPHE4D5ob+XnLBd5Osg6LCVgLDb7ioMXUlROi7KT1W8OrqC56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ml4HaV+x; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2F7DE0002;
	Mon, 11 Nov 2024 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731352899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yshEmQNfo7lf99gQWxM7QIkdoQdSMmzP8GeA7i6xr74=;
	b=Ml4HaV+xJg4aI9v++lFwK6yWYiRMfqAYfZFaigv/ioq+3gIgZrBBR0vcuufs4C2XjnilXi
	KaWJPkAENm2xUD/pyh3Q0q0O5s6V9RJtncgr9QAfV1Tawkf365GjStMvobKxFb8Jdi2sac
	mF5tsODuWCBlQvSUEx1JrQYFADDIciByva2Pi3fNR/j6wdKa5XewG89EDUIjqlD0zkQhyG
	Erf+P8n6qtlqc8JtVSV/5QtwcYOGkEO0jNpw/jNOeP9sve1G1KT62dY+NdZlX4kmIIant5
	bknC2Osy1PwmHbnDAToBF3PDEHshWPdVy/j8I6qY5dnF0ZDfvs8QmIemGOIRiw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v2 2/6] memory: ti-aemif: Export aemif_set_cs_timings()
In-Reply-To: <20241106085507.76425-3-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Wed, 6 Nov 2024 09:55:03 +0100")
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
	<20241106085507.76425-3-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 20:21:37 +0100
Message-ID: <87ttcdr2ym.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


Hello Bastien,

On 06/11/2024 at 09:55:03 +01, Bastien Curutchet <bastien.curutchet@bootlin=
.com> wrote:

> Export the aemif_set_cs_timing() symbol so it can be used by other
> drivers
>
> Add a spinlock to protect the CS configuration register from concurrent
> accesses.

What concurrent accesses are you trying to protect yourself against?
I fail to see the use case, but TBH I haven't tried hard enough maybe.

Also, what justifies the use of a spin-lock in this case?

Thanks,
Miqu=C3=A8l

