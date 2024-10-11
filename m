Return-Path: <linux-kernel+bounces-361489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0E99A8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3AB22ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9526C199E84;
	Fri, 11 Oct 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GWhCVcHb"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FF1993B1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664217; cv=none; b=UiXlKTLbNS4XupVZIe4uU4plv4pye11F4pZJNwNkCldzpsFX3QgydSl1KkdOScqY4pUoc0rkVyTxhSWgeVXNPphn7u3a+MaS/eQpQaN6sYAa+TdxYsXT9lSxtOxa1P5BT8bW/kEBGPUAnZ+liT8RnAKenJf1IkJi9onTITX6oUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664217; c=relaxed/simple;
	bh=ouMRHIXhivuHHZGJlG3Z44V/Huuo89hdE0o6BXQHi2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE6Ck6l21YTBl9yvWFvOJzQfRyoTqijdHdAH8i4yfhCDckTpQWWpvtT8/0SENaVdnTCNRNX0s2WYyP9HTzEreAH6rCRWbnyHIJbo2etsQHV4H8M3S8R9PW7dNOvt/4bXzI70GNXwm9bAmBSlTh261L5wYoK9DY1danybZqgZf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GWhCVcHb; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c5ab2de184so13632616d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664214; x=1729269014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPhAadXb6deLzT65nScMA8kj+FFthnCaAO8bn8FgNrY=;
        b=GWhCVcHbnWQVgYtoGQPqjOavYflip3QE3NGqPaSS5lM0ZXua50eLMbw5JvqNczqArJ
         H/nNuYhG3sSWpvY4ZXi/urlrHowF5+rdLPgereO796EAm0hQEs/tttL4x70KK7eG93Bq
         VyNo5wmEk3PryjYGM5lTfaja/ARhBpWCv0TnzTiW8knCY480Q0G8SXd5FfCzA70769OV
         BHH7JKAS4RS/NOLqr4mzKsdxwYtloZPoqehrW/iDHo41XOP6O2AyZlBJBYoi1x72xpj4
         5HzOJfQiZLFk1cJOb6VmTa7lGAAlUij19iGNfHxux/wAwRFtqHdyciT1QIEsteMl48O+
         7qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664214; x=1729269014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPhAadXb6deLzT65nScMA8kj+FFthnCaAO8bn8FgNrY=;
        b=Aq4Yi/u1XwcHKExAwktf9lR6xhqxTcJjUhQrl8zYJUWLJ1W7JJjTbj2OLgC3A7LzHZ
         2tYjoyd9IFsPr2+hFMV15KOHFqfp3DMiw6Xgd3kcvQpOqWUX1XO1nubyng+nXJHDOWeO
         9RlQ0NKn2Po0woYG7Zet3J0IBE9/+q4B61fttPCwLl9m1mW/+hYShoU++6CMZIWwe8uv
         D5LUSvOPyW+LR7wKk+i2YXAEOGI/1SjtK+//9CW9seU6xC4lRPsinQBMLgs1GKp5q+1f
         h3Jn7zmKVWPwQty1Ew1QibK1v6gHbJm4k2opk+31WIM/nNxBXLfVSxRpJBp67z9aSriz
         xr9w==
X-Forwarded-Encrypted: i=1; AJvYcCXkv0rebyx4Z6L19xyeXQMw43jcvyeHMTgB1IDXJ1Timbjo3YYZhOX3vvDcQN42UOfkRbIFtSeLdw1hPZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sskG+aQ3MQAVptM7zarM1ktewkY2Hep0fZCkzwCmEDNCjBYe
	UU9O4FsKL6eNdwvy1FLUhlf7ifmyiaCJsOrhzXgV99RdhKxWDaaQC0IBObTPWt0=
X-Google-Smtp-Source: AGHT+IFVYjgNGvbnm+fz+S+roYIt0msKBxnq6ZqbWkjMoLLY6L7C62MrX3NFxmjayxzvu7T4CrAADA==
X-Received: by 2002:a05:6214:469e:b0:6cb:a616:7c7e with SMTP id 6a1803df08f44-6cbefffdebbmr35637696d6.2.1728664214289;
        Fri, 11 Oct 2024 09:30:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b79e9sm16838466d6.32.2024.10.11.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:30:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIWq-007e0D-Tu;
	Fri, 11 Oct 2024 13:30:12 -0300
Date: Fri, 11 Oct 2024 13:30:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iommu/vt-d: Remove domain_update_iommu_cap()
Message-ID: <20241011163012.GM762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-5-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:19PM +0800, Lu Baolu wrote:
> The attributes of a paging domain are initialized during the allocation
> process, and any attempt to attach a domain that is not compatible will
> result in a failure. Therefore, there is no need to update the domain
> attributes at the time of domain attachment.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 83 -------------------------------------
>  2 files changed, 84 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

