Return-Path: <linux-kernel+bounces-311193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF09685CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5701C223DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBE170A03;
	Mon,  2 Sep 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GU0r+obX"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDEC273F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275450; cv=none; b=lHHm+4SyvhKAUwxs59s17wd9mvw4GfjNzR+mpIGkOxbb/ZAuW/LBg9vke+4IFs4GurV4YXAkEeDxEHoDLBKUsIzKlmmao2gz9qywgRj8Q3H6KgCuX7cMb5AXUBrEs1dLzOEhwxHxtD86oqCeiDj+TSBmu8k+hk072N3QB+JsdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275450; c=relaxed/simple;
	bh=9xWxK4k2JHrrkPmTw7yOFIyiXI0XGPVObk6ZeD9Mluk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S90AGF95QBwNfRScP/kihmDJYxpOiiDjJDpEawFzvyczxMQuNP9geAcPBsPF/K5udZTJybFjFqeGcbZWUuKTIHCB5+HNNlmPTB9XpLgxzEc8qiShncWcHuU1wWIn0HQptrlH1Quo4s2SvaVGAqtna3HUyzAW6LOE8GeE4qHXqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GU0r+obX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c3eef389so1119867f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275447; x=1725880247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nOO7Hb/JXtlC/qgW8ERIJO/M5AFtKMVdqiKQIt1Z+F4=;
        b=GU0r+obX+vsF5CIYtgYOMwkbt4/IiLmecpbmMplpl7zGJ2uYgSpNJy/UIC9lfb6Vy/
         /HeQZrLZoWmnEEBmE6jQasGqCoaasx0LRMnyNDgSv6Wu4qDtsvxn66CexFddtQ8xCOvN
         5/jB29jG4FiuIvzbUqsyrqSIxAAqLIAe3Yvdo/RJUkJx1jIa4ao3X6RNjDg/LoQTCK4E
         xLcRihHQA7BuJALC3DGHqE6LdYJjr5XrqmptelACExu9e+lbbaG8rsi7SzR8EmhxBf8+
         2EM2VL7sFoZ95/okqp2zk7opicfIsKvxuuj7WXZ0jrDXmwCapqnSt02ZX2LVdxV5HHb7
         ZAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275447; x=1725880247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOO7Hb/JXtlC/qgW8ERIJO/M5AFtKMVdqiKQIt1Z+F4=;
        b=rVbAkF7+cj9fzeukp0yFO+rK2e7KigR8lljFp8bmh1PjXaEkixt8klYf4IDXPVGiOS
         w4rBKIm1cxkI/2CZqTAHHcKjcCSpAnCnGViN0wk90ULhCVL0kG+k6AXPg16Da1KF+flD
         sU7ut+nyYoKnHSNU1TXl/ImlOIF7b66WjZM1RLg1lLEBsuQ+9A1V3nqySXPdYm9+Ihc4
         N5c1mZqwajqtjpvDG/WCPS2AKxlVwDOKhomI4ZCJ5J3FvS731EvR+T2cf7LWW5grOgZq
         yHjvj0sdQ9yeIZnXp8lPNRzkwuQ7oCSvc+t0C09HMFSgNBqxQ3Xol15qqb7y+w5+RBB7
         LHKw==
X-Forwarded-Encrypted: i=1; AJvYcCVNfmTF8ksV8ZpuhsMY0r0jFnLYTRufHWRCsiVKx1VzD8S8HTbGdpuCjwbzGPAwfP4I7K5nv79wregGZKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGsVJQ1S1pcM+zVvdO00ajbpt98KQGjvO1j9Oy/KokH8yjivj
	7++7HcZAHgiYQTeGp/8IUcubbkjbXVTJbn3lJM5Vy97rGL9vKTDMsk0HiUaf8O0=
X-Google-Smtp-Source: AGHT+IEz8wanJZGmgbRn3Kk/Dfz53S+s6/CjQbgF0rK5OlIPJrcJzBVzkoW0OUweK2VZiBz9Asg/7Q==
X-Received: by 2002:a5d:6345:0:b0:371:c518:6f54 with SMTP id ffacd0b85a97d-374bf169505mr4896215f8f.29.1725275447376;
        Mon, 02 Sep 2024 04:10:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a42sm132114425e9.11.2024.09.02.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:10:47 -0700 (PDT)
Date: Mon, 2 Sep 2024 14:10:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <4e8fa6fa-89aa-422f-b603-e2a3e1a2c704@stanley.mountain>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
 <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>
 <96a19237-9380-4173-9e52-e8295a0f4883@stanley.mountain>
 <ZtWQcXerriSnWgf1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtWQcXerriSnWgf1@smile.fi.intel.com>

On Mon, Sep 02, 2024 at 01:16:17PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 31, 2024 at 11:53:51AM +0300, Dan Carpenter wrote:
> > On Sat, Aug 31, 2024 at 11:25:54AM +0300, Dan Carpenter wrote:
> > > On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> > > > In the similar way, ignore 0 error code (AKA "success") in
> > > > dev_err_probe(). This helps to simplify a code such as
> > > > 
> > > >   if (ret < 0)
> > > >     return dev_err_probe(int3472->dev, ret, err_msg);
> > > > 
> > > >   return ret;
> > > > 
> > > > to
> > > > 
> > > >   return dev_err_probe(int3472->dev, ret, err_msg);
> > > > 
> > > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > This is a terrible idea because currently Smatch is able to detect about one
> > > bug per month where someone unintentionally passes the wrong error variable
> > > to dev_err_probe().
> 
> How many cases you know where smatch is false positive about this?
> 

This check has a very low false positive rate.  There is only one potential
false positive in the current linux-next.  Let me add Baolin Wang to get his
take on this.  I never mentioned reported this warning because the code was old
when I wrote the check.

drivers/spi/spi-sprd-adi.c
   550          ret = of_hwspin_lock_get_id(np, 0);
   551          if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {

Is it possible for the CONFIG_ to not be enabled but ret is zero?

   552                  sadi->hwlock =
   553                          devm_hwspin_lock_request_specific(&pdev->dev, ret);
   554                  if (!sadi->hwlock) {
   555                          ret = -ENXIO;
   556                          goto put_ctlr;
   557                  }
   558          } else {
   559                  switch (ret) {
   560                  case -ENOENT:
   561                          dev_info(&pdev->dev, "no hardware spinlock supplied\n");
   562                          break;
   563                  default:
   564                          dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
                                                          ^^^

   565                          goto put_ctlr;
   566                  }
   567          }


> I believe the number is only a few at most, which means that you may easily
> detect this still with this change being applied, i.e. "anything that
> terminates function flow with code 0, passed to dev_err_probe(), is
> suspicious".
> 

I think you mean the opposite of what you wrote?  That if we're passing zero to
dev_err_probe() and it's the last line in a function it's *NOT* suspicious?
Otherwise, I don't really understand the heuristic you're proposing.

regards,
dan carpenter


