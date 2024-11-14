Return-Path: <linux-kernel+bounces-409352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1709C8B96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22D91F267C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAB71FB3FE;
	Thu, 14 Nov 2024 13:13:13 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE51FAEF1;
	Thu, 14 Nov 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589993; cv=none; b=Sjo5Aa5VlZ525j0GNmAAhDza3EHSpH55OPblxkIzEVlVmC4tMMFQnQYlIp0pHCsmPWXQPFp0JL6BZey9x5bqELy2IUEfQDKZctVF/VkKR+c/othfcus1iDmSU3Ua9Y92373SFcnndL/fcuSH8riN5HE3Hh+pbEEscABWXGnnEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589993; c=relaxed/simple;
	bh=WwvM7h8xNYeTd6NJql4u1AesZv0MAzk1dOG7kIyhllo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9KFPw7GgoPIRj9HnrD+xUL2iXKHm1BSKIr8V1en8Ee3ZwzMaxpeJJFZT0aslYA2GdHA41Wr97rXKLVGawjJXzcD8CwwwqS5MZlX7Hqx5KWud+1we0gXR8vxhcciz07c6bb/5I3b6BLYwrn3Q/dqgGYqfRkD4i5kYElA9BJA1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4AECsbT5013558;
	Thu, 14 Nov 2024 06:54:37 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4AECsadN013553;
	Thu, 14 Nov 2024 06:54:36 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 14 Nov 2024 06:54:36 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>, linuxppc-dev@lists.ozlabs.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
Message-ID: <20241114125436.GL29862@gate.crashing.org>
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzdfcm3l.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

On Thu, Nov 07, 2024 at 10:35:58PM +1100, Michael Ellerman wrote:
> "Rob Herring (Arm)" <robh@kernel.org> writes:
> > While OpenFirmware originally allowed walking parent nodes and default
> > root values for #address-cells and #size-cells, FDT has long required
> > explicit values. It's been a warning in dtc for the root node since the
> > beginning (2005) and for any parent node since 2007. Of course, not all
> > FDT uses dtc, but that should be the majority by far. The various
> > extracted OF devicetrees I have dating back to the 1990s (various
> > PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
> 
> I have various old device trees that have been given to me over the
> years, and as far as I can tell they all have these properties (some of
> them are partial trees so it's hard to be 100% sure).

Many SUN systems won't have such superfluous properties.  But does
anyone use such systems at all anymore, and do people use dtc with
those :-)


Segher

