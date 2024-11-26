Return-Path: <linux-kernel+bounces-421835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B89D90B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27331B22BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A057B3E1;
	Tue, 26 Nov 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="B4hckH0r"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1F481DD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732591684; cv=none; b=dgz06cxV1CHrsbT9DWnwhU81ya0VVEUmA/rr5n3yoBZxBuqON246mBUq1+8TnWtbzwe1XSOOX1S0AJWOKn2bxG3KdU1Po2R2vIhddQhfTnL+lu+UPmvEcursKsJ6SDfuLTjY3a3s+kSAaYvwNFmr7uAEKZxGKaMQesQFVD5mciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732591684; c=relaxed/simple;
	bh=4HXkMnCHnK9z+sqyKvKwDDRFvXdTCSWPpKDF3bUrpvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jYrbV2ZU9C1HZ1hRJnLrXCHkRyvP/y61Xl2dqmyNtwqvVxq41MuFIZBM2+hEw8SJJNFxNlQgkypmPoyAQC36SL/GvhIPR2TBGLFXU6KCzt+tKkJdNrDQgIMSkHruG/ki6xl2PiMsX/jvIOBRoBEblbarGegIKa7UMsOb/DMK0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=B4hckH0r; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732591676;
	bh=4HXkMnCHnK9z+sqyKvKwDDRFvXdTCSWPpKDF3bUrpvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B4hckH0rN76Y0a5y5nq1cchcJEn8jG4seVY3TR8tmA3y0hH1UiVVf7826nYgMuzib
	 SYA8iE+NvGHzG6AwAvjP01U1HideeZFnZ07JjGzxQx6b+D3ZE7vn+CHTk3RSagIyGh
	 gaxFq5bJ/6glvw5237EoJdpQuk5A9w/zpBzEYLqiyV8GvgwxZy4YiOmnDlNlHYs+mE
	 aMGYbVPYjA+m/J8c+SoKg5sstPL7HCXpCKyvri83s7ChVf6KnaB18tdSqavl2SRSDT
	 OZozNN9NS0DuMuM9W67bFbwgRO2QEM3kd3JtflILcuX+/HlTfSuE6/lNTdQzPSWnRK
	 Rw3SzWlmYIuPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xy7Lg6yDQz4xfK;
	Tue, 26 Nov 2024 14:27:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: arnd@arndb.de, geert@linux-m68k.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
In-Reply-To: <20241121083846.3648473-1-glaubitz@physik.fu-berlin.de>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241121083846.3648473-1-glaubitz@physik.fu-berlin.de>
Date: Tue, 26 Nov 2024 14:27:55 +1100
Message-ID: <87sere7jyc.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:
> Hello Michael,

Hi Adrian,

>> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
>> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
>> some from Motorola? No Apple machines should be affected.
>
> I have a Pegasos 2 and I planned on keeping it.

OK great. You're the first user we've heard from in quite a while :)

Any idea what is the latest kernel version you have run on it?

> Have you asked among the Amiga community whether they plan on discarding
> your hardware? I think it's always ill-fated to ask for popularity of
> hardware on just the LKML. Most users are not on the LKML.

I haven't because I don't really know anything about the Amiga
community, who they are, where they hang out, etc.

Please cross post this to any Amiga folks you know, or tell me where I
should post it.

We've maintained this code for over 20 years, at some point if there's
no one in the *Linux community* who cares about it then it's hard to
justify keeping it.

cheers

