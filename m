Return-Path: <linux-kernel+bounces-553057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E7A582E9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30443AE544
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F71A00F8;
	Sun,  9 Mar 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD9T4kYA"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9217A319
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515057; cv=none; b=O2FVDbyW/QlT17ayDrR1Ut2BwGwmsJpc+w5nW5LsK96qu+oPLN0wI6hBLmM398Qb+xIa9ZX0FQPwygQVSbUm+hM04hS2IjrL8k5n/sZJe64oxacIlCElEew7EKJxf+D4JZSRl6yNvKL/+dVZpwnLClJr31blMVPeHLhWOA8o1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515057; c=relaxed/simple;
	bh=SE1rhr1/Gpwazw37bpBn4zpfKxtpKBxXgeoPjv0eKnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhX1CTQ2ItHZV1Gp+qWyP0G7qTph0EhLJb//CQtmBlRKarAd8mOqo5kD+Wuza/8FDcJkp2pfY2RSrrIbTbM0c+brz4P3Ni4gegr6EmAbuxy83FeZZend3BUkaq3oI499jwYAh6s72uk7kawHTEvUF4008xphe6ngSnnjcfeMbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RD9T4kYA; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e573136107bso2701957276.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741515054; x=1742119854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BClW3AD5pwAP7HlEQggy/3PgguRjaaiqTnG6w3UH/Q=;
        b=RD9T4kYAHKz426QgOqUe5Z2IZfY4RLlbveXW2G7VoPk9NGDC7tSvYiSSWIcpXXJWfI
         ntEkcykDblYBtIU+/RZ3acPPGnx1DHb4GOZJP9Na97LETEQwxjFkLaDyeqD4h4wKRczU
         HXdJzdeVBpNXrrhG1esi9zsPoIwo8gvNe0vDMv2e8lfWB49AWy8sGZOzySQ4kPiN3d+3
         YPP/Mskl2EniPBd8hl5jibX5yjmg+wh2PoP7FIYtpfDtyocrF0tiPxMsBAE6ZRwig83s
         ILaTX6DTntWgw/2oENqP38GcT0u2/SFt2cuG/yY9fABLjdBOlJ4JinVIywZtTcr2WFBb
         JuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515054; x=1742119854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BClW3AD5pwAP7HlEQggy/3PgguRjaaiqTnG6w3UH/Q=;
        b=r0D8X1gpsFAtGaet219NSbB8AI/kfbaCtvxxHkPrnJS/aAFZ6r6OpWe3tuoT2lUAZ/
         WqGNcDuIAj9tqrrJaiEC6Zt7kZzRJgswrKwJtEHjDehxgqoYDgFFIuhGtFPIOE06oun9
         XB0dERN+z/K/mYEGj101qSpeiQ5yCpDKBSM6o7qrVHyOIh6AXgnKFRk8o1U8qujVCARo
         FghQ2xqCECnLCqUQ2wNfNvn7pqQTUTmWS7B6K6tBvI2g/H5FpOAj7s9Fd4E0vLJiP3b6
         BMLRalMGKcH33xz4KgycM8uiaqJ97nwwLgfiUIUrk4t8/di+LT7vsA6omQLwVJVQM6aH
         AGvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7SMyBGhFO53O4QCHBoT1X5p+fYUxr8l8cwzjH+tPJlf+2u82JzPhFObRJ/z+TdgUCsbvB+VFFUsr7g5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPS/C6jct+/QrIwoYbXwfK+/W1XdF3oiWBA2Cops5/iKB0DskW
	CXWItqdY84kyxgmGjVSxStuZk+iRIeT5RYV6DrPIJYkracqAIDawrZwJeW60CcBjdFEd3UjGT2I
	BgqsiFDGxQBmQGBB/kOEBIR3+/eqjUV08xs2jmQ==
X-Gm-Gg: ASbGnctQO75LRo1LCVUnLCVQB2ysCe5SgQ2HUXFMbYD15RO4mhuoJgTVizxkG2sG8Sj
	yohazY1mXP8AH9Bfhop2DvZ9UvjOWruGlRENQBrXfKVUIu05MVhvz+QPmEUWWoO2pAybgL7t49L
	naYezoqrvV8Csw65psvUr4TqXOYzBN8pXYxbhJLJTTkBHL7nCj7xs=
X-Google-Smtp-Source: AGHT+IELHQ0fTEF6TQsCVADH9+2FjqIz2dd2lZgnP8p9HlYkvFgSHseJRTK4oPdwl0BlLmUYZqUu+3ES+J82wsobBT0=
X-Received: by 2002:a05:6902:1081:b0:e63:5be5:81a3 with SMTP id
 3f1490d57ef6-e635c121fe2mr12595424276.1.1741515054548; Sun, 09 Mar 2025
 03:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-2-35087287f9d1@collabora.com>
 <CAA8EJpqYE1drM6=C0AwPZ-e5RkWqjMTpWQiwhA64qby1mmVL1Q@mail.gmail.com> <22142c86-c8b5-4427-9764-a7daa4a005b1@collabora.com>
In-Reply-To: <22142c86-c8b5-4427-9764-a7daa4a005b1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 12:10:43 +0200
X-Gm-Features: AQ5f1JraoRZHEAAKtM_6fInxqSPprmQzLJINm38dwVXdhnnYMeLTS5kKKnY-1Ok
Message-ID: <CAA8EJpqCUWH95Ew57K_HKmPGhf40G_2n09SWKTonvyUn2vE4oQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] phy: hdmi: Add color depth configuration
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 12:10, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Hi Dmitry,
>
> On 3/9/25 11:16 AM, Dmitry Baryshkov wrote:
> > On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> > <cristian.ciocaltea@collabora.com> wrote:
> >>
> >> Extend the HDMI configuration options to allow managing bits per color
> >> channel.  This is required by some PHY drivers such as
> >> rockchip-samsung-hdptx.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  include/linux/phy/phy-hdmi.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Just to confirm, are you passing TMDS char rate or pixel clock for
> > DeepColor (bpc > 8) modes?
>
> It's the TMDS char rate, but we still need the bpc info to program
> CMN_REG(0086) in PATCH 12.

Thanks for the confirmation.

-- 
With best wishes
Dmitry

