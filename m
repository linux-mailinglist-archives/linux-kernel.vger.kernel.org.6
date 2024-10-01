Return-Path: <linux-kernel+bounces-346220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B898C14E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4406C1C23E36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4A1C9DF0;
	Tue,  1 Oct 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lqxU2aYj"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADA1C5782
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795629; cv=none; b=pmHgoYHtZ95nCxvS6dKrtZ3+GxpmNA8JRimbN2K00IcUnSvsNOibpf1bAxsLnXOrIKJmVYz+fpTHm1DZK1b56K/zs2DajS9y4QHldlZ2A8Uh92pfVtykyrpFGg6iD7UAVN8dn3qn9WN8J6eCSQmRa2914sv4vEdOatQuLvEENQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795629; c=relaxed/simple;
	bh=klvPYQvceMS7e+u435x6bBIuMEfX1hIM61WYALoMLVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Iw5k6ZX77suvn2ziSSLp/6A/CijEhR1MxQC3+6U5iW6uQ2w6r4IvaCr3HKJ+Vulk7ryXNoClhsLUYHBuw9Ua86eqI33HFoPcx8a1fFVF+LFOdhsIRvzKKKgLybJniVIJ3hjvZes+0njkyk9M5jPZE65fDcz/3huQufX6rXgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lqxU2aYj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4583068795eso49857851cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727795627; x=1728400427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wH/D8AAkmGXfodYMfAwyRCswFUR0f/XeaeOOtQHZJR8=;
        b=lqxU2aYj4EuR1YXA/5MxyC6wjP+tycpcDYcs7S2AnU3SP4zzHkb52d+ev+Yacmw2kv
         HZEvfGahmwr1+ogSw/O2qFH+k3iWS/q9WExvWqNP5/SFbcp6ts7uIGuw4jBtops6TWRs
         vMwo2RQs51vnIBekP2oLnee0EJduOE+icmM/A5xqsTyxgxMtSaFjDjt5EU4kP77o1ZN4
         bOFWzgWlLXBRWQVUIy6y022CYyPfNjcaNgjEy/EjeS1aLY9tfenC1tEP3/Y/4eXQlt5t
         RNxrRTrJNpu7PxekFG54e2+od3pDFcGMXP0rOepypD/xfJpiPluGFY4/HKk2LJAkVgVU
         gFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795627; x=1728400427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH/D8AAkmGXfodYMfAwyRCswFUR0f/XeaeOOtQHZJR8=;
        b=Wc1RNVnuWWAD9+40jlY1fFnuhS+wS5ygacysRogvb15UPkzGTC7OiN+u5r7nxB05un
         sK3nzD5y0C9FI0puWB+DVpoC2fIg16maG/DSa44ubWmnE02cITPC/u3G+jAJtJ/l8lsB
         ifMRRMpIc6Fdj3jP7SA+izykIGQG/jTdioAeu2ERkPu2sgKWosaLEhJLZEhYpuZWA1/z
         q9Qa+Kj7y08CzoDKMQrf6G1YSJ7LDiMLbKXy4Oy82tvhV1iQve8qsB7ugcF6GI3Dhycj
         0W+kDpbwfUm/E7VDdungi6Y7qCGmool+OjHbSmR+13DkjQbaTdzNTsnYv5piKcMzk70Y
         OGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaxtrro+GMi/YMwAX0mgeMZ40cx3Vs81s2/xvyVEQoJovvzxvECms1CDVJwBWzOoFIcwRWK/Jqx9WfG/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Qjl3m/7mdTySgcX6affoT9FSvAeFhJw4PjjJutBHnTbnfjDt
	khB8ReZgUdvfbmv01zcuyT6wBqpkA5ClmcoAUQ4E5gEZlPvWz7v9dWDFNr0g4KQ=
X-Google-Smtp-Source: AGHT+IEgx5X0C3Z/TUBNZmAt37mnOUy5vuCV8HD5LocgLsm01ba949ibJenHp7iZk6fvm6cIrWafiA==
X-Received: by 2002:a05:622a:1a02:b0:458:42aa:9853 with SMTP id d75a77b69052e-45c9f227955mr260457751cf.23.1727795626732;
        Tue, 01 Oct 2024 08:13:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm46664201cf.82.2024.10.01.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:13:46 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:13:17 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, dave@stgolabs.net, dave.jiang@intel.com,
	vishal.l.verma@intel.com, lukas@wunner.de
Subject: Re: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Message-ID: <ZvwRjbRIrkCSjwQI@PC2K9PVX.TheFacebook.com>
References: <20240913183241.17320-1-gourry@gourry.net>
 <66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240916101557.00007b3a@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916101557.00007b3a@Huawei.com>

On Mon, Sep 16, 2024 at 10:15:57AM +0100, Jonathan Cameron wrote:
> On Fri, 13 Sep 2024 22:32:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > [ add linux-pci and Lukas ]
> > 
> > Gregory Price wrote:
> > > Depending on the device, sometimes firmware clears the busy flag
> > > later than expected.  This can cause the device to appear busy when
> > > calling multiple commands in quick sucession. Add a 1 second retry
> > > window to all doe commands that end with -EBUSY.  
> > 
> > I would have expected this to be handled as part of finishing off
> > pci_doe_recv_resp() not retrying on a new submission.
> > 
> > It also occurs to me that instead of warning "another entity is sending conflicting
> > requests" message, the doe core should just ensure that it is the only
> > agent using the mailbox. Something like hold the PCI config lock over
> > DOE transactions. Then it will remove ambiguity of "conflicting agent"
> > vs "device is slow to clear BUSY".
> > 
> 
> I believe we put that dance in to not fail too horribly
> if a firmware was messing with the DOE behind our backs rather than
> another OS level actor was messing with it.
> 
> We wouldn't expect firmware to be using a DOE that Linux wants, but
> the problem is the discovery protocol which the firmware might run
> to find the DOE it does want to use.
> 
> My memory might be wrong though as this was a while back.
> 
> Jonathan

Just following up here, it sounds like everyone is unsure of this change.

I can confirm that this handles the CDAT retry issue I am seeing, and that
the BUSY bit is set upon entry into the initial call. Only 1 or 2 retries
are attempted before it is cleared and returns successfully.

I'd explored putting the retry logic in the CDAT code that calls into here,
but that just seemed wrong.  Is there a suggestion or a nak here?

Trying to find a path forward.

~Gregory

