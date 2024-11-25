Return-Path: <linux-kernel+bounces-420594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7089D7D04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EFE1636B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D34218BB9C;
	Mon, 25 Nov 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsno5DUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20218B475
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523880; cv=none; b=FQkiaQArVjID6/Dx0nfrEldUNN+OpKn9TVaa8w6qSS4v50caQgVkApz+08l8I7vg1BHLmt7spsGMcSdPOobTvy/ZFjY9I5+gmkU/7A7dOuz4s41psqeT256U5YxkWa8n/8N3EzgZ/Rcl4w4wq+QqaHXxdrvjmu+Vvdzle/SdWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523880; c=relaxed/simple;
	bh=lFy8jCbAa4BewXdTwk2+qDv8pSO5e70DGDXVWy7ZdIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWfatEoTkwt3Azu7RcFFTDuECagOkBYsyeGGHAdjhkOcSHiXJUnlMjn2Xtc7FRjGmCezAJeGgn5m1r/zmNTxPiZYZzRzBggWBDJgplnTZwXXXsT1ngFKuGFrXgO30LNIRNqr72OfysohCKNJDa/dxxMG1kjLfWagI6vWw6V7zzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsno5DUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818FEC4CECE;
	Mon, 25 Nov 2024 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732523880;
	bh=lFy8jCbAa4BewXdTwk2+qDv8pSO5e70DGDXVWy7ZdIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vsno5DUBYpigSJD6VlxPh87VBwhaCezi9Q0OkTpBfsWuVM9NlW4ZfKnQVoEgWtrWO
	 QXF6Pf104+Lx85jsaoAddG4ffDhme/+Rxa+t31flgoglF4BUfWmhPj1X7YOXJUMKww
	 0kx7aT2Sc9IptrGqHfbvPJuEvTMpcvJHJHPxqbxYAOg284OFx6RZ+Cvm6XVVzpuuPF
	 1bczUVjyzKnT3m3q8jLh5iTfHBkfjC7ZKkxw/+RWeV0hwx1fiklJ9rjD2bpo3t6x3u
	 FF5799IQsaYMZqMWVdaCPWt6ApIuRNW9q9RN0lY3KiRs8rK2AZpv3vzkn6TLxMbmWh
	 uu3tGQceAnvTg==
Date: Mon, 25 Nov 2024 09:37:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH RESEND] x86/cpu/topology: remove limit of CPUs due to
 noapic on x86_64
Message-ID: <Z0Q3ZNoQsoiCAiiA@gmail.com>
References: <20241124174510.2561-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124174510.2561-1-ffmancera@riseup.net>


* Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:

> On x86_64 the command line parameter "noapic" should not limit the
> number of possible CPUs, as it only limits the use of IRQ sharing or
> device IRQ remapping. Only on x86_32 the command line parameter
> "nolapic" limits the number of possible CPUs to one. This restores the
> behavior previous to the rework of possible CPU management.

So what's the motivation? Arguably the x86-64 boot option behavior was 
weird: a working local APIC is very much needed to have an SMP system.

If we want to disable IRQ sharing or device IRQ remapping, then that 
should have an appropriately named boot command line option. Does some 
system require that perhaps?

Thanks,

	Ingo

