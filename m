Return-Path: <linux-kernel+bounces-412463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2B9D094F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9F91F2253F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E95142E78;
	Mon, 18 Nov 2024 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZWi1owTl"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488217FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910060; cv=none; b=hVVZ4bVB8+ZRvd1uj4l8jf2mFsa9c23GZ21B6xpIIIeFtsNlVsMYUboKW+pQz/hm5kucRQIETqtaC/anSD6WZSUxmDTsG/AOQAlLNNerFKGpsGatJORS1XFMVzYiksKKkJCLLkKmm04kQA18SE4n5rjoM3uSnv9s3rvv9r7bGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910060; c=relaxed/simple;
	bh=z1Fd1ilnNJkiEtM/RBMHqbcg3yHAJWJe9OlZBZwXLTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KkFgUvylFQhgZVlSMw6JSZst49ATQTpPH7xqvV+1rkjOdf6ts7c5GRI8D4yGg/wtEI3THV4hORK1IBxM1im0E6nAhqgeE7vlUvqTVEbHaHZQ+LVrOn2W2tw2FMUdW+L5VMgxprmvCbqlwu7xy6KQluOz5YNpZkxWVlvTmTcq61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ZWi1owTl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731910050;
	bh=z1Fd1ilnNJkiEtM/RBMHqbcg3yHAJWJe9OlZBZwXLTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZWi1owTlUv0ZNIvznpWtr5Ob6iYk6V0LVG9+NGlIYK3FVVBIABGwTzt9YfK1F/Kc3
	 Djp1iWyISNYz12k/GDC9GYJSfkz7R2GzIbiZ2ZQKM6i/IqwLCgkpa9TUPSH4q0cUOr
	 yB2s11BlBsPEutsk9IijPDY4ABxAxj5yvgs01ngQAd7u9oO6FCgbwYNpAX7BzDQfm3
	 PtfG9pl9FESFL5/R8x46nKLGvbD+uQIyaQLFwB3UwsTZ0G++6nz3mIAeTsEhaPEZ/J
	 LUw3OTcC6uQhRSMC0HsEG4VgxpU2eQuzyARWyXztR4f4C1t78evLnxkrw2LZQEAm03
	 +nijMR346U2hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XsHGV4tmQz4xD3;
	Mon, 18 Nov 2024 17:07:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
In-Reply-To: <7e8a2788-f0ab-4d98-b26c-114e04558fb3@gmx.net>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <7e8a2788-f0ab-4d98-b26c-114e04558fb3@gmx.net>
Date: Mon, 18 Nov 2024 17:07:31 +1100
Message-ID: <87bjydoz18.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gerhard Pircher <gerhard_pircher@gmx.net> writes:
> Am 14.11.24 um 14:11 schrieb Michael Ellerman:
>> CHRP (Common Hardware Reference Platform) was a standard developed by
>> IBM & Apple for PowerPC-based systems.
>>
>> The standard was used in the development of some machines but never
>> gained wide spread adoption.
>>
>> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
>> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
>> some from Motorola? No Apple machines should be affected.
>>
>> All of those mentioned above are over or nearing 20 years old, and seem
>> to have no active users.

> Pegasos2 users still exist, but admittedly they mainly use MorphOS and
> AmigaOS4 on these machines.

Ack. To be clear my comment was only referring to Linux users.

The Linux CHRP support is still present in v6.12, which will be an LTS
for the next 2 years at least, so if there's folks who occasionally boot
Linux they will still be able to do that for a while.

cheers

