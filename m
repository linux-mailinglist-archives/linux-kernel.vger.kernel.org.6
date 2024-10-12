Return-Path: <linux-kernel+bounces-362418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246B99B4B9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648DA1C208C9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAD15C13F;
	Sat, 12 Oct 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzCqaHwm"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C215C0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734743; cv=none; b=b4ueD4UsDYeS3Ot/Dh+N5RqRjul0mvpJApfwYqBkHQ/qXIywoHb2oiwWvqw+CVXDm547CsMrAZLjtYKFkPsFRAPN5OoTCXKcO6+vxmrcPM4cxw27lBzx9zomWGaqVWhbZDNgAEw10HkYgHo7G/xI+3mACmLfR0q79j5UGlzxPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734743; c=relaxed/simple;
	bh=kf0YZbk3mglIH4ByXZQtKAh/Ol2tsBLv5BBUe1F863w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8M18f+VlQwvgff3TWjcL+ZXRFyDBWneP5+KI2dQJC2mgK8ZH19IPgi2poJlwXIeRt9tQXRsIZyJTfT+pfSHGC+IGpHwYhhuF3WxXhHXdffQ2oCy+3eCwQxZK8YnkJ6ECaU3i8P68XHIKjz3we7zYcu5a/WJmMIGLhFMvSG91pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IzCqaHwm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e3d45bbb5so941474b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728734741; x=1729339541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d31fMEIkZBWfHDg7MkYDOFVjb8TdCN2jGRRDuyk+HcY=;
        b=IzCqaHwm8MYXSJDQrN1v7lnzIb54rEQejpvwWnHvLjZA/sEhTxOqZwEjh8KuC64dff
         C6NWzz4mj2CUJDuVtmcfzLva9bph61XGlZQPxPCzXjPmwjnPA/S7dPxpjz/5iF+sqRN2
         PUb2k/8KitkUMiEoIHZmhMSpV00J9DREzYU2SpCUk6YYjpQwX3w4RSYxljsZqwjva8nX
         7GLAMppLvS2hPjCtf75qGXLsPwFwzm4NuwFSVsNNnX4AhuOW/3tnLklRxBPLDjyZkKbi
         b/yiRyH2So4iUq0lWzLgXSvNrC3Jnq9PeE7MsWL8DJar8uwRXwxwNu5hlepp5bWg9BQm
         pH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728734741; x=1729339541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d31fMEIkZBWfHDg7MkYDOFVjb8TdCN2jGRRDuyk+HcY=;
        b=oi8W90wWOipaDYNhoezloZlEJO1iJATSmpIyCR29v59YZmS4PoVFQ7wX/yZc3faTMk
         7aLmO1OUbBMt5TiQhiGjYqaHflv5c1xQMptmR6Y4vfQvqxykhxfgO1or/lLuv0w1PzgC
         KR147MbStomhgQsa3gL3hOiUXb+9CwYFH7rJluDiM0tdlBHFYlEbF1FkP/2En2HPVc8/
         CJTop/S2N20Ssbi97PSxhGd5daGg3zpLc2PjGnprfu1PlAYiG11t5eSNF1o+iCEhf258
         f3QigFaVm/V9/rHTLCAyRJz4hUlEmzp7YkPBCFs1rnFQSj/osem6TSjlM95ciSg/4bU5
         irnw==
X-Forwarded-Encrypted: i=1; AJvYcCUmxViEz/g3VObXZ+I0UH0B6r/70Tw88v/wmG/u1G6pV411t/vyCtDRmYjK+8kBv/XCZMiF6YkStXsDNlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxorehliorqFn4WuxqacdJEHIg0SmmwklfXU5XTHS42zUyo71Ay
	4DhX5yXVTiXZmhXRyqJQSkSkTuBsofsgpBlUTamqesYdQ+B7YdL9Mv5i/LZEMHYFmD+AdCiDwZk
	=
X-Google-Smtp-Source: AGHT+IFSsBMQH+PyGhmqzrLQ62VMYY9J5q1rZuOjYArGKZZ0lBK45Y5rDnqcj6s9R/T0RqZCAWlqBw==
X-Received: by 2002:a05:6a00:811:b0:71e:209:513c with SMTP id d2e1a72fcca58-71e380a36c9mr10010363b3a.17.1728734741456;
        Sat, 12 Oct 2024 05:05:41 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba17dsm4006379b3a.155.2024.10.12.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 05:05:41 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:35:36 +0530
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
Message-ID: <20241012120536.l7tp32ofvf6okijy@thinkpad>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
 <20241012050611.1908-3-linux.amoon@gmail.com>
 <20241012061834.ksbtcaw3c7iacnye@thinkpad>
 <CANAwSgTk2ynkuxBarvX--Qs_LTduFuSDCv3k_WNgj=za_81+kQ@mail.gmail.com>
 <20241012080019.cdgq63rwj6oi4bg7@thinkpad>
 <CANAwSgSCfM9TUe6j6OemyMbY_NsjLNgV=rCu9jXw7u_361bE+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSCfM9TUe6j6OemyMbY_NsjLNgV=rCu9jXw7u_361bE+g@mail.gmail.com>

