Return-Path: <linux-kernel+bounces-208341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28A9023E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3740AB28BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFE484E1F;
	Mon, 10 Jun 2024 14:11:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC423B0;
	Mon, 10 Jun 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028704; cv=none; b=GC9nExaNrXC6eIwAVh7x/fm+djuG7eHYGFxRhFCjoQVEk2zKMEM5wLWih2LES6MWullRbsRirRUOHjwYNsf9myF7ffrTmP2SoPgZu9c4CXutmEEqLK/tQjnHxD0FiKeOmgBDL+x3wIBSxO6x7m54Isq9mD6dFYGO3M+HYn/1d1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028704; c=relaxed/simple;
	bh=FsdkyzDBDHbWmLBrCoH0qjW/NNd5YeFXroFLBck/y8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/tGp3QKA7lufi97kIRadmAJ9VC10X+aVhvnWmCR/68MkPu0dVo+etAvmgbrxyrk1uk/1fotffPsw/L8SDdtS/kqfUNWclFCF8rGo5UF6zvDUYC16YTc1xk1tG6tcZlnSSG9I4BI5d2S0n0NTnLfF0SNfSKuWGlyPZ+V5Xs2dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D56AC2BBFC;
	Mon, 10 Jun 2024 14:11:40 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:11:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v3 02/14] arm64: Detect if in a realm and set RIPAS RAM
Message-ID: <ZmcJmvBDtjaLay5k@arm.com>
References: <20240605093006.145492-1-steven.price@arm.com>
 <20240605093006.145492-3-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605093006.145492-3-steven.price@arm.com>

On Wed, Jun 05, 2024 at 10:29:54AM +0100, Steven Price wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9b5ab6818f7f..9d8d38e3bee2 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -41,6 +41,7 @@
>  #include <asm/kvm_host.h>
>  #include <asm/memory.h>
>  #include <asm/numa.h>
> +#include <asm/rsi.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <linux/sizes.h>

What's this random include here? It looks like a leftover from the
previous version.

-- 
Catalin

