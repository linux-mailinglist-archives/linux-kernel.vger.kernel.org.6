Return-Path: <linux-kernel+bounces-263571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE693D7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EA1C2303B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EE517B42F;
	Fri, 26 Jul 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rJNUHUYa"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D118AEA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016132; cv=none; b=kVNqUBReyhHYxSzlOmnvunyVxp88DfmrwoZmBD+EPpzjIf2wOZsbvqalxbVSVUK1z2J9+EUtmTbLAebHNjHzX33bM7KUdgTp7jp2zcWr/KkDXoyfb5k5GolNI1CJ37Hmmw1PIJ3snzRq7GHncGCbq85zrZN3sUFK3D3+cHvLvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016132; c=relaxed/simple;
	bh=LsNP2SFjdlnJJoZbylk7xJQW6tlfVVYv7IzSXcPYXZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoVjvSKYs+fek7iTz+7rw9RW3GGfvsrOczFqbS3JfYk9oK/MosSZ2EywmMNrZnMm9/vy5/2/CslthIhEAAWKW0q83OuNsVDwSku9nY2Y+bPf8FtZxlCa8tdZi3F/uFL5GhhGQ2jREcl649wHSYBIKW+vDfgty16bC/IAVxtIMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rJNUHUYa; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b6199ef089so5545666d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1722016129; x=1722620929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=da6akh8WgUAwxLGmzRI7X6vZ0MUewp6RMFPFkDcDnow=;
        b=rJNUHUYaJJBCdmiI0D0tdmCxIFZCO6iSnYEfKVkXs6fmiySkPrwpT3n1tA9ikTjtL5
         EtR07RX9h4Wtot2PHsevxSgw2pE4jJSz8yrVaaznOQWHRyiDa0KzV8shnLqPxzyhDuGx
         V1Kvok5NpuKOjyXlCP81TAzlByaHhBzMZQa7eJMJvpB/6Mui9WUPWvTZN82kCQ9JQhqX
         UGgL0BcaW9inC9brlvUsAat2IWlsR8qX4pYdaJD1mNMnfBDhdTTMfUWgFugKDrpPBPge
         b+Qe+PHRHbANhlZ4qkC7F9waDLlvPIy2McmbkJtgqNAuOL1XSPPq7xUMKwl17CfUPZIC
         N5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016129; x=1722620929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da6akh8WgUAwxLGmzRI7X6vZ0MUewp6RMFPFkDcDnow=;
        b=hFc33P+EupAJDx4PjbIabDUL23mfQVF8d4uerajqeMIM6G3B0WbfQukDjisk0cJ9JS
         2zc/dtv7ahiolVDfGtlbXvOlzd/9hTbjTQ8Qg/SPgvifLYxEmoRm/TgbKgMsKVNvq+Xl
         qTVxk8+hcmzyWcLfUctaFknu2MHRu2rVhAS34fbfl3V2SgZWJ1/onCU6LyqGwP+7Ej9o
         CRVJn2xMGmyixiiYkUC4tQMyBUcm4oAEREgAnxkWGVhtKL1bT1Bkgs0rod2RyMZSQA+V
         BcbcbugDAojFrbKfZPLVbEtPCAdiopmfVXz1UoeHZuSS+dcvjoW7Pr2RYuzoPFvjiCgs
         ojRg==
X-Forwarded-Encrypted: i=1; AJvYcCVpwon3gscIl3GWYk7KKMxKET1XNCFrXto80joLEGTiw1GoVDWBuVI2XxF9FZFP0rvAge8XgAzRBOicurzg5HNhBcsTwQy0lF5x9ree
X-Gm-Message-State: AOJu0Yyw7pAlqpWTui5lhyG24d2+D3+TCmfrMLNxFQkqqfEM8hflfa1m
	Xa2SUi2UC0LqrezdSICGPLjvUKIGlJ+Hc1Wsgq99b/10s1BDqS76cU43tk2xdg==
