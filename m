Return-Path: <linux-kernel+bounces-346279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A989198C240
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F5C1F26184
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A111CC148;
	Tue,  1 Oct 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nfQ1lo0/"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A71CB506
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798716; cv=none; b=RGx4bG3zt/qWq/rYlOzZd+DPJFJsvHRi2GHNb5+W3oPb2KXcmT1kx6Kli/kGeO3j9RdZaPL3nPleA5I86uKhy7nENecVYYsQ3HFtLrXi6czYzA070k4kt2xAmziUOIFVCKLaXXtEmrW8+EZZ7B+E2sMPq872Vc8B6cKIAF0gL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798716; c=relaxed/simple;
	bh=C57aOV7WqzX66B1kVXAbDB2SXf2Y+tKtl/uQWnjaZuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7bnJCIynbHvt57pko9lIDgktsPiFzepu0pFxqrrv16nYzJyTjpUe5dh1ejWnvZqzskpJFFtebVYwdRpJN7/bhSXzhumBfzLu0cSVAVPDwMtzgrb67Y9dv+sbX7pO0cEjmcWYqAKlhqxcuE6/v++rJxTHN6pIsna7an5bUWUcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nfQ1lo0/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9a30a0490so632228785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727798713; x=1728403513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqbFlSrs+wzzaAJa1pk9Jm3ecEhBzsBWk37uMTmAYtM=;
        b=nfQ1lo0/ruHHA46X3xf1ytyIaHIXyuALRm+iVA/kc3Zypue8POnj4IlF4OaPzsFL8A
         ODa97+a4er+pf/INvAQdZWLwGXKuwOZw77WkLl5LrUPvDYLPtJz1JqUSdyVY2tcxgRSD
         fOOiLDp80n+7/U42T/zJbNcxdGkkXBzk2Yj1rbA5B18KgZSrI3fFV22KhO0CcarsDRQI
         B323p6bIZrZH8VS0MkXA1x/+M0cczKl2WdSACv+wCAnvaSGmf200AoE8NMjZFLeVDZhZ
         O619VfJCnTnaPcpHAHvSucDCL0f5BEauuT/26D6YHkurMfs+/vGCsbPyEAPu0FpRUlCc
         WuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798713; x=1728403513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqbFlSrs+wzzaAJa1pk9Jm3ecEhBzsBWk37uMTmAYtM=;
        b=P+MARq3FtadyVxV1zrl7YUDJvcYP4dm/5xE8qhDQ2NVTs6e7Y0vSugfko2TwZDgIWT
         K+we89Fuw1N0ShcG8WEoLFt1YwZzj7I3Hot1pDveM4n9ylZ3dwS9ZOjrC4QTM0RQfQVA
         R3t1gIjjFWHX7dg570sT5Hza5M3PoJ+9KoncytxGhfEcmJXmz1PJnIHvW75tild020aA
         c14YAqJEQYLWmNLKDhwCP/uNp4NH8hPGfKt40khh+S4p9UCPquXwLQuSMrpe4ZGml52C
         sXVUrrUgHet+CbyZEe+m0aowg1tISyZL4Qi09ET7dK2VBj6MQWwsoI7l8PZxT1IOyNyk
         FiCA==
X-Forwarded-Encrypted: i=1; AJvYcCU1QnaHEOmoRV2DS1shvo9y59DpaWi1Q9NLclLVx8KRvLXvyTn4b8hAiqYejFK/YxPiszHgdBSjmzWlvns=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3zdj962mSIEJmJl7CMtRsij9Dz3sGLmernAPYUy1AwQviLUV
	2FUP/LhARo3ZFaRz+EtHhyHVRCSgn4E76yR7VQKh87vMqDORq+Y8zby18xJ7YWo=
X-Google-Smtp-Source: AGHT+IGvHKnNKLHBVUMCFw3MdQ+JfCrHKwohCgRxUwgHH8k6a6X/J7lGp9KRTdH3ZOdKWQEw36fpEA==
X-Received: by 2002:a05:620a:2992:b0:7ac:e15c:9d01 with SMTP id af79cd13be357-7ae62732e43mr21762785a.43.1727798712929;
        Tue, 01 Oct 2024 09:05:12 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377f0ea7sm520807185a.61.2024.10.01.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:05:12 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:04:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, dave@stgolabs.net, dave.jiang@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Message-ID: <Zvwdmy43AUELFzV4@PC2K9PVX.TheFacebook.com>
References: <20240913183241.17320-1-gourry@gourry.net>
 <66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240916101557.00007b3a@Huawei.com>
 <ZvwRjbRIrkCSjwQI@PC2K9PVX.TheFacebook.com>
 <ZvwZd5CCV2PdqSLF@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvwZd5CCV2PdqSLF@wunner.de>

On Tue, Oct 01, 2024 at 05:47:03PM +0200, Lukas Wunner wrote:
> On Tue, Oct 01, 2024 at 11:13:17AM -0400, Gregory Price wrote:
> > > > Gregory Price wrote:
> > > > > Depending on the device, sometimes firmware clears the busy flag
> > > > > later than expected.  This can cause the device to appear busy when
> > > > > calling multiple commands in quick sucession. Add a 1 second retry
> > > > > window to all doe commands that end with -EBUSY.  
> > 
> > Just following up here, it sounds like everyone is unsure of this change.
> > 
> > I can confirm that this handles the CDAT retry issue I am seeing, and that
> > the BUSY bit is set upon entry into the initial call. Only 1 or 2 retries
> > are attempted before it is cleared and returns successfully.
> > 
> > I'd explored putting the retry logic in the CDAT code that calls into here,
> > but that just seemed wrong.  Is there a suggestion or a nak here?
> > 
> > Trying to find a path forward.
> 
> The PCIe Base Spec doesn't prescribe a maximum timeout for the
> DOE BUSY bit to clear.  Thus it seems fine to me in principle
> to add a (or raise the) timeout if it turns out to be necessary
> for real-life hardware.
> 
> That said, the proposed patch has room for improvement:

Will address and resubmit, thanks!

> 
> * The patch seems to wait for DOE BUSY bit to clear *after*
>   completion.  That's odd.  The kernel waits for DOE Busy bit
>   to clear *before* sending a new request, in pci_doe_send_req().
>   My expectation would have been that you'd add a loop there which
>   polls for DOE Busy bit to clear before sending a request.
> 
>   It seems that polling is the only option as no interrupt is
>   raised on DOE Busy bit clear, per PCIe r6.2 sec 6.30.3.
>   (Please add this bit of information to the commit message.)
> 
> * The commit message should clearly specify the device(s)
>   affected by the issue (Vendor and Device ID plus name).
>   Comments such as "Depending on the device, sometimes ..."
>   are a little too vague.
> 
> * The "1 or 2 retries" bit of information you're mentioning
>   above should likewise be in the commit message.
> 
> * Please use "PCI/DOE:" as subject prefix to match previous
>   commits which touched drivers/pci/doe.c.
> 
> * Please adhere to spec language, e.g. use "DOE Busy bit"
>   instead of "busy bit" so it's unambiguous for readers
>   what you're referring to.
> 
> Thanks,
> 
> Lukas

