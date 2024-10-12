Return-Path: <linux-kernel+bounces-362189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C27EA99B1E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A3A1F2371F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868D13774B;
	Sat, 12 Oct 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMUy29F/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BE13AD32
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720030; cv=none; b=mjIDVazRqNO6fafbep0ZKiLJ4z1FexG+sg0bhIBP6zmUKCkIFyElDDSci3k9cFZFsfBsU4ffQC0QeGIyet7U8c+gy8GWVEObSOervfB3qdDxHlUTK9SpppOgR+9Ml16D+i6Qk7TI2BByT8J3rLFMAUPujVMrO8yeyJ2vgfTaxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720030; c=relaxed/simple;
	bh=X/oFhZ44IyH3gxaWPSlq/39m/4rwqDFrzXuiQnAiYLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEyiqzoR7J+tB5mjmmY3LNjf29ci2E0pkNVzB9krMnnAFCj0NAdao5MKWsCfWyPMNYoo7s2s4YXarkajBCuYT8ROIwxAv8E2TqLKJJJp7ZKmcdcILot2shMz2USwdJjImpnpimKlonxDfUV6RUSiKgcY6+bjMSRoUyz2ws/zAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMUy29F/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c7edf2872so21692895ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728720028; x=1729324828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SwGEkgRRa1cwEpEXYHn8Jfzmui7uZXkgrh+X/zl8+Zg=;
        b=WMUy29F/BHJg1rXxWGY2TpjFfFCGzCatxDBqIs9kzBf8x5Gu59JI3m6Pd64RAarIkY
         OZAwYN1Lbkha1KBBkPEWU6jZzosg1rUToresP3p4KJAt6f7dl52b1xLqytUY+GNgtj9C
         1A1seMOnlHj3MAjiphrnxvf6Vy8WGiNS3ZlS6v1LupEfJOlnegnNrY39XOiSSI3s76Ul
         Xes6cNtnxxitHTjzb9MSfs2I9L5pMJS3psrYc1LRM6dewBAE8EUY5B0aOAsDAp8OfDtt
         P9ZXNPO6hxXum9oAMS5zsjMAK238A33SURYqQnBHPuO9AdvVevlswm7Kz8BRC/tEeA9T
         7VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728720028; x=1729324828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwGEkgRRa1cwEpEXYHn8Jfzmui7uZXkgrh+X/zl8+Zg=;
        b=PqoIbFjQg1SdY5uIsEVZ1u4F0vGkpCrYg0uEdk1teBpZpbHuIbl1XRAoYQrN+xmUnE
         m6dU3B/aV/zst3XpmFQvWGK1IxBZBP4fCnFvjXLa3cmwBigM66lUjO364bBpia5t0t6W
         aBcTQHX6wjsZlczYUr9+Nlxtfrd8P2dep2g/FkZuG+AdhP460csDityMkC2PsYTVwQeO
         GCJQw7lOQfurGcSOLQny76Au57tovrx5m2T7W/yNRcsbSD5mUYKTya4TD5EmsIVyQxMH
         ++XlluBOd+K/Hym+U3CPxpC+2K3a5xRdYnlnYfgy72es/f9OptvWjVwD+k/fktlxF0kY
         LVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8L0bWBFIFlu9sv1Im3iW63yCxh73zxc0ihWaMsXo1xFA8YbcbUNXRl1XGhwIV+5I9m11uE+Q5m5TUlKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRQKdhp5dJAPwRwdvUsBQaHYPkGyQdNTOCZqlG1PRmUTE71yh
	dqMaLN6/6o5D7RBtCf0j3rbtLBxA5Y8g9sucLv9KnItvEOFK6ojun/YmZYz5kCB5tR8TeXdugoQ
	=
X-Google-Smtp-Source: AGHT+IFcLuA6Pa/yDRB0ro7g9hMgXsIhUc1ZpWkdd3AW+bO3wyX3tthtl51Bioe/OrN9QKN7qtOYwQ==
X-Received: by 2002:a17:903:2b10:b0:20b:db4:d913 with SMTP id d9443c01a7336-20ca037aa44mr78217775ad.11.1728720028121;
        Sat, 12 Oct 2024 01:00:28 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad9968sm33450665ad.6.2024.10.12.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 01:00:24 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:30:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20241012080019.cdgq63rwj6oi4bg7@thinkpad>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
 <20241012050611.1908-3-linux.amoon@gmail.com>
 <20241012061834.ksbtcaw3c7iacnye@thinkpad>
 <CANAwSgTk2ynkuxBarvX--Qs_LTduFuSDCv3k_WNgj=za_81+kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgTk2ynkuxBarvX--Qs_LTduFuSDCv3k_WNgj=za_81+kQ@mail.gmail.com>

On Sat, Oct 12, 2024 at 12:55:32PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> Thanks for your review comments.
> 
> On Sat, 12 Oct 2024 at 11:48, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Sat, Oct 12, 2024 at 10:36:04AM +0530, Anand Moon wrote:
> > > Refactor the reset control handling in the Rockchip PCIe driver,
> > > introducing a more robust and efficient method for assert and
> > > deassert reset controller using reset_control_bulk*() API. Using the
> > > reset_control_bulk APIs, the reset handling for the core clocks reset
> > > unit becomes much simpler.
> > >
> >
> > Same comments as previous patch.
> >
> I will explain more about this.
> > > Spilt the reset controller in two groups as pre the RK3399 TRM.
> >
> > *per
> >
> > Also please state the TRM name and section for reference.
> >
> Yes
> > > After power up, the software driver should de-assert the reset of PCIe PHY,
> > > then wait the PLL locked by polling the status, if PLL
> > > has locked, then can de-assert the reset simultaneously
> > > driver need to De-assert the reset pins simultionaly.
> > >
> > >   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> > >
> > > - replace devm_reset_control_get_exclusive() with
> > >       devm_reset_control_bulk_get_exclusive().
> > > - replace reset_control_assert with
> > >       reset_control_bulk_assert().
> > > - replace reset_control_deassert with
> > >       reset_control_bulk_deassert().
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> > >         with devm_reset_control_bulk_get_exclusive()
> > >     update the functional changes.
> > > V6: Add reason for the split of the RESET pins.
> > > v5: Fix the De-assert reset core as per the TRM
> > >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> > >     simultaneously.
> > > v4: use dev_err_probe in error path.
> > > v3: Fix typo in commit message, dropped reported by.
> > > v2: Fix compilation error reported by Intel test robot
> > >     fixed checkpatch warning.
> > > ---
> > >  drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
> > >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> > >  2 files changed, 49 insertions(+), 128 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > > index 2777ef0cb599..9a118e2b8cbd 100644
> > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > +++ b/drivers/pci/controller/pcie-rockchip.c

[...]

> > > @@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> > >        * Please don't reorder the deassert sequence of the following
> > >        * four reset pins.
> >
> > I don't think my earlier comment on this addressed. Why are you changing the
> > reset order? Why can't you have the resets in below (older) order?
> >
> > static const char * const rockchip_pci_core_rsts[] = {
> >         mgmt-sticky",
> >         "core",
> >         "mgmt",
> >         "pipe",
> > };
>  I will add a comment on this above.

Sorry, I don't get your response. My suggestion was to keep the resets sorted as
the original order (also indicated by my above snippet).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

