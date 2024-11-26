Return-Path: <linux-kernel+bounces-422671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1479D9CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CE0282791
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1D1DB363;
	Tue, 26 Nov 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERnD62+W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjA+cMRz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145380C02
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642878; cv=none; b=qBwUnQtFmCmXETLTTPbwh1hSVfKQvfQgNus3y9Wdc+hjbprTmueAUR+Vl6zIZcnv3HmkSpPWVB0F9k7tnjsPKoVfMcme3hw2MpC2mwf9GnpmmGRfAAFmeK99Jm1QLXkbTG2kywS4Ft+uiqG+Lvgpk5Y3f2zBdT/LLuHI1o0mcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642878; c=relaxed/simple;
	bh=PPSnA41coIwDjhcOM58Qd6tknD86gTdOq24hZjP2m1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVGY2uPlh0NmM3jFMChueSwuonu9C+oEtkKrPY/TLdOvDOP5Fsk8FC8xJr7/vRBUoc/F2EDxU7lipUOe2OQCpkBfAmN8YbxyypxDrRxbP37vW3NlA+syA+ZWwvmSly0+xkz+4MxaGAqYX3qkGaeCei28uSuIfK5jzULl88q2zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERnD62+W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjA+cMRz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732642875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPSnA41coIwDjhcOM58Qd6tknD86gTdOq24hZjP2m1w=;
	b=ERnD62+Wlk5SL4814Wu7aFiw2ejB83hM5AqsZQg8VLDIOAgbrcX+lUsY0ee5oND6ky/gta
	z4shhSrN2/5tPh9MMPJ54OBw4T8T7qcA3ldPhTjWzSwOnrxgNSnu9+G8C5Aw5Xiy+z57tT
	dv+LCUXekD8p5EN9YzQtDl0szrs20cf/MWrE2jO4fJ9W+aqjcpMy4Pw2VCbiN0U8tSTvRH
	+ZP2lo3Foi8m2eWaqLrdUOK6bc5X12LNTnG36AcdISxf3seIE8JgFUkf0LUUal8IlIqSCn
	muzQjQEmEl2XOkgVdqBl49g3qTBUnwZeJrAocxrZdup1lFp4dok2UI6+t7zjHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732642875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPSnA41coIwDjhcOM58Qd6tknD86gTdOq24hZjP2m1w=;
	b=XjA+cMRzcHZlSHcEIXNGER863US3c8G9D+GwsXT+6jOfmHKN7A2MsVYCBdNWJo6PDOzN0C
	ZiH9lugmUgYHk5Bg==
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jk@ozlabs.org, arnd@arndb.de,
 geoff@infradead.org
Subject: Re: [RFC PATCH 20/20] genirq: Remove IRQ_EDGE_EOI_HANDLER
In-Reply-To: <20241114125111.599093-20-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
 <20241114125111.599093-20-mpe@ellerman.id.au>
Date: Tue, 26 Nov 2024 18:41:14 +0100
Message-ID: <8734jdzydh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 14 2024 at 23:51, Michael Ellerman wrote:
> The powerpc Cell blade support, now removed, was the only user of
> IRQ_EDGE_EOI_HANDLER, so remove it.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

