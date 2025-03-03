Return-Path: <linux-kernel+bounces-541276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D3A4BAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB61E170BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F601F0E38;
	Mon,  3 Mar 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVV9iRau"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6061D63C0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994257; cv=none; b=TilnpKc/fpXoIoJIdbSqgm0SO0tMr4DP1FW+BzEhIY9JBd/2Hxw440RlS0W7r+gdC7KI1ICyeGB1smrk+mMiB97p51j3CSnp7EdZBFYnOw57uA7hQTHaPWTYpprIXH81q5ICoMrqmzJBoP82f5Jw6hQyFR++4ZUZBGYY6jX22Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994257; c=relaxed/simple;
	bh=jLJKFq3DzDFZlX1XSnSbaeOdYYwfb/ehBF5/SPp1ssQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrhfmr6XmaYQMgFP1n/ZfIsy0vlX1+XBzGtCIF4EsThC9E5/W9yMXC/v+0Kc/psGFC91EzbJ0IA6CfxaIJoRQtrz3vAYyHKzu57zHzXDU6j3jnFTK4MdJwOSKgpGrOQXp0vM/6kL7NeTAs/xfFTk222HqwDxJ2I5MCZf8h2jhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVV9iRau; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43998deed24so39680795e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740994254; x=1741599054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40IljttzQ4D51zd6+tKieDE6wTjSWdKsG254DqLzf6A=;
        b=QVV9iRaunQUVPFpWm49OJ/gpXZMShxnxVdt36tNG7Dxpm5V2x/iSGDtd7r3OFK/eHv
         qY9m/KHSzXeMfWzbC3E4UzmuDvt4X9SDM1knWeXyaMFtaUmMVJbttj7LmLN25qgfVSGS
         BsU0OwwKgIp9rbJw/9BYRsiJKlmN2z+AseNyFDLwRAmeBPXAhShXPT5+0Vaj0HZ2Wrws
         gg/Yxjpk/wE5S4ybz3sOCo85mWo3ktNuhYvC3BNoGYwEwZ0wPN4zL4cvJUx1ILUPOJlr
         IkcLpDwXP40fgQlPsQoh490eLeIdAGKQsRC4KTPhowg+CLbArurqBCG7AAGgmRJ82V9i
         WreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994254; x=1741599054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40IljttzQ4D51zd6+tKieDE6wTjSWdKsG254DqLzf6A=;
        b=ZSWRZeoHPZSd7JCd03YFu1IjCR3FzBv7/M+61bk4gMNieVw2ihbN7HwE54ZUPV6r7D
         wI+H7wU1TPLbWMJ+1bcw8SRnLrXZdPtTNq24zN7rIwQkXoAivqP0tUIuk8DdDjDuX8AA
         ZpsLj9Ps9ciVdwRfqs68N+kbv/52cVizVY4b8TlHviOKXIu7E+0w3WUR8vMkAUTvSbP1
         CEF0ff/yeLxKBcZJTpxcs0a3w1YipVl0cDga16IW0h/Takn5t3gdEiUjhv0y1TxHWbTj
         dnSO4b220NJK+m5gaYPAaiL9VkQcgeGTGJxUwG9GLBMrXnfNoZbvme1tXDluCjWX5bof
         Fr+w==
X-Forwarded-Encrypted: i=1; AJvYcCXwjf4ahrIe+lfVEPlLJxtaUTKSlbfdFG29Qc1gahBsrlbaU/CvGpuMp8dRcxAHyuG5Wg2ns2na8Zkz4rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5eVO276tmooYeVU/glLoslseek50eRWOsRW47g5ASsxgiobb
	3rYizSfRVZRpWo+eTbUn9sbWwCn47SeRBJ3iZ4ISgrbeQXhqgvkF
X-Gm-Gg: ASbGnctNfinJz7CN0q6zJB98dksFQJ+Q3J8Yh5bnqoFsk+7YSrB6sJQJKAnC6Y7mYnf
	00zbKlZ7xHqO/FWQiKNiRjF+AXOxp3gqnSIRYhUy/qdtLev/1RzyZdZqPGeiuAbiNYbuR5Ia/7F
	NHGITlCc8hV9yjyxtyhOSPB+lOepnA2YgH16aaUYoLJ9mRsTkvA/yreFa9a7lU74DZ3CoNbNBR/
	zmtV40CYGiaEmbA/IDyjOgi/YSKXoy7YYqmDkCRNVQAkOHiJdPe0b7LAXG2leMj1B5ljEKMMK9b
	GuY8+EqFww+wFzfVVk3b8uQBzxIsvFkfy30fablmDB0M
X-Google-Smtp-Source: AGHT+IE593cTzA3Ll5VUo6n9spv8sl0rB5EmPJ7Oo0urGlRI3JU+kEeG6M0t/EplWSVuxhmvW3R3dg==
X-Received: by 2002:a05:600c:4444:b0:439:92ca:f01b with SMTP id 5b1f17b1804b1-43ba6708bd2mr103876125e9.13.1740994253402;
        Mon, 03 Mar 2025 01:30:53 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:4dab:10cc:7f02:7565])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710c2sm179671575e9.32.2025.03.03.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:30:52 -0800 (PST)
Date: Mon, 3 Mar 2025 10:30:51 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	tharvey@gateworks.com, hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] phy: freescale: imx8m-pcie: cleanup reset logic
Message-ID: <Z8V2yzfYGirBFi1u@eichest-laptop>
References: <20250228103959.47419-1-eichest@gmail.com>
 <20250228103959.47419-2-eichest@gmail.com>
 <c965906ea8797385399534e974cabdba5564ae0f.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c965906ea8797385399534e974cabdba5564ae0f.camel@pengutronix.de>

Hi Philipp,

On Fri, Feb 28, 2025 at 01:38:11PM +0100, Philipp Zabel wrote:
> On Fr, 2025-02-28 at 11:38 +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Remove the switch statement and base perst release on whether it is
> > found in the device tree. The probe function fails without the reset
> > property, making it mandatory. Therefore, always release reset
> > independent of the variant.
> > 
> > This does not change the behavior of the driver but reduces driver
> > complexity and allows for easier future modifications.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > index e98361dcdeadf..00f957a42d9dc 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > @@ -141,15 +141,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
> >  			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
> >  	usleep_range(100, 200);
> >  
> > -	switch (imx8_phy->drvdata->variant) {
> > -	case IMX8MP:
> > +	if (imx8_phy->perst)
> 
> This check is not necessary, reset_control_deassert(NULL) is a no-op:
> 

Thanks for the feedback, I will remove the check in the next version.

Regards,
Stefan

