Return-Path: <linux-kernel+bounces-269347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8679431D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69281B24EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528AF1B3F04;
	Wed, 31 Jul 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jPWOReDo"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6B1B3748
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435314; cv=none; b=om1wdU4HPdAisRCAF8j4ag1Qf83mScS8svBDj8HNynUDvRBgqZ+FXd/N/Hzf/2r8gjJ6XgQq+RX0sR1Mti5ZSi1RV9lEM3ILTatETKLObwXApWagdr7NyKqjRdN/M/0Rd9vDa/EpOgYrhifiyGXwFD5o2V7aNydyIp0SwQoH2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435314; c=relaxed/simple;
	bh=r4t/RSO2hnjEe6G0UZz+W/1GYVcTqgB0/PT6VIY5r9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCWTV9D2mQYAm1KBYAtSe7fzoirZMndyS5XO+ZO5j3ofOQPvm1/35FeJvHwN4MBNm+GtT8goEqnszRxx+5UJcYhJTZL4IHbYJ+SXTltdAaDdIGiIchO2n4hsoodyG5RMVeIwd1jNFmTuS1HgtfobQZLT8X++r5Z2NsCTbgfs/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jPWOReDo; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b7aed340daso34782116d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722435312; x=1723040112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZoGyjJaWEwHv/KfoCIN2q0gBEBBi+yquexZmDv5wAQ=;
        b=jPWOReDofvGe9fFrLP9YyShxbJFutSpldxfOK/lc83oI+PG114J/apwW/o5BKp2BHu
         XIK1uSQFinqafLqbjZ8p5hHYDiXzstGFzRyZodOtbQ+zXegeQPFCpFJVmf7UILT6GbBq
         x9Cz5p3XVcKRx8F7ZBRGB3X3znna0wLiFiM46MumeX8hsCFqb0ja7CJXpSWrEYpX8qOw
         LKXErYzR9OL47IeAMh7O4vhCN9QHtc3EVXplsuFaUGRIv4rV7fey8aUALT0/0VvItykK
         PJ80qjb+mX6R4aQTL5JuG/tIFsSnzYLW5XG0sNeloVZhBT4b5B8Aa+IL9+sz9B3wGeWS
         dhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435312; x=1723040112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZoGyjJaWEwHv/KfoCIN2q0gBEBBi+yquexZmDv5wAQ=;
        b=PceFrx7RR94+8YUI9Qn50xnDiAOchAGRlWn9+bFeeusY4ZrlLsc5PxpvA7M41DsBZR
         LAFzEerPq8BjcgwkcJkvw60fZaVXe/29A6lA8f1IKCWtvjCgzFQZaicpoclxe4Kh8U7l
         8yiq9Q4i0ddRXgalDnaPnk2T4YYNuu/Wjo4uYKzJ3O7kUVY8O4ttlI/flow6yufJv3Z4
         dOpxMRB0EStLFxHK2dLbFF7b2qFXlqJihrR9O4JtpJaEzkNiJG8YLMt9D/Uyu63aJkud
         IRXQUoIgZKbHt9bN3ExVh0kR0q+f3RFosOsFeyStOip8jfRjsE7tLBkV4ySuG8aC91cc
         BtYg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVzWkRWW7TcnpLGV//eXnQ65GiqKadBW0+YhI+A86NO6FA0+NGue5sj8lmiBYvQvyM7Tb+uqwiY5BwmDSpLGArynHATfd/JNW42BI
X-Gm-Message-State: AOJu0YxUpOZZWkFzSCyvxlJcFY68k5G+S0Ok54nD5R8BKVSzFSMgQShK
	6mUYak68pKwWYHqRfYrLpULi/H/d46ZoMBIm/s7FSETjELUBfyRHHd2kGqdj9sw=
X-Google-Smtp-Source: AGHT+IFNREONZgm7zLR0cLrVINRHZAuZJz57NqpdO1aQ2JjmTspGlBRsHUwaFMQ8H7vcv4eyfHiRWw==
X-Received: by 2002:ad4:5c6f:0:b0:6b5:d9ef:d56d with SMTP id 6a1803df08f44-6bb559c3461mr182732716d6.21.1722435311609;
        Wed, 31 Jul 2024 07:15:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa950a3sm74461836d6.90.2024.07.31.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:15:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:26:06 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <ZqlMXuBxi2oShb-u@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
 <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com>
 <87cymupd7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqlF0hn6Jh4Ybl-p@PC2K9PVX.TheFacebook.com>
 <878qxiowmy.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qxiowmy.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Wed, Jul 31, 2024 at 03:20:37PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> >
> > In this case, the system is configured explicitly so that kmem does not
> > manage it. In fact, some systems still cannot be managed with
> > EFI_MEMORY_SP due to hpa!=spa issues that the driver cannot manage.
> 
> Sorry, I don't understand.  IIUC, kmem.c can manage almost any memory
> range via drivers/dax/hmem.  Please check
> 
> drivers/dax/hmem/device.c
> drivers/dax/hmem/hmem.c
> 
> Could you elaborate why kmem.c doesn't work for some memory range?
> 

Sorry I misunderstood, I thought you meant the cxl+kmem/hmem subsystem
interaction and handing configuration of the CXL device over to the
kernel.

The boot parameter is not likely to be a solution for us but I will look
at it.

> > But I think a feature that worked in 5.x should work in 6.x, and right
> > now the change in node placement breaks hardware that worked with 5.x
> > which happened to have broken or missing HMAT.

