Return-Path: <linux-kernel+bounces-262675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8BA93CA85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732E2282855
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F04690;
	Thu, 25 Jul 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bJnv0gPs"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CE143887
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944809; cv=none; b=Nz0snBNDnt9yKHIIq5FTxxYjNJuXXB6WE4igIDDp80uBuYHwdGSoBGCh1+mP/wXUqlwgRdXOjKUPePS/CQWZf1Yvf8Tl7yVoA5MbzbyWzgT+RiiRtrk4gSWB3fawOQpDqVLH2/yH7Ra7oraf5dCpPmkX45LzF3c1AFtiG2d4U0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944809; c=relaxed/simple;
	bh=KSjDde/wW6D5zE3NvMhyq254W+T5OiyoyXE8khJZn6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz0rA1QomcoIjex9E4VkMtq0OaSYMBWLf/PIATJZimXrCinS/BU3a6F3rs0slDe2tdq51XYfxuGwF9fns/Y0MWDY0Od/4nmfsXFpJXQ84tMWNgZmfmzxRMmQwvl2As23fOGhJNECrpCZWVqZOyXacNa8xAOThAtVZi0aNmPjtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bJnv0gPs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65fdfd7b3deso15263547b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721944807; x=1722549607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMAd4iLmUv8odVu7JAFB9ApmQQP3eAOg2M6CjRWnesE=;
        b=bJnv0gPs/bY+9s1BKhucvuZ5epkajJkx2a5xicKqaEfVcjq5BHM6EPvmaLJ0cGTb0Z
         zUwhGsc95FED1+3Rrj+YxQjwzIxzcd25/kgyfoMgAcl6nHE+ilJEQddgpVcJfLF2Zt3r
         ByYcacxTqB9gxSfUevjXjBvptE80H5wudG6UJHTKuaGXJwpj/PKdj0OH3Hgo0grISq00
         P4wjaLjNYkdNwMOOa5NRwm7sEE2+BVo+prG9tNrVH3GNLHkruoq3OwpshiZs3v5eyU4V
         LKC1mWl2N8PmjfDNhjcfwPxhCcWR2gWgFaObqHaxQ8S6HN3eyoH3utj7M2KPkhQcV7AT
         wB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721944807; x=1722549607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMAd4iLmUv8odVu7JAFB9ApmQQP3eAOg2M6CjRWnesE=;
        b=NeeDfeOZNT9tqllN1+gF4U06lURlEp2BppTIy2btwyeG9/WJ3idNlH284L7J5poRRX
         TqHpQU50ozOM3xo32BXxOtZWRln6fT7kYJlry/ktsS1h2MLeiupdPnuEyBajkip5KEbj
         QdnKSylE6dQl//MU4ncOmYCxYeaJvG9fPPMb/Uc6lE+DoycJ72iZlrgbdYd6ECOvRSFG
         Nulv5qDIqpRJodnEUYsJIQo/ubaCOi5ERNrHW+EQp/iN2n4xjyKfpWCR4DuVsmmy7E/U
         sCjEU+xTftWLdYxtuZP/Gf8FjIzV5FljitGEBH7qNqXeQwxbKAQ5kEPNEyx4CgGTUb78
         711g==
X-Forwarded-Encrypted: i=1; AJvYcCXScvoM6jzMnzNx6K5lGZhzyxVrAalZJp6cb79wydaTmTHN2gXjVdwHRbHgqieY8quSZsM038HX4BA31SWpkT6f+qBJL6469TuDeMCE
X-Gm-Message-State: AOJu0YyMq1+C0ChLSeomEVu15Ahw3MxVr8764S6bhlatjwpRDi8dAWEv
	OWLGmIhZPr6tKLMMPBYQiJjdx695oHSzIilsj8UR24Hs75sKsaLDOE9pZMi+NJs=
X-Google-Smtp-Source: AGHT+IHdUxAEWXGqn6foo0jARHDLvQtDiKUbJMw+adb16WFCsoSLyl/dUufXXzE7h2ov1yGNj9pzHQ==
X-Received: by 2002:a0d:ed03:0:b0:64b:630f:9f85 with SMTP id 00721157ae682-675113b347dmr45040387b3.12.1721944806711;
        Thu, 25 Jul 2024 15:00:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac10e3sm10707486d6.109.2024.07.25.15.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:00:06 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:00:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <ZqLK4CpSg4PfAdGx@PC2K9PVX.TheFacebook.com>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>

On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> Default expectation of Linux is that HPA == SPA, which means that
> hardware addresses in the decoders are the same as the kernel sees
> them. However, there are platforms where this is not the case and an
> address translation between decoder's (HPA) and the system's physical
> addresses (SPA) is needed.
> 
> This series implements address translation for HDM decoding. The
> implementation follows the rule that the representation of hardware
> address ranges in the kernel are all SPA. If decoder registers (HDM
> decoder cap or register range) are not SPA, a base offset must be
> applied. Translation happens when accessing the registers back and
> forth. After a read access an address will be converted to SPA and
> before a write access the programmed address is translated from an
> SPA. The decoder register access can be easily encapsulated by address
> translation and thus there are only a few places where translation is
> needed and the code must be changed. This is implemented in patch #2,
> patch #1 is a prerequisite.
> 
> Address translation is restricted to platforms that need it. As such a
> platform check is needed and a flag is introduced for this (patch #3).
> 
> For address translation the base offset must be determined for the
> memory domain. Depending on the platform there are various options for
> this. The address range in the CEDT's CFWMS entry of the CXL host
> bridge can be used to determine the decoder's base address (patch
> #4). This is enabled for AMD Zen4 platforms (patch #5).
> 
> Changelog:
> 
> v2:
>  * Fixed build error for other archs [kbot]
> 

Hi Robert,

I'm looking to test this patch series but saw you were looking at
reworking a portion of it.  Just wanted to inquire as to whether
you think I should wait for a v3 given this is a few weeks old now.

Thanks!
~Gregory

