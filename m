Return-Path: <linux-kernel+bounces-188989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0C8CE95E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFEB1C20F88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D53BBF3;
	Fri, 24 May 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="gq4HrcxL"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B53B2A1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574385; cv=none; b=VP3Fcj3Ue7w36Cpd9aP9mHCDe3QEnQF6nWHVSbSwKtEQdy4F3u3QqGoUToQjOCipwhCuudPCIJ7DbpqQ8oFxQ3yYxVxICl9qg8CdDaD/hrvOIvzVUxtTTJp1kwaGFd1j1S8lsIaVTUhevxNAzGuHz5VmOCXsEE1fxxujV2baPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574385; c=relaxed/simple;
	bh=6YjW4gPlBJUm+qGoxCi73uLtqlLtfdqeWevPkQB22lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciaF6qTIdBU7XWgKMdNwuSAVdC/jL9t+sh8hrSbTVw84J2Ht24KBFz16jsecT0FxOgetRa6NjkDryVf833N1C97z9qtFXrOXFdYdgqBttbhULfuhIzwoNTUxvl4NCmTs0F6nkx2sxu130oW7jJt2gTaYYQjKryGWmvOVZw2stZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=fail smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=gq4HrcxL; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e73359b979so57679011fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1716574381; x=1717179181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAb4E/ylNY4nYQpT5wwWxISxDYgnB6L1bhxHr5GF4gY=;
        b=gq4HrcxLbKcxY4xGNxp/Wu5SbfLAYE356WysmVfak2yJxK1BspdOUQ+nAqg5tB0D4P
         iv7L7bBRRealMxEwq53JkLg020P8VpKLo5M/G6x4Jzkr6uHMXWaOIwAPeF5KN0wtb7Ok
         xvKyMrdMt6htLQmd5Axqw7miYa2HWikILGcugvB/K4k9T981yrb0cch5FM7k1csFZpgQ
         +tOvDhJfoiyZCUq0Bm+og2RKbo6U9AWXQUwAfVs494bWacPorBIcQwmIVSzapJvG/amB
         SjFNMzsh3ssKOvtk3udQo1MCyRIGkfXO778MlMxr1zwYTS5Fw7euwy45Xq7lGH8xQdMJ
         GuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716574381; x=1717179181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAb4E/ylNY4nYQpT5wwWxISxDYgnB6L1bhxHr5GF4gY=;
        b=oFxEt2QsWf3Y0J49bq1bbEDl4H5LNNSsHNZiv7ypzFC72eyO3ceyRkycMqyCqTTWfk
         H70oZBIhtYd80YYuUo6p4AuXvwBAvqRtEdw6e32ZfH5qKzsik8aebCk6j+t9YPl2e+H7
         uGw7+Jv4h03o2pwStRcYlZdZ81lu2Fgyat52L+S31pPm01WfoDdkx6s6DJuCR38lHJ5V
         2VZBmUO+pIYaFYsgVDlpRr0Al1KjiXcomIquWV+Y4ew/1zsTHI3Cw6Bq0BTeSfQgYwxC
         1m44kwESwUta4/m4jMNfzI61mUuWDjRcUR/zQgrV0ZA7maM53a0vJzofQ+KsChRfM6To
         EO8w==
X-Forwarded-Encrypted: i=1; AJvYcCUjlaWXo6u4jSLosXhg/eWCN4plYruJrEMzfbNSxGlLeopuZGwumMp6MjQhWIJZB8m7hnyEVMBtW1moiLvMFFHlBECTe42d5phi29Av
X-Gm-Message-State: AOJu0Yx3BwZiXvPaa1ogH4LVtFnhKZLvkGQwgdUabKdxUXblBO+5Ihk5
	Vh33dSWux2aVRoXkrXi0XMSH35qkmibWlEtafXXXUPLGBjyLln216YdZNQd35Z4=
X-Google-Smtp-Source: AGHT+IGquvASHix50Y6m7trq1iJckrrLIxXAt0DDnEtvLQfEYyKMu5W3KCNL43t4St1VdKAYYOiaXA==
X-Received: by 2002:a05:651c:10a5:b0:2e7:f9a4:ee07 with SMTP id 38308e7fff4ca-2e95b280f73mr19336131fa.53.1716574380842;
        Fri, 24 May 2024 11:13:00 -0700 (PDT)
Received: from minibuilder (c83-249-74-52.bredband.tele2.se. [83.249.74.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdcd234sm2874081fa.99.2024.05.24.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:13:00 -0700 (PDT)
Date: Fri, 24 May 2024 20:12:58 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, Pier.Beruto@onsemi.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <ZlDYqoMNkb-ZieSZ@minibuilder>
References: <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder>
 <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
 <ZkUtx1Pj6alRhYd6@minibuilder>
 <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>

> >>>> Is it doing this in an endless cycle?
> >>>
> >>> Exactly, so what I'm seeing is when the driver livelocks the macphy is
> >>> periodically pulling the irq pin low, the driver clears the interrupt
> >>> and repeat.
> >> If I understand correctly, you are keep on getting interrupt without
> >> indicating anything in the footer?. Are you using LAN8650 Rev.B0 or B1?.
> >> If it is B0 then can you try with Rev.B1 once?
> >>

After a considerable ammount of headscratching it seems that disabling collision
detection on the macphy is the only way of getting it stable.
When PLCA is enabled it's expected that CD causes problems, when running
in CSMA/CD mode it was unexpected (for me at least).

Disabling collision detection was discussed here 
https://lore.kernel.org/netdev/20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se/
in a patchset that I haven't gotten around to testing through properly
and fixing up, but now it's definetly a priority.

Rev.b0 and b1 gives similar results in this domain, though I'm getting
lower throughput and it's easier/faster to get the internal error state
on rev.b1.

When CD is disabled both chip revs seems stable in all of my testing.

> > 
> > I'll check the footer content, thanks for the tip!
> > 
> > All testing has bee done with Rev.B0, we've located a set of B1 chips.
> > So we'll get on resoldering and rerunning the test scenario.
> Thanks for the consideration. But be informed that the internal PHY 
> initial settings are updated for the Rev.B1. But the one from the 
> mainline still supports for Rev.B0. So that microchip_t1s.c to be 
> updated to support Rev.B1.

I posted a suggestion for how to bringup rev.b1
https://lore.kernel.org/netdev/20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se/

I should have prefaced the cover letter with 'ugly hacks ahead'.

> 
> Also I am in talk with our design team that whether the updated initial 
> settings for B1 are also applicable for B0. If so, then we will have 
> only one updated initial setting which supports both B0 and B1.

Any update on this?

I will submit a new revision of the lan8670 revc + disable collision
detection pathset where CD is disabled regardless of operating mode.

R

