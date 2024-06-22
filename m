Return-Path: <linux-kernel+bounces-225776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA19913542
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 19:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4FD1F228BC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897C1755B;
	Sat, 22 Jun 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HcmHBB/O"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A035BA39
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719075925; cv=none; b=RE418F+/sw1L8HEpALwz45hz05o9zUOJ+hl0ZxhbOkBlBowt8ZElUE8Q3xmhXNk2HYObKWgpIGzVboBuRV+SqSNQgCMUvkxNNDAjAcBNFYPWz9VCh2nPbCNRT8eK+dcJ2wF7IXtyJzlfh65m/I71BkFw/Q3KuCU6r0sGRvHsK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719075925; c=relaxed/simple;
	bh=dLTdRMsHypGHOmYS2h9jl/mZNl8Zk2CDSWaZWF2Vva0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FayKJd5OZc5p7wMQh0mA+PmsWIjRU/sfXh2fhJH0obnv/99pykRDGQLXq/aUsVPGK7vR+S4EiNhqixVyBrb0OOQdD8mqeTtd4j4WPHcIG04Dxw9HLOJOY9uXGtQiz0WYreXjaa0G/sT4pzgg+sY40mvE3W3EKJHZryHVdi2B040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HcmHBB/O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UTD2xftu2z4JZcOB2nVc3UtOsaUvmH9Ox+gvHCg/8tg=; b=HcmHBB/OWsj2Y2o0OOwcEhEaPM
	Ig/Ymu5vverQTnY0DPSFlBSXIDBGf1/9GI/N0qdAmcoKcf3FsFXZjzdGEjm3ABsjOj4SABBcb8Xib
	2x7UF2Q4PYEbH+8dkoRDjzqclWxtHE5+JGX+fWz4vC8pfrrSSTx0b2jzinGwAHm+CFsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4Ag-000jsY-DF; Sat, 22 Jun 2024 19:05:02 +0200
Date: Sat, 22 Jun 2024 19:05:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Wei <liuwei09@cestc.cn>
Cc: prarit@redhat.com, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH V3] ACPI: Add acpi=nospcr to disable ACPI SPCR as default
 console on arm64
Message-ID: <f706cb73-4219-47fb-a075-e591502be7c2@lunn.ch>
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <20240622093521.71770-1-liuwei09@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622093521.71770-1-liuwei09@cestc.cn>

On Sat, Jun 22, 2024 at 05:35:21PM +0800, Liu Wei wrote:
> For varying privacy and security reasons, sometimes we would like to
> completely silence the serial console, and only enable it when needed.
> 
> But there are many existing systems that depend on this console,
> so add acpi=nospcr for this situation.

Maybe it is just me, but i see nospcr and my brain expands it to "no
speaker". Adding to that, your commit message says "completely
silence"...

> +			nospcr -- disable ACPI SPCR as default console on ARM64
> +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> +			"acpi=nospcr" are available
> +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> +			are available

How about putting the word 'serial' in here somewhere, just to give
users an additional clue you are not talking about a speaker, CTRL-G
etc.

	Andrew

