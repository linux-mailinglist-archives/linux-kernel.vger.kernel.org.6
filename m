Return-Path: <linux-kernel+bounces-405744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697F9C5790
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FE3B3C054
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5CB215015;
	Tue, 12 Nov 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BYX4f8hM"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A12144A8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410242; cv=none; b=OsJsTJNjTyylIJJ6noiLbyC6MKvECsdV+qrxhIMvj3TJ/NNKMcBOkZL7YDaTqV3qakmtJbzSj9PWs7Uo5C4WopkBcRurAUWv0GKhLrrJAwGKYjuN4UPBJYvy8LWcYUqWn22FbhIOZdmj3hBylVsvyKBMDbBqk7oKFDuDslAfTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410242; c=relaxed/simple;
	bh=FwJ5gUGil3S1ZD9QkCtfYxlbkSFPT8MXJtUT0r746v0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPeEAR2iOtcqoVtJXZTkH9pdYPHzghPeW+fRleYro6NPNhxfAmAljC/zukrP9fNnk20nZwzdLqzYu5BwiaJmtSMXsGsnwzq/305ewtKV8C2sevRSFZmvo575OTf2Cun80lhw/VmG/SgFQjlCyU7qCdmQWQKGaAm8xy57VsC3us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BYX4f8hM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0B41240008;
	Tue, 12 Nov 2024 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731410238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwJ5gUGil3S1ZD9QkCtfYxlbkSFPT8MXJtUT0r746v0=;
	b=BYX4f8hMOjqs0FgwJhp0tbgDc2sYzMuYwpphFRaehkwiJtgjEbaWFODsGDykHwxXa2UxZy
	UzgwEYY9Ko7E/mQZBfYO8C70Jlju4yjhK+9z2qg/qBaSQRmRRrKwMRPGrwHBX/TRjwIUwS
	nUWOZwhGhRp7INlbNNMjeXW/Jf0Y5+E8Pzn4r3qG8/5D+oOZ3fGyZ5bXjOav/kw550sDO8
	N9S7e6v574je9xdTW3cIwRUAfVRYYTTnOqxcOUUVeLvELmpGK0P/la4NO1YNpnAlqZW7aV
	bgMh5k23QIByVZ9Na4ffdzeeoTLWXqVI36ftXrEZEAI6lPrBUgBAQs2nnnEvPA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v2 2/6] memory: ti-aemif: Export aemif_set_cs_timings()
In-Reply-To: <07cd5d53-ce99-4ada-a7f1-53795eff5c42@bootlin.com> (Bastien
	Curutchet's message of "Tue, 12 Nov 2024 10:13:38 +0100")
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
	<20241106085507.76425-3-bastien.curutchet@bootlin.com>
	<87ttcdr2ym.fsf@bootlin.com>
	<07cd5d53-ce99-4ada-a7f1-53795eff5c42@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 12 Nov 2024 12:17:17 +0100
Message-ID: <87y11osnuq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Bastien,

On 12/11/2024 at 10:13:38 +01, Bastien Curutchet <bastien.curutchet@bootlin=
.com> wrote:

> Hi Miqu=C3=A8l,
>
> On 11/11/24 8:21 PM, Miquel Raynal wrote:
>> Hello Bastien,
>> On 06/11/2024 at 09:55:03 +01, Bastien Curutchet
>> <bastien.curutchet@bootlin.com> wrote:
>>=20
>>> Export the aemif_set_cs_timing() symbol so it can be used by other
>>> drivers
>>>
>>> Add a spinlock to protect the CS configuration register from concurrent
>>> accesses.
>> What concurrent accesses are you trying to protect yourself against?
>> I fail to see the use case, but TBH I haven't tried hard enough maybe.
>>=20
>
> The register that handles the CS configuration belongs to the AEMIF
> component but it will also be accessed by the AEMIF 'children' with the
> aemif_set_cs_timing() function. So far, concurrent accesses shouldn't
> occur because the AEMIF configures the CS timings only once and does so
> before probing its 'children'; but I don't know how things can evolve in
> the future.

Okay, and I guess we can have more than one children, in this case
indeed we need serialization.

>> Also, what justifies the use of a spin-lock in this case?
>>=20
>
> TBH, I always struggle to choose between mutexes and spin-locks. I chose
> spin-lock because it only protects one memory-mapped register so I think
> it doesn't worth going to sleep when waiting for the lock.

In general, I believe in a path that is not a hot-path and if you can
sleep, you should go for a mutex.

Cheers,
Miqu=C3=A8l

