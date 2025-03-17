Return-Path: <linux-kernel+bounces-563576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C858A6447E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEBE7A5681
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93F21B9D3;
	Mon, 17 Mar 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuV//NN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF207E9;
	Mon, 17 Mar 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198327; cv=none; b=qNNXMuvEVIyKClwlA7yNFMBbEVyC7c8JaDX+MSpneA6h9PujLGFo0E9k1zdinry0bx6cV6XRneooSstcnHxT5ud46RwaMOj4zv4YsPJ9G2lEEx5M6NKa9zR6HaNrS329NiXO4MoAxFouoPXLVW9CzOVc1OyRb0HwEgbktPa82QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198327; c=relaxed/simple;
	bh=2v0do6VIwqpU4cRxJMLNn3PrlCZX3QFEq4K6WtzwMiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5PqwOc1FZLSu13usR5+ygP0r2FiNIuR+fbbpuCmrMd0/kMWIGfEjzrK7s/eZNuQnEjhv0U+aTYT9PLQY/7AGABPWEL1eLFcnFfH6R23cTbVL3x/TPt6mnMjD9De7kRSj7r9sljqRgCPJXLU4nj5nvs6EwhAhYaOB1LIBr/S504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuV//NN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEFAC4CEE3;
	Mon, 17 Mar 2025 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742198327;
	bh=2v0do6VIwqpU4cRxJMLNn3PrlCZX3QFEq4K6WtzwMiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuV//NN3pIxOqg2j932/2V9a+/OMoOoVL8BuT9p5TihirVs6x8hVQNAtKiyY6ZNfD
	 C8FRvfBjJYIYPrpe9ihKUGaZFVwqn9cf10Qa2nHgy/2ATcUYG3+P5R5h3xWdntjkdC
	 N022U/cHp6CrLitdcGacpX8w3yU175OsJ9iVTh+pmpSwq1snREKhyCNi54PPyLU3Wd
	 BWEEyDpZpOMQjYxNMry05JHKVFyxgcR3xXg5SFZaqXhD1cKKkuP06igfA3crte9uUL
	 m48Nx30znERuY305BNEUGbV849ih3V1bHplbvV9MRLzcwjr/SlBxlBJMPPfrCV49pn
	 xeKTrxRx3ceew==
Date: Mon, 17 Mar 2025 08:58:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: dmukhin@ford.com
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/early_printk: add MMIO-based UARTs
Message-ID: <Z9fWMaX25c8GIaQK@gmail.com>
References: <20250314-earlyprintk-v2-1-2bcbe05290b8@ford.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-earlyprintk-v2-1-2bcbe05290b8@ford.com>


* Denis Mukhin via B4 Relay <devnull+dmukhin.ford.com@kernel.org> wrote:

> +	if (!strncmp(s, "nocfg", 5))
> +		baudrate = 0;
> +	else {
> +		baudrate = simple_strtoul(s, &e, 0);
> +		if (baudrate == 0 || s == e)
> +			baudrate = DEFAULT_BAUD;
> +	}

In standard kernel coding style we always balance curly braces and 
don't skip them in the single-statement case. Ie. the above should be:

	if (!strncmp(s, "nocfg", 5)) {
		baudrate = 0;
	} else {


> +	if (baudrate)
> +		early_serial_hw_init(115200 / baudrate);

Hm, I think that division will go poorly if 'baudrate' ends up being 0 
in the 'nocfg' case ... ;-)

Thanks,

	Ingo

