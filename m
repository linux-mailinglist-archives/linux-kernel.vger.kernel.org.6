Return-Path: <linux-kernel+bounces-364890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB499DA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0707E1F218FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3875223;
	Tue, 15 Oct 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFkFaldU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E066EC5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951461; cv=none; b=JkTJeeddZQk1Em5FeZ4kkHkBGz2b8Jpf8WAX28VlsGxoUz8Wr6CDUS19vivL1D1wx0a7vMztN6hp82sZ82MgGZKQcArEr/kwoPvXOb+YurOzP+++kg1gJ2bQ70BN3UL+Pk4LnWx7sOwjqjlSpn3TTHgDLLktvbiKdfl73+7EU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951461; c=relaxed/simple;
	bh=ngIrxuzzNJwLiIU1IpPjPiIt+o+lZ0H9rQMl0ewpd7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLV9q/K4ZGsLilbk4k7KpLLhM3VIuHcoBr+4Kum8Un38Pev2esg5mG+ynel6BEzcHQ/4xBVsL2WCA3RNwO1MrfU1JqRcAqDUo395cXboxYmCbx0haqJTlgjHLSRBdnakkQPsZdk6xe/0B0TBzaUHvVoC7UG1YEf2zwxm3v033TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFkFaldU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFB9C4CEC3;
	Tue, 15 Oct 2024 00:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728951461;
	bh=ngIrxuzzNJwLiIU1IpPjPiIt+o+lZ0H9rQMl0ewpd7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFkFaldUaFxuDPfvZWF2lzyFsx8XROqUuMQTxvhXZh22+qnfkoy7cQbgxDqV8wf6f
	 vlAtBtTsJMd66qjv7arnsZCewK0v/c04MpmUa9LGnvdyJZ/AVJn1R7qN5zp5Vd+tJx
	 29vRSJkbs9olZUxDpBBhyY2RaYOowcUv3Ttmksw+GVx7iZGCqtms9goi/6YNPIlttb
	 ECgvz6Ui44dKEWyR5x9tnsvWu8J494xYrKxTKK4j2iwRYRlnDx+xHu557Vebu202hO
	 wOIxL+Lr12kjlnLOc71pDoGaqGQ2KMMvGwnw2UIvdHGnl1MVDBdbgbbkM/ZrIKFZOS
	 V/z6tgX1dPVcg==
Date: Tue, 15 Oct 2024 08:02:19 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: NOMMU: Fix exc_ret for stack frame type
Message-ID: <Zw2xC39-YkNlL6qT@xhacker>
References: <20241013132520.2848-1-jszhang@kernel.org>
 <87ba9595-6229-4a79-aa65-d76567ef708e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ba9595-6229-4a79-aa65-d76567ef708e@arm.com>

On Mon, Oct 14, 2024 at 10:54:00AM +0100, Vladimir Murzin wrote:
> On 10/13/24 14:25, Jisheng Zhang wrote:
> > commit 72cd4064fcca ("ARM: 8830/1: NOMMU: Toggle only bits in
> > EXC_RETURN we are really care of") only sets BIT[3] for Thread mode
> > and BIT[2] for PSP, it leaves BIT[4] untouched. But there's such a
> > case: the pre-linux env makes use of FPU then the BIT[4] in 'lr' is
> > cleared, this brings an umatch issue since the NOMMU kernel doesn't
> 
> Can pre-linux env disable FPU before passing control to kernel (which
> is, as correctly pointed, doesn't know how to use FPU)?

IIRC, I did a experiment like this by clearing the SCB CPACR related
bits, but the stack frame type is still not correct. I searched in the
armv8m arm or cortex-mN's TRM I didn't find the relation between the
returned "lr" and the pre FPU usage.

What's more, IMHO, kernel needs to use the correct exc_ret no matter
the pre-linux env does, I.E if kernel/userspace supports FPU, then
clear BIT[4]; if no, set BIT[4].

PS: this is a regression: before the commit, the have-used-fpu pre-linux
env + linux nommu combination works; after the commit, it fails to
execute the init due to wrong stack frame type.

Thanks

