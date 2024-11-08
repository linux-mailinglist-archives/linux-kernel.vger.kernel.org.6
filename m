Return-Path: <linux-kernel+bounces-401578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D169C1C78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C358284D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F551E47B1;
	Fri,  8 Nov 2024 11:54:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFD7462
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066851; cv=none; b=p4V7jm70Q6Yl7CC1oKGi0ZCp7jV8Y2laqOV0LWGbnKlbkOWv2uJTe4vpEhcbpftoTn54hTw0blkiCVAG32MuVRJyydfMgXX/sA9ILTArYM50ffHL7AvPCADqzARekH+XES2QwkZiafGOZqyv9q33afZXEOdBqmNUo3Ixy1wNs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066851; c=relaxed/simple;
	bh=dXsnSzpSmH7jFj3r6IUkN9EYqxfdRkJtNVjFdOUOiZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4dVNgH79/eSy4Q9TRnNWLSpWZultdFvcPhdsAHUsmwlDNpGFzFMa/iTrtLnqxARxMW1weQgtkEU0RSEBuHyJDcFjiDhvIUgZl6KEp5cVANVBRRxvWIGPz7a8adHxNoOL6c70sVlQfDoYChRCYBVgS4bM71V/CKtcGDYI/i982U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94034339;
	Fri,  8 Nov 2024 03:54:32 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 678283F528;
	Fri,  8 Nov 2024 03:54:00 -0800 (PST)
Date: Fri, 8 Nov 2024 11:53:57 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: John Watts <contact@jookia.org>
Cc: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Workaround TCON TOP conflict between DE0 and
 DE1
Message-ID: <20241108115357.691b77b0@donnerap.manchester.arm.com>
In-Reply-To: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Nov 2024 12:40:16 +1100
John Watts <contact@jookia.org> wrote:

Hi John,

thanks for taking care and sending a patch!

> On the D1 and T113 the TCON TOP cannot handle setting both DEs to a
> single output, even if the outputs are disabled. As a workaround assign
> DE1 to TVE0 by default.

Can you say *why* this patch is needed? Is there something broken that
needs fixing? Where does this show and why wasn't this a problem before?

> A full fix for this would include logic that makes sure both DEs never
> share the same output.

To be honest, given the isolation on this patch, I'd rather wait for this
full fledged solution, especially if there is no pressing need (see above).

> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> index a1ca3916f42bcc63b9ac7643e788d962ef360ca8..543311ffb1509face3fbfd069ded10933f254b9d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -179,7 +179,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>  	 * At least on H6, some registers have some bits set by default
>  	 * which may cause issues. Clear them here.
>  	 */
> -	writel(0, regs + TCON_TOP_PORT_SEL_REG);
> +	writel(0x20, regs + TCON_TOP_PORT_SEL_REG);

Sorry, but that looks weird:
First, please explain the 0x20. Is it bit 5? If yes, what does that bit
mean? The commit message suggests you know that?

And second: the comment above clearly states that those two writes just
*clear* some registers, to have some sane base line. So please adjust this
comment, and copy in some of the rationale from the commit message.
Explaining things in the commit message is good (so thanks for that!), but
having at least some terse technical explanations near the code, in a
comment, is better.

Cheers,
Andre

>  	writel(0, regs + TCON_TOP_GATE_SRC_REG);
>  
>  	/*
> 
> ---
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
> change-id: 20241108-tcon_fix-f0585ac9bae0
> 
> Best regards,


