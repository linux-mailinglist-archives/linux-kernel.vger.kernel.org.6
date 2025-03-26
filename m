Return-Path: <linux-kernel+bounces-576980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31494A716EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2BB16CDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BE1E1E0E;
	Wed, 26 Mar 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KTur8psl"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4761B3950
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993601; cv=none; b=fFrTg4sWzwR+nqp2/8+/L/lLO+5w/3aHfbH14oueRVg8gLaduyac6VbZYRaB4FquB/uRBKOJ6suOPsQRGbkuyL8wy5ISndwUos1Yga8B/PmI7GucU+GyULvOHzRajBEm9fXWVVk+Rkhc16nZYeo6MwqB2gvnpI8+rWwGvQfs3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993601; c=relaxed/simple;
	bh=8HHp1uBdC+4gdzNJZq59DdfqIQAiw0gMCqs4ThMiGLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teA549+TU/dIh9+krCXYB5vrQK7zGpT/RCziKTegtWZGO/KcqgC2ss4j6myRCEDSAEN9eTdDOnIzRN6drvMapPLFt4nmDeXlbvoDLfsK3w6/a27pX/5uoEZ3hlYNS7T+U0l39jlAkvB6nZuRVYJbDzfUNXRk5gc24PuDC3jECPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KTur8psl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c54a9d3fcaso690177885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742993597; x=1743598397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unBBZW4o0XvmaaTwB/+3iSkpD4sIQERsLXl81RTyoyQ=;
        b=KTur8pslGSHJ8IVvochTjVgBVpVZpF37vPvfn4u9I+ekOv3fxfxZsYWkQW86ryGvNX
         YIos6QbYkPgFaPLvnd+aJpX6D7tOwq8/GLlP8j4VzktsC6z3n/MtIy99sfT9/yltPlam
         pRNMIGzywkBN51M+PMSB5dEsdE+9JMqwjoAUwRTmmzcb3DbHPx3nHuk7Mh24HdWPoW2j
         8Imxch9Sm8o/IcVM/CCEJIExL71kutg3FWJB8ELkf0X6P5Yk5I/D8RIlviCgiTnPtqbO
         lh62y4N5dewBMZ77t9FkX9P590UkroY2HdRp7o5nKoNe6XPVXZURr5k4Ac/HnUH9fUIj
         ys1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993597; x=1743598397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unBBZW4o0XvmaaTwB/+3iSkpD4sIQERsLXl81RTyoyQ=;
        b=lcMLN5O0JmkA8ucKnHnOSwNsohheecw5MGvF9NPP9cljqibnY53CpU48JThL2nhE5E
         KRz7zX9KRAxDyXP1yxbD6rAy0UvGDHZp2wcLwWViDrTrlhno/2kpzTB880w7RGeUnWuc
         eGlcC30mnbBroHVK3zW1Mq+EXFdXoF3pzNoUBJl0Dz1+wUh1yatVYn81EbsaCOL+PJGw
         H5aeKbTZfiwXWq8GUSUVxhIGZwPT1wipIrhdKIYB3ydVFN4ONhbPT6w4BIClIsExIpyX
         3NJPnEBIn8DJEnH5SfirLHSCBzLuvKYoFJn9AXcPSyRFM1PdSqKa1fikhpsyVFRwkjTH
         VauA==
X-Forwarded-Encrypted: i=1; AJvYcCWdPGpuYW8IW05vTT3yjE4eYLB8jqlSNCtylyCAub3BvrVHEagDFkcCIGIALa/YuurI+0pf1QdoUVAl3ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmHrrdzG/iPLS5CmleNUeyVZT43aRsVxLpbQRNEkjD1GweJTa
	ekPrQl8iRd6QC+3khL0cm0bYgeQZqQhIpMUepeBxGwOcoYIFCMzqaCsg8bxEuBw=
X-Gm-Gg: ASbGncsnYCqcCutJjsO5iI2KMabLT4TqtMoB+goeKVAup5/EpMtSf/vOPH3oCXSP5ft
	6o9k3I9ih+xhUk1WKvqBNSxumPOeV0OoId26b5DQXUIYiLVdEEo3MfNco6otbPWlBSkDFEimsz0
	NuvUvGfUVhjLYXhLkdeTvZXGg9p9A6BXJFK3epTy7AaU9/GI18hhD9UJvkJS/VTfdxbaggoZLHw
	gxhUrnslsFkoBE1xcdTmI/QSQCR7Xrh2tXf8i0yMSUjpGgZFbCz9JfZZRnzczTEqtc0Z7nMEe9M
	dHxNODNJF4FK63PRGw5mLWa2tTiwTtTUKCkXUc+QUvxsIRbzhwJ04g==
X-Google-Smtp-Source: AGHT+IEyK007wueidBJdaxRdr4xRWmnbMteuuUEM+eIwVWK6Vpov8l7x9HZXE3tKIEMisQ/zDeiPqg==
X-Received: by 2002:a05:620a:29d0:b0:7c5:3c62:804c with SMTP id af79cd13be357-7c5ba157d0amr3415424585a.21.1742993597358;
        Wed, 26 Mar 2025 05:53:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec688sm760794885a.64.2025.03.26.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:53:16 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:53:14 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z-P4ulrFQAbJBC_A@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
 <Z+PIoAGgz33R2c3P@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+PIoAGgz33R2c3P@phytium.com.cn>

On Wed, Mar 26, 2025 at 05:28:00PM +0800, Yuquan Wang wrote:
> > 
> > Notice at both the root and the host bridge, the Interleave Ways is 2.
> > There are two targets at each level.  The host bridge has a granularity
> > of 512 to capture its parent's ways and granularity (`2*256`).
> > 
> > Each decoder is programmed with the total number of targets (4) and the
> > overall granularity (256B).
> >
> 
> Sorry, I tried to set this topology on Qemu Virt and used:
> "cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3"
> 
> but it failed with:
> "cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4"
> 
> It seems like the CFMWs IW should be 4?
>

It has been a while since i've interacted with QEMU's interleave stuff,
but IIRC (at least back when I was working on it) most configurations
had 1 device per host bridge - in which case the CFMWS IW should be 4
with each of the host bridges described in it.

I'm not sure you can do multiple devices per host bridge without a
switch setup.

~Gregory

