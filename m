Return-Path: <linux-kernel+bounces-248051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4B92D7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ED01C21332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857D1953B9;
	Wed, 10 Jul 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XN2mgeoK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A141946C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633872; cv=none; b=A/p6q0Rk/Ln+XriB5IPXIXQkILUYjV5XxfizT44gmhTjGU/kbAcftWRha2P6Rm20/muj3ZMFbjEhzXjHRppMI75Qp7Zf4YZXF5UbZC8++EwDyprRleRqnTllnfoaTpyjeIIXF8B9NltlIRG99C+zjQueDjR1NzB3RxIZJyG7Z1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633872; c=relaxed/simple;
	bh=1SU0JcntRNlBdtFla5MZR0uVgmQ0VyFri7O5YG6IDsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHgjEx/nSy+suPoUI9fkd3dUDj8yGZ+B+t+UC410DOE4Q1SmRhKnxzHUwu6R1iDGHJx2h7QvsZTFUNMiVciPbxlEjOAVJE3A4+h3hyowOTnSCDLqgpVwkOBW66C8q6vX3EIu39nUW5nikKEr0Zyr1bL0uEyi3FG3cuLwU70o0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XN2mgeoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4447CC32781;
	Wed, 10 Jul 2024 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720633871;
	bh=1SU0JcntRNlBdtFla5MZR0uVgmQ0VyFri7O5YG6IDsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN2mgeoKuNee90nEKw4vmZiaSJSAaXFWt+U60JgaYDfmqIMNEeuL808TaKCT/tCLA
	 Jrj7CskozpG4593Ju0yNY5GVvgiilmV3IVUa1Q5XVAa5FNjO9PUzLe/iTUlo/tg5MD
	 Cxtahd599+r8jLSlSrrwU3rMP1qepiMLjJy5Gnqg=
Date: Wed, 10 Jul 2024 19:51:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: Re: [PATCH] staging: comedi: ni_*: do not declare unused variable
 range_ni_E_ao_ext
Message-ID: <2024071043-cramp-pope-2133@gregkh>
References: <20240710173719.3559437-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710173719.3559437-1-abbotti@mev.co.uk>

On Wed, Jul 10, 2024 at 06:37:19PM +0100, Ian Abbott wrote:
> Mirsad Todorovac reported a compiler warning in "ni_stc.h" due to the
> variable `range_ni_E_ao_ext` being defined but unused when building the
> "ni_routes_test" module.
> 
> The `range_ni_E_ao_ext` variable is tentatively defined in "ni_stc.h"
> (with internal linkage) and fully defined in "ni_mio_common.c".
> "ni_stc.h" and/or "ni_mio_common.c" are included by the "ni_atmio",
> "ni_pcimio", "ni_mio_cs", and "ni_routes_test" modules, which will each
> get their own local `range_ni_E_ao_ext` variable defined.  However, it
> is not used by the "ni_mio_cs" or "ni_routes_test" modules.  They should
> get optimized out, but there are compiler warnings about the unused
> variable when built with the `W=1` option.
> 
> Move the full definition of the variable from "ni_mio_common.c" into the
> places where it is used, namely "ni_atmio.c" and "ni_pcimio.c", and
> remove the tentative definition of the variable from "ni_stc.h".  This
> fixes the compiler warnings.
> 
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> Link: https://lore.kernel.org/lkml/3bab8580-c01a-4183-94af-ba3193c94c0e@gmail.com/
> Cc: Mirsad Todorovac <mtodorovac69@gmail.com>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
> Note: The linked report also covers similar warnings elsewhere in the
> kernel, so is not closed by this patch.

Nit, no need for "staging:" in the subject line anymore :)

I'll fix that up when applying it, no need to resend.

thanks,

greg k-h

