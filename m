Return-Path: <linux-kernel+bounces-553161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2EA58514
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F177A264D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA91DE4D7;
	Sun,  9 Mar 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql72i83d"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709541E515
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531673; cv=none; b=hMNRnKv3l7q8qTQv80cNpBKeQdsFYVz4GEsz/jQRhKfAennWfjHnhySkddByoMN9UtpNNGkKh/Vw1CLdAXpu9FHSINFinM6BCoHfur1iJkbOqA/6PYoX6VSsi3zxw7DQ2hDT1WDXXEL6uRSCgIlDG49ulEgHIj2GNUwkFYa2jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531673; c=relaxed/simple;
	bh=0xJ9aJH61Xvx5ry1hLFZpHJ37VedNuqIBO1JG+WSuZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKHmmLxhZW6YBDpIYUttVVG8olVVHKPanMq4k9SqJyGe13IG77mRIMhdrBj5Xkn/cxl8Sgkso2yXIdtjdsqc/yJ8YTK6qZq8L5yfldT8FdN3mb9DxAAUYpA17q6FSUkv7lBiG24FmyBancQo7/SGZK4sBpjVFLTGasXnHiuD5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql72i83d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948021a45so29149085e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741531670; x=1742136470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTWaiiNH+tBaZi6l7L8OTGx/gcOTL7htEY9OSZqeGPc=;
        b=Ql72i83dP3Fp1l7YBF77hJF2qDqLN1FfN5pEzcAnQhcRr4rvHDEkex2DfinvkeDPvS
         /7Z9MIFQvq+zmk5NZrccVszDKyQQR99OxeNVluuGOAcvSMebp3p6gCNjGZx9YOpvmKjW
         QfPRYJQmFLQaxspfZS1exd5q5n75UB8991uio4M7KqrVfhYvXrUFaLECF0zDET7mM7ox
         f3a1G/MxneuhNouiDbXyv4rPHG5hYxBjs4br1a1c2RXWtVUAVsK4474Lk22mojoHPmaC
         poGbhtMbDIHicoSI7FUU5pBkkaBFl+wYnaGPiG7QLXm5/iu0S0X/72GqeoAirSXMSfIi
         E7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741531670; x=1742136470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTWaiiNH+tBaZi6l7L8OTGx/gcOTL7htEY9OSZqeGPc=;
        b=o0sdw1oURVhhUlesZu9EU16stZfBmUgazM8DAtbuY1g4UmSuWJwIqmq6NKPCJMLIhK
         YJigdzHL8LpBmjPJep5DptBglrrU2M7f3RbuI4ee2jJ2PARz7+Ksi9X/7OkH1qyCBZnm
         d57++W9Fu5WX0OQ6uwgD7oZjM0D3SYnS1d4XJFIFNU+Ux2a3HpHbWU4MB01Xnt5sVpC2
         kGPPKI8jdWf5ZXqIFqmQW8VWpgIAzEYI47Fe8sO9+6th3psilrScY1MIYa0gk9PntlPm
         VCReketpri2sC4iXPM6g8ETNUgMSGqKwI+xkmvzbIWoTzQjsKWd5O8OFln9MRqr0Flum
         mXTA==
X-Forwarded-Encrypted: i=1; AJvYcCWLhfDCA5gaGxSkJdezUUZ9PXjlZmrwns9PyVMxGaX1fTvpnOhiBeG/W+mYDiyERnofhlTe8+oIvPib3sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6AB/FJZvQMoVKyNvHuuGG4loOEbUIoThzFOcrFmSG0RJhn4C
	8LbdjzPWFwr/YxUwYaUtd4H3CmnO1u5KdYRywD3clWTqlCYdiaTN
X-Gm-Gg: ASbGnct8DgtbzPIDzw3ZpC1W+vsnCF++Rupqrtj97hlJzBxblmvfDQKAJHnc/jadyLB
	4CEu2NAyquzuzyJAo1WlF8thHXSU/BXqKa5fJLxT2fLEi+VMyGdiUyb9Cmfq5q5szI2Nb83WYtL
	u7C+mAB3mHyFPZYwUw39ajup0nPM5/fFkCt/EqOeNDEAe0oMl2EBMoFqmt+QpMppIPo+0xRkgXd
	DiAHurdkPHinmjh7n8RFRZCGsALBOHTkzvUl94Arh9UD2pzTX2a2zmDnXtDOyuf6BtG6JrmMWME
	9I6R8OFTYOBwp74fTeWmw8/aN9guvnZ7dzoj4e8X9dYi9w3uw9T7k+qaIh6cqQm5n/BWyezX3bf
	/uR4Qpbx0nUUak6PCfQ==
