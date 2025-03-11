Return-Path: <linux-kernel+bounces-556677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61004A5CD47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A778D7A9830
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE9263888;
	Tue, 11 Mar 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI9CghDu"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C93262D05;
	Tue, 11 Mar 2025 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716589; cv=none; b=EZ0B+uOtiFiUqwLwaNk68q2/Xj0M6Dro4jHStP34Hyqezgv2cCJhzAHc7WQ3J22VBqh3Z0RkVw5STNjA+JBFVDfsYPkYdNhJelCx7KmLv/CWlgPyy0JRkRnAuGwyV7848c8ssq5RjQPqyiUUdndSCHKepclz7vpKpFTwN0VMbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716589; c=relaxed/simple;
	bh=KTZ7pAewKhJGTa4+0RoIrxJXtYufuOEKjZdQOIXGxks=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gexbmw8mTH/0QAWWZZDnZ0PgcD9T9P1Rcepn8KVJfoTC4H9IqzVKDmnBvywByb65Xq5sGfa4CoMVauGrGG6STJiSsBJ4jKxI8WqPMm9qolo1hT4ijrTflD5SSxqKvr7Bck+C9U1Z4LHFsZWFA6oTFmK5M3OfVBSwKGgtvtlKSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI9CghDu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so955888766b.3;
        Tue, 11 Mar 2025 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741716586; x=1742321386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w7YliLuH4qlV/MO/+JH2L4UcYmketDeTxX5I8TCDYu0=;
        b=dI9CghDu2e4InaN8M/wmugQ1/zPp4vRngPSnHga1b11ctv264/G5AUjrmnVSmTgswP
         BhwwTa/pm7laravY/eYsuqnmJkowvympHtvrJVPMvlge+XFuRnfhcOMBTLeu2j3ZG9e7
         8B9nXn21siN9hD7vcQT7NQvNxajl3kTALnITVA7qumyQrcZP0tOLmsXaWkX2kw37Ssq+
         8VCvhmWUx0MfECKQPcjm9escWZhcP6oYlq3MedS7iNgR8LCwB/LZ9ME0Jl/wsdNFv7w2
         WNXDZUJrjTgBoqWkfNQU2GMHurmP20H++zUvVJ2rqRgbmioUHgYk824Wp6TfOtDWmCI+
         T7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716586; x=1742321386;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7YliLuH4qlV/MO/+JH2L4UcYmketDeTxX5I8TCDYu0=;
        b=TR3sgb+NY+BZZC6agEGvlwE0YwIZKSNYRbwZzuxjkj4QIrJM5RAMXIEJM9hKrrNL14
         ZrGSK7mDnZyv5iVILiWTShC/T8vsuSmiS/V8RIXYK4bzHHmC8P/acJ/myN4+LTWVqQtV
         AlbjB7s3RU07BtQwG7FHrdoCc1yxpqXY9Wybf8cdac/nf94vJDvRemrZlddrq0tAcqvi
         7xjfVh5G6sL9iXJBEXJag1CvjLS7yISUQRBaeklISsKvoA0N21tBzKMf12OhskeudVCl
         xO4f2ghFjDpe91Da+/RwWJ/dlILQlRiIzj3baSdJmFYfI4hEwYhOLBSBJeHR/3CTpF6m
         ZlPA==
X-Forwarded-Encrypted: i=1; AJvYcCUivd4wqZhAGPKlGFTGArNthd1uIf1iN2S0Fzw1zApun0BGy3NPWOqJZO7UhvzVWuOQjjUZVr29EHVo3sCB@vger.kernel.org, AJvYcCVNSWQiZrkScZ8iSsLFP5bkE/hMenRuhp7QxFnbTHJek1fiWvrDhQN0pPP6o3pEsIVxVPzAV29Ph9pS@vger.kernel.org, AJvYcCVPrjFJ3M4gIoqG+wU88+ukD7W9lDHpCisvD84VjUBUXmu060tDWeqyDJZDotK6R/xIyGA6FC9JFDqr@vger.kernel.org, AJvYcCVV6bjXfRmXFoCu+1jY2xIc3Hm11tanrN2UXoH38rLZ8wi/kKhZ3n4B/qb6HgTUgbu4J161+7DQcNJQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KedOMauYww2fQ8PeBZ7zL3sgmsekDT6YqX4O0ZvqiWckHtph
	00KYLj55KqC+HuBIDoB2EimAxy6kZB8NqvR4SsbRYuhhHJ6lMGdFCgmtpGB2
