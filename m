Return-Path: <linux-kernel+bounces-399789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC859C043B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C612E1F224AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC220C485;
	Thu,  7 Nov 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Natq8Mpc"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933220C483;
	Thu,  7 Nov 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979365; cv=none; b=cdAT8h1YUq9axjn0mhan8JS/C63qBXu04OOUk7EdvtcsdQvyZM2GD4lZ9UAF3cRMwrl1b9ftVlcsZE1KZQadQjo2xsx6ieu4C1CCMJYEF5jsiWwwx3qElkA9PE8y1m1sFAW1eiixqZoXtyJP9d4D9KLjuyM6IruC7viDUKA04u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979365; c=relaxed/simple;
	bh=Qu3sLBuA2l/huyDUtQbZTBU6aoM9vYd0HPB2dAFL//0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ViEy5ccXfws94WQwXesZYGEXTz87mJC3dgSlUq2Szxbk4fcTOKSJcKQSH7sMThSUS9yh5/AsL22byvIQz/Kcwt7/sWkSvm/0EzJjbZwgC5pAM+waEMsgCFfAYBpgoKuZ7sxczp3YN9YPH4qe763/bl81BtMbYK2sCsuISRHN1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Natq8Mpc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730979357;
	bh=Qu3sLBuA2l/huyDUtQbZTBU6aoM9vYd0HPB2dAFL//0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Natq8MpcvRLo8792rq10uzgXADLxKDmvQR4WmIHLsNxlKVbDwwFth3TYqjZr4rF4f
	 gbBSMOgDumUl8QS5BAsImk31g+X1EIm7PcQ7W1hQf3D5i/bZWR0wEiH1qNLjHIOD89
	 sb6MEmnQXSOUhDinrRe0qAMVoeR7Mbf+mqXGn2upl0UP93H8E36bVAS9UNDw8U6ykS
	 7lLZyEqWobbNGobltBU3x358guCheZHNAlhYLEq4lLNDuOhDlRvYYGhVneQWCbEkVV
	 LIxlox5M6HKta8CaHTeKnEy0FEzFicWDFg4P1t2Mcs0P4mN32rBKNBEKLHNWb1UWw8
	 tCwLk+K4i2zeg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xkg4Y5S1pz4x1w;
	Thu,  7 Nov 2024 22:35:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells
 handling
In-Reply-To: <20241106171028.3830266-1-robh@kernel.org>
References: <20241106171028.3830266-1-robh@kernel.org>
Date: Thu, 07 Nov 2024 22:35:58 +1100
Message-ID: <87jzdfcm3l.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring (Arm)" <robh@kernel.org> writes:
> While OpenFirmware originally allowed walking parent nodes and default
> root values for #address-cells and #size-cells, FDT has long required
> explicit values. It's been a warning in dtc for the root node since the
> beginning (2005) and for any parent node since 2007. Of course, not all
> FDT uses dtc, but that should be the majority by far. The various
> extracted OF devicetrees I have dating back to the 1990s (various
> PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.

I have various old device trees that have been given to me over the
years, and as far as I can tell they all have these properties (some of
them are partial trees so it's hard to be 100% sure).

So LGTM.

cheers

