Return-Path: <linux-kernel+bounces-299832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48695DA8D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08271C21965
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DE15E97;
	Sat, 24 Aug 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StZa89Wu"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E83111AD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466000; cv=none; b=MEE69u4diBfjcMrtyi/1+IJESPhux1LrgRlIn+v52J0cYQet0eEE0V6Wrvuz+dSnKBqM3AujuPFuFsJs/QtfedWvf3hinm2IhVYEp+IReYU42XHop8kP/Usz20ItJi8NHYP4LZhrls+dMyLBGNpA0BBh31/j8c/pKly6hbT7k9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466000; c=relaxed/simple;
	bh=9sQ6JCFssdZGtmsYy5s9QY2cnq9zziz23TvGEam7rTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn/5KkNXiXa8H+EMqf5SHyA9x+D3AnehrrTMsvfQdl19lEnGCQnplpLLcQxD8zyl1KhzNesiLYq3kFC+tBHBf2xv+ojU21pC/dOYE7aRbVTGBsF5Mg9v7FoCpQ/IFhhsfs8aXhXnsUBsVUearKnKKCj7zZT/rJCzFcClgdg3mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=StZa89Wu; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7093f3a1af9so2087849a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724465998; x=1725070798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q9g7D4EjyQqlZkVFhMkSsFS8fbMF1DEOst87SjuDKg8=;
        b=StZa89WucGiiLoyhYGdUbeWVd7glncTNSANrKtAH/CV1L7liBk3WFBRi9JYbrkoNuS
         ulUir6qtXnuqN+4JgbLqWbWpDUsB7Nq/AHtiPCGEqRfzUt1VXCdaCsznj2v9hnyFT+7O
         MYVbeVeTXsgWDtYiA6E/HwQje6eYUEXhfdJdFd8PGa/VRiCthMOCy5hwD/ZjnlgoVy2Q
         w4LpYQTjBI2FXpfaFxcMuEhCydECb+R/s7m+jBAot8hz+MsNPLwu5U1Y7CHVVyaKbRNk
         kF8l8O3wj8AavXeOUh7fKrxfqg5HmTXKnYVGbRXM01GUX9rEvUbuGY838R2llfv51aZp
         FUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465998; x=1725070798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9g7D4EjyQqlZkVFhMkSsFS8fbMF1DEOst87SjuDKg8=;
        b=I410Vo9yF3PJw2KjX44l3f4onYoLtTuV+qY2aEXcFxJPqx6nZ6UuoXJId+6CBpyj+M
         sU7qxOvVCdzX4CzZHfU2mdD7dt0tXfFJTQVHhZRpvXkYICatQ755El7RxH0kX61hj/Yx
         /SdIdRVvhdFTJDNjDZdLlyalz6kyfad1iXfTkxzUeitWEnU0hMjCgKTozk0N673/sQ2C
         yrl0nxG9ZtcdZsU3O4Oy9dqAZqDp3Q7YLKg/1tDMYJY3pc5RDYCTjr9DGThc7OSff2LL
         vvJEbR8zJikDIMm6YTG467pDOiJ/Cl9bAZ/IgZ0qmRQbFlI5Slx970KeICKvQciBUViu
         MhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3frITWYFh+AZOmAO1pQ7L5/csY2Jc2NDpEods2TgbA3UbiXaWvhakq9hY6nxmG13li5YxYhB8E/BsGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2X0qltavXvNrEUDQDSHTesnIDKRgAmjsHohhmxZFArelEwld
	Rc2ex2W19TR4F8baXSqX8V1w23xUPOkvsHsnqyGpTUcTsvjeohB1fNSNArIisg==
X-Google-Smtp-Source: AGHT+IGu8hxs5nyQH8QxjA1xEWXYw+NH7bSGHW27OjR19bep/VZUDM94F+d3I21JXE3DZ7Uw4A37gQ==
X-Received: by 2002:a05:6830:6a8f:b0:709:3e0c:6735 with SMTP id 46e09a7af769-70e0eb2f327mr4524723a34.17.1724465998015;
        Fri, 23 Aug 2024 19:19:58 -0700 (PDT)
Received: from thinkpad ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61968ecc7sm4601882a91.54.2024.08.23.19.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:19:57 -0700 (PDT)
Date: Sat, 24 Aug 2024 07:49:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240824021946.s5jbzvysjxl5dcvt@thinkpad>
References: <20240823044133.b27cgioefsg4sjlr@thinkpad>
 <20240823220436.GA387844@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823220436.GA387844@bhelgaas>

On Fri, Aug 23, 2024 at 05:04:36PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 23, 2024 at 10:11:33AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Aug 22, 2024 at 12:31:33PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Aug 22, 2024 at 09:10:25PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Aug 22, 2024 at 10:16:58AM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Aug 22, 2024 at 12:18:23PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> > > > > > ...
> > > > > 
> > > > > > > Although I do have the question of what happens if the RC deasserts
> > > > > > > PERST# before qcom-ep is loaded.  We probably don't execute
> > > > > > > qcom_pcie_perst_deassert() in that case, so how does the init happen?
> > > > > > 
> > > > > > PERST# is a level trigger signal. So even if the host has asserted
> > > > > > it before EP booted, the level will stay low and ep will detect it
> > > > > > while booting.
> > > > > 
> > > > > The PERST# signal itself is definitely level oriented.
> > > > > 
> > > > > I'm still skeptical about the *interrupt* from the PCIe controller
> > > > > being level-triggered, as I mentioned here:
> > > > > https://lore.kernel.org/r/20240815224735.GA57931@bhelgaas
> > > > 
> > > > Sorry, that comment got buried into my inbox. So didn't get a chance
> > > > to respond.
> > > > 
> > > > > tegra194 is also dwc-based and has a similar PERST# interrupt but
> > > > > it's edge-triggered (tegra_pcie_ep_pex_rst_irq()), which I think
> > > > > is a cleaner implementation.  Then you don't have to remember the
> > > > > current state, switch between high and low trigger, worry about
> > > > > races and missing a pulse, etc.
> > > > 
> > > > I did try to mimic what tegra194 did when I wrote the qcom-ep
> > > > driver, but it didn't work. If we use the level triggered interrupt
> > > > as edge, the interrupt will be missed if we do not listen at the
> > > > right time (when PERST# goes from high to low and vice versa).
> > > > 
> > > > I don't know how tegra194 interrupt controller is wired up, but IIUC
> > > > they will need to boot the endpoint first and then host to catch the
> > > > PERST# interrupt.  Otherwise, the endpoint will never see the
> > > > interrupt until host toggles it again.
> > > 
> > > Having to control the boot ordering of endpoint and host is definitely
> > > problematic.
> > > 
> > > What is the nature of the crash when we try to enable the PHY when
> > > Refclk is not available?  The endpoint has no control over when the
> > > host asserts/deasserts PERST#.  If PERST# happens to be asserted while
> > > the endpoint is enabling the PHY, and this causes some kind of crash
> > > that the endpoint driver can't easily recover from, that's a serious
> > > robustness problem.
> > 
> > The whole endpoint SoC crashes if the refclk is not available during
> > phy_power_on() as the PHY driver tries to access some register on Dmitry's
> > platform (I did not see this crash on SM8450 SoC though).
> > 
> > If we keep the enable_resources() during probe() then the race condition you
> > observed above could apply. So removing that from probe() will also make the
> > race condition go away,
> 
> Example:
> 
>   1) host deasserts PERST#
>   2) qcom-ep handles PERST# IRQ
>   3) qcom_pcie_ep_perst_irq_thread() calls qcom_pcie_perst_deassert()
>   4) host asserts PERST#, Refclk no longer valid
>   5) qcom_pcie_perst_deassert() calls qcom_pcie_enable_resources()
>   6) qcom_pcie_enable_resources() enables PHY
> 
> I don't see what prevents the PERST# assertion at 4.  It sounds like
> the endpoint SoC crashes at 6.

IDK why host would quickly assert the PERST# after deasserting during probe()
unless someone intentionally does that from host side.

If that happens then there is a possibility of the endpoint SoC crash, but I'm
not sure how we can avoid that.

But what this patch fixes is a crash occuring in a sane scenario:

1) Endpoint boots first (no refclk from host)
2) Probe() calls qcom_pcie_enable_resources() --> Crash

- Mani

-- 
மணிவண்ணன் சதாசிவம்

