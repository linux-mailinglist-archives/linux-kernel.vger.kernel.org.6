Return-Path: <linux-kernel+bounces-371968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65F49A42BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C14CB216D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98220264C;
	Fri, 18 Oct 2024 15:42:52 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E62022C5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266171; cv=none; b=ndSFmnE5/Mh/Fq147lwxgcE4K6+JW7MpbXEDMRTiJCUkoFEl9MHCy2yR2tawI4g/amZLOo+QePpr2gfAoj9hA0bpP1hNT4aBstnHfXChcy2XCv9ixJbYpY+2NpuRYdn5rj1taKT7afIPzUnK+aS8qGXlJ8f6i71bYH5bJwsyrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266171; c=relaxed/simple;
	bh=YvP/aOKOmBoYDHIAPsx6nTaYlcWOR+x52YYYhH2MOFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8zAYfNTEkUYUJXA40GVMQUInOmQw9mIGf5Vbb6twtvJTzkOOdfPv9WviQPv/PB2zo2tqSubyPfTo1Xo1ijAqkuZJl3F2YV75jpCmrZ2J6Tb6pVyu72XfKthnijft32A3uQX48gE7NVbVy+YKjzcf9/OrGwuhGtcqLp2K/MXN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 49IFck73006368;
	Fri, 18 Oct 2024 10:38:46 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 49IFchtv006361;
	Fri, 18 Oct 2024 10:38:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 18 Oct 2024 10:38:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, maddy@linux.ibm.com, arnd@arndb.de,
        chentao@kylinos.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.com
Subject: Re: [PATCH][next] powerpc/spufs: Replace snprintf() with the safer scnprintf() variant
Message-ID: <20241018153843.GJ29862@gate.crashing.org>
References: <ZxIcI0QRFGZLCNRl@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxIcI0QRFGZLCNRl@mail.google.com>
User-Agent: Mutt/1.4.2.3i

On Fri, Oct 18, 2024 at 09:28:19PM +1300, Paulo Miguel Almeida wrote:
> The C99 standard specifies that {v}snprintf() returns the length of the
> data that *would have been* written if there were enough space.

Not including the trailing zero byte, and it can also return negative if
there was an encoding error.  Yes.

Not that this matters at all for your patch, so why mention it?


Segher

