Return-Path: <linux-kernel+bounces-370765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DE9A31CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762531C223DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BFF3BB22;
	Fri, 18 Oct 2024 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt6hjR9T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965320E30B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212756; cv=none; b=Vc8DeA7jHG8Cr2rJrGyjU4iHKZzMoJG4cUlqW00CZb2gAO+OQG4x4Che3fe77zbkRNbm9XkPefmPUwjNEOLpAwd7iCn6FY2xL7HsKoJTsBRXBbVj6wj7jF5V4DHQAQyz11Cg6yQExdhn8dTfI98vvhzlnIu6qi5GdFAcKMWaGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212756; c=relaxed/simple;
	bh=wPRRqlv1/ki0LcaRlxx1RH0ZpcvrgzNnPp5Ea3C3ews=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEn4Vrv4p1Q0kVe+W8MadEPOvYUjlAWU6HvYS1Ns21TuX2xCaTzYHX41NAJ8GngA0xZuKVHUt7Jc/7IsVX2Ush4Yv0i6Q2x/UcWaPBuRktOfiRTytdDpeepjrFjE2v+gtaXXyWPhFZR077CYO6INXqnWYDXClYZ6YftskFzLyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt6hjR9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF6CC4CEC3;
	Fri, 18 Oct 2024 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729212755;
	bh=wPRRqlv1/ki0LcaRlxx1RH0ZpcvrgzNnPp5Ea3C3ews=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bt6hjR9TT+QN0GQsUWb8A36JmF+cR1yxW08mbKeg2uJuZil8BPi6C4M6Z2W/QeNV4
	 GR52nSwZR2zNUK4Kv2M3SNOv/nWZ0Yf5ZpRY9a3ww0SGFK/7CSi3FZxhQ7oZwCorkP
	 JWfHh4vmnbsRn45L0VisnfbJlG4h3ZnuqkxmAm4fzgVywCWGnL1EAHJ50LX+xcOyaF
	 MCb+1h0yy5u1NnRc1pR4GTm9sSLUOL1BBo0QZBDKMNAAN4VV/haxhVWlvNF+qK/qoV
	 fSk6n/wXEi9mx1D8/9rzWtFeECf5JgTEliV7UoutFvG0kILP5X/RKCsY7wnb89/64C
	 tGlF1ZXbTAVEA==
Date: Thu, 17 Oct 2024 17:52:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Phillip Potter <phil@philpotter.co.uk>, linux-kernel@vger.kernel.org,
	Jordy Zomer <jordyzomer@google.com>
Subject: Re: [PATCH] cdrom: Avoid barrier_nospec() in
 cdrom_ioctl_media_changed()
Message-ID: <20241018005233.styuaj7eyn7b6nux@treble>
References: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
 <dd1712dd-1485-417a-81cc-482d7dd26a11@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd1712dd-1485-417a-81cc-482d7dd26a11@kernel.dk>

On Thu, Oct 17, 2024 at 06:33:24PM -0600, Jens Axboe wrote:
> On 10/17/24 4:09 PM, Josh Poimboeuf wrote:
> > The barrier_nospec() after the array bounds check is overkill and
> > painfully slow for arches which implement it.
> > 
> > Furthermore, most arches don't implement it, so they remain exposed to
> > Spectre v1 (which can affect pretty much any CPU with branch
> > prediction).
> > 
> > Instead, clamp the user pointer to a valid range so it's guaranteed to
> > be a valid array index even when the bounds check mispredicts.
> 
> It's a cdrom, and media change detection to be more specific. I really
> don't think anyone would care about performance here, it's not even
> a hot path for a cdrom driver. That said, I don't disagree with
> the change, just don't think it'll make one iota of difference
> in the real world.

Fair, though it's also about hardening as barrier_nospec() is only
implemented by x86 and powerpc (see 2nd paragraph).  Most/all arches are
affected by Spectre v1.

-- 
Josh

