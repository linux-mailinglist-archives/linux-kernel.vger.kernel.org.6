Return-Path: <linux-kernel+bounces-275185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E9994818F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A1228DB81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E415F3F8;
	Mon,  5 Aug 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBzWdopb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXfW3HAD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1015B56E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882614; cv=none; b=qRN2OxUSbw6jQnG3i4ZKYZIOVBeenyZIustP/Mdph7k9aXE3Hj15uWegxa8PrsMkGMzir3j/SLrQ/2hLLzXYAcnhgUJqQYsqNYqc1oWO/KK+3l1P+yGLk4l4aP5rbpFDTKcdhaw4iWkKOxoA2/Jz4dPhaEeMb0CyTON0T3FvnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882614; c=relaxed/simple;
	bh=NrU2SDbKbXUb/ATIe1QlAPBGvchHxO1RsIZlMCmshIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ceBqC9uvJ53Tsi0+gwtpBackhiRxIu8zuhDxvAuRIrvhBWNnzr5tDfgoWNOo04ne6X7rmOHKUr8vnBZSR6jEpclP9y3kHdFKlyRqaec2/q1bHdREE7iDsR0No37kYYdN4PTiEVSpoZhfwUNFvgYGUvAscp/68o+Sx5ukCafRyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBzWdopb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXfW3HAD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722882607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP1J5S0LSf8H5luAMPVVcaxUVN84MC/2Vx5Wexj5lQ0=;
	b=IBzWdopbkAobSW5j6KDqdsL9NcecSPD62RwLNdesymhEK+bn2wnTNrlYpchcv6XETexNdV
	BV27ivthM7yOND2Q3MDM9mP8ADagwo5I1pkHqxOBZBOhqC6RXeYGqe1oYU39YYvi1YcHzH
	mHiliu3Loh8p6U4YK7ON7JyoRQTRB5+eUnkh7zSyyaiM0/TaGfi6BeWZTNXLphg165wrOa
	XfG8pvoCuPjS5aHTFoFGuosPHGS7BT472qNGO47O6U1+rSqgS9w6XdvvrcJ4XhiDaIFzm1
	lFOGXNxvV1xJTkmWdCFmCoLn3qfMoc1F1cOE/BtWCbebnq4FKWVZSeI9Ec1z9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722882607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP1J5S0LSf8H5luAMPVVcaxUVN84MC/2Vx5Wexj5lQ0=;
	b=AXfW3HAD/VzwMv+z2NTl/H4Fwq/SE/80UvZRFumZt7DI87x1abbWOXkkrs8oF1xfUvmNKC
	CyTW9t8vzsvCsjCQ==
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>
Subject: Re: [PATCH] timekeeping: Fix bogus clock_was_set() invocation in
 do_adjtimex()
In-Reply-To: <CANDhNCpej847tOsbnDFBLV6GLdPGDoM5JJ7d1-UYed+2AEarVQ@mail.gmail.com>
References: <877ccx7igo.ffs@tglx>
 <CANDhNCpej847tOsbnDFBLV6GLdPGDoM5JJ7d1-UYed+2AEarVQ@mail.gmail.com>
Date: Mon, 05 Aug 2024 20:30:06 +0200
Message-ID: <874j7y6cwh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05 2024 at 10:50, John Stultz wrote:
> On Sat, Aug 3, 2024 at 8:07=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>
>> The addition of the bases argument to clock_was_set() fixed up all call
>> sites correctly except for do_adjtimex(). This uses CLOCK_REALTIME
>> instead of CLOCK_SET_WALL as argument. CLOCK_REALTIME is 0.
>>
>> As a result the effect of that clock_was_set() notification is incomplete
>> and might result in timers expiring late because the hrtimer code does
>> not re-evaluate the affected clock bases.
>>
>> Use CLOCK_SET_WALL instead of CLOCK_REALTIME to tell the hrtimers code
>> which clock bases need to be re-evaluated.
>
> Acked-by: John Stultz <jstultz@google.com>
>
> My only thought here is maybe renaming CLOCK_SET_WALL and
> CLOCK_SET_BOOT to something like:
>   BASEMASK_WALL_CLOCK_SET and BASEMASK_BOOT_CLOCK_SET
>
> Just to avoid future naming mixups or confusion with clockids?

Makes sense. Care to whip up a patch?

Thanks,

        tglx

