Return-Path: <linux-kernel+bounces-225878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6574091369E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9291C2143E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00026F2F0;
	Sat, 22 Jun 2024 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hafdVrro"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A203DDCD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095617; cv=none; b=trS2ivH/n3deRu9vCcVRAQcHwsdcr6nAwhhuPxEmaxz7CvfFrbZ7ALAB5jITPimBc5T3B89d02LFsJtqydZdKhdGgB7Du85RT8ZeU6nB3iPuvbmYVVn9diOZYQLP9tESePj//i/s8PvryN6DpwyfPkZVBOWsEc2QAUbyEGARr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095617; c=relaxed/simple;
	bh=yXHDuCH7yhsxHOLDOEQwKUtxydAJfdzce4SGbTwKYVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpalZIl+ImSibFPLfASQYaBFturtpAykVuzdaO/QV+OjaX+B2GQflHLCRNsDjK+bojEOUGAbrYEp0BL78qwHFBshNuE6VHXBEW+8CrhrIt4M41+DBDa1DGUOl2AuD1l9qtqnzNtDvwGoTeoWf0jOmt97LFJqScKVgw6zT899H8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hafdVrro; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C7E7FF805;
	Sat, 22 Jun 2024 22:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719095607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yAig6dC8mmO+ffpgNNjwAU36oDbyKtV33/YZDermEsg=;
	b=hafdVrroY7TjNpxQqyNnhczBTzWc8Cut1Wq4JkxN8tH1u76bV12HIoKgZqoEUV9Htsmkh+
	LkMpZTcSJz3B1pAVnHiANxWtE3ewDG3QlsUlJtIecEvqJiMI/kP3QMibwi+MWj+QSLM2r/
	m4rgoleFVfahOZA+yZ+g8ysz2OCPKiYx4pGkbyF9s5FMYeu+JC3JZCHwwVluq5pH7efIRB
	vdV+EYnZ/SJ+h7ZlNkDLa7Hz3vLnFw6ffLhS4eOBd8gy2aPTVnXvAPY5NMEb6TOvzXmjKX
	fSg/XPUMHBfYoffN8Ff4GBBmC1SGY9f4zIYmIuEUEGERrvfXlYJmzGUQAV/UyQ==
Date: Sun, 23 Jun 2024 00:33:23 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Aniket <aniketmaurya@google.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: dw: Fix clearing queue thld
Message-ID: <171909557750.2164405.17868065814725354783.b4-ty@bootlin.com>
References: <20240611112650.411214-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611112650.411214-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 11 Jun 2024 11:26:50 +0000, Aniket wrote:
> QUEUE_THLD_CTRL_IBI_STAT_MASK is repeated twice.
> Replace with QUEUE_THLD_CTRL_IBI_DATA_MASK.
> 
> 

Applied, thanks!

[1/1] i3c: dw: Fix clearing queue thld
      https://git.kernel.org/abelloni/c/ed569e6cb3d7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

