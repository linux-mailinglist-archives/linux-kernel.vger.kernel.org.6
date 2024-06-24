Return-Path: <linux-kernel+bounces-227382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA79915036
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5A31C21FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2519AD9A;
	Mon, 24 Jun 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSngehcO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8C19AD8B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240153; cv=none; b=soBR/vWiZKDktnnhREMWfib6erfqb6adA4SW6Fgerkb2WjeCdn/0ZTHCDli7Q+V8Ol0C/C8ZLTqLZtVaJw/QIggvf2DQBS0jVqYjmMLica1UTVSZaJGdzC3e9ehq5E2uAPzrx30+PrjUCQsi5XxFp8e7GyQzBOEiF28NwceJXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240153; c=relaxed/simple;
	bh=SyswWu1AqB72FEdhCtLY98PQ4fTBCKFZWNGbvA8Dmn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOri67em4B1qS9Lm8ij4j/dBLGhh/w8RJ4YSENGay3OMxhTzBeC1HbvmlhIvah7KZjSwWfz9ichsh76aQxiRgZB2/bDzq/g1ViOaPK470PbICCEdDZTw1TiYVlKj7VTguIxXqKMZTj1MuP3mI105E3Ll/F7wgXRypU9MZR8l4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSngehcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E17C2BBFC;
	Mon, 24 Jun 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719240152;
	bh=SyswWu1AqB72FEdhCtLY98PQ4fTBCKFZWNGbvA8Dmn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSngehcO0yI2RZYE6Fx1x4NNKaD2rIHcIsgUqv7WDPhC+S9TNy/HLtAO4jGX1eIWr
	 esyGUJxcfzYmspAzGjne+nbdM4ZnVdiN0brqUkc61sr9AbIbAojXj4xDVqBQao7693
	 cjuu5IjyEJPY1iPRAhFFsREgmedRbKiAFAm75JZXnq2LhM8aAemvyep3XgtZ/Y4+CI
	 Vq2v/HwPIByfWrMCYKn2DmyFvAKjTlKcpwR8ajmHwK/F4p7RpJi+YZ4Jp8YZWLtMBU
	 zr96MkEY4jCKuo3R9uqgjjiceS2W5sMrybhHETwGLsKMw/reEwzwHllmHLfI3TjyIn
	 YiXis8zSOyHxA==
Date: Mon, 24 Jun 2024 15:42:28 +0100
From: Will Deacon <will@kernel.org>
To: Liu Wei <liuwei09@cestc.cn>
Cc: andrew@lunn.ch, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	prarit@redhat.com
Subject: Re: [PATCH V3] ACPI: Add acpi=nospcr to disable ACPI SPCR as default
 console on arm64
Message-ID: <20240624144227.GA8706@willie-the-truck>
References: <f706cb73-4219-47fb-a075-e591502be7c2@lunn.ch>
 <20240624050404.84512-1-liuwei09@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624050404.84512-1-liuwei09@cestc.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 24, 2024 at 01:04:04PM +0800, Liu Wei wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> > On Sat, Jun 22, 2024 at 05:35:21PM +0800, Liu Wei wrote:
> > > For varying privacy and security reasons, sometimes we would like to
> > > completely silence the serial console, and only enable it when needed.
> > > 
> > > But there are many existing systems that depend on this console,
> > > so add acpi=nospcr for this situation.
> > 
> > Maybe it is just me, but i see nospcr and my brain expands it to "no
> > speaker". Adding to that, your commit message says "completely
> > silence"...
> > 
> > > +			nospcr -- disable ACPI SPCR as default console on ARM64
> > > +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> > > +			"acpi=nospcr" are available
> > > +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> > > +			are available
> > 
> > How about putting the word 'serial' in here somewhere, just to give
> > users an additional clue you are not talking about a speaker, CTRL-G
> > etc.
> 
> Thank you for your suggestion. 
> 
> You mean acpi=nospcr_serial or acpi=no_spcrserial? However, it appears 
> somewhat unconventional compared to the original acpi=* parameter.
> 
> How about introducing a new one, such as acpi_no_spcr_serial or 
> acpi_no_spcr_console?

I think acpi=nospcr is fine like it is. Just expand the acronym in the
documentation so that it's obviously not talking about a speaker.

Will

