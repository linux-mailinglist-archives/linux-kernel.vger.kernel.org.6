Return-Path: <linux-kernel+bounces-557187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7202A5D4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBFC178D13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40118A93C;
	Wed, 12 Mar 2025 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Upy/gAm9"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8442A82
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749658; cv=none; b=utuEhwC5OaKbhNzq5FFiZv4Y82o69oDC6Dl0uEYBVK2mAELoevIkFjv4v2Fp9U4Iabc3SrgcCqzGmAwpUcNSMo6vlbpg/hQrA+++mA6vUbDqHKkf7DAzBxGlou8oZ6X+V7vMWsckA/2ul9U0zWCUX9vh9ilu1R+auj5baPIhIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749658; c=relaxed/simple;
	bh=O9y+/2Qm3JATFyDUzKyrD5K1XojM/UVvNyi5aMAIstA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Qwo8dFvPy/h3ebR+N3Z7vYmgMeZRdjGxCQuRcgKQfTxV+SPVw25Mr86UIKD6DdlvxCW7V3PK8lzRu0+qD8gS57oFR1ZEUQeRBAc6cev7wGV7hOsdq/Vlpg2jcLz8MbEwymO4leCZIu4CMNfbnj+VQWrZ/N3/hhtq+dYrvGW9PNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Upy/gAm9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741749652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97XLkDxuD9yIqFuxmDBA6gqf7evP59zqd6Yx2ZOCY9M=;
	b=Upy/gAm9Rf/+hzSlXur/wC6Q5x0WwI3hGyLfFu/htRnLLUYObn458CMfeSVDAz8ZmqSOUc
	yLU7mU/kAkmE5bBwUKL5V0THaZ6VsU3SSLV6A4irkFfOCn0VsaWD9wITq4dnd/FUvI2YRK
	B7QUwvSYP+bJKnpxDy1/uJJrClWXt/k=
Date: Wed, 12 Mar 2025 03:20:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <171eb20e618f8c05ef8169e892a1ed08cf580ee9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <871pv31wpf.ffs@tglx>
References: <20250311013352.2727490-1-yajun.deng@linux.dev>
 <871pv31wpf.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

March 11, 2025 at 10:14 PM, "Thomas Gleixner" <tglx@linutronix.de> wrote:



>=20
>=20On Tue, Mar 11 2025 at 09:33, Yajun Deng wrote:
>=20
>=20>=20
>=20> affinity_hint is a hint to user space for preferred irq affinity, b=
ut
> >=20
>=20>  it could chang if the value it points to is changed. In other word=
s,
> >=20
>=20>  the hint is invalid.
> >=20
>=20
> That's a problem of the driver which provides the hint.
>=20
>=20>=20
>=20> For example, if affinity_hint points to smp_affinity, smp_affinity
> >=20
>=20>  is changed by the user, and affinity_hint would chang. affinity_hi=
nt
> >=20
>=20>  couldn't as a hint to the user, it should keep the value if it has=
.
> >=20
>=20
> What is 'smp_affinity'?=20

It's=20'desc->irq_common_data.affinity'.
>=20
>=20I really fail to understand the problem you are trying to solve.

irq_update_affinity_hint(irq, desc->irq_common_data.affinity);

As in this code, this means affinity_hint points to smp_affinity.

If someone were to bind several irqs to the same core, affinity_hint woul=
d change.

it couldn't as a hint to the user.

This patch allocates memory for affinity_hint and keeps the first value, =
even if someone

modifies smp_affinity, affinity_hint wouldn't change, it can as a hint to=
 the user.


>=20
>=20Thanks,
>=20
>=20 tglx
>

