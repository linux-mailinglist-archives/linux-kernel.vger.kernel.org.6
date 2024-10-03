Return-Path: <linux-kernel+bounces-349321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EE098F44C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092AD1F21ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED431A4F31;
	Thu,  3 Oct 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c6JpXNhi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B652E419
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973240; cv=none; b=IsWXjs3JQPaOV7EpDluIHK7jXjHZXdfZxUhkeqp46p46Jh92dCLGJp/m8GnkbMoTpZtJ/FEPNNK42u9SY2SSjbGdlQYlef4fysKPxAPhzKjcL+yvYIsMiagnzX7n8ErIaIXoVrNNGWOB3/Prb0R09ugqayuvwZYoWt1WgYpBTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973240; c=relaxed/simple;
	bh=aDvtngM+zTJETYYM8NjUWYxvE//Q8V8BmTxKgQqU6og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlL4zpIrTChlN7PBtPoiYBOjv7ldOf3HBqj3g9L/ZQavYCl34cNdUEKohmkVsHVFd0/ER4xW4XoPgkYqReYJuJrPkgQLdhm8wjbn3PEPHnW+RRmNcIlYNoc6rk8ud3s8ZZzmo9ShXWkon4cW/CueNJAsPCnoVWTmB/ftT6BYXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=c6JpXNhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED16C4CEC5;
	Thu,  3 Oct 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c6JpXNhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727973236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDvtngM+zTJETYYM8NjUWYxvE//Q8V8BmTxKgQqU6og=;
	b=c6JpXNhiGvdSOaFUMXQoarBQz+bGN/kW6/J8+hqEE39+oFgrfSaiL0FFj+NbxJqr21vc/l
	XyC97d/QlESAg7V9GWH8N5tHurtKsWnxjoNpuIrQPwyHe732Tc2bN2lQD12ebhSdI+nhzn
	FkCvCB50FOwRCrtxx0SPO8Sytcxkej0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a4f3bc08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 16:33:56 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:33:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, mpe@ellerman.id.au
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
Message-ID: <Zv7HcuhVH1uM9BNI@zx2c4.com>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>

Hey Christophe, Michael,

This series actually looks pretty okay to me. I realize ThomasW is
working on more generic cleanups that might obliterate the need for
this, and that may or may not wind up in 6.13. But, I was thinking, this
seems like a good correct thing to do, and to do it now for 6.12, maybe
as a fix through the powerpc tree. Then ThomasW can base his work atop
this, which might wind up including the nice lr optimizations you've
made. And then also if ThomasW's work doesn't land or gets reverted or
whatever, at least we'll have this in tree for 6.12.

Michael - what do you think of that? Worth taking these two patches into
your fixes?

Jason

