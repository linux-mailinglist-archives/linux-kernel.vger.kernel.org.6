Return-Path: <linux-kernel+bounces-330904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B597A5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64FC281DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0061591E3;
	Mon, 16 Sep 2024 16:24:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9513D62F;
	Mon, 16 Sep 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503869; cv=none; b=dC/uLp/jjYHHJm3tH6x71fXL13O2CTsak3jFKLqDKYNFXq79NuQ3lUNuUkZnUy55v9ZNyUdZBvi6QXYQElQ9VyBMsr835MsDCFuTYN1XionEI76Sgsy1qlHO8WD4pxXwFTXfOPLi3GhbEQUbP+P9+dt8seS5baO4ka1rF44I8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503869; c=relaxed/simple;
	bh=EbtDAL/L0z5cbXy347r3f62tQawgD11SRo4gaXFuAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmFwEbuekOVS8I5yJFlDl5bMPRNhnU8ha+DCp4zbzMUwh0v1/8noM33QzyXGNZ/r+gyBj/8Gt0AHEOOHQEnj5hZgpYb96QxyeID3Xp+C9JdSnxjl6sHF859fwDLTnvf+i85DVH86CtA/2UU505SMT6baf79f9SXv0PTRJee517Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185B7C4CEC5;
	Mon, 16 Sep 2024 16:24:27 +0000 (UTC)
Date: Mon, 16 Sep 2024 17:24:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: cpufeature: Pretend that Apple A10 family
 does not support 32-bit EL0
Message-ID: <ZuhbuYsRk5yRoSx8@arm.com>
References: <20240909091425.16258-1-towinchenmi@gmail.com>
 <20240909091425.16258-3-towinchenmi@gmail.com>
 <f908c9ca-8063-44f4-b534-ddfc067b98c2@gmail.com>
 <ZuhPIdnx36yXJhHi@arm.com>
 <110df06f-a598-4ffc-97c9-372a0fb858dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <110df06f-a598-4ffc-97c9-372a0fb858dc@gmail.com>

On Tue, Sep 17, 2024 at 12:00:10AM +0800, Nick Chan wrote:
> Catalin Marinas 於 2024/9/16 晚上11:30 寫道:
> > On Mon, Sep 16, 2024 at 09:41:12PM +0800, Nick Chan wrote:
> >> On 9/9/2024 17:10, Nick Chan wrote:
> >>> Trying to support 32-bit EL0 on a CPU that can only execute it in certain
> >>> states is a bad idea. The A10 family only supports 16KB page size anyway
> >>> so many AArch32 executables won't run anyways. Pretend that it does not
> >>> support 32-bit EL0 at all.
> > 
> > CONFIG_COMPAT depends on ARM64_4K_PAGES || EXPERT. Do we really need
> > these patches in case one enables EXPERT and tries to run 32-bit
> > binaries that never ran on 16K pages before?
> 
> The worst thing that can happen is the 32-bit process crashes with illegal
> instruction, the kernel will still be fine.

Yes, but that's not my point. By default you do not get CONFIG_COMPAT
enabled with CONFIG_ARM64_16K_PAGES. So these patches are not really
necessary (unless one enabled EXPERT and turns on CONFIG_COMPAT but
these are specialist cases that I don't care about).

-- 
Catalin

