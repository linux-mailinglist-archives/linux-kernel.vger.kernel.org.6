Return-Path: <linux-kernel+bounces-350731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709819908FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E067B27D90
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526B1C3033;
	Fri,  4 Oct 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nZJ5boJU"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA4381AF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058452; cv=none; b=ngw081RAjfBrd41sEDc90FxjuQiOSp4GsHD0NNeM9d0IyNr6G6o8mAm+HGVQXTVgeLV3T1P9MhRgbplvUqeDs+7K3TjXYgHfPAoL1U/SGvii3VMS5k8YaLnKEGoxAdO8Ll8k2Z1z7IWvkzhQUWLg8aQ4SKpYXcQWJRJPzetmNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058452; c=relaxed/simple;
	bh=YcjYn7rRzX45bmS0dUJRi0VLoeflEEWYtLb+AkCEaIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKBnlnUwjFxOKNqTOy1tyhpnf8C4wAhQ/4rfxmaHcjVRm2w7v42dQ+zl7louoBsnthYZlzK6r7GYzt0Beab9vpc/J0ow8mKlbKc+Kv2qT/wSxmB8vmWs5l9l5gQmRPZDN80vOzDxeafDvX0H7saTvjx+aRzBy3th20G21iUyRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nZJ5boJU; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71116d8504bso1426100a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728058449; x=1728663249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2Iit7fFgKBWP7MqjbwBizfG2cS9Hz2aUvfI/dAalIM=;
        b=nZJ5boJU8LiTZNx+IaFFyirbaTHwEWp74D7fqV+jTep6ZoUWTgwm4bt68ZezVQpoRs
         ftLRZktc/BuwGQacUqRDRY99J+Cr9uZbrde7dqK/4x0/us2PJ35H6RWsOgQinSl0RSob
         IatC2PdJW5/U68SXDk2eOQAQEhSXe8cloPGIL7iBpuyUbo+q+5AKdxoG4+2OyBKZyiD7
         /TFldafQ9sJDyY+eBdB84H1jdL6ZcCrbRO524z3UkgDZfo3/vP1fX89vEu3cEHJKcHYI
         UsUd6vLz7vfFvgSbZSxepZ7l2PGqxCSPIjku4EJo6DqPybgGFRR/fxDlJWolw9zyAir9
         X5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058449; x=1728663249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2Iit7fFgKBWP7MqjbwBizfG2cS9Hz2aUvfI/dAalIM=;
        b=msSDlGHNujNenCentgrMT7ud8vBB/IrX/DQXMdfr6hXop+3i1wS+McktORM4MKM0Os
         4F7N4j8pYk5e5vIWuym8yKkkeBcEGgGVGDuF71jJrDkWChFRbgZ8K0U2YS5IbjQ1TsdO
         pvFyDEctumcGQjQea8Qwhof4jiGXy/vEIYaC8lgzSRVywVdkuDj3ofzYDev9UuE9ktLU
         HJd0jKWN/GdMHGR7nJslD91rHI1UTo+Yx6DQWh6KQCrUm8mruDcQ0KHiDQdvkUeSzOOQ
         g8txS0qv3B5LnQ4yWMZJ8AqOvxiNXz0LxEbP0LMUaufkx6d+WMWdNeXdnZw/T/yJyfhM
         D5vw==
X-Forwarded-Encrypted: i=1; AJvYcCWS9ZREEgek5S0GAhtCNFVEAR7z7IuygtFHx1sa9fo3rDSbeHR2My6hTus9mzgThKD/Kku2gonmkTsi/NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4Q206VvVS7euxLdqNLELicyJyEo8njbWmEYpmOpNbMB+rEB/
	/GGtEanIUkmrhWxgU4xphewlk36F/gN676jF4Hbd/toqvKt2OIaBaRNp+e7jHKE=
X-Google-Smtp-Source: AGHT+IHNZtp0RdmKR9tPX6Tz5fe0BbWkd+TEdNBUAWZwajlgqxRX7pqiGzGGB5dusaMWe6dfhlFLAQ==
X-Received: by 2002:a05:6358:9889:b0:1a5:b0f7:251 with SMTP id e5c5f4694b2df-1c2b83ad8a5mr126598055d.24.1728058449246;
        Fri, 04 Oct 2024 09:14:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46d0fddsm534476d6.5.2024.10.04.09.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:14:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swkwS-00DT5g-CE;
	Fri, 04 Oct 2024 13:14:08 -0300
Date: Fri, 4 Oct 2024 13:14:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com,
	will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241004161408.GJ2456194@ziepe.ca>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia>
 <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
 <20241004124343.GE2456194@ziepe.ca>
 <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>

On Fri, Oct 04, 2024 at 09:05:46AM -0700, Yang Shi wrote:
> 
> 
> On 10/4/24 5:43 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 03, 2024 at 08:31:23AM -0700, Yang Shi wrote:
> > > If I understand correctly, the check is mainly used to avoid the u64 -> u32
> > > overflow. This check guarantee no overflow. If some crazy hardware really
> > > requests that large memory, the allocation will fail.
> > Sure, the kalloc will print a warn on anyhow if it is too big
> 
> Thank you. Will spin a new revision.

Oh wait a sec, it is not so simple, the 31 is too big because the
multiply will overflow or truncate to size_t too. This is why I picked
something lower.

Jason

