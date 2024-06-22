Return-Path: <linux-kernel+bounces-225478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F9A91310A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FFB23D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77763E;
	Sat, 22 Jun 2024 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2f3Pn4p+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBE28F4
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014714; cv=none; b=Wm9j+GVGbMyrbD3lEeMwUG5kLW+9v5H6fIWCkg575oXobb6BtgpfLSmgwOhXEQdK05Q2+AM5ATxK6Zq9m34XePKYoIcWUoEHhPdxLyC2+AXZGIxZMytBuVDKBEjjJ42cGxdZuldus/+l6HiTUxwg1xYMDo/qPopsKAu9x9CmGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014714; c=relaxed/simple;
	bh=mtLzfIy7druKeAfdg+1CJtW/70Bo9KaqxrNxgShLw3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O310vnTc3XIpmY6sBnNDzTAAYFllG/8e0KR2Rj+7WFSRQXiPbfqxJ5jMIa+QuR+kANcs7zlY56fCR0PB7EyvPrbBX78O0aMXp4T4yHEtRaC4sqD3txUnwYReUidMGlfeU5oYN+NUrPx8PPlwAXLEd5hHXIJ0eD8iV+IFPMA59zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2f3Pn4p+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70fdc9645so222565ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719014712; x=1719619512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2NFHVTARxY6oz0ND/xOG9DTefTphGU25EZtwr7kbv4k=;
        b=2f3Pn4p+YkU3jxGBlYWP5mGgl2Mw8cICXwkCuCWXpE5A1phhzAfkyA8sgaaUPqQReH
         PlMhkrxN1dMtF4R5an0RNacdhyEPiYTa0wtaso9tEGAegMOINi32UhrvRRqS82teiGhU
         9suc3R258r8+hYDhSEt19vtA6Yq2FGUYdZH6XlNR4Ek0fhOw/iqnXsl9/BRAbTfSmQaM
         QUot53ftTMwwkT8+y5bvjTf3PpklMhybM1iv3nOqtOhKOQvNfGqsn3QOR+HXXdfC63pM
         pa1JfAGe5/k3NWp4DcRkZJTC5CLmhiPXpmhYoakXWBQ6mhDtqIg65m7Sz+d/cPHk8Ex7
         s6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719014712; x=1719619512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NFHVTARxY6oz0ND/xOG9DTefTphGU25EZtwr7kbv4k=;
        b=H8OJ0WzCyA4sl42wXZs6BRXaxi0EjlYDTvFpItBEbMCtoPJde9c2utMH4SrupJC9vQ
         7zC+aGpmLu7Oefj0pV8JGYAtY8E42L+t4TWLPggrCuxI+dLabwLgg53Q7MZjEI2rfDPQ
         Tj3LDQnWlk+2pDj3JS3VjC+d/y9s2cy0dK9UxMfDm9JJXJCEhOMPw2F8ioSbPHtMIpkJ
         HHo865DCJ8lL9ILxrtprfn0pA3fndFvr46rBWx/JQlbSHTtW1JPsBAdtBvEx5NmDM+YT
         jQtnyHcwa27LT9nKiLHoq/9bIrtJ5d646fdbqmuywhc14K1wrV1gdry5aFsuvwI9Qm1A
         a4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr490JEm2V/rGJE/dxbjjDNoQtvan/cXBkDvma6QynHAWt04SVctGanrk4eO6I66L1IH61vYkrWl1F32k2bfEhj9328IrepT3/4B9x
X-Gm-Message-State: AOJu0Ywl5RSilYqkTs/p5d2fsQVZfb04tdu6cibou754bf9Puk+b4mPG
	Q1ntSMM0zBwyLosUqoaE8aUi5ba74Y5Vy1cDD2VEOmToNfCM+5q2sB6gpTEKQg==
X-Google-Smtp-Source: AGHT+IGDqe+3EUcAreiXyt9Qnv6KoLaGftjNkz08Y2Ium1Q4hAkVCIpw2uQMNCaRjKkz1QhQFpj8/g==
X-Received: by 2002:a17:903:33cf:b0:1f2:fee2:82ea with SMTP id d9443c01a7336-1fa09ffb017mr842335ad.11.1719014712177;
        Fri, 21 Jun 2024 17:05:12 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512ad7b5sm1982244b3a.165.2024.06.21.17.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 17:05:11 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:05:08 -0700
From: William McVicker <willmcvicker@google.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Roy Luo <royluo@google.com>, kernel-team@android.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 3/6] phy: exynos5-usbdrd: convert core clocks to
 clk_bulk
Message-ID: <ZnYVNLkAmUGU6ZVN@google.com>
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org>
 <20240617-usb-phy-gs101-v3-3-b66de9ae7424@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-usb-phy-gs101-v3-3-b66de9ae7424@linaro.org>

On 06/17/2024, André Draszik wrote:
> Using the clk_bulk APIs, the clock handling for the core clocks becomes
> much simpler. No need to check any flags whether or not certain clocks
> exist or not. Further, we can drop the various handles to the
> individual clocks in the driver data and instead simply treat them all
> as one thing.
> 
> So far, this driver assumes that all platforms have a clock "ref". It
> also assumes that the clocks "phy_pipe", "phy_utmi", and "itp" exist if
> the platform data "has_common_clk_gate" is set to true. It then goes
> and individually tries to acquire and enable and disable all the
> individual clocks one by one. Rather than relying on these implicit
> clocks and open-coding the clock handling, we can just explicitly spell
> out the clock names in the different device data and use that
> information to populate clk_bulk_data, allowing us to use the clk_bulk
> APIs for managing the clocks.
> 
> As a side-effect, this change highlighted the fact that
> exynos5_usbdrd_phy_power_on() forgot to check the result of the clock
> enable calls. Using the clk_bulk APIs, the compiler now warns when
> return values are not checked - therefore add the necessary check
> instead of silently ignoring failures and continuing as if all is OK
> when it isn't.
> 
> For consistency, also change a related dev_err() to dev_err_probe() in
> exynos5_usbdrd_phy_clk_handle() to get consistent error message
> formatting.
> 
> Finally, exynos5_usbdrd_phy_clk_handle() prints an error message in all
> cases as necessary (except for -ENOMEM). There is no need to print
> another message in its caller (the probe() function), and printing
> errors during OOM conditions is usually discouraged. Drop the
> duplicated message in exynos5_usbdrd_phy_probe().
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Tested-by: Will McVicker <willmcvicker@google.com>

[...]

Thanks,
Will

