Return-Path: <linux-kernel+bounces-311638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E10A968B6E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1357C1F226AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC771A3041;
	Mon,  2 Sep 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK9eFiKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1A1A3036;
	Mon,  2 Sep 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292684; cv=none; b=JmVZAXnj2fJ4ldb3b744+huNh0uSPITGSWNm2N9njCV+NQuBVO4fVg0aKQp1kDdOfB7VIGbBreplHrpmw8GbHnWDsGtfMai6EnELOSJiifb+mZxsdziThXrCP7dOimLaf/B6iOmiZg4mOjMm8dd2tTJGhkgzGPGdtLEewdkCCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292684; c=relaxed/simple;
	bh=mY1sRu6kvsJx4p25fDSDqFcNwuKL7CwzNTNM06M4Wwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG33JSWGeka4EpnS330mT0noW14kFwhOx6yo0ufi8Ei/FhMOkcUpLBdU9ViWmksx94c1Jc8kmXvppv9kBdqzaCHqxLrJceBXAlG0icWp4r9YTCOq2zbekQq6URb8Cg55oqhLAsMWs+YEJ0CvIfSI65QZC/rs7G6lK+QGO62J5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK9eFiKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156C9C4CEC2;
	Mon,  2 Sep 2024 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725292684;
	bh=mY1sRu6kvsJx4p25fDSDqFcNwuKL7CwzNTNM06M4Wwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK9eFiKCCnkjHsqsE++zRvsQ8Fh++vqqfYcYjpejBY4SWmEyQGGQYNJw1zTi9PVBU
	 BZVVnEZYCZ4b3l6xC3f3/oIoCEkOw+tCHFNCgd4R72R9QdPZD5IBbXNsvyokMFh6zd
	 Hq1z2GzWTLpFQumwO9++PyQI87zfRzdmoTNZkZp2mB7frAfVZohI/YupfbZNY1dzVz
	 p1K29ORWKlwrPq5ofX5GgwrimCU03dlzf80msMR97mm9yXAdNhjIQ1s8LMkLwngUAr
	 HNOOaarlBzvRszlRZo33fI7/q68i7/hP3gzO2lp4T3P8f8VsIUpmIq1DMJFu/2s5iU
	 bxY19sXUsMV9w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sl9Ra-000000001eV-2J9N;
	Mon, 02 Sep 2024 17:58:18 +0200
Date: Mon, 2 Sep 2024 17:58:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <ZtXgmi0TDfDMwnlz@hovoldconsulting.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
 <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>

On Sat, Aug 31, 2024 at 11:25:54AM +0300, Dan Carpenter wrote:
> On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> > In the similar way, ignore 0 error code (AKA "success") in
> > dev_err_probe(). This helps to simplify a code such as
> > 
> >   if (ret < 0)
> >     return dev_err_probe(int3472->dev, ret, err_msg);
> > 
> >   return ret;
> > 
> > to
> > 
> >   return dev_err_probe(int3472->dev, ret, err_msg);
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This is a terrible idea because currently Smatch is able to detect about one
> bug per month where someone unintentionally passes the wrong error variable
> to dev_err_probe().
> 
> I really hate this.
> 
> NAKed-by: Dan Carpenter <dan.carpenter@linaro.org>

Regardless of any issues this may cause for tooling, I fully agree that
this is a terrible idea that will only result in unreadable code.

	return dev_err_probe(dev, ret, "registration failed\n");

Except it did not fail...

NAK

Johan

