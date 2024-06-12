Return-Path: <linux-kernel+bounces-210837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C611C904928
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7861F24462
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18180DDC4;
	Wed, 12 Jun 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DP7bpPDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CCBE55
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160194; cv=none; b=BPf0JXGzKHGs4jjjeK7MbtQ4f2DSoj1CMs+ErhwZkMKw2bQ9YBrhsGWkNtZ1JRo/XT4N5iBuCdDQPImDT+K432wgGtpjmqN5hacEjyxosHcaSHNHerIFyp3IokQfVq/FHfFRkFZwyWlYnerG1kudiu8Rp9Czi7heyOA4lkif7Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160194; c=relaxed/simple;
	bh=+1qtoHJhfx9Go+zeE8IKC/Ad/GnhlaEJcIWNTbAZ7m0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NqFDB1scZNzXMilrphAcp6Ra3IftDI8EddOVoNn3aFTtB1ihKp8jyKkr4f4SFDHJcJq4bdDTNuYEuyo4No9Krb1TKDLuUFCxEW1Ckpse6PcKILRhwnaJWnP4+QyrY24AWChJvzoRpm1SvwMRdhfVXxa43kskRsqnEEyoc4nIMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DP7bpPDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B727C2BD10;
	Wed, 12 Jun 2024 02:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718160193;
	bh=+1qtoHJhfx9Go+zeE8IKC/Ad/GnhlaEJcIWNTbAZ7m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DP7bpPDaCYbo5BPL/Cyx9UnzLpEBJKgLuIjnn2u8ihYZj2s4d4i4n8k9zxc3GFoXp
	 LPSb5RyCeqxRfD9JacDtiAuKrYFRdudWd32ItxxJ9dV9dQVcU5uFOWtR57Bb0q3Txl
	 jqDCiTXQyKmlMYT4CRp9B5N5noguS5Mn32yOp9pk=
Date: Tue, 11 Jun 2024 19:43:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rafael Aquini <aquini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Paul McKenney <paulmck@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] mm: mmap: allow for the maximum number of bits for
 randomizing mmap_base by default
Message-Id: <20240611194312.6048eba27c9ff3869040a35c@linux-foundation.org>
In-Reply-To: <Zmj7XAF5EcF40glG@x1-fbsd.aquini.net>
References: <20240606170026.101839-1-aquini@redhat.com>
	<20240606180622.102099-1-aquini@redhat.com>
	<20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>
	<ZmdJyK7Mm9rFCpv2@optiplex-fbsd>
	<20240611143239.ab8e4d96289a748ae1f8a480@linux-foundation.org>
	<Zmj7XAF5EcF40glG@x1-fbsd.aquini.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 21:35:24 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> > Shouldn't we make this the default (at least for 32-bit) so the
> > regressed kernels are fixed simply by applying this patch?
> > 
> 
> That is a fair take, indeed. I guess we could do something like
> 
>  config FORCE_MAX_MMAP_RND_BITS
>         bool "Force maximum number of bits to use for ASLR of mmap base address"
> -       default n
> +       default y if !64BIT

"something like" != "exhaustively tested" ;)

I'll toss that in there, but please do let me know when it is suitable
for an upstream merge.

I also added cc:stable.

