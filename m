Return-Path: <linux-kernel+bounces-337606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A2984C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF80281820
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5513B792;
	Tue, 24 Sep 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdcwPh0C"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A01386C6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210649; cv=none; b=drv0hQXowZY+4k95OVv26mjY8x0Ovvx2aVpMHNXAGf/PICh3bqGr7eEowUMZec0Mp8an9OKwz2FP+3STQrmz6ykeSDd2x+6rrfXJzapb03+xm/v4WGby4zHl1q1/7x0ptzQ7RumUrEoFr20GJ/uznAqthB38PmAavCDgwP338hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210649; c=relaxed/simple;
	bh=VGq1aDROzzermo/waLvpMambgOJT3M9KdClrLSQxB+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XARe9kIa+E7k10gj1bX9DReLEvLcPA8wJPRHtQEPgv7qs2wfQfnx5Haq3KT/TUlwsyXroOTdLS1tlo5KqcZA3LITmhR5T55QL+8ZgXa9OrwZXYY5LEe+jx5RoomjMidtqzgLjfwCyYZdRh6bXgYDUWTZf+s0oIqGs+v09OtbfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdcwPh0C; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365392cfafso6233239e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727210645; x=1727815445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2faGZGNjV/Ol4dCxT3b6jGEV1WM/yda0rsC63QluSdQ=;
        b=LdcwPh0CozX5IU9H+b5lnR4u7DclKxWyvrgB7KeSd+FXH0QLBLHw6WSGKvWP+Xujmh
         gS3UlUYbX6ZvsyJBShqPyOzvLKZuMhyxfA9A+BTeIm/Hnnam/N1AqxwK8/G4tVVdtAmO
         AHHv7u8jcDz5rzNVc8jrqdmRoqEWZAzJx3/6I5l581b89EaSJoiTsuafvsxWq2hy4ujc
         fPsibTeAWISFl4sU5VRRtYQAReLOrPFdx+Izl8hBh56ZfXzVXAHCKWsMD3MQ871kbUds
         9hnBTE9tvTZHeOFC7XwDDW9M0BHT84h2w316id3NL2nYHC74InNm3uxMCljR89HQ12gt
         cBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727210645; x=1727815445;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2faGZGNjV/Ol4dCxT3b6jGEV1WM/yda0rsC63QluSdQ=;
        b=Tpsl5ioE7W1rj0K6BgW5gn5F4SMFC0Fa3/iNkc/tCk7Ry+umVQxBwUS79imL0OCxXa
         /j6frBlePgUiXUlDNEOC/7C8s9bEsl/fGPTrdCC19VWvzBiulIKoLSCaB9/DQHblZk5R
         u2SJ92JMo6RRzXN4Tk3HS4UBzgtfNJao2kWIIhhYfSj2fV+QRfi2opG4Dzrgm3YmCaQ3
         48mr5uYg+CRZBhshJsWbc6pH78aXRixmuhgLALw4Ewjt5AtNmhRb2tGUUjETB1nY9bFm
         DdNl5Ngh6/cavPozcVxDKYiNPvWbMc9EAj5amjgw5VQJBdjqnJtiiqAW6KwcRHxrsWHv
         Z5BA==
X-Forwarded-Encrypted: i=1; AJvYcCWYSwJhLbRooOuIv3Fx3RAk0YvaomPp58ukyLP10/dT2l4aLcISdiMUDTX+DZ1V7sNui0KflAka2Te2gbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYdw5JSf2ZXHals4z1d5L43eDVRaghF/vKb1KkTPc7I7TKgWg
	GUeQgNFDJYsqUspgY2N1d1eLC09BwUwkSAA8myRadHi089LY5E4P
X-Google-Smtp-Source: AGHT+IE66lH2TWaoR0Wn1kL/JkKwaihDSp/X6Fc9tJ9Phu/UUJM1E1L/IMzsW1415EulINyviGdhPQ==
X-Received: by 2002:a05:6512:6cf:b0:52e:f77b:bb58 with SMTP id 2adb3069b0e04-53877538ce4mr178528e87.36.1727210644749;
        Tue, 24 Sep 2024 13:44:04 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864da87sm327296e87.268.2024.09.24.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 13:44:04 -0700 (PDT)
Date: Tue, 24 Sep 2024 23:44:02 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <ZvMkkhyJrohaajuk@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <ZvHUn1Q2R8FumZ20@skv.local>
 <2024092440-embattled-magical-64bc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024092440-embattled-magical-64bc@gregkh>

Hi,

On 24-09-24 11:23, Greg Kroah-Hartman wrote:
> On Mon, Sep 23, 2024 at 11:50:39PM +0300, Andrey Skvortsov wrote:
> > Hi Stuart,
> > 
> > On 24-08-22 15:28, Stuart Hayes wrote:
> > > Add code to allow asynchronous shutdown of devices, ensuring that each
> > > device is shut down before its parents & suppliers.
> > > 
> > > Only devices with drivers that have async_shutdown_enable enabled will be
> > > shut down asynchronously.
> > > 
> > > This can dramatically reduce system shutdown/reboot time on systems that
> > > have multiple devices that take many seconds to shut down (like certain
> > > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > > without this patch to 55 seconds with the patch.
> > > 
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > ---
> > >  drivers/base/base.h           |  4 +++
> > >  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
> > >  include/linux/device/driver.h |  2 ++
> > >  3 files changed, 59 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > index 0b53593372d7..aa5a2bd3f2b8 100644
> > > --- a/drivers/base/base.h
> > > +++ b/drivers/base/base.h
> > > @@ -10,6 +10,7 @@
> > >   * shared outside of the drivers/base/ directory.
> > 
> > This change landed in linux-next and I have problem with shutdown on
> > ARM Allwinner A64 device. Device usually hangs at shutdown.
> > git bisect pointed to "driver core: shut down devices asynchronously"
> > as a first bad commit.
> > 
> > I've tried to debug the problem and this is what I see:
> > 
> > 1) device 'mmc_host mmc0' processed in device_shutdown. For this device
> > async_schedule_domain is called (cookie 264, for example).
> > 
> > 2) after that 'mmcblk mmc0:aaaa' is processed. For this device
> > async_schedule_domain is called (cookie 296, for example).
> > 
> > 3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
> > parent->p->shutdown_after is updated from 263 to 296.
> > 
> > 4) After sometime shutdown_one_device_async is called for 264
> > (mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
> > code calls first async_synchronize_cookie_domain for 297.
> > 
> > 264 can't finish, because it waits for 297. shutdown process can't continue.
> > 
> > The problem is always with a MMC host controller.
> 
> If you take the patch here:
> 	https://lore.kernel.org/r/20240919043143.1194950-1-stuart.w.hayes@gmail.com
> does it solve the problem?

Unfortunately not. I've applied the patch to next-20240920 and tested
latest next-20240924 with patch integrated already. In both cases
shutdown hangs.

-- 
Best regards,
Andrey Skvortsov

