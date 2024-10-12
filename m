Return-Path: <linux-kernel+bounces-362116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C225799B146
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2AA283FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105B313A899;
	Sat, 12 Oct 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+OmZ0qG"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B184315F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714040; cv=none; b=HEjsxQ08qS6QTXNylHmDu9Vul9W0S4sygfmt6FWYUW8WnACUSYSpH3kS3Y3cM5DdQTNSNW0oZ7S0ZDQfNk24PRjKWGfpOHG/lWlMSBFaF2EFD5es/kj/bGe1cuYIqkx41is5wZZzMEnvLg+fUy7nFyv7X5B9zTnoBCWHX92nba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714040; c=relaxed/simple;
	bh=CO7SG9lz+Y2/u2AisdVe21PDtRN0/Izo2b0JXYC+Fe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBeow+lbbDME58m8OhLW7t5eX6udg5vBOD345bHjAYKcDQ3bhlXp9oN8SVPO8PlkjzQHjUmweI22OKY3mDjzPl8UDd+WLt/TwhkMun2olFeGQyHOnv4Jk8+4ymCT9pXZZ5FQXaC5GCXd4iWQhcpxeS+7cyrQDQvnnqLbtz0AGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+OmZ0qG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca7fc4484so8699225ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728714038; x=1729318838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vvc97tx45kd3GdJFZQqd4tuk2ye7G9u+HV8rsNF8eb8=;
        b=P+OmZ0qGLO1qC7e/HHoDD7BKk4UvPuMjIvuzNj2hRUlREvb6CC8vV+p9vFgAZS00x1
         VVyVC35zyd06XMl53He2jriyNHU76sPToNHbfvyc2ZFdTjb3s3cEHhkxAF/ArrEfGSnb
         C7VBxTIGUF+w2oryqyeINrvTeASusw5bVoqfJBhWrqeMeA7aajYt81Z9yjf3TwBBANAN
         toA1/ew7Z5OQ5JkNg6z5izs4mV0a1qtQAKoGXIy/ODCGQufGmrTBwV52G+CGpNJkdY6a
         o32FaK+tz2boqJIzdlsjltO6QLbWJzhgPnnXT61aUbirsFiDgxdoUYcLVnPs8eELRYib
         PXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728714038; x=1729318838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvc97tx45kd3GdJFZQqd4tuk2ye7G9u+HV8rsNF8eb8=;
        b=RBcopbum6PQ+ZkfNkthSBtshSE37BXjoYq6BvhShf8zxWCh0aKoKUEoAXV1M38SFze
         Lt4C4bNCbxsXnSVJMVDEV3ZfvJIv8/W9quoJt/aPFA7ZxXGZflEZI4x27if30S3whzLL
         +lwJ8Lqsk2nYcBf4WucEvElEUKNeMIA8CrlD6K0Rs8plC10R0ymNECjQ20A6REMaLTBp
         xWmq63Ke/f0GNWICnwhkjg6avFyVhSXTd6Oz71d+5shg72myKYwAYv4aLour/OR16Yzv
         c5D6u8RN3nhdDccCnhk2lEezSua/i98MAg0TmLYYWh/S38UJDDL/RAHJhDzSZnwg64XO
         i/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXCNclV3eiE5T9SQIY7+4yPVLAUy0UY8/rYs4HkJb8qs0h8zHKbvLKA36feOChc2qC852anSeRI5tRCHKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KFEOIqX3SNN1NXQpph7J4I4nxxeJY6hmrQFTPxAuJDKzVLwm
	OOD3VUb7JlcxhoO8j5WesqqGpYLW3cNG/isy4TK2eO3qNubZelgs9nUlH9ag8g==
X-Google-Smtp-Source: AGHT+IE9MibCsUxYlp5xvQC7TUKij7uDrYwOeTEXKfHPdmVzk+hiCpUdru94Jk7kYya9WtbYeISqmQ==
X-Received: by 2002:a17:902:dad2:b0:20c:7be3:2832 with SMTP id d9443c01a7336-20cbb1ae2f7mr24955435ad.31.1728714038373;
        Fri, 11 Oct 2024 23:20:38 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc3cea4sm32451225ad.115.2024.10.11.23.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 23:20:37 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:50:33 +0530
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
Message-ID: <20241012062033.2w7jbfiptvdlklzl@thinkpad>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
 <20241012050611.1908-4-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012050611.1908-4-linux.amoon@gmail.com>

On Sat, Oct 12, 2024 at 10:36:05AM +0530, Anand Moon wrote:
> Refactor the rockchip_pcie_disable_clocks function to accept a
> struct rockchip_pcie pointer instead of a void pointer. This change
> improves type safety and code readability by explicitly specifying
> the expected data type.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v7: None
> v6: Fix the subject, add the missing () in the function name.

Did you remove it in v7? Please don't do that, it just increases the burden on
reviewers.

- Mani

> v5: Fix the commit message and add r-b Manivannan.
> v4: None
> v3: None
> v2: No
> ---
>  drivers/pci/controller/pcie-rockchip.c | 3 +--
>  drivers/pci/controller/pcie-rockchip.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 9a118e2b8cbd..c3147111f1a7 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -269,9 +269,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
>  
> -void rockchip_pcie_disable_clocks(void *data)
> +void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
>  {
> -	struct rockchip_pcie *rockchip = data;
>  
>  	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
>  }
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 2761699f670b..7f0f938e9195 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -347,7 +347,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
> -void rockchip_pcie_disable_clocks(void *data);
> +void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_cfg_configuration_accesses(
>  		struct rockchip_pcie *rockchip, u32 type);
>  
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

