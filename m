Return-Path: <linux-kernel+bounces-325421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B600697597E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E682D1C222CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8681B3B2F;
	Wed, 11 Sep 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+v+gjxB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A71B29C9;
	Wed, 11 Sep 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076084; cv=none; b=GK0jiCJkpoATv9FPBVCRg70FB4R5F8NGf7oRbEroZJ9+bEwxmQrhClHwpoJ12kejE8YpZHZmRXxUzCzUMx2bnTiYSSsJZbCBSW+TFAOol8PpAz7VKszvXoBpRk9sh5bbpqcf/w2fHe2GvIXm7JYV+shiwTMbC9Tpy+alhSyg3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076084; c=relaxed/simple;
	bh=cptVxf9qIw+rXupZ5FawDp/6nxLX6A3YH/GDpNoW2Xo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYhawCfTziTJ8LL6AWqYwlWh2yVdQbJX29xBHGIOsvNi88yMYcKd01zZRmjLO4PS83KNuddL1w7V3jnletSoLG9xt3QWO/7/n4BWpuPowRzSK9y0ixESSGl/UsQsrKGmt9GCEsyND1UzIWjXGSpbKzSVPmlhupyyZvUHGOgoDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+v+gjxB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so11387866b.2;
        Wed, 11 Sep 2024 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076081; x=1726680881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HffJRtI/DVlYLlG6iwwlB2jKFRZkg+5GM+hNqxkk/lM=;
        b=P+v+gjxBptb0ajhqNPBaBEv56vC+n/fH33uyl9tv36WTbtUbU8RSC+w13bDfWbLsKL
         OJ3kbb8z2xt7v+2602qOwDabjDAaU3mgQcbviS7L1IClFd39lkBvtIx71G5sUYsaXlBC
         XIYmHGap3C8utZ7Gyx8oi6+bvckdS8jbr3q+Ur2kky7DsIUIYz3jaRi+tCg1I/tH2Rif
         Ln1S7WNJ//9axkWYQvXs4cDh/teIS2NF1OPzAeU8tFs0Vl8TSaA2FAiRb/YNSJZVzPj1
         5N8AlTHzNFhy0k+76ZsHz9jNfscwYBKtIovROrej7FB8DWGAIP0UbOjvXCSujhjraMNQ
         FWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076081; x=1726680881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HffJRtI/DVlYLlG6iwwlB2jKFRZkg+5GM+hNqxkk/lM=;
        b=Ka5H2eIQzGkHwIOhkJXDH2LKezWKHQxeIDAAPcOjttbvS1V4K5OlJ183uY+lkOQvjy
         7cRg4ol56Bf4z2tUhrwIV7JuyYpWgfpflCe5TMkSVp5I3uhI/c/kuH43+QgcwgGSxial
         2QFgByPk/Ea+N+O7lnYGh5DHw/PuCE+dAYh4kGXFmZ9k9iiIala1UcqOHtED8T+A8rGq
         C7xi/Uslk1AJRpXUwXC7nZmxhuldAiSzMFHTmf1I6kQ/AhmNXOmFUGR501HGGmJtaOT8
         Tx9bU2gHImXiB3wIWUOy+eDTx9OevtTwomNXtCZYEZuYEvg0C7omj0YCLALotJANChbB
         M3xA==
X-Forwarded-Encrypted: i=1; AJvYcCU17ZFeCBPhL/GEfFikj6uENuLiVygSxLmftzGNFJC0aFNmiQVFedzwAg8GHh3gKnKOYa4ZlzItlzUfgDjJ@vger.kernel.org, AJvYcCUj4o1w1iG9CczCPY1rpq+599p/+5IENapeV1g2viNuFqkn6RhaTtrPCNEAq6LzyIp9xuoSlnoRStNj@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcwymorCSkWiUKQIUrXVl47DPstmv88qygWsRejQfkHsPUCAf
	ftnYmh4LGmceMCSWCGHETGMA+2SiPyp4o6cO4UsFSdnRGQwy0ZlA
X-Google-Smtp-Source: AGHT+IGx0apl0UgdqMcYr2/OZY7R+So61ETixw7sxmYbC392KtJIdtJmTXfDe9sq92pzTBYd5TLqOQ==
X-Received: by 2002:a17:907:980f:b0:a86:8d9d:898a with SMTP id a640c23a62f3a-a9029674d81mr19230166b.58.1726076080568;
        Wed, 11 Sep 2024 10:34:40 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:797a:1b45:332e:77c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce9ed6sm631311266b.165.2024.09.11.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:34:40 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 11 Sep 2024 19:34:38 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, robh@kernel.org,
	saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] of/irq: Use helper to define resources
Message-ID: <20240911173438.GA5015@vamoiridPC>
References: <20240911160253.37221-1-vassilisamir@gmail.com>
 <20240911160253.37221-3-vassilisamir@gmail.com>
 <ZuHCJcTyQvfPl7ai@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHCJcTyQvfPl7ai@smile.fi.intel.com>

On Wed, Sep 11, 2024 at 07:15:33PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 11, 2024 at 06:02:53PM +0200, Vasileios Amoiridis wrote:
> > Resources definition can become simpler and more organised by using the
> > dedicated helpers.
> 
> ...
> 
> > -		r->start = r->end = irq;
> > -		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > -		r->name = name ? name : of_node_full_name(dev);
> > +		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev));
> 
> Hmm... It seems you haven't replied to me why you avoid using Elvis here,
> while at it.
> 
> Also for both patches you probably want
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > +		r->flags |= irq_get_trigger_type(irq);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


Hi Andy,

Thanks for your message once again!!

I honestly didn't know this operator, I just found out about it.
Looks like it fits here, I can definitely use it.

I am going to leave it for a while to see if Krzysztof or Rob have
any other comments and then I can send as you proposed.

As for the tag, of course I can add it! I just wasn't sure if that
was the case for here.

Cheers,
Vasilis