X-Google-Smtp-Source: AGHT+IFfcNDT9741//3LSkOUXP5XWBykUNvYG3uMXN61dzAYodF3R9u9EGGDouuQOm0bccgd0Y35Ag==
X-Received: by 2002:a05:6214:27ef:b0:6b5:752e:a33a with SMTP id 6a1803df08f44-6bb55acfeccmr4441856d6.57.1722016129227;
        Fri, 26 Jul 2024 10:48:49 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-58.harvard-secure.wrls.harvard.edu. [65.112.8.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d82a1sm18699516d6.8.2024.07.26.10.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:48:48 -0700 (PDT)
Date: Fri, 26 Jul 2024 13:48:45 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset
 recovery time
Message-ID: <8e300b0b-91f8-4003-a1b9-0f22869ae6e1@rowland.harvard.edu>
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
 <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>
 <f1e2e2b1-b83c-4105-b62c-a053d18c2985@molgen.mpg.de>
 <3d3416cd-167f-4c50-972b-0eb376a13fdf@rowland.harvard.edu>
 <cee9630e-781e-49b1-82c5-9066552f71b1@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cee9630e-781e-49b1-82c5-9066552f71b1@molgen.mpg.de>

On Wed, Jul 24, 2024 at 11:00:42PM +0200, Paul Menzel wrote:
> Dear Alan,
> 
> 
> Am 24.07.24 um 20:52 schrieb Alan Stern:
> > On Wed, Jul 24, 2024 at 08:14:34PM +0200, Paul Menzel wrote:
> 
> […]
> 
> > > Am 24.07.24 um 16:10 schrieb Alan Stern:
> > > > On Wed, Jul 24, 2024 at 01:15:23PM +0200, Paul Menzel wrote:
> > > > > This basically reverts commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
> > > > > ("[PATCH] USB: relax usbcore reset timings") from 2005.
> > > > > 
> > > > > This adds unneeded 40 ms during resume from suspend on a majority of
> > > > 
> > > > Wrong.  It adds 40 ms to the recovery time from a port reset -- see the
> > > > commit's title.  Suspend and resume do not in general involve port
> > > > resets (although sometimes they do).
> > > 
> > > It looks like on my system the ports are reset:
> > > 
> > > ```
> > > $ grep suspend-240501-063619/hub_port_reset abreu_mem_ftrace.txt
> > >   6416.257589 |   3)  kworker-9023  |               | hub_port_reset [usbcore]() {
> > >   6416.387182 |   2)  kworker-9023  |   129593.0 us |                  } /* hub_port_reset [usbcore] */
> > 
> > > ```
> > 
> > It depends on the hardware and the kind of suspend.
> 
> It is ACPI S3 suspend. Can I find out, why the ports are reset? Not
> resetting the ports would be even better to reduce the resume time.

It's probably an xHCI thing -- the hardware may stop providing power to 
the ports during S3 suspend, or something like that.  The xHCI people 
may have a better idea of what's going on.

> > > > > devices, where it’s not needed, like the Dell XPS 13 9360/0596KF, BIOS
> > > > > 2.21.0 06/02/2022 with
> > > > 
> > > > > The commit messages unfortunately does not list the devices needing this.
> > > > > Should they surface again, these should be added to the quirk list for
> > > > > USB_QUIRK_HUB_SLOW_RESET.
> > > > 
> > > > This quirk applies to hubs that need extra time when one of their ports
> > > > gets reset.  However, it seems likely that the patch you are reverting
> > > > was meant to help the device attached to the port, not the hub itself.
> > > > Which would mean that the adding hubs to the quirk list won't help
> > > > unless every hub is added -- in which case there's no point reverting
> > > > the patch.
> > > > 
> > > > Furthermore, should any of these bad hubs or devices still be in use,
> > > > your change would cause them to stop working reliably.  It would be a
> > > > regression.
> > > > 
> > > > A better approach would be to add a sysfs boolean attribute to the hub
> > > > driver to enable the 40-ms reset-recovery delay, and make it default to
> > > > True.  Then people who don't need the delay could disable it from
> > > > userspace, say by a udev rule.
> > > 
> > > How would you name it?
> > 
> > You could call it "long_reset_recovery".  Anything like that would be
> > okay.
> 
> Would it be useful to makes it an integer instead of a boolean, and allow to
> configure the delay: `extra_reset_recovery_delay_ms`?

Sure, why not?  Just so long as the default value matches the current 
behavior.

Alan Stern

