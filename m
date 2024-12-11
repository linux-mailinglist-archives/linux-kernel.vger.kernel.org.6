Return-Path: <linux-kernel+bounces-441044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16D9EC89B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBD1884F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE3202F80;
	Wed, 11 Dec 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAG2KN3n"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6751207A18
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908482; cv=none; b=mjFncSRl9HKn327jvpmsr+JveMn1rG36fRnNYSfBr9cN9zj45+d7ak0tljKEH1/tYhWdEFHi3/AasO0BVYW78i/uhfjgdUtaextbZ8lZywfPH2JUKsk8LgH2wMXtu1+BEAHb/tVfqLMfhx3hslveosaoz/QQXai5daWs5SCFhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908482; c=relaxed/simple;
	bh=Ox+dvyXza+TX7ZDpJ8HAcztROBmWclSerpmh0X86Alk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNk7hI8v7DTJs09WFAkEcfoWy5rwBN1nry7a4mjptUzJXLYMXpyWs1tNEL4c6PnhYXLKFqsgKoNgPBxKgcUc2+7V0Iy92Cl2DtXTSvAJoN5sNjYhv7a1HhBDpEImsMFlc4wlOQuwKqp7VKvuZLPTZiGIl2mSHQ0244yuP3h28CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAG2KN3n; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso33615365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908478; x=1734513278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUFybBHAtKBg9XAbRfnlqLJtUAS0jaNbKaZp0A764TQ=;
        b=dAG2KN3nE4vO8Wbzja222Y0MPHoVAEgTLJHUKvG7m+ikMGr334rMGU2cf4OpRmZuDe
         xwzNcRgN7NNhOgkhz2Rt1WhX+NUhiv2ezU8RUw0eT9oIKmzU5vokUyCeEYGiuYRGUIEY
         aFo0Vgags/f/+mgxCsD3lpjNiJ6aj6RbqDJ2mFkjPYvfuuReCN4S5BX7IZCNPuZgOPsl
         rEL9fkHDoOHpE5B73TVeS+p9zUOHoVeG3HzOBevdLUrUzfYErYy2i5grYTlBhBoGj2ET
         N37JXnGPAIA7fROGRq/FaJq4a74Xza7X+rvHftrmIoG77yZBu82l5VeL7F9IX4byK1jR
         grxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908478; x=1734513278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUFybBHAtKBg9XAbRfnlqLJtUAS0jaNbKaZp0A764TQ=;
        b=YHngs0LYwDs408KYcprTJfeH9qIaWen2h8P5w8Dweq74f2bIoKSlAZSxR8DZPgzfua
         nQgYtUrRSV4KxRVQEg90g/ModXkOUdkyVsYMX3/w0hwrPTQ9Ime+Vxe/IskxDrNskf5K
         lFl08Ia72a1qtvKar08DQUBxQJQ7MSvk6ScWtGA70duQmxkfe5tNgCiO+8T98hFbGKVI
         xsb4joNoIt2mrzTLH+MEk64RVSosPJmSI8ldBU5ZLcO93Pw/9cj4pXd6IkrEaGEY8Nly
         EZ1k74OHLaJcNZKUr/jXxe+Wvr8eET7jL3+msxuusIqRngZYvFs9PABrc3WFq0DkVW3z
         mlQA==
X-Forwarded-Encrypted: i=1; AJvYcCUvuqqjbTZ9cGzmxFoUGvVj9JSURQ1HfAdHkbVOMadsTqAwrD3gvAA5nfcuHLyDqaDhj370eqVPkT/EhEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OtKy7BagpId+SCKv44B25GWd4j8oyFdZ2vcN4kk2hOuL7V0f
	2VesMcRV4fu6WJ6UEQgLzcf7ddvfPM9TolCHuFDbUVG2S9JfwXD2d9Pc+SmFcA==
X-Gm-Gg: ASbGncvqkc0ZMYIO7++K9LmuqJ+clSzfQC9ozqG8kqJ9hi5jfKIfFXAHR4oJsuAUSyM
	yhMXJNeY74SSJfjx2IkXY2fzU3riggEYOZhdgMuNFYvT6eOumKO6AXcrRAxA3EvFaCQpps60p5L
	hnVtr3d9zwlVVEW7KnLyzodBQ/FAa44YFRceYGQcuigzFF5vu/tR3avlStmkgXF1eBY8k+FOrKy
	9CtRdgp/r52R6ama6nnSTXJOorppC3ubT/lka9UHLDRWlbboeyZE1NUeoLIjbo=
X-Google-Smtp-Source: AGHT+IE7knwn48LdhJslFzK1Zi2TZQ4t5PfbLv5V67ShOU5zUeOc6EVVuqUeQ7tRigEaD2ORk66xQw==
X-Received: by 2002:a17:903:1d2:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21778696456mr33767495ad.47.1733908477842;
        Wed, 11 Dec 2024 01:14:37 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164252350dsm54976385ad.43.2024.12.11.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:14:37 -0800 (PST)
Date: Wed, 11 Dec 2024 14:44:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, vigneshr@ti.com, s-vadapalli@ti.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, theo.lebrun@bootlin.com,
	thomas.petazzoni@bootlin.com, kwilczynski@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check
 reset_gpio before to use it
Message-ID: <20241211091421.4empou7mbm35ynxq@thinkpad>
References: <20241210154256.GA3242512@bhelgaas>
 <6c7cb07c-af9e-4f69-84df-2b59a57e4182@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c7cb07c-af9e-4f69-84df-2b59a57e4182@bootlin.com>

On Wed, Dec 11, 2024 at 09:59:30AM +0100, Thomas Richard wrote:
> On 12/10/24 16:42, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2024 at 12:23:21PM +0100, Thomas Richard wrote:
> >> The reset_gpio is optional, so in j721e_pcie_suspend_noirq() check if it is
> >> not NULL before to use it.
> > 
> > If you have occasion to post a v2, update subject to:
> > 
> >   PCI: j721e: Check reset_gpio for NULL before using it
> > 
> > s/before to use it/before using it/
> > 
> > Did you trip over a NULL pointer dereference here?  Or maybe found via
> > inspection?
> 
> By inspection
> 
> > 
> > It looks like gpiod_set_value_cansleep(desc) *should* be a no-op if
> > desc is NULL, based on this comment [1]:
> > 
> >  * This descriptor validation needs to be inserted verbatim into each
> >  * function taking a descriptor, so we need to use a preprocessor
> >  * macro to avoid endless duplication. If the desc is NULL it is an
> >  * optional GPIO and calls should just bail out.
> > 
> > and the fact that the VALIDATE_DESC_VOID() macro looks like it would
> > return early in that case.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?id=v6.12#n2316
> 
> Oh yes you're right.
> In fact, the if statement in probe() and resume_noirq() is for msleep(),
> not really for gpiod_set_value_cansleep().
> 
> So this patch is useless.
> 

Yes. Almost all of the GPIO APIs accepting desc (except few) use VALIDATE_DESC()
to check for NULL descriptor. So explicit check is not needed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