On Sat, Oct 12, 2024 at 03:34:25PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> On Sat, 12 Oct 2024 at 13:30, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Sat, Oct 12, 2024 at 12:55:32PM +0530, Anand Moon wrote:
> > > Hi Manivannan,
> > >
> > > Thanks for your review comments.
> > >
> > > On Sat, 12 Oct 2024 at 11:48, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Sat, Oct 12, 2024 at 10:36:04AM +0530, Anand Moon wrote:
> > > > > Refactor the reset control handling in the Rockchip PCIe driver,
> > > > > introducing a more robust and efficient method for assert and
> > > > > deassert reset controller using reset_control_bulk*() API. Using the
> > > > > reset_control_bulk APIs, the reset handling for the core clocks reset
> > > > > unit becomes much simpler.
> > > > >
> > > >
> > > > Same comments as previous patch.
> > > >
> > > I will explain more about this.
> > > > > Spilt the reset controller in two groups as pre the RK3399 TRM.
> > > >
> > > > *per
> > > >
> > > > Also please state the TRM name and section for reference.
> > > >
> > > Yes
> > > > > After power up, the software driver should de-assert the reset of PCIe PHY,
> > > > > then wait the PLL locked by polling the status, if PLL
> > > > > has locked, then can de-assert the reset simultaneously
> > > > > driver need to De-assert the reset pins simultionaly.
> > > > >
> > > > >   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> > > > >
> > > > > - replace devm_reset_control_get_exclusive() with
> > > > >       devm_reset_control_bulk_get_exclusive().
> > > > > - replace reset_control_assert with
> > > > >       reset_control_bulk_assert().
> > > > > - replace reset_control_deassert with
> > > > >       reset_control_bulk_deassert().
> > > > >
> > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > ---
> > > > > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> > > > >         with devm_reset_control_bulk_get_exclusive()
> > > > >     update the functional changes.
> > > > > V6: Add reason for the split of the RESET pins.
> > > > > v5: Fix the De-assert reset core as per the TRM
> > > > >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> > > > >     simultaneously.
> > > > > v4: use dev_err_probe in error path.
> > > > > v3: Fix typo in commit message, dropped reported by.
> > > > > v2: Fix compilation error reported by Intel test robot
> > > > >     fixed checkpatch warning.
> > > > > ---
> > > > >  drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
> > > > >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> > > > >  2 files changed, 49 insertions(+), 128 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > > > > index 2777ef0cb599..9a118e2b8cbd 100644
> > > > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > > > +++ b/drivers/pci/controller/pcie-rockchip.c
> >
> > [...]
> >
> > > > > @@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> > > > >        * Please don't reorder the deassert sequence of the following
> > > > >        * four reset pins.
> > > >
> > > > I don't think my earlier comment on this addressed. Why are you changing the
> > > > reset order? Why can't you have the resets in below (older) order?
> > > >
> > > > static const char * const rockchip_pci_core_rsts[] = {
> > > >         mgmt-sticky",
> > > >         "core",
> > > >         "mgmt",
> > > >         "pipe",
> > > > };
> > >  I will add a comment on this above.
> 
> I get your point, I missed your point.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-rockchip.c?h=v6.12-rc2#n275
> 
> Actually I had these changes, but it got missed out in rebase.
> 
> >
> > Sorry, I don't get your response. My suggestion was to keep the resets sorted as
> > the original order (also indicated by my above snippet).
> 
> I will go through all the suggestions and modify them accordingly.
> 
> As per the RK3399 TRM
> [2] https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf
> 
> 17.5.2.2 Reset Application
> 17.5.2.2.2 System Reset (describe all the core reset feature)
> (name as per the dts mapping)
> RESET_N: - core
> MGMT_RESET_N:- mgmt
> MGMT_STICKY_RESET_N:- mgmt-sticky
> PIPE_RESET_N: - pipe
> AXI_RESET_N - aclk
> APB_RESET_N: pclk
> PM_RESET_N: - pm
> PCIE_PHY_RESET_N: - phy reset (used in the phy driver).
> 
> This is the reason for the split of the clk and core reset.
> 
> Further down in
> 17.5.8 PCIe Operation
> 17.5.8.1 PCIe Initialization Sequence
> 17.5.8.1.1 PCIe as Root Complex
> 
> 6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> simultaneously
> 
> Should I follow this order ? or the above order.
> static const char * const rockchip_pci_core_rsts[] = {
>         "pipe",
>         "mgmt-sticky",
>          "mgmt",
>          "core",
> };

Ok, thanks for clarifying. I was worried about the comment in the driver that
warns against changing the order. But TRM rececommends a different order :/

But since no one ever reported any issue, let's go with the existing order. If
you want to follow TRM, then I'd like to get an Ack from Rockchip Engineers who
knows the hardware better.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

