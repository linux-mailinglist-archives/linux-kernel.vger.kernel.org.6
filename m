Return-Path: <linux-kernel+bounces-409942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826CD9C93CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B46286C32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12681AE001;
	Thu, 14 Nov 2024 21:07:47 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E518B484
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618467; cv=none; b=sobPVqfo6IlphH1qpwlsg3az+b4dk26FoNcPKQIM5nj0+nOCjxWentzT3zepDgk+pQVfmeP6fxICER1IDU0lttbZaJs2dtI+nM/rNxZV2OL8vKesY4RbP228hCDLZ17W3Zl0iqKHT95ttDY5ljsdhGCw0pyU30GautXrTkOOpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618467; c=relaxed/simple;
	bh=6cWTY2xZeaBn0xyYK8rPTQmYWh9b+pJJO6cj/yyOYFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbWQVnl0Sy5/3pL687UgTTqw/ttxGZOK1/gaTUPjTo+WEEAvfh8/EHRHjT6TeZlqbRyOA2gGjK7WQ+b/0ozBMlN9wv/hhzqFG2bOuE2GCSxH3dqsOYvjNMMG60WZsaWdHwENXHynE0tVx0xcH7MyeaztSJ3/pZ3k1Korb5Axa/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4AEL4KlI000954;
	Thu, 14 Nov 2024 15:04:20 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4AEL4Ief000942;
	Thu, 14 Nov 2024 15:04:18 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 14 Nov 2024 15:04:18 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, arnd@arndb.de
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
Message-ID: <20241114210418.GM29862@gate.crashing.org>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

On Fri, Nov 15, 2024 at 12:11:04AM +1100, Michael Ellerman wrote:
> CHRP (Common Hardware Reference Platform) was a standard developed by
> IBM & Apple for PowerPC-based systems.
> 
> The standard was used in the development of some machines but never
> gained wide spread adoption.
> 
> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
> some from Motorola? No Apple machines should be affected.
> 
> All of those mentioned above are over or nearing 20 years old, and seem
> to have no active users.

This was used by all non-IBM 970 systems as well.  The last was SLOF on
JS20 and JS21, about 20 years ago yes, and I doubt anyone uses it still
(I don't).

> So remove the CHRP support. If there's interest in still supporting some
> of the machines that can be brought back from the git history.

Sorry to see it go, but that's the way of the world :-)

> Note there are still some references to CHRP/chrp in various comments
> and some in the code, because later standards (eg. RPA, PAPR) used some
> elements of CHRP or copied the CHRP behaviour. These will need to be
> cleaned up on a case-by-case basis to either refer to newer standards or
> left as-is when that's correct.
> 
> The CHRP code was copied from arch/ppc, and before that it mostly
> predates git, so the original authorship is largely lost. If anyone
> wrote any of this code and would like a CREDITS entry just let me know.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher

