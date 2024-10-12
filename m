Return-Path: <linux-kernel+bounces-362192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7199B1ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FED284D31
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1A142900;
	Sat, 12 Oct 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZ9WXFrj"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2C7EF09
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720141; cv=none; b=pnLb6DQPmkI9qqrEaXydOxUFY2ixBZwP1qSurDMn6NDRdOTb2G0oAujaOY97BTg51W00oYF1hJPDkJ5KKCQD6thTVoxRnGXB5S47YInsR5bR0amL3/PFtJ/r0UMMqEpMHYCPNQT3lRQyiqSBDzl8myWFtBwKQ0mfmKz1e8+yvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720141; c=relaxed/simple;
	bh=oUyP8qJxUiMJuPJgKHCo0Wq+ETnImS27GfAWr/6nvBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ1cY0RGw7sfzxcG2kuq0La4rvQB0hY4ZGhSFlOdRzc3NYUdoOM/gu0iHWTkGT37tGOmLwOqWeVVUjPo0T7vu8Kdi2Oaw0AwyFmyVgLKwpQHtVXDVMfXc7j0h4U2W+oCxcBi9Chx24H4Ly4PNLSThiC1mchS+hVnSy+B1pJmIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZ9WXFrj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1356861a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728720139; x=1729324939; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wZqk1gpDcpLbh6iDyY6xdY16qjHfIm4cSq6P6zQlQhI=;
        b=MZ9WXFrjSFHvBqorL06sbpZ8JWlUzQiRs8UzOLCAtCUeRRKUPUg8mh2A/LIcD7BDb+
         adnZtFYv8XSQwnAp2WO09A+pADbJVHaObcbj8JAGJBymf+ReeJhtIg2FDqiM4d/uhtl0
         bqVwZ02IniVIsqQ7X/jRwWr6X4zFTmK5m3GNi7ItepfC4Q+7e87Xzr6VH5SJEWhznYED
         2rD8nvmM1aclu7MYD6U1QGucPAlM0Hfi+nE8M+6mHYaOaxi1DSO/ZTk9R0QAyCmD0EPy
         y0hg2fmUrMenKUlg9nGKvEq8hxa1mX2P4fko43RrYvkEf9vb3vO7BpmYOoxlyWahA1k9
         4v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728720139; x=1729324939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZqk1gpDcpLbh6iDyY6xdY16qjHfIm4cSq6P6zQlQhI=;
        b=oNXZnsPM9N1oFX1m4HAKMFMs9Xf974q0anJVoqXuk39NKdq7a+ip1nIHttZjkYoDCz
         7rR3ukiKvYQTz3mM4i9ugWm8xP8SXxnruO3FKDAa/m6QzPfLQvcZqAkU+dxn3uGzXFUv
         10wnfIU52imIZZKq7E9WKA7dcEfs85NE9eFv/kre6LV8NK1KTfryHB1Cn05C/T+erdyF
         YsJupVaz6dzqAyZdwcAJDAP0xHiY0QIQ1DbV2qKPW9bjrk0aEzSxeBPsqN2ugpEDY1R9
         3mg7f+qK1s4EkfsIzPWVzSRg85cMVSc/8lUmd5QkKtZmYicmS5QxvloAdopkp7OYef5r
         BvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdz8M0rmb9go6qFDnvGyXFGFxsfhe688ZQ8W3gNPVcrupsRUHml12wkqoKZ9FCWwq0U/+g9b2VMLgCBm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhWkZYFSj+QxhQq2mbYszB9dRhoBiCz8P6bm65oxIKxTk6dVV
	yk+jLMhUq7bbKcWETWWzyui/127weHnrIPBBNXz7ueuOtBG1IBcunV0L3Gux6vpjjS7FdSV9fCI
	=
X-Google-Smtp-Source: AGHT+IGoErZ1DMvXi7PdOjqOtgBagJx8Ivw1+HU2C6hiM6DJX1nWFZSKvbxbRddh3deh5/zJxscDyg==
X-Received: by 2002:a17:90b:1495:b0:2e2:e6c8:36a7 with SMTP id 98e67ed59e1d1-2e31536e312mr2565945a91.31.1728720139502;
        Sat, 12 Oct 2024 01:02:19 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e31af38baasm869855a91.41.2024.10.12.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 01:02:19 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:32:13 +0530
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
Subject: Re: [PATCH v7 3/3] PCI: rockchip: Refactor
 rockchip_pcie_disable_clocks() function signature
Message-ID: <20241012080213.rxllcpofy2at5vnz@thinkpad>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
 <20241012050611.1908-4-linux.amoon@gmail.com>
 <20241012062033.2w7jbfiptvdlklzl@thinkpad>
 <CANAwSgS68sL2JE5wafq98gFV-jhWFx5594Ax6+aVW8mpiBgHnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgS68sL2JE5wafq98gFV-jhWFx5594Ax6+aVW8mpiBgHnQ@mail.gmail.com>

On Sat, Oct 12, 2024 at 12:55:38PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> Thanks for your review comments.
> 
> On Sat, 12 Oct 2024 at 11:50, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Sat, Oct 12, 2024 at 10:36:05AM +0530, Anand Moon wrote:
> > > Refactor the rockchip_pcie_disable_clocks function to accept a
> > > struct rockchip_pcie pointer instead of a void pointer. This change
> > > improves type safety and code readability by explicitly specifying
> > > the expected data type.
> > >
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v7: None
> > > v6: Fix the subject, add the missing () in the function name.
> >
> > Did you remove it in v7? Please don't do that, it just increases the burden on
> > reviewers.
> >
> > - Mani
> Earlier, it was reported that function () should be used in the function name.

Hmm. Why can't you do the same for the description also?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

