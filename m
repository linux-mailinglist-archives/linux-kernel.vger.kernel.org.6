Return-Path: <linux-kernel+bounces-400342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3669C0C17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2361C222FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC38824A3;
	Thu,  7 Nov 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXaGhoDS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3A212F0E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998825; cv=none; b=UtcZj/iq4JuZpQeD6j4R24YQJ8p/8dB2YsDNIhpEHaaZCWGBR2UdVp5L5oz5ZewHBPwdlGBIR+vVoATczn/zkb61HOElhQv6bm8YGffsQ5y0L1fh2M+U5tDnsAehLYlgxlk5om1mqml2BrKApDd6SV7JzjEyp6jWoKRfeQP1vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998825; c=relaxed/simple;
	bh=fmEMZSN8aYDktJAftW6kTuaO7wJAwwzSFJuKFKEOrmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LbpFsHe1QKn/5SDuQKzkCi+EdS/dg8XVv68zmkoCkh5KODyy0+jflrHfYK+zpOCZ4bDTYUYIPxJUcgDJJUdZ/WdVUUZXQUJbpnJMGqH4ZZfJ45MXhGvhAtAWVoi1rcs0OMdy0V91Ts9VKP7bKbinfXAkVN3C+bYZct5PF9Hlv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXaGhoDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204B8C4CECD;
	Thu,  7 Nov 2024 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730998824;
	bh=fmEMZSN8aYDktJAftW6kTuaO7wJAwwzSFJuKFKEOrmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bXaGhoDSo3pT7F+q6VnOjjxAJKmMyTf3z43Vw6z3BrqOuoGzRAup2kUvvObIE3bsx
	 YmMIgnVEo7EwHtOKAmdylTlqn6vThURcB8YPWkE58fsaQqXgyaiqptHx/ERu0tZP0M
	 /wxwRFenyvfTGxbp1M6NqafnaH6cKXWDL7gB1Cz8taM6FICIaKlJCsbR6GZ449xv4Z
	 AFHHO0Q0j2D0JuSkw5muppQSdEz5lsitrJjEecaHNXR1Yx+bR4rJqtd36F+bbdAv4+
	 ZWO0a0kZQoFMBoAWQQNckpCCnRzXQOemPJB2EEu/UMgA7tt0LFchvRLD90gh1AleDo
	 f0NyZ8bXMlHtw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: tudor.ambarus@linaro.org,  pratyush@kernel.org,  mwalle@kernel.org,
  miquel.raynal@bootlin.com,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>
Subject: Re: [PATCH] mtd: spi-nor: core: replace dummy buswidth from addr to
 data
In-Reply-To: <20241107093016.151448-1-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Thu, 7 Nov 2024 17:30:16 +0800")
References: <20241107093016.151448-1-linchengming884@gmail.com>
Date: Thu, 07 Nov 2024 17:00:21 +0000
Message-ID: <mafs0cyj77zdm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 07 2024, Cheng Ming Lin wrote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> The default dummy cycle for Macronix SPI NOR flash in Octal Output
> Read Mode(1-1-8) is 20.
>
> Currently, the dummy buswidth is set according to the address bus width.
> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
> host to read data 4 cycles too early.
>
> Since the protocol data buswidth is always greater than or equal to the
> address buswidth. Setting the dummy buswidth to match the data buswidth
> increases the likelihood that the dummy cycle-to-byte conversion will be
> divisible, preventing the host from reading data prematurely.

Makes sense.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

