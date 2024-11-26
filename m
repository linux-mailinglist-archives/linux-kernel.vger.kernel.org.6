Return-Path: <linux-kernel+bounces-421840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0D9D90CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EC2B24474
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A142A80;
	Tue, 26 Nov 2024 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="R3WKrDKY"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC771A28D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593001; cv=none; b=pJPjcQerHR4eIHddx+dpLz2aF991yxV5Kc28MeCnNYYBccIBplMNvHJXeiGm2YDRvYW/B2Is1AERMLPczEwytxFOU5Os04fSQMMoxsQKmiufu9O7lLwBKQe6l4lHBsJAKTr6Tlo9qjEt77OzChD0I68yjloLPcfchkjjQjIAwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593001; c=relaxed/simple;
	bh=QYc6U6l2LP084zljP9h6GyNy4Bv4iwI/lb8bqGR+7f0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzopwjMxz7Wk3E7LTy+66heKKTnTPzmXfz9ysUq5+ZF1TMWaa7u2LWow2gvVQbtTU11LkaL4vQY9U5ssT14PRlC5S/WTisrNcnLhUpKq+Nz/4UZCszAIWpWKkhUqNH9n3akPEdSt1T62lNob07MxPFp8eCCPccWfxX+9mVZQdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=R3WKrDKY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732592993;
	bh=1GDroj8cvLi8AxibFvo2uc0aSiYUK5hkkTcQYG+0QMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R3WKrDKYw/ByHHEa3PtgTcc8Xvh/auZj8U5ShHkBVdPy++QKCXrk6InR/jlQz2g46
	 Ho3w7cBt7fIt75TfsDMPoccD5p0suflRBhbppyLZX0SOea3+KT1vLVP6q4j+hA7TNd
	 QtKRqI0xD++3UaInC37uz3VJIV+X8ZM3in0MRSbQEwzqA++giq9uCV9m7G/E1Av0jC
	 2j6tYOINNtTiSI3JxBWbOh0dyPlF/OyYE7voVaU7kBqyNlwf1Bj3YxOaFjgRX5JLiN
	 oBNtQU0aNHOTFz9t5zgiM+A/yBhv09Us81gDkbiOP93txeBtDtCFzbtpqfwPhV3SYX
	 BqQqPONaaOXRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xy7r163rdz4wcy;
	Tue, 26 Nov 2024 14:49:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 geert@linux-m68k.org, arnd@arndb.de
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
In-Reply-To: <20241114210418.GM29862@gate.crashing.org>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114210418.GM29862@gate.crashing.org>
Date: Tue, 26 Nov 2024 14:49:49 +1100
Message-ID: <87mshm7ixu.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Fri, Nov 15, 2024 at 12:11:04AM +1100, Michael Ellerman wrote:
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
>
> This was used by all non-IBM 970 systems as well.  The last was SLOF on
> JS20 and JS21, about 20 years ago yes, and I doubt anyone uses it still
> (I don't).

By "this" you mean the CHRP standard?

At least in Linux the "CHRP" platform has always been 32-bit only AFAIK.

My memory is that JS20/JS21 used the "maple" platform, which was a
64-bit only bare-metal platform, possibly it was actually == CHRP, but
we didn't call it that in Linux.

But maybe I'm wrong, you were more involved than me back than, and it
was a long time ago :)

cheers

