Return-Path: <linux-kernel+bounces-188821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7421C8CE774
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B361F21ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8012C7F8;
	Fri, 24 May 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfCiYQHx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A012C55D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562759; cv=none; b=bjOnCkpiad9x5gWfwkgGAA2ZTw/ZydTSe5hWv6E/siTnYcR9xB6aHZO/mxEhFyDDchja3om3ApqCzOXYpHDoTBVhGfOvrqnaf5rDl2jNupNFek/FBABO50ju5XDQp6m+7ornqXR4Sa3BVu0q2p0YvwItJQd0BqR7ns0bkbfZBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562759; c=relaxed/simple;
	bh=EtDbG/mTVNJyR2zS1qaWqcywYi1onHVXARebeJcxOWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SScLi5Dh3W1JEv1RyMUG6qNKGV9Xul8vTkfclePyPcwKqssQXGf/p2hrnFLazZkDgJGNrR6X8O1WdM1v3mMbx7WCKKQocf5l9BBXIesGao49e50PITzs+W86cyoGNU1YOT0VsIIY9K4qbH/GDb1jLlvG67R9Yo23QPIJgXkQk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfCiYQHx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so4899925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716562756; x=1717167556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk85nCqz8hNY7JRWhz/zThepuy6o3cVjI0xiL1VXLX0=;
        b=JfCiYQHxWpVMHcp2E9u2Of6WkQRbn2754vi6lwTMgmxhdKTlDNeXMw6EKUEbZG0eBd
         1ZfMMUEK7CVmCjSm2G1eZMg1LACTA/v7V9WnzY8Ts8K8ep5bE0gdAkrHwaHtUW+quK2c
         iTYZeQ3NxHC7Dg606jqVe+AeE5IpsXQK3C2m24L5GUj7eWPX2ffqD4XEkI03LU4TPJ6E
         7Q7mLxJETqaVix0gsffsYlL+r8dvvHugHMscnDafIqIIcTVkp9QwGeVAUde29Br1T7dY
         fg2k03YHdTYk1gGaAXbmnqW9tbpMl2hV+YNb0PUUapollPfikXolu+MF155k2wel66iz
         HFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562756; x=1717167556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk85nCqz8hNY7JRWhz/zThepuy6o3cVjI0xiL1VXLX0=;
        b=F2jyWPnxHUa0udM0pybzxuNG2jBCaWppDq0oS4St4J5EaMsyjDBG7b27UcKefP5vV0
         0ufG8A/rgYmQEo7skApfSZs0azfTfdpQICg/XvshSTlrknX3E7il1loHaCnhxroh/4IK
         8dzo3D/hJ6AvqOdSh8UBRCVDFWRsy8D/PBkpcfj2Ew5IYk+pufnOt/69G04gpAd9O2GB
         LjuaqRovWHJn5SIkRY3Mk07aw2C3of57Q0Klv+wOPUVLryIrazDWawIcTdHcAicPJTe0
         cvW9KRzeEiKuFr+TPBpxuNM8Wzr0UPlShkuN8TAfA9IVkWMK2Oj3CSVr9q3B0hBqP1IO
         jbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyqs3zepVK54GYSwVXKixtu2qNWKi1Ad/Hwqf6N8HD8bRXUOfMek4Ulxl6O8+uKaZ/KDysSiXr99NQ34+/K1W0OyZEieKn4qUzNch+
X-Gm-Message-State: AOJu0Yzgr+Zq9nEvI9Lm1LLsPV2iZdh6f1iroaEzLOCoh6qJ1Yv8SMWw
	TfWfPRB7yWYaqgRPSdVKZWhRiptJtaWvUnvUyW7vgQPK+01BXBNa8xwHXXGXga4=
X-Google-Smtp-Source: AGHT+IFq0bCDgKuc4UiHOXzKfU6n5S35HgNDJ778we7FOdrAWRUa/2kR7n0rOXH7nejXsAceU6xa9Q==
X-Received: by 2002:a05:600c:68c3:b0:420:ef93:cd2f with SMTP id 5b1f17b1804b1-42108a79cdfmr16925355e9.21.1716562756144;
        Fri, 24 May 2024 07:59:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970b4esm22917645e9.14.2024.05.24.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:59:15 -0700 (PDT)
Date: Fri, 24 May 2024 17:59:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] PCI: xilinx-nwl: Add phy support
Message-ID: <41d89132-f6bb-4feb-af1d-412206a85afa@moroto.mountain>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
 <20240520145402.2526481-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520145402.2526481-7-sean.anderson@linux.dev>

On Mon, May 20, 2024 at 10:54:01AM -0400, Sean Anderson wrote:
> +static int nwl_pcie_phy_enable(struct nwl_pcie *pcie)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret)
> +			goto err;
> +
> +		ret = phy_power_on(pcie->phy[i]);
> +		if (ret) {
> +			WARN_ON(phy_exit(pcie->phy[i]));
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (--i) {

This doesn't work.  If we fail on the first iteration, then it will
lead to an array underflow.  It should be while (--i >= 0) or
while (i--).  I prefer the first, but the second format works for people
who use unsigned iterators.

> +		WARN_ON(phy_power_off(pcie->phy[i]));
> +		WARN_ON(phy_exit(pcie->phy[i]));
> +	}
> +
> +	return ret;
> +}

regards,
dan carpenter


