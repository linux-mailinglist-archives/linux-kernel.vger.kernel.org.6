Return-Path: <linux-kernel+bounces-230210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC579179DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280431C20753
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA415F308;
	Wed, 26 Jun 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmXhL/KG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716241FBB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387520; cv=none; b=Mllz/JNHElEOYEXRHOBsXzEFOhenojEpN4mG6S+h0Z/0EGg3pvrl8orszcW+/uPwQxw4BuKudcdFW76oTyxjyblIjX7gF0lwEelX43/wPtmgDYhgKr4fuTyv9NzVtkJaWcn24yTwahSDESuzhMKcwMHH5rs71QMnv/sd4/ZAaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387520; c=relaxed/simple;
	bh=vHW/g4nP2o+hvEzqZQsIKpaAOHRc8WHJ7y2cWQzsDmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P79AqOatHJKGZThrYAmx6cBZmVWJH2mftV9QhtlmKoH/IamqcF/7U1ZVM2NmHuVyAuioXgdL1Ya1+i9wiTN8v6FbKskCDGYajCV2LGjrVXSRHKygCKTdDKuFwocs5aT2/aR5Hwf1kzQ5CT5IQ+pihUZKp9mk52sCpMLuecW+L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmXhL/KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B22C2BD10;
	Wed, 26 Jun 2024 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719387520;
	bh=vHW/g4nP2o+hvEzqZQsIKpaAOHRc8WHJ7y2cWQzsDmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmXhL/KGHK7KJoTZg8iWsW70QrSESSu8PfLeLwg5Qm3k+3iaSuxJjipB8DGO00LLF
	 rRqXpty+RiYmDe9/8pIuWg+p4iykoXAXmtZeAKdprJ+ouax2oRr0RbvJo0vQprwjy5
	 rUtTnZ1n2mWfGbKVHHWECIf8vTbwnYiCiYPXDcDs=
Date: Wed, 26 Jun 2024 09:38:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
Message-ID: <2024062627-curler-unlucky-51e0@gregkh>
References: <20240625125803.38038-1-tursulin@igalia.com>
 <20240625125803.38038-2-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625125803.38038-2-tursulin@igalia.com>

On Tue, Jun 25, 2024 at 01:58:02PM +0100, Tvrtko Ursulin wrote:
> From: Maíra Canal <mcanal@igalia.com>
> 
> Add some common code for splitting the memory into N emulated NUMA memory
> nodes.
> 
> Individual architecture can then enable selecting this option and use the
> existing numa=fake=<N> kernel argument to enable it.
> 
> Memory is always split into equally sized chunks.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: “Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/Kconfig          |  7 ++++
>  drivers/base/Makefile         |  1 +
>  drivers/base/arch_numa.c      |  6 ++++
>  drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
>  drivers/base/numa_emulation.h | 21 +++++++++++

Why not just properly describe the numa topology in your bootloader or
device tree and not need any such "fake" stuff at all?

Also, you are now asking me to maintain these new files, not something
I'm comfortable doing at all sorry.

greg k-h

