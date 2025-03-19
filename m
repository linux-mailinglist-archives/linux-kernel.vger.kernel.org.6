Return-Path: <linux-kernel+bounces-568713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E6A6997C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAF77B39AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304F52147F6;
	Wed, 19 Mar 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RsBZdGFz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B51F4164
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412992; cv=none; b=MC5djWonbLC0uzUENlm78AnNn/KSEkAbovyPh1NRgX74XX6VA1Rgg/amnne7e+PnrCN9ZJgrlMqUMVSDwdFyNbeFPggwWghAUeUlWegUT7diR92vZlFM9QRpdYRcA3y+dQewb4PxPx9FpbSEpR0Mi1smisSbTCk++p/CyvwCQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412992; c=relaxed/simple;
	bh=GFiDluF3fB8gMKuc9iqC+xRclZUuq5KZyVwMIxZJFXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDvhWvR8k0M2fNiiZ/7qOjFxchAOT6OdPQtLm8Iepd2eHvZnyp7JoDCJSSZotVNSs5yP58DHQhBjwgWkLmHxmp/VW7zt0Jac34OTPHuHRCoRj68mYZdlpsVduxQ89pMp8hP4Wdv/k6XtS1uBb9lM1ceRi6ZE3cWFpKVQ2xpGpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RsBZdGFz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C678640E01D1;
	Wed, 19 Mar 2025 19:36:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YjveOVdjTMpU; Wed, 19 Mar 2025 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742412980; bh=2rMfP9h0aeOQrOkpvanagx4fbuzagxqnWyXAvvKSQCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsBZdGFzDFUsVtP6RwWoYwSJktKYVbYkQTZy3cOsHKjsGV229yxsV0OyEPH94pDSD
	 8wnSKnZcFCBfNjkXqLMgDTgS+nTHrIqDeyaoboRda/ou6jvUfXq8ADKk5xl+ACXBEk
	 zywxlWOeSSbSBumMDVBmb7Y7JUgpQUb4NOju4z+UPAI9IPKaWPSamt07/3KXhAJ38y
	 w+PHN0EcW8kQJfZopz+aPorfUPPboPkFtIinbIgOkBxum1SRBuvyU5RQbEe7WF7gcD
	 VQc1vuNYo/zXGB4hHcJmhMMa5EM0MfdPajm+rJ12eQ0yDLPr+4izl5J7Ja6KJPx+Ex
	 vT5bcGJqU8WVGJsriNEeMqaCKHy+TVnMFUJdJN8UigJXHAGfMsFi+qXCThe1ghmO8Z
	 LlhZbo5XbhgV/5DzktSRPtwW6+A4N3t/GhX8Npv26xVhpQcGnzdr7mGuaujTT0p+zx
	 ea3Z9GARptZPO3MpGhCwO7hY541O35PyhJcTVmyX71rc2YDISI6hQVYKY73xKFnYFV
	 9r9ZK1TpiKnt4EqzeD4nEw/2RWQeOhArewXb5+fUisX4m79BhfQCopejeb311QqIVF
	 cviBAGLbYunAQbLyQQBo7SQ55uHkqu7jcdDIG39T2mX3zDHW61Q48rdF5s10EDtfn0
	 erZK+IhBQQYbFZpxe7dx0IKg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A932440E016E;
	Wed, 19 Mar 2025 19:36:17 +0000 (UTC)
Date: Wed, 19 Mar 2025 20:36:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: linux-kernel@vger.kernel.org, shravankr@nvidia.com
Subject: Re: [PATCH] MAINTAINERS: add secondary maintainer for bluefield_edac
 driver
Message-ID: <20250319193609.GFZ9scqZ2JL4waS9qn@fat_crate.local>
References: <20250319181630.2673-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319181630.2673-1-davthompson@nvidia.com>

On Wed, Mar 19, 2025 at 02:16:30PM -0400, David Thompson wrote:
> Add a new line to bluefield_edac driver's section of MAINTAINERS
> file, providing secondary maintainer's name and contact information.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efee40ea589f..570411b580ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8214,6 +8214,7 @@ F:	drivers/edac/aspeed_edac.c
>  
>  EDAC-BLUEFIELD
>  M:	Shravan Kumar Ramani <shravankr@nvidia.com>
> +M:	David Thompson <davthompson@nvidia.com>
>  S:	Supported
>  F:	drivers/edac/bluefield_edac.c
>  
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

