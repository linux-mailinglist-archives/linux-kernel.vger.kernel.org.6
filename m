Return-Path: <linux-kernel+bounces-445526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F59F174D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635631613F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6219007F;
	Fri, 13 Dec 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnh+Iyph"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102818FDBD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120841; cv=none; b=Sw5Xjk6n+n3PNS5Hy+wRN8Kr1jg/hnm1E4DmKQSssc0WW1IoR8TTuikZq/eLHsrKGV8xcASrGbqiPuKDFaWl8Nule0d551hj0i5F35OUWiELPaAfPIy5zkOVb4gkIf7+8SH1+9GMm1qjz96Wd8yPXWMxDJ4IO8CXcgo8mFmrYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120841; c=relaxed/simple;
	bh=f2jyOe+lg8F1rPmqbu6chfwX4anYDD0i5ra/as4BSA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOD3RjXISbJf3VujfN1K2QVRVNeXqX35spKe7yABpMyQcaf+LkyR7cuMlWurRI2r0SVu4du/FEQWxU/82B6BBJwsM8Q2hqgWjQyJDEVWXNSVQPXnW1tgKq/EC3IkyY8SHpU8szfc9/td2ibpoYRbiJwZTOxVZsbpAPuuyAqZIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hnh+Iyph; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc93152edcso1775736a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734120838; x=1734725638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA2vp+0Q4hjfylA+aN4ZK1qWmF0cLRB2spMI6XM8wUI=;
        b=hnh+IyphpXPI/UfAnVsow7vFiYny3cbbkGxQnLbht3pRATm31pL7PJCbHV2kIajQ1B
         mLLNxjG/AihUqqAabp/naZqykHbM25RTv4WtWXQK1aj6J0T3B0y9o4TtAprV5rxnX3vC
         n7vXlVW71bAaK+UKh7dpjPJjR+FcAaIhID6XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120838; x=1734725638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA2vp+0Q4hjfylA+aN4ZK1qWmF0cLRB2spMI6XM8wUI=;
        b=EhAukY5AmKmyGSg751VqmXNnXjA03YLsnKD37ZFNZ39bMeHEBUrl57BLIZYCeOEDNN
         gQSKVsUjkUqHHSxiVOWgrpxL+OFb+lL5ND0ecW5ox+Iq/OyialUZG5RX/cEimhRCgVFx
         PUHz5QGTxWYJQKgopGfasQjzQoehiXopili7F9Gg0GQjfRmk3GXQKSlyieaq5Y80QP25
         6K9xGXKoN8jBHjJ+JXjRYU2duq/y7tpOv/hc9z7LrshQWistgdN1MPhwZFvWcZCeWXcs
         mqEs5/hlapkUCPZqISIUMt3O2yjMhN79FxdxnFFxbOL53GMbKL0AUNJmJ67fl3nFSIlW
         wa8w==
X-Forwarded-Encrypted: i=1; AJvYcCV2ff5XgRHZ/A1jF0eUIVK/4mmKsX9lzxsDlbeMYMXocMRAA5OJe+MzgWalNeHIex6LfkFtaxB+ieSihO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwptP4h2YdDd1/vTKeOyfV+A5HY6OpJh/Nmby8qGHPpU8lOFGJ5
	52d6zg/p1S4lyQ8mPAfylEFm+/vjQymfcU5vpB1Y9ekCMaI/7Xjze+CzpCBBug==
X-Gm-Gg: ASbGncuUbaG4r8XCKPLLCOSzQgbqIi5n9KzdQuhUSAO3TdbZF2Kp5y4oxjnsZJDKJA5
	ON2ue9ih6FgE5mWTQzolaJhKOwsNsywiKRxL5e0CHcmv0EwF+R2Apew+T5Ng5PLuRoiebHXuJuy
	GOKUZLDXvAltC6PXQNygI+VKon3ynZDQI6v8Yeo26PlAJCGhNcCV6Ft8fKa0t2ZhCfgXxZ3ETXr
	KGNidGDNEPx8ZrYhW8ITSNzEhnph0T1+It56Y9lmm2G+V+anS/iRYL/XAMb0as6PtxW1Iknc1ZN
	qebjR1f0NvQJyYB/tw==
X-Google-Smtp-Source: AGHT+IE2v3SR/KU8sT1pXTDInylE09uN/fwe8e1DJVZHqAxSyKPgCbB080FVuQIdjxru6cGbzDWahg==
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id 98e67ed59e1d1-2f29153af6bmr5376411a91.2.1734120838389;
        Fri, 13 Dec 2024 12:13:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:356a:489a:83c:f7d9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2a1e9c561sm177437a91.14.2024.12.13.12.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:13:58 -0800 (PST)
Date: Fri, 13 Dec 2024 12:13:56 -0800
From: Brian Norris <briannorris@chromium.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
Message-ID: <Z1yVhPJjxKhsc7VE@google.com>
References: <20241212003201.2098123-1-briannorris@chromium.org>
 <20241212003201.2098123-4-briannorris@chromium.org>
 <20241213-athletic-strong-bumblebee-bfabf1@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-athletic-strong-bumblebee-bfabf1@houat>

Hi Maxime,

On Fri, Dec 13, 2024 at 12:59:57PM +0100, Maxime Ripard wrote:
> On Wed, Dec 11, 2024 at 04:31:41PM -0800, Brian Norris wrote:
> > --- a/drivers/base/test/platform-device-test.c
> > +++ b/drivers/base/test/platform-device-test.c

> > @@ -217,7 +219,45 @@ static struct kunit_suite platform_device_devm_test_suite = {
> >  	.test_cases = platform_device_devm_tests,
> >  };
> >  
> > -kunit_test_suite(platform_device_devm_test_suite);
> > +static void platform_device_find_by_null_test(struct kunit *test)
> > +{
> > +	struct platform_device *pdev;
> > +	int ret;
> > +
> > +	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > +
> > +	ret = platform_device_add(pdev);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> 
> I *think* you have a bug there: if platform_device_add fails,
> KUNIT_ASSERT will stop the test execution and thus you will leak the
> platform_device you just allocated.
> 
> You need to call platform_device_put in such a case, but if
> platform_device_add succeeds then you need to call
> platform_device_unregister instead.

Hehe, well I'm imitating the existing leaks in the other tests in this
file, then ;) But admittedly, those are a little more complex, because
the unregistration is actually part of the test flow.

> It would be better to use kunit_platform_device_alloc and
> kunit_platform_device_add that already deal with this.

Cool, thanks, I'll use those in v3 for my new test.

> The rest looks good to me, once fixed:
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks for the tips and review.

Brian

