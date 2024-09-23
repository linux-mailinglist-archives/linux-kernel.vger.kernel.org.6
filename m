Return-Path: <linux-kernel+bounces-332624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80497BC09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69A01F22FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C72189F57;
	Wed, 18 Sep 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZLtE1g1t"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC46189B9B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661589; cv=none; b=owqkEFxRIOlu5uqDQy2cni1s5Lq+p/n+MCu19j47DGEQtcBtLDh8/O54MP8pgnI1QU7pe3F8+RyXrqWRes8IGjUs+lz9+qxh2sPoaILpLM1TpTGV9zYcVMxa544jslhisV7EpbevRuJiAQ+4gqo3uQQ2PmymnO5uUeKwP8PvZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661589; c=relaxed/simple;
	bh=SPwOWgolRBzcq70Z7OTJv1xyKVRYxY9zSb9rNNXBZJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8rHih1zl6FtF6l6qSDMrfIaNnJxbNFKYPobqrjPBPzB7jUakTwTh7qD0lxcDTOzS3/29eP5GHe/sUxGOEz4cb/EFBhMCX87gbafazKXxQ/DWZ8aoPmdT/JSkgdJkNB9k3AqFL0e4MBCGCaIYt+f8zzWYXfHyCJS3mcZ5Rv0gG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZLtE1g1t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso7504067a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726661586; x=1727266386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbrtlVBBvFqgMH7BAoG+wyciNSBCfqOZjcwermuBKzo=;
        b=ZLtE1g1tvUH2jbe3L5OrZfpWshx0uty2tyrrPWcCs0AW/bLFOFSeuyctRswI6PeAEX
         yWik6wDfXQl83nPyBzQXXCJr9Vu80NGmFgydz4q0HgaX373zG94jZ0boMZZT5HrENGlX
         8RDOORfQnuObV4//HDh2V3gSpaNDdbLEAueqWllyFrRBRTBYTUgsX2qWGK8cX4amXHps
         Rcub2T8u84Mg7+vjicqVozOEtrycfusplRGhUbi8PaFPudjcydhQ7C7ErY0owiLIxizX
         UnZdvt/RHyZBmV3ceu2LtCpslaDDP2NV42MAxvAWWwXpBwqyEX0idqvIYhJqAFzC8TFB
         4rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726661586; x=1727266386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbrtlVBBvFqgMH7BAoG+wyciNSBCfqOZjcwermuBKzo=;
        b=rdEiubjEEPeEAGJK1dOXlQt/HCV8OHk+6nGAlHIQm9RhUT1U6kSOGvDxfK1NLpN8vT
         4Lzy01gZ1ob/RodipYj5fR0Be13ncLDlCvX/2tgA993OenN7fjLWhlrqJ4kxc9z0gNJA
         ydQCdk6912TDH8CBPMk3inNiANd3kgp6dwpDBIPFoQHxU8SGRgKZx+AAGUW2L3SP+5GG
         Fk1E+AUKooqjKHY559xlRukcpl0usHOFdqc9p0B1uMsejJf6kDV2Q/POIcvtbhHax6Yf
         DPTDVO2GGAvbrFxFsHCDoO9ricezsXnqjDLlcMPUnNXOX727HpJ94/yTB5M4LT8sfgy7
         nKAw==
X-Forwarded-Encrypted: i=1; AJvYcCUtCZ6OWIGDcIh3EWxyy1LncwYxTzjaH0tzgPVqL/xpzuSSjobBKBehtUguSxmpeWD4wvJ9dlBf6rHFU8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOwsHE0v4LCnGjftytdBS6wC+itwtg33wxcfj8nkE6UEdIKzc
	LAac3Jurjxt2mlYtqehZRaxhlK0wXZJT3FkyiG53g45QoyW/XIAy+GYfyxD5dDs=
X-Google-Smtp-Source: AGHT+IHREEasO0BbaPIldkkJKabZf8X6ahWCVuU45HlXha/oDliA8XdsYZJPvOjAamhhlsJHnCsvLA==
X-Received: by 2002:a50:c949:0:b0:5c3:1089:ff3c with SMTP id 4fb4d7f45d1cf-5c41e1b590fmr10516049a12.35.1726661585838;
        Wed, 18 Sep 2024 05:13:05 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb495b3sm4794844a12.20.2024.09.18.05.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:13:04 -0700 (PDT)
Date: Wed, 18 Sep 2024 13:59:07 +0200
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	terry.bowman@amd.com
Subject: Re: [PATCH] cxl/core/port: defer probe when memdev fails to find
 correct port
Message-ID: <ZurAiwt7t2WWVrJM@PC2K9PVX.TheFacebook.com>
References: <20240913183234.17302-1-gourry@gourry.net>
 <66e511eff0c0d_ae212945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e511eff0c0d_ae212945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Sep 13, 2024 at 09:32:48PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > Depending on device/hierarchy readiness, it can be possible for the
> > async probe process to attempt to register an endpoint before the
> > entire port hierarchy is ready.  This currently fails with -ENXIO.
> > 
> > Return -EPROBE_DEFER to try again later automatically (which is
> > what the local comments already say we should do anyway).
> 
> I want to make sure this is not papering over some other issue. Can you
> post the final topology when this works (cxl list -BPET)? My working
> theory is that you have 2 devices that share an intermediate port.
> Otherwise, I am having a hard time understanding why the
> cxl_bus_rescan() in cxl_acpi_probe() does not obviate the explicit
> EPROBE_DEFER.
>

Sorry for the delay

[
  {
    "bus":"root0",
    "provider":"ACPI.CXL",
    "nr_dports":4,
    "dports":[
      {
        "dport":"pci0000:e0",
        "alias":"ACPI0016:00",
        "id":7
      },
      {
        "dport":"pci0000:00",
        "alias":"ACPI0016:01",
        "id":0
      },
      {
        "dport":"pci0000:c0",
        "alias":"ACPI0016:02",
        "id":6
      },
      {
        "dport":"pci0000:20",
        "alias":"ACPI0016:03",
        "id":1
      }
    ],
    "ports:root0":[
      {
        "port":"port1",
        "host":"pci0000:e0",
        "depth":1,
        "decoders_committed":2,
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
            "decoders_committed":1
          }
        ]
      },
      {
        "port":"port2",
        "host":"pci0000:00",
        "depth":1,
        "decoders_committed":0,
        "nr_dports":2,
        "dports":[
          {
            "dport":"0000:00:01.3",
            "alias":"device:55",
            "id":2
          },
          {
            "dport":"0000:00:07.1",
            "alias":"device:5d",
            "id":113
          }
        ]
      },
      {
        "port":"port4",
        "host":"pci0000:20",
        "depth":1,
        "decoders_committed":0,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:20:01.1",
            "alias":"device:d0",
            "id":0
          }
        ]
      }
    ]
  }
]
 
> So, devA is dependendent on devB to create a common port, but devA loses
> that race after cxl_bus_rescan() has already run. Then EBPROBE_DEFER is
> the right answer to trigger devA to try again.

