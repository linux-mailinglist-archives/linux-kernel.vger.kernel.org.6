Return-Path: <linux-kernel+bounces-248221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170992DA10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6B41F23C81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CAD19149A;
	Wed, 10 Jul 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Suv6Ek33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONMH5QuB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1583CD9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643409; cv=none; b=r6aYfnT6HpMPR3N4970cv70A0iakXiv74Hjs7ODxdRsbQtfi6buZdTXqzCsWGgl5SB17Uh0uOax5wgiMNlVM+s0ut1IH5D7Vw889Niy1vuORWUjgbxIPAeAupLoMzSDjXoVVBtwkgRjZE+VPwYUAfAZy5kzgXrLwn8ZJ2CDn0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643409; c=relaxed/simple;
	bh=vpQkn0HYQ7rMjSPdDVHHkiCEetosVeEqGaNYaAlScoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBID6BFoDTeAZLWCGYAoG5vfWziy+gIWYplxRXeUxC95fdqMBQkaA3zE2O6pqhwLrhtoMEj6b65RNGzltu7dBPFJVvk6e9SpVv2ni/9BSvsgt3ykWbyl4WBwA8KfhHH4KrGLGOeLqX8HH3acXZ//ZNwfYdy+p42K14v7ecfI+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Suv6Ek33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONMH5QuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720643406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpQkn0HYQ7rMjSPdDVHHkiCEetosVeEqGaNYaAlScoI=;
	b=Suv6Ek33wHAqPowS9D16B2J7DG7qWCa3lYo5qqDLRVG5DFqb2ItYpTsuZLjB3UlsluWoNN
	22Sw/q4xu8nb4/fF/PlD1Za6JNOqCwffUK/KnsRbYAVRX0FCWQdqyIz0hL/A8YgTL5qMya
	nXmsrghVwiNQZ2AcvyaaFM6df3b5GCd6y7uwC2VT3o3+G9tadMromQS9jCWt+7NRSNDBXe
	0uizR7wVCz2OxavXAPUOhht2s1gkG4qTMoxcFIm6KwA8jrOb37Yrw7wB8gwz1I+JE/M/CB
	Hv3FIHh0I9+9HyjGadl0mhUWTkppTmQBIcEzo/VNdCRveSnvMBTXyA/EvgtSyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720643406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpQkn0HYQ7rMjSPdDVHHkiCEetosVeEqGaNYaAlScoI=;
	b=ONMH5QuBiRRj+UMlfmwO1c/lH1p9N9ounownWgVhI1vC27XGa4kB4k91g/s8uIXTNxgG0h
	cR2ft8Jh22VpHLCQ==
To: =?utf-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,
 =?utf-8?B?5byg5ZiJ5Lyf?= <zhangjiawei8@xiaomi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?546L6Z+s?=
 <lingyue@xiaomi.com>, =?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>,
 "isaacmanjarres@google.com" <isaacmanjarres@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, =?utf-8?B?5qKB5Lyf6bmP?=
 <weipengliang@xiaomi.com>, =?utf-8?B?57+B6YeR6aOe?=
 <wengjinfei@xiaomi.com>
Subject: RE: [External Mail]Re: Race condition when replacing the broadcast
 timer
In-Reply-To: <bc1a086b932f454f9379c49221983675@xiaomi.com>
References: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
 <87o77m1v9r.ffs@tglx> <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
 <835d5847-1aa0-4852-89c7-6a6996b3eb65@linaro.org>
 <bc1a086b932f454f9379c49221983675@xiaomi.com>
Date: Wed, 10 Jul 2024 22:30:05 +0200
Message-ID: <87o775uh0y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01 2024 at 02:11, =E6=9C=B1=E6=81=BA=E4=B9=BE wrote:
> Jiawei,
> Please update here when you have the test result

Any update on this?

