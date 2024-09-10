Return-Path: <linux-kernel+bounces-323920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E126C974545
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20F0B21FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F91AB539;
	Tue, 10 Sep 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2QmSAoQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D918E36E;
	Tue, 10 Sep 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005640; cv=none; b=IgHqwJiDuD3wgFsRP1xer8fg+24wC4kkBycKxKqLy5EmcrJxQZ6QOV5g34ePnY4AaudkckKO4BvtYjmNkKr6rMb6FPg+TlVYpLAr0JLBTefBlpfasOX3bGldasIr0V9aRluVySosWMs5PCS0pMTJLlzRUenM983cUODleN4gGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005640; c=relaxed/simple;
	bh=VsTjWNADfLdStC2suvhv8Rq350roC915QLeW/CXDE5U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR0WQ+YJkMMlTMnfyYeMdHw89J++rSshFi7nnP6Jfr6VkN1LsI+Hlsy363cH37bgwj3AG1gwogZVNJendQLIE6pztN4EQmohHkeRQvN5XuBdIZlLK4+kZR1pc6X+F49j3mgBxi/7Eevi7hLJNU/0c2zfOt2fMLwNMvcEn9WpqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2QmSAoQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53660856a21so3762097e87.2;
        Tue, 10 Sep 2024 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726005637; x=1726610437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jMtl0prKSdJz//ECC13RAziEQ8EPeFlB0bmZxnmxps=;
        b=Q2QmSAoQpp0YUcU8nyAZkCoUICwm1TbW/+57/QdWi3AvD1ibYlihM91Y2tjtpN8990
         4/O9L/qsERVKLmUsX/ftt0HM85I5bYN9LdO2MeYpQhXrFnH5Ta02R+VcYbUfKtx4pBf6
         IMqDEBZtacD9cL1cGzS2O9mUbnNihVdvmCb+wPudiDIPIcckM3YGiYbZ+yqiGEaN+UYH
         re9QXGzwJzLXx7lVN4QRQNLEm7VGNYd70yxYw6MQjvS0h/WzIqX9CFNhq29uLU5vN5ig
         IRY4TtyIBJFwflTBiYq9YRve4cB0F1IhXOmt9u+VxJkWPMDQC0NzEbFKB6LZxoohWZbp
         fw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005637; x=1726610437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jMtl0prKSdJz//ECC13RAziEQ8EPeFlB0bmZxnmxps=;
        b=I8+MJ8lm6YcVDcMNQh76fzkkfxmH5tJpuoJSvsCSqmtaiUNwRX+MIH32k9L7yeGPLD
         ymZdLpVQgKFN4n008t00JMLkWkOTEv4n4OnXWRZR7ynDGZF/uuhJa+5YrL64zLB1Qogp
         040hoQkK2MT0KSL9QfEC1grYXTcFfVOg3kcY+Msat4BjOSimD4fGWeLK2aJHU6PqHEkb
         xSkPbUBiF9O+urn7fddLYRYk7xn2qJxQpxBtLHQzIbWHp8e+cNFJcyLPro/F4c5i1rTv
         Zdk+bMQ4FWZ08ugJ3JynQHkJwHuG77Z/TCdKiIAvHd+fTh7lql2CsbgGkfBXB87fwf+Z
         Zu4A==
X-Forwarded-Encrypted: i=1; AJvYcCUyvdJ1jeA+MwXNvvnb/+Z44yxx1VNrmxsxOceav8gx6hB76My/xB26t44FEkSVc54k1LKbCZSuWC8k@vger.kernel.org, AJvYcCWK3Iqn/71LsUJR/bsyAy+6Llx6QZTL+A1IIpnkzSJmCl9YCHgIyRKbmRw7jl3/LcXn04NAD6fUUexIDlT7@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8WmOa8f5Bpy4xdvkYUIgJnh5t60dIRg1GHAFtP7ZSqJuxeCI
	Pl+uQqjPO7dMPOzD/P0SXksF+zkx3LdH8HM5CDyPLJoBbaPsBhVJ
X-Google-Smtp-Source: AGHT+IFO+tbp/diwqj/gYjQo79A6AcJtxm5yl6bKrbc7+otBgsQycMyX/JIKwQEk3yN1l5KZra/hSA==
X-Received: by 2002:a05:6512:220c:b0:535:66ff:c681 with SMTP id 2adb3069b0e04-5365881042emr8174927e87.48.1726005636662;
        Tue, 10 Sep 2024 15:00:36 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:5d47:19e4:3e71:414c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd424dasm4733467a12.9.2024.09.10.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:00:36 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 11 Sep 2024 00:00:34 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, robh@kernel.org,
	saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] of/irq: Use helper to define resources
Message-ID: <20240910220034.GC12725@vamoiridPC>
References: <20240904160239.121301-1-vassilisamir@gmail.com>
 <20240904160239.121301-3-vassilisamir@gmail.com>
 <ZtltLjZkFBWSbl2s@smile.fi.intel.com>
 <w4mq5nareqaf3fpwf3hr4oywgxlnjy33va5ftspw5rmdxuflms@x3lw3pj64tig>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4mq5nareqaf3fpwf3hr4oywgxlnjy33va5ftspw5rmdxuflms@x3lw3pj64tig>

On Sun, Sep 08, 2024 at 10:44:15AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 05, 2024 at 11:34:54AM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 04, 2024 at 06:02:38PM +0200, Vasileios Amoiridis wrote:
> > > Resources definition can become simpler and more organised by using the
> > > dedicated helpers.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > ...
> > 
> > > +		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev))
> > 
> > Just use Elvis to make this shorten.
> > Btw, have you ever compiled this?
> 
> It wasn't ever built... and if not built, probably not tested, either.
> 
> Best regards,
> Krzysztof
> 

Hi Andy, Krzysztof,

That is a stupid mistake. I was sending around quite some patches and
lost concentration a bit. Will fix that.

Cheers,
Vasilis

