Return-Path: <linux-kernel+bounces-346230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F698C178
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B431F24501
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1811C9B76;
	Tue,  1 Oct 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j1xXWvFH"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BD1C68AC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796043; cv=none; b=oNW5jYljNt2cTe7NQ51i3mwZSXublp5mF47WADv64lCPIE/ePP818EkNRvM7OFw8CgUM5VDxjrITz9n9nVz2OHb739t850m3QrUKzhg/Jb3huOcVfmgRe+CaG20wriFEPFlF6pRQu358pB/G11Ah2FcLMg46mI1DDb6NrIbP97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796043; c=relaxed/simple;
	bh=ZU+Z/WlZcaTh47xXgjL+D5zyETNn+avD/Kj0arLV7NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfZ4QDVwkO1vTJGCARLKhMae1gxEVDUtnNHgdW43RAsbDMooblEhQBv/XbfG0dtZ2FnUXdsCDFLsFGlFXiN6ajjGlon8gMXPB8ZydVlYsG1Sw4uLP80waA3zwCRTOf2yddGsmMgmT9FZoi3/A/LdVp4qfZVX7Vi/mhHRpGFYtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j1xXWvFH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb4c013b78so28343396d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727796041; x=1728400841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=os7ciG24pZLduUL01Uf3DEB98OBQt4RnR5S6qFgUTGk=;
        b=j1xXWvFHdB9HepYC6ePIdZAd2TU2cL1uUGr2LjU3Jc/qZa3GIjsN5vjiHdCiwQax5G
         XzbB07Yc44ubAAIaMtiVQamly1rhZUAinjnqj1/mWKjDwdvhJsdEaSFKquZlZ4s4J5kn
         HTp7CddHuzFILkiWQDcPBKysfoKJv5zXg+VBrcOwwvgHNM+N2tTANtrntG3ESKRD48ZG
         azx/V+sDIOSLa5jYcqaoQJge3B2qEUIYhsy3//dGzDI4jQL5op8cuiQHX5uQmiBfqWI5
         C1yIgYOuxPpmt+bIl0EknVXKdHrOqP8Sb6SxZ/BDRWLQ4qc7gJXzODtCFBZnKzgL0zfa
         Xi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796041; x=1728400841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7ciG24pZLduUL01Uf3DEB98OBQt4RnR5S6qFgUTGk=;
        b=oFx9uYBhgDKO8JYTFBegCXRGi2qelp25asYxofyX+WapKJfSIj/TjQ9ZCX0dwgCXul
         izR5xzDAlXiLJ1BgfAjo8imjf0fACkU38AiOTsB8B4/j75bHYIl2mfBPK9a9HIq/F7Xf
         0DkylVJ+oE0mzIRkeW2KuC/bY3lK0P42DsFyVZFdQaRApluTnVGtOKC2459jaalZCfZu
         AwjJ40YiaTIwu2v1IIxl1phWP8Tl/M216WwCwSuWFZ+lDhh8Dik67igy3y544IdUxSNg
         DPvMQOWzz+RYrZ6/4uptMNZvyojN80NycJ1gQpkcq7Le7H33C1n+Lb/X5rwmrwm+/aVh
         N5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUDbUbaJcO6Z/9CYcCZccrSYgzKQjqswi2IXt1yenzIL9qisMiS0Kg5ZGta9DGC1QWOEzZ49Zkfk+8fKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5Q6S1VTbJNiWF8Sw+XKAcnHaahaA1VAOBxmX6enHuswFOlSl
	1EJgLDFsD/xAH+yakKgJAwEB7dvlTD+9gDMrBuTjsSr++PzuVny8eluHrVZSZYA=
X-Google-Smtp-Source: AGHT+IEfkdwBIWEZzpIx/ashe6rDUHbFbG5kJrCq2hePig1GgZbqm2JF4/GnUYx4iA8UiMuXCbaUtQ==
X-Received: by 2002:a05:6214:3207:b0:6c5:7446:4fdf with SMTP id 6a1803df08f44-6cb3b5e283dmr258721556d6.24.1727796040646;
        Tue, 01 Oct 2024 08:20:40 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66b5a8sm50944436d6.79.2024.10.01.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:20:39 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:20:11 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	terry.bowman@amd.com
Subject: Re: [PATCH] cxl/core/port: defer probe when memdev fails to find
 correct port
Message-ID: <ZvwTKxTc9yDypmkG@PC2K9PVX.TheFacebook.com>
References: <20240913183234.17302-1-gourry@gourry.net>
 <66e511eff0c0d_ae212945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZurAiwt7t2WWVrJM@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurAiwt7t2WWVrJM@PC2K9PVX.TheFacebook.com>

On Wed, Sep 18, 2024 at 01:59:07PM +0200, Gregory Price wrote:
> On Fri, Sep 13, 2024 at 09:32:48PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > Depending on device/hierarchy readiness, it can be possible for the
> > > async probe process to attempt to register an endpoint before the
> > > entire port hierarchy is ready.  This currently fails with -ENXIO.
> > > 
> > > Return -EPROBE_DEFER to try again later automatically (which is
> > > what the local comments already say we should do anyway).
> > 
> > I want to make sure this is not papering over some other issue. Can you
> > post the final topology when this works (cxl list -BPET)? My working
> > theory is that you have 2 devices that share an intermediate port.
> > Otherwise, I am having a hard time understanding why the
> > cxl_bus_rescan() in cxl_acpi_probe() does not obviate the explicit
> > EPROBE_DEFER.
> >

just reporting back with a fully functional layout - they do not appear to
share an intermediate port, unless you consider the root a shared port.

I see your concern about this papering over another issue, but it's not
clear what to look for or how to look for it at this point.

For what it's worth - another group observed the same issue with different
hardware and produced the same patch.

    "ports:root0":[
      {
        "port":"port1",
        "host":"pci0000:e0",
        "depth":1,
        "decoders_committed":1,
        "nr_dports":4,
        "dports":[
          {
            "dport":"0000:e0:07.2",
            "alias":"device:16",
            "id":114
          },
          {
            "dport":"0000:e0:01.1",
            "alias":"device:02",
            "id":0
          },
          {
            "dport":"0000:e0:01.3",
            "alias":"device:05",
            "id":2
          },
          {
            "dport":"0000:e0:07.1",
            "alias":"device:0d",
            "id":113
          }
        ],
        "endpoints:port1":[
          {
            "endpoint":"endpoint5",
            "host":"mem0",
            "parent_dport":"0000:e0:01.1",
            "depth":2,
            "decoders_committed":1
          }
        ]
      },
      {
        "port":"port3",
        "host":"pci0000:c0",
        "depth":1,
        "decoders_committed":2,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:c0:01.1",
            "alias":"device:c3",
            "id":0
          }
        ],
        "endpoints:port3":[
          {
            "endpoint":"endpoint6",
            "host":"mem1",
            "parent_dport":"0000:c0:01.1",
            "depth":2,
            "decoders_committed":2
          }
        ]
      },
    ]

> > So, devA is dependendent on devB to create a common port, but devA loses
> > that race after cxl_bus_rescan() has already run. Then EBPROBE_DEFER is
> > the right answer to trigger devA to try again.