X-Google-Smtp-Source: AGHT+IEwJbPV09xk72LEbzQ8Myae9OExn7rbr2tBSURY8OV0I/uXz2TcorLmybD6DwsofI0FuPNHzw==
X-Received: by 2002:a5d:64ad:0:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-39132d4de7emr6923623f8f.15.1741531669489;
        Sun, 09 Mar 2025 07:47:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103aa5sm12193398f8f.94.2025.03.09.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:47:48 -0700 (PDT)
Date: Sun, 9 Mar 2025 14:47:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, Sandor Yu
 <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 07/12] phy: rockchip: samsung-hdptx: Avoid Hz<->hHz
 unit conversion overhead
Message-ID: <20250309144747.744e5197@pumpkin>
In-Reply-To: <a1a3e86a-1906-4797-932d-8e1aadafedde@collabora.com>
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
	<20250308-phy-sam-hdptx-bpc-v5-7-35087287f9d1@collabora.com>
	<CAA8EJpoQbvFbNXQ2RB1qY2gHnwZaU-PT-DMLnZkrxkqs2wkXqQ@mail.gmail.com>
	<a1a3e86a-1906-4797-932d-8e1aadafedde@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Mar 2025 12:13:32 +0200
Cristian Ciocaltea <cristian.ciocaltea@collabora.com> wrote:

> On 3/9/25 11:22 AM, Dmitry Baryshkov wrote:
> > On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> > <cristian.ciocaltea@collabora.com> wrote:  
> >>
> >> The ropll_tmds_cfg table used to identify the configuration params for
> >> the supported rates expects the search key, i.e. bit_rate member of
> >> struct ropll_config, to be provided in hHz rather than Hz (1 hHz = 100
> >> Hz).  This requires multiple conversions between these units being
> >> performed at runtime.
> >>
> >> Improve implementation clarity and efficiency by consistently using the
> >> Hz unit throughout driver's internal data structures and functions.
> >> Also rename the rather misleading struct member.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 79 +++++++++++------------
> >>  1 file changed, 39 insertions(+), 40 deletions(-)
> >>
> >> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >> index 2bf525514c1991a1299265d12e1e85f66333c604..e58a01bdb3ce82d66acdcb02c06de2816288b574 100644
> >> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >> @@ -330,7 +330,7 @@ enum dp_link_rate {
> >>  };
> >>
> >>  struct ropll_config {
> >> -       u32 bit_rate;
> >> +       u32 rate;  
> > 
> > unsigned long long, please, to match the tmds_char_rate type.

Isn't 'bit_rate' more descriptive?
But maybe rate_hz to make the units more obvious.

If the max frequency might get near 4Gz then the you need something
bigger that u32 - which might it used hectaHz (a prefix that is pretty much only
used with areas of land!)
Being more explicit with u64 (rather than 'long long') may be better.
Certainly less typing.

	David



> >   
> >>         u8 pms_mdiv;
> >>         u8 pms_mdiv_afc;
> >>         u8 pms_pdiv;
> >> @@ -410,45 +410,45 @@ struct rk_hdptx_phy {
> >>  };
> >>
> >>  static const struct ropll_config ropll_tmds_cfg[] = {
> >> -       { 5940000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >> +       { 594000000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,  
> > 
> > Use ULL suffix
> >   
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 3712500, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >> +       { 371250000, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 2970000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >> +       { 297000000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1620000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
> >> +       { 162000000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
> >>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1856250, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >> +       { 185625000, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1540000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
> >> +       { 154000000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1485000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
> >> +       { 148500000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
> >>           0x10, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1462500, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
> >> +       { 146250000, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
> >>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1190000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
> >> +       { 119000000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
> >>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1065000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
> >> +       { 106500000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
> >>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 1080000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> >> +       { 108000000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> >>           0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 855000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
> >> +       { 85500000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 835000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
> >> +       { 83500000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 928125, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >> +       { 92812500, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 742500, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >> +       { 74250000, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 650000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
> >> +       { 65000000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
> >>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 337500, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
> >> +       { 33750000, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
> >>           1, 1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 400000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> >> +       { 40000000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> >>           0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 270000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> >> +       { 27000000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> >>           0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >> -       { 251750, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
> >> +       { 25175000, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
> >>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> >>  };
> >>
> >> @@ -894,10 +894,10 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
> >>         regmap_write(hdptx->grf, GRF_HDPTX_CON0, val);
> >>  }
> >>
> >> -static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
> >> +static bool rk_hdptx_phy_clk_pll_calc(unsigned long rate,  
> > 
> > here and further, unsigned long long
> > Also, is it tmds_char_rate?  
> 
> Yes, will do the suggested changes in v6.
> 
> Thanks,
> Cristian
> 


