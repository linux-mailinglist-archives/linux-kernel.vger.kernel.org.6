Return-Path: <linux-kernel+bounces-239390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B9925ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4399428A43F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947B1741C4;
	Wed,  3 Jul 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="f7+L3cQA"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0E13776F;
	Wed,  3 Jul 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006611; cv=none; b=TY0mTJHE1+auuXbhHFWc6S6+csWaD84L0nXCSvyFrS2t2nstEvCKWmKfgQitD5VACQejlRCxmwnB55UaLxAOEFIBBvixRq6oU3L//SCGUQaukk9Y75Gbwc4qTWoSY80qcgK6Ye4eFZi4VM1kMlhZILsq53br7n/rp4l739uQQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006611; c=relaxed/simple;
	bh=Vp/o8oM7f/Cn3VExLle9E9dQVEcxizL9LtkQF+BGUZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elUQY7uKY0noWwmycy+cTcAs7Ycf9bp81cerpbTykCCCoKKnOREqn2bHGU3shVeI8QqMsX60n6eWF87sBGWN/SKpkFixdIvmE495GUv7oX1yFUbdpKtz+wx5mZApwGj+7bYju4zAH1s+G5/l0Z9owDQZNX49d5WOo1QYs7CcIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=f7+L3cQA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720006607;
	bh=R77gWoyRaHjitzxdt9vqwRqguNOuLOOkElH+/b0NzN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f7+L3cQAqB64y7v0d9teKpFDl3Lqj5p13+WmEOHetk0kaogcB+CO10T6RnDDzoAGa
	 gteTUArhjd+tZSLSkZ12HblqsPIacZ86GX3eBvVRK39Sd6hSMmBojFyGID68qyD7Rl
	 ibs74wFnVbDxEOHAjYGRnD6gj5uUK1ziIIT6EvjlcYeNd7yWSxe7ALpYLUXbcV9bp3
	 59aqOIqN87dzi1KVnGlACpYAijp6yy+uQ+nBVJlsT+G9g1IrdOBPxf2lfhAI20zdTl
	 YPizHsGFfVpjx+qw3Q/93Ghb4Dx939v87hOWW13H8xo6Vd7m+8gIebykA2M7Bljfte
	 8V0Twp32F5CiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDd675Lhqz4xM5;
	Wed,  3 Jul 2024 21:36:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 19/20] powerpc/xive: convert to
 of_property_for_each_u32_new()
In-Reply-To: <20240703-of_property_for_each_u32-v1-19-42c1fc0b82aa@bootlin.com>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
 <20240703-of_property_for_each_u32-v1-19-42c1fc0b82aa@bootlin.com>
Date: Wed, 03 Jul 2024 21:36:47 +1000
Message-ID: <87ikxmk8q8.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luca Ceresoli <luca.ceresoli@bootlin.com> writes:
> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.
>
> In this case only the 'prop' variable can be removed and not 'reg',
> because 'reg' is used in _previous_ lines of the same function. There
> is no side effect because the of_property_for_each_u32() macro being
> removed would anyway write 'reg' bwfore reading its value, and 'reg'
> is not used in _following_ lines.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  arch/powerpc/sysdev/xive/spapr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

