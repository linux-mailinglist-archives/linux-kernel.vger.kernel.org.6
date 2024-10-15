Return-Path: <linux-kernel+bounces-366011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC999EFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710931F2591E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712B1B21BA;
	Tue, 15 Oct 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyqCVfn/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B21FC7F6;
	Tue, 15 Oct 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002870; cv=none; b=he1moADn3XQob6KJ2i+sVAPa7oWCPnnnF11Hh9ndauOQFDR/fphzctFVtxHXB76IriZLRTaWZVkb5aP5ZV1HVI4INUBEQQrv19DRJ4RnKf1pr2NnP7BmjVGKAfjwlvpTrg0h4e0pYdQwdRrSPgYAfai/erF0RvkB2enOkgiRJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002870; c=relaxed/simple;
	bh=/zCdooE819i7xDtG3txZiBijfesvKbqWcuvhOrqvJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/GTWQXswR4ge4NcnpV1zBXnlv0pziW+7/W7vCTU9X5CraL9+JdX9Uk1JKImUzkdAr+ROsX2wHYVWe5RCz2wAdM8VgS1suAObIrMxLKGEfIlUjOcgbjFLn//l03DTDXlNM5fugzrHx489e7nMVUvxt/JtsSIIOZ5zZ00iyKLcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyqCVfn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE6AC4CEC6;
	Tue, 15 Oct 2024 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002870;
	bh=/zCdooE819i7xDtG3txZiBijfesvKbqWcuvhOrqvJfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyqCVfn/XZ/NRpCYx81j//goKU2q5femDNqlNjExinmcKOT78oCti0LLDOTPJybop
	 BYGe+zNsc1Ga2NWRwtrL6FtjzQ2FeFDGC55d8/vvVHv4X7B2CGBIbO6hdA1IIBHOGx
	 Fx8QWeG5dGUjZz7qriNtfoQdCBpNs4CT8/TBqD9808dbf3XT2EN91eJ+Y94zi1lS32
	 TAwJrM+Ld/uPcLoOjQs+QaJ+R7Cy60COfFo1pfe+h1pcJrjqHbkJK5pOOLKvz4IB2k
	 BUC7m0MwUz2/YkYWK0J0OyeHGox5YVsOgJbz57selgV5H/Wsag7DccCERiAbnQoGW9
	 aOrDZfiSVIcjg==
Date: Tue, 15 Oct 2024 15:34:26 +0100
From: Lee Jones <lee@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cs42l43: Disable IRQs during suspend
Message-ID: <20241015143426.GK8348@google.com>
References: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
 <Zw0AlU9QsWpZs2Sh@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw0AlU9QsWpZs2Sh@finisterre.sirena.org.uk>

On Mon, 14 Oct 2024, Mark Brown wrote:

> On Mon, Oct 14, 2024 at 10:52:02AM +0100, Charles Keepax wrote:
> > The ASoC CODEC driver masks the IRQs whilst entering and exiting
> > system suspend to avoid issues where the IRQ handler can run but PM
> > runtime is disabled. However, as the IRQs could also be used from
> > other parts of the driver, it would be better to move this handling to
> > the MFD level.
> 
> Acked-by: Mark Brown <broonie@kernel.org.

Do you want a PR?

-- 
Lee Jones [李琼斯]