X-Gm-Gg: ASbGncvXLPpx/6neYgNNNZMnyUPFB1MVb1HNtlmscp6Tt9nerfqU3pBD5IU6jfJPOh0
	w7MElJVnmjyon+zOF7MVa5sXeL9mTHZrDkQdklfiQdnHdOl9el8p6PsBJ1LWI08ZGs5hh1FYpQk
	3dZJiUt3w4+QHJXY280WouF0uEDE5nLe1/oaykW6JBO8CEUw9o0HnXCn+cOtfMbZMWcFEEoYzs5
	LstpK9PTDEni83bD1IBbocyN864vJa442omLiqMtLshKZb6s/nvR4QLwq1Lkbs9THLzSbLWzTWR
	nt8twTKLZ0mLtVmYCnfoGZsYQJCaZVx1BrXklKkGzADwhd8HCUSiLuyFJWEdNOjjgw+9rPwI1sQ
	Mt61kB6s2GxQYkZJv4Lx+NsM=
X-Google-Smtp-Source: AGHT+IFGoeMKh+SV9Aw9aLOSeklw6RYQlLlVxQgOHzKR34XV8RHNJXBdNm+Xa03GkQRMHVbvPeRAPw==
X-Received: by 2002:a17:906:180d:b0:ac2:5d24:1fcf with SMTP id a640c23a62f3a-ac25d2423fdmr1538965666b.26.1741716585443;
        Tue, 11 Mar 2025 11:09:45 -0700 (PDT)
Received: from Ansuel-XPS. (58.43.196.178.dynamic.cust.swisscom.net. [178.196.43.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2895e7e6asm511088166b.54.2025.03.11.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:09:44 -0700 (PDT)
Message-ID: <67d07c68.170a0220.3fa05.2c8e@mx.google.com>
X-Google-Original-Message-ID: <Z9B8Z2aA3MfCBBLG@Ansuel-XPS.>
Date: Tue, 11 Mar 2025 19:09:43 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 10/13] phy: airoha: Add support for Airoha AN7581 USB PHY
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-11-ansuelsmth@gmail.com>
 <Z9AhN9T8s1oogCUn@vaman>
 <Z9AhkByegWQgC9YE@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AhkByegWQgC9YE@vaman>

On Tue, Mar 11, 2025 at 12:42:08PM +0100, Vinod Koul wrote:
> On 11-03-25, 12:40, Vinod Koul wrote:
> > On 09-03-25, 14:29, Christian Marangi wrote:
> > > Add support for Airoha AN7581 USB PHY driver. AN7581 supports up to 2
> > > USB port with USB 2.0 mode always supported and USB 3.0 mode available
> > > only if the Serdes port is correctly configured for USB 3.0.
> > > 
> > > On xLate probe, the Serdes mode is validated and the driver return error
> > > if the Serdes mode doesn't reflect the expected mode. This is required
> > > as Serdes mode are controlled by the SCU SSR bits and can be either USB
> > > 3.0 mode or HSGMII or PCIe 2. In such case USB 3.0 won't work.
> > > 
> > > If the USB 3.0 mode is not supported, the modes needs to be also
> > > disabled in the xHCI node or the driver will report unsable clock and
> > > fail probe.
> 
> Also I dont see phy depends on rest. Please split this and post phy bits
> separately at least..

Well USB doesn't work without this driver so they are indirectly
dependent. Will split and address all the other comments.

> 
> -- 
> ~Vinod

-- 
	Ansuel

